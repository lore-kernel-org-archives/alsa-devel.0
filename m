From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] SoC: max98357a: use flags argument of
	devm_gpiod_get to set direction
Date: Tue, 19 May 2015 08:58:09 +0200
Message-ID: <1432018689-7124-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id EBF5C264F07
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 08:58:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

U2luY2UgMzliMmJiZTNkNzE1IChncGlvOiBhZGQgZmxhZ3MgYXJndW1lbnQgdG8gZ3Bpb2RfZ2V0
KigpIGZ1bmN0aW9ucykKd2hpY2ggYXBwZWFyZWQgaW4gdjMuMTctcmMxLCB0aGUgZ3Bpb2RfZ2V0
KiBmdW5jdGlvbnMgdGFrZSBhbiBhZGRpdGlvbmFsCnBhcmFtZXRlciB0aGF0IGFsbG93cyB0byBz
cGVjaWZ5IGRpcmVjdGlvbiBhbmQgaW5pdGlhbCB2YWx1ZSBmb3Igb3V0cHV0LgoKVXNlIHRoaXMg
dG8gc2ltcGxpZnkgdGhlIGRyaXZlci4gRnVydGhlcm1vcmUgdGhpcyBpcyBvbmUgY2FsbGVyIGxl
c3MKdGhhdCBzdG9wcyB1cyBtYWtpbmcgdGhlIGZsYWdzIGFyZ3VtZW50IHRvIGdwaW9kX2dldCoo
KSBtYW5kYXRvcnkuCgpGaXhlczogYWY1YWRmMTI5MzY5ICgiQVNvQzogbWF4OTgzNTdhOiBBZGQg
TUFYOTgzNTdBIGNvZGVjIGRyaXZlciIpClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmln
IDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+Ci0tLQogc291bmQvc29jL2NvZGVjcy9t
YXg5ODM1N2EuYyB8IDMgKy0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9tYXg5ODM1N2EuYyBiL3Nv
dW5kL3NvYy9jb2RlY3MvbWF4OTgzNTdhLmMKaW5kZXggYmYzZTkzM2VlODk1Li4zYTJmZGEwOGE4
OTMgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvbWF4OTgzNTdhLmMKKysrIGIvc291bmQv
c29jL2NvZGVjcy9tYXg5ODM1N2EuYwpAQCAtNjAsMTMgKzYwLDEyIEBAIHN0YXRpYyBpbnQgbWF4
OTgzNTdhX2NvZGVjX3Byb2JlKHN0cnVjdCBzbmRfc29jX2NvZGVjICpjb2RlYykKIHsKIAlzdHJ1
Y3QgZ3Bpb19kZXNjICpzZG1vZGU7CiAKLQlzZG1vZGUgPSBkZXZtX2dwaW9kX2dldChjb2RlYy0+
ZGV2LCAic2Rtb2RlIik7CisJc2Rtb2RlID0gZGV2bV9ncGlvZF9nZXQoY29kZWMtPmRldiwgInNk
bW9kZSIsIEdQSU9EX09VVF9MT1cpOwogCWlmIChJU19FUlIoc2Rtb2RlKSkgewogCQlkZXZfZXJy
KGNvZGVjLT5kZXYsICIlcygpIHVuYWJsZSB0byBnZXQgc2Rtb2RlIEdQSU86ICVsZFxuIiwKIAkJ
CQlfX2Z1bmNfXywgUFRSX0VSUihzZG1vZGUpKTsKIAkJcmV0dXJuIFBUUl9FUlIoc2Rtb2RlKTsK
IAl9Ci0JZ3Bpb2RfZGlyZWN0aW9uX291dHB1dChzZG1vZGUsIDApOwogCXNuZF9zb2NfY29kZWNf
c2V0X2RydmRhdGEoY29kZWMsIHNkbW9kZSk7CiAKIAlyZXR1cm4gMDsKLS0gCjIuMS40CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1h
aWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxz
YS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
