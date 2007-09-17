From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
 initial load
Date: Mon, 17 Sep 2007 14:04:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>
References: <46E58D01.9080809@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="289736052-1503498660-1190063061=:27377"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.sea5.speakeasy.net (mail3.sea5.speakeasy.net
	[69.17.117.5]) by alsa0.perex.cz (Postfix) with ESMTP id E1AEB243B9
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 23:04:23 +0200 (CEST)
In-Reply-To: <46E58D01.9080809@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--289736052-1503498660-1190063061=:27377
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 10 Sep 2007, Rene Herman wrote:
> When the ad1848/cs2431 is first being initialized, auto-calibration may not
> be set causing a timeout waiting for it in snd_ad1848/cs4231_mce_down().
>
> This has no dire consequences other than an alarming printk, but since what
> we need to wait for is for the calibration to _finish_, let's just check for
> that instead.
>
> The early chips need a slight delay (as commented -- 5 sample periods) to be
> sure that _if_ calibration is going to happen, it has started when we check
> While the CS4231A datasheet implies it'll happen immediately on downing MCE,
> some testing is showing that there's a window there as well, so just do the
> delay everywhere.

I don't think this code is doing what you think it does.

First, you call msleep(1) while holding reg_lock with interrupts disabled.
That's sleeping while atomic.  You should drop the lock first, or use
mdelay().

Second, schedule_timeout() returns immediately unless you have set the task
state to TASK_UNINTERRUPTIBLE or TASK_INTERRUPTIBLE.  I don't see anywhere
where this is done, so the 250ms delay is in fact a busy loop.  The call to
schedule_timeout() appears to be quite pointless.

This would explain what is happening when Krzysztof said, "The waiting loop
was passed 340 times after mce was down with msleep(1)." 340 loops at 250 ms
per loop is 85 seconds.  That would mean a call to hw_params() takes 85
seconds, and open(), with three mce_downs, would take over four minutes!

I looked at the ad1848 datasheet, and it says the auto-calibration should take
about 384 samples (or ~128, which I think is the time it takes ACI to go low
when auto-calibration is not on).  That would be 70 ms at the high end and
typically more like 3 ms.  A 250 ms polling interval seems to be quite long.
That would be at least 3/4 second for open(), and 1/4 second for hw_params().
With OSS emulation calling hw_params() many times, all the extra delay would
be easily noticeable.  Of course you do not notice it now because you are not
waiting 250 ms, but busy looping.

The wait for the init bit to be off after the check for ACI seems unneeded
too.  snd_ad1848_in(), called while waiting for ACI to go low, does the exact
same thing when it calls snd_ad1848_wait().  So the INIT bit is already off at
this point.

Here is a patch to fix all these problems and simplify the code in the
process.  I picked a value of 3 ms for the polling interval.  Obviously, there
is a trade-off in selecting the value.  The smaller the delay, the less wasted
time from when ACI goes low to when it is detected.  But it also means more
iterations of the loop, and thus more scheduling and interrupt disabling.

I think a good way to pick a value, is to try select the smallest value such
that 90% of the time the loop will finish on the first check.  It seems like 3
or maybe 4 would do that.

If you're not concerned much about efficiency, and just want to detect ACI low
as soon as possible, you'd use 1 ms.  Or if you want to get more complicated,
delay 3 ms on the first iteration, and 1 ms thereafter.  Or to be even smarter
than that, have a lookup table from the sample rate setting to the delay
value, so that the delay can be larger for slower sampling rates.  But that
hardly seems worth the effort.
--289736052-1503498660-1190063061=:27377
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ad1848.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0709171404210.27377@shell4.speakeasy.net>
Content-Description: 
Content-Disposition: attachment; filename="ad1848.patch"

