From: Trent Piepho <tpiepho@gmail.com>
Subject: Bug in alsa-lib causes high CPU with rate plugin
Date: Thu, 8 Nov 2012 13:47:52 -0800
Message-ID: <CA+7tXii+Oc8utgBA=mqa3BA+9BYUv0cqd3pC=DQcAKrDTkyXxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d04339cde8307b104ce02c939
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 by alsa0.perex.cz (Postfix) with ESMTP id DBD002615F2
 for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2012 22:47:53 +0100 (CET)
Received: by mail-vb0-f51.google.com with SMTP id fn1so3064032vbb.38
 for <alsa-devel@alsa-project.org>; Thu, 08 Nov 2012 13:47:53 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--f46d04339cde8307b104ce02c939
Content-Type: text/plain; charset=ISO-8859-1

There is a bug in the way alsa-lib sleeps when using a plugin that can
cause very high CPU usage for PCM playback with using rate conversion.

I've attached a simple test program.  It simply uses blocking mode and
calls snd_pcm_writei() with a buffer of zeros one thousand times and
then exits.  One would think the CPU usage would be very low.  And
indeed when the write sized passed to snd_pcm_writei is equal to the
period size it is quite low (i5 with HDA):

lucid@Dashboard:~$ /usr/bin/time ./a.out > /dev/null
period size 352, write size 352
done, wrote 1000 buffers of 352 frames
0.10user 0.15system 0:09.01elapsed 2%CPU (0avgtext+0avgdata 9360maxresident)k

But, with one small change to have snd_pcm_writei() write buffers one
frame larger than the period size, one gets this:

period size 352, write size 353
done, wrote 1000 buffers of 353 frames
1.92user 2.00system 0:09.04elapsed 43%CPU (0avgtext+0avgdata 9360maxresident)k

Simply increasing the write size by one caused the CPU usage to jump
to 43% from 2%!  Because more software writes in chunks equal to the
period size it doesn't see this problem.  That's why it wasn't found
and fixed long ago.

I've figured out why this is happening.  The problem is caused by how
alsa-lib decides to sleep when waiting for available buffer space and
the way the rate plugin can only process complete periods at a time.

Suppose we have the rate plugin with hw as its slave.  Both have a
ring buffer that is 3+ periods in size.  Allowing for the rate
conversion, the buffers and periods are the same size for both.
avail_min is set to the normal value of one period for both.

Suppose there are two empty periods in the buffer and we call
snd_pcm_writei() to write 1.5 periods.  That fits in the empty space
in the rate plugin's buffer and so gets written immediately.  The rate
plugin's buffer now has 0.5 empty periods of space.  The rate plugin
will resample just one period of the newly written data, because it
can only process complete periods at a time, and write that to the hw
buffer.  So the hw buffer now has one free period.  This means the
rate plugin has less free space in its buffer than the hw has, because
the rate plugin has half a period of data it can't yet resample and
pass to the slave.

Now we write another one period of data with another snd_pcm_writei()
call.  This gets to snd_pcm_write_areas() in pcm.c and triggers this
code (edited for brevity):

                if ((state == SND_PCM_STATE_RUNNING &&
                     (snd_pcm_uframes_t)avail < pcm->avail_min &&
                     size > (snd_pcm_uframes_t)avail)) {
                        err = snd_pcm_wait(pcm, -1);
                        goto _again;
                }

avail is the available space in the rate plugin's buffer, which is
half a period.  pcm->avail_min is also for the rate plugin.  size is
the amount remaining in the writei() call, which is one period in this
example.

As we can see, the conditions of the if() statement are true.  avail
of 0.5 periods is less than avail_min of 1 period and the size of the
write (1 period) is greater than avail.  So we call snd_pcm_wait() and
then go back to the top when it returns.  avail will get updated to
the current value and this code runs again.

Eventually snd_pcm_wait() will call poll() and try to sleep in the
kernel while waiting for more room to be available.  But remember the
hw buffer had one full period free!  That's more than tghe half period
that's free in the rate buffer and, and this is the key here, it is
*more than avail_min*.  So poll() will not sleep at all!  That's where
the 43% CPU comes from.  alsa-lib is in a tight loop inside
snd_pcm_write_areas() calling snd_pcm_wait() over and over again.

