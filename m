From: Kailang <kailang@realtek.com>
Subject: Dell AIO speaker pop noise
Date: Tue, 16 Apr 2019 07:30:59 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18DBBB6E@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A18DBBB6ERTITMBSVM07real_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8AFD2F89616
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 09:31:07 +0200 (CEST)
Content-Language: zh-TW
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: hwang4 <hui.wang@canonical.com>, " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6FAB7C47BCF00940BB0999A99BE3547A18DBBB6ERTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Issue 1: The noise keeps occurring via speaker when Headset is plugged in.
Issue 2: The humming noise is occuring when switching to sound of settings.
	 The noise will be stopped when switching to other options of settings.
Issue 3: The popping noise occurred for one second when plugged in and remo=
ved the headset.

This patch will solve this three issues.

BR,
Kailang

--_002_6FAB7C47BCF00940BB0999A99BE3547A18DBBB6ERTITMBSVM07real_
Content-Type: application/octet-stream; name="0000-dell-aio-spk-noise.patch"
Content-Description: 0000-dell-aio-spk-noise.patch
Content-Disposition: attachment; filename="0000-dell-aio-spk-noise.patch";
	size=2268; creation-date="Tue, 16 Apr 2019 07:22:29 GMT";
	modification-date="Tue, 16 Apr 2019 07:28:37 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxZDc3NzE0YmQzNWM5MTc4ZTIwOTA0YzU2OWNkNmE5YzJkNjQ5ZTFiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFR1ZSwgMTYgQXByIDIwMTkgMTU6MjA6MjAgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEZpeGVkIERlbGwgQUlPIHNwZWFrZXIgbm9pc2UKCklzc3VlIDE6IFRo
