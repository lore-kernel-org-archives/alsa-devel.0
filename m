From: Kailang <kailang@realtek.com>
Subject: Re: HP mute led for ALC286
Date: Thu, 20 Nov 2014 07:04:01 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A179FB92A@RTITMBSV09.realtek.com.tw>
References: <s5hr3x9qz5j.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A179FB004@RTITMBSV09.realtek.com.tw>
 <s5h8ujgrext.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A179FB7CA@RTITMBSV09.realtek.com.tw>
 <s5h8uj71lci.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A179FB92ARTITMBSV09realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A6BFF26587B
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 08:04:08 +0100 (CET)
In-Reply-To: <s5h8uj71lci.wl-tiwai@suse.de>
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

--_002_6FAB7C47BCF00940BB0999A99BE3547A179FB92ARTITMBSV09realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]=20
> Sent: Wednesday, November 19, 2014 7:28 PM
> To: Kailang
> Cc: (alsa-devel@alsa-project.org)
> Subject: Re: HP mute led for ALC286
>=20
> At Wed, 19 Nov 2014 07:13:16 +0000,
> Kailang wrote:
> >=20
> > Hi Takashi,
> >=20
> > I had sent the discussion mail about the DMI string for HP.
> > But no body response.
> > So, I just send the patch to fix this issue.
>=20
> I'd like to avoid the duplicated open codes, so could you try=20
> the patch below and rewrite your patch to follow this?  You'd=20
> just need to set like:
>   spec->gpio_mute_led_mask =3D 0x02;
>   spec->gpio_mic_led_mask =3D 0x20;
>   pec->mute_led_polarity =3D 0;
> then you can use the existing alc_fixup_gpio_mute_hook and=20
> alc_fixup_gpio_mic_mute_hook.

I modified as attach patch. ^^