snd_pcm_wait() doesn't sleep, because it's based on the status of the
hw buffer and that buffer does have free space.  snd_pcm_write_areas()
would write to the hw buffer and not try to sleep.  But it's not
looking at the hw buffer when it decides to sleep or write, it's
looking at the rate buffer.  And the rate buffer's fill level says to
sleep, not write.  And if snd_pcm_wait() was looking at the rate
buffer, it would sleep.

We have the rate buffer that's current fill level says, "sleep first,
then write" and the HW buffer that says the opposite, "write first,
then sleep".  The code that writes looks at the former and decides to
sleep but the code that sleeps looks at the latter and decides it's
not time sleep.

A trivial patch that stops this behavior is below, which simply forces
the rate plugin's avail_min to 1.

diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 41089d7..86f57c4 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -1142,6 +1142,7 @@ static int snd_pcm_rate_start(snd_pcm_t *pcm)
                return 0;
        }
        rate->start_pending = 0;
+       pcm->avail_min = 1;
        return snd_pcm_start(rate->gen.slave);
 }

I think it would be better to have the rate plugin decrease avail_min
by how much unresampled data it has yet to pass to the slave.  This
preserves the idea of avail_min if it were set to more than one
period.  This also fixes the problem.  I've attached a real patch to
do that.

For the test program to show the problem YOU MUST USE THE RATE CONVERT
PLUGIN!  It seems obvious but people keep missing this.  I found the
easiest way to do that was to create a custom device in ~/.asoundrc
that forced rate converting to 48kHz.  Like this:
pcm.foo {
    type plug;
    slave {
        pcm "hw:0,0";
        rate 48000;
    }
}

--f46d04339cde8307b104ce02c939
Content-Type: text/x-csrc; charset=US-ASCII; name="alsatest.c"
Content-Disposition: attachment; filename="alsatest.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h9ae5ona0

