From: Kailang <kailang@realtek.com>
Subject: FW: Dell new AIO platform
Date: Tue, 6 Mar 2018 07:57:15 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1840D1E6@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A1840D1E6RTITMBSV02realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F4552670F9
 for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2018 08:57:20 +0100 (CET)
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6FAB7C47BCF00940BB0999A99BE3547A1840D1E6RTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20
Hi Takashi,
=20
This platform was only one phone Jack.
Add dummy lineout verb to fix automute mode disable.
This just the workarround.
=20
This patch was test by Hui Wang@canonical
=20
Many Thanks.
=20
BR,
Kailang

--_002_6FAB7C47BCF00940BB0999A99BE3547A1840D1E6RTITMBSV02realt_
Content-Type: application/octet-stream;
	name="0000-dell-0x0873-headset-mode-support.patch"
Content-Description: 0000-dell-0x0873-headset-mode-support.patch
Content-Disposition: attachment;
	filename="0000-dell-0x0873-headset-mode-support.patch"; size=1893;
	creation-date="Mon, 05 Feb 2018 08:12:10 GMT";
	modification-date="Mon, 05 Feb 2018 08:11:24 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2MDdiMGVlYWNlZWJmYWI3Y2JkNzBhYWQ5MzA4NTFmMWEzYjhkM2U2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IE1vbiwgNSBGZWIgMjAxOCAxNjowNzoyMCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYS9yZWFsdGVrIC0gQWRkIGhlYWRzZXQgbW9kZSBzdXBwb3J0IGZvciBEZWxsIGxhcHRvcAoK
VGhpcyBwbGF0Zm9ybSB3YXMgb25seSBvbmUgcGhvbmUgSmFjay4KQWRkIGR1bW15IGxpbmVvdXQg
dmVyYiB0byBmaXggYXV0b211dGUgbW9kZSBkaXNhYmxlLgpUaGlzIGp1c3QgdGhlIHdvcmthcnJv
dW5kLgoKU2lnbmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29tPgoK
ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hk
YS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggMjM0NzU4OC4uY2Y1Y2I5NCAxMDA2NDQKLS0tIGEvc291
bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFs
dGVrLmMKQEAgLTU0NDYsNiArNTQ0Niw3IEBAIGVudW0gewogCUFMQzcwMF9GSVhVUF9JTlRFTF9S
RUZFUkVOQ0UsCiAJQUxDMjc0X0ZJWFVQX0RFTExfQklORF9EQUNTLAogCUFMQzI3NF9GSVhVUF9E
RUxMX0FJT19MSU5FT1VUX1ZFUkIsCisJQUxDMjU1X0ZJWFVQX0RVTU1ZX0xJTkVPVVRfVkVSQiwK
IH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaGRhX2ZpeHVwIGFsYzI2OV9maXh1cHNbXSA9IHsK
QEAgLTYyNzEsNiArNjI3MiwxNSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGhkYV9maXh1cCBhbGMy
NjlfZml4dXBzW10gPSB7CiAJCS5jaGFpbmVkID0gdHJ1ZSwKIAkJLmNoYWluX2lkID0gQUxDMjc0
X0ZJWFVQX0RFTExfQklORF9EQUNTCiAJfSwKKwlbQUxDMjU1X0ZJWFVQX0RVTU1ZX0xJTkVPVVRf
VkVSQl0gPSB7CisJCS50eXBlID0gSERBX0ZJWFVQX1BJTlMsCisJCS52LnBpbnMgPSAoY29uc3Qg
c3RydWN0IGhkYV9waW50YmxbXSkgeworCQkJeyAweDE0LCAweDAyMDExMDFmIH0sCisJCQl7IH0K
KwkJfSwKKwkJLmNoYWluZWQgPSB0cnVlLAorCQkuY2hhaW5faWQgPSBBTEMyNTVfRklYVVBfREVM
TDFfTUlDX05PX1BSRVNFTkNFCisJfSwKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3Bj
aV9xdWlyayBhbGMyNjlfZml4dXBfdGJsW10gPSB7CkBAIC02MzIxLDYgKzYzMzEsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHNuZF9wY2lfcXVpcmsgYWxjMjY5X2ZpeHVwX3RibFtdID0gewogCVNO
RF9QQ0lfUVVJUksoMHgxMDI4LCAweDA3NWQsICJEZWxsIEFJTyIsIEFMQzI5OF9GSVhVUF9TUEtf
Vk9MVU1FKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwNzk4LCAiRGVsbCBJbnNwaXJvbiAx
NyA3MDAwIEdhbWluZyIsIEFMQzI1Nl9GSVhVUF9ERUxMX0lOU1BJUk9OXzc1NTlfU1VCV09PRkVS
KSwKIAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwODJhLCAiRGVsbCBYUFMgMTMgOTM2MCIsIEFM
QzI1Nl9GSVhVUF9ERUxMX1hQU18xM19IRUFEUEhPTkVfTk9JU0UpLAorCVNORF9QQ0lfUVVJUkso
MHgxMDI4LCAweDA4NzMsICJEZWxsIFByZWNpc2lvbiAzOTMwIiwgQUxDMjU1X0ZJWFVQX0RVTU1Z
X0xJTkVPVVRfVkVSQiksCiAJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MTY0YSwgIkRlbGwiLCBB
TEMyOTNfRklYVVBfREVMTDFfTUlDX05PX1BSRVNFTkNFKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAy
OCwgMHgxNjRiLCAiRGVsbCIsIEFMQzI5M19GSVhVUF9ERUxMMV9NSUNfTk9fUFJFU0VOQ0UpLAog
CVNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDE1ODYsICJIUCIsIEFMQzI2OV9GSVhVUF9IUF9NVVRF
X0xFRF9NSUMyKSwK

--_002_6FAB7C47BCF00940BB0999A99BE3547A1840D1E6RTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A1840D1E6RTITMBSV02realt_--