YWQxODQ4OiBmaXggc2NoZWR1bGUgd2hpbGUgYXRvbWljLCBzaW1wbGlmeSBN
Q0UgZG93biBjb2RlDQ0KDQ0KVGhlIGZ1bmN0aW9uIHNuZF9hZDE4NDhfbWNl
X2Rvd24oKSBjYWxsZWQgbXNsZWVwKCkgd2hpbGUgaG9sZGluZyBhIHNwaW5s
b2NrDQ0Kd2l0aCBJUlFzIGRpc2FibGVkLg0NCg0NCkEgcG9sbGluZyBsb29w
IHRvIGNoZWNrIGZvciBBQ0kgdG8gZ28gZG93biB3YXMgbW9yZSBjb252b2x1
dGVkIHRoYW4gaXQgbmVlZGVkDQ0KdG8gYmUuICBOZXcgbG9vcCBzaG91bGQg
YmUgbW9yZSBlZmZpY2llbnQgYW5kIGl0IGEgbG90IHNpbXBsZXIuDQ0KDQ0K
QSBwb2xsaW5nIGxvb3AgdG8gY2hlY2sgZm9yIHRoZSBkZXZpY2UgdG8gbGVh
dmluZyBJTklUIG1vZGUgaXMgcmVtb3ZlZC4gIFRoZQ0NCmRldmljZSBtdXN0
IGhhdmUgYWxyZWFkeSBsZWZ0IGluaXQgZm9yIHRoZSBwcmV2aW91cyBBQ0kg
bG9vcCB0byBoYXZlIGZpbmlzaGVkLg0NCg0NClNpZ25lZC1vZmYtYnk6IFRy
ZW50IFBpZXBobyA8eHl6enlAc3BlYWtlYXN5Lm9yZz4NCg0KZGlmZiAtciA1
MDUwMmMxM2QyY2YgaXNhL2FkMTg0OC9hZDE4NDhfbGliLmMNCi0tLSBhL2lz
YS9hZDE4NDgvYWQxODQ4X2xpYi5jCU1vbiBTZXAgMTcgMTk6MDg6MzIgMjAw
NyArMDIwMA0KKysrIGIvaXNhL2FkMTg0OC9hZDE4NDhfbGliLmMJTW9uIFNl
cCAxNyAxMjo1NzowNSAyMDA3IC0wNzAwDQpAQCAtMjA1LDcgKzIwNSw2IEBA
IHN0YXRpYyB2b2lkIHNuZF9hZDE4NDhfbWNlX2Rvd24oc3RydWN0IHMNCiB7
DQogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQogCWludCB0aW1lb3V0Ow0KLQl1
bnNpZ25lZCBsb25nIGVuZF90aW1lOw0KIA0KIAlzcGluX2xvY2tfaXJxc2F2
ZSgmY2hpcC0+cmVnX2xvY2ssIGZsYWdzKTsNCiAJZm9yICh0aW1lb3V0ID0g
NTsgdGltZW91dCA+IDA7IHRpbWVvdXQtLSkNCkBAIC0yMzEsMzkgKzIzMCwy
OCBAQCBzdGF0aWMgdm9pZCBzbmRfYWQxODQ4X21jZV9kb3duKHN0cnVjdCBz
DQogCQlyZXR1cm47DQogCX0NCiANCi0JLyoNCi0JICogV2FpdCBmb3IgKHBv
c3NpYmxlIC0tIGR1cmluZyBpbml0IGF1dG8tY2FsaWJyYXRpb24gbWF5IG5v
dCBiZSBzZXQpDQotCSAqIGNhbGlicmF0aW9uIHByb2Nlc3MgdG8gc3RhcnQu
IE5lZWRzIHVwdG8gNSBzYW1wbGUgcGVyaW9kcyBvbiBBRDE4NDgNCi0JICog
d2hpY2ggYXQgdGhlIHNsb3dlc3QgcG9zc2libGUgcmF0ZSBvZiA1LjUxMjUg
a0h6IG1lYW5zIDkwNyB1cy4NCisJLyogDQorCSAqIFdhaXQgZm9yIGF1dG8t
Y2FsaWJyYXRpb24gKEFDKSBwcm9jZXNzIHRvIGZpbmlzaCwgaS5lLiBBQ0kg
dG8gZ28NCisJICogbG93LiAgSXQgbWF5IHRha2UgdXAgdG8gNSBzYW1wbGUg
cGVyaW9kcyAoYXQgbW9zdCA5MDcgdXMgQCA1LjUxMjUNCisJICoga0h6KSBm
b3IgdGhlIHByb2Nlc3MgdG8gX3N0YXJ0Xywgc28gaXQgaXMgaW1wb3J0YW50
IHRvIHdhaXQgYXQgbGVhc3QNCisJICogdGhhdCBsb25nIGJlZm9yZSBjaGVj
a2luZy4gIE90aGVyd2lzZSB3ZSBtaWdodCB0aGluayBBQyBoYXMgZmluaXNo
ZWQNCisJICogd2hlbiBpdCBoYXMgaW4gZmFjdCBub3QgYmVndW4uICBJdCBz
aG91bGQgdGFrZSAxMjggKG5vIEFDKSBvciAzODQNCisJICogKEFDKSBjeWNs
ZXMgZm9yIEFDSSB0byBkcm9wLiAgVGhpcyBnaXZlcyBhIHJhbmdlIG9mIGF0
IG1vc3QgNzAgbXMNCisJICogd2l0aCBhIG1vcmUgdHlwaWNhbCB2YWx1ZSBv
ZiBqdXN0IHVuZGVyIDMgbXMuICBXaXRoIGEgMyBtcyB3YWl0LCB3ZQ0KKwkg
KiB3aWxsIHByb2JhYmx5IGZpbmlzaCBvbiB0aGUgZmlyc3QgbG9vcC4NCiAJ
ICovDQotCW1zbGVlcCgxKTsNCi0NCi0Jc25kX3ByaW50ZGQoIigyKSBqaWZm
aWVzID0gJWx1XG4iLCBqaWZmaWVzKTsNCi0NCi0JZW5kX3RpbWUgPSBqaWZm
aWVzICsgbXNlY3NfdG9famlmZmllcygyNTApOw0KLQl3aGlsZSAoc25kX2Fk
MTg0OF9pbihjaGlwLCBBRDE4NDhfVEVTVF9JTklUKSAmIEFEMTg0OF9DQUxJ
Ql9JTl9QUk9HUkVTUykgew0KLQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
Y2hpcC0+cmVnX2xvY2ssIGZsYWdzKTsNCi0JCWlmICh0aW1lX2FmdGVyKGpp
ZmZpZXMsIGVuZF90aW1lKSkgew0KLQkJCXNuZF9wcmludGsoS0VSTl9FUlIg
Im1jZV9kb3duIC0gYXV0byBjYWxpYnJhdGlvbiB0aW1lIG91dCAoMilcbiIp
Ow0KLQkJCXJldHVybjsNCi0JCX0NCi0JCW1zbGVlcCgxKTsNCisJLyogZ2l2
ZSB1cCBhdCB+MS80IHNlYyBhdCAzIG1zIHBlciBsb29wICovDQorIAlmb3Io
dGltZW91dCA9IDg1OyB0aW1lb3V0ID4gMDsgdGltZW91dC0tKSB7DQorCQlt
c2xlZXAoMyk7DQogCQlzcGluX2xvY2tfaXJxc2F2ZSgmY2hpcC0+cmVnX2xv
Y2ssIGZsYWdzKTsNCi0JfQ0KLQ0KLQlzbmRfcHJpbnRkZCgiKDMpIGppZmZp
ZXMgPSAlbHVcbiIsIGppZmZpZXMpOw0KLQ0KLQllbmRfdGltZSA9IGppZmZp
ZXMgKyBtc2Vjc190b19qaWZmaWVzKDEwMCk7DQotCXdoaWxlIChpbmIoQUQx
ODQ4UChjaGlwLCBSRUdTRUwpKSAmIEFEMTg0OF9JTklUKSB7DQotCQlzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZjaGlwLT5yZWdfbG9jaywgZmxhZ3MpOw0K
LQkJaWYgKHRpbWVfYWZ0ZXIoamlmZmllcywgZW5kX3RpbWUpKSB7DQotCQkJ
c25kX3ByaW50ayhLRVJOX0VSUiAibWNlX2Rvd24gLSBhdXRvIGNhbGlicmF0
aW9uIHRpbWUgb3V0ICgzKVxuIik7DQotCQkJcmV0dXJuOw0KLQkJfQ0KLQkJ
bXNsZWVwKDEpOw0KLQkJc3Bpbl9sb2NrX2lycXNhdmUoJmNoaXAtPnJlZ19s
b2NrLCBmbGFncyk7DQotCX0NCi0Jc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
Y2hpcC0+cmVnX2xvY2ssIGZsYWdzKTsNCisJCWlmIChzbmRfYWQxODQ4X2lu
KGNoaXAsIEFEMTg0OF9URVNUX0lOSVQpICYgQUQxODQ4X0NBTElCX0lOX1BS
T0dSRVNTKQ0KKwkJCWJyZWFrOw0KKwl9DQorCXNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJmNoaXAtPnJlZ19sb2NrLCBmbGFncyk7DQorCWlmICghdGltZW91
dCkgew0KKwkJc25kX3ByaW50ayhLRVJOX0VSUiAibWNlX2Rvd24gLSBhdXRv
IGNhbGlicmF0aW9uIHRpbWUgb3V0ICgyKVxuIik7DQorCQlyZXR1cm47DQor
CX0NCiANCiAJc25kX3ByaW50ZGQoIig0KSBqaWZmaWVzID0gJWx1XG4iLCBq
aWZmaWVzKTsNCiAJc25kX3ByaW50ZCgibWNlX2Rvd24gLSBleGl0ID0gMHgl
eFxuIiwgaW5iKEFEMTg0OFAoY2hpcCwgUkVHU0VMKSkpOw0K

--289736052-1503498660-1190063061=:27377
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--289736052-1503498660-1190063061=:27377--
