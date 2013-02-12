From: Fernando Luis Vazquez Cao <fernando_b1@lab.ntt.co.jp>
Subject: Re: [PATCH 2/3] ALSA: hda - no-primary-hp is a quirk for model ALC889
 not ALC882
Date: Tue, 12 Feb 2013 17:01:48 +0900
Message-ID: <5119F6EC.5090509@lab.ntt.co.jp>
References: <1360655264.13766.2.camel@nexus.lab.ntt.co.jp> <1360655656.13766.6.camel@nexus.lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360655656.13766.6.camel@nexus.lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Iwai,

Ouch, the subject reads "[PATCH 2/3]" but this is patch 3 of the series
and should be applied last. I am sorry for the noise.

Thanks,
=46ernando


On 2013/02/12 16:54, Fernando Luis V=C3=A1zquez Cao wrote:
> Substitute ALC889 for ALC882 in macro and function names.
>
> Cc: stable@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
> ---
>
> diff -urNp linux-3.7.6-orig/sound/pci/hda/patch_realtek.c linux-3.7.6=
/sound/pci/hda/patch_realtek.c
> --- linux-3.7.6-orig/sound/pci/hda/patch_realtek.c	2013-02-09 22:52:4=
0.301209823 +0900
> +++ linux-3.7.6/sound/pci/hda/patch_realtek.c	2013-02-09 22:58:54.695=
063675 +0900
> @@ -5030,7 +5030,7 @@ enum {
>   	ALC889_FIXUP_MBP_VREF,
>   	ALC889_FIXUP_IMAC91_VREF,
>   	ALC882_FIXUP_INV_DMIC,
> -	ALC882_FIXUP_NO_PRIMARY_HP,
> +	ALC889_FIXUP_NO_PRIMARY_HP,
>   };
>  =20
>   static void alc889_fixup_coef(struct hda_codec *codec,
> @@ -5156,7 +5156,7 @@ static void alc889_fixup_imac91_vref(str
>    * Strangely, the speaker output doesn't work on Vaio Z and some Va=
io
>    * all-in-one desktop PCs (for example VGC-LN51JGB) through DAC 0x0=
5
>    */
> -static void alc882_fixup_no_primary_hp(struct hda_codec *codec,
> +static void alc889_fixup_no_primary_hp(struct hda_codec *codec,
>   				       const struct alc_fixup *fix, int action)
>   {
>   	struct alc_spec *spec =3D codec->spec;
> @@ -5350,9 +5350,9 @@ static const struct alc_fixup alc882_fix
>   		.type =3D ALC_FIXUP_FUNC,
>   		.v.func =3D alc_fixup_inv_dmic_0x12,
>   	},
> -	[ALC882_FIXUP_NO_PRIMARY_HP] =3D {
> +	[ALC889_FIXUP_NO_PRIMARY_HP] =3D {
>   		.type =3D ALC_FIXUP_FUNC,
> -		.v.func =3D alc882_fixup_no_primary_hp,
> +		.v.func =3D alc889_fixup_no_primary_hp,
>   	},
>   };
>  =20
> @@ -5388,8 +5388,8 @@ static const struct snd_pci_quirk alc882
>   	SND_PCI_QUIRK(0x1043, 0x1971, "Asus W2JC", ALC882_FIXUP_ASUS_W2JC)=
,
>   	SND_PCI_QUIRK(0x1043, 0x835f, "Asus Eee 1601", ALC888_FIXUP_EEE160=
1),
>   	SND_PCI_QUIRK(0x104d, 0x9047, "Sony Vaio TT", ALC889_FIXUP_VAIO_TT=
),
> -	SND_PCI_QUIRK(0x104d, 0x905a, "Sony Vaio Z", ALC882_FIXUP_NO_PRIMAR=
Y_HP),
> -	SND_PCI_QUIRK(0x104d, 0x9043, "Sony Vaio VGC-LN51JGB", ALC882_FIXUP=
_NO_PRIMARY_HP),
> +	SND_PCI_QUIRK(0x104d, 0x905a, "Sony Vaio Z", ALC889_FIXUP_NO_PRIMAR=
Y_HP),
> +	SND_PCI_QUIRK(0x104d, 0x9043, "Sony Vaio VGC-LN51JGB", ALC889_FIXUP=
_NO_PRIMARY_HP),
>  =20
>   	/* All Apple entries are in codec SSIDs */
>   	SND_PCI_QUIRK(0x106b, 0x00a0, "MacBookPro 3,1", ALC889_FIXUP_MBP_V=
REF),
> @@ -5432,7 +5432,7 @@ static const struct alc_model_fixup alc8
>   	{.id =3D ALC882_FIXUP_ACER_ASPIRE_8930G, .name =3D "acer-aspire-89=
30g"},
>   	{.id =3D ALC883_FIXUP_ACER_EAPD, .name =3D "acer-aspire"},
>   	{.id =3D ALC882_FIXUP_INV_DMIC, .name =3D "inv-dmic"},
> -	{.id =3D ALC882_FIXUP_NO_PRIMARY_HP, .name =3D "no-primary-hp"},
> +	{.id =3D ALC889_FIXUP_NO_PRIMARY_HP, .name =3D "no-primary-hp"},
>   	{}
>   };