LyogQ29weXJpZ2h0IChDKSAyMDEzIERlbHBoaSBUZWNobm9sb2dpZXMsIEluYy4KICAgV3JpdHRl
biBieSBUcmVudCBQaWVwaG8gPHRwaWVwaG9AZ21haWwuY29tPgoqLwojaW5jbHVkZSA8c3RkaW8u
aD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxlcnJu
by5oPgojaW5jbHVkZSA8YWxzYS9hc291bmRsaWIuaD4KI2luY2x1ZGUgPHN5cy90aW1lLmg+CiNp
bmNsdWRlIDxzdGRpbnQuaD4KCiNkZWZpbmUgQ09VTlQgMTAwMAkvLyBOdW1iZXIgb2YgcGVyaW9k
cyB0byB3cml0ZSBiZWZvcmUgZXhpdGluZwojZGVmaW5lIFdSSVRFX0RFTFRBIDEJLy8gd3JpdGUg
cGVyaW9kIHNpemUgcGx1cyB0aGlzCiNkZWZpbmUgUkFURSA0NDEwMAojZGVmaW5lIFBFUklPRF9T
SVpFIDM1MgojZGVmaW5lIFBFUklPRFMgMwoKLy8gI2RlZmluZSBkYmcoYXJncy4uLikJZnByaW50
ZihzdGRlcnIsIGFyZ3MpCiNkZWZpbmUgZGJnKGFyZ3MuLi4pCWRvIHt9IHdoaWxlKDApCgpzdGF0
aWMgY2hhciAqZGV2aWNlID0gImZvbyI7CnN0YXRpYyBzbmRfb3V0cHV0X3QgKm91dHB1dDsKCmlu
dCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsKCXNuZF9wY21fdCAqaGFuZGxlOwoJc25k
X3BjbV9od19wYXJhbXNfdCAqaHdwYXJhbXM7CglzbmRfcGNtX3N3X3BhcmFtc190ICpzd3BhcmFt
czsKCWludCBlcnI7Cgl1aW50MTZfdCAqYnVmOwoJdW5zaWduZWQgaW50IGk7CglzbmRfcGNtX3Nm
cmFtZXNfdCBjb3VudDsKCXNuZF9wY21fdWZyYW1lc190IHBlcmlvZHNpemUsIHdyaXRlc2l6ZTsK
CglzbmRfb3V0cHV0X3N0ZGlvX2F0dGFjaCgmb3V0cHV0LCBzdGRvdXQsIDApOwoJaWYgKGFyZ2Mg
PiAxKSB7CgkJZGV2aWNlID0gYXJndlsxXTsKCQlwcmludGYoIldpbGwgdXNlIGRldmljZSAnJXMn
XG4iLCBkZXZpY2UpOwoJfQoKCWVyciA9IHNuZF9wY21fb3BlbigmaGFuZGxlLCBkZXZpY2UsIFNO
RF9QQ01fU1RSRUFNX1BMQVlCQUNLLCAwKTsKCWlmIChlcnIgPCAwKSB7CgkJcHJpbnRmKCJQbGF5
YmFjayBvcGVuZSBlcnJvcjogJXNcbiIsIHNuZF9zdHJlcnJvcihlcnIpKTsKCQlyZXR1cm4gLTE7
Cgl9CglkYmcoIlBDTSBvcGVuZWQsIGdvaW5nIHRvIHNldCBwYXJhbXNcbiIpOwoKCXNuZF9wY21f
aHdfcGFyYW1zX21hbGxvYygmaHdwYXJhbXMpOwoJc25kX3BjbV9od19wYXJhbXNfYW55KGhhbmRs
ZSwgaHdwYXJhbXMpOwoJc25kX3BjbV9od19wYXJhbXNfc2V0X2FjY2VzcyhoYW5kbGUsIGh3cGFy
YW1zLCBTTkRfUENNX0FDQ0VTU19SV19JTlRFUkxFQVZFRCk7CglzbmRfcGNtX2h3X3BhcmFtc19z
ZXRfY2hhbm5lbHMoaGFuZGxlLCBod3BhcmFtcywgMSk7CglzbmRfcGNtX2h3X3BhcmFtc19zZXRf
Zm9ybWF0KGhhbmRsZSwgaHdwYXJhbXMsIFNORF9QQ01fRk9STUFUX1MxNl9MRSk7CgllcnIgPSBz
bmRfcGNtX2h3X3BhcmFtc19zZXRfcmF0ZShoYW5kbGUsIGh3cGFyYW1zLCBSQVRFLCAwKTsKCWRi
ZygicmF0ZSBzZXQgJXNcbiIsIGVyciA8IDAgPyAiZmFpbCIgOiAic3VjY2VzcyIpOwoJcGVyaW9k
c2l6ZSA9IFBFUklPRF9TSVpFOwoJZXJyID0gc25kX3BjbV9od19wYXJhbXNfc2V0X3BlcmlvZF9z
aXplX25lYXIoaGFuZGxlLCBod3BhcmFtcywgJnBlcmlvZHNpemUsIE5VTEwpOwoJZGJnKCJwZXJp
b2Qgc2l6ZSBzZXQgJXMsIGdvdCAlbHVcbiIsIGVyciA8IDAgPyAiZmFpbCIgOiAic3VjY2VzcyIs
IHBlcmlvZHNpemUpOwoJZXJyID0gc25kX3BjbV9od19wYXJhbXNfc2V0X2J1ZmZlcl9zaXplKGhh
bmRsZSwgaHdwYXJhbXMsIHBlcmlvZHNpemUgKiBQRVJJT0RTKTsKCWRiZygiYnVmZmVyIHNpemUg
c2V0ICVzXG4iLCBlcnIgPCAwID8gImZhaWwiIDogInN1Y2Nlc3MiKTsKCWVyciA9IHNuZF9wY21f
aHdfcGFyYW1zX3NldF9wZXJpb2RzKGhhbmRsZSwgaHdwYXJhbXMsIFBFUklPRFMsIDApOwoJZGJn
KCJwZXJpb2RzIHNldCAlc1xuIiwgZXJyIDwgMCA/ICJmYWlsIiA6ICJzdWNjZXNzIik7CgkKCWVy
ciA9IHNuZF9wY21faHdfcGFyYW1zKGhhbmRsZSwgaHdwYXJhbXMpOwoJaWYgKGVyciA8IDApIHsK
CQlwcmludGYoInVuYWJsZSB0byBzZXQgaHcgcGFyYW1zIGZvciBwbGF5YmFjazogJXNcbiIsIHNu
ZF9zdHJlcnJvcihlcnIpKTsKCQlyZXR1cm4gLTE7Cgl9CgoJc25kX3BjbV9zd19wYXJhbXNfbWFs
bG9jKCZzd3BhcmFtcyk7CglzbmRfcGNtX3N3X3BhcmFtc19jdXJyZW50KGhhbmRsZSwgc3dwYXJh
bXMpOwoJc25kX3BjbV9zd19wYXJhbXMoaGFuZGxlLCBzd3BhcmFtcyk7CgkKCXNuZF9wY21fZHVt
cChoYW5kbGUsIG91dHB1dCk7CgoJd3JpdGVzaXplID0gcGVyaW9kc2l6ZSArIFdSSVRFX0RFTFRB
OwoJYnVmID0gbWFsbG9jKHdyaXRlc2l6ZSAqIHNpemVvZigqYnVmKSk7Cglmb3IoaT0wO2k8d3Jp
dGVzaXplO2krKykgYnVmW2ldID0gaTsKCglmcHJpbnRmKHN0ZGVyciwgInBlcmlvZCBzaXplICVs
dSwgd3JpdGUgc2l6ZSAlbHVcbiIsIHBlcmlvZHNpemUsIHdyaXRlc2l6ZSk7CglzbGVlcCgxKTsK
CWVyciA9IHNuZF9wY21fcHJlcGFyZShoYW5kbGUpOwoJaWYgKGVyciA8IDApIHsKCQlwcmludGYo
IkVycm9yIGluIHByZXBhcmU6ICVzXG4iLCBzbmRfc3RyZXJyb3IoZXJyKSk7CgkJcmV0dXJuIC0x
OwoJfQoJcHJpbnRmKCJQcmVwYXJlZCwgc3RhcnRpbmcgdG8gd3JpdGVcbiIpOwoKCWZvciAoaT0w
O2k8Q09VTlQ7aSsrKSB7CgkJY291bnQgPSBzbmRfcGNtX3dyaXRlaShoYW5kbGUsIGJ1Ziwgd3Jp
dGVzaXplKTsKCQlpZiAoY291bnQgPCAwKSB7Ci8vCQkJcHJpbnRmKCJFcnJvciB3cml0aW5nIGZy
YW1lczogJXNcbiIsIHNuZF9zdHJlcnJvcihjb3VudCkpOwoJCQlzbmRfcGNtX3JlY292ZXIoaGFu
ZGxlLCBjb3VudCwgMCk7CgkJfQoJCXByaW50ZigiV3JpdGUgJWxkIGZyYW1lc1xuIiwgY291bnQp
O2ZmbHVzaChzdGRvdXQpOwoJfQoJcHJpbnRmKCJkb25lIHdyaXRpbmcsIGRyYWluaW5nLi4uXG4i
KTsKCXNuZF9wY21fZHJhaW4oaGFuZGxlKTsKCWZwcmludGYoc3RkZXJyLCAiRG9uZSwgd3JvdGUg
JWQgYnVmZmVycyBvZiAlbHUgZnJhbWVzXG4iLCBpLCB3cml0ZXNpemUpOwoKCWV4aXQoMCk7Cn0K
--f46d04339cde8307b104ce02c939
Content-Type: application/octet-stream;
	name="0001-Fix-sleeping-problem-with-rate-plugin.patch"
