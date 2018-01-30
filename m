From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] ASoC: rt5514: Fix rt5514_spi_burst_read()
	buffer passing
Date: Tue, 30 Jan 2018 14:19:42 +0100
Message-ID: <1517318383-14420-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be
 [195.130.132.51])
 by alsa0.perex.cz (Postfix) with ESMTP id AA9D42671F2
 for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2018 14:19:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: alsa-devel@alsa-project.org

cnQ1NTE0X2RzcF92b2ljZV93YWtlX3VwX3B1dCgpIHBhc3NlcyAiKHU4ICopJmJ1ZiIgdG8KcnQ1
NTE0X3NwaV9idXJzdF9yZWFkKCksIHdoZXJlIHRoZSBjYXN0IGlzIG5lZWRlZCB0byBzaWxlbmNl
IGEgY29tcGlsZXIKd2FybmluZzoKCiAgICBzb3VuZC9zb2MvY29kZWNzL3J0NTUxNC5jOiBJbiBm
dW5jdGlvbiDigJhydDU1MTRfZHNwX3ZvaWNlX3dha2VfdXBfcHV04oCZOgogICAgc291bmQvc29j
L2NvZGVjcy9ydDU1MTQuYzozNTc6IHdhcm5pbmc6IHBhc3NpbmcgYXJndW1lbnQgMiBvZiDigJhy
dDU1MTRfc3BpX2J1cnN0X3JlYWTigJkgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlCgpI
b3dldmVyLCBhcyB0aGUgdmFyaWFibGUgaXMgZGVjbGFyZWQgYXMgYW4gYXJyYXkgKCJ1OCBidWZb
OF0iKSwgdGhlCmZ1bmN0aW9uIHNob3VsZCBqdXN0IHBhc3MgImJ1ZiIgaW5zdGVhZC4KCkZpeGVz
OiBmYzljYWIwNTgzNzYzOWNlICgiQVNvQzogcnQ1NTE0OiBUaGUgRFNQIGNsb2NrIGNhbiBiZSBj
YWxpYnJhdGVkIGJ5IHRoZSBvdGhlciBjbG9jayBzb3VyY2UiKQpTaWduZWQtb2ZmLWJ5OiBHZWVy
dCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPgotLS0KIHNvdW5kL3NvYy9jb2Rl
Y3MvcnQ1NTE0LmMgfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvcnQ1NTE0LmMgYi9zb3Vu
ZC9zb2MvY29kZWNzL3J0NTUxNC5jCmluZGV4IDE5OGRmMDE2ODAyZjgyNmQuLjE5ZjAxNTU4ZmJj
YTY3N2YgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvcnQ1NTE0LmMKKysrIGIvc291bmQv
c29jL2NvZGVjcy9ydDU1MTQuYwpAQCAtMzU0LDggKzM1NCw3IEBAIHN0YXRpYyBpbnQgcnQ1NTE0
X2RzcF92b2ljZV93YWtlX3VwX3B1dChzdHJ1Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwKIAkJ
CQltc2xlZXAoMjApOwogI2lmIElTX0VOQUJMRUQoQ09ORklHX1NORF9TT0NfUlQ1NTE0X1NQSSkK
IAkJCQlydDU1MTRfc3BpX2J1cnN0X3JlYWQoUlQ1NTE0X1BMTDNfQ0FMSUJfQ1RSTDYgfAotCQkJ
CQlSVDU1MTRfRFNQX01BUFBJTkcsCi0JCQkJCSh1OCAqKSZidWYsIHNpemVvZihidWYpKTsKKwkJ
CQkJUlQ1NTE0X0RTUF9NQVBQSU5HLCBidWYsIHNpemVvZihidWYpKTsKICNlbHNlCiAJCQkJZGV2
X2Vycihjb2RlYy0+ZGV2LCAiVGhlcmUgaXMgbm8gU1BJIGRyaXZlciBmb3IiCiAJCQkJCSIgbG9h
ZGluZyB0aGUgZmlybXdhcmVcbiIpOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2
ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxt
YW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
