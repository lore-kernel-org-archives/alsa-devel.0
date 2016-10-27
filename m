From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v5 2/7] ASoC: sunxi: Add a simple HDMI CODEC
Date: Fri, 28 Oct 2016 00:54:34 +0800
Message-ID: <CAGb2v67cE8v3=XtTzDBst2D2U6wM8pffQYK9nEok+j4xnPT39A@mail.gmail.com>
References: <cover.1477142934.git.moinejf@free.fr> <5cb540f20f64d28bd7dee82a0e14ee5209631979.1477142934.git.moinejf@free.fr>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCMILY6JWQBBBY7CZDAAKGQEHB5QTBQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <5cb540f20f64d28bd7dee82a0e14ee5209631979.1477142934.git.moinejf-GANU6spQydw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 21, 2016 at 3:44 PM, Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org> wrot=
e:
> Allwinner's SoCs include support for both audio and video on HDMI.
> This patch defines a simple audio CODEC which may be used in sunxi
> HDMI video drivers.
>
> Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>

There's already a driver for basically the same thing:

    sound/soc/codec/hdmi-codec.c

You use it by registering a sub-device from your hdmi driver, with the
proper platform_data and callbacks. Grep for HDMI_CODEC_DRV_NAME for
platforms already using it.

ChenYu