Content-Disposition: attachment;
	filename="0001-Fix-sleeping-problem-with-rate-plugin.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h9ae620o1

RnJvbSAxYzU1ZmY5YmFhNGZlNTcxNWM5MWEwMjk1N2QyOGQxZmQ5MzlkYmE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUcmVudCBQaWVwaG8gPHRwaWVwaG9AZ21haWwuY29tPgpEYXRl
OiBUaHUsIDggTm92IDIwMTIgMTM6MTA6MzUgLTA4MDAKU3ViamVjdDogW1BBVENIXSBGaXggc2xl
ZXBpbmcgcHJvYmxlbSB3aXRoIHJhdGUgcGx1Z2luCgpUaGUgcmF0ZSBwbHVnaW4gY2FuIG9ubHkg
cHJvY2VzcyBjb21wbGV0ZSBwZXJpb2RzIG9mIGRhdGEuICBCZWNhdXNlIG9mCnRoaXMgc29tZXRp
bWVzIHRoZSByYXRlIHBsdWdpbidzIGJ1ZmZlciBoYXMgZnJhbWVzIGluIGl0IHRoYXQgaGF2ZSBu
b3QKeWV0IGJlZW4gc2VudCB0byBpdHMgc2xhdmUuICBUaGlzIG1lYW5zIHRoZSByYXRlIHBsdWdp
bidzIGJ1ZmZlciBoYXMKbGVzcyBhdmFpbGFibGUgc3BhY2UgdGhhbiB0aGUgc2xhdmUncyBidWZm
ZXIuCgpXaGVuIG1vcmUgZGF0YSBpcyB3cml0dGVuLCB0aGUgcmF0ZSBwbHVnaW4ncyBidWZmZXIg
d2lsbCBoYXZlIGxlc3MKdGhhbiBhdmFpbF9taW4gc3BhY2UgYW5kIHNvIGFsc2EtbGliIHdpbGwg
dHJ5IHRvIHdhaXQgZm9yIG1vcmUgc3BhY2UKdG8gYmVjb21lIGF2YWlsYWJsZS4gIFRoaXMgaW4g
dHVybiBiZWNvbWVzIGEgd2FpdCBvbiB0aGUgc2xhdmUncwpidWZmZXIuICBCdXQgdGhlIHNsYXZl
J3MgYnVmZmVyIGhhcyBtb3JlIHNwYWNlIGF2YWlsYWJsZSEgIFNvIGl0CmRvZXNuJ3Qgc2xlZXAg
YW5kIHRoZSB3YWl0IHJldHVybnMgaW1tZWRpYXRseS4KCkFMU0EgZ2V0cyBzdHVjayBpbiBhIHRp
Z2h0IGxvb3Agd2l0aCB0aGUgd3JpdGluZyBjb2RlIGRlY2lkZWQgdGhhdCB0aGUKcmF0ZSBwbHVn
aW4ncyBidWZmZXIgaXMgdG9vIGZ1bGwgYW5kIHRyeWluZyB0byBzbGVlcCwgYW5kIHRoZSBzbGVl
cGluZwpjb2RlIGRlY2lkaW5nIHRoYXQgdGhlIHNsYXZlJ3MgYnVmZmVyIGlzIGVtcHR5IGVub3Vn
aCBhbmQgbm90CnNsZWVwaW5nLgoKV2UgZ2V0IGFyb3VuZCB0aGlzIGJ5IHR3ZWVraW5nIGF2YWls
X21pbiB0byBkZWNyZWFzZSBpdCBieSB0aGUKdW5wcm9jZXNzZWQgZGF0YS4gIFdoZW4gZGVjaWRp
bmcgdG8gc2xlZXAsIHRoaXMgaGFzIHRoZSBzYW1lIGVmZmVjdCBhcwppbmNyZWFzaW5nIHRoZSBh
dmFpbGFibGUgc3BhY2UgYnkgdGhlIHVucHJvY2Vzc2VkIGRhdGEuICBJbiBlZmZlY3QsIHdlCnR1
cm4gYXZhaWwocmF0ZSkgaW50byBhdmFpbChyYXRlLT5zbGF2ZSkuICBDYW4gbWFrZSBvdXIgc2xl
ZXAgZGVjaXNpb24KYmFzZWQgb24gdGhlIHNsYXZlJ3MgYnVmZmVyLCBpbnN0ZWFkIG9mIG9uIHRo
ZSByYXRlIGJ1ZmZlci4KClRoZXJlIHdhcyBhbiB1bnVzZWQgZmllbGQsIG9yaWdfYXZhaWxfbWlu
LCBpbiB0aGUgcmF0ZSBzdHJ1Y3QuICBUaGlzCmNoYW5nZXMgaXQgdG8gYmUgdGhlIHJhdGUncyBv
cmlnaW5hbCBhdmFpX21pbiByYXRoZXIgdGhhbiB0aGUgc2xhdmUncwpvcmlnaW5hbCBhdmFpbF9t
aW4uCgpTaWduZWQtb2ZmLWJ5OiBUcmVudCBQaWVwaG8gPHRwaWVwaG9AZ21haWwuY29tPgotLS0K
IHNyYy9wY20vcGNtX3JhdGUuYyB8ICAgIDYgKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3BjbS9wY21fcmF0ZS5j
IGIvc3JjL3BjbS9wY21fcmF0ZS5jCmluZGV4IDRiYTg1MjEuLjQxMDg5ZDcgMTAwNjQ0Ci0tLSBh
L3NyYy9wY20vcGNtX3JhdGUuYworKysgYi9zcmMvcGNtL3BjbV9yYXRlLmMKQEAgLTM5NSw4ICsz
OTUsOCBAQCBzdGF0aWMgaW50IHNuZF9wY21fcmF0ZV9zd19wYXJhbXMoc25kX3BjbV90ICpwY20s
IHNuZF9wY21fc3dfcGFyYW1zX3QgKiBwYXJhbXMpCiAJaWYgKHJhdGUtPm9wcy5hZGp1c3RfcGl0
Y2gpCiAJCXJhdGUtPm9wcy5hZGp1c3RfcGl0Y2gocmF0ZS0+b2JqLCAmcmF0ZS0+aW5mbyk7CiAK
LQlyZWNhbGMocGNtLCAmc3BhcmFtcy0+YXZhaWxfbWluKTsKIAlyYXRlLT5vcmlnX2F2YWlsX21p
biA9IHNwYXJhbXMtPmF2YWlsX21pbjsKKwlyZWNhbGMocGNtLCAmc3BhcmFtcy0+YXZhaWxfbWlu
KTsKIAlyZWNhbGMocGNtLCAmc3BhcmFtcy0+c3RhcnRfdGhyZXNob2xkKTsKIAlpZiAoc3BhcmFt
cy0+YXZhaWxfbWluIDwgMSkgc3BhcmFtcy0+YXZhaWxfbWluID0gMTsKIAlpZiAoc3BhcmFtcy0+
c3RhcnRfdGhyZXNob2xkIDw9IHNsYXZlLT5idWZmZXJfc2l6ZSkgewpAQCAtOTY5LDYgKzk2OSwx
MCBAQCBzdGF0aWMgaW50IHNuZF9wY21fcmF0ZV9zeW5jX3BsYXliYWNrX2FyZWEoc25kX3BjbV90
ICpwY20sIHNuZF9wY21fdWZyYW1lc190IGFwcAogCQlpZiAocmF0ZS0+bGFzdF9jb21taXRfcHRy
ID49IHBjbS0+Ym91bmRhcnkpCiAJCQlyYXRlLT5sYXN0X2NvbW1pdF9wdHIgPSAwOwogCX0KKwkv
KiBUd2VlayBhdmFpbF9taW4gdG8gdGFrZSBpbnRvIGFjY291bnQgdGhlIGRhdGEgbm90IHlldCBz
ZW50IHRvIHRoZQorCSAqIHNsYXZlIHBjbS4gICovCisJcGNtLT5hdmFpbF9taW4gPSByYXRlLT5v
cmlnX2F2YWlsX21pbiA+PSB4ZmVyID8gCisJICAgICAgICAgICAgICAgICByYXRlLT5vcmlnX2F2
YWlsX21pbiAtIHhmZXIgOiAxOwogCXJldHVybiAwOwogfQogCi0tIAoxLjcuOS41Cgo=
--f46d04339cde8307b104ce02c939
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--f46d04339cde8307b104ce02c939--
