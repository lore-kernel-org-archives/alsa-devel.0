From: Kailang <kailang@realtek.com>
Subject: New Dell platform support headset mode
Date: Thu, 3 Jan 2019 07:59:38 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18420BC8@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A18420BC8RTITMBSV02realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 61DE7267B78
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 08:59:46 +0100 (CET)
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

--_002_6FAB7C47BCF00940BB0999A99BE3547A18420BC8RTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Attach patch will enable headset mode for new platform.

BR,
Kailang

--_002_6FAB7C47BCF00940BB0999A99BE3547A18420BC8RTITMBSV02realt_
Content-Type: application/octet-stream;
	name="0000-dell-headset-mode-0x0935.patch"
Content-Description: 0000-dell-headset-mode-0x0935.patch
Content-Disposition: attachment;
	filename="0000-dell-headset-mode-0x0935.patch"; size=1183;
	creation-date="Thu, 03 Jan 2019 07:56:58 GMT";
	modification-date="Thu, 03 Jan 2019 07:56:30 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxYzIxZTQwZGYzYjE4YzM1NGU3YjdkNGE0ZGQxOGY2MDA5MzAwYTcwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFRodSwgMyBKYW4gMjAxOSAxNTo1MzozOSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYS9yZWFsdGVrIC0gU3VwcG9ydCBEZWxsIGhlYWRzZXQgbW9kZSBmb3IgTmV3IEFJTwogcGxh
dGZvcm0KCkRlbGwgaGFzIG5ldyBwbGF0Zm9ybSBmb3IgQUxDMjc0LgpUaGlzIHdpbGwgc3VwcG9y
dCB0byBlbmFibGUgaGVhZHNldCBtb2RlLgoKU2lnbmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxr
YWlsYW5nQHJlYWx0ZWsuY29tPgoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVh
bHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggYTRmNGE5ZC4uZTQ4
Mzc1NSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291
bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTY1ODQsNiArNjU4NCw3IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBhbGMyNjlfZml4dXBfdGJsW10gPSB7CiAJU05EX1BD
SV9RVUlSSygweDEwMjgsIDB4MDg3MSwgIkRlbGwgUHJlY2lzaW9uIDM2MzAiLCBBTEMyNTVfRklY
VVBfREVMTF9IRUFEU0VUX01JQyksCiAJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MDg3MiwgIkRl
bGwgUHJlY2lzaW9uIDM2MzAiLCBBTEMyNTVfRklYVVBfREVMTF9IRUFEU0VUX01JQyksCiAJU05E
X1BDSV9RVUlSSygweDEwMjgsIDB4MDg3MywgIkRlbGwgUHJlY2lzaW9uIDM5MzAiLCBBTEMyNTVf
RklYVVBfRFVNTVlfTElORU9VVF9WRVJCKSwKKwlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwOTM1
LCAiRGVsbCIsIEFMQzI3NF9GSVhVUF9ERUxMX0FJT19MSU5FT1VUX1ZFUkIpLAogCVNORF9QQ0lf
UVVJUksoMHgxMDI4LCAweDE2NGEsICJEZWxsIiwgQUxDMjkzX0ZJWFVQX0RFTEwxX01JQ19OT19Q
UkVTRU5DRSksCiAJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MTY0YiwgIkRlbGwiLCBBTEMyOTNf
RklYVVBfREVMTDFfTUlDX05PX1BSRVNFTkNFKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAzYywgMHgx
NTg2LCAiSFAiLCBBTEMyNjlfRklYVVBfSFBfTVVURV9MRURfTUlDMiksCg==

--_002_6FAB7C47BCF00940BB0999A99BE3547A18420BC8RTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A18420BC8RTITMBSV02realt_--
