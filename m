From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] ASoC: simplify registration of snd-soc-dummy
	device
Date: Fri, 17 May 2013 11:26:15 +0200
Message-ID: <1368782775-28517-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id AE1A62602C6
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2013 11:26:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRy
b25peC5kZT4KLS0tCiBzb3VuZC9zb2Mvc29jLXV0aWxzLmMgfCAxMyArKysrLS0tLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3NvdW5kL3NvYy9zb2MtdXRpbHMuYyBiL3NvdW5kL3NvYy9zb2MtdXRpbHMuYwppbmRleCA0
YjNiZTZjLi4yOWIyMTFlIDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mvc29jLXV0aWxzLmMKKysrIGIv
c291bmQvc29jL3NvYy11dGlscy5jCkBAIC0xNTksMTUgKzE1OSwxMCBAQCBpbnQgX19pbml0IHNu
ZF9zb2NfdXRpbF9pbml0KHZvaWQpCiB7CiAJaW50IHJldDsKIAotCXNvY19kdW1teV9kZXYgPSBw
bGF0Zm9ybV9kZXZpY2VfYWxsb2MoInNuZC1zb2MtZHVtbXkiLCAtMSk7Ci0JaWYgKCFzb2NfZHVt
bXlfZGV2KQotCQlyZXR1cm4gLUVOT01FTTsKLQotCXJldCA9IHBsYXRmb3JtX2RldmljZV9hZGQo
c29jX2R1bW15X2Rldik7Ci0JaWYgKHJldCAhPSAwKSB7Ci0JCXBsYXRmb3JtX2RldmljZV9wdXQo
c29jX2R1bW15X2Rldik7Ci0JCXJldHVybiByZXQ7Ci0JfQorCXNvY19kdW1teV9kZXYgPQorCQlw
bGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXJfc2ltcGxlKCJzbmQtc29jLWR1bW15IiwgLTEsIE5VTEws
IDApOworCWlmIChJU19FUlIoc29jX2R1bW15X2RldikpCisJCXJldHVybiBQVFJfRVJSKHNvY19k
dW1teV9kZXYpOwogCiAJcmV0ID0gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZzb2NfZHVtbXlf
ZHJpdmVyKTsKIAlpZiAocmV0ICE9IDApCi0tIAoxLjguMi4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
