From: Kailang <kailang@realtek.com>
Subject: Add headset support for Dell laptop
Date: Fri, 2 Feb 2018 07:40:47 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18409E2E@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A18409E2ERTITMBSV02realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id DF986266F64
 for <alsa-devel@alsa-project.org>; Fri,  2 Feb 2018 08:40:54 +0100 (CET)
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

--_002_6FAB7C47BCF00940BB0999A99BE3547A18409E2ERTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Attach patch was for support headset mode for Dell laptop.

This platform had two Dmic and single Dmic.
This update was for single Dmic.

This commit was for two Dmic.=20
commit	75ee94b20b46459e3d29f5ac2c3af3cebdeef777

Many thanks.

BR,
Kailang=

--_002_6FAB7C47BCF00940BB0999A99BE3547A18409E2ERTITMBSV02realt_
Content-Type: application/octet-stream;
	name="0000-dell-grizzly-single-dmic.patch"
Content-Description: 0000-dell-grizzly-single-dmic.patch
Content-Disposition: attachment;
	filename="0000-dell-grizzly-single-dmic.patch"; size=1343;
	creation-date="Fri, 02 Feb 2018 07:35:32 GMT";
	modification-date="Fri, 02 Feb 2018 07:21:36 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiYzUwYTAwMjA5N2Q1YjJlNWQ2NThiN2IyZGQwYmY2N2NmZjViMWU0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IEZyaSwgMiBGZWIgMjAxOCAxNToxMzowOSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYS9yZWFsdGVrIC0gQWRkIGhlYWRzZXQgbW9kZSBzdXBwb3J0IGZvciBEZWxsIGxhcHRvcAoK
VGhpcyBwbGF0Zm9ybSBoYWQgdHdvIERtaWMgYW5kIHNpbmdsZSBEbWljLgpUaGlzIHVwZGF0ZSB3
YXMgZm9yIHNpbmdsZSBEbWljLgoKVGhpcyBjb21taXQgd2FzIGZvciB0d28gRG1pYy4KY29tbWl0
CTc1ZWU5NGIyMGI0NjQ1OWUzZDI5ZjVhYzJjM2FmM2NlYmRlZWY3NzcKClNpZ25lZC1vZmYtYnk6
IEthaWxhbmcgWWFuZyA8a2FpbGFuZ0ByZWFsdGVrLmNvbT4KCmRpZmYgLS1naXQgYS9zb3VuZC9w
Y2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmlu
ZGV4IDIzNDc1ODguLjQyNjEzOGUgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVh
bHRlay5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCkBAIC02MzIxLDYgKzYz
MjEsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9wY2lfcXVpcmsgYWxjMjY5X2ZpeHVwX3Ri
bFtdID0gewogCVNORF9QQ0lfUVVJUksoMHgxMDI4LCAweDA3NWQsICJEZWxsIEFJTyIsIEFMQzI5
OF9GSVhVUF9TUEtfVk9MVU1FKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwNzk4LCAiRGVs
bCBJbnNwaXJvbiAxNyA3MDAwIEdhbWluZyIsIEFMQzI1Nl9GSVhVUF9ERUxMX0lOU1BJUk9OXzc1
NTlfU1VCV09PRkVSKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwODJhLCAiRGVsbCBYUFMg
MTMgOTM2MCIsIEFMQzI1Nl9GSVhVUF9ERUxMX1hQU18xM19IRUFEUEhPTkVfTk9JU0UpLAorCVNO
RF9QQ0lfUVVJUksoMHgxMDI4LCAweDA4NGIsICJEZWxsIiwgQUxDMjc0X0ZJWFVQX0RFTExfQUlP
X0xJTkVPVVRfVkVSQiksCisJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MDg0ZSwgIkRlbGwiLCBB
TEMyNzRfRklYVVBfREVMTF9BSU9fTElORU9VVF9WRVJCKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAy
OCwgMHgxNjRhLCAiRGVsbCIsIEFMQzI5M19GSVhVUF9ERUxMMV9NSUNfTk9fUFJFU0VOQ0UpLAog
CVNORF9QQ0lfUVVJUksoMHgxMDI4LCAweDE2NGIsICJEZWxsIiwgQUxDMjkzX0ZJWFVQX0RFTEwx
X01JQ19OT19QUkVTRU5DRSksCiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4MTU4NiwgIkhQIiwg
QUxDMjY5X0ZJWFVQX0hQX01VVEVfTEVEX01JQzIpLAo=

--_002_6FAB7C47BCF00940BB0999A99BE3547A18409E2ERTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A18409E2ERTITMBSV02realt_--
