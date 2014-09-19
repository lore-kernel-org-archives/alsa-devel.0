From: Renu Tyagi <renu.tyagi@samsung.com>
Subject: [PATCH 4/11] rawmidi : close handle h
Date: Fri, 19 Sep 2014 10:23:36 +0000 (GMT)
Message-ID: <59.55.05230.8240C145@epcpsbgx3.samsung.com>
Reply-To: renu.tyagi@samsung.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by alsa0.perex.cz (Postfix) with ESMTP id BC940261B1B
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 12:23:41 +0200 (CEST)
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NC500EVV8VGHY50@mailout2.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 19 Sep 2014 19:23:40 +0900 (KST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="windows-1252"
MIME-Version: 1.0
Message-ID: <14839614.30521411122216219.JavaMail.weblogic@epv6ml10>

U2lnbmVkLW9mZi1ieTogcmVudSB0eWFnaSANCi0tLQ0Kc3JjL3Jhd21pZGkvcmF3bWlkaS5jIHwg
ICAgNSArKysrLQ0KMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9zcmMvcmF3bWlkaS9yYXdtaWRpLmMgYi9zcmMvcmF3bWlkaS9y
YXdtaWRpLmMNCmluZGV4IGI4MzViNDcuLmFjNjk5YjQgMTAwNjQ0DQotLS0gYS9zcmMvcmF3bWlk
aS9yYXdtaWRpLmMNCisrKyBiL3NyYy9yYXdtaWRpL3Jhd21pZGkuYw0KQEAgLTI1Niw4ICsyNTYs
MTEgQEAgc3RhdGljIGludCBzbmRfcmF3bWlkaV9vcGVuX2NvbmYoc25kX3Jhd21pZGlfdCAqKmlu
cHV0cCwgc25kX3Jhd21pZGlfdCAqKm91dHB1dHANCiAgICAgICAgICAgICAgICBzbmRfY29uZmln
X2RlbGV0ZSh0eXBlX2NvbmYpOw0KICAgICAgICBpZiAoZXJyID49IDApDQogICAgICAgICAgICAg
ICAgZXJyID0gb3Blbl9mdW5jKGlucHV0cCwgb3V0cHV0cCwgbmFtZSwgcmF3bWlkaV9yb290LCBy
YXdtaWRpX2NvbmYsIG1vZGUpOw0KLSAgICAgICBpZiAoZXJyIDwgMCkNCisgICAgICAgaWYgKGVy
ciA8IDApIHsNCisgICAgICAgICAgICAgICBpZiAoaCkNCisgICAgICAgICAgICAgICAgICAgICAg
IHNuZF9kbGNsb3NlKGgpOw0KICAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQorICAgICAgIH0N
CiAgICAgICAgaWYgKGlucHV0cCkgew0KICAgICAgICAgICAgICAgICgqaW5wdXRwKS0+ZGxfaGFu
ZGxlID0gaDsgaCA9IE5VTEw7DQogICAgICAgICAgICAgICAgc25kX3Jhd21pZGlfcGFyYW1zX2Rl
ZmF1bHQoKmlucHV0cCwgwrZtcyk7DQotLQ0KMS43LjE=


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY
Content-Type: application/octet-stream;
 name="patch_4.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch_4.patch"


CgpTaWduZWQtb2ZmLWJ5OiByZW51IHR5YWdpIDxyZW51LnR5YWdpQHNhbXN1bmcuY29tPgot
LS0KIHNyYy9yYXdtaWRpL3Jhd21pZGkuYyB8ICAgIDUgKysrKy0KIDEgZmlsZXMgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9y
YXdtaWRpL3Jhd21pZGkuYyBiL3NyYy9yYXdtaWRpL3Jhd21pZGkuYwppbmRleCBiODM1YjQ3
Li5hYzY5OWI0IDEwMDY0NAotLS0gYS9zcmMvcmF3bWlkaS9yYXdtaWRpLmMKKysrIGIvc3Jj
L3Jhd21pZGkvcmF3bWlkaS5jCkBAIC0yNTYsOCArMjU2LDExIEBAIHN0YXRpYyBpbnQgc25k
X3Jhd21pZGlfb3Blbl9jb25mKHNuZF9yYXdtaWRpX3QgKippbnB1dHAsIHNuZF9yYXdtaWRp
X3QgKipvdXRwdXRwCiAJCXNuZF9jb25maWdfZGVsZXRlKHR5cGVfY29uZik7CiAJaWYgKGVy
ciA+PSAwKQogCQllcnIgPSBvcGVuX2Z1bmMoaW5wdXRwLCBvdXRwdXRwLCBuYW1lLCByYXdt
aWRpX3Jvb3QsIHJhd21pZGlfY29uZiwgbW9kZSk7Ci0JaWYgKGVyciA8IDApCisJaWYgKGVy
ciA8IDApIHsKKwkJaWYgKGgpCisJCQlzbmRfZGxjbG9zZShoKTsKIAkJcmV0dXJuIGVycjsK
Kwl9CiAJaWYgKGlucHV0cCkgewogCQkoKmlucHV0cCktPmRsX2hhbmRsZSA9IGg7IGggPSBO
VUxMOwogCQlzbmRfcmF3bWlkaV9wYXJhbXNfZGVmYXVsdCgqaW5wdXRwLCAmcGFyYW1zKTsK
LS0gCjEuNy4xCgo=


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY--
