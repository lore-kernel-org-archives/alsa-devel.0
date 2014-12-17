From: Kailang <kailang@realtek.com>
Subject: Re: New codec support for ALC256
Date: Wed, 17 Dec 2014 09:43:50 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A17A02549@RTITMBSV09.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A17A024F2@RTITMBSV09.realtek.com.tw>
 <s5hsigews32.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A17A02549RTITMBSV09realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 94D65260836
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 10:43:56 +0100 (CET)
In-Reply-To: <s5hsigews32.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6FAB7C47BCF00940BB0999A99BE3547A17A02549RTITMBSV09realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi Takashi,

Oh! Sorry.
Attach again with eapd function.

BR,
Kailang=20

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]=20
> Sent: Wednesday, December 17, 2014 5:20 PM
> To: Kailang
> Cc: (alsa-devel@alsa-project.org)
> Subject: Re: New codec support for ALC256
>=20
> At Wed, 17 Dec 2014 07:56:56 +0000,
> Kailang wrote:
> >=20
> > Attach the patch.
>=20
> Don't we need the addition to alc_fill_eapd_coef()?
>=20
>=20
> thanks,
>=20
> Takashi
>=20
> ------Please consider the environment before printing this e-mail.
> =

--_002_6FAB7C47BCF00940BB0999A99BE3547A17A02549RTITMBSV09realt_
Content-Type: application/octet-stream; name="0001-new-alc256-support.patch"
Content-Description: 0001-new-alc256-support.patch
Content-Disposition: attachment; filename="0001-new-alc256-support.patch";
	size=1893; creation-date="Wed, 17 Dec 2014 09:41:49 GMT";
	modification-date="Wed, 17 Dec 2014 09:40:59 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhZjA5ZmM3NDUxZjhmMTllODNlYWU5MDk5NGVmYjY0NDI4MmU4NTliIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFdlZCwgMTcgRGVjIDIwMTQgMTc6Mzk6MDUgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIE5ldyBjb2RlYyBzdXBwb3J0IGZvciBBTEMyNTYKCkFkZCBuZXcgc3Vw
cG9ydCBmb3IgQUxDMjU2IGNvZGVjLgoKU2lnbmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWls
YW5nQHJlYWx0ZWsuY29tPgoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRl
ay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggYTcyMjA2Ny4uOGU0N2Nm
ZSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQv
cGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTMyMSw2ICszMjEsNyBAQCBzdGF0aWMgdm9pZCBh
bGNfZmlsbF9lYXBkX2NvZWYoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCiAJCWJyZWFrOwogCWNh
c2UgMHgxMGVjMDIzMzoKIAljYXNlIDB4MTBlYzAyNTU6CisJY2FzZSAweDEwZWMwMjU2OgogCWNh
c2UgMHgxMGVjMDI4MjoKIAljYXNlIDB4MTBlYzAyODM6CiAJY2FzZSAweDEwZWMwMjg2OgpAQCAt
MjY2MCw2ICsyNjYxLDcgQEAgZW51bSB7CiAJQUxDMjY5X1RZUEVfQUxDMjg1LAogCUFMQzI2OV9U
WVBFX0FMQzI4NiwKIAlBTEMyNjlfVFlQRV9BTEMyNTUsCisJQUxDMjY5X1RZUEVfQUxDMjU2LAog
fTsKIAogLyoKQEAgLTI2ODcsNiArMjY4OSw3IEBAIHN0YXRpYyBpbnQgYWxjMjY5X3BhcnNlX2F1
dG9fY29uZmlnKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCWNhc2UgQUxDMjY5X1RZUEVfQUxD
MjgzOgogCWNhc2UgQUxDMjY5X1RZUEVfQUxDMjg2OgogCWNhc2UgQUxDMjY5X1RZUEVfQUxDMjU1
OgorCWNhc2UgQUxDMjY5X1RZUEVfQUxDMjU2OgogCQlzc2lkcyA9IGFsYzI2OV9zc2lkczsKIAkJ
YnJlYWs7CiAJZGVmYXVsdDoKQEAgLTU0MjAsNiArNTQyMyw5IEBAIHN0YXRpYyBpbnQgcGF0Y2hf
YWxjMjY5KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCWNhc2UgMHgxMGVjMDI1NToKIAkJc3Bl
Yy0+Y29kZWNfdmFyaWFudCA9IEFMQzI2OV9UWVBFX0FMQzI1NTsKIAkJYnJlYWs7CisJY2FzZSAw
eDEwZWMwMjU2OgorCQlzcGVjLT5jb2RlY192YXJpYW50ID0gQUxDMjY5X1RZUEVfQUxDMjU2Owor
CQlicmVhazsKIAl9CiAKIAlpZiAoc25kX2hkYV9jb2RlY19yZWFkKGNvZGVjLCAweDUxLCAwLCBB
Q19WRVJCX1BBUkFNRVRFUlMsIDApID09IDB4MTBlYzU1MDUpIHsKQEAgLTYzNDEsNiArNjM0Nyw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaGRhX2NvZGVjX3ByZXNldCBzbmRfaGRhX3ByZXNldF9y
ZWFsdGVrW10gPSB7CiAJeyAuaWQgPSAweDEwZWMwMjMzLCAubmFtZSA9ICJBTEMyMzMiLCAucGF0
Y2ggPSBwYXRjaF9hbGMyNjkgfSwKIAl7IC5pZCA9IDB4MTBlYzAyMzUsIC5uYW1lID0gIkFMQzIz
MyIsIC5wYXRjaCA9IHBhdGNoX2FsYzI2OSB9LAogCXsgLmlkID0gMHgxMGVjMDI1NSwgLm5hbWUg
PSAiQUxDMjU1IiwgLnBhdGNoID0gcGF0Y2hfYWxjMjY5IH0sCisJeyAuaWQgPSAweDEwZWMwMjU2
LCAubmFtZSA9ICJBTEMyNTYiLCAucGF0Y2ggPSBwYXRjaF9hbGMyNjkgfSwKIAl7IC5pZCA9IDB4
MTBlYzAyNjAsIC5uYW1lID0gIkFMQzI2MCIsIC5wYXRjaCA9IHBhdGNoX2FsYzI2MCB9LAogCXsg
LmlkID0gMHgxMGVjMDI2MiwgLm5hbWUgPSAiQUxDMjYyIiwgLnBhdGNoID0gcGF0Y2hfYWxjMjYy
IH0sCiAJeyAuaWQgPSAweDEwZWMwMjY3LCAubmFtZSA9ICJBTEMyNjciLCAucGF0Y2ggPSBwYXRj
aF9hbGMyNjggfSwK

--_002_6FAB7C47BCF00940BB0999A99BE3547A17A02549RTITMBSV09realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A17A02549RTITMBSV09realt_--
