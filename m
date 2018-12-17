From: Wandrille RONCE <w@ndrille.fr>
Subject: PATCH] ALSA: hda/realtek: Enable audio jacks of ASUS
 UX433FN variant with ALC294
Date: Mon, 17 Dec 2018 23:27:00 +0100
Message-ID: <7b9c610d-2a88-c121-9671-ad68b673a7c5@ndrille.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vanvan.co (vanvan.co [195.154.237.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 960E2267AF9
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 23:27:02 +0100 (CET)
Received: from [192.168.1.20] (unknown [81.249.133.55])
 by vanvan.co (Postfix) with ESMTPSA id 5014F292733
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 23:27:00 +0100 (CET)
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

IEZyb20gNWEyNDRlMjc4YzdiYjYyNmM5MDFkNjY4ZDM1OWY0NzY4MWU0MDY0NyBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogV2FuZHJpbGxlIFJPTkNFIDx3QG5kcmlsbGUuZnI+CkRhdGU6
IE1vbiwgMTcgRGVjIDIwMTggMTk6MzA6MDAgKzAxMDAKU3ViamVjdDogW1BBVENIXSBBTFNBOiBo
ZGEvcmVhbHRlazogRW5hYmxlIGF1ZGlvIGphY2tzIG9mIEFTVVMgVVg0MzNGTgogwqB2YXJpYW50
IHdpdGggQUxDMjk0CgotLS0KIMKgc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgfCAxICsK
IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNp
L2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwppbmRl
eCA5MGYzMGU3NjlhNDIuLjZmMzRmODExMjVlMCAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9w
YXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTY1
ODQsNiArNjU4NCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3BjaV9xdWlyayAKYWxjMjY5
X2ZpeHVwX3RibFtdID0gewogwqDCoMKgwqAgU05EX1BDSV9RVUlSSygweDEwNDMsIDB4MTNiMCwg
IkFTVVMgWjU1MFNBIiwgQUxDMjU2X0ZJWFVQX0FTVVNfTUlDKSwKIMKgwqDCoMKgIFNORF9QQ0lf
UVVJUksoMHgxMDQzLCAweDE0MjcsICJBc3VzIFplbmJvb2sgVVgzMUUiLCAKQUxDMjY5VkJfRklY
VVBfQVNVU19aRU5CT09LKSwKIMKgwqDCoMKgIFNORF9QQ0lfUVVJUksoMHgxMDQzLCAweDE0YTEs
ICJBU1VTIFVYNTMzRkQiLCBBTEMyOTRfRklYVVBfQVNVU19TUEspLAorwqDCoMKgIFNORF9QQ0lf
UVVJUksoMHgxMDQzLCAweDE2Y2UsICJBU1VTIFVYNDMzRk4iLCBBTEMyOTRfRklYVVBfQVNVU19T
UEspLAogwqDCoMKgwqAgU05EX1BDSV9RVUlSSygweDEwNDMsIDB4MTBhMSwgIkFTVVMgVVgzOTFV
QSIsIEFMQzI5NF9GSVhVUF9BU1VTX1NQSyksCiDCoMKgwqDCoCBTTkRfUENJX1FVSVJLKDB4MTA0
MywgMHgxNTE3LCAiQXN1cyBaZW5ib29rIFVYMzFBIiwgCkFMQzI2OVZCX0ZJWFVQX0FTVVNfWkVO
Qk9PS19VWDMxQSksCiDCoMKgwqDCoCBTTkRfUENJX1FVSVJLKDB4MTA0MywgMHgxNmUzLCAiQVNV
UyBVWDUwIiwgQUxDMjY5X0ZJWFVQX1NURVJFT19ETUlDKSwKLS0gCjIuMTkuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
