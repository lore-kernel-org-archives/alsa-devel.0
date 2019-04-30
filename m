From: Kailang <kailang@realtek.com>
Subject: move eapd coef function before ACT_PRE_PROBE state
Date: Tue, 30 Apr 2019 07:40:31 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1D76558C@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A1D76558CRTITMBSVM07real_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CAF35F8065C
 for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2019 09:40:36 +0200 (CEST)
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
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D76558CRTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

alc_fill_eapd_coef(),this function was change EAPD control to default.
Default was set EAPD by verb control.
This function was run in ACT_INIT state.
Move it to ACT_PRE_PROBE above. It will have a chance to change EAPD contro=
l
on ACT_PRE_PROBE state. It could change control by 0x20 coef bit.

BR,
Kailang

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D76558CRTITMBSVM07real_
Content-Type: application/octet-stream;
	name="0000-move-eapd-coef-func.patch"
Content-Description: 0000-move-eapd-coef-func.patch
Content-Disposition: attachment; filename="0000-move-eapd-coef-func.patch";
	size=1327; creation-date="Fri, 26 Apr 2019 09:20:24 GMT";
	modification-date="Fri, 26 Apr 2019 09:28:26 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyM2M5YTFjMzI4OGM0ZTc4MjU1ZjEzM2E0ZDljNDhmNTg0MmUwM2U2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IEZyaSwgMjYgQXByIDIwMTkgMTc6MTY6NDggKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIE1vdmUgRVBBRCBieSB2ZXJiIGZ1bmN0aW9uCgphbGNfZmlsbF9lYXBk
X2NvZWYoKSx0aGlzIGZ1bmN0aW9uIHdhcyBjaGFuZ2UgRUFQRCBjb250cm9sIHRvIGRlZmF1bHQu
CkRlZmF1bHQgd2FzIHNldCBFQVBEIGJ5IHZlcmIgY29udHJvbC4KVGhpcyBmdW5jdGlvbiB3YXMg
cnVuIGluIEFDVF9JTklUIHN0YXRlLgpNb3ZlIGl0IHRvIEFDVF9QUkVfUFJPQkUgYWJvdmUuIEl0
IHdpbGwgaGF2ZSBhIGNoYW5jZSB0byBjaGFuZ2UgRUFQRCBjb250cm9sCm9uIEFDVF9QUkVfUFJP
QkUgc3RhdGUuIEl0IGNvdWxkIGNoYW5nZSBjb250cm9sIGJ5IDB4MjAgY29lZiBiaXQuCgpTaWdu
ZWQtb2ZmLWJ5OiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CgpkaWZmIC0tZ2l0
IGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3Jl
YWx0ZWsuYwppbmRleCAxZDBlMGYyZTY1MjYuLjc1NTNmNzA0Y2I3ZiAxMDA2NDQKLS0tIGEvc291
bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFs
dGVrLmMKQEAgLTUwMSw3ICs1MDEsNiBAQCBzdGF0aWMgdm9pZCBhbGNfZWFwZF9zaHV0dXAoc3Ry
dWN0IGhkYV9jb2RlYyAqY29kZWMpCiAvKiBnZW5lcmljIEVBUEQgaW5pdGlhbGl6YXRpb24gKi8K
IHN0YXRpYyB2b2lkIGFsY19hdXRvX2luaXRfYW1wKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLCBp
bnQgdHlwZSkKIHsKLQlhbGNfZmlsbF9lYXBkX2NvZWYoY29kZWMpOwogCWFsY19hdXRvX3NldHVw
X2VhcGQoY29kZWMsIHRydWUpOwogCWFsY193cml0ZV9ncGlvKGNvZGVjKTsKIAlzd2l0Y2ggKHR5
cGUpIHsKQEAgLTEwODUsNiArMTA4NCw3IEBAIHN0YXRpYyBpbnQgYWxjX2FsbG9jX3NwZWMoc3Ry
dWN0IGhkYV9jb2RlYyAqY29kZWMsIGhkYV9uaWRfdCBtaXhlcl9uaWQpCiAJCXJldHVybiAtRU5P
TUVNOwogCWNvZGVjLT5zcGVjID0gc3BlYzsKIAlzbmRfaGRhX2dlbl9zcGVjX2luaXQoJnNwZWMt
Pmdlbik7CisJYWxjX2ZpbGxfZWFwZF9jb2VmKGNvZGVjKTsKIAlzcGVjLT5nZW4ubWl4ZXJfbmlk
ID0gbWl4ZXJfbmlkOwogCXNwZWMtPmdlbi5vd25fZWFwZF9jdGwgPSAxOwogCWNvZGVjLT5zaW5n
bGVfYWRjX2FtcCA9IDE7Cg==

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D76558CRTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A1D76558CRTITMBSVM07real_--
