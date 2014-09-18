From: Renu Tyagi <renu.tyagi@samsung.com>
Subject: Re: coverity fix in alsa-libs
Date: Thu, 18 Sep 2014 03:57:35 +0000 (GMT)
Message-ID: <86.74.04938.F285A145@epcpsbgx1.samsung.com>
Reply-To: renu.tyagi@samsung.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by alsa0.perex.cz (Postfix) with ESMTP id 003DC261683
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 05:57:39 +0200 (CEST)
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NC200LCRWC1IZE0@mailout4.samsung.com> for
 alsa-devel@alsa-project.org; Thu, 18 Sep 2014 12:57:37 +0900 (KST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="windows-1252"
MIME-Version: 1.0
Message-ID: <26983035.79381411012655765.JavaMail.weblogic@epv6ml12>

SGksIA0KDQpTb3JyeSBmb3IgdGhlIHNwYW0gbWFpbC4gSSBhbSBzZW5kaW5nIHRoZSBtYWlsIGlu
IHBsYWluIHRleHQgbm93Lg0KUEZBIHBhdGNoLiANCkZpbGUgaW4gd2hpY2ggY2hhbmdlcyBhcmUg
YmVpbmcgbWFkZSA6IHJhd21pZGkuYw0KQnVnIHR5cGUgLSBIYW5kbGUgaCB0byBiZSBjbG9zZWQg
aW4gY2FzZSBvZiBlcnJvciBiZWZvcmUgcmV0dXJuaW5nIA0KTWVhbndoaWxlIEkgYW0gbG9va2lu
ZyBpbnRvIHRoZSBtYXR0ZXIgd2h5IG15IG1haWxzIGFyZSBub3QgdmlzaWJsZSBpbiBNTC4NCg0K
VGhhbmtzIA0KUmVudSBUeWFnaSA=


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY
Content-Type: application/octet-stream;
 name="patch_22578.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch_22578.patch"


RnJvbSBlYTZlYTE0NTJiMDM2OGMyNWNlNDFlYTQ0MzRjMjlkNTUzOTEyZmUzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiByZW51NTU1IDxyZW51LnR5YWdpQHNhbXN1bmcuY29t
PgpEYXRlOiBXZWQsIDE3IFNlcCAyMDE0IDE2OjQ1OjI3ICswNTMwClN1YmplY3Q6IFtQQVRD
SCAxLzhdIEhhbmRsZSBoIHRvIGJlIGNsb3NlZCBpbiBjYXNlIG9mIGVycm9yIGJlZm9yZSBy
ZXR1cm5pbmcKCgpTaWduZWQtb2ZmLWJ5OiByZW51NTU1IDxyZW51LnR5YWdpQHNhbXN1bmcu
Y29tPgotLS0KIHNyYy9yYXdtaWRpL3Jhd21pZGkuYyB8ICAgIDUgKysrKy0KIDEgZmlsZXMg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3NyYy9yYXdtaWRpL3Jhd21pZGkuYyBiL3NyYy9yYXdtaWRpL3Jhd21pZGkuYwppbmRleCBi
ODM1YjQ3Li4wY2E1ZDFmIDEwMDY0NAotLS0gYS9zcmMvcmF3bWlkaS9yYXdtaWRpLmMKKysr
IGIvc3JjL3Jhd21pZGkvcmF3bWlkaS5jCkBAIC0yNTYsOCArMjU2LDExIEBAIHN0YXRpYyBp
bnQgc25kX3Jhd21pZGlfb3Blbl9jb25mKHNuZF9yYXdtaWRpX3QgKippbnB1dHAsIHNuZF9y
YXdtaWRpX3QgKipvdXRwdXRwCiAJCXNuZF9jb25maWdfZGVsZXRlKHR5cGVfY29uZik7CiAJ
aWYgKGVyciA+PSAwKQogCQllcnIgPSBvcGVuX2Z1bmMoaW5wdXRwLCBvdXRwdXRwLCBuYW1l
LCByYXdtaWRpX3Jvb3QsIHJhd21pZGlfY29uZiwgbW9kZSk7Ci0JaWYgKGVyciA8IDApCisJ
aWYgKGVyciA8IDApeworCQlpZiAoaCkKKwkJCXNuZF9kbGNsb3NlKGgpOwogCQlyZXR1cm4g
ZXJyOworCX0KIAlpZiAoaW5wdXRwKSB7CiAJCSgqaW5wdXRwKS0+ZGxfaGFuZGxlID0gaDsg
aCA9IE5VTEw7CiAJCXNuZF9yYXdtaWRpX3BhcmFtc19kZWZhdWx0KCppbnB1dHAsICZwYXJh
bXMpOwotLSAKMS43LjEKCg==


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY--
