From: yokota.hgml@gmail.com
Subject: [PATCH] ALSA: hda/realtek - Add Panasonic CF-SZ6
	headset jack quirk
Date: Mon, 16 Jul 2018 17:10:45 +0900
Message-ID: <CA+0c0dVT4v5bkkWXn6sLPL9ac29Sjxiz4qV+ypbHhDJ=uaDdvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000e3e62a0571195d49"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A69C2673ED
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 10:10:47 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so14862110wmc.1
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 01:10:47 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

--000000000000e3e62a0571195d49
Content-Type: text/plain; charset="UTF-8"

 This adds some required quirk when uses headset or headphone on
Panasonic CF-SZ6.

Signed-off-by: YOKOTA Hiroshi <yokota.hgml@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

--000000000000e3e62a0571195d49
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-ALSA-hda-realtek-Add-Panasonic-CF-SZ6-headset-jack-q.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-realtek-Add-Panasonic-CF-SZ6-headset-jack-q.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jjnzbes00

RnJvbSAzN2ZjM2VhMDQ2OTExMjRjOTJhOGQ2Mjg1NjBiOTcyZWIyMTVjN2U4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZT0tPVEEgSGlyb3NoaSA8eW9rb3RhLmhnbWxAZ21haWwuY29t
PgpEYXRlOiBTdW4sIDEgSnVsIDIwMTggMTg6MzA6MDEgKzA5MDAKU3ViamVjdDogW1BBVENIXSBB
TFNBOiBoZGEvcmVhbHRlayAtIEFkZCBQYW5hc29uaWMgQ0YtU1o2IGhlYWRzZXQgamFjayBxdWly
awoKIFRoaXMgYWRkcyBzb21lIHJlcXVpcmVkIHF1aXJrIHdoZW4gdXNlcyBoZWFkc2V0IG9yIGhl
YWRwaG9uZSBvbgpQYW5hc29uaWMgQ0YtU1o2LgoKU2lnbmVkLW9mZi1ieTogWU9LT1RBIEhpcm9z
aGkgPHlva290YS5oZ21sQGdtYWlsLmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0
ZWsuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEv
c291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0
ZWsuYwppbmRleCA2NjY3MTNlMS4uZGI2MjVkMDAgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEv
cGF0Y2hfcmVhbHRlay5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCkBAIC02
NTEzLDYgKzY1MTMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9wY2lfcXVpcmsgYWxjMjY5
X2ZpeHVwX3RibFtdID0gewogCVNORF9QQ0lfUVVJUksoMHgxMGNmLCAweDE2MjksICJMaWZlYm9v
ayBVN3g3IiwgQUxDMjU1X0ZJWFVQX0xJRkVCT09LX1U3eDdfSEVBRFNFVF9NSUMpLAogCVNORF9Q
Q0lfUVVJUksoMHgxMGNmLCAweDE4NDUsICJMaWZlYm9vayBVOTA0IiwgQUxDMjY5X0ZJWFVQX0xJ
RkVCT09LX0VYVE1JQyksCiAJU05EX1BDSV9RVUlSSygweDEwZWMsIDB4MTBmMiwgIkludGVsIFJl
ZmVyZW5jZSBib2FyZCIsIEFMQzcwMF9GSVhVUF9JTlRFTF9SRUZFUkVOQ0UpLAorCVNORF9QQ0lf
UVVJUksoMHgxMGY3LCAweDgzMzgsICJQYW5hc29uaWMgQ0YtU1o2IiwgQUxDMjY5X0ZJWFVQX0hF
QURTRVRfTU9ERSksCiAJU05EX1BDSV9RVUlSSygweDE0NGQsIDB4YzEwOSwgIlNhbXN1bmcgQXRp
diBib29rIDkgKE5QOTAwWDNHKSIsIEFMQzI2OV9GSVhVUF9JTlZfRE1JQyksCiAJU05EX1BDSV9R
VUlSSygweDE0NGQsIDB4Yzc0MCwgIlNhbXN1bmcgQXRpdiBib29rIDggKE5QODcwWjVHKSIsIEFM
QzI2OV9GSVhVUF9BVElWX0JPT0tfOCksCiAJU05EX1BDSV9RVUlSSygweDE0NTgsIDB4ZmE1Mywg
IkdpZ2FieXRlIEJYQlQtMjgwNyIsIEFMQzI4M19GSVhVUF9IRUFEU0VUX01JQyksCi0tIAoyLjE4
LjAKCg==
--000000000000e3e62a0571195d49
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--000000000000e3e62a0571195d49--
