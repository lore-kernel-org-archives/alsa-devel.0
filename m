From: Kailang <kailang@realtek.com>
Subject: Re: auto_mute for early patch issue
Date: Fri, 1 Feb 2019 09:18:45 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18DB8879@RTITMBSVM07.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A18DB7608@RTITMBSVM07.realtek.com.tw>
 <s5hpnsdck29.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A18DB85D8@RTITMBSVM07.realtek.com.tw>
 <s5hy371ay4b.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A18DB8879RTITMBSVM07real_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 890F02666B3
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2019 10:18:51 +0100 (CET)
In-Reply-To: <s5hy371ay4b.wl-tiwai@suse.de>
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

--_002_6FAB7C47BCF00940BB0999A99BE3547A18DB8879RTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

I forgot it solved this issue for ALC283 before. It was also chrome OS case=
.
I cooked attach patch. It will not need to move spec->suppress_auto_mute ch=
eck line.
Many thanks.

BR,
Kailang

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>=20
Sent: Thursday, January 31, 2019 7:02 PM
To: Kailang <kailang@realtek.com>
Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
Subject: Re: auto_mute for early patch issue

On Thu, 31 Jan 2019 11:50:26 +0100,
Kailang wrote:
>=20
> Hi Takashi,
>=20
> spec->suppress_auto_mute =3D 1;
> This will cause spec->gen.autocfg.hp_pins [0] =3D 0.
> This will cause alc2??_init() and alc2??_shutup() and dell headset mode n=
ot run errors.

That's the result with your suggested change (moving
spec->supress_auto_mute_mode in check_auto_mute_availability()) ??


Takashi

>=20
> Does it has other place to store pin NID?=20
> Or just only this place hp_pin =3D spec->gen.autocfg.hp_pins[0]; to get h=
eadphone NID.
>=20
> BR,
> Kailang
>=20
> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>=20
> Sent: Thursday, January 31, 2019 4:23 PM
> To: Kailang <kailang@realtek.com>
> Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> Subject: Re: auto_mute for early patch issue
>=20
> On Thu, 31 Jan 2019 09:00:36 +0100,
> Kailang wrote:
> >=20
> > Hi Takashi,
> >=20
> > I move check line to below. It will show value for hp_pins[0].
> > As I know, search from verb table in function snd_hda_parse_pin_defcfg(=
).
> > It will fill pins at auto_pin_cfg.
> > Why it need to run below function to get cfg->hp_pins?
>=20
> It's just because hp_pins[] and speaker_pins[] are used for the case with=
 the auto-mute, so far, not for other evaluations :)
>=20
> The change below looks safe, so if this works for you, feel fee to apply =
like that.
>=20
>=20
> thanks,
>=20
> Takashi
>=20
>=20
> > static int check_auto_mute_availability(struct hda_codec *codec) {
> > 	struct hda_gen_spec *spec =3D codec->spec;
> > 	struct auto_pin_cfg *cfg =3D &spec->autocfg;
> > 	int present =3D 0;
> > 	int i, err;
> >=20
> > -	if (spec->suppress_auto_mute)
> > -		return 0;
> >=20
> > 	if (cfg->hp_pins[0])
> > 		present++;
> > 	if (cfg->line_out_pins[0])
> > 		present++;
> > 	if (cfg->speaker_pins[0])
> > 		present++;
> > 	if (present < 2) /* need two different output types */
> > 		return 0;
> >=20
> > 	if (!cfg->speaker_pins[0] &&
> > 	    cfg->line_out_type =3D=3D AUTO_PIN_SPEAKER_OUT) {
> > 		memcpy(cfg->speaker_pins, cfg->line_out_pins,
> > 		       sizeof(cfg->speaker_pins));
> > 		cfg->speaker_outs =3D cfg->line_outs;
> > 	}
> >=20
> > 	if (!cfg->hp_pins[0] &&
> > 	    cfg->line_out_type =3D=3D AUTO_PIN_HP_OUT) {
> > 		memcpy(cfg->hp_pins, cfg->line_out_pins,
> > 		       sizeof(cfg->hp_pins));
> > 		cfg->hp_outs =3D cfg->line_outs;
> > 	}
> >=20
> > +	if (spec->suppress_auto_mute)
> > +		return 0;
> >=20
> > ......
> > .....
> > ......
> > }
> >=20
> > BR,
> > Kailang
> >=20
> > -----Original Message-----
> > From: Kailang
> > Sent: Thursday, January 31, 2019 12:08 PM
> > To: Takashi Iwai (tiwai@suse.de) <tiwai@suse.de>
> > Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> > Subject: auto_mute for early patch issue
> >=20
> > Hi Takashi,
> >=20
> > Chrome OS use early patch firmware file to load model and use auto_mute=
 =3Dno hint options.