ZSBub2lzZSBrZWVwcyBvY2N1cnJpbmcgdmlhIHNwZWFrZXIgd2hlbiBIZWFkc2V0IGlzIHBsdWdn
ZWQgaW4uCklzc3VlIDI6IFRoZSBodW1taW5nIG5vaXNlIGlzIG9jY3VyaW5nIHdoZW4gc3dpdGNo
aW5nIHRvIHNvdW5kIG9mIHNldHRpbmdzLgoJIFRoZSBub2lzZSB3aWxsIGJlIHN0b3BwZWQgd2hl
biBzd2l0Y2hpbmcgdG8gb3RoZXIgb3B0aW9ucyBvZiBzZXR0aW5ncy4KSXNzdWUgMzogVGhlIHBv
cHBpbmcgbm9pc2Ugb2NjdXJyZWQgZm9yIG9uZSBzZWNvbmQgd2hlbiBwbHVnZ2VkIGluIGFuZCBy
ZW1vdmVkIHRoZSBoZWFkc2V0LgoKVGhpcyBwYXRjaCB3aWxsIHNvbHZlIHRoaXMgdGhyZWUgaXNz
dWVzLgoKU2lnbmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29tPgoK
ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hk
YS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggODEwNDc5NzY2MDkwLi4wZGVkMDgwOTU0NmQgMTAwNjQ0
Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBiL3NvdW5kL3BjaS9oZGEv
cGF0Y2hfcmVhbHRlay5jCkBAIC01NDUyLDYgKzU0NTIsMTkgQEAgc3RhdGljIHZvaWQgYWxjMjc0
X2ZpeHVwX2JpbmRfZGFjcyhzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywKIAlzcGVjLT5nZW4ucHJl
ZmVycmVkX2RhY3MgPSBwcmVmZXJyZWRfcGFpcnM7CiB9CiAKK3N0YXRpYyB2b2lkIGFsYzI3NF9m
aXh1cF9haW9fc3BlYWtlcihzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywKKwkJCQkgICAgY29uc3Qg
c3RydWN0IGhkYV9maXh1cCAqZml4LCBpbnQgYWN0aW9uKQoreworCXN0cnVjdCBhbGNfc3BlYyAq
c3BlYyA9IGNvZGVjLT5zcGVjOworCisJc3dpdGNoIChhY3Rpb24pIHsKKwljYXNlIEhEQV9GSVhV
UF9BQ1RfUFJFX1BST0JFOgorCQljb2RlYy0+cG93ZXJfc2F2ZV9ub2RlID0gMDsKKwkJc3BlYy0+
Z2VuLnN1cHByZXNzX2F1dG9fbXV0ZSA9IDE7CisJCWJyZWFrOworCX0KK30KKwogLyogVGhlIERB
QyBvZiBOSUQgMHgzIHdpbGwgaW50cm9kdWNlIGNsaWNrL3BvcCBub2lzZSBvbiBoZWFkcGhvbmVz
LCBzbyBpbnZhbGlkYXRlIGl0ICovCiBzdGF0aWMgdm9pZCBhbGMyODVfZml4dXBfaW52YWxpZGF0
ZV9kYWNzKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLAogCQkJICAgICAgY29uc3Qgc3RydWN0IGhk
YV9maXh1cCAqZml4LCBpbnQgYWN0aW9uKQpAQCAtNTY3Nyw2ICs1NjkwLDcgQEAgZW51bSB7CiAJ
QUxDMjk0X0ZJWFVQX0xFTk9WT19NSUNfTE9DQVRJT04sCiAJQUxDMjI1X0ZJWFVQX0RFTExfV1lT
RV9NSUNfTk9fUFJFU0VOQ0UsCiAJQUxDNzAwX0ZJWFVQX0lOVEVMX1JFRkVSRU5DRSwKKwlBTEMy
NzRfRklYVVBfREVMTF9BSU9fU1BLLAogCUFMQzI3NF9GSVhVUF9ERUxMX0JJTkRfREFDUywKIAlB
TEMyNzRfRklYVVBfREVMTF9BSU9fTElORU9VVF9WRVJCLAogCUFMQzI5OF9GSVhVUF9UUFQ0NzBf
RE9DSywKQEAgLTY1NTEsMTEgKzY1NjUsMTcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBoZGFfZml4
dXAgYWxjMjY5X2ZpeHVwc1tdID0gewogCQkJe30KIAkJfQogCX0sCisJW0FMQzI3NF9GSVhVUF9E
RUxMX0FJT19TUEtdID0geworCQkudHlwZSA9IEhEQV9GSVhVUF9GVU5DLAorCQkudi5mdW5jID0g
YWxjMjc0X2ZpeHVwX2Fpb19zcGVha2VyLAorCQkuY2hhaW5lZCA9IHRydWUsCisJCS5jaGFpbl9p
ZCA9IEFMQzI2OV9GSVhVUF9ERUxMMV9NSUNfTk9fUFJFU0VOQ0UKKwl9LAogCVtBTEMyNzRfRklY
VVBfREVMTF9CSU5EX0RBQ1NdID0gewogCQkudHlwZSA9IEhEQV9GSVhVUF9GVU5DLAogCQkudi5m
dW5jID0gYWxjMjc0X2ZpeHVwX2JpbmRfZGFjcywKIAkJLmNoYWluZWQgPSB0cnVlLAotCQkuY2hh
aW5faWQgPSBBTEMyNjlfRklYVVBfREVMTDFfTUlDX05PX1BSRVNFTkNFCisJCS5jaGFpbl9pZCA9
IEFMQzI3NF9GSVhVUF9ERUxMX0FJT19TUEsKIAl9LAogCVtBTEMyNzRfRklYVVBfREVMTF9BSU9f
TElORU9VVF9WRVJCXSA9IHsKIAkJLnR5cGUgPSBIREFfRklYVVBfUElOUywK

--_002_6FAB7C47BCF00940BB0999A99BE3547A18DBBB6ERTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A18DBBB6ERTITMBSVM07real_--
