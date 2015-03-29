From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/4] ASoC: fsi: mark several data structures as
	const
Date: Sun, 29 Mar 2015 21:47:15 +0200
Message-ID: <1427658437-23136-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1427658437-23136-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4A1A426042F
 for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2015 21:47:39 +0200 (CEST)
In-Reply-To: <1427658437-23136-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

QSBkcml2ZXIncyBwbGF0Zm9ybV9kZXZpY2VfaWQsIG9mX2RldmljZV9pZCBhbmQgZGV2aWNlIGRh
dGEgc2hvdWxkIGFuZApjYW4gYmUgY29uc3QuCgpTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvD
tm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgotLS0KIHNvdW5kL3NvYy9zaC9m
c2kuYyB8IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL3NoL2ZzaS5jIGIvc291bmQvc29jL3No
L2ZzaS5jCmluZGV4IGRhYjZhYTY2MWEyMi4uNTgyN2MwZWI2YjkwIDEwMDY0NAotLS0gYS9zb3Vu
ZC9zb2Mvc2gvZnNpLmMKKysrIGIvc291bmQvc29jL3NoL2ZzaS5jCkBAIC0xODc2LDcgKzE4NzYs
NyBAQCBzdGF0aWMgdm9pZCBmc2lfaGFuZGxlcl9pbml0KHN0cnVjdCBmc2lfcHJpdiAqZnNpLAog
CX0KIH0KIAotc3RhdGljIHN0cnVjdCBmc2lfY29yZSBmc2kxX2NvcmUgPSB7CitzdGF0aWMgY29u
c3Qgc3RydWN0IGZzaV9jb3JlIGZzaTFfY29yZSA9IHsKIAkudmVyCT0gMSwKIAogCS8qIEludGVy
cnVwdCAqLwpAQCAtMTg4NSw3ICsxODg1LDcgQEAgc3RhdGljIHN0cnVjdCBmc2lfY29yZSBmc2kx
X2NvcmUgPSB7CiAJLmltc2sJPSBJTVNLLAogfTsKIAotc3RhdGljIHN0cnVjdCBmc2lfY29yZSBm
c2kyX2NvcmUgPSB7CitzdGF0aWMgY29uc3Qgc3RydWN0IGZzaV9jb3JlIGZzaTJfY29yZSA9IHsK
IAkudmVyCT0gMiwKIAogCS8qIEludGVycnVwdCAqLwpAQCAtMTg5NiwxNCArMTg5NiwxNCBAQCBz
dGF0aWMgc3RydWN0IGZzaV9jb3JlIGZzaTJfY29yZSA9IHsKIAkuYl9tY2xrCT0gQl9NU1RfQ1RM
UiwKIH07CiAKLXN0YXRpYyBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGZzaV9vZl9tYXRjaFtdID0gewor
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgZnNpX29mX21hdGNoW10gPSB7CiAJeyAu
Y29tcGF0aWJsZSA9ICJyZW5lc2FzLHNoX2ZzaSIsCS5kYXRhID0gJmZzaTFfY29yZX0sCiAJeyAu
Y29tcGF0aWJsZSA9ICJyZW5lc2FzLHNoX2ZzaTIiLAkuZGF0YSA9ICZmc2kyX2NvcmV9LAogCXt9
LAogfTsKIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGZzaV9vZl9tYXRjaCk7CiAKLXN0YXRpYyBz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lkIGZzaV9pZF90YWJsZVtdID0geworc3RhdGljIGNvbnN0
IHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2VfaWQgZnNpX2lkX3RhYmxlW10gPSB7CiAJeyAic2hfZnNp
IiwJKGtlcm5lbF91bG9uZ190KSZmc2kxX2NvcmUgfSwKIAl7ICJzaF9mc2kyIiwJKGtlcm5lbF91
bG9uZ190KSZmc2kyX2NvcmUgfSwKIAl7fSwKLS0gCjIuMS40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
