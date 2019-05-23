From: Kailang <kailang@realtek.com>
Subject: set power_save_node=0 as default
Date: Thu, 23 May 2019 06:59:18 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1D766DC0@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A1D766DC0RTITMBSVM07real_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77414F80C0F
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 08:59:24 +0200 (CEST)
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

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D766DC0RTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

I measured power consumption between power_save_node=3D1 and power_save_nod=
e=3D0.
It's almost the same.
Codec will enter to runtime suspend and suspend.
That pin also will enter to D3. Don't need to enter to D3 by single pin.
So, Disable power_save_node as default. It will avoid more issues.
Windows Driver also has not this option at runtime PM.

Many Thanks.

BR,
Kailang

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D766DC0RTITMBSVM07real_
Content-Type: application/octet-stream;
	name="0000-power-save-node-disable.patch"
Content-Description: 0000-power-save-node-disable.patch
Content-Disposition: attachment;
	filename="0000-power-save-node-disable.patch"; size=1064;
	creation-date="Thu, 23 May 2019 06:46:59 GMT";
	modification-date="Thu, 23 May 2019 06:56:40 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0MDhjNjQ5ZTFlNmRjYWIyZGZmMmZjMDJlMTkxZTdlZDRhNmFlNWY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFRodSwgMjMgTWF5IDIwMTkgMTQ6NDM6MDQgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIFNldCBkZWZhdWx0IHBvd2VyIHNhdmUgbm9kZSB0byAwCgpJIG1lYXN1
cmVkIHBvd2VyIGNvbnN1bXB0aW9uIGJldHdlZW4gcG93ZXJfc2F2ZV9ub2RlPTEgYW5kIHBvd2Vy
X3NhdmVfbm9kZT0wLgpJdCdzIGFsbW9zdCB0aGUgc2FtZS4KQ29kZWMgd2lsbCBlbnRlciB0byBy
dW50aW1lIHN1c3BlbmQgYW5kIHN1c3BlbmQuClRoYXQgcGluIGFsc28gd2lsbCBlbnRlciB0byBE
My4gRG9uJ3QgbmVlZCB0byBlbnRlciB0byBEMyBieSBzaW5nbGUgcGluLgpTbywgRGlzYWJsZSBw
b3dlcl9zYXZlX25vZGUgYXMgZGVmYXVsdC4gSXQgd2lsbCBhdm9pZCBtb3JlIGlzc3Vlcy4KV2lu
ZG93cyBEcml2ZXIgYWxzbyBoYXMgbm90IHRoaXMgb3B0aW9uIGF0IHJ1bnRpbWUgUE0uCgpTaWdu
ZWQtb2ZmLWJ5OiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CgpkaWZmIC0tZ2l0
IGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3Jl
YWx0ZWsuYwppbmRleCBmODNmMjFkNjRkZDQuLjQxM2ZjMzFkNWE4ZiAxMDA2NDQKLS0tIGEvc291
bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFs
dGVrLmMKQEAgLTc3MDYsNyArNzcwNiw3IEBAIHN0YXRpYyBpbnQgcGF0Y2hfYWxjMjY5KHN0cnVj
dCBoZGFfY29kZWMgKmNvZGVjKQogCiAJc3BlYyA9IGNvZGVjLT5zcGVjOwogCXNwZWMtPmdlbi5z
aGFyZWRfbWljX3ZyZWZfcGluID0gMHgxODsKLQljb2RlYy0+cG93ZXJfc2F2ZV9ub2RlID0gMTsK
Kwljb2RlYy0+cG93ZXJfc2F2ZV9ub2RlID0gMDsKIAogI2lmZGVmIENPTkZJR19QTQogCWNvZGVj
LT5wYXRjaF9vcHMuc3VzcGVuZCA9IGFsYzI2OV9zdXNwZW5kOwo=

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D766DC0RTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A1D766DC0RTITMBSVM07real_--
