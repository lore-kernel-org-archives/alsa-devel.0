From: Kailang <kailang@realtek.com>
Subject: Update ALC215 depop optimize
Date: Wed, 17 Jan 2018 07:42:18 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A184068B0@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A184068B0RTITMBSV02realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id C9211266D71
 for <alsa-devel@alsa-project.org>; Wed, 17 Jan 2018 08:42:24 +0100 (CET)
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

--_002_6FAB7C47BCF00940BB0999A99BE3547A184068B0RTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi Takashi,

Attach was the update patch for ALC215 depop.
This depop method was same as ALC225.

BR,
Kailang=

--_002_6FAB7C47BCF00940BB0999A99BE3547A184068B0RTITMBSV02realt_
Content-Type: application/octet-stream;
	name="0000-alc215-depop-optimize.patch"
Content-Description: 0000-alc215-depop-optimize.patch
Content-Disposition: attachment;
	filename="0000-alc215-depop-optimize.patch"; size=815;
	creation-date="Wed, 17 Jan 2018 07:37:38 GMT";
	modification-date="Wed, 17 Jan 2018 07:36:02 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3ODdmY2JlYjVhY2E0MmVjM2Q0YTU2MDEwOTY0Y2I0ZjgyMmFjYmE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFdlZCwgMTcgSmFuIDIwMTggMTU6MzI6MDMgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIHVwZGF0ZSBBTEMyMTUgZGVwb3Agb3B0aW1pemUKCkFkZCBBTEMyMTUg
aXRzIG93biBkZXBvcCBmdW5jdGlvbnMgZm9yIGFsY19pbml0IGFuZCBhbGNfc2h1dHVwLgpBc3Np
Z24gaXQgdG8gQUxDMjI1IHVzYWdlLgoKU2lnbmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWls
YW5nQHJlYWx0ZWsuY29tPgoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRl
ay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggNTUyNjQ2Yy4uMmYwZTM3
YSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQv
cGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTcwMjQsNiArNzAyNCw4IEBAIHN0YXRpYyBpbnQg
cGF0Y2hfYWxjMjY5KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCWNhc2UgMHgxMGVjMDI4NToK
IAljYXNlIDB4MTBlYzAyODk6CiAJCXNwZWMtPmNvZGVjX3ZhcmlhbnQgPSBBTEMyNjlfVFlQRV9B
TEMyMTU7CisJCXNwZWMtPnNodXR1cCA9IGFsYzIyNV9zaHV0dXA7CisJCXNwZWMtPmluaXRfaG9v
ayA9IGFsYzIyNV9pbml0OwogCQlzcGVjLT5nZW4ubWl4ZXJfbmlkID0gMDsKIAkJYnJlYWs7CiAJ
Y2FzZSAweDEwZWMwMjI1Ogo=

--_002_6FAB7C47BCF00940BB0999A99BE3547A184068B0RTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A184068B0RTITMBSV02realt_--
