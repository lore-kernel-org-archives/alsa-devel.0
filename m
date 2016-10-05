From: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 07/14] ASoC: Add sun8i audio card
Date: Wed, 5 Oct 2016 08:04:26 +0200
Message-ID: <CAEKpxBkUbCGJdToReQx7P+5i92doUdNeMvA5fiDACGcniY=nJg@mail.gmail.com>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <cover.1475569400.git.mylene.josserand@free-electrons.com> <33d641ff43f0c0349cdfa2cdbbfdcdde66205596.1475571575.git.mylene.josserand@free-electrons.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCHNXO4F7MHBB25P2K7QKGQEBC32CII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <33d641ff43f0c0349cdfa2cdbbfdcdde66205596.1475571575.git.mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 4 October 2016 at 11:46, Myl=C3=A8ne Josserand
<mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> Add the audio card for sun8i SoC. This card links the codec driver
> (digital part) with the DAI driver. The analog codec driver is
> added as an aux_device.
>
> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org=
>
> ---
>  sound/soc/sunxi/Kconfig  |  14 +++++++
>  sound/soc/sunxi/Makefile |   1 +
>  sound/soc/sunxi/sun8i.c  | 101 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 116 insertions(+)
>  create mode 100644 sound/soc/sunxi/sun8i.c
>
> diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
> index 9e287b0..7b97395 100644
> --- a/sound/soc/sunxi/Kconfig
> +++ b/sound/soc/sunxi/Kconfig
> @@ -27,6 +27,20 @@ config SND_SUN4I_SPDIF
>           Say Y or M to add support for the S/PDIF audio block in the All=
winner
>           A10 and affiliated SoCs.
>
> +config SND_SUN8I
> +       tristate "Allwinner SUN6I/SUN8I audio card support"
> +       select SND_SUN8I_CODEC
> +       select SND_SUN4I_I2S
> +       select SND_SUN8I_CODEC_ANALOG
> +       select REGMAP_MMIO
> +       help
> +         This option enables the audio card for Allwinner A33 (sun8i) So=
C.
> +         It enables the DAI driver (SND_SUN4I_I2S), the digital audio
> +         codec driver (SND_SUN8I_CODEC) and the analog codec driver
> +         (SND_SUN8I_CODEC_ANALOG).
> +
> +         Say Y or M if you want to add sun8i/6i card support
> +
>  config SND_SUN8I_CODEC
>         tristate "Allwinner SUN8I audio codec"
>         select REGMAP_MMIO
> diff --git a/sound/soc/sunxi/Makefile b/sound/soc/sunxi/Makefile
> index 1da63d3..7f1bab9 100644
> --- a/sound/soc/sunxi/Makefile
> +++ b/sound/soc/sunxi/Makefile
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_SND_SUN4I_CODEC) +=3D sun4i-codec.o
>  obj-$(CONFIG_SND_SUN4I_I2S) +=3D sun4i-i2s.o
>  obj-$(CONFIG_SND_SUN4I_SPDIF) +=3D sun4i-spdif.o
> +obj-$(CONFIG_SND_SUN8I) +=3D sun8i.o
>  obj-$(CONFIG_SND_SUN8I_CODEC) +=3D sun8i-codec.o
>  obj-$(CONFIG_SND_SUN8I_CODEC_ANALOG) +=3D sun8i-codec-analog.o
> diff --git a/sound/soc/sunxi/sun8i.c b/sound/soc/sunxi/sun8i.c
> new file mode 100644
> index 0000000..565cd88
> --- /dev/null
> +++ b/sound/soc/sunxi/sun8i.c
> @@ -0,0 +1,101 @@
> +/*
> + * ALSA SoC driver for Allwinner sun8i SoC
> + *
> + * Copyright (C) 2016 Myl=C3=A8ne Josserand <mylene.josserand@free-elect=
rons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/firmware.h>
> +#include <linux/module.h>
> +
> +#include <sound/soc.h>
> +
> +static struct snd_soc_aux_dev sun8i_audio_prcm_aux_devs[] =3D {
> +       {
> +               .name =3D "sun8i-codec-analog",
> +               .codec_name =3D "sun8i-codec-analog.0",
> +       },
> +};
> +
> +static struct snd_soc_dai_link sun8i_dai_link =3D {
> +       .name           =3D "sun4i-i2s",
> +       .stream_name    =3D "Playback",
> +       .codec_dai_name =3D "sun8i",
> +       .dai_fmt        =3D SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_I2S |
> +                       SND_SOC_DAIFMT_CBM_CFM,
> +};
> +
> +static struct snd_soc_card sun8i_card =3D {
> +       .name           =3D "sun8i-card",
> +       .owner          =3D THIS_MODULE,
> +       .dai_link       =3D &sun8i_dai_link,
> +       .num_links      =3D 1,
> +       .aux_dev        =3D sun8i_audio_prcm_aux_devs,
> +       .num_aux_devs   =3D ARRAY_SIZE(sun8i_audio_prcm_aux_devs),
> +};
> +
> +static int sun8i_probe(struct platform_device *pdev)
> +{
> +       struct snd_soc_dai_link *link =3D &sun8i_dai_link;
> +       struct device_node *np =3D pdev->dev.of_node;
> +       int ret;
> +
> +       /* register the soc card */
> +       sun8i_card.dev =3D &pdev->dev;
> +
> +       /* Retrieve the audio-codec from DT */
> +       link->codec_of_node =3D of_parse_phandle(np, "allwinner,audio-cod=
ec", 0);
> +       if (!link->codec_of_node) {
> +               dev_err(&pdev->dev, "Missing audio codec\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Retrieve DAI from DT */
> +       link->cpu_of_node =3D of_parse_phandle(np, "allwinner,i2s-control=
ler", 0);
Now that I've spent some time trying to add my changes for the H3
ontop of your code,  I think this file should be more generic and rely
on the dtsi more. It's pretty A33 specific but with little effort it
can be worked to cover all of the sun8i type drivers. I would change
"allwinner,i2s-controller" to "allwinner,audio-dai" for starters and
then maybe pull in some info for the dai-link from the dtsi.
CK
> +       if (!link->cpu_of_node) {
> +               dev_err(&pdev->dev, "Missing I2S controller\n");
> +               return -EINVAL;
> +       }
> +
> +       link->platform_of_node =3D link->cpu_of_node;
> +
> +       /* Register the sound card */
> +       ret =3D devm_snd_soc_register_card(&pdev->dev, &sun8i_card);
> +       if (ret) {
> +               dev_err(&pdev->dev,
> +                       "Soc register card failed %d\n", ret);
> +               return ret;
> +       }
> +
> +       return ret;
> +}
> +
> +static const struct of_device_id sun8i_of_match[] =3D {
> +       { .compatible =3D "allwinner,sun8i-audio", },
> +       {},
> +};
> +
> +MODULE_DEVICE_TABLE(of, sun8i_of_match);
> +
> +static struct platform_driver sun8i_card_driver =3D {
> +       .probe =3D sun8i_probe,
> +       .driver =3D {
> +               .name   =3D "sun8i-audio",
> +               .of_match_table =3D sun8i_of_match,
> +       },
> +};
> +
> +module_platform_driver(sun8i_card_driver);
> +
> +MODULE_AUTHOR("Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTGGXanvQGlWp@public.gmane.org=
m>");
> +MODULE_DESCRIPTION("Allwinner sun8i machine ASoC driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.9.3
>

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
