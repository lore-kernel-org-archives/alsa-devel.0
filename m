From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: If /dev/snd/controlCx EACCES vs. ENODEV mixup
Date: Sun, 25 Nov 2007 22:40:07 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711252232430.7688@tm8103.perex-int.cz>
References: <20071125210359.GB17108@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1540448179-1196026807=:7688"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 263B724611
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 22:40:08 +0100 (CET)
In-Reply-To: <20071125210359.GB17108@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1540448179-1196026807=:7688
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sun, 25 Nov 2007, Lennart Poettering wrote:

> Hi!
> 
> If /dev/snd/controlC0 is not accessible due to a permission problem
> (EACCES), then alsa-libs will lie and return ENODEV. This is quite a
> bit confusing:
> 
> <snip>
> $ sudo chmod 000 /dev/snd/controlC0
> $ aplay -D hw:0
> ALSA lib pcm_hw.c:1207:(_snd_pcm_hw_open) Invalid value for card
> aplay: main:546: audio open error: No such device
> </snip>
> 
> (and strace shows that the actual problem is EACESS, as one would
> assume.

Could you try attached patch?

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
--8323584-1540448179-1196026807=:7688
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="perm.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0711252240070.7688@tm8103.perex-int.cz>
Content-Description: 
Content-Disposition: attachment; filename="perm.patch"

ZGlmZiAtciA2NzJjNTM4NzY0NWQgc3JjL2NvbnRyb2wvY2FyZHMuYw0KLS0t
IGEvc3JjL2NvbnRyb2wvY2FyZHMuYwlGcmkgTm92IDIzIDE1OjQ2OjQ4IDIw
MDcgKzAxMDANCisrKyBiL3NyYy9jb250cm9sL2NhcmRzLmMJU3VuIE5vdiAy
NSAyMjozNjo1NyAyMDA3ICswMTAwDQpAQCAtMzksMTIgKzM5LDcgQEANCiAj
ZGVmaW5lIFNORF9GSUxFX0xPQUQJCUFMT0FEX0RFVklDRV9ESVJFQ1RPUlkg
ImFsb2FkQyVpIg0KICNlbmRpZg0KIA0KLS8qKg0KLSAqIFxicmllZiBUcnkg
dG8gbG9hZCB0aGUgZHJpdmVyIGZvciBhIGNhcmQuDQotICogXHBhcmFtIGNh
cmQgQ2FyZCBudW1iZXIuDQotICogXHJldHVybiAxIGlmIGRyaXZlciBpcyBw
cmVzZW50LCB6ZXJvIGlmIGRyaXZlciBpcyBub3QgcHJlc2VudA0KLSAqLw0K
LWludCBzbmRfY2FyZF9sb2FkKGludCBjYXJkKQ0KK3N0YXRpYyBpbnQgc25k
X2NhcmRfbG9hZDEoaW50IGNhcmQpDQogew0KIAlpbnQgb3Blbl9kZXY7DQog
CWNoYXIgY29udHJvbFtzaXplb2YoU05EX0ZJTEVfQ09OVFJPTCkgKyAxMF07
DQpAQCAtNjEsOSArNTYsMjAgQEAgaW50IHNuZF9jYXJkX2xvYWQoaW50IGNh
cmQpDQogI2VuZGlmDQogCWlmIChvcGVuX2RldiA+PSAwKSB7DQogCQljbG9z
ZSAob3Blbl9kZXYpOw0KLQkJcmV0dXJuIDE7DQotCX0NCi0JcmV0dXJuIDA7
DQorCQlyZXR1cm4gMDsNCisJfSBlbHNlIHsNCisJCXJldHVybiAtZXJybm87
DQorCX0NCit9DQorDQorLyoqDQorICogXGJyaWVmIFRyeSB0byBsb2FkIHRo
ZSBkcml2ZXIgZm9yIGEgY2FyZC4NCisgKiBccGFyYW0gY2FyZCBDYXJkIG51
bWJlci4NCisgKiBccmV0dXJuIDEgaWYgZHJpdmVyIGlzIHByZXNlbnQsIHpl
cm8gaWYgZHJpdmVyIGlzIG5vdCBwcmVzZW50DQorICovDQoraW50IHNuZF9j
YXJkX2xvYWQoaW50IGNhcmQpDQorew0KKwlyZXR1cm4gISEoc25kX2NhcmRf
bG9hZDEoY2FyZCkgPT0gMCk7DQogfQ0KIA0KIC8qKg0KQEAgLTEwNCw3ICsx
MTAsNyBAQCBpbnQgc25kX2NhcmRfbmV4dChpbnQgKnJjYXJkKQ0KICAqLw0K
IGludCBzbmRfY2FyZF9nZXRfaW5kZXgoY29uc3QgY2hhciAqc3RyaW5nKQ0K
IHsNCi0JaW50IGNhcmQ7DQorCWludCBjYXJkLCBlcnI7DQogCXNuZF9jdGxf
dCAqaGFuZGxlOw0KIAlzbmRfY3RsX2NhcmRfaW5mb190IGluZm87DQogDQpA
QCAtMTE2LDEzICsxMjIsMTYgQEAgaW50IHNuZF9jYXJkX2dldF9pbmRleChj
b25zdCBjaGFyICpzdHJpbg0KIAkJCXJldHVybiAtRUlOVkFMOw0KIAkJaWYg
KGNhcmQgPCAwIHx8IGNhcmQgPiAzMSkNCiAJCQlyZXR1cm4gLUVJTlZBTDsN
Ci0JCWlmIChzbmRfY2FyZF9sb2FkKGNhcmQpKQ0KKwkJZXJyID0gc25kX2Nh
cmRfbG9hZDEoY2FyZCk7DQorCQlpZiAoZXJyID49IDApDQogCQkJcmV0dXJu
IGNhcmQ7DQotCQlyZXR1cm4gLUVOT0RFVjsNCisJCXJldHVybiBlcnI7DQog
CX0NCiAJZm9yIChjYXJkID0gMDsgY2FyZCA8IDMyOyBjYXJkKyspIHsNCisj
aWZkZWYgU1VQUE9SVF9BTE9BRA0KIAkJaWYgKCEgc25kX2NhcmRfbG9hZChj
YXJkKSkNCiAJCQljb250aW51ZTsNCisjZW5kaWYNCiAJCWlmIChzbmRfY3Rs
X2h3X29wZW4oJmhhbmRsZSwgTlVMTCwgY2FyZCwgMCkgPCAwKQ0KIAkJCWNv
bnRpbnVlOw0KIAkJaWYgKHNuZF9jdGxfY2FyZF9pbmZvKGhhbmRsZSwgJmlu
Zm8pIDwgMCkgew0K

--8323584-1540448179-1196026807=:7688
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1540448179-1196026807=:7688--