> ---
>  include/sound/sunxi_hdmi.h    |  23 +++++++++
>  sound/soc/codecs/Kconfig      |   9 ++++
>  sound/soc/codecs/Makefile     |   2 +
>  sound/soc/codecs/sunxi-hdmi.c | 106 ++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 140 insertions(+)
>  create mode 100644 include/sound/sunxi_hdmi.h
>  create mode 100644 sound/soc/codecs/sunxi-hdmi.c
>
> diff --git a/include/sound/sunxi_hdmi.h b/include/sound/sunxi_hdmi.h
> new file mode 100644
> index 0000000..0986bb9
> --- /dev/null
> +++ b/include/sound/sunxi_hdmi.h
> @@ -0,0 +1,23 @@
> +#ifndef __SUNXI_HDMI_H__
> +#define __SUNXI_HDMI_H__
> +/*
> + * Copyright (C) 2016 Jean-Fran=C3=A7ois Moine
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +struct sunxi_hdmi_codec {
> +       u8 *eld;
> +       int (*set_audio_input)(struct device *dev,
> +                               int enable,
> +                               unsigned sample_rate,
> +                               unsigned sample_bit);
> +};
> +
> +int sunxi_hdmi_codec_register(struct device *dev);
> +void sunxi_hdmi_codec_unregister(struct device *dev);
> +
> +#endif /* __SUNXI_HDMI_H__ */
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index c67667b..53385b1 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -131,6 +131,7 @@ config SND_SOC_ALL_CODECS
>         select SND_SOC_STA529 if I2C
>         select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
>         select SND_SOC_STI_SAS
> +       select SND_SOC_SUNXI_HDMI
>         select SND_SOC_TAS2552 if I2C
>         select SND_SOC_TAS5086 if I2C
>         select SND_SOC_TAS571X if I2C
> @@ -793,6 +794,14 @@ config SND_SOC_STAC9766
>  config SND_SOC_STI_SAS
>         tristate "codec Audio support for STI SAS codec"
>
> +config SND_SOC_SUNXI_HDMI
> +       tristate "Allwinner sunxi HDMI Support"
> +       default m if DRM_SUNXI_DE2_HDMI=3Dm
> +       default y if DRM_SUNXI_DE2_HDMI=3Dy
> +       select SND_PCM_ELD
> +       help
> +         Enable HDMI audio output
> +
>  config SND_SOC_TAS2552
>         tristate "Texas Instruments TAS2552 Mono Audio amplifier"
>         depends on I2C
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index 958cd49..35804eb 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -139,6 +139,7 @@ snd-soc-sta350-objs :=3D sta350.o
>  snd-soc-sta529-objs :=3D sta529.o
>  snd-soc-stac9766-objs :=3D stac9766.o
>  snd-soc-sti-sas-objs :=3D sti-sas.o
> +snd-soc-sunxi-hdmi-objs :=3D sunxi-hdmi.o
>  snd-soc-tas5086-objs :=3D tas5086.o
>  snd-soc-tas571x-objs :=3D tas571x.o
>  snd-soc-tas5720-objs :=3D tas5720.o
> @@ -359,6 +360,7 @@ obj-$(CONFIG_SND_SOC_STA350)   +=3D snd-soc-sta350.o
>  obj-$(CONFIG_SND_SOC_STA529)   +=3D snd-soc-sta529.o
>  obj-$(CONFIG_SND_SOC_STAC9766) +=3D snd-soc-stac9766.o
>  obj-$(CONFIG_SND_SOC_STI_SAS)  +=3D snd-soc-sti-sas.o
> +obj-$(CONFIG_SND_SOC_SUNXI_HDMI)       +=3D snd-soc-sunxi-hdmi.o
>  obj-$(CONFIG_SND_SOC_TAS2552)  +=3D snd-soc-tas2552.o
>  obj-$(CONFIG_SND_SOC_TAS5086)  +=3D snd-soc-tas5086.o
>  obj-$(CONFIG_SND_SOC_TAS571X)  +=3D snd-soc-tas571x.o
> diff --git a/sound/soc/codecs/sunxi-hdmi.c b/sound/soc/codecs/sunxi-hdmi.=
c
> new file mode 100644
> index 0000000..0d08676
> --- /dev/null
> +++ b/sound/soc/codecs/sunxi-hdmi.c
> @@ -0,0 +1,106 @@
> +/*
> + * Allwinner HDMI codec
> + *
> + * Copyright (C) 2016 Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <sound/soc.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <sound/pcm_drm_eld.h>
> +#include <sound/pcm_params.h>
> +
> +#include "sound/sunxi_hdmi.h"
> +
> +#define SUNXI_HDMI_FORMATS (SNDRV_PCM_FMTBIT_S8 | \
> +                         SNDRV_PCM_FMTBIT_S16_LE | \
> +                         SNDRV_PCM_FMTBIT_S20_3LE | \
> +                         SNDRV_PCM_FMTBIT_S24_LE | \
> +                         SNDRV_PCM_FMTBIT_S32_LE)
> +
> +static int sunxi_hdmi_codec_startup(struct snd_pcm_substream *substream,
> +                                 struct snd_soc_dai *dai)
> +{
> +       struct snd_pcm_runtime *runtime =3D substream->runtime;
> +       struct sunxi_hdmi_codec *priv =3D dev_get_drvdata(dai->dev);
> +       u8 *eld;
> +
> +       eld =3D priv->eld;
> +       if (!eld)
> +               return -ENODEV;
> +
> +       return snd_pcm_hw_constraint_eld(runtime, eld);
> +}
> +
> +static int sunxi_hdmi_hw_params(struct snd_pcm_substream *substream,
> +                             struct snd_pcm_hw_params *params,
> +                             struct snd_soc_dai *dai)
> +{
> +       struct sunxi_hdmi_codec *priv =3D dev_get_drvdata(dai->dev);
> +       unsigned sample_bit;
> +
> +       if (params_format(params) =3D=3D SNDRV_PCM_FORMAT_S16_LE)
> +               sample_bit =3D 16;
> +       else
> +               sample_bit =3D 24;
> +
> +       return priv->set_audio_input(dai->dev, true,
> +                                       params_rate(params),
> +                                       sample_bit);
> +}
> +
> +static void sunxi_hdmi_codec_shutdown(struct snd_pcm_substream *substrea=
m,
> +                                   struct snd_soc_dai *dai)
> +{
> +       struct sunxi_hdmi_codec *priv =3D dev_get_drvdata(dai->dev);
> +
> +       priv->set_audio_input(dai->dev, false, 0, 0);
> +}
> +
> +static const struct snd_soc_dai_ops sunxi_hdmi_codec_ops =3D {
> +       .startup =3D sunxi_hdmi_codec_startup,
> +       .hw_params =3D sunxi_hdmi_hw_params,
> +       .shutdown =3D sunxi_hdmi_codec_shutdown,
> +};
> +
> +static struct snd_soc_dai_driver sunxi_hdmi_codec =3D {
> +       .name =3D "hdmi",         /* must be the name of the node in the =
DT */
> +       .playback =3D {
> +               .stream_name    =3D "HDMI Playback",
> +               .channels_min   =3D 1,
> +               .channels_max   =3D 8,
> +               .rates          =3D SNDRV_PCM_RATE_CONTINUOUS,
> +               .rate_min       =3D 8000,
> +               .rate_max       =3D 192000,
> +               .formats        =3D SUNXI_HDMI_FORMATS,
> +       },
> +       .ops =3D &sunxi_hdmi_codec_ops,
> +};
> +
> +static const struct snd_soc_codec_driver sunxi_hdmi_codec_drv =3D {
> +       .ignore_pmdown_time =3D true,
> +};
> +
> +/* functions called from the HDMI video driver */
> +int sunxi_hdmi_codec_register(struct device *dev)
> +{
> +       return snd_soc_register_codec(dev, &sunxi_hdmi_codec_drv,
> +                                       &sunxi_hdmi_codec, 1);
> +}
> +EXPORT_SYMBOL_GPL(sunxi_hdmi_codec_register);
> +
> +void sunxi_hdmi_codec_unregister(struct device *dev)
> +{
> +       snd_soc_unregister_codec(dev);
> +}
> +EXPORT_SYMBOL_GPL(sunxi_hdmi_codec_unregister);
> +
> +MODULE_AUTHOR("Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>");
> +MODULE_DESCRIPTION("Allwinner HDMI CODEC");
> +MODULE_LICENSE("GPL");
> --
> 2.10.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/d/optout.

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
