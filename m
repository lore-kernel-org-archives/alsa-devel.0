From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH 2/5] ASoC: max98088: add OF support
Date: Tue, 25 Sep 2018 16:23:49 +0200
Message-ID: <20180925142352.24106-3-m.felsch@pengutronix.de>
References: <20180925142352.24106-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 866AF2678AC
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2018 16:24:21 +0200 (CEST)
In-Reply-To: <20180925142352.24106-1-m.felsch@pengutronix.de>
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

RnJvbTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgoKTUFYOTgwODggaXMgYW4g
b2xkZXIgdmVyc2lvbiBvZiB0aGUgTUFYOTgwODkgZGV2aWNlLgoKU2lnbmVkLW9mZi1ieTogQW5k
cmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgpbbS5mZWxzY2hAcGVuZ3V0cm9uaXguZGU6
IGFkZCBDT05GSUdfT0YgY29tcGlsZSBzd2l0Y2hdClttLmZlbHNjaEBwZW5ndXRyb25peC5kZTog
YWRhcHQgY29tbWl0IG1lc3NhZ2VdClNpZ25lZC1vZmYtYnk6IE1hcmNvIEZlbHNjaCA8bS5mZWxz
Y2hAcGVuZ3V0cm9uaXguZGU+Ci0tLQogc291bmQvc29jL2NvZGVjcy9tYXg5ODA4OC5jIHwgMTAg
KysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9zb3VuZC9zb2MvY29kZWNzL21heDk4MDg4LmMgYi9zb3VuZC9zb2MvY29kZWNzL21heDk4MDg4
LmMKaW5kZXggZmI1MTVhYWE1NGZjLi45NDUwZDVkOWM0OTIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3Nv
Yy9jb2RlY3MvbWF4OTgwODguYworKysgYi9zb3VuZC9zb2MvY29kZWNzL21heDk4MDg4LmMKQEAg
LTE3NDIsOSArMTc0MiwxOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgbWF4
OTgwODhfaTJjX2lkW10gPSB7CiB9OwogTU9EVUxFX0RFVklDRV9UQUJMRShpMmMsIG1heDk4MDg4
X2kyY19pZCk7CiAKKyNpZiBkZWZpbmVkKENPTkZJR19PRikKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
b2ZfZGV2aWNlX2lkIG1heDk4MDg4X29mX21hdGNoW10gPSB7CisJeyAuY29tcGF0aWJsZSA9ICJt
YXhpbSxtYXg5ODA4OCIgfSwKKwl7IC5jb21wYXRpYmxlID0gIm1heGltLG1heDk4MDg5IiB9LAor
CXsgfQorfTsKK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG1heDk4MDg4X29mX21hdGNoKTsKKyNl
bmRpZgorCiBzdGF0aWMgc3RydWN0IGkyY19kcml2ZXIgbWF4OTgwODhfaTJjX2RyaXZlciA9IHsK
IAkuZHJpdmVyID0gewogCQkubmFtZSA9ICJtYXg5ODA4OCIsCisJCS5vZl9tYXRjaF90YWJsZSA9
IG9mX21hdGNoX3B0cihtYXg5ODA4OF9vZl9tYXRjaCksCiAJfSwKIAkucHJvYmUgID0gbWF4OTgw
ODhfaTJjX3Byb2JlLAogCS5pZF90YWJsZSA9IG1heDk4MDg4X2kyY19pZCwKLS0gCjIuMTkuMAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
