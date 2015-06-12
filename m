From: Mihai =?UTF-8?B?RG9uyJt1?= <mihai.dontu@gmail.com>
Subject: Re: Audio crackles with 4.1-rc1
Date: Fri, 12 Jun 2015 12:45:23 +0300
Message-ID: <20150612124523.37fd0875@mdontu-l>
References: <s5hpp6ov1wv.wl-tiwai@suse.de>
	<s5h4mnzgne6.wl-tiwai@suse.de>
	<20150430150131.GA10148@earth.li>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy4jp5s3t.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan McDowell <noodles@earth.li>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Jun 2015 09:00:06 +0200 Takashi Iwai wrote:
> At Fri, 12 Jun 2015 01:23:18 +0300, Mihai Don=C8=9Bu wrote:
> > No, 4.0.5 and all previous kernels (>=3D 3.12) are OK. I have attac=
hed a
> > small tarball with the two files produced by alsa-info.sh.
>=20
> Both are taken in different states (one is headphone plugged and
> another unplugged?).  At best, take the snapshot in the same situatio=
n
> for comparison.
>=20
> In anyway, below is another shot in dark.  The white noise is possibl=
y
> the ill side effect of analog loopback.  But it's strange that this
> didn't happen on 4.0.x.  And, it combines another black magic that
> worked for another Dell model.  Let's see.
>=20
>=20
> Takashi
>=20
> ---
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_real=
tek.c
> index 9d3e0fcb4326..cf46f6012ba4 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -4522,6 +4522,8 @@ enum {
>  	ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
>  	ALC288_FIXUP_DELL_XPS_13_GPIO6,
>  	ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
> +	ALC292_FIXUP_DELL_E74,
> +	ALC292_FIXUP_DISABLE_AAMIX,
>  };
> =20
>  static const struct hda_fixup alc269_fixups[] =3D {
> @@ -5054,6 +5056,16 @@ static const struct hda_fixup alc269_fixups[] =
=3D {
>  		.chained =3D true,
>  		.chain_id =3D ALC269_FIXUP_HEADSET_MODE
>  	},
> +	[ALC292_FIXUP_DISABLE_AAMIX] =3D {
> +		.type =3D HDA_FIXUP_FUNC,
> +		.v.func =3D alc_fixup_disable_aamix,
> +	},
> +	[ALC292_FIXUP_DELL_E74] =3D {
> +		.type =3D HDA_FIXUP_FUNC,
> +		.v.func =3D alc_fixup_dell_xps13,
> +		.chained =3D true,
> +		.chain_id =3D ALC292_FIXUP_DISABLE_AAMIX
> +	},
>  };
> =20
>  static const struct snd_pci_quirk alc269_fixup_tbl[] =3D {
> @@ -5066,6 +5078,7 @@ static const struct snd_pci_quirk alc269_fixup_=
tbl[] =3D {
>  	SND_PCI_QUIRK(0x1025, 0x0775, "Acer Aspire E1-572", ALC271_FIXUP_HP=
_GATE_MIC_JACK_E1_572),
>  	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_A=
SPIRE_V5_PINS),
>  	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z=
),
> +	SND_PCI_QUIRK(0x1028, 0x05cb, "Dell Latitude E7440", ALC292_FIXUP_D=
ELL_E74),
>  	SND_PCI_QUIRK(0x1028, 0x05da, "Dell Vostro 5460", ALC290_FIXUP_SUBW=
OOFER),
>  	SND_PCI_QUIRK(0x1028, 0x05f4, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRE=
SENCE),
>  	SND_PCI_QUIRK(0x1028, 0x05f5, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRE=
SENCE),

Nice shot! It appears to work. :-) No clicks, no static.

I had to apply it by hand over 4.1-rc7, because the first two arrays
look different in both it and -master. Anyway, I will play with it some
more today see if anything else is broken.

Oh, and yes, the second state is without headphones on. I removed them
without thinking when the noise started. Sorry about that.

Thanks!

--=20
Mihai Don=C8=9Bu
