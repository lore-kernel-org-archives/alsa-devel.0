From: Wandrille RONCE <w@ndrille.fr>
Subject: [PATCH] ALSA: hda/realtek: Enable audio jacks of ASUS
 UX391UA with, ALC294
Date: Mon, 17 Dec 2018 22:58:04 +0100
Message-ID: <489c2bed-b02b-c957-6c16-1dac5e57007d@ndrille.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vanvan.co (vanvan.co [195.154.237.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E6F6267AC9
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 22:58:07 +0100 (CET)
Received: from [192.168.1.20] (unknown [81.249.133.55])
 by vanvan.co (Postfix) with ESMTPSA id 723BE292363
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 22:58:04 +0100 (CET)
Content-Language: en-US
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

IEZyb20gYzg3Y2UyMTE5ZjAxMGRiNzg5MzNjNDI0YjhiYTY3MzhjMzA1NmRmZiBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogV2FuZHJpbGxlIFJPTkNFIDx3QG5kcmlsbGUuZnI+CkRhdGU6
IE1vbiwgMTcgRGVjIDIwMTggMTk6MDA6MDAgKzAxMDAKU3ViamVjdDogW1BBVENIXSBBTFNBOiBo
ZGEvcmVhbHRlazogRW5hYmxlIGF1ZGlvIGphY2tzIG9mIEFTVVMgVVgzOTFVQSB3aXRoCiDCoEFM
QzI5NAoKLS0tCiDCoHNvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIHwgMSArCiDCoDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0
Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggMTUwMjFj
ODM5MzcyLi45MGYzMGU3NjlhNDIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVh
bHRlay5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCkBAIC02NTg0LDYgKzY1
ODQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9wY2lfcXVpcmsgCmFsYzI2OV9maXh1cF90
YmxbXSA9IHsKIMKgwqDCoMKgIFNORF9QQ0lfUVVJUksoMHgxMDQzLCAweDEzYjAsICJBU1VTIFo1
NTBTQSIsIEFMQzI1Nl9GSVhVUF9BU1VTX01JQyksCiDCoMKgwqDCoCBTTkRfUENJX1FVSVJLKDB4
MTA0MywgMHgxNDI3LCAiQXN1cyBaZW5ib29rIFVYMzFFIiwgCkFMQzI2OVZCX0ZJWFVQX0FTVVNf
WkVOQk9PSyksCiDCoMKgwqDCoCBTTkRfUENJX1FVSVJLKDB4MTA0MywgMHgxNGExLCAiQVNVUyBV
WDUzM0ZEIiwgQUxDMjk0X0ZJWFVQX0FTVVNfU1BLKSwKK8KgwqDCoCBTTkRfUENJX1FVSVJLKDB4
MTA0MywgMHgxMGExLCAiQVNVUyBVWDM5MVVBIiwgQUxDMjk0X0ZJWFVQX0FTVVNfU1BLKSwKIMKg
wqDCoMKgIFNORF9QQ0lfUVVJUksoMHgxMDQzLCAweDE1MTcsICJBc3VzIFplbmJvb2sgVVgzMUEi
LCAKQUxDMjY5VkJfRklYVVBfQVNVU19aRU5CT09LX1VYMzFBKSwKIMKgwqDCoMKgIFNORF9QQ0lf
UVVJUksoMHgxMDQzLCAweDE2ZTMsICJBU1VTIFVYNTAiLCBBTEMyNjlfRklYVVBfU1RFUkVPX0RN
SUMpLAogwqDCoMKgwqAgU05EX1BDSV9RVUlSSygweDEwNDMsIDB4MWExMywgIkFzdXMgRzczSnci
LCBBTEMyNjlfRklYVVBfQVNVU19HNzNKVyksCi0tIAoyLjE5LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
