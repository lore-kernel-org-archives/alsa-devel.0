From: Ryan Pavlik <rpav@mephle.com>
Subject: Re: poll() and select()
Date: Tue, 14 Oct 2003 11:30:31 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031014113031.7fde9794.rpav@mephle.com>
References: <20031013105324.637917b0.rpav@mephle.com>
	<s5h4qycup1q.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__14_Oct_2003_11_30_31_-0700_waI.eIxtADD_UGSV"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qycup1q.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Tue__14_Oct_2003_11_30_31_-0700_waI.eIxtADD_UGSV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2003 11:49:37 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 13 Oct 2003 10:53:24 -0700,
> Ryan Pavlik wrote:
> > 
> > Hey, I'm currently pondering an ALSA interface for Ruby
> > (http://ruby-lang.org).  Unfortunately, to do what I want, I need to
> > be able to have a file descriptor for select().  I've tried using the
> > fds returned by snd_seq_poll_descriptors(), but (not suprisingly) they
> > didn't work: select blocks indefinitely.
> 
> if i understand correctly, it should work.  fd field in the returned
> pollfd struct is the file descriptor for select().

This is what I had hoped.  However, it doesn't seem to work correctly,
and I'm thinking it's because the file descriptor isn't actually for
reading and writing, but some other form of communication I'm not
familiar with.

I'm using the "seqdemo.c" example from the HOWTO as a testbase.
The main bit of code looks like this:

    while (1) {
        FD_ZERO(&rfds);
        FD_SET(pfd[0].fd, &rfds);

        if (select(npfd, &rfds, NULL, NULL, NULL)) {
            midi_action(seq_handle);
        }  
    }

Basically, a replacement of the old while() loop with a bridge from
the poll() structs to select().  I've used select() before with no
problems, but this simply hangs indefinitely, while the poll() version
works as advertised.

>From the select manpage:

       Three independent sets of descriptors are  watched.   Those  listed  in
       readfds will be watched to see if characters become available for read-
       ing (more precisely, to see if a read will not block - in particular, a
       file  descriptor  is also ready on end-of-file), [...]

I'm thinking it may not be the case that /proc/snd/dev/seq may not be
something that you read() from, but I'm not sure.  I've attached my
version of seqdemo, perhaps I'm doing something wrong.

thanks,

-- 
Ryan Pavlik <rpav@mephle.com>

"I'll *prove* to you that sword-chucks are the
 single greatest advancement in all weaponology." - 8BT

--Multipart=_Tue__14_Oct_2003_11_30_31_-0700_waI.eIxtADD_UGSV
Content-Type: application/octet-stream;
 name="seqdemo.c"
Content-Disposition: attachment;
 filename="seqdemo.c"
Content-Transfer-Encoding: base64

Lyogc2VxZGVtby5jIGJ5IE1hdHRoaWFzIE5hZ29ybmkgKi8KCiNpbmNsdWRlIDxzdGRpby5oPgoj
aW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHN5cy9zZWxl
Y3QuaD4KI2luY2x1ZGUgPGFsc2EvYXNvdW5kbGliLmg+CgpzbmRfc2VxX3QgKm9wZW5fc2VxKCk7
CnZvaWQgbWlkaV9hY3Rpb24oc25kX3NlcV90ICpzZXFfaGFuZGxlKTsKCnNuZF9zZXFfdCAqb3Bl
bl9zZXEoKSB7CgogICAgc25kX3NlcV90ICpzZXFfaGFuZGxlOwogICAgaW50IHBvcnRpZDsKCiAg
ICBpZiAoc25kX3NlcV9vcGVuKCZzZXFfaGFuZGxlLCAiZGVmYXVsdCIsIFNORF9TRVFfT1BFTl9J
TlBVVCwgMCkgPCAwKSB7CiAgICAgICAgZnByaW50ZihzdGRlcnIsICJFcnJvciBvcGVuaW5nIEFM
U0Egc2VxdWVuY2VyLlxuIik7CiAgICAgICAgZXhpdCgxKTsKICAgIH0KICAgIHNuZF9zZXFfc2V0
X2NsaWVudF9uYW1lKHNlcV9oYW5kbGUsICJBTFNBIFNlcXVlbmNlciBEZW1vIik7CiAgICBpZiAo
KHBvcnRpZCA9IHNuZF9zZXFfY3JlYXRlX3NpbXBsZV9wb3J0KHNlcV9oYW5kbGUsICJBTFNBIFNl
cXVlbmNlciBEZW1vIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgU05EX1NFUV9QT1JUX0NBUF9XUklURXxTTkRfU0VRX1BPUlRfQ0FQX1NVQlNfV1JJVEUsCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNORF9TRVFfUE9SVF9U
WVBFX0FQUExJQ0FUSU9OKSkgPCAwKSB7CiAgICAgICAgZnByaW50ZihzdGRlcnIsICJFcnJvciBj
cmVhdGluZyBzZXF1ZW5jZXIgcG9ydC5cbiIpOwogICAgICAgIGV4aXQoMSk7CiAgICB9CiAgICBy
ZXR1cm4oc2VxX2hhbmRsZSk7Cn0KCnZvaWQgbWlkaV9hY3Rpb24oc25kX3NlcV90ICpzZXFfaGFu
ZGxlKSB7CgogICAgc25kX3NlcV9ldmVudF90ICpldjsKCiAgICBkbyB7CiAgICAgICAgc25kX3Nl
cV9ldmVudF9pbnB1dChzZXFfaGFuZGxlLCAmZXYpOwogICAgICAgIHN3aXRjaCAoZXYtPnR5cGUp
IHsKICAgICAgICAgICAgY2FzZSBTTkRfU0VRX0VWRU5UX0NPTlRST0xMRVI6IAogICAgICAgICAg
ICAgICAgZnByaW50ZihzdGRlcnIsICJDb250cm9sIGV2ZW50IG9uIENoYW5uZWwgJTJkOiAlNWQg
ICAgICAgXHIiLAogICAgICAgICAgICAgICAgICAgICAgICBldi0+ZGF0YS5jb250cm9sLmNoYW5u
ZWwsIGV2LT5kYXRhLmNvbnRyb2wudmFsdWUpOwogICAgICAgICAgICAgICAgYnJlYWs7CiAgICAg
ICAgICAgIGNhc2UgU05EX1NFUV9FVkVOVF9QSVRDSEJFTkQ6CiAgICAgICAgICAgICAgICBmcHJp
bnRmKHN0ZGVyciwgIlBpdGNoYmVuZGVyIGV2ZW50IG9uIENoYW5uZWwgJTJkOiAlNWQgICBcciIs
IAogICAgICAgICAgICAgICAgICAgICAgICBldi0+ZGF0YS5jb250cm9sLmNoYW5uZWwsIGV2LT5k
YXRhLmNvbnRyb2wudmFsdWUpOwogICAgICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgICAgIGNh
c2UgU05EX1NFUV9FVkVOVF9OT1RFT046CiAgICAgICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwg
Ik5vdGUgT24gZXZlbnQgb24gQ2hhbm5lbCAlMmQ6ICU1ZCAgICAgICBcciIsCiAgICAgICAgICAg
ICAgICAgICAgICAgIGV2LT5kYXRhLmNvbnRyb2wuY2hhbm5lbCwgZXYtPmRhdGEubm90ZS5ub3Rl
KTsKICAgICAgICAgICAgICAgIGJyZWFrOyAgICAgICAgCiAgICAgICAgICAgIGNhc2UgU05EX1NF
UV9FVkVOVF9OT1RFT0ZGOiAKICAgICAgICAgICAgICAgIGZwcmludGYoc3RkZXJyLCAiTm90ZSBP
ZmYgZXZlbnQgb24gQ2hhbm5lbCAlMmQ6ICU1ZCAgICAgIFxyIiwgICAgICAgICAKICAgICAgICAg
ICAgICAgICAgICAgICAgZXYtPmRhdGEuY29udHJvbC5jaGFubmVsLCBldi0+ZGF0YS5ub3RlLm5v
dGUpOyAgICAgICAgICAgCiAgICAgICAgICAgICAgICBicmVhazsgICAgICAgIAogICAgICAgIH0K
ICAgICAgICBzbmRfc2VxX2ZyZWVfZXZlbnQoZXYpOwogICAgfSB3aGlsZSAoc25kX3NlcV9ldmVu
dF9pbnB1dF9wZW5kaW5nKHNlcV9oYW5kbGUsIDApID4gMCk7Cn0KCmludCBtYWluKGludCBhcmdj
LCBjaGFyICphcmd2W10pIHsKCiAgICBzbmRfc2VxX3QgKnNlcV9oYW5kbGU7CiAgICBpbnQgbnBm
ZDsKICAgIHN0cnVjdCBwb2xsZmQgKnBmZDsKICAKICAgIGZkX3NldCByZmRzOwogICAgCiAgICBz
ZXFfaGFuZGxlID0gb3Blbl9zZXEoKTsKCiAgICBucGZkID0gc25kX3NlcV9wb2xsX2Rlc2NyaXB0
b3JzX2NvdW50KHNlcV9oYW5kbGUsIFBPTExJTik7CiAgICBwZmQgPSAoc3RydWN0IHBvbGxmZCAq
KWFsbG9jYShucGZkICogc2l6ZW9mKHN0cnVjdCBwb2xsZmQpKTsKICAgIHNuZF9zZXFfcG9sbF9k
ZXNjcmlwdG9ycyhzZXFfaGFuZGxlLCBwZmQsIG5wZmQsIFBPTExJTik7CgogICAgd2hpbGUgKDEp
IHsKICAgICAgICBGRF9aRVJPKCZyZmRzKTsKICAgICAgICBGRF9TRVQocGZkWzBdLmZkLCAmcmZk
cyk7CgogICAgICAgIGlmIChzZWxlY3QobnBmZCwgJnJmZHMsIE5VTEwsIE5VTEwsIE5VTEwpKSB7
CiAgICAgICAgICAgIG1pZGlfYWN0aW9uKHNlcV9oYW5kbGUpOwogICAgICAgIH0gIAogICAgfQp9
Cg==

--Multipart=_Tue__14_Oct_2003_11_30_31_-0700_waI.eIxtADD_UGSV--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
