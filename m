From: =?UTF-8?Q?Emmanuel_Fust=c3=a9?= <emmanuel.fuste-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: pcm5102a: Add support for PCM5102A
 codec
Date: Sun, 22 May 2016 23:29:55 +0200
Message-ID: <34ab107e-10dc-fbd3-28d1-203c6411851c@laposte.net>
References: <1463130853-25096-1-git-send-email-kernel@martin.sperl.org>
 <1463130853-25096-2-git-send-email-kernel@martin.sperl.org>
Reply-To: emmanuel.fuste-QFKgK+z4sOrR7s880joybQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463130853-25096-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>, Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Le 13/05/2016 =E0 11:14, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org a =E9crit :
> From: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
>
> Some definitions to support the PCM5102A codec
> by Texas Instruments.
>
> Signed-off-by: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
>
> Changes to original patch by Florian Meier:
> * rebased (Makefile and Kconfig
> * fixed checkpath errors (spaces, newlines)
> * added dt-binding documentation
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/pcm5102a.txt         | 13 ++++
>  sound/soc/codecs/Kconfig                           |  4 ++
>  sound/soc/codecs/Makefile                          |  2 +
>  sound/soc/codecs/pcm5102a.c                        | 69 ++++++++++++=
++++++++++
>  4 files changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/pcm5102a.=
txt
>  create mode 100644 sound/soc/codecs/pcm5102a.c
>
> diff --git a/Documentation/devicetree/bindings/sound/pcm5102a.txt b/D=
ocumentation/devicetree/bindings/sound/pcm5102a.txt
> new file mode 100644
> index 0000000..c63ab0b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/pcm5102a.txt
> @@ -0,0 +1,13 @@
> +PCM5102a audio CODECs
> +
> +These devices does not use I2C or SPI.
> +
> +Required properties:
> +
> +  - compatible : set as "ti,pcm5102a"
> +
> +Examples:
> +
> +	pcm5102a: pcm5102a {
> +		compatible =3D "ti,pcm5102a";
> +	};
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 7ef3a0c..26ae0b5 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -94,6 +94,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_PCM3008
>  	select SND_SOC_PCM3168A_I2C if I2C
>  	select SND_SOC_PCM3168A_SPI if SPI_MASTER
> +	select SND_SOC_PCM5102A
>  	select SND_SOC_PCM512x_I2C if I2C
>  	select SND_SOC_PCM512x_SPI if SPI_MASTER
>  	select SND_SOC_RT286 if I2C
> @@ -575,6 +576,9 @@ config SND_SOC_PCM3168A_SPI
>  	select SND_SOC_PCM3168A
>  	select REGMAP_SPI
>
> +config SND_SOC_PCM5102A
> +	tristate
> +
>  config SND_SOC_PCM512x
>  	tristate
>
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index 185a712..4532a74 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -89,6 +89,7 @@ snd-soc-pcm3008-objs :=3D pcm3008.o
>  snd-soc-pcm3168a-objs :=3D pcm3168a.o
>  snd-soc-pcm3168a-i2c-objs :=3D pcm3168a-i2c.o
>  snd-soc-pcm3168a-spi-objs :=3D pcm3168a-spi.o
> +snd-soc-pcm5102a-objs :=3D pcm5102a.o
>  snd-soc-pcm512x-objs :=3D pcm512x.o
>  snd-soc-pcm512x-i2c-objs :=3D pcm512x-i2c.o
>  snd-soc-pcm512x-spi-objs :=3D pcm512x-spi.o
> @@ -298,6 +299,7 @@ obj-$(CONFIG_SND_SOC_PCM3008)	+=3D snd-soc-pcm300=
8.o
>  obj-$(CONFIG_SND_SOC_PCM3168A)	+=3D snd-soc-pcm3168a.o
>  obj-$(CONFIG_SND_SOC_PCM3168A_I2C)	+=3D snd-soc-pcm3168a-i2c.o
>  obj-$(CONFIG_SND_SOC_PCM3168A_SPI)	+=3D snd-soc-pcm3168a-spi.o
> +obj-$(CONFIG_SND_SOC_PCM5102A)	+=3D snd-soc-pcm5102a.o
>  obj-$(CONFIG_SND_SOC_PCM512x)	+=3D snd-soc-pcm512x.o
>  obj-$(CONFIG_SND_SOC_PCM512x_I2C)	+=3D snd-soc-pcm512x-i2c.o
>  obj-$(CONFIG_SND_SOC_PCM512x_SPI)	+=3D snd-soc-pcm512x-spi.o
> diff --git a/sound/soc/codecs/pcm5102a.c b/sound/soc/codecs/pcm5102a.=
c
> new file mode 100644
> index 0000000..ed51567
> --- /dev/null
> +++ b/sound/soc/codecs/pcm5102a.c
> @@ -0,0 +1,69 @@
> +/*
> + * Driver for the PCM5102A codec
> + *
> + * Author:	Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
> + *		Copyright 2013
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <sound/soc.h>
> +
> +static struct snd_soc_dai_driver pcm5102a_dai =3D {
> +	.name =3D "pcm5102a-hifi",
> +	.playback =3D {
> +		.channels_min =3D 2,
> +		.channels_max =3D 2,
> +		.rates =3D SNDRV_PCM_RATE_8000_192000,
> +		.formats =3D SNDRV_PCM_FMTBIT_S16_LE |
> +			   SNDRV_PCM_FMTBIT_S24_LE |
> +			   SNDRV_PCM_FMTBIT_S32_LE
> +	},
> +};
> +
> +static struct snd_soc_codec_driver soc_codec_dev_pcm5102a;
> +
> +static int pcm5102a_probe(struct platform_device *pdev)
> +{
> +	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_pcm5102a,
> +			&pcm5102a_dai, 1);
> +}
> +
> +static int pcm5102a_remove(struct platform_device *pdev)
> +{
> +	snd_soc_unregister_codec(&pdev->dev);
> +	return 0;
> +}
> +
> +static const struct of_device_id pcm5102a_of_match[] =3D {
> +	{ .compatible =3D "ti,pcm5102a", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pcm5102a_of_match);
> +
> +static struct platform_driver pcm5102a_codec_driver =3D {
> +	.probe		=3D pcm5102a_probe,
> +	.remove		=3D pcm5102a_remove,
> +	.driver		=3D {
> +		.name	=3D "pcm5102a-codec",
> +		.owner	=3D THIS_MODULE,
> +		.of_match_table =3D pcm5102a_of_match,
> +	},
> +};
> +
> +module_platform_driver(pcm5102a_codec_driver);
> +
> +MODULE_DESCRIPTION("ASoC PCM5102A codec driver");
> +MODULE_AUTHOR("Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");
>
Hello,

There is nothing PCM5102A specific here, and it is pretty generic.
Wouldn't it be better to write instead a simple-i2s-codec for all the=20
classics I2S "hifi" DACs which will get the I2S/DAI parameters from DT =
?
PCM510x, PCM5122 in HW mode, ES9023, a bunch of ES90xx implementations=20
etc... will use exactly the same code with only format and rate=20
variation. And for the rate, it is implementation dependent, even in th=
e=20
case of pcm5102a.

Emmanuel.


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