>=20
>=20
> thanks,
>=20
> Takashi
>=20
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda/realtek - Clean up mute/mic GPIO=20
> LED handling
>=20
> There are a few duplicated codes handling the mute and=20
> mic-mute LEDs via GPIO pins.  Let's consolidate to single=20
> helpers.  Here we introduced two new fields to alc_spec,=20
> gpio_mute_led_mask and gpio_mic_led_mask, to contain the bit=20
> mask to set/clear.  Also, mute_led_polarity is evaluated as well.
>=20
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/patch_realtek.c | 81=20
> +++++++++++++++++++++----------------------
>  1 file changed, 40 insertions(+), 41 deletions(-)
>=20
> diff --git a/sound/pci/hda/patch_realtek.c=20
> b/sound/pci/hda/patch_realtek.c index=20
> 1af917f58a70..3c29a558e7db 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -96,6 +96,8 @@ struct alc_spec {
>  	hda_nid_t cap_mute_led_nid;
> =20
>  	unsigned int gpio_led; /* used for alc269_fixup_hp_gpio_led() */
> +	unsigned int gpio_mute_led_mask;
> +	unsigned int gpio_mic_led_mask;
> =20
>  	hda_nid_t headset_mic_pin;
>  	hda_nid_t headphone_mic_pin;
> @@ -3235,41 +3237,45 @@ static void=20
> alc269_fixup_hp_mute_led_mic2(struct hda_codec *codec,
>  	}
>  }
> =20
> -/* turn on/off mute LED per vmaster hook */ -static void=20
> alc269_fixup_hp_gpio_mute_hook(void *private_data, int enabled)
> +/* update LED status via GPIO */
> +static void alc_update_gpio_led(struct hda_codec *codec,=20
> unsigned int mask,
> +				bool enabled)
>  {
> -	struct hda_codec *codec =3D private_data;
>  	struct alc_spec *spec =3D codec->spec;
>  	unsigned int oldval =3D spec->gpio_led;
> =20
> +	if (spec->mute_led_polarity)
> +		enabled =3D !enabled;
> +
>  	if (enabled)
> -		spec->gpio_led &=3D ~0x08;
> +		spec->gpio_led &=3D ~mask;
>  	else
> -		spec->gpio_led |=3D 0x08;
> +		spec->gpio_led |=3D mask;
>  	if (spec->gpio_led !=3D oldval)
>  		snd_hda_codec_write(codec, 0x01, 0,=20
> AC_VERB_SET_GPIO_DATA,
>  				    spec->gpio_led);
>  }
> =20
> -/* turn on/off mic-mute LED per capture hook */ -static void=20
> alc269_fixup_hp_gpio_mic_mute_hook(struct hda_codec *codec,
> -					       struct=20
> snd_kcontrol *kcontrol,
> -					       struct=20
> snd_ctl_elem_value *ucontrol)
> +/* turn on/off mute LED via GPIO per vmaster hook */ static void=20
> +alc_fixup_gpio_mute_hook(void *private_data, int enabled)
>  {
> +	struct hda_codec *codec =3D private_data;
>  	struct alc_spec *spec =3D codec->spec;
> -	unsigned int oldval =3D spec->gpio_led;
> =20
> -	if (!ucontrol)
> -		return;
> +	alc_update_gpio_led(codec, spec->gpio_mute_led_mask, enabled); }
> =20
> -	if (ucontrol->value.integer.value[0] ||
> -	    ucontrol->value.integer.value[1])
> -		spec->gpio_led &=3D ~0x10;
> -	else
> -		spec->gpio_led |=3D 0x10;
> -	if (spec->gpio_led !=3D oldval)
> -		snd_hda_codec_write(codec, 0x01, 0,=20
> AC_VERB_SET_GPIO_DATA,
> -				    spec->gpio_led);
> +/* turn on/off mic-mute LED via GPIO per capture hook */ static void=20
> +alc_fixup_gpio_mic_mute_hook(struct hda_codec *codec,
> +					 struct snd_kcontrol *kcontrol,
> +					 struct=20
> snd_ctl_elem_value *ucontrol) {
> +	struct alc_spec *spec =3D codec->spec;
> +
> +	if (ucontrol)
> +		alc_update_gpio_led(codec, spec->gpio_mic_led_mask,
> +				    ucontrol->value.integer.value[0] ||
> +				    ucontrol->value.integer.value[1]);
>  }
> =20
>  static void alc269_fixup_hp_gpio_led(struct hda_codec=20
> *codec, @@ -3283,9 +3289,12 @@ static void=20
> alc269_fixup_hp_gpio_led(struct hda_codec *codec,
>  	};
> =20
>  	if (action =3D=3D HDA_FIXUP_ACT_PRE_PROBE) {
> -		spec->gen.vmaster_mute.hook =3D=20
> alc269_fixup_hp_gpio_mute_hook;
> -		spec->gen.cap_sync_hook =3D=20
> alc269_fixup_hp_gpio_mic_mute_hook;
> +		spec->gen.vmaster_mute.hook =3D alc_fixup_gpio_mute_hook;
> +		spec->gen.cap_sync_hook =3D alc_fixup_gpio_mic_mute_hook;
>  		spec->gpio_led =3D 0;
> +		spec->mute_led_polarity =3D 0;
> +		spec->gpio_mute_led_mask =3D 0x08;
> +		spec->gpio_mic_led_mask =3D 0x10;
>  		snd_hda_add_verbs(codec, gpio_init);
>  	}
>  }
> @@ -3327,9 +3336,11 @@ static void=20
> alc269_fixup_hp_gpio_mic1_led(struct hda_codec *codec,
>  	};
> =20
>  	if (action =3D=3D HDA_FIXUP_ACT_PRE_PROBE) {
> -		spec->gen.vmaster_mute.hook =3D=20
> alc269_fixup_hp_gpio_mute_hook;
> +		spec->gen.vmaster_mute.hook =3D alc_fixup_gpio_mute_hook;
>  		spec->gen.cap_sync_hook =3D=20
> alc269_fixup_hp_cap_mic_mute_hook;
>  		spec->gpio_led =3D 0;
> +		spec->mute_led_polarity =3D 0;
> +		spec->gpio_mute_led_mask =3D 0x08;
>  		spec->cap_mute_led_nid =3D 0x18;
>  		snd_hda_add_verbs(codec, gpio_init);
>  		codec->power_filter =3D led_power_filter; @@=20
> -3348,9 +3359,11 @@ static void alc280_fixup_hp_gpio4(struct=20
> hda_codec *codec,
>  	};
> =20
>  	if (action =3D=3D HDA_FIXUP_ACT_PRE_PROBE) {
> -		spec->gen.vmaster_mute.hook =3D=20
> alc269_fixup_hp_gpio_mute_hook;
> +		spec->gen.vmaster_mute.hook =3D alc_fixup_gpio_mute_hook;
>  		spec->gen.cap_sync_hook =3D=20
> alc269_fixup_hp_cap_mic_mute_hook;
>  		spec->gpio_led =3D 0;
> +		spec->mute_led_polarity =3D 0;
> +		spec->gpio_mute_led_mask =3D 0x08;
>  		spec->cap_mute_led_nid =3D 0x18;
>  		snd_hda_add_verbs(codec, gpio_init);
>  		codec->power_filter =3D led_power_filter; @@=20
> -5624,22 +5637,6 @@ static void alc_fixup_bass_chmap(struct=20
> hda_codec *codec,
>  	}
>  }
> =20
> -/* turn on/off mute LED per vmaster hook */ -static void=20
> alc662_led_gpio1_mute_hook(void *private_data, int enabled) -{
> -	struct hda_codec *codec =3D private_data;
> -	struct alc_spec *spec =3D codec->spec;
> -	unsigned int oldval =3D spec->gpio_led;
> -
> -	if (enabled)
> -		spec->gpio_led |=3D 0x01;
> -	else
> -		spec->gpio_led &=3D ~0x01;
> -	if (spec->gpio_led !=3D oldval)
> -		snd_hda_codec_write(codec, 0x01, 0,=20
> AC_VERB_SET_GPIO_DATA,
> -				    spec->gpio_led);
> -}
> -
>  /* avoid D3 for keeping GPIO up */
>  static unsigned int gpio_led_power_filter(struct hda_codec *codec,
>  					  hda_nid_t nid,
> @@ -5662,8 +5659,10 @@ static void=20
> alc662_fixup_led_gpio1(struct hda_codec *codec,
>  	};
> =20
>  	if (action =3D=3D HDA_FIXUP_ACT_PRE_PROBE) {
> -		spec->gen.vmaster_mute.hook =3D=20
> alc662_led_gpio1_mute_hook;
> +		spec->gen.vmaster_mute.hook =3D alc_fixup_gpio_mute_hook;
>  		spec->gpio_led =3D 0;
> +		spec->mute_led_polarity =3D 1;
> +		spec->gpio_mute_led_mask =3D 0x01;
>  		snd_hda_add_verbs(codec, gpio_init);
>  		codec->power_filter =3D gpio_led_power_filter;
>  	}
> --
> 2.1.3
>=20
>=20
> ------Please consider the environment before printing this e-mail.
> =

--_002_6FAB7C47BCF00940BB0999A99BE3547A179FB92ARTITMBSV09realt_
Content-Type: application/octet-stream;
	name="0001-supported-HP-mute-led-alc286.patch"
Content-Description: 0001-supported-HP-mute-led-alc286.patch
Content-Disposition: attachment;
	filename="0001-supported-HP-mute-led-alc286.patch"; size=3572;
	creation-date="Thu, 20 Nov 2014 07:05:50 GMT";
	modification-date="Thu, 20 Nov 2014 06:59:29 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwMzliMTJmNzdmZGNiMWY3NWE5NjRmYmY3ODFkY2M1N2M0YTE4ZGVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFRodSwgMjAgTm92IDIwMTQgMTQ6NTg6MDggKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIFN1cHBvcnRlZCBIUCBtdXRlIExlZCBmb3IgQUxDMjg2CgpOZXcgSFAg
bWFjaGluZSBzdXBwb3J0ZWQgb3V0cHV0IG11dGUgbGVkIGFuZCBpbnB1dCBtdXRlIGxlZC4KQUxD
Mjg2OgpHUElPMSB0byBjb250cm9sIG91dHB1dCBtdXRlIGxlZC4KR1BJTzUgdG8gY29udHJvbCBp
bnB1dCBtdXRlIGxlZC4KClNpZ25lZC1vZmYtYnk6IEthaWxhbmcgWWFuZyA8a2FpbGFuZ0ByZWFs
dGVrLmNvbT4KCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBiL3Nv
dW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmluZGV4IDhmZWExYjguLjI4MzE2ZjggMTAwNjQ0
Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBiL3NvdW5kL3BjaS9oZGEv
cGF0Y2hfcmVhbHRlay5jCkBAIC05Miw2ICs5Miw4IEBAIHN0cnVjdCBhbGNfc3BlYyB7CiAKIAkv
KiBtdXRlIExFRCBmb3IgSFAgbGFwdG9wcywgc2VlIGFsYzI2OV9maXh1cF9taWNfbXV0ZV9ob29r
KCkgKi8KIAlpbnQgbXV0ZV9sZWRfcG9sYXJpdHk7CisJdW5zaWduZWQgaW50IGdwaW9fc3BrX211
dGVfbGVkX21hc2s7CisJdW5zaWduZWQgaW50IGdwaW9fbWljX211dGVfbGVkX21hc2s7CiAJaGRh
X25pZF90IG11dGVfbGVkX25pZDsKIAloZGFfbmlkX3QgY2FwX211dGVfbGVkX25pZDsKIApAQCAt
MzMxMSwyMyArMzMxMywyMyBAQCBzdGF0aWMgdm9pZCBhbGMyNjlfZml4dXBfaHBfbXV0ZV9sZWRf
bWljMihzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywKIH0KIAogLyogdHVybiBvbi9vZmYgbXV0ZSBM
RUQgcGVyIHZtYXN0ZXIgaG9vayAqLwotc3RhdGljIHZvaWQgYWxjMjY5X2ZpeHVwX2hwX2dwaW9f
bXV0ZV9ob29rKHZvaWQgKnByaXZhdGVfZGF0YSwgaW50IGVuYWJsZWQpCitzdGF0aWMgdm9pZCBh
bGNfZml4dXBfaHBfZ3Bpb19tdXRlX2hvb2sodm9pZCAqcHJpdmF0ZV9kYXRhLCBpbnQgZW5hYmxl
ZCkKIHsKIAlzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYyA9IHByaXZhdGVfZGF0YTsKIAlzdHJ1Y3Qg
YWxjX3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsKIAl1bnNpZ25lZCBpbnQgb2xkdmFsID0gc3Bl
Yy0+Z3Bpb19sZWQ7CiAKIAlpZiAoZW5hYmxlZCkKLQkJc3BlYy0+Z3Bpb19sZWQgJj0gfjB4MDg7
CisJCXNwZWMtPmdwaW9fbGVkICY9IH5zcGVjLT5ncGlvX3Nwa19tdXRlX2xlZF9tYXNrOwogCWVs
c2UKLQkJc3BlYy0+Z3Bpb19sZWQgfD0gMHgwODsKKwkJc3BlYy0+Z3Bpb19sZWQgfD0gc3BlYy0+
Z3Bpb19zcGtfbXV0ZV9sZWRfbWFzazsKIAlpZiAoc3BlYy0+Z3Bpb19sZWQgIT0gb2xkdmFsKQog
CQlzbmRfaGRhX2NvZGVjX3dyaXRlKGNvZGVjLCAweDAxLCAwLCBBQ19WRVJCX1NFVF9HUElPX0RB
VEEsCiAJCQkJICAgIHNwZWMtPmdwaW9fbGVkKTsKIH0KIAogLyogdHVybiBvbi9vZmYgbWljLW11
dGUgTEVEIHBlciBjYXB0dXJlIGhvb2sgKi8KLXN0YXRpYyB2b2lkIGFsYzI2OV9maXh1cF9ocF9n
cGlvX21pY19tdXRlX2hvb2soc3RydWN0IGhkYV9jb2RlYyAqY29kZWMsCitzdGF0aWMgdm9pZCBh
bGNfZml4dXBfaHBfZ3Bpb19taWNfbXV0ZV9ob29rKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLAog
CQkJCQkgICAgICAgc3RydWN0IHNuZF9rY29udHJvbCAqa2NvbnRyb2wsCiAJCQkJCSAgICAgICBz
dHJ1Y3Qgc25kX2N0bF9lbGVtX3ZhbHVlICp1Y29udHJvbCkKIHsKQEAgLTMzMzksOSArMzM0MSw5
IEBAIHN0YXRpYyB2b2lkIGFsYzI2OV9maXh1cF9ocF9ncGlvX21pY19tdXRlX2hvb2soc3RydWN0
IGhkYV9jb2RlYyAqY29kZWMsCiAKIAlpZiAodWNvbnRyb2wtPnZhbHVlLmludGVnZXIudmFsdWVb
MF0gfHwKIAkgICAgdWNvbnRyb2wtPnZhbHVlLmludGVnZXIudmFsdWVbMV0pCi0JCXNwZWMtPmdw
aW9fbGVkICY9IH4weDEwOworCQlzcGVjLT5ncGlvX2xlZCAmPSB+c3BlYy0+Z3Bpb19taWNfbXV0
ZV9sZWRfbWFzazsKIAllbHNlCi0JCXNwZWMtPmdwaW9fbGVkIHw9IDB4MTA7CisJCXNwZWMtPmdw
aW9fbGVkIHw9IHNwZWMtPmdwaW9fbWljX211dGVfbGVkX21hc2s7CiAJaWYgKHNwZWMtPmdwaW9f
bGVkICE9IG9sZHZhbCkKIAkJc25kX2hkYV9jb2RlY193cml0ZShjb2RlYywgMHgwMSwgMCwgQUNf
VkVSQl9TRVRfR1BJT19EQVRBLAogCQkJCSAgICBzcGVjLT5ncGlvX2xlZCk7CkBAIC0zMzU2LDEw
ICszMzU4LDMwIEBAIHN0YXRpYyB2b2lkIGFsYzI2OV9maXh1cF9ocF9ncGlvX2xlZChzdHJ1Y3Qg
aGRhX2NvZGVjICpjb2RlYywKIAkJeyAweDAxLCBBQ19WRVJCX1NFVF9HUElPX0RJUkVDVElPTiwg
MHgxOCB9LAogCQl7fQogCX07CisJc3BlYy0+Z3Bpb19zcGtfbXV0ZV9sZWRfbWFzayA9IDB4MDg7
CisJc3BlYy0+Z3Bpb19taWNfbXV0ZV9sZWRfbWFzayA9IDB4MTA7CisgCWlmIChhY3Rpb24gPT0g
SERBX0ZJWFVQX0FDVF9QUkVfUFJPQkUpIHsKKwkJc3BlYy0+Z2VuLnZtYXN0ZXJfbXV0ZS5ob29r
ID0gYWxjX2ZpeHVwX2hwX2dwaW9fbXV0ZV9ob29rOworCQlzcGVjLT5nZW4uY2FwX3N5bmNfaG9v
ayA9IGFsY19maXh1cF9ocF9ncGlvX21pY19tdXRlX2hvb2s7CisJCXNwZWMtPmdwaW9fbGVkID0g
MDsKKwkJc25kX2hkYV9hZGRfdmVyYnMoY29kZWMsIGdwaW9faW5pdCk7CisJfQorfQogCi0JaWYg
KGFjdGlvbiA9PSBIREFfRklYVVBfQUNUX1BSRV9QUk9CRSkgewotCQlzcGVjLT5nZW4udm1hc3Rl
cl9tdXRlLmhvb2sgPSBhbGMyNjlfZml4dXBfaHBfZ3Bpb19tdXRlX2hvb2s7Ci0JCXNwZWMtPmdl
bi5jYXBfc3luY19ob29rID0gYWxjMjY5X2ZpeHVwX2hwX2dwaW9fbWljX211dGVfaG9vazsKK3N0
YXRpYyB2b2lkIGFsYzI4Nl9maXh1cF9ocF9ncGlvX2xlZChzdHJ1Y3QgaGRhX2NvZGVjICpjb2Rl
YywKKwkJCQljb25zdCBzdHJ1Y3QgaGRhX2ZpeHVwICpmaXgsIGludCBhY3Rpb24pCit7CisJc3Ry
dWN0IGFsY19zcGVjICpzcGVjID0gY29kZWMtPnNwZWM7CisJc3RhdGljIGNvbnN0IHN0cnVjdCBo
ZGFfdmVyYiBncGlvX2luaXRbXSA9IHsKKwkJeyAweDAxLCBBQ19WRVJCX1NFVF9HUElPX01BU0ss
IDB4MjIgfSwKKwkJeyAweDAxLCBBQ19WRVJCX1NFVF9HUElPX0RJUkVDVElPTiwgMHgyMiB9LAor
CQl7fQorCX07CisJc3BlYy0+Z3Bpb19zcGtfbXV0ZV9sZWRfbWFzayA9IDB4MDI7CisJc3BlYy0+
Z3Bpb19taWNfbXV0ZV9sZWRfbWFzayA9IDB4MjA7CisgCWlmIChhY3Rpb24gPT0gSERBX0ZJWFVQ
X0FDVF9QUkVfUFJPQkUpIHsKKwkJc3BlYy0+Z2VuLnZtYXN0ZXJfbXV0ZS5ob29rID0gYWxjX2Zp
eHVwX2hwX2dwaW9fbXV0ZV9ob29rOworCQlzcGVjLT5nZW4uY2FwX3N5bmNfaG9vayA9IGFsY19m
aXh1cF9ocF9ncGlvX21pY19tdXRlX2hvb2s7CiAJCXNwZWMtPmdwaW9fbGVkID0gMDsKIAkJc25k
X2hkYV9hZGRfdmVyYnMoY29kZWMsIGdwaW9faW5pdCk7CiAJfQo=

--_002_6FAB7C47BCF00940BB0999A99BE3547A179FB92ARTITMBSV09realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A179FB92ARTITMBSV09realt_--
