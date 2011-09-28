From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] ASoC: adau1701: Initialize codec->control_data before
 using it
Date: Wed, 28 Sep 2011 15:24:08 +0800
Message-ID: <CAF+7xWmV_WQScOsCn3NDfFacmX_Y=TJJ_9vD0OrdA_QjdCKK5A@mail.gmail.com>
References: <1317194488.2498.2.camel@phoenix>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317194488.2498.2.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Cliff Cai <cliff.cai@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/9/28 Axel Lin <axel.lin@gmail.com>:
> Currently codec->control_data is not initialized before calling
> process_sigma_firmware(codec->control_data, ADAU1701_FIRMWARE).
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
This one is a v2 of original patch.
Sorry, forgot to add v2 in the subject line.

> =A0sound/soc/codecs/adau1701.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.=
c
> index b7e4cc7..8b7e1c5 100644
> --- a/sound/soc/codecs/adau1701.c
> +++ b/sound/soc/codecs/adau1701.c
> @@ -458,6 +458,7 @@ static int adau1701_probe(struct snd_soc_codec *c=
odec)
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0codec->dapm.idle_bias_off =3D 1;
> + =A0 =A0 =A0 codec->control_data =3D to_i2c_client(codec->dev);
>
> =A0 =A0 =A0 =A0ret =3D adau1701_load_firmware(codec);
> =A0 =A0 =A0 =A0if (ret)
> --
> 1.7.4.1
>
>
>
>
