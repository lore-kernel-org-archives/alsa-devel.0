From: Kailang <kailang@realtek.com>
Subject: Dell desktop headset support
Date: Thu, 22 Mar 2018 07:55:39 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1841064A@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A1841064ARTITMBSV02realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 05F4F26738C
 for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2018 08:55:49 +0100 (CET)
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

--_002_6FAB7C47BCF00940BB0999A99BE3547A1841064ARTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi Takashi,

Attach patch was fixup for Dell desktop.

This platform was hardware fixed type for CTIA type for headset port.
Assigned 0x19 verb will fix can't record issue.

This patch was tested by Ubuntu QA.
Thanks.

BR,
Kailang=

--_002_6FAB7C47BCF00940BB0999A99BE3547A1841064ARTITMBSV02realt_
Content-Type: application/octet-stream;
	name="0001-dell-desktop-headset-mic-issue.patch"
Content-Description: 0001-dell-desktop-headset-mic-issue.patch
Content-Disposition: attachment;
	filename="0001-dell-desktop-headset-mic-issue.patch"; size=1953;
	creation-date="Fri, 16 Mar 2018 03:51:01 GMT";
	modification-date="Thu, 22 Mar 2018 07:51:37 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmYzhiYWNhYWYzZmE1MjA4NjNiMTkwZjJkNzc3OTM3YzI0OWE1YjkxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IEZyaSwgMTYgTWFyIDIwMTggMTE6NDY6MDggKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEZpeCBEZWxsIGhlYWRzZXQgTWljIGNhbid0IHJlY29yZAoKVGhpcyBw
bGF0Zm9ybSB3YXMgaGFyZHdhcmUgZml4ZWQgdHlwZSBmb3IgQ1RJQSB0eXBlIGZvciBoZWFkc2V0
IHBvcnQuCkFzc2lnbmVkIDB4MTkgdmVyYiB3aWxsIGZpeCBjYW4ndCByZWNvcmQgaXNzdWUuCgpT
aWduZWQtb2ZmLWJ5OiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CgpkaWZmIC0t
Z2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNo
X3JlYWx0ZWsuYwppbmRleCA5YWYzMDFjLi5kNjkzNGE2IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kv
aGRhL3BhdGNoX3JlYWx0ZWsuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwpA
QCAtNTQ5Nyw2ICs1NDk3LDcgQEAgZW51bSB7CiAJQUxDMjc0X0ZJWFVQX0RFTExfQUlPX0xJTkVP
VVRfVkVSQiwKIAlBTEMyOThfRklYVVBfVFBUNDcwX0RPQ0ssCiAJQUxDMjU1X0ZJWFVQX0RVTU1Z
X0xJTkVPVVRfVkVSQiwKKwlBTEMyNTVfRklYVVBfREVMTF9IRUFEU0VUX01JQywKIH07CiAKIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgaGRhX2ZpeHVwIGFsYzI2OV9maXh1cHNbXSA9IHsKQEAgLTYzNTcs
NiArNjM1OCwxMyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGhkYV9maXh1cCBhbGMyNjlfZml4dXBz
W10gPSB7CiAJCS5jaGFpbmVkID0gdHJ1ZSwKIAkJLmNoYWluX2lkID0gQUxDMjU1X0ZJWFVQX0RF
TEwxX01JQ19OT19QUkVTRU5DRQogCX0sCisJW0FMQzI1NV9GSVhVUF9ERUxMX0hFQURTRVRfTUlD
XSA9IHsKKwkJLnR5cGUgPSBIREFfRklYVVBfUElOUywKKwkJLnYucGlucyA9IChjb25zdCBzdHJ1
Y3QgaGRhX3BpbnRibFtdKSB7CisJCQl7IDB4MTksIDB4MDFhMTkxM2MgfSwgLyogdXNlIGFzIGhl
YWRzZXQgbWljLCB3aXRob3V0IGl0cyBvd24gamFjayBkZXRlY3QgKi8KKwkJCXsgfQorCQl9LAor
CX0sCiB9OwogCiBzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9wY2lfcXVpcmsgYWxjMjY5X2ZpeHVw
X3RibFtdID0gewpAQCAtNjQxMSw2ICs2NDE5LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRf
cGNpX3F1aXJrIGFsYzI2OV9maXh1cF90YmxbXSA9IHsKIAlTTkRfUENJX1FVSVJLKDB4MTAyOCwg
MHgwODJhLCAiRGVsbCBYUFMgMTMgOTM2MCIsIEFMQzI1Nl9GSVhVUF9ERUxMX1hQU18xM19IRUFE
UEhPTkVfTk9JU0UpLAogCVNORF9QQ0lfUVVJUksoMHgxMDI4LCAweDA4NGIsICJEZWxsIiwgQUxD
Mjc0X0ZJWFVQX0RFTExfQUlPX0xJTkVPVVRfVkVSQiksCiAJU05EX1BDSV9RVUlSSygweDEwMjgs
IDB4MDg0ZSwgIkRlbGwiLCBBTEMyNzRfRklYVVBfREVMTF9BSU9fTElORU9VVF9WRVJCKSwKKwlT
TkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwODcxLCAiRGVsbCBQcmVjaXNpb24gMzYzMCIsIEFMQzI1
NV9GSVhVUF9ERUxMX0hFQURTRVRfTUlDKSwKKwlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwODcy
LCAiRGVsbCBQcmVjaXNpb24gMzYzMCIsIEFMQzI1NV9GSVhVUF9ERUxMX0hFQURTRVRfTUlDKSwK
IAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwODczLCAiRGVsbCBQcmVjaXNpb24gMzkzMCIsIEFM
QzI1NV9GSVhVUF9EVU1NWV9MSU5FT1VUX1ZFUkIpLAogCVNORF9QQ0lfUVVJUksoMHgxMDI4LCAw
eDE2NGEsICJEZWxsIiwgQUxDMjkzX0ZJWFVQX0RFTEwxX01JQ19OT19QUkVTRU5DRSksCiAJU05E
X1BDSV9RVUlSSygweDEwMjgsIDB4MTY0YiwgIkRlbGwiLCBBTEMyOTNfRklYVVBfREVMTDFfTUlD
X05PX1BSRVNFTkNFKSwK

--_002_6FAB7C47BCF00940BB0999A99BE3547A1841064ARTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A1841064ARTITMBSV02realt_--
