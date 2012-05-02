From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: M-Audio FastTrack C400
Date: Wed, 2 May 2012 12:05:45 +0200
Message-ID: <CAFz=ag5HWp-BW4ZyymR7F60ahtzttyoBk6ZwdSRVKBXepHyn1w@mail.gmail.com>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
	<4F8FD2A7.60700@ladisch.de> <4F911629.5090704@gmail.com>
	<4F920D73.7070309@rauros.net>
	<CAFz=ag4viHQ-K7qbpCk-G+H3Q8GKe=7-anfOeCy3jhUCYUJ5BQ@mail.gmail.com>
	<CACckToUVQu=p0ZSaGw-oRn2ASgfQ_Po2im1ha5-yUVeyt7JUaQ@mail.gmail.com>
	<4F9CB0D7.5060401@rauros.net>
	<CAFz=ag6tVjD6hANk2e6sH8hcrbJi6SdqYJNy2U-nkArBV5DVfQ@mail.gmail.com>
	<4F9D4291.6060803@rauros.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3056423db5082504bf0ad40b
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 27C19104429
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2012 12:05:47 +0200 (CEST)
Received: by ghbg19 with SMTP id g19so518204ghb.38
	for <alsa-devel@alsa-project.org>; Wed, 02 May 2012 03:05:46 -0700 (PDT)
In-Reply-To: <4F9D4291.6060803@rauros.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: chris-alsa@rauros.net
Cc: Grant Diffey <gdiffey@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--20cf3056423db5082504bf0ad40b
Content-Type: text/plain; charset=ISO-8859-1

Hi,

thanks for the usbmon logs.

Here's small patch for mixer_quirks.c that might get you *some*
controls (should be 16 controls). I could not even try to compile this
at the moment so it might be completely broken ;-)

If you don't hear any sound it would still be a success if you can
actually control the controls. Please, also take a look at usbmon
output (grep Co) and see if we really match the corresponding Windows
messages.

Due to the flat layout of the mixer we can't get more controls within
the current quirk without a couple of deeper changes in mixer.c. I'm
hesitating to do something like this without knowing if it's actually
needed *and* sufficient.

Hence, could you please send usbmon logs of the effect controls.
Again, I'm only interested in the "Co" lines.
(If the effect controls extend the flat layout we need to write our
own get/set functions anyway and there was no need for dealing with
mixer.c)

Regards,

Felix