> > I find an issue for early patch issue about hint option auto_mute =3D n=
o.
> >=20
> > This will cause all spec->init_hook can't get hp_pin values.
> >=20
> > For example: alc225_init() alc225_shutup() alc256_init() alc256_shutup(=
) Early patch file hint auto_mute =3D no equal spec->suppress_auto_mute =3D=
 1 It will return function check_auto_mute_availability() in had_generic.c.
> >=20
> > hp_pin =3D spec->gen.autocfg.hp_pins[0];  =3D=3D> It will get value 0.
> >=20
> > I think this issue was for a long time.
> > Please see the attach dmesg. One is kill hint auto_mute option.=20
> >=20
> > BR,
> > Kailang
> >=20
>=20
> ------Please consider the environment before printing this e-mail.
>=20

--_002_6FAB7C47BCF00940BB0999A99BE3547A18DB8879RTITMBSVM07real_
Content-Type: application/octet-stream; name="0000-fix-lose-hp-pins.patch"
Content-Description: 0000-fix-lose-hp-pins.patch
Content-Disposition: attachment; filename="0000-fix-lose-hp-pins.patch";
	size=3960; creation-date="Fri, 01 Feb 2019 08:58:00 GMT";
	modification-date="Fri, 01 Feb 2019 09:17:27 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyYmZhODhhNjZjYTEzMmNjZmFlYmMxN2VmYjZjNjQ3YjJkNWM2MjkyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IEZyaSwgMSBGZWIgMjAxOSAxNjo1MToxMCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYS9yZWFsdGVrIC0gRml4IGxvc2UgaHBfcGlucyBmb3IgZGlzYWJsZSBhdXRvIG11dGUKCldo
