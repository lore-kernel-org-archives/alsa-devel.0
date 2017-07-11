From: Kailang <kailang@realtek.com>
Subject: New codec device ID for ALC1220
Date: Tue, 11 Jul 2017 07:25:38 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A183F31C4@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A183F31C4RTITMBSV02realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 26696266CE2
 for <alsa-devel@alsa-project.org>; Tue, 11 Jul 2017 09:25:48 +0200 (CEST)
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

--_002_6FAB7C47BCF00940BB0999A99BE3547A183F31C4RTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi Takashi,

ALC1220 has another device ID.
Attach patch was add 0x1168 device ID support.

Many Thanks.

BR,
Kailang=

--_002_6FAB7C47BCF00940BB0999A99BE3547A183F31C4RTITMBSV02realt_
Content-Type: application/octet-stream; name="0000-new-id-for-alc1220.patch"
Content-Description: 0000-new-id-for-alc1220.patch
Content-Disposition: attachment; filename="0000-new-id-for-alc1220.patch";
	size=1100; creation-date="Tue, 11 Jul 2017 07:22:00 GMT";
	modification-date="Tue, 11 Jul 2017 07:22:44 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhNzQ5ODk0M2I0NWQ0M2Y0YTFhYmYzN2I3NTkwOGMxZWRmODQwMjMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFR1ZSwgMTEgSnVsIDIwMTcgMTU6MTU6NDcgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIE5ldyBjb2RlYyBkZXZpY2UgSUQgZm9yIEFMQzEyMjAKCkNvZGVjIElE
IGlzIDB4MTE2OC4KSXQgaXMgYW5vdGhlciBBTEMxMjIwIGNvZGVjLgoKU2lnbmVkLW9mZi1ieTog
S2FpbGFuZyBZYW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29tPgoKZGlmZiAtLWdpdCBhL3NvdW5kL3Bj
aS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5k
ZXggZTIxMTZkMi4uNDVkNThmYyAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFs
dGVrLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTM3OSw2ICszNzks
NyBAQCBzdGF0aWMgdm9pZCBhbGNfZmlsbF9lYXBkX2NvZWYoc3RydWN0IGhkYV9jb2RlYyAqY29k
ZWMpCiAJCWJyZWFrOwogCWNhc2UgMHgxMGVjMDg5OToKIAljYXNlIDB4MTBlYzA5MDA6CisJY2Fz
ZSAweDEwZWMxMTY4OgogCWNhc2UgMHgxMGVjMTIyMDoKIAkJYWxjX3VwZGF0ZV9jb2VmX2lkeChj
b2RlYywgMHg3LCAxPDwxLCAwKTsKIAkJYnJlYWs7CkBAIC03ODE1LDYgKzc4MTYsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGhkYV9kZXZpY2VfaWQgc25kX2hkYV9pZF9yZWFsdGVrW10gPSB7CiAJ
SERBX0NPREVDX0VOVFJZKDB4MTBlYzA4OTIsICJBTEM4OTIiLCBwYXRjaF9hbGM2NjIpLAogCUhE
QV9DT0RFQ19FTlRSWSgweDEwZWMwODk5LCAiQUxDODk4IiwgcGF0Y2hfYWxjODgyKSwKIAlIREFf
Q09ERUNfRU5UUlkoMHgxMGVjMDkwMCwgIkFMQzExNTAiLCBwYXRjaF9hbGM4ODIpLAorCUhEQV9D
T0RFQ19FTlRSWSgweDEwZWMxMTY4LCAiQUxDMTIyMCIsIHBhdGNoX2FsYzg4MiksCiAJSERBX0NP
REVDX0VOVFJZKDB4MTBlYzEyMjAsICJBTEMxMjIwIiwgcGF0Y2hfYWxjODgyKSwKIAl7fSAvKiB0
ZXJtaW5hdG9yICovCiB9Owo=

--_002_6FAB7C47BCF00940BB0999A99BE3547A183F31C4RTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A183F31C4RTITMBSV02realt_--