--20cf3056423db5082504bf0ad40b
Content-Type: application/octet-stream; name="c400_test.diff"
Content-Disposition: attachment; filename="c400_test.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h1q7xnfg0

ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9taXhlcl9xdWlya3MuYyBiL3NvdW5kL3VzYi9taXhlcl9x
dWlya3MuYwppbmRleCAxMjEyNWNhLi4yYmE0YTI4IDEwMDY0NAotLS0gYS9zb3VuZC91c2IvbWl4
ZXJfcXVpcmtzLmMKKysrIGIvc291bmQvdXNiL21peGVyX3F1aXJrcy5jCkBAIC05MjUsNiArOTI1
LDUyIEBAIHN0YXRpYyBpbnQgc25kX2Z0dV9jcmVhdGVfbWl4ZXIoc3RydWN0IHVzYl9taXhlcl9p
bnRlcmZhY2UgKm1peGVyKQogfQogCiAKKy8qIFRyeSB0byBjcmVhdGUgbWl4ZXIgY29udHJvbHMg
Zm9yIE0tQXVkaW8gQzQwMCAqLworc3RhdGljIGludCBzbmRfYzQwMF9jcmVhdGVfdm9sX2N0bHMo
c3RydWN0IHVzYl9taXhlcl9pbnRlcmZhY2UgKm1peGVyKQoreworCWNoYXIgbmFtZVs2NF07CisJ
dW5zaWduZWQgaW50IGNvbnRyb2wsIGNtYXNrOworCWludCBpbiwgb3V0LCBlcnI7CisKKwljb25z
dCB1bnNpZ25lZCBpbnQgaWQgPSAweDQwOworCWNvbnN0IGludCB2YWxfdHlwZSA9IFVTQl9NSVhF
Ul9TMTY7CisJY29uc3QgY29udHJvbCA9IDE7CisKKwlmb3IgKGluID0gMDsgaW4gPCAxMDsgaW4r
KykgeworCQlmb3IgKG91dCA9IDA7IG91dCA8IDY7IG91dCsrKSB7CisJCQkvKiBHaXZlIGl0IGEg
bmFtZSAqLworCQkJaWYoaW4gPCA2KSB7CisJCQkJc25wcmludGYobmFtZSwgc2l6ZW9mKG5hbWUp
LAorCQkJCQkiREluJWQgLSBPdXQlZCBQbGF5YmFjayBWb2x1bWUiLAorCQkJCQlpbiArIDEsIG91
dCArIDEpOworCQkJfSBlbHNlIHsKKwkJCQlzbnByaW50ZihuYW1lLCBzaXplb2YobmFtZSksCisJ
CQkJCSJBSW4lZCAtIE91dCVkIFBsYXliYWNrIFZvbHVtZSIsCisJCQkJCWluIC0gNiwgb3V0ICsg
MSk7CQkJCQorCQkJfQorCQkJLyogQ3JlYXRlIGFzIG1hbnkgY29udHJvbHMgYXMgcG9zc2libGUg
YS50Lm0uICovCisJCQlpZiAoaW4gKiA2ICsgb3V0IDwgTUFYX0NIQU5ORUxTIHsKKwkJCQljbWFz
ayA9IDEgPDwgKGluICogNiArIG91dCk7CisJCQkJZXJyID0gc25kX2NyZWF0ZV9zdGRfbW9ub19j
dGwobWl4ZXIsIGlkLCBjb250cm9sLAorCQkJCQkJCWNtYXNrLCB2YWxfdHlwZSwgbmFtZSwKKwkJ
CQkJCQkmc25kX3VzYl9taXhlcl92b2xfdGx2KTsKKwkJCQlpZiAoZXJyIDwgMCkKKwkJCQkJcmV0
dXJuIGVycjsKKwkJCX0KKwkJfQorCX0KKworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IHNu
ZF9jNDAwX2NyZWF0ZV9taXhlcihzdHJ1Y3QgdXNiX21peGVyX2ludGVyZmFjZSAqbWl4ZXIpCit7
CisJaW50IGVyciA9IDA7CisJZXJyID0gc25kX2M0MDBfY3JlYXRlX3ZvbF9jdGxzKG1peGVyKTsK
KworCXJldHVybiBlcnI7Cit9CisKIC8qCiAgKiBDcmVhdGUgbWl4ZXIgZm9yIEVsZWN0cml4IEVi
b3gtNDQKICAqCkBAIC0xMDI1LDYgKzEwNzEsMTAgQEAgaW50IHNuZF91c2JfbWl4ZXJfYXBwbHlf
Y3JlYXRlX3F1aXJrKHN0cnVjdCB1c2JfbWl4ZXJfaW50ZXJmYWNlICptaXhlcikKIAkJZXJyID0g
c25kX2Z0dV9jcmVhdGVfbWl4ZXIobWl4ZXIpOwogCQlicmVhazsKIAorCWNhc2UgVVNCX0lEKDB4
MDc2MywgMHgyMDMwKTogLyogTS1BdWRpbyBDNDAwICovCisJCWVyciA9IHNuZF9jNDAwX2NyZWF0
ZV9taXhlcihtaXhlcik7CisJCWJyZWFrOworCiAJY2FzZSBVU0JfSUQoMHgwYjA1LCAweDE3Mzkp
OgogCWNhc2UgVVNCX0lEKDB4MGIwNSwgMHgxNzQzKToKIAkJZXJyID0gc25kX3hvbmFyX3UxX2Nv
bnRyb2xzX2NyZWF0ZShtaXhlcik7Cg==
--20cf3056423db5082504bf0ad40b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--20cf3056423db5082504bf0ad40b--