ZW4gYXV0b19tdXRlID0gbm8gb3Igc3BlYy0+c3VwcHJlc3NfYXV0b19tdXRlID0gMSwgY2ZnLT5o
cF9waW5zIHdpbGwgbG9zZSB2YWx1ZS4KQWRkIHRoaXMgcGF0Y2ggdG8gZmluZCBocF9waW5zIHZh
bHVlLgpJIGFkZCBmaXhlZCBmb3IgQUxDMjgyIEFMQzIyNSBBTEMyNTYgQUxDMjk0IGFuZCBhbGNf
ZGVmYXVsdF9pbml0KCkgYWxjX2RlZmF1bHRfc2h1dHVwKCkuCgpTaWduZWQtb2ZmLWJ5OiBLYWls
YW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hk
YS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwppbmRleCBl
OWRjOTQwLi43NDg2NGU2IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsu
YworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAtMjk2Myw2ICsyOTYzLDEx
IEBAIHN0YXRpYyB2b2lkIGFsYzI4Ml9pbml0KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCWJv
b2wgaHBfcGluX3NlbnNlOwogCWludCBjb2VmNzg7CiAKKwlpZiAoIXNwZWMtPmdlbi5hdXRvY2Zn
LmhwX291dHMgJiYgc3BlYy0+Z2VuLnN1cHByZXNzX2F1dG9fbXV0ZSkgeworCQlpZiAoc3BlYy0+
Z2VuLmF1dG9jZmcubGluZV9vdXRfdHlwZSA9PSBBQ19KQUNLX0hQX09VVCkKKwkJCWhwX3BpbiA9
IHNwZWMtPmdlbi5hdXRvY2ZnLmxpbmVfb3V0X3BpbnNbMF07CisJfQorCiAJYWxjMjgyX3Jlc3Rv
cmVfZGVmYXVsdF92YWx1ZShjb2RlYyk7CiAKIAlpZiAoIWhwX3BpbikKQEAgLTMwMDAsNiArMzAw
NSwxMSBAQCBzdGF0aWMgdm9pZCBhbGMyODJfc2h1dHVwKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVj
KQogCWJvb2wgaHBfcGluX3NlbnNlOwogCWludCBjb2VmNzg7CiAKKwlpZiAoIXNwZWMtPmdlbi5h
dXRvY2ZnLmhwX291dHMgJiYgc3BlYy0+Z2VuLnN1cHByZXNzX2F1dG9fbXV0ZSkgeworCQlpZiAo
c3BlYy0+Z2VuLmF1dG9jZmcubGluZV9vdXRfdHlwZSA9PSBBQ19KQUNLX0hQX09VVCkKKwkJCWhw
X3BpbiA9IHNwZWMtPmdlbi5hdXRvY2ZnLmxpbmVfb3V0X3BpbnNbMF07CisJfQorCiAJaWYgKCFo
cF9waW4pIHsKIAkJYWxjMjY5X3NodXR1cChjb2RlYyk7CiAJCXJldHVybjsKQEAgLTMxNTksNiAr
MzE2OSwxMSBAQCBzdGF0aWMgdm9pZCBhbGMyNTZfaW5pdChzdHJ1Y3QgaGRhX2NvZGVjICpjb2Rl
YykKIAloZGFfbmlkX3QgaHBfcGluID0gc3BlYy0+Z2VuLmF1dG9jZmcuaHBfcGluc1swXTsKIAli
b29sIGhwX3Bpbl9zZW5zZTsKIAorCWlmICghc3BlYy0+Z2VuLmF1dG9jZmcuaHBfb3V0cyAmJiBz
cGVjLT5nZW4uc3VwcHJlc3NfYXV0b19tdXRlKSB7CisJCWlmIChzcGVjLT5nZW4uYXV0b2NmZy5s
aW5lX291dF90eXBlID09IEFDX0pBQ0tfSFBfT1VUKQorCQkJaHBfcGluID0gc3BlYy0+Z2VuLmF1
dG9jZmcubGluZV9vdXRfcGluc1swXTsKKwl9CisKIAlpZiAoIWhwX3BpbikKIAkJcmV0dXJuOwog
CkBAIC0zMTk1LDYgKzMyMTAsMTEgQEAgc3RhdGljIHZvaWQgYWxjMjU2X3NodXR1cChzdHJ1Y3Qg
aGRhX2NvZGVjICpjb2RlYykKIAloZGFfbmlkX3QgaHBfcGluID0gc3BlYy0+Z2VuLmF1dG9jZmcu
aHBfcGluc1swXTsKIAlib29sIGhwX3Bpbl9zZW5zZTsKIAorCWlmICghc3BlYy0+Z2VuLmF1dG9j
ZmcuaHBfb3V0cyAmJiBzcGVjLT5nZW4uc3VwcHJlc3NfYXV0b19tdXRlKSB7CisJCWlmIChzcGVj
LT5nZW4uYXV0b2NmZy5saW5lX291dF90eXBlID09IEFDX0pBQ0tfSFBfT1VUKQorCQkJaHBfcGlu
ID0gc3BlYy0+Z2VuLmF1dG9jZmcubGluZV9vdXRfcGluc1swXTsKKwl9CisKIAlpZiAoIWhwX3Bp
bikgewogCQlhbGMyNjlfc2h1dHVwKGNvZGVjKTsKIAkJcmV0dXJuOwpAQCAtMzIzMSw2ICszMjUx
LDExIEBAIHN0YXRpYyB2b2lkIGFsYzIyNV9pbml0KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQog
CWhkYV9uaWRfdCBocF9waW4gPSBzcGVjLT5nZW4uYXV0b2NmZy5ocF9waW5zWzBdOwogCWJvb2wg
aHAxX3Bpbl9zZW5zZSwgaHAyX3Bpbl9zZW5zZTsKIAorCWlmICghc3BlYy0+Z2VuLmF1dG9jZmcu
aHBfb3V0cyAmJiBzcGVjLT5nZW4uc3VwcHJlc3NfYXV0b19tdXRlKSB7CisJCWlmIChzcGVjLT5n
ZW4uYXV0b2NmZy5saW5lX291dF90eXBlID09IEFDX0pBQ0tfSFBfT1VUKQorCQkJaHBfcGluID0g
c3BlYy0+Z2VuLmF1dG9jZmcubGluZV9vdXRfcGluc1swXTsKKwl9CisKIAlpZiAoIWhwX3BpbikK
IAkJcmV0dXJuOwogCkBAIC0zMjc0LDYgKzMyOTksMTEgQEAgc3RhdGljIHZvaWQgYWxjMjI1X3No
dXR1cChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIAloZGFfbmlkX3QgaHBfcGluID0gc3BlYy0+
Z2VuLmF1dG9jZmcuaHBfcGluc1swXTsKIAlib29sIGhwMV9waW5fc2Vuc2UsIGhwMl9waW5fc2Vu
c2U7CiAKKwlpZiAoIXNwZWMtPmdlbi5hdXRvY2ZnLmhwX291dHMgJiYgc3BlYy0+Z2VuLnN1cHBy
ZXNzX2F1dG9fbXV0ZSkgeworCQlpZiAoc3BlYy0+Z2VuLmF1dG9jZmcubGluZV9vdXRfdHlwZSA9
PSBBQ19KQUNLX0hQX09VVCkKKwkJCWhwX3BpbiA9IHNwZWMtPmdlbi5hdXRvY2ZnLmxpbmVfb3V0
X3BpbnNbMF07CisJfQorCiAJaWYgKCFocF9waW4pIHsKIAkJYWxjMjY5X3NodXR1cChjb2RlYyk7
CiAJCXJldHVybjsKQEAgLTMzMTgsNiArMzM0OCwxMSBAQCBzdGF0aWMgdm9pZCBhbGNfZGVmYXVs
dF9pbml0KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCWhkYV9uaWRfdCBocF9waW4gPSBzcGVj
LT5nZW4uYXV0b2NmZy5ocF9waW5zWzBdOwogCWJvb2wgaHBfcGluX3NlbnNlOwogCisJaWYgKCFz
cGVjLT5nZW4uYXV0b2NmZy5ocF9vdXRzICYmIHNwZWMtPmdlbi5zdXBwcmVzc19hdXRvX211dGUp
IHsKKwkJaWYgKHNwZWMtPmdlbi5hdXRvY2ZnLmxpbmVfb3V0X3R5cGUgPT0gQUNfSkFDS19IUF9P
VVQpCisJCQlocF9waW4gPSBzcGVjLT5nZW4uYXV0b2NmZy5saW5lX291dF9waW5zWzBdOworCX0K
KwogCWlmICghaHBfcGluKQogCQlyZXR1cm47CiAKQEAgLTMzNDcsNiArMzM4MiwxMSBAQCBzdGF0
aWMgdm9pZCBhbGNfZGVmYXVsdF9zaHV0dXAoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCiAJaGRh
X25pZF90IGhwX3BpbiA9IHNwZWMtPmdlbi5hdXRvY2ZnLmhwX3BpbnNbMF07CiAJYm9vbCBocF9w
aW5fc2Vuc2U7CiAKKwlpZiAoIXNwZWMtPmdlbi5hdXRvY2ZnLmhwX291dHMgJiYgc3BlYy0+Z2Vu
LnN1cHByZXNzX2F1dG9fbXV0ZSkgeworCQlpZiAoc3BlYy0+Z2VuLmF1dG9jZmcubGluZV9vdXRf
dHlwZSA9PSBBQ19KQUNLX0hQX09VVCkKKwkJCWhwX3BpbiA9IHNwZWMtPmdlbi5hdXRvY2ZnLmxp
bmVfb3V0X3BpbnNbMF07CisJfQorCiAJaWYgKCFocF9waW4pIHsKIAkJYWxjMjY5X3NodXR1cChj
b2RlYyk7CiAJCXJldHVybjsKQEAgLTMzNzksNiArMzQxOSwxMSBAQCBzdGF0aWMgdm9pZCBhbGMy
OTRfaHBfaW5pdChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIAloZGFfbmlkX3QgaHBfcGluID0g
c3BlYy0+Z2VuLmF1dG9jZmcuaHBfcGluc1swXTsKIAlpbnQgaSwgdmFsOwogCisJaWYgKCFzcGVj
LT5nZW4uYXV0b2NmZy5ocF9vdXRzICYmIHNwZWMtPmdlbi5zdXBwcmVzc19hdXRvX211dGUpIHsK
KwkJaWYgKHNwZWMtPmdlbi5hdXRvY2ZnLmxpbmVfb3V0X3R5cGUgPT0gQUNfSkFDS19IUF9PVVQp
CisJCQlocF9waW4gPSBzcGVjLT5nZW4uYXV0b2NmZy5saW5lX291dF9waW5zWzBdOworCX0KKwog
CWlmICghaHBfcGluKQogCQlyZXR1cm47CiAK

--_002_6FAB7C47BCF00940BB0999A99BE3547A18DB8879RTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A18DB8879RTITMBSVM07real_--
