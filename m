From: =?UTF-8?q?Ga=C3=ABtan=20Carlier?= <gcembed@gmail.com>
Subject: [PATCH 1/1] [ASoC] Fix v2: Revert 'ASoC: imx-ssi:
	Remove mono support'.
Date: Thu,  6 Sep 2012 08:25:53 +0200
Message-ID: <1346912753-2030-1-git-send-email-gcembed@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 32B8A26031A
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 08:28:14 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so925987wgb.20
 for <alsa-devel@alsa-project.org>; Wed, 05 Sep 2012 23:28:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Javier Martin <javier.martin@vista-silicon.com>, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Ga=C3=ABtan=20Carlier?= <gcembed@gmail.com>
List-Id: alsa-devel@alsa-project.org

V2hlbiBwYXRjaCBvZiBKYXZpZXIgTWFydGluIGlzIGFwcGxpZWQgb24gbGludXgtbmV4dC0yMDEy
MDgyNAp0aGUgcGF0Y2ggZmFpbGVkIGJlY2F1c2UgY29tbWVudCBsaW5lIGlzIG1pc3NpbmcuCgpT
aWduZWQtb2ZmLWJ5OiBHYcOrdGFuIENhcmxpZXIgPGdjZW1iZWRAZ21haWwuY29tPgpTaWduZWQt
b2ZmLWJ5OiBKYXZpZXIgTWFydGluIDxqYXZpZXIubWFydGluQHZpc3RhLXNpbGljb24uY29tPgot
LS0KIHNvdW5kL3NvYy9mc2wvaW14LXNzaS5jIHwgICAgNSArKy0tLQogMSBmaWxlcyBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29j
L2ZzbC9pbXgtc3NpLmMgYi9zb3VuZC9zb2MvZnNsL2lteC1zc2kuYwppbmRleCA3MDc0YWU2Li4z
YzUyMGM0IDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvZnNsL2lteC1zc2kuYworKysgYi9zb3VuZC9z
b2MvZnNsL2lteC1zc2kuYwpAQCAtMzgwLDE0ICszODAsMTMgQEAgc3RhdGljIGludCBpbXhfc3Np
X2RhaV9wcm9iZShzdHJ1Y3Qgc25kX3NvY19kYWkgKmRhaSkKIHN0YXRpYyBzdHJ1Y3Qgc25kX3Nv
Y19kYWlfZHJpdmVyIGlteF9zc2lfZGFpID0gewogCS5wcm9iZSA9IGlteF9zc2lfZGFpX3Byb2Jl
LAogCS5wbGF5YmFjayA9IHsKLQkJLyogVGhlIFNTSSBkb2VzIG5vdCBzdXBwb3J0IG1vbmF1cmFs
IGF1ZGlvLiAqLwotCQkuY2hhbm5lbHNfbWluID0gMiwKKwkJLmNoYW5uZWxzX21pbiA9IDEsCiAJ
CS5jaGFubmVsc19tYXggPSAyLAogCQkucmF0ZXMgPSBTTkRSVl9QQ01fUkFURV84MDAwXzk2MDAw
LAogCQkuZm9ybWF0cyA9IFNORFJWX1BDTV9GTVRCSVRfUzE2X0xFLAogCX0sCiAJLmNhcHR1cmUg
PSB7Ci0JCS5jaGFubmVsc19taW4gPSAyLAorCQkuY2hhbm5lbHNfbWluID0gMSwKIAkJLmNoYW5u
ZWxzX21heCA9IDIsCiAJCS5yYXRlcyA9IFNORFJWX1BDTV9SQVRFXzgwMDBfOTYwMDAsCiAJCS5m
b3JtYXRzID0gU05EUlZfUENNX0ZNVEJJVF9TMTZfTEUsCi0tIAoxLjcuNy40CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
