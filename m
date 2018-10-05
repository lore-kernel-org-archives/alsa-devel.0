From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH v2 2/5] ASoC: max98088: add OF support
Date: Fri,  5 Oct 2018 09:58:09 +0200
Message-ID: <20181005075812.13986-3-m.felsch@pengutronix.de>
References: <20181005075812.13986-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 50601267906
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 09:58:26 +0200 (CEST)
In-Reply-To: <20181005075812.13986-1-m.felsch@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

RnJvbTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgoKTUFYOTgwODggaXMganVz
dCBhbiBvbGRlciB2ZXJzaW9uIG9mIHRoZSBNQVg5ODA4OSBkZXZpY2UuIEJvdGggZGV2aWNlcwpo
YXZlIHRoZSBzYW1lIGNhcGFiaWxpdGllcy4gVGhlcmUgaXMgb25seSBvbmUgbWlub3IgZGlmZmVy
ZW5jZSBpbiBKQUNLCmRldGVjdGlvbiBhbmQgdGhlIHJlbGF0ZWQgcG93ZXItc2F2ZSBtb2RpLCBi
dXQgdGhlIE1BWDk4MDg5IGlzIGJhY2t3YXJkCmNvbXBhdGlibGUgdG8gdGhlIE1BWDk4MDg4LgoK
U2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgpbbS5mZWxz
Y2hAcGVuZ3V0cm9uaXguZGU6IGFkZCBDT05GSUdfT0YgY29tcGlsZSBzd2l0Y2hdClttLmZlbHNj
aEBwZW5ndXRyb25peC5kZTogYWRhcHQgY29tbWl0IG1lc3NhZ2VdClNpZ25lZC1vZmYtYnk6IE1h
cmNvIEZlbHNjaCA8bS5mZWxzY2hAcGVuZ3V0cm9uaXguZGU+Ci0tLQogc291bmQvc29jL2NvZGVj
cy9tYXg5ODA4OC5jIHwgMTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL21heDk4MDg4LmMgYi9zb3VuZC9z
b2MvY29kZWNzL21heDk4MDg4LmMKaW5kZXggZmI1MTVhYWE1NGZjLi45NDUwZDVkOWM0OTIgMTAw
NjQ0Ci0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvbWF4OTgwODguYworKysgYi9zb3VuZC9zb2MvY29k
ZWNzL21heDk4MDg4LmMKQEAgLTE3NDIsOSArMTc0MiwxOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGkyY19kZXZpY2VfaWQgbWF4OTgwODhfaTJjX2lkW10gPSB7CiB9OwogTU9EVUxFX0RFVklDRV9U
QUJMRShpMmMsIG1heDk4MDg4X2kyY19pZCk7CiAKKyNpZiBkZWZpbmVkKENPTkZJR19PRikKK3N0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG1heDk4MDg4X29mX21hdGNoW10gPSB7CisJ
eyAuY29tcGF0aWJsZSA9ICJtYXhpbSxtYXg5ODA4OCIgfSwKKwl7IC5jb21wYXRpYmxlID0gIm1h
eGltLG1heDk4MDg5IiB9LAorCXsgfQorfTsKK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG1heDk4
MDg4X29mX21hdGNoKTsKKyNlbmRpZgorCiBzdGF0aWMgc3RydWN0IGkyY19kcml2ZXIgbWF4OTgw
ODhfaTJjX2RyaXZlciA9IHsKIAkuZHJpdmVyID0gewogCQkubmFtZSA9ICJtYXg5ODA4OCIsCisJ
CS5vZl9tYXRjaF90YWJsZSA9IG9mX21hdGNoX3B0cihtYXg5ODA4OF9vZl9tYXRjaCksCiAJfSwK
IAkucHJvYmUgID0gbWF4OTgwODhfaTJjX3Byb2JlLAogCS5pZF90YWJsZSA9IG1heDk4MDg4X2ky
Y19pZCwKLS0gCjIuMTkuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCg==
