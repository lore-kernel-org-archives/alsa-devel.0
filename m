From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 4/4] ASoC: mark of_device_id and device data
	as constant
Date: Tue, 31 Mar 2015 16:48:59 +0200
Message-ID: <1427813339-23817-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1427813339-23817-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 5916E264F53
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 16:49:41 +0200 (CEST)
In-Reply-To: <1427813339-23817-1-git-send-email-u.kleine-koenig@pengutronix.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Fabian Frederick <fabf@skynet.be>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

QSBkcml2ZXIncyBvZl9kZXZpY2VfaWQgYW5kIGRldmljZSBkYXRhIHNob3VsZCBhbmQgY2FuIGJl
IGNvbnN0LgoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5p
Z0BwZW5ndXRyb25peC5kZT4KLS0tCiBzb3VuZC9zb2Mvc2gvcmNhci9jb3JlLmMgfCA0ICsrLS0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvc291bmQvc29jL3NoL3JjYXIvY29yZS5jIGIvc291bmQvc29jL3NoL3JjYXIvY29yZS5j
CmluZGV4IDNkOGU0ZDYwYzgzZC4uOWY0OGQ3NWZhOTkyIDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mv
c2gvcmNhci9jb3JlLmMKKysrIGIvc291bmQvc29jL3NoL3JjYXIvY29yZS5jCkBAIC05OSwxMSAr
OTksMTEgQEAKICNkZWZpbmUgUlNORF9SQVRFUyBTTkRSVl9QQ01fUkFURV84MDAwXzk2MDAwCiAj
ZGVmaW5lIFJTTkRfRk1UUyAoU05EUlZfUENNX0ZNVEJJVF9TMjRfTEUgfCBTTkRSVl9QQ01fRk1U
QklUX1MxNl9MRSkKIAotc3RhdGljIHN0cnVjdCByc25kX29mX2RhdGEgcnNuZF9vZl9kYXRhX2dl
bjEgPSB7CitzdGF0aWMgY29uc3Qgc3RydWN0IHJzbmRfb2ZfZGF0YSByc25kX29mX2RhdGFfZ2Vu
MSA9IHsKIAkuZmxhZ3MgPSBSU05EX0dFTjEsCiB9OwogCi1zdGF0aWMgc3RydWN0IHJzbmRfb2Zf
ZGF0YSByc25kX29mX2RhdGFfZ2VuMiA9IHsKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcnNuZF9vZl9k
YXRhIHJzbmRfb2ZfZGF0YV9nZW4yID0gewogCS5mbGFncyA9IFJTTkRfR0VOMiwKIH07CiAKLS0g
CjIuMS40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
