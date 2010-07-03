From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: [PATCH 1/3] ASoC: codec: Add WM8987 device id to
	WM8750 driver
Date: Sat, 03 Jul 2010 02:46:10 +0200
Message-ID: <4c2e8854.cf7d0e0a.166f.3e5a@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 08F7B243B9
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Jul 2010 02:46:14 +0200 (CEST)
Received: by eye27 with SMTP id 27so23483eye.38
	for <alsa-devel@alsa-project.org>; Fri, 02 Jul 2010 17:46:12 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

VGhlIFdNODk4NyBjb2RlYyBpcyByZWdpc3RlciBjb21wYXRpYmxlIHdpdGggdGhlIFdNODc1MCwg
c28ganVzdCBhZGQgaXQgdG8gdGhlClNQSSBhbmQgScKyQyBkZXZpY2UgdGFibGUuCgpTaWduZWQt
b2ZmLWJ5OiBNYXVydXMgQ3VlbGVuYWVyZSA8bWN1ZWxlbmFlcmVAZ21haWwuY29tPgotLS0KIHNv
dW5kL3NvYy9jb2RlY3Mvd204NzUwLmMgfCAgIDExICsrKysrKysrKystCiAxIGZpbGVzIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQv
c29jL2NvZGVjcy93bTg3NTAuYyBiL3NvdW5kL3NvYy9jb2RlY3Mvd204NzUwLmMKaW5kZXggOTQw
N2UxOS4uZTJjMDVlMyAxMDA2NDQKLS0tIGEvc291bmQvc29jL2NvZGVjcy93bTg3NTAuYworKysg
Yi9zb3VuZC9zb2MvY29kZWNzL3dtODc1MC5jCkBAIC04ODQsNiArODg0LDcgQEAgc3RhdGljIGlu
dCB3bTg3NTBfaTJjX3JlbW92ZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQogCiBzdGF0aWMg
Y29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgd204NzUwX2kyY19pZFtdID0gewogCXsgIndtODc1
MCIsIDAgfSwKKwl7ICJ3bTg5ODciLCAwIH0sIC8qIFdNODk4NyBpcyByZWdpc3RlciBjb21wYXRp
YmxlIHdpdGggV004NzUwICovCiAJeyB9CiB9OwogTU9EVUxFX0RFVklDRV9UQUJMRShpMmMsIHdt
ODc1MF9pMmNfaWQpOwpAQCAtOTI1LDE0ICs5MjYsMjIgQEAgc3RhdGljIGludCBfX2RldmV4aXQg
d204NzUwX3NwaV9yZW1vdmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkKIAlyZXR1cm4gMDsKIH0K
IAorc3RhdGljIGNvbnN0IHN0cnVjdCBzcGlfZGV2aWNlX2lkIHdtODc1MF9zcGlfaWRbXSA9IHsK
Kwl7ICJ3bTg3NTAiLCAwIH0sCisJeyAid204OTg3IiwgMCB9LAorCXsgfQorfTsKK01PRFVMRV9E
RVZJQ0VfVEFCTEUoc3BpLCB3bTg3NTBfc3BpX2lkKTsKKwogc3RhdGljIHN0cnVjdCBzcGlfZHJp
dmVyIHdtODc1MF9zcGlfZHJpdmVyID0gewogCS5kcml2ZXIgPSB7Ci0JCS5uYW1lCT0gIndtODc1
MCIsCisJCS5uYW1lCT0gIldNODc1MCBTUEkgQ29kZWMiLAogCQkuYnVzCT0gJnNwaV9idXNfdHlw
ZSwKIAkJLm93bmVyCT0gVEhJU19NT0RVTEUsCiAJfSwKIAkucHJvYmUJCT0gd204NzUwX3NwaV9w
cm9iZSwKIAkucmVtb3ZlCQk9IF9fZGV2ZXhpdF9wKHdtODc1MF9zcGlfcmVtb3ZlKSwKKwkuaWRf
dGFibGUJPSB3bTg3NTBfc3BpX2lkLAogfTsKICNlbmRpZgogCi0tIAoxLjcuMC40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
