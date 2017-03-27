From: Ryans Lee <RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Subject: RE: [alsa-devel] [PATCH] ASoC: Add support for Maxim Integrated
 MAX98927 Amplifier
Date: Mon, 27 Mar 2017 05:45:23 +0000
Message-ID: <BY2PR11MB08379FE803113440DD984076E7330@BY2PR11MB0837.namprd11.prod.outlook.com>
References: <1489970423-29353-1-git-send-email-ryans.lee@maximintegrated.com>
 <20170320141407.GS6986@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170320141407.GS6986-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "tiwai-IBi9RG/b67k@public.gmane.org" <tiwai-IBi9RG/b67k@public.gmane.org>, "kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org" <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, "nh6z-fFIq/eER6g8@public.gmane.org" <nh6z-fFIq/eER6g8@public.gmane.org>, "KCHSU0-KrzQf0k3Iz9BDgjK7y7TUQ@public.gmane.org" <KCHSU0-KrzQf0k3Iz9BDgjK7y7TUQ@public.gmane.org>, "axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org" <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, "romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org" <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, "petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org" <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>, "srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org" <oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Charles Keepax [mailto:ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org]
> Sent: Monday, March 20, 2017 7:14 AM
> To: Ryans Lee <RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
> Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;=20
> mark.rutland-5wv7dgnIgG8@public.gmane.org; perex-/Fr2/VpizcU@public.gmane.org; tiwai-IBi9RG/b67k@public.gmane.org;=20
> kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org; arnd-r2nGTMty4D4@public.gmane.org; lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org;=20
> bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org; nh6z-fFIq/eER6g8@public.gmane.org; KCHSU0-KrzQf0k3Iz9BDgjK7y7TUQ@public.gmane.org;=20
> axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org; romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org; petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org;=20
> srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org;=20
> Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org; alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org;=20
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;=20
> dgreid-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
> Subject: Re: [alsa-devel] [PATCH] ASoC: Add support for Maxim=20
> Integrated MAX98927 Amplifier
>
> EXTERNAL EMAIL
>
>
>
> On Mon, Mar 20, 2017 at 09:40:23AM +0900, Ryan Lee wrote:
>> Signed-off-by: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
>> ---
>> Resubmit the intial version of MAX98927 driver. Added all fixes into the=
 initial patch.
> <snip>
>> +static int max98927_reg_get(struct snd_kcontrol *kcontrol,
>> +     struct snd_ctl_elem_value *ucontrol, unsigned int reg,
>> +     unsigned int mask, unsigned int shift) {
>> +     struct snd_soc_codec *codec =3D snd_soc_kcontrol_codec(kcontrol);
>> +     struct max98927_priv *max98927 =3D snd_soc_codec_get_drvdata(codec=
);
>> +     int data;
>> +
>> +     regmap_read(max98927->regmap, reg, &data);
>> +     ucontrol->value.integer.value[0] =3D (data & mask) >> shift;
>> +     return 0;
>> +}
>> +
>> +static int max98927_reg_put(struct snd_kcontrol *kcontrol,
>> +     struct snd_ctl_elem_value *ucontrol, unsigned int reg,
>> +     unsigned int mask, unsigned int shift) {
>> +     struct snd_soc_codec *codec =3D snd_soc_kcontrol_codec(kcontrol);
>> +     struct max98927_priv *max98927 =3D snd_soc_codec_get_drvdata(codec=
);
>> +     unsigned int sel =3D ucontrol->value.integer.value[0];
>> +
>> +     regmap_update_bits(max98927->regmap, reg, mask, sel << shift);
>> +     dev_dbg(codec->dev, "%s: register 0x%02X, value 0x%02X\n",
>> +             __func__, reg, sel);
>> +     return 0;
>> +}
>
> These functions look a lot like they duplicate things the ASoC core does?

You're right. I removed 'max98927_reg_get' and 'max98927_reg_put' function =
to avoid duplication.

>
> <snip>
>> +static int max98927_boost_voltage_get(struct snd_kcontrol *kcontrol,
>> +     struct snd_ctl_elem_value *ucontrol) {
>> +     return max98927_reg_get(kcontrol, ucontrol,
>> +             MAX98927_R0040_BOOST_CTRL0,
>> +             MAX98927_BOOST_CTRL0_VOUT_MASK, 0); }
>> +
>
> And can't these just be specified in the normal way with the register inf=
ormation attached to the control? There doesn't seem to be any special beha=
viour being added here. Apologies if I am missing something here.

Thank you for your feedback. Now SOC_ENUM_EXT was replaced by SOC_ENUM. SOC=
_SINGLE_EXT was also replaced by SOC_SINGLE. Above function is no longer be=
ing used.

>
> Thanks,
> Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
