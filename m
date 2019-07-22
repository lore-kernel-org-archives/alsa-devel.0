From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/5] ASoC: atmel_ssc_dai: implement left-justified data mode
Date: Mon, 22 Jul 2019 20:27:21 +0200
Message-ID: <ca3d0b124cdf6e2d0ec158a7948f08dd8abfd3b7.1563819483.git.mirq-linux@rere.qmqm.pl>
References: <cover.1563819483.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1563819483.git.mirq-linux@rere.qmqm.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Mark Brown <broonie@kernel.org>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogTWljaGHFgiBNaXJvc8WCYXcgPG1pcnEtbGludXhAcmVyZS5xbXFtLnBs
PgotLS0KIHNvdW5kL3NvYy9hdG1lbC9hdG1lbF9zc2NfZGFpLmMgfCAxMyArKysrKysrKysrKysr
CiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3Nv
Yy9hdG1lbC9hdG1lbF9zc2NfZGFpLmMgYi9zb3VuZC9zb2MvYXRtZWwvYXRtZWxfc3NjX2RhaS5j
CmluZGV4IGIyOTkyNDk2ZTUyZi4uMDQ1NDFkN2MzM2ZlIDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mv
YXRtZWwvYXRtZWxfc3NjX2RhaS5jCisrKyBiL3NvdW5kL3NvYy9hdG1lbC9hdG1lbF9zc2NfZGFp
LmMKQEAgLTU2NCw3ICs1NjQsMjAgQEAgc3RhdGljIGludCBhdG1lbF9zc2NfaHdfcGFyYW1zKHN0
cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAogCiAJc3dpdGNoIChzc2NfcC0+ZGFp
Zm10ICYgU05EX1NPQ19EQUlGTVRfRk9STUFUX01BU0spIHsKIAorCWNhc2UgU05EX1NPQ19EQUlG
TVRfTEVGVF9KOgorCQkvKiBsZWZ0LWp1c3RpZmllZCBmb3JtYXQgKi8KKwkJZnNfb3N5bmMgPSBT
U0NfRlNPU19QT1NJVElWRTsKKworCQlyY21yID0JICBTU0NfQkYoUkNNUl9TVFRETFksIDApCisJ
CQl8IFNTQ19CRihSQ01SX1NUQVJULCBTU0NfU1RBUlRfUklTSU5HX1JGKTsKKworCQl0Y21yID0J
ICBTU0NfQkYoVENNUl9TVFRETFksIDApCisJCQl8IFNTQ19CRihUQ01SX1NUQVJULCBTU0NfU1RB
UlRfUklTSU5HX1JGKTsKKworCQlicmVhazsKKwogCWNhc2UgU05EX1NPQ19EQUlGTVRfSTJTOgor
CQkvKiBJMlMgZm9ybWF0ID0gbGVmdC1qdXN0aWZpZWQgd2l0aCBzdGFydCBiaXQgYW5kIGludmVy
dGVkIExSQ0xLICovCiAJCWZzX29zeW5jID0gU1NDX0ZTT1NfTkVHQVRJVkU7CiAKIAkJcmNtciA9
CSAgU1NDX0JGKFJDTVJfU1RURExZLCAxKQotLSAKMi4yMC4xCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
