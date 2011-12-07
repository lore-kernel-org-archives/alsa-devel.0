From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v2] soc/lapis: add machine driver
Date: Wed, 7 Dec 2011 13:42:45 +0900
Message-ID: <CANKRQnhbBNDjQw5MQGexZAEboC0oHB5QS1LfHo6pDeoeDSwByw@mail.gmail.com>
References: <1322819115-15808-1-git-send-email-tomoya.rohm@gmail.com>
	<20111202153401.GX8245@opensource.wolfsonmicro.com>
	<CANKRQniyjT_2Ko=EYmffu3_NzDJQTMm9nY6rUp-DQ70e6AVQpA@mail.gmail.com>
	<20111205183223.GB7467@opensource.wolfsonmicro.com>
	<CANKRQnhEFvubv0b63z34=_xn4x4q=20enofqPrMsFetj1x7-NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANKRQnhEFvubv0b63z34=_xn4x4q=20enofqPrMsFetj1x7-NQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mike Frysinger <vapier@gentoo.org>, Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
List-Id: alsa-devel@alsa-project.org

2011/12/6 Tomoya MORINAGA <tomoya.rohm@gmail.com>:
>>> >> + =A0 =A0 ret =3D snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_=
I2S |
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SO=
C_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
>>> >> + =A0 =A0 if (ret < 0)
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>
>>> > Use the dai_fmt field in the dai_link to set this.
>>
>>> Sorry, I can't understand your saying.
>>> Let me know in more detail.
>>
>> I'm not sure what more to say... =A0Have you looked at that field an=
d how
>> it is both implemented and used in other drivers, or at the commit l=
ogs
>> for relevant changes? =A0What do you find unclear?
>
> You said "Use the dai_fmt field in the dai_link to set this."
> However, both dai_fmt and dai_link are already implemented like below=
=2E
> static struct snd_soc_dai_link ioh_i2s_dai =3D {
> ...
> };
>
> static struct snd_soc_card ioh_i2s_card =3D {
> ...
> =A0 =A0 =A0 =A0.dai_link =A0 =A0 =A0 =3D &ioh_i2s_dai,
> ...
> };
> So, I can't understand your saying.

Could you give me your answer ?

thanks,

tomoya
