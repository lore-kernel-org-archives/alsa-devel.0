From: Stas Sergeev <stsp@list.ru>
Subject: [PATCH] ASoC: define playback and capture streams in
	dummy codec
Date: Fri, 12 Apr 2013 14:53:56 +0400
Message-ID: <5167E7C4.7080501@list.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000801080803070904000003"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp34.i.mail.ru (smtp34.i.mail.ru [94.100.177.94])
 by alsa0.perex.cz (Postfix) with ESMTP id BE63726160D
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2013 12:54:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, "Gabriel M. Beddingfield" <gabrbedd@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000801080803070904000003
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi.

This patch adds a playback and capture streams to the dummy codec DAI
configuration. Most permissive set of sampling rates and formats is used.

Signed-off-by: Stas Sergeev <stsp@users.sourceforge.net>

--------------000801080803070904000003
Content-Type: application/x-patch;
 name="0001-ASoC-define-playback-and-capture-streams-in-dummy-co.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename*0="0001-ASoC-define-playback-and-capture-streams-in-dummy-co.pa";
 filename*1="tch"

RnJvbSAyMjgxM2IyMTI0ZDgxZDhkZTVjZGUxOWE0ZTJmOTQ5MGJkMjNiYWFiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGFzIFNlcmdlZXYgPHN0c3BAdXNlcnMuc291cmNl
Zm9yZ2UubmV0PgpEYXRlOiBUaHUsIDExIEFwciAyMDEzIDE5OjA3OjIwICswNDAwClN1Ympl
Y3Q6IFtQQVRDSF0gQVNvQzogZGVmaW5lIHBsYXliYWNrIGFuZCBjYXB0dXJlIHN0cmVhbXMg
aW4gZHVtbXkgY29kZWMKClRoaXMgcGF0Y2ggYWRkcyBhIHBsYXliYWNrIGFuZCBjYXB0dXJl
IHN0cmVhbXMgdG8gdGhlIGR1bW15IGNvZGVjIERBSQpjb25maWd1cmF0aW9uLiBNb3N0IHBl
cm1pc3NpdmUgc2V0IG9mIHNhbXBsaW5nIHJhdGVzIGFuZCBmb3JtYXRzIGlzIHVzZWQuCgpT
aWduZWQtb2ZmLWJ5OiBTdGFzIFNlcmdlZXYgPHN0c3BAdXNlcnMuc291cmNlZm9yZ2UubmV0
PgotLS0KIHNvdW5kL3NvYy9zb2MtdXRpbHMuYyB8IDI1ICsrKysrKysrKysrKysrKysrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
c291bmQvc29jL3NvYy11dGlscy5jIGIvc291bmQvc29jL3NvYy11dGlscy5jCmluZGV4IGZl
NDU0MWQuLmJmMWY5MmEgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9zb2MtdXRpbHMuYworKysg
Yi9zb3VuZC9zb2Mvc29jLXV0aWxzLmMKQEAgLTkwLDggKzkwLDMzIEBAIHN0YXRpYyBzdHJ1
Y3Qgc25kX3NvY19wbGF0Zm9ybV9kcml2ZXIgZHVtbXlfcGxhdGZvcm0gPSB7CiB9OwogCiBz
dGF0aWMgc3RydWN0IHNuZF9zb2NfY29kZWNfZHJpdmVyIGR1bW15X2NvZGVjOworCisjZGVm
aW5lIFNUVUJfUkFURVMJU05EUlZfUENNX1JBVEVfODAwMF8xOTIwMDAKKyNkZWZpbmUgU1RV
Ql9GT1JNQVRTCShTTkRSVl9QQ01fRk1UQklUX1M4IHwgXAorCQkJU05EUlZfUENNX0ZNVEJJ
VF9VOCB8IFwKKwkJCVNORFJWX1BDTV9GTVRCSVRfUzE2X0xFIHwgXAorCQkJU05EUlZfUENN
X0ZNVEJJVF9VMTZfTEUgfCBcCisJCQlTTkRSVl9QQ01fRk1UQklUX1MyNF9MRSB8IFwKKwkJ
CVNORFJWX1BDTV9GTVRCSVRfVTI0X0xFIHwgXAorCQkJU05EUlZfUENNX0ZNVEJJVF9TMzJf
TEUgfCBcCisJCQlTTkRSVl9QQ01fRk1UQklUX1UzMl9MRSB8IFwKKwkJCVNORFJWX1BDTV9G
TVRCSVRfSUVDOTU4X1NVQkZSQU1FX0xFKQogc3RhdGljIHN0cnVjdCBzbmRfc29jX2RhaV9k
cml2ZXIgZHVtbXlfZGFpID0gewogCS5uYW1lID0gInNuZC1zb2MtZHVtbXktZGFpIiwKKwku
cGxheWJhY2sgCT0geworCQkuc3RyZWFtX25hbWUJPSAiUGxheWJhY2siLAorCQkuY2hhbm5l
bHNfbWluCT0gMSwKKwkJLmNoYW5uZWxzX21heAk9IDM4NCwKKwkJLnJhdGVzCQk9IFNUVUJf
UkFURVMsCisJCS5mb3JtYXRzCT0gU1RVQl9GT1JNQVRTLAorCX0sCisJLmNhcHR1cmUgPSB7
CisJCS5zdHJlYW1fbmFtZSA9ICJDYXB0dXJlIiwKKwkJLmNoYW5uZWxzX21pbgk9IDEsCisJ
CS5jaGFubmVsc19tYXgJPSAzODQsCisJCS5yYXRlcyA9IFNUVUJfUkFURVMsCisJCS5mb3Jt
YXRzID0gU1RVQl9GT1JNQVRTLAorCSB9LAogfTsKIAogc3RhdGljIGludCBzbmRfc29jX2R1
bW15X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCi0tIAoxLjcuMTEuNwoK

--------------000801080803070904000003
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000801080803070904000003--
