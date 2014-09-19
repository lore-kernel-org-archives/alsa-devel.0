From: Renu Tyagi <renu.tyagi@samsung.com>
Subject: [PATCH 3/11] sbase : fixed missing free
Date: Fri, 19 Sep 2014 10:23:07 +0000 (GMT)
Message-ID: <71.21.05030.B040C145@epcpsbgx4.samsung.com>
Reply-To: renu.tyagi@samsung.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AE13261A03
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 12:23:11 +0200 (CEST)
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NC500EUA8UKHY50@mailout2.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 19 Sep 2014 19:23:08 +0900 (KST)
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
Message-ID: <28338925.30481411122187172.JavaMail.weblogic@epv6ml10>

U2lnbmVkLW9mZi1ieTogcmVudSB0eWFnaSANCi0tLQ0KbW9kdWxlcy9taXhlci9zaW1wbGUvc2Jh
c2UuYyB8ICAgIDEgKw0KMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9tb2R1bGVzL21peGVyL3NpbXBsZS9zYmFzZS5jIGIvbW9k
dWxlcy9taXhlci9zaW1wbGUvc2Jhc2UuYw0KaW5kZXggOTdmZWVlOC4uYmIyZjU5ZCAxMDA2NDQN
Ci0tLSBhL21vZHVsZXMvbWl4ZXIvc2ltcGxlL3NiYXNlLmMNCisrKyBiL21vZHVsZXMvbWl4ZXIv
c2ltcGxlL3NiYXNlLmMNCkBAIC0zNzcsNiArMzc3LDcgQEAgc3RhdGljIGludCBzaW1wbGVfZXZl
bnRfYWRkMShzbmRfbWl4ZXJfY2xhc3NfdCAqY2xhc3MsDQogICAgICAgICAgICAgICAgaWYgKGN0
eXBlICE9IFNORF9DVExfRUxFTV9UWVBFX0JPT0xFQU4pIHsNCiAgICAgICAgICAgICAgICAgICAg
ICBfX2ludmFsaWRfdHlwZToNCiAgICAgICAgICAgICAgICAgICAgICAgIHNuZF9taXhlcl9zZWxl
bV9pZF9mcmVlKGlkKTsNCisgICAgICAgICAgICAgICAgICAgICAgIGZyZWUoaHNpbXBsZSk7DQog
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCiAgICAgICAgICAgICAgICB9
DQogICAgICAgICAgICAgICAgYnJlYWs7DQotLQ0KMS43LjE=


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY
Content-Type: application/octet-stream;
 name="patch_3.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch_3.patch"


CgpTaWduZWQtb2ZmLWJ5OiByZW51IHR5YWdpIDxyZW51LnR5YWdpQHNhbXN1bmcuY29tPgot
LS0KIG1vZHVsZXMvbWl4ZXIvc2ltcGxlL3NiYXNlLmMgfCAgICAxICsKIDEgZmlsZXMgY2hh
bmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL21v
ZHVsZXMvbWl4ZXIvc2ltcGxlL3NiYXNlLmMgYi9tb2R1bGVzL21peGVyL3NpbXBsZS9zYmFz
ZS5jCmluZGV4IDk3ZmVlZTguLmJiMmY1OWQgMTAwNjQ0Ci0tLSBhL21vZHVsZXMvbWl4ZXIv
c2ltcGxlL3NiYXNlLmMKKysrIGIvbW9kdWxlcy9taXhlci9zaW1wbGUvc2Jhc2UuYwpAQCAt
Mzc3LDYgKzM3Nyw3IEBAIHN0YXRpYyBpbnQgc2ltcGxlX2V2ZW50X2FkZDEoc25kX21peGVy
X2NsYXNzX3QgKmNsYXNzLAogCQlpZiAoY3R5cGUgIT0gU05EX0NUTF9FTEVNX1RZUEVfQk9P
TEVBTikgewogCQkgICAgICBfX2ludmFsaWRfdHlwZToKIAkJICAgICAgCXNuZF9taXhlcl9z
ZWxlbV9pZF9mcmVlKGlkKTsKKwkJCWZyZWUoaHNpbXBsZSk7CiAJCQlyZXR1cm4gLUVJTlZB
TDsKIAkJfQogCQlicmVhazsKLS0gCjEuNy4xCgo=


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY--
