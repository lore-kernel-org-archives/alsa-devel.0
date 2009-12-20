From: =?UTF-8?Q?Rafael_Esp=C3=ADndola?= <rafael.espindola@gmail.com>
Subject: [patch] Add support for the new 27 inch IMacs
Date: Sun, 20 Dec 2009 16:46:15 -0500
Message-ID: <564d96fb0912201346y29f3fbcamfa9e82760bdc8b2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001517477fa6fee00a047b2fe649
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 593BB103813
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 22:46:17 +0100 (CET)
Received: by fxm4 with SMTP id 4so18286028fxm.32
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 13:46:16 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--001517477fa6fee00a047b2fe649
Content-Type: text/plain; charset=UTF-8

With the attached patch I am able to use the sound on a new IMac 27. What works:

*) Internal speakers
*) Internal microphone
*) Headphone

I don't have an external mic or a SPDIF device to test the rest.

Cheers,
Rafael

--001517477fa6fee00a047b2fe649
Content-Type: text/x-patch; charset=US-ASCII; name="imac27.patch"
Content-Disposition: attachment; filename="imac27.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g3gcjc0x0

ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfY2lycnVzLmMgYi9zb3VuZC9wY2kvaGRh
L3BhdGNoX2NpcnJ1cy5jCmluZGV4IGVlYjkxZjYuLjdkMTFjNDggMTAwNjQ0Ci0tLSBhL3NvdW5k
L3BjaS9oZGEvcGF0Y2hfY2lycnVzLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9jaXJydXMu
YwpAQCAtNjYsNiArNjYsNyBAQCBzdHJ1Y3QgY3Nfc3BlYyB7CiAvKiBhdmFpbGFibGUgbW9kZWxz
ICovCiBlbnVtIHsKIAlDUzQyMFhfTUJQNTUsCisJQ1M0MjBYX0lNQUMyNywKIAlDUzQyMFhfQVVU
TywKIAlDUzQyMFhfTU9ERUxTCiB9OwpAQCAtODMzLDcgKzgzNCw4IEBAIHN0YXRpYyB2b2lkIGNz
X2F1dG9tdXRlKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCQkJCSAgICBBQ19WRVJCX1NFVF9Q
SU5fV0lER0VUX0NPTlRST0wsCiAJCQkJICAgIGhwX3ByZXNlbnQgPyAwIDogUElOX09VVCk7CiAJ
fQotCWlmIChzcGVjLT5ib2FyZF9jb25maWcgPT0gQ1M0MjBYX01CUDU1KSB7CisJaWYgKHNwZWMt
PmJvYXJkX2NvbmZpZyA9PSBDUzQyMFhfTUJQNTUgfHwKKwkgICAgc3BlYy0+Ym9hcmRfY29uZmln
ID09IENTNDIwWF9JTUFDMjcpIHsKIAkJdW5zaWduZWQgaW50IGdwaW8gPSBocF9wcmVzZW50ID8g
MHgwMiA6IDB4MDg7CiAJCXNuZF9oZGFfY29kZWNfd3JpdGUoY29kZWMsIDB4MDEsIDAsCiAJCQkJ
ICAgIEFDX1ZFUkJfU0VUX0dQSU9fREFUQSwgZ3Bpbyk7CkBAIC0xMDc1LDEyICsxMDc3LDE0IEBA
IHN0YXRpYyBpbnQgY3NfcGFyc2VfYXV0b19jb25maWcoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMp
CiAKIHN0YXRpYyBjb25zdCBjaGFyICpjczQyMHhfbW9kZWxzW0NTNDIwWF9NT0RFTFNdID0gewog
CVtDUzQyMFhfTUJQNTVdID0gIm1icDU1IiwKKwlbQ1M0MjBYX0lNQUMyN10gPSAiaW1hYzI3IiwK
IAlbQ1M0MjBYX0FVVE9dID0gImF1dG8iLAogfTsKIAogCiBzdGF0aWMgc3RydWN0IHNuZF9wY2lf
cXVpcmsgY3M0MjB4X2NmZ190YmxbXSA9IHsKIAlTTkRfUENJX1FVSVJLKDB4MTBkZSwgMHhjYjc5
LCAiTWFjQm9va1BybyA1LDUiLCBDUzQyMFhfTUJQNTUpLAorCVNORF9QQ0lfUVVJUksoMHg4MDg2
LCAweDcyNzAsICJJTWFjIDI3IEluY2giLCBDUzQyMFhfSU1BQzI3KSwKIAl7fSAvKiB0ZXJtaW5h
dG9yICovCiB9OwogCkBAIC0xMTAzLDggKzExMDcsMjMgQEAgc3RhdGljIHN0cnVjdCBjc19waW5j
ZmcgbWJwNTVfcGluY2Znc1tdID0gewogCXt9IC8qIHRlcm1pbmF0b3IgKi8KIH07CiAKK3N0YXRp
YyBzdHJ1Y3QgY3NfcGluY2ZnIGltYWMyN19waW5jZmdzW10gPSB7CisJeyAweDA5LCAweDAxMmI0
MDUwfSwKKwl7IDB4MGEsIDB4OTAxMDAxNDB9LAorCXsgMHgwYiwgMHg5MDEwMDE0Mn0sCisJeyAw
eDBjLCAweDAxOGIzMDIwfSwKKwl7IDB4MGQsIDB4OTBhMDAxMTB9LAorCXsgMHgwZSwgMHg0MDAw
MDBmMH0sCisJeyAweDBmLCAweDAxY2JlMDMwfSwKKwl7IDB4MTAsIDB4MDE0YmUwNjB9LAorCXsg
MHgxMiwgMHgwMWFiOTA3MH0sCisJeyAweDE1LCAweDQwMDAwMGYwfSwKKwl7fSAvKiB0ZXJtaW5h
dG9yICovCit9OworCiBzdGF0aWMgc3RydWN0IGNzX3BpbmNmZyAqY3NfcGluY2Znc1tDUzQyMFhf
TU9ERUxTXSA9IHsKIAlbQ1M0MjBYX01CUDU1XSA9IG1icDU1X3BpbmNmZ3MsCisJW0NTNDIwWF9J
TUFDMjddID0gaW1hYzI3X3BpbmNmZ3MsCiB9OwogCiBzdGF0aWMgdm9pZCBmaXhfcGluY2ZnKHN0
cnVjdCBoZGFfY29kZWMgKmNvZGVjLCBpbnQgbW9kZWwpCkBAIC0xMTM0LDYgKzExNTMsNyBAQCBz
dGF0aWMgaW50IHBhdGNoX2NzNDIweChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIAkJZml4X3Bp
bmNmZyhjb2RlYywgc3BlYy0+Ym9hcmRfY29uZmlnKTsKIAogCXN3aXRjaCAoc3BlYy0+Ym9hcmRf
Y29uZmlnKSB7CisJY2FzZSBDUzQyMFhfSU1BQzI3OgogCWNhc2UgQ1M0MjBYX01CUDU1OgogCQkv
KiBHUElPMSA9IGhlYWRwaG9uZXMgKi8KIAkJLyogR1BJTzMgPSBzcGVha2VycyAqLwo=
--001517477fa6fee00a047b2fe649
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001517477fa6fee00a047b2fe649--
