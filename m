From: Mihai =?UTF-8?B?RG9uyJt1?= <mihai.dontu@gmail.com>
Subject: Re: Audio crackles with 4.1-rc1
Date: Fri, 12 Jun 2015 20:28:09 +0300
Message-ID: <20150612202809.4ada983f@mdontu-l.dsd.bitdefender.biz>
References: <s5hpp6ov1wv.wl-tiwai@suse.de>
	<s5hd22l7dgo.wl-tiwai@suse.de>
	<20150502150513.GF10148@earth.li>
	<s5hk2w514aj.wl-tiwai@suse.de>
	<20150519161911.GD28070@earth.li>
	<s5hr3qctryf.wl-tiwai@suse.de>
	<20150519215310.GF28070@earth.li>
	<s5hd21vu9k7.wl-tiwai@suse.de>
	<20150610131755.0b906783@mdontu-l.dsd.bitdefender.biz>
	<s5h4mmfooaq.wl-tiwai@suse.de>
	<20150610134135.327e2bdc@mdontu-l.dsd.bitdefender.biz>
	<s5hvbevn8gh.wl-tiwai@suse.de>
	<20150610144551.4578ee99@mdontu-l.dsd.bitdefender.biz>
	<s5hpp53n3o9.wl-tiwai@suse.de>
	<s5hlhfrn2w9.wl-tiwai@suse.de>
	<20150610192202.0e987fd0@mdontu-l.dsd.bitdefender.biz>
	<s5hr3pjleac.wl-tiwai@suse.de>
	<20150610194303.3b82609d@mdontu-l.dsd.bitdefender.biz>
	<s5hy4jr8ltm.wl-tiwai@suse.de>
	<20150611011236.53bcd1fd@mdontu-l>
	<s5hioau96ue.wl-tiwai@suse.de>
	<20150612012318.6e3482ed@mdontu-l>
	<s5hy4jp5s3t.wl-tiwai@suse.de>
	<20150612124523.37fd0875@mdontu-l>
	<s5h8ubpjkzw.wl-tiwai@suse.de>
	<s5hk2v9hv5v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hk2v9hv5v.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan McDowell <noodles@earth.li>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Jun 2015 16:13:16 +0200 Takashi Iwai wrote:
> For your convenience, below is the combined patch for 4.1.
>=20
> Jonathan, could you also try this patch and see whether you still get
> the noise?
>=20
> ---
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_real=
tek.c
> index 0320cb523d9e..919051d92a0b 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -4515,6 +4515,8 @@ enum {
>  	ALC288_FIXUP_DELL_HEADSET_MODE,
>  	ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
>  	ALC288_FIXUP_DELL_XPS_13_GPIO6,
> +	ALC292_FIXUP_DELL_E7X,
> +	ALC292_FIXUP_DISABLE_AAMIX,
>  };
> =20
>  static const struct hda_fixup alc269_fixups[] =3D {
> @@ -5037,6 +5039,16 @@ static const struct hda_fixup alc269_fixups[] =
=3D {
>  		.chained =3D true,
>  		.chain_id =3D ALC288_FIXUP_DELL1_MIC_NO_PRESENCE
>  	},
> +	[ALC292_FIXUP_DISABLE_AAMIX] =3D {
> +		.type =3D HDA_FIXUP_FUNC,
> +		.v.func =3D alc_fixup_disable_aamix,
> +	},
> +	[ALC292_FIXUP_DELL_E7X] =3D {
> +		.type =3D HDA_FIXUP_FUNC,
> +		.v.func =3D alc_fixup_dell_xps13,
> +		.chained =3D true,
> +		.chain_id =3D ALC292_FIXUP_DISABLE_AAMIX
> +	},
>  };
> =20
>  static const struct snd_pci_quirk alc269_fixup_tbl[] =3D {
> @@ -5049,6 +5061,8 @@ static const struct snd_pci_quirk alc269_fixup_=
tbl[] =3D {
>  	SND_PCI_QUIRK(0x1025, 0x0775, "Acer Aspire E1-572", ALC271_FIXUP_HP=
_GATE_MIC_JACK_E1_572),
>  	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_A=
SPIRE_V5_PINS),
>  	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z=
),
> +	SND_PCI_QUIRK(0x1028, 0x05ca, "Dell Latitude E7240", ALC292_FIXUP_D=
ELL_E7X),
> +	SND_PCI_QUIRK(0x1028, 0x05cb, "Dell Latitude E7440", ALC292_FIXUP_D=
ELL_E7X),
>  	SND_PCI_QUIRK(0x1028, 0x05da, "Dell Vostro 5460", ALC290_FIXUP_SUBW=
OOFER),
>  	SND_PCI_QUIRK(0x1028, 0x05f4, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRE=
SENCE),
>  	SND_PCI_QUIRK(0x1028, 0x05f5, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRE=
SENCE),
> @@ -5637,8 +5651,7 @@ static int patch_alc269(struct hda_codec *codec=
)
> =20
>  	spec =3D codec->spec;
>  	spec->gen.shared_mic_vref_pin =3D 0x18;
> -	if (codec->core.vendor_id !=3D 0x10ec0292)
> -		codec->power_save_node =3D 1;
> +	codec->power_save_node =3D 1;
> =20
>  	snd_hda_pick_fixup(codec, alc269_fixup_models,
>  		       alc269_fixup_tbl, alc269_fixups);

This patch works fine for me. You can add my Tested-by when you re-spin
it for Linus and if Jonathan is happy as well.

Thank you!

--=20
Mihai Don=C8=9Bu
