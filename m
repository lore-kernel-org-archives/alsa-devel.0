From: Urja Rannikko <urjaman@gmail.com>
Subject: [PATCH] conf/ucm: VEYRON-I2S: Add internal speakers
	and mic, other fixes
Date: Wed, 6 Jun 2018 18:19:53 +0000
Message-ID: <CAPCnQJmct24teOrWopkny_A5Qe9NMD_nn0J8ytYCvzTcbyo-MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0000000000009e9ce6056dfd36b3"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f51.google.com (mail-lf0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2984E2671EE
 for <alsa-devel@alsa-project.org>; Wed,  6 Jun 2018 20:19:54 +0200 (CEST)
Received: by mail-lf0-f51.google.com with SMTP id j13-v6so10555182lfb.13
 for <alsa-devel@alsa-project.org>; Wed, 06 Jun 2018 11:19:54 -0700 (PDT)
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

--0000000000009e9ce6056dfd36b3
Content-Type: text/plain; charset="UTF-8"

Hi,

Attached is a patch that effectively fixes pulseaudio
(and adds the internal speakers for other UCM users, if any)
on the ASUS C201 chromebook.

--0000000000009e9ce6056dfd36b3
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-conf-ucm-VEYRON-I2S-Add-internal-speakers-and-mic-ot.patch"
Content-Disposition: attachment;
	filename="0001-conf-ucm-VEYRON-I2S-Add-internal-speakers-and-mic-ot.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ji3fobjl0

RnJvbSBjNWFlZmNiMTY5ZTkyOTlkYmJhY2UwZGMxMzhjNThmODEyMWU2NDEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBVcmphIFJhbm5pa2tvIDx1cmphbWFuQGdtYWlsLmNvbT4KRGF0
ZTogV2VkLCA2IEp1biAyMDE4IDE3OjUyOjQyICswMDAwClN1YmplY3Q6IFtQQVRDSF0gY29uZi91
Y206IFZFWVJPTi1JMlM6IEFkZCBpbnRlcm5hbCBzcGVha2VycyBhbmQgbWljLCBvdGhlcgogZml4
ZXMKCk90aGVyIGZpeGVzIGluY2x1ZGUgb3V0cHV0L2lucHV0IG5hbWVzIChjb21tZW50cykgZm9y
IFVJcyAocGF2dWNvbnRyb2wpCnRvIGRpc3BsYXksIGFuZCBQbGF5YmFjay9DYXB0dXJlUENNIGVu
dHJpZXMgc28gcHVsc2VhdWRpbyBpbml0aWFsaXplcwpjb3JyZWN0bHkgb24gdGhpcyBoYXJkd2Fy
ZS4KClNpZ25lZC1vZmYtYnk6IFVyamEgUmFubmlra28gPHVyamFtYW5AZ21haWwuY29tPgotLS0K
IHNyYy9jb25mL3VjbS9WRVlST04tSTJTL0hpRmkuY29uZiB8IDM4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvc3JjL2NvbmYvdWNtL1ZFWVJPTi1JMlMvSGlGaS5jb25mIGIvc3JjL2NvbmYvdWNtL1ZF
WVJPTi1JMlMvSGlGaS5jb25mCmluZGV4IDI5MmI4ZmMuLjZkZGRmOWEgMTAwNjQ0Ci0tLSBhL3Ny
Yy9jb25mL3VjbS9WRVlST04tSTJTL0hpRmkuY29uZgorKysgYi9zcmMvY29uZi91Y20vVkVZUk9O
LUkyUy9IaUZpLmNvbmYKQEAgLTQ3LDkgKzQ3LDQ1IEBAIFNlY3Rpb25WZXJiIHsKIAldCiB9CiAK
K1NlY3Rpb25EZXZpY2UuIlNwZWFrZXIiLjAgeworCUNvbW1lbnQgIlNwZWFrZXIiCisJVmFsdWUg
eworCQlQbGF5YmFja1BDTSAiaHc6VkVZUk9OSTJTLDAiCisJfQorCUVuYWJsZVNlcXVlbmNlIFsK
KwkJY2RldiAiaHc6VkVZUk9OSTJTIgorCisJCWNzZXQgIm5hbWU9J1NwZWFrZXIgU3dpdGNoJyBv
biIKKwldCisJRGlzYWJsZVNlcXVlbmNlIFsKKwkJY2RldiAiaHc6VkVZUk9OSTJTIgorCisJCWNz
ZXQgIm5hbWU9J1NwZWFrZXIgU3dpdGNoJyBvZmYiCisJXQorfQorCitTZWN0aW9uRGV2aWNlLiJJ
bnRlcm5hbCBNaWMiLjAgeworCUNvbW1lbnQgIkludCBNaWMiCisJVmFsdWUgeworCQlDYXB0dXJl
UENNICJodzpWRVlST05JMlMsMCIKKwl9CisJRW5hYmxlU2VxdWVuY2UgWworCQljZGV2ICJodzpW
RVlST05JMlMiCisKKwkJY3NldCAibmFtZT0nSW50IE1pYyBTd2l0Y2gnIG9uIgorCV0KKwlEaXNh
YmxlU2VxdWVuY2UgWworCQljZGV2ICJodzpWRVlST05JMlMiCisKKwkJY3NldCAibmFtZT0nSW50
IE1pYyBTd2l0Y2gnIG9mZiIKKwldCit9CisKIFNlY3Rpb25EZXZpY2UuIkhlYWRwaG9uZSIuMCB7
CisJQ29tbWVudCAiSGVhZHBob25lIgogCVZhbHVlIHsKIAkJSmFja05hbWUgIlZFWVJPTi1JMlMg
SGVhZHNldCBKYWNrIgorCQlQbGF5YmFja1BDTSAiaHc6VkVZUk9OSTJTLDAiCiAJCU91dHB1dERz
cE5hbWUgIiIKIAl9CiAKQEAgLTcwLDggKzEwNiwxMCBAQCBTZWN0aW9uRGV2aWNlLiJIZWFkcGhv
bmUiLjAgewogfQogCiBTZWN0aW9uRGV2aWNlLiJNaWMiLjAgeworCUNvbW1lbnQgIkhlYWRzZXQg
TWljIgogCVZhbHVlIHsKIAkJSmFja05hbWUgIlZFWVJPTi1JMlMgSGVhZHNldCBKYWNrIgorCQlD
YXB0dXJlUENNICJodzpWRVlST05JMlMsMCIKIAl9CiAKIAlFbmFibGVTZXF1ZW5jZSBbCi0tIAoy
LjE3LjEKCg==
--0000000000009e9ce6056dfd36b3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0000000000009e9ce6056dfd36b3--
