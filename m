From: Renu Tyagi <renu.tyagi@samsung.com>
Subject: [PATCH 6/11] simple_abst : null check for lib
Date: Fri, 19 Sep 2014 11:04:55 +0000 (GMT)
Message-ID: <9B.C4.05030.7DD0C145@epcpsbgx4.samsung.com>
Reply-To: renu.tyagi@samsung.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by alsa0.perex.cz (Postfix) with ESMTP id C9E66261A50
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 13:04:57 +0200 (CEST)
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NC500IIUAS71Q40@mailout2.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 19 Sep 2014 20:04:55 +0900 (KST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="windows-1252"
MIME-Version: 1.0
Message-ID: <8784019.31151411124694973.JavaMail.weblogic@epv6ml10>

U2lnbmVkLW9mZi1ieTogcmVudSB0eWFnaSA8cmVudS50eWFnaUBzYW1zdW5nLmNvbT4NCi0tLQ0K
IHNyYy9taXhlci9zaW1wbGVfYWJzdC5jIHwgICAgMiArKw0KIDEgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvc3JjL21peGVyL3Np
bXBsZV9hYnN0LmMgYi9zcmMvbWl4ZXIvc2ltcGxlX2Fic3QuYw0KaW5kZXggOWU5YWFmNS4uNTI5
NzQ3MiAxMDA2NDQNCi0tLSBhL3NyYy9taXhlci9zaW1wbGVfYWJzdC5jDQorKysgYi9zcmMvbWl4
ZXIvc2ltcGxlX2Fic3QuYw0KQEAgLTcwLDYgKzcwLDggQEAgc3RhdGljIGludCB0cnlfb3Blbihz
bmRfbWl4ZXJfY2xhc3NfdCAqY2xhc3MsIGNvbnN0IGNoYXIgKmxpYikNCiAgICAgICAgdm9pZCAq
aDsNCiAgICAgICAgaW50IGVyciA9IDA7DQoNCisgICAgICAgaWYgKCFsaWIpDQorICAgICAgICAg
ICAgICAgcmV0dXJuIC1FTlhJTzsNCiAgICAgICAgcGF0aCA9IGdldGVudigiQUxTQV9NSVhFUl9T
SU1QTEVfTU9EVUxFUyIpOw0KICAgICAgICBpZiAoIXBhdGgpDQogICAgICAgICAgICAgICAgcGF0
aCA9IFNPX1BBVEg7DQotLQ0KMS43LjENCg==


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY
Content-Type: application/octet-stream;
 name="patch_6.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch_6.patch"


CgpTaWduZWQtb2ZmLWJ5OiByZW51IHR5YWdpIDxyZW51LnR5YWdpQHNhbXN1bmcuY29tPgot
LS0KIHNyYy9taXhlci9zaW1wbGVfYWJzdC5jIHwgICAgMiArKwogMSBmaWxlcyBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL21p
eGVyL3NpbXBsZV9hYnN0LmMgYi9zcmMvbWl4ZXIvc2ltcGxlX2Fic3QuYwppbmRleCA5ZTlh
YWY1Li41Mjk3NDcyIDEwMDY0NAotLS0gYS9zcmMvbWl4ZXIvc2ltcGxlX2Fic3QuYworKysg
Yi9zcmMvbWl4ZXIvc2ltcGxlX2Fic3QuYwpAQCAtNzAsNiArNzAsOCBAQCBzdGF0aWMgaW50
IHRyeV9vcGVuKHNuZF9taXhlcl9jbGFzc190ICpjbGFzcywgY29uc3QgY2hhciAqbGliKQog
CXZvaWQgKmg7CiAJaW50IGVyciA9IDA7CiAKKwlpZiAoIWxpYikKKwkJcmV0dXJuIC1FTlhJ
TzsKIAlwYXRoID0gZ2V0ZW52KCJBTFNBX01JWEVSX1NJTVBMRV9NT0RVTEVTIik7CiAJaWYg
KCFwYXRoKQogCQlwYXRoID0gU09fUEFUSDsKLS0gCjEuNy4xCgo=


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY--
