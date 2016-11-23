From: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Subject: Re: [PATCH] ALSA SoC MAX98927 driver - Initial release
Date: Wed, 23 Nov 2016 20:20:27 +0100
Message-ID: <CAOf5uw=b0DhwokOg_4iyJOEvX3DQbynU5VE_v=QPWy4HLKgu2Q@mail.gmail.com>
References: <1479877026-5172-1-git-send-email-RyanS.Lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479877026-5172-1-git-send-email-RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ryan Lee <RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Oder Chiou <oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, yesanishhere-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Jacob Siverskog <jacob-EZCvousvhKUZux3j3Bed6dkegs52MxvZ@public.gmane.org>, Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, nh6z-fFIq/eER6g8@public.gmane.org, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi


On Wed, Nov 23, 2016 at 5:57 AM, Ryan Lee <RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org> wrote:
> Signed-off-by: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/max98927.txt         |   32 +
>  sound/soc/codecs/Kconfig                           |    5 +
>  sound/soc/codecs/Makefile                          |    2 +
>  sound/soc/codecs/max98927.c                        |  954 +++++++++++++++
>  sound/soc/codecs/max98927.h                        | 1253 ++++++++++++++++++++
>  5 files changed, 2246 insertions(+)
>  create mode 100755 Documentation/devicetree/bindings/sound/max98927.txt
>  mode change 100644 => 100755 sound/soc/codecs/Kconfig
>  mode change 100644 => 100755 sound/soc/codecs/Makefile
>  create mode 100755 sound/soc/codecs/max98927.c
>  create mode 100755 sound/soc/codecs/max98927.h
>
> diff --git a/Documentation/devicetree/bindings/sound/max98927.txt b/Documentation/devicetree/bindings/sound/max98927.txt
> new file mode 100755
> index 0000000..ddcd332
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/max98927.txt
> @@ -0,0 +1,32 @@
> +max98927 audio CODEC
> +
> +This device supports I2C.
> +
> +Required properties:
> +
> +  - compatible : "maxim,max98927"
> +
> +  - vmon-slot-no : slot number used to send voltage information
> +                   or in inteleave mode this will be used as
> +                   interleave slot.
> +
> +  - imon-slot-no : slot number used to send current information
> +
> +  - interleave-mode : When using two MAX98927 in a system it is
> +                      possible to create ADC data that that will
> +                      overflow the frame size. Digital Audio Interleave
> +                      mode provides a means to output VMON and IMON data
> +                      from two devices on a single DOUT line when running
> +                      smaller frames sizes such as 32 BCLKS per LRCLK or
> +                      48 BCLKS per LRCLK.
> +
> +  - reg : the I2C address of the device for I2C
> +
> +Example:
> +
> +codec: max98927@3a {
> +   compatible = "maxim,max98927";
> +   vmon-slot-no = <1>;
> +   imon-slot-no = <0>;
> +   reg = <0x3a>;
> +};
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> old mode 100644
> new mode 100755
> index c67667b..45f21ca
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -86,6 +86,7 @@ config SND_SOC_ALL_CODECS
>         select SND_SOC_MAX9867 if I2C
>         select SND_SOC_MAX98925 if I2C
>         select SND_SOC_MAX98926 if I2C
> +       select SND_SOC_MAX98927 if I2C
>         select SND_SOC_MAX9850 if I2C
>         select SND_SOC_MAX9860 if I2C
>         select SND_SOC_MAX9768 if I2C
> @@ -573,6 +574,10 @@ config SND_SOC_MAX98925
>  config SND_SOC_MAX98926
>         tristate
>
> +config SND_SOC_MAX98927
> +       tristate "Maxim Integrated MAX98927 Speaker Amplifier"
> +       depends on I2C
> +
>  config SND_SOC_MAX9850
>         tristate
>
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> old mode 100644
> new mode 100755
> index 958cd49..1f5fe2c
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -82,6 +82,7 @@ snd-soc-max98371-objs := max98371.o
>  snd-soc-max9867-objs := max9867.o
>  snd-soc-max98925-objs := max98925.o
>  snd-soc-max98926-objs := max98926.o
> +snd-soc-max98927-objs := max98927.o
>  snd-soc-max9850-objs := max9850.o
>  snd-soc-max9860-objs := max9860.o
>  snd-soc-mc13783-objs := mc13783.o
> @@ -306,6 +307,7 @@ obj-$(CONFIG_SND_SOC_MAX98357A)     += snd-soc-max98357a.o
>  obj-$(CONFIG_SND_SOC_MAX9867)  += snd-soc-max9867.o
>  obj-$(CONFIG_SND_SOC_MAX98925) += snd-soc-max98925.o
>  obj-$(CONFIG_SND_SOC_MAX98926) += snd-soc-max98926.o
> +obj-$(CONFIG_SND_SOC_MAX98927) += snd-soc-max98927.o
>  obj-$(CONFIG_SND_SOC_MAX9850)  += snd-soc-max9850.o
>  obj-$(CONFIG_SND_SOC_MAX9860)  += snd-soc-max9860.o
>  obj-$(CONFIG_SND_SOC_MC13783)  += snd-soc-mc13783.o
> diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
> new file mode 100755
> index 0000000..d85c84f
> --- /dev/null
> +++ b/sound/soc/codecs/max98927.c
> @@ -0,0 +1,954 @@
> +/*
> + * max98927.c  --  MAX98927 ALSA Soc Audio driver
> + *
> + * Copyright 2013-15 Maxim Integrated Products
> + * Author: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/cdev.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <linux/gpio.h>
> +#include <linux/of_gpio.h>
> +#include <sound/tlv.h>
> +#include "max98927.h"
> +
> +static struct reg_default max98927_reg_map[] = {
> +       {0x0014,  0x78},
> +       {0x0015,  0xFF},
> +       {0x0043,  0x04},
> +       {0x0017,  0x55},
> +       /* For mono driver we are just enabling one channel*/
> +       {MAX98927_PCM_Rx_Enables_A,  0x03},
> +       {MAX98927_PCM_Tx_HiZ_Control_A, 0xfc},
> +       {MAX98927_PCM_Tx_HiZ_Control_B, 0xff},
> +       {MAX98927_PCM_Tx_Channel_Sources_A, 0x01},
> +       {MAX98927_PCM_Tx_Channel_Sources_B, 0x01},
> +       {MAX98927_Measurement_DSP_Config, 0xf7},

What about not use camel case

> +       {0x0025,  0x80},
> +       {0x0026,  0x01},
> +       {0x0035,  0x40},
> +       {0x0036,  0x40},
> +       {0x0037,  0x02},
> +       {0x0039,  0x01},
> +       {0x003c,  0x44},
> +       {0x003d,  0x04},
> +       {0x0040,  0x10},
> +       {0x0042,  0x3f},
> +       {0x0044,  0x00},
> +       {0x0045,  0x24},
> +       {0x007f,  0x06},
> +       {0x0087,  0x1c},
> +       {0x0089,  0x03},
> +       {0x009f,  0x01},
> +};
> +
> +void max98927_wrapper_write(struct max98927_priv *max98927,
> +       unsigned int reg, unsigned int val)
> +{
> +       if (max98927->regmap)
> +               regmap_write(max98927->regmap, reg, val);
> +       if (max98927->sub_regmap)
> +               regmap_write(max98927->sub_regmap, reg, val);
> +}
> +
> +void max98927_wrap_update_bits(struct max98927_priv *max98927,
> +       unsigned int reg, unsigned int mask, unsigned int val)
> +{
> +       if (max98927->regmap)
> +               regmap_update_bits(max98927->regmap, reg, mask, val);
> +       if (max98927->sub_regmap)
> +               regmap_update_bits(max98927->sub_regmap, reg, mask, val);
> +}
> +
> +static int max98927_reg_get(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol, unsigned int reg,
> +               unsigned int mask, unsigned int shift)
> +{
> +       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +       struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +       int data;
> +
> +       regmap_read(max98927->regmap, reg, &data);
> +       ucontrol->value.integer.value[0] =
> +               (data & mask) >> shift;
> +       return 0;
> +}
> +
> +static int max98927_reg_put(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol, unsigned int reg,
> +               unsigned int mask, unsigned int shift)
> +{
> +       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +       struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +       unsigned int sel = ucontrol->value.integer.value[0];
> +
> +       max98927_wrap_update_bits(max98927, reg, mask, sel << shift);
> +       dev_dbg(codec->dev, "%s: register 0x%02X, value 0x%02X\n",
> +                               __func__, reg, sel);
> +       return 0;
> +}
> +
> +static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai,
> +       unsigned int fmt)
> +{
> +       struct snd_soc_codec *codec = codec_dai->codec;
> +       struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +       unsigned int invert = 0;
> +
> +       dev_dbg(codec->dev, "%s: fmt 0x%08X\n", __func__, fmt);
> +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +       case SND_SOC_DAIFMT_CBS_CFS:
> +               max98927_wrap_update_bits(max98927, MAX98927_PCM_Master_Mode,
> +               MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_Mask,
> +               MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_SLAVE);
> +               break;
> +       case SND_SOC_DAIFMT_CBM_CFM:
> +               max98927->master = true;
> +               max98927_wrap_update_bits(max98927, MAX98927_PCM_Master_Mode,
> +               MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_Mask,
> +               MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_MASTER);
> +               break;
> +       case SND_SOC_DAIFMT_CBS_CFM:
> +               max98927_wrap_update_bits(max98927, MAX98927_PCM_Master_Mode,
> +               MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_Mask,
> +               MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_HYBRID);
> +       default:
> +               dev_err(codec->dev, "DAI clock mode unsupported");
> +               return -EINVAL;
> +       }

Please fill up the mask variable and apply in one round after the switch.

> +
> +       switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +       case SND_SOC_DAIFMT_NB_NF:
> +               break;
> +       case SND_SOC_DAIFMT_IB_NF:
> +               invert = MAX98927_PCM_Mode_Config_PCM_BCLKEDGE;
> +               break;
> +       default:
> +               dev_err(codec->dev, "DAI invert mode unsupported");
> +               return -EINVAL;
> +       }
> +
> +       /* interface format */
> +       switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +       case SND_SOC_DAIFMT_I2S:
> +               max98927->iface |= SND_SOC_DAIFMT_I2S;
> +               max98927_wrap_update_bits(max98927,
> +                       MAX98927_PCM_Mode_Config,
> +               max98927->iface, max98927->iface);
> +       break;
> +       case SND_SOC_DAIFMT_LEFT_J:
> +               max98927->iface |= SND_SOC_DAIFMT_LEFT_J;
> +               max98927_wrap_update_bits(max98927,
> +                       MAX98927_PCM_Mode_Config,
> +               max98927->iface, max98927->iface);
> +       break;
> +       default:
> +               return -EINVAL;
> +       }
> +

Same here

> +       /* pcm channel configuration */
> +       if (max98927->iface & (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J)) {
> +               max98927_wrapper_write(max98927,
> +                       MAX98927_PCM_Rx_Enables_A,
> +                       MAX98927_PCM_Rx_Enables_A_PCM_RX_CH0_EN|
> +                       MAX98927_PCM_Rx_Enables_A_PCM_RX_CH1_EN);
> +               max98927_wrapper_write(max98927,
> +                       MAX98927_PCM_Tx_Enables_A,
> +                       MAX98927_PCM_Tx_Enables_A_PCM_TX_CH0_EN|
> +                       MAX98927_PCM_Tx_Enables_A_PCM_TX_CH1_EN);
> +       }
> +       max98927_wrap_update_bits(max98927, MAX98927_PCM_Mode_Config,
> +               MAX98927_PCM_Mode_Config_PCM_BCLKEDGE, invert);
> +       return 0;
> +}
> +
> +/* codec MCLK rate in master mode */
> +static const int rate_table[] = {
> +       5644800, 6000000, 6144000, 6500000,
> +       9600000, 11289600, 12000000, 12288000,
> +       13000000, 19200000,
> +};
> +
> +static int max98927_set_clock(struct max98927_priv *max98927,
> +       struct snd_pcm_hw_params *params)
> +{
> +       /* BCLK/LRCLK ratio calculation */
> +       int blr_clk_ratio = params_channels(params) * max98927->ch_size;
> +       int reg = MAX98927_PCM_Clock_setup;
> +       int mask = MAX98927_PCM_Clock_setup_PCM_BSEL_Mask;
> +       int value;
> +
> +       if (max98927->master) {
> +               int i;
> +               /* match rate to closest value */
> +               for (i = 0; i < ARRAY_SIZE(rate_table); i++) {
> +                       if (rate_table[i] >= max98927->sysclk)
> +                               break;
> +               }
> +               if (i == ARRAY_SIZE(rate_table)) {
> +                       pr_err("%s couldn't get the MCLK to match codec\n",
> +                               __func__);
> +                       return -EINVAL;
> +               }
> +               max98927_wrap_update_bits(max98927, MAX98927_PCM_Master_Mode,
> +                       MAX98927_PCM_Master_Mode_PCM_MCLK_RATE_Mask,
> +                       i << MAX98927_PCM_Master_Mode_PCM_MCLK_RATE_SHIFT);
> +       }

some code style here

> +
> +       switch (blr_clk_ratio) {
> +       case 32:
> +               value = 2;
> +               break;
> +       case 48:
> +               value = 3;
> +               break;
> +       case 64:
> +               value = 4;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +       max98927_wrap_update_bits(max98927,
> +       reg, mask, value);
> +       return 0;
> +}
> +

ditto

> +static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
> +       struct snd_pcm_hw_params *params,
> +       struct snd_soc_dai *dai)
> +{
> +       struct snd_soc_codec *codec = dai->codec;
> +       struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +       int sampling_rate = 0;
> +
> +       /* pcm mode configuration */
> +       switch (snd_pcm_format_width(params_format(params))) {
> +       case 16:
> +               max98927_wrap_update_bits(max98927,
> +                       MAX98927_PCM_Mode_Config,
> +                       MAX98927_PCM_Mode_Config_PCM_CHANSZ_16,
> +                       MAX98927_PCM_Mode_Config_PCM_CHANSZ_16);
> +               max98927->ch_size = 16;
> +               break;
> +       case 24:
> +               max98927_wrap_update_bits(max98927,
> +                       MAX98927_PCM_Mode_Config,
> +                       MAX98927_PCM_Mode_Config_PCM_CHANSZ_24,
> +                       MAX98927_PCM_Mode_Config_PCM_CHANSZ_24);
> +               max98927->ch_size = 24;
> +               break;
> +       case 32:
> +               max98927_wrap_update_bits(max98927,
> +                       MAX98927_PCM_Mode_Config,
> +                       MAX98927_PCM_Mode_Config_PCM_CHANSZ_32,
> +                       MAX98927_PCM_Mode_Config_PCM_CHANSZ_32);
> +               max98927->ch_size = 32;
> +               break;
> +       default:
> +               pr_err("%s: format unsupported %d",
> +                       __func__, params_format(params));
> +               goto err;
> +       }

Move update bits after switch. Can you update a new version?

Michael

> +       dev_dbg(codec->dev, "%s: format supported %d",
> +               __func__, params_format(params));
> +
> +       /* sampling rate configuration */
> +       switch (params_rate(params)) {
> +       case 8000:
> +               sampling_rate |=
> +                       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_8000;
> +               break;
> +       case 11025:
> +               sampling_rate |=
> +                       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_11025;
> +               break;
> +       case 12000:
> +               sampling_rate |=
> +                       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_12000;
> +               break;
> +       case 16000:
> +               sampling_rate |=
> +                       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_16000;
> +               break;
> +       case 22050:
> +               sampling_rate |=
> +                       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_22050;
> +               break;
> +       case 24000:
> +               sampling_rate |=
> +                       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_24000;
> +               break;
> +       case 32000:
> +               sampling_rate |=
> +                       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_32000;
> +               break;
> +       case 44100:
> +               sampling_rate |=
> +                       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_44100;
> +               break;
> +       case 48000:
> +               sampling_rate |=
> +                       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_48000;
> +               break;
> +       default:
> +               pr_err("%s rate %d not supported\n",
> +                       __func__, params_rate(params));
> +               goto err;
> +       }
> +       /* set DAI_SR to correct LRCLK frequency */
> +       max98927_wrap_update_bits(max98927, MAX98927_PCM_Sample_rate_setup_1,
> +               MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_Mask, sampling_rate);
> +       max98927_wrap_update_bits(max98927, MAX98927_PCM_Sample_rate_setup_2,
> +               MAX98927_PCM_Sample_rate_setup_2_SPK_SR_Mask, sampling_rate<<4);
> +       max98927_wrap_update_bits(max98927, MAX98927_PCM_Sample_rate_setup_2,
> +               MAX98927_PCM_Sample_rate_setup_2_IVADC_SR_Mask, sampling_rate);
> +       return max98927_set_clock(max98927, params);
> +err:
> +       return -EINVAL;
> +}
> +
> +#define MAX98927_RATES SNDRV_PCM_RATE_8000_48000
> +
> +#define MAX98927_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
> +       SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
> +
> +static int max98927_dai_set_sysclk(struct snd_soc_dai *dai,
> +                                  int clk_id, unsigned int freq, int dir)
> +{
> +       struct snd_soc_codec *codec = dai->codec;
> +       struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +
> +       max98927->sysclk = freq;
> +       return 0;
> +}
> +
> +static const struct snd_soc_dai_ops max98927_dai_ops = {
> +       .set_sysclk = max98927_dai_set_sysclk,
> +       .set_fmt = max98927_dai_set_fmt,
> +       .hw_params = max98927_dai_hw_params,
> +};
> +
> +static void max98927_handle_pdata(struct snd_soc_codec *codec)
> +{
> +       struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +       struct max98927_reg_default *regInfo;
> +       int cfg_size = 0;
> +       int x;
> +
> +       if (max98927->regcfg != NULL)
> +               cfg_size = max98927->regcfg_sz / sizeof(uint32_t);
> +
> +       if (cfg_size <= 0) {
> +               dev_dbg(codec->dev,
> +                       "Register configuration is not required.\n");
> +               return;
> +       }
> +
> +       /* direct configuration from device tree */
> +       for (x = 0; x < cfg_size; x += 3) {
> +               regInfo = (struct max98927_reg_default *)&max98927->regcfg[x];
> +               dev_info(codec->dev, "CH:%d, reg:0x%02x, value:0x%02x\n",
> +                       be32_to_cpu(regInfo->ch),
> +                       be32_to_cpu(regInfo->reg),
> +                       be32_to_cpu(regInfo->def));
> +               if (be32_to_cpu(regInfo->ch) == PRI_MAX98927
> +                       && max98927->regmap)
> +                       regmap_write(max98927->regmap,
> +                               be32_to_cpu(regInfo->reg),
> +                               be32_to_cpu(regInfo->def));
> +               else if (be32_to_cpu(regInfo->ch) == SEC_MAX98927
> +                       && max98927->sub_regmap)
> +                       regmap_write(max98927->sub_regmap,
> +                               be32_to_cpu(regInfo->reg),
> +                               be32_to_cpu(regInfo->def));
> +       }
> +}
> +
> +static int max98927_dac_event(struct snd_soc_dapm_widget *w,
> +       struct snd_kcontrol *kcontrol, int event)
> +{
> +       struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
> +       struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +
> +       switch (event) {
> +       case SND_SOC_DAPM_POST_PMU:
> +               max98927_wrap_update_bits(max98927,
> +                       MAX98927_AMP_enables, 1, 1);
> +               /* enable the v and i for vi feedback */
> +               max98927_wrap_update_bits(max98927,
> +                       MAX98927_Measurement_enables,
> +                       MAX98927_Measurement_enables_IVADC_V_EN,
> +                       MAX98927_Measurement_enables_IVADC_V_EN);
> +               max98927_wrap_update_bits(max98927,
> +                       MAX98927_Measurement_enables,
> +                       MAX98927_Measurement_enables_IVADC_I_EN,
> +                       MAX98927_Measurement_enables_IVADC_I_EN);
> +               max98927_wrap_update_bits(max98927,
> +                       MAX98927_Global_Enable, 1, 1);
> +               break;
> +       case SND_SOC_DAPM_POST_PMD:
> +               max98927_wrap_update_bits(max98927,
> +                       MAX98927_Global_Enable, 1, 0);
> +               max98927_wrap_update_bits(max98927,
> +                       MAX98927_AMP_enables, 1, 0);
> +               /* disable the v and i for vi feedback */
> +               max98927_wrap_update_bits(max98927,
> +                       MAX98927_Measurement_enables,
> +                       MAX98927_Measurement_enables_IVADC_V_EN,
> +                       0);
> +               max98927_wrap_update_bits(max98927,
> +                       MAX98927_Measurement_enables,
> +                       MAX98927_Measurement_enables_IVADC_I_EN,
> +                       0);
> +               break;
> +       default:
> +               return 0;
> +       }
> +       return 0;
> +}
> +
> +static const struct snd_soc_dapm_widget max98927_dapm_widgets[] = {
> +       SND_SOC_DAPM_AIF_IN("DAI_OUT", "HiFi Playback", 0, SND_SOC_NOPM, 0, 0),
> +       SND_SOC_DAPM_DAC_E("Amp Enable", "HiFi Playback", MAX98927_AMP_enables,
> +               0, 0, max98927_dac_event,
> +               SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
> +       SND_SOC_DAPM_OUTPUT("BE_OUT"),
> +};
> +
> +static DECLARE_TLV_DB_SCALE(max98927_spk_tlv, 300, 300, 0);
> +static DECLARE_TLV_DB_SCALE(max98927_digital_tlv, -1600, 25, 0);
> +
> +static int max98927_spk_gain_get(struct snd_kcontrol *kcontrol,
> +                               struct snd_ctl_elem_value *ucontrol)
> +{
> +       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +       struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +
> +       ucontrol->value.integer.value[0] = max98927->spk_gain;
> +       dev_dbg(codec->dev, "%s: spk_gain setting returned %d\n", __func__,
> +               (int) ucontrol->value.integer.value[0]);
> +       return 0;
> +}
> +
> +static int max98927_spk_gain_put(struct snd_kcontrol *kcontrol,
> +                               struct snd_ctl_elem_value *ucontrol)
> +{
> +       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +       struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +       unsigned int sel = ucontrol->value.integer.value[0];
> +
> +       if (sel < ((1 << MAX98927_Speaker_Gain_Width) - 1)) {
> +               max98927_wrap_update_bits(max98927, MAX98927_Speaker_Gain,
> +                       MAX98927_Speaker_Gain_SPK_PCM_GAIN_Mask, sel);
> +               max98927->spk_gain = sel;
> +       }
> +       return 0;
> +}
> +
> +static int max98927_digital_gain_get(struct snd_kcontrol *kcontrol,
> +                               struct snd_ctl_elem_value *ucontrol)
> +{
> +       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +       struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +
> +       ucontrol->value.integer.value[0] = max98927->digital_gain;
> +       dev_dbg(codec->dev, "%s: spk_gain setting returned %d\n", __func__,
> +               (int) ucontrol->value.integer.value[0]);
> +       return 0;
> +}
> +
> +static int max98927_digital_gain_put(struct snd_kcontrol *kcontrol,
> +                               struct snd_ctl_elem_value *ucontrol)
> +{
> +       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +       struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +       unsigned int sel = ucontrol->value.integer.value[0];
> +
> +       if (sel < ((1 << MAX98927_AMP_VOL_WIDTH) - 1)) {
> +               max98927_wrap_update_bits(max98927, MAX98927_AMP_volume_control,
> +                       MAX98927_AMP_volume_control_AMP_VOL_Mask, sel);
> +               max98927->digital_gain = sel;
> +       }
> +       return 0;
> +}
> +
> +static int max98927_boost_voltage_get(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       return max98927_reg_get(kcontrol, ucontrol, MAX98927_Boost_Control_0,
> +               MAX98927_Boost_Control_0_BST_VOUT_Mask, 0);
> +}
> +
> +static int max98927_boost_voltage_put(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       return max98927_reg_put(kcontrol, ucontrol, MAX98927_Boost_Control_0,
> +               MAX98927_Boost_Control_0_BST_VOUT_Mask, 0);
> +}
> +
> +static int max98927_amp_vol_get(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       return max98927_reg_get(kcontrol, ucontrol, MAX98927_Boost_Control_0,
> +               MAX98927_Boost_Control_0_BST_VOUT_Mask,
> +               MAX98927_AMP_VOL_LOCATION_SHIFT);
> +}
> +
> +static int max98927_amp_dsp_put(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       return max98927_reg_put(kcontrol, ucontrol, MAX98927_Brownout_enables,
> +               MAX98927_Brownout_enables_AMP_DSP_EN, MAX98927_BDE_DSP_SHIFT);
> +}
> +
> +static int max98927_amp_dsp_get(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       return max98927_reg_get(kcontrol, ucontrol, MAX98927_Brownout_enables,
> +               MAX98927_Brownout_enables_AMP_DSP_EN, MAX98927_BDE_DSP_SHIFT);
> +}
> +
> +static int max98927_ramp_switch_put(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       return max98927_reg_put(kcontrol, ucontrol, MAX98927_AMP_DSP_Config,
> +               MAX98927_AMP_DSP_Config_AMP_VOL_RMP_BYPASS,
> +               MAX98927_SPK_RMP_EN_SHIFT);
> +}
> +static int max98927_ramp_switch_get(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       return max98927_reg_get(kcontrol, ucontrol, MAX98927_AMP_DSP_Config,
> +               MAX98927_AMP_DSP_Config_AMP_VOL_RMP_BYPASS,
> +               MAX98927_SPK_RMP_EN_SHIFT);
> +}
> +
> +static int max98927_dre_en_put(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       return max98927_reg_put(kcontrol, ucontrol, MAX98927_DRE_Control,
> +               MAX98927_DRE_Control_DRE_EN, 0);
> +}
> +static int max98927_dre_en_get(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       return max98927_reg_get(kcontrol, ucontrol, MAX98927_DRE_Control,
> +               MAX98927_DRE_Control_DRE_EN, 0);
> +}
> +static int max98927_amp_vol_put(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       return max98927_reg_put(kcontrol, ucontrol,
> +               MAX98927_AMP_volume_control,
> +               MAX98927_AMP_volume_control_AMP_VOL_SEL,
> +               MAX98927_AMP_VOL_LOCATION_SHIFT);
> +}
> +static int max98927_spk_src_get(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       return max98927_reg_get(kcontrol, ucontrol,
> +               MAX98927_Speaker_source_select,
> +               MAX98927_Speaker_source_select_SPK_SOURCE_Mask, 0);
> +}
> +
> +static int max98927_spk_src_put(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       return max98927_reg_put(kcontrol, ucontrol,
> +               MAX98927_Speaker_source_select,
> +               MAX98927_Speaker_source_select_SPK_SOURCE_Mask, 0);
> +}
> +
> +static int max98927_mono_out_get(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       return max98927_reg_get(kcontrol, ucontrol,
> +               MAX98927_PCM_to_speaker_monomix_A,
> +               MAX98927_PCM_to_spkmonomix_A_DMONOMIX_CFG_Mask,
> +               MAX98927_PCM_to_speaker_monomix_A_SHIFT);
> +}
> +
> +static int max98927_mono_out_put(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       return max98927_reg_put(kcontrol, ucontrol,
> +               MAX98927_PCM_to_speaker_monomix_A,
> +               MAX98927_PCM_to_spkmonomix_A_DMONOMIX_CFG_Mask,
> +               MAX98927_PCM_to_speaker_monomix_A_SHIFT);
> +}
> +
> +static bool max98927_readable_register(struct device *dev, unsigned int reg)
> +{
> +       switch (reg) {
> +       case 0x0001 ... 0x0028:
> +       case 0x002B ... 0x004E:
> +       case 0x0051 ... 0x0055:
> +       case 0x005A ... 0x0061:
> +       case 0x0072 ... 0x0087:
> +       case 0x00FF:
> +       case 0x0100:
> +       case 0x01FF:
> +               return true;
> +       }
> +       return false;
> +};
> +
> +static const char * const max98927_boost_voltage_text[] = {
> +       "6.5V", "6.625V", "6.75V", "6.875V", "7V", "7.125V", "7.25V", "7.375V",
> +       "7.5V", "7.625V", "7.75V", "7.875V", "8V", "8.125V", "8.25V", "8.375V",
> +       "8.5V", "8.625V", "8.75V", "8.875V", "9V", "9.125V", "9.25V", "9.375V",
> +       "9.5V", "9.625V", "9.75V", "9.875V", "10V"
> +};
> +
> +static const char * const max98927_speaker_source_text[] = {
> +       "i2s", "reserved", "tone", "pdm"
> +};
> +
> +static const char * const max98927_monomix_output_text[] = {
> +       "ch_0", "ch_1", "ch_1_2_div"
> +};
> +
> +static const struct soc_enum max98927_enum[] = {
> +       SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(max98927_monomix_output_text),
> +               max98927_monomix_output_text),
> +       SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(max98927_speaker_source_text),
> +               max98927_speaker_source_text),
> +       SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(max98927_boost_voltage_text),
> +               max98927_boost_voltage_text),
> +};
> +
> +static const struct snd_kcontrol_new max98927_snd_controls[] = {
> +       SOC_SINGLE_EXT_TLV("Speaker Volume", MAX98927_Speaker_Gain,
> +               0, (1<<MAX98927_Speaker_Gain_Width)-1, 0,
> +               max98927_spk_gain_get, max98927_spk_gain_put,
> +               max98927_spk_tlv),
> +       SOC_SINGLE_EXT_TLV("Digital Gain", MAX98927_AMP_volume_control,
> +               0, (1<<MAX98927_AMP_VOL_WIDTH)-1, 0,
> +               max98927_digital_gain_get, max98927_digital_gain_put,
> +               max98927_digital_tlv),
> +       SOC_SINGLE_EXT("Amp DSP Enable", MAX98927_Brownout_enables,
> +               MAX98927_BDE_DSP_SHIFT, 1, 0,
> +               max98927_amp_dsp_get, max98927_amp_dsp_put),
> +       SOC_SINGLE_EXT("Ramp Switch", MAX98927_AMP_DSP_Config,
> +               MAX98927_SPK_RMP_EN_SHIFT, 1, 1,
> +               max98927_ramp_switch_get, max98927_ramp_switch_put),
> +       SOC_SINGLE_EXT("DRE EN", MAX98927_DRE_Control,
> +               MAX98927_DRE_Control_DRE_SHIFT, 1, 0,
> +               max98927_dre_en_get, max98927_dre_en_put),
> +       SOC_SINGLE_EXT("Amp Volume Location", MAX98927_AMP_volume_control,
> +               MAX98927_AMP_VOL_LOCATION_SHIFT, 1, 0,
> +               max98927_amp_vol_get, max98927_amp_vol_put),
> +
> +       SOC_ENUM_EXT("Boost Output Voltage", max98927_enum[2],
> +       max98927_boost_voltage_get, max98927_boost_voltage_put),
> +       SOC_ENUM_EXT("Speaker Source", max98927_enum[1],
> +       max98927_spk_src_get, max98927_spk_src_put),
> +       SOC_ENUM_EXT("Monomix Output", max98927_enum[0],
> +       max98927_mono_out_get, max98927_mono_out_put),
> +};
> +
> +static const struct snd_soc_dapm_route max98927_audio_map[] = {
> +       {"BE_OUT", NULL, "Amp Enable"},
> +};
> +
> +static struct snd_soc_dai_driver max98927_dai[] = {
> +       {
> +               .name = "max98927-aif1",
> +               .playback = {
> +                       .stream_name = "HiFi Playback",
> +                       .channels_min = 1,
> +                       .channels_max = 2,
> +                       .rates = MAX98927_RATES,
> +                       .formats = MAX98927_FORMATS,
> +               },
> +               .capture = {
> +                       .stream_name = "HiFi Capture",
> +                       .channels_min = 1,
> +                       .channels_max = 2,
> +                       .rates = MAX98927_RATES,
> +                       .formats = MAX98927_FORMATS,
> +               },
> +               .ops = &max98927_dai_ops,
> +       }
> +};
> +
> +static int max98927_probe(struct snd_soc_codec *codec)
> +{
> +       struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +       int ret = 0, reg = 0, i;
> +
> +       max98927->codec = codec;
> +       codec->control_data = max98927->regmap;
> +       codec->cache_bypass = 1;
> +
> +       /* Software Reset */
> +       max98927_wrapper_write(max98927,
> +               MAX98927_Software_Reset, MAX98927_Software_Reset_RST);
> +
> +       /* Check Revision ID for the primary MAX98927*/
> +       ret = regmap_read(max98927->regmap, MAX98927_REV_ID, &reg);
> +       if (ret < 0)
> +               dev_err(codec->dev,
> +                       "Failed to read: 0x%02X\n", MAX98927_REV_ID);
> +       else
> +               dev_info(codec->dev,
> +                       "MAX98927 revisionID: 0x%02X\n", reg);
> +
> +       /* Check Revision ID for the secondary MAX98927*/
> +       if (max98927->sub_regmap) {
> +               ret = regmap_read(max98927->sub_regmap, MAX98927_REV_ID, &reg);
> +               if (ret < 0)
> +                       dev_err(codec->dev,
> +                               "Failed to read: 0x%02X from secodnary device\n"
> +                               , MAX98927_REV_ID);
> +               else
> +                       dev_info(codec->dev,
> +                               "Secondary device revisionID: 0x%02X\n", reg);
> +       }
> +
> +       /* Register initialization */
> +       for (i = 0; i < sizeof(max98927_reg_map)/
> +                       sizeof(max98927_reg_map[0]); i++)
> +               max98927_wrapper_write(max98927,
> +                       max98927_reg_map[i].reg,
> +                       max98927_reg_map[i].def);
> +
> +       if (max98927->regmap)
> +               regmap_write(max98927->regmap,
> +                       MAX98927_PCM_Tx_Channel_Sources_A,
> +                       (max98927->i_l_slot
> +                               <<MAX98927_PCM_Tx_Ch_Sources_A_I_SHIFT|
> +                       max98927->v_l_slot)&0xFF);
> +       if (max98927->sub_regmap)
> +               regmap_write(max98927->sub_regmap,
> +                       MAX98927_PCM_Tx_Channel_Sources_A,
> +                       (max98927->i_r_slot
> +                               <<MAX98927_PCM_Tx_Ch_Sources_A_I_SHIFT|
> +                       max98927->v_r_slot)&0xFF);
> +
> +       /* Set interleave mode */
> +       if (max98927->interleave_mode)
> +               max98927_wrap_update_bits(max98927,
> +                               MAX98927_PCM_Tx_Channel_Sources_B,
> +                               MAX98927_PCM_Tx_Channel_Src_INTERLEAVE_Mask,
> +                               MAX98927_PCM_Tx_Channel_Src_INTERLEAVE_Mask);
> +
> +       max98927_handle_pdata(codec);
> +
> +       return ret;
> +}
> +
> +static const struct snd_soc_codec_driver soc_codec_dev_max98927 = {
> +       .probe            = max98927_probe,
> +       .dapm_routes = max98927_audio_map,
> +       .num_dapm_routes = ARRAY_SIZE(max98927_audio_map),
> +       .dapm_widgets = max98927_dapm_widgets,
> +       .num_dapm_widgets = ARRAY_SIZE(max98927_dapm_widgets),
> +       .controls = max98927_snd_controls,
> +       .num_controls = ARRAY_SIZE(max98927_snd_controls),
> +};
> +
> +static const struct regmap_config max98927_regmap = {
> +       .reg_bits         = 16,
> +       .val_bits         = 8,
> +       .max_register     = MAX98927_REV_ID,
> +       .reg_defaults     = max98927_reg_map,
> +       .num_reg_defaults = ARRAY_SIZE(max98927_reg_map),
> +       .readable_reg     = max98927_readable_register,
> +       .cache_type       = REGCACHE_RBTREE,
> +};
> +
> +static struct i2c_board_info max98927_i2c_sub_board[] = {
> +       {
> +               I2C_BOARD_INFO("max98927_sub", 0x39),
> +       }
> +};
> +
> +static struct i2c_driver max98927_i2c_sub_driver = {
> +       .driver = {
> +               .name = "max98927_sub",
> +               .owner = THIS_MODULE,
> +       },
> +};
> +
> +struct i2c_client *max98927_add_sub_device(int bus_id, int slave_addr)
> +{
> +       struct i2c_client *i2c = NULL;
> +       struct i2c_adapter *adapter;
> +
> +       max98927_i2c_sub_board[0].addr = slave_addr;
> +
> +       adapter = i2c_get_adapter(bus_id);
> +       if (adapter) {
> +               i2c = i2c_new_device(adapter, max98927_i2c_sub_board);
> +               if (i2c)
> +                       i2c->dev.driver = &max98927_i2c_sub_driver.driver;
> +       }
> +
> +       return i2c;
> +}
> +
> +int probe_common(struct i2c_client *i2c, struct max98927_priv *max98927)
> +{
> +       int ret = 0, value;
> +
> +       if (!of_property_read_u32(i2c->dev.of_node, "vmon-l-slot", &value))
> +               max98927->v_l_slot = value & 0xF;
> +       else
> +               max98927->v_l_slot = 0;
> +       if (!of_property_read_u32(i2c->dev.of_node, "imon-l-slot", &value))
> +               max98927->i_l_slot = value & 0xF;
> +       else
> +               max98927->i_l_slot = 1;
> +       if (!of_property_read_u32(i2c->dev.of_node, "vmon-r-slot", &value))
> +               max98927->v_r_slot = value & 0xF;
> +       else
> +               max98927->v_r_slot = 2;
> +       if (!of_property_read_u32(i2c->dev.of_node, "imon-r-slot", &value))
> +               max98927->i_r_slot = value & 0xF;
> +       else
> +               max98927->i_r_slot = 3;
> +
> +       ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98927,
> +               max98927_dai, ARRAY_SIZE(max98927_dai));
> +       if (ret < 0)
> +               dev_err(&i2c->dev,
> +                   "Failed to register codec: %d\n", ret);
> +       return ret;
> +}
> +
> +static int max98927_i2c_probe(struct i2c_client *i2c,
> +       const struct i2c_device_id *id)
> +{
> +
> +       int ret = 0, value;
> +       struct max98927_priv *max98927 = NULL;
> +
> +       max98927 = devm_kzalloc(&i2c->dev,
> +               sizeof(*max98927), GFP_KERNEL);
> +
> +       if (!max98927) {
> +               ret = -ENOMEM;
> +               goto err;
> +       }
> +       i2c_set_clientdata(i2c, max98927);
> +
> +       /* update interleave mode info */
> +       if (!of_property_read_u32(i2c->dev.of_node,
> +               "interleave_mode", &value)) {
> +               if (value > 0)
> +                       max98927->interleave_mode = 1;
> +               else
> +                       max98927->interleave_mode = 0;
> +       } else
> +               max98927->interleave_mode = 0;
> +
> +       /* update direct configuration info */
> +       max98927->regcfg = of_get_property(i2c->dev.of_node,
> +                       "maxim,regcfg", &max98927->regcfg_sz);
> +
> +       /* check for secondary MAX98927 */
> +       ret = of_property_read_u32(i2c->dev.of_node,
> +                       "maxim,sub_reg", &max98927->sub_reg);
> +       if (ret) {
> +               dev_err(&i2c->dev, "Sub-device slave address was not found.\n");
> +               max98927->sub_reg = -1;
> +       }
> +       ret = of_property_read_u32(i2c->dev.of_node,
> +                       "maxim,sub_bus", &max98927->sub_bus);
> +       if (ret) {
> +               dev_err(&i2c->dev, "Sub-device bus information was not found.\n");
> +               max98927->sub_bus = i2c->adapter->nr;
> +       }
> +
> +       /* regmap initialization for primary device */
> +       max98927->regmap
> +               = devm_regmap_init_i2c(i2c, &max98927_regmap);
> +       if (IS_ERR(max98927->regmap)) {
> +               ret = PTR_ERR(max98927->regmap);
> +               dev_err(&i2c->dev,
> +                       "Failed to allocate regmap: %d\n", ret);
> +               goto err;
> +       }
> +
> +       /* regmap initialization for secondary device */
> +       if (max98927->sub_reg > 0)      {
> +               max98927->sub_i2c = max98927_add_sub_device(max98927->sub_bus,
> +                       max98927->sub_reg);
> +               if (IS_ERR(max98927->sub_i2c)) {
> +                       dev_err(&max98927->sub_i2c->dev,
> +                                       "Second MAX98927 was not found\n");
> +                       ret = PTR_ERR(max98927->regmap);
> +                       goto err;
> +               } else {
> +                       max98927->sub_regmap = regmap_init_i2c(
> +                                       max98927->sub_i2c, &max98927_regmap);
> +                       if (IS_ERR(max98927->sub_regmap)) {
> +                               ret = PTR_ERR(max98927->sub_regmap);
> +                               dev_err(&max98927->sub_i2c->dev,
> +                                       "Failed to allocate sub_regmap: %d\n",
> +                                       ret);
> +                               goto err;
> +                       }
> +               }
> +       }
> +
> +       /* codec registeration */
> +       ret = probe_common(i2c, max98927);
> +
> +       return ret;
> +
> +err:
> +       if (max98927)
> +               devm_kfree(&i2c->dev, max98927);
> +       return ret;
> +}
> +
> +static int max98927_i2c_remove(struct i2c_client *client)
> +{
> +       snd_soc_unregister_codec(&client->dev);
> +       return 0;
> +}
> +
> +static const struct i2c_device_id max98927_i2c_id[] = {
> +       { "max98927", 0},
> +       { },
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, max98927_i2c_id);
> +
> +static const struct of_device_id max98927_of_match[] = {
> +       { .compatible = "maxim,max98927", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, max98927_of_match);
> +
> +static struct i2c_driver max98927_i2c_driver = {
> +       .driver = {
> +               .name = "max98927",
> +               .owner = THIS_MODULE,
> +               .of_match_table = of_match_ptr(max98927_of_match),
> +               .pm = NULL,
> +       },
> +       .probe  = max98927_i2c_probe,
> +       .remove = max98927_i2c_remove,
> +       .id_table = max98927_i2c_id,
> +};
> +
> +module_i2c_driver(max98927_i2c_driver)
> +
> +MODULE_DESCRIPTION("ALSA SoC MAX98927 driver");
> +MODULE_AUTHOR("Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
> new file mode 100755
> index 0000000..2305185
> --- /dev/null
> +++ b/sound/soc/codecs/max98927.h
> @@ -0,0 +1,1253 @@
> +/*
> + * max98927.c  --  MAX98927 ALSA Soc Audio driver
> + *
> + * Copyright 2008-11 Wolfson Microelectronics PLC.
> + * Author: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + */
> +#ifndef __MAX98927_REGISTERDEFS_H
> +#define __MAX98927_REGISTERDEFS_H
> +#ifdef CONFIG_SND_SOC_MAXIM_DSM
> +#include <sound/maxim_dsm.h>
> +#endif /* CONFIG_SND_SOC_MAXIM_DSM */
> +
> +enum {
> +       PRI_MAX98927 = 0,
> +       SEC_MAX98927 = 1,
> +       MAX_DEV_ID_MAX98927,
> +} MAX98927deviceID;
> +
> +enum {
> +       /*Interrupt Raw 1 (Address 0x0001)*/
> +       MAX98927_Interrupt_Raw_1 = 0x0001,
> +       MAX98927_Interrupt_Raw_1_BDE_ACTIVE_END_RAW = (0x1 << 0),
> +       MAX98927_Interrupt_Raw_1_BDE_ACTIVE_BGN_RAW = (0x1 << 1),
> +       MAX98927_Interrupt_Raw_1_BDE_LEVEL_CHANGE_RAW = (0x1 << 2),
> +       MAX98927_Interrupt_Raw_1_BDE_L8_RAW = (0x1 << 3),
> +       MAX98927_Interrupt_Raw_1_THERMWARN_END_RAW = (0x1 << 4),
> +       MAX98927_Interrupt_Raw_1_THERMWARN_START_RAW = (0x1 << 5),
> +       MAX98927_Interrupt_Raw_1_THERMSHDN_END_RAW = (0x1 << 6),
> +       MAX98927_Interrupt_Raw_1_THERMSHDN_START_RAW = (0x1 << 7),
> +
> +       /* Interrupt Raw 2 (Address 0x0002)*/
> +       MAX98927_Interrupt_Raw_2 = 0x0002,
> +       MAX98927_Interrupt_Raw_2_WATCHDOGWARN_RAW = (0x1 << 0),
> +       MAX98927_Interrupt_Raw_2_WATCHDOGFAIL_RAW = (0x1 << 1),
> +       MAX98927_Interrupt_Raw_2_BOOSTCURRLIM_RAW = (0x1 << 2),
> +       MAX98927_Interrupt_Raw_2_CLKSTOP_RAW = (0x1 << 3),
> +       MAX98927_Interrupt_Raw_2_CLKSTART_RAW = (0x1 << 4),
> +       MAX98927_Interrupt_Raw_2_MEASADC_END_RAW = (0x1 << 5),
> +       MAX98927_Interrupt_Raw_2_PWRDN_DONE_RAW = (0x1 << 6),
> +       MAX98927_Interrupt_Raw_2_PWRUP_DONE_RAW = (0x1 << 7),
> +
> +       /* Interrupt Raw 3 (Address 0x0003)*/
> +       MAX98927_Interrupt_Raw_3  = 0x0003,
> +       MAX98927_Interrupt_Raw_3_PWRUP_FAIL_RAW = (0x1 << 0),
> +       MAX98927_Interrupt_Raw_3_AUTH_DONE_RAW  = (0x1 << 1),
> +       MAX98927_Interrupt_Raw_3_SPK_OVC_RAW = (0x1 << 2),
> +       MAX98927_Interrupt_Raw_3_BST_UVLO_RAW = (0x1 << 3),
> +
> +       /* Interrupt State 1 (Address 0x0004)*/
> +       MAX98927_Interrupt_State_1  = 0x0004,
> +       MAX98927_Interrupt_State_1_BDE_ACTIVE_END_STATE  = (0x1 << 0),
> +       MAX98927_Interrupt_State_1_BDE_ACTIVE_BGN_STATE  = (0x1 << 1),
> +       MAX98927_Interrupt_State_1_BDE_LEVEL_CHANGE_STATE  = (0x1 << 2),
> +       MAX98927_Interrupt_State_1_BDE_L8_STATE = (0x1 << 3),
> +       MAX98927_Interrupt_State_1_THERMWARN_END_STATE   = (0x1 << 4),
> +       MAX98927_Interrupt_State_1_THERMWARN_START_STATE = (0x1 << 5),
> +       MAX98927_Interrupt_State_1_THERMSHDN_END_STATE   = (0x1 << 6),
> +       MAX98927_Interrupt_State_1_THERMSHDN_START_STATE = (0x1 << 7),
> +
> +       /* Interrupt State 2 (Address 0x0005)*/
> +       MAX98927_Interrupt_State_2  = 0x0005,
> +       MAX98927_Interrupt_State_2_WATCHDOGWARN_STATE = (0x1 << 0),
> +       MAX98927_Interrupt_State_2_WATCHDOGFAIL_STATE = (0x1 << 1),
> +       MAX98927_Interrupt_State_2_BOOSTCURRLIM_STATE = (0x1 << 2),
> +       MAX98927_Interrupt_State_2_CLKSTOP_STATE  = (0x1 << 3),
> +       MAX98927_Interrupt_State_2_CLKSTART_STATE = (0x1 << 4),
> +       MAX98927_Interrupt_State_2_MEASADC_END_STATE = (0x1 << 5),
> +       MAX98927_Interrupt_State_2_PWRDN_DONE_STATE  = (0x1 << 6),
> +       MAX98927_Interrupt_State_2_PWRUP_DONE_STATE  = (0x1 << 7),
> +
> +       /* Interrupt State 3 (Address 0x0006)*/
> +       MAX98927_Interrupt_State_3  = 0x0006,
> +       MAX98927_Interrupt_State_3_PWRUP_FAIL_STATE  = (0x1 << 0),
> +       MAX98927_Interrupt_State_3_AUTH_DONE_STATE = (0x1 << 1),
> +       MAX98927_Interrupt_State_3_SPK_OVC_STATE  = (0x1 << 2),
> +       MAX98927_Interrupt_State_3_BST_UVLO_STATE = (0x1 << 3),
> +
> +       /* Interrupt Flag 1 (Address 0x0007)*/
> +       MAX98927_Interrupt_Flag_1 = 0x0007,
> +       MAX98927_Interrupt_Flag_1_BDE_ACTIVE_END_FLAG = (0x1 << 0),
> +       MAX98927_Interrupt_Flag_1_BDE_ACTIVE_BGN_FLAG = (0x1 << 1),
> +       MAX98927_Interrupt_Flag_1_BDE_LEVEL_CHANGE_FLAG  = (0x1 << 2),
> +       MAX98927_Interrupt_Flag_1_BDE_L8_FLAG = (0x1 << 3),
> +       MAX98927_Interrupt_Flag_1_THERMWARN_END_FLAG = (0x1 << 4),
> +       MAX98927_Interrupt_Flag_1_THERMWARN_START_FLAG   = (0x1 << 5),
> +       MAX98927_Interrupt_Flag_1_THERMSHDN_END_FLAG = (0x1 << 6),
> +       MAX98927_Interrupt_Flag_1_THERMSHDN_START_FLAG   = (0x1 << 7),
> +
> +       /* Interrupt Flag 2 (Address 0x0008)*/
> +       MAX98927_Interrupt_Flag_2 = 0x0008,
> +       MAX98927_Interrupt_Flag_2_WATCHDOGWARN_FLAG  = (0x1 << 0),
> +       MAX98927_Interrupt_Flag_2_WATCHDOGFAIL_FLAG  = (0x1 << 1),
> +       MAX98927_Interrupt_Flag_2_BOOSTCURRLIM_FLAG  = (0x1 << 2),
> +       MAX98927_Interrupt_Flag_2_CLKSTOP_FLAG  = (0x1 << 3),
> +       MAX98927_Interrupt_Flag_2_CLKSTART_FLAG = (0x1 << 4),
> +       MAX98927_Interrupt_Flag_2_MEASADC_END_FLAG = (0x1 << 5),
> +       MAX98927_Interrupt_Flag_2_PWRDN_DONE_FLAG = (0x1 << 6),
> +       MAX98927_Interrupt_Flag_2_PWRUP_DONE_FLAG = (0x1 << 7),
> +
> +       /* Interrupt Flag 3 (Address 0x0009)*/
> +       MAX98927_Interrupt_Flag_3 = 0x0009,
> +       MAX98927_Interrupt_Flag_3_PWRUP_FAIL_FLAG = (0x1 << 0),
> +       MAX98927_Interrupt_Flag_3_AUTH_DONE_FLAG  = (0x1 << 1),
> +       MAX98927_Interrupt_Flag_3_SPK_OVC_FLAG  = (0x1 << 2),
> +       MAX98927_Interrupt_Flag_3_BST_UVLO_FLAG = (0x1 << 3),
> +
> +       /* Interrupt Enable 1 (Address 0x000a)*/
> +       MAX98927_Interrupt_Enable_1 = 0x000a,
> +       MAX98927_Interrupt_Enable_1_BDE_ACTIVE_END_EN = (0x1 << 0),
> +       MAX98927_Interrupt_Enable_1_BDE_ACTIVE_BGN_EN = (0x1 << 1),
> +       MAX98927_Interrupt_Enable_1_BDE_LEVEL_CHANGE_EN  = (0x1 << 2),
> +       MAX98927_Interrupt_Enable_1_BDE_L8_EN = (0x1 << 3),
> +       MAX98927_Interrupt_Enable_1_THERMWARN_END_EN = (0x1 << 4),
> +       MAX98927_Interrupt_Enable_1_THERMWARN_START_EN   = (0x1 << 5),
> +       MAX98927_Interrupt_Enable_1_THERMSHDN_END_EN = (0x1 << 6),
> +       MAX98927_Interrupt_Enable_1_THERMSHDN_START_EN   = (0x1 << 7),
> +
> +       /* Interrupt Enable 2 (Address 0x000b)*/
> +       MAX98927_Interrupt_Enable_2 = 0x000b,
> +       MAX98927_Interrupt_Enable_2_WATCHDOGWARN_EN  = (0x1 << 0),
> +       MAX98927_Interrupt_Enable_2_WATCHDOGFAIL_EN  = (0x1 << 1),
> +       MAX98927_Interrupt_Enable_2_BOOSTCURRLIM_EN  = (0x1 << 2),
> +       MAX98927_Interrupt_Enable_2_CLKSTOP_EN  = (0x1 << 3),
> +       MAX98927_Interrupt_Enable_2_CLKSTART_EN = (0x1 << 4),
> +       MAX98927_Interrupt_Enable_2_MEASADC_END_EN = (0x1 << 5),
> +       MAX98927_Interrupt_Enable_2_PWRDN_DONE_EN = (0x1 << 6),
> +       MAX98927_Interrupt_Enable_2_PWRUP_DONE_EN = (0x1 << 7),
> +
> +       /* Interrupt Enable 3 (Address 0x000c)*/
> +       MAX98927_Interrupt_Enable_3 = 0x000c,
> +       MAX98927_Interrupt_Enable_3_PWRUP_FAIL_EN = (0x1 << 0),
> +       MAX98927_Interrupt_Enable_3_AUTH_DONE_EN  = (0x1 << 1),
> +       MAX98927_Interrupt_Enable_3_SPK_OVC_EN  = (0x1 << 2),
> +       MAX98927_Interrupt_Enable_3_BST_UVLO_EN = (0x1 << 3),
> +
> +       /* Interrupt Flag Clear 1 (Address 0x000d)*/
> +       MAX98927_Interrupt_Flag_Clear_1  = 0x000d,
> +       MAX98927_Interrupt_Flag_Clear_1_BDE_ACTIVE_END_CLR = (0x1 << 0),
> +       MAX98927_Interrupt_Flag_Clear_1_BDE_ACTIVE_BGN_CLR = (0x1 << 1),
> +       MAX98927_Interrupt_Flag_Clear_1_BDE_LEVEL_CHANGE_CLR = (0x1 << 2),
> +       MAX98927_Interrupt_Flag_Clear_1_BDE_L8_CLR = (0x1 << 3),
> +       MAX98927_Interrupt_Flag_Clear_1_THERMWARN_END_CLR  = (0x1 << 4),
> +       MAX98927_Interrupt_Flag_Clear_1_THERMWARN_START_CLR  = (0x1 << 5),
> +       MAX98927_Interrupt_Flag_Clear_1_THERMSHDN_END_CLR  = (0x1 << 6),
> +       MAX98927_Interrupt_Flag_Clear_1_THERMSHDN_START_CLR  = (0x1 << 7),
> +
> +       /* Interrupt Flag Clear 2 (Address 0x000e)*/
> +       MAX98927_Interrupt_Flag_Clear_2  = 0x000e,
> +       MAX98927_Interrupt_Flag_Clear_2_WATCHDOGWARN_CLR = (0x1 << 0),
> +       MAX98927_Interrupt_Flag_Clear_2_WATCHDOGFAIL_CLR = (0x1 << 1),
> +       MAX98927_Interrupt_Flag_Clear_2_BOOSTCURRLIM_CLR = (0x1 << 2),
> +       MAX98927_Interrupt_Flag_Clear_2_CLKSTOP_CLR  = (0x1 << 3),
> +       MAX98927_Interrupt_Flag_Clear_2_CLKSTART_CLR = (0x1 << 4),
> +       MAX98927_Interrupt_Flag_Clear_2_MEASADC_END_CLR  = (0x1 << 5),
> +       MAX98927_Interrupt_Flag_Clear_2_PWRDN_DONE_CLR   = (0x1 << 6),
> +       MAX98927_Interrupt_Flag_Clear_2_PWRUP_DONE_CLR   = (0x1 << 7),
> +
> +       /* Interrupt Flag Clear 3 (Address 0x000f)*/
> +       MAX98927_Interrupt_Flag_Clear_3  = 0x000f,
> +       MAX98927_Interrupt_Flag_Clear_3_PWRUP_FAIL_CLR   = (0x1 << 0),
> +       MAX98927_Interrupt_Flag_Clear_3_AUTH_DONE_CLR = (0x1 << 1),
> +       MAX98927_Interrupt_Flag_Clear_3_SPK_OVC_CLR  = (0x1 << 2),
> +       MAX98927_Interrupt_Flag_Clear_3_BST_UVLO_CLR = (0x1 << 3),
> +
> +       /* IRQ Control (Address 0x0010)*/
> +       MAX98927_IRQ_Control  = 0x0010,
> +       MAX98927_IRQ_Control_IRQ_EN = (0x1 << 0),
> +       MAX98927_IRQ_Control_IRQ_POL  = (0x1 << 1),
> +       MAX98927_IRQ_Control_IRQ_MODE = (0x1 << 2),
> +
> +       /* Clock monitor enable (Address 0x0011)*/
> +       MAX98927_Clock_monitor_enable = 0x0011,
> +       MAX98927_Clock_monitor_enable_CMON_ENA  = (0x1 << 0),
> +       MAX98927_Clock_monitor_enable_CMON_AUTORESTART_ENA = (0x1 << 1),
> +
> +       /* Watchdog Control (Address 0x0012)*/
> +       MAX98927_Watchdog_Control = 0x0012,
> +       MAX98927_Watchdog_Control_WDT_ENA  = (0x1 << 0),
> +       MAX98927_Watchdog_Control_WDT_MODE = (0x1 << 1),
> +       MAX98927_Watchdog_Control_WDT_TO_SEL_Mask = (0x3 << 2),
> +       MAX98927_Watchdog_Control_WDT_TO_SEL_5  = (0x0 << 2),
> +       MAX98927_Watchdog_Control_WDT_TO_SEL_10 = (0x1 << 2),
> +       MAX98927_Watchdog_Control_WDT_TO_SEL_35 = (0x2 << 2),
> +       MAX98927_Watchdog_Control_WDT_TO_SEL_50 = (0x3 << 2),
> +       MAX98927_Watchdog_Control_WDT_HW_SOURCE = (0x1 << 4),
> +
> +       /* Watchdog SW Reset (Address 0x0013)*/
> +       MAX98927_Watchdog_SW_Reset  = 0x0013,
> +       MAX98927_Watchdog_SW_Reset_WDT_SW_RST_Mask = (0xff << 0),
> +
> +       /* Meas ADC Thermal Warning Threshhold (Address 0x0014)*/
> +       MAX98927_Meas_ADC_TW_Threshhold = 0x0014,
> +       MAX98927_Meas_ADC_TW_Threshhold_MEAS_ADC_WARN_THRESH_Mask
> +               = (0xff << 0),
> +
> +       /* Meas ADC Thermal Shutdown Threshhold (Address 0x0015)*/
> +       MAX98927_Meas_ADC_TS_Threshhold = 0x0015,
> +       MAX98927_Meas_ADC_TS_Threshhold_MEAS_ADC_SHDN_THRESH_Mask
> +               = (0xff << 0),
> +
> +       /* Meas ADC Thermal Hysteresis (Address 0x0016)*/
> +       MAX98927_Meas_ADC_Thermal_Hysteresis = 0x0016,
> +       MAX98927_Meas_ADC_TH_MEAS_ADC_THERM_HYST_Mask  = (0x1f << 0),
> +
> +       /* Pin Config (Address 0x0017)*/
> +       MAX98927_Pin_Config = 0x0017,
> +       MAX98927_Pin_Config_DOUT_DRV_Mask  = (0x3 << 0),
> +       MAX98927_Pin_Config_DOUT_DRV_01  = (0x0 << 0),
> +       MAX98927_Pin_Config_DOUT_DRV_11  = (0x2 << 0),
> +       MAX98927_Pin_Config_BCLK_DRV_Mask  = (0x3 << 2),
> +       MAX98927_Pin_Config_BCLK_DRV_01  = (0x0 << 2),
> +       MAX98927_Pin_Config_BCLK_DRV_11  = (0x2 << 2),
> +       MAX98927_Pin_Config_LRCLK_DRV_Mask = (0x3 << 4),
> +       MAX98927_Pin_Config_LRCLK_DRV_01 = (0x0 << 4),
> +       MAX98927_Pin_Config_LRCLK_DRV_11 = (0x2 << 4),
> +       MAX98927_Pin_Config_ICC_DRV_Mask = (0x3 << 6),
> +       MAX98927_Pin_Config_ICC_DRV_01 = (0x0 << 6),
> +       MAX98927_Pin_Config_ICC_DRV_11 = (0x2 << 6),
> +
> +       /* PCM Rx Enables A (Address 0x0018)*/
> +       MAX98927_PCM_Rx_Enables_A = 0x0018,
> +       MAX98927_PCM_Rx_Enables_A_PCM_RX_CH0_EN = (0x1 << 0),
> +       MAX98927_PCM_Rx_Enables_A_PCM_RX_CH1_EN = (0x1 << 1),
> +       MAX98927_PCM_Rx_Enables_A_PCM_RX_CH2_EN = (0x1 << 2),
> +       MAX98927_PCM_Rx_Enables_A_PCM_RX_CH3_EN = (0x1 << 3),
> +       MAX98927_PCM_Rx_Enables_A_PCM_RX_CH4_EN = (0x1 << 4),
> +       MAX98927_PCM_Rx_Enables_A_PCM_RX_CH5_EN = (0x1 << 5),
> +       MAX98927_PCM_Rx_Enables_A_PCM_RX_CH6_EN = (0x1 << 6),
> +       MAX98927_PCM_Rx_Enables_A_PCM_RX_CH7_EN = (0x1 << 7),
> +
> +       /* PCM Rx Enables B (Address 0x0019)*/
> +       MAX98927_PCM_Rx_Enables_B = 0x0019,
> +       MAX98927_PCM_Rx_Enables_B_PCM_RX_CH8_EN = (0x1 << 0),
> +       MAX98927_PCM_Rx_Enables_B_PCM_RX_CH9_EN = (0x1 << 1),
> +       MAX98927_PCM_Rx_Enables_B_PCM_RX_CH10_EN  = (0x1 << 2),
> +       MAX98927_PCM_Rx_Enables_B_PCM_RX_CH11_EN  = (0x1 << 3),
> +       MAX98927_PCM_Rx_Enables_B_PCM_RX_CH12_EN  = (0x1 << 4),
> +       MAX98927_PCM_Rx_Enables_B_PCM_RX_CH13_EN  = (0x1 << 5),
> +       MAX98927_PCM_Rx_Enables_B_PCM_RX_CH14_EN  = (0x1 << 6),
> +       MAX98927_PCM_Rx_Enables_B_PCM_RX_CH15_EN  = (0x1 << 7),
> +
> +       /* PCM Tx Enables A (Address 0x001a)*/
> +       MAX98927_PCM_Tx_Enables_A = 0x001a,
> +       MAX98927_PCM_Tx_Enables_A_PCM_TX_CH0_EN = (0x1 << 0),
> +       MAX98927_PCM_Tx_Enables_A_PCM_TX_CH1_EN = (0x1 << 1),
> +       MAX98927_PCM_Tx_Enables_A_PCM_TX_CH2_EN = (0x1 << 2),
> +       MAX98927_PCM_Tx_Enables_A_PCM_TX_CH3_EN = (0x1 << 3),
> +       MAX98927_PCM_Tx_Enables_A_PCM_TX_CH4_EN = (0x1 << 4),
> +       MAX98927_PCM_Tx_Enables_A_PCM_TX_CH5_EN = (0x1 << 5),
> +       MAX98927_PCM_Tx_Enables_A_PCM_TX_CH6_EN = (0x1 << 6),
> +       MAX98927_PCM_Tx_Enables_A_PCM_TX_CH7_EN = (0x1 << 7),
> +
> +       /* PCM Tx Enables B (Address 0x001b)*/
> +       MAX98927_PCM_Tx_Enables_B = 0x001b,
> +       MAX98927_PCM_Tx_Enables_B_PCM_TX_CH8_EN = (0x1 << 0),
> +       MAX98927_PCM_Tx_Enables_B_PCM_TX_CH9_EN = (0x1 << 1),
> +       MAX98927_PCM_Tx_Enables_B_PCM_TX_CH10_EN  = (0x1 << 2),
> +       MAX98927_PCM_Tx_Enables_B_PCM_TX_CH11_EN  = (0x1 << 3),
> +       MAX98927_PCM_Tx_Enables_B_PCM_TX_CH12_EN  = (0x1 << 4),
> +       MAX98927_PCM_Tx_Enables_B_PCM_TX_CH13_EN  = (0x1 << 5),
> +       MAX98927_PCM_Tx_Enables_B_PCM_TX_CH14_EN  = (0x1 << 6),
> +       MAX98927_PCM_Tx_Enables_B_PCM_TX_CH15_EN  = (0x1 << 7),
> +
> +       /* PCM Tx HiZ Control A (Address 0x001c)*/
> +       MAX98927_PCM_Tx_HiZ_Control_A = 0x001c,
> +       MAX98927_PCM_Tx_HiZ_Control_A_PCM_TX_CH0_HIZ = (0x1 << 0),
> +       MAX98927_PCM_Tx_HiZ_Control_A_PCM_TX_CH1_HIZ = (0x1 << 1),
> +       MAX98927_PCM_Tx_HiZ_Control_A_PCM_TX_CH2_HIZ = (0x1 << 2),
> +       MAX98927_PCM_Tx_HiZ_Control_A_PCM_TX_CH3_HIZ = (0x1 << 3),
> +       MAX98927_PCM_Tx_HiZ_Control_A_PCM_TX_CH4_HIZ = (0x1 << 4),
> +       MAX98927_PCM_Tx_HiZ_Control_A_PCM_TX_CH5_HIZ = (0x1 << 5),
> +       MAX98927_PCM_Tx_HiZ_Control_A_PCM_TX_CH6_HIZ = (0x1 << 6),
> +       MAX98927_PCM_Tx_HiZ_Control_A_PCM_TX_CH7_HIZ = (0x1 << 7),
> +
> +       /* PCM Tx HiZ Control B (Address 0x001d)*/
> +       MAX98927_PCM_Tx_HiZ_Control_B = 0x001d,
> +       MAX98927_PCM_Tx_HiZ_Control_B_PCM_TX_CH8_HIZ = (0x1 << 0),
> +       MAX98927_PCM_Tx_HiZ_Control_B_PCM_TX_CH9_HIZ = (0x1 << 1),
> +       MAX98927_PCM_Tx_HiZ_Control_B_PCM_TX_CH10_HIZ = (0x1 << 2),
> +       MAX98927_PCM_Tx_HiZ_Control_B_PCM_TX_CH11_HIZ = (0x1 << 3),
> +       MAX98927_PCM_Tx_HiZ_Control_B_PCM_TX_CH12_HIZ = (0x1 << 4),
> +       MAX98927_PCM_Tx_HiZ_Control_B_PCM_TX_CH13_HIZ = (0x1 << 5),
> +       MAX98927_PCM_Tx_HiZ_Control_B_PCM_TX_CH14_HIZ = (0x1 << 6),
> +       MAX98927_PCM_Tx_HiZ_Control_B_PCM_TX_CH15_HIZ = (0x1 << 7),
> +
> +       /* PCM Tx Channel Sources A (Address 0x001e)*/
> +       MAX98927_PCM_Tx_Channel_Sources_A  = 0x001e,
> +       MAX98927_PCM_Tx_Channel_Sources_A_PCM_IVADC_V_DEST_Mask = (0xf << 0),
> +       MAX98927_PCM_Tx_Channel_Sources_A_PCM_IVADC_I_DEST_Mask = (0xf << 4),
> +
> +       /* PCM Tx Channel Sources B (Address 0x001f)*/
> +       MAX98927_PCM_Tx_Channel_Sources_B  = 0x001f,
> +       MAX98927_PCM_Tx_Channel_Sources_B_PCM_AMP_DSP_DEST_Mask = (0xf << 0),
> +       MAX98927_PCM_Tx_Channel_Src_INTERLEAVE_Mask = (0x1 << 5),
> +
> +       /* PCM Mode Config (Address 0x0020)*/
> +       MAX98927_PCM_Mode_Config  = 0x0020,
> +       MAX98927_PCM_Mode_Config_PCM_TX_EXTRA_HIZ = (0x1 << 0),
> +       MAX98927_PCM_Mode_Config_PCM_CHANSEL = (0x1 << 1),
> +       MAX98927_PCM_Mode_Config_PCM_BCLKEDGE = (0x1 << 2),
> +       MAX98927_PCM_Mode_Config_PCM_FORMAT_Mask  = (0x7 << 3),
> +       MAX98927_PCM_Mode_Config_PCM_FORMAT_I2S = (0x0 << 3),
> +       MAX98927_PCM_Mode_Config_PCM_FORMAT_LEFT  = (0x1 << 3),
> +       MAX98927_PCM_Mode_Config_PCM_FORMAT_TDM_0 = (0x3 << 3),
> +       MAX98927_PCM_Mode_Config_PCM_FORMAT_TDM_1 = (0x4 << 3),
> +       MAX98927_PCM_Mode_Config_PCM_FORMAT_TDM_2 = (0x5 << 3),
> +       MAX98927_PCM_Mode_Config_PCM_FORMAT_ = (0x6 << 3),
> +       MAX98927_PCM_Mode_Config_PCM_CHANSZ_Mask  = (0x3 << 6),
> +       MAX98927_PCM_Mode_Config_PCM_CHANSZ_16  = (0x1 << 6),
> +       MAX98927_PCM_Mode_Config_PCM_CHANSZ_24  = (0x2 << 6),
> +       MAX98927_PCM_Mode_Config_PCM_CHANSZ_32  = (0x3 << 6),
> +
> +       /* PCM Master Mode (Address 0x0021)*/
> +       MAX98927_PCM_Master_Mode  = 0x0021,
> +       MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_Mask  = (0x3 << 0),
> +       MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_SLAVE = (0x0 << 0),
> +       MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_MASTER = (0x3 << 0),
> +       MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_HYBRID = (0x1 << 0),
> +       MAX98927_PCM_Master_Mode_PCM_MCLK_RATE_Mask  = (0xf << 2),
> +       MAX98927_PCM_Master_Mode_PCM_CLK_SOURCE = (0x1 << 6),
> +
> +       /* PCM Clock setup (Address 0x0022)*/
> +       MAX98927_PCM_Clock_setup  = 0x0022,
> +       MAX98927_PCM_Clock_setup_PCM_BSEL_Mask  = (0xf << 0),
> +       MAX98927_PCM_Clock_setup_PCM_MSEL_Mask  = (0xf << 4),
> +
> +       /* PCM Sample rate setup 1 (Address 0x0023)*/
> +       MAX98927_PCM_Sample_rate_setup_1 = 0x0023,
> +       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_Mask  = (0xf << 0),
> +       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_8000  = (0x0 << 0),
> +       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_11025  = (0x1 << 0),
> +       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_12000  = (0x2 << 0),
> +       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_16000  = (0x3 << 0),
> +       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_22050  = (0x4 << 0),
> +       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_24000  = (0x5 << 0),
> +       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_32000  = (0x6 << 0),
> +       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_44100  = (0x7 << 0),
> +       MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_48000  = (0x8 << 0),
> +
> +       /* PCM Sample rate setup 1 (Address 0x0024)*/
> +       MAX98927_PCM_Sample_rate_setup_2 = 0x0024,
> +       MAX98927_PCM_Sample_rate_setup_2_IVADC_SR_Mask   = (0xf << 0),
> +       MAX98927_PCM_Sample_rate_setup_2_SPK_SR_Mask = (0xf << 4),
> +       MAX98927_PCM_Sample_rate_setup_2_SPK_SR_0001 = (0x0 << 4),
> +       MAX98927_PCM_Sample_rate_setup_2_SPK_SR_0011 = (0x2 << 4),
> +       MAX98927_PCM_Sample_rate_setup_2_SPK_SR_0101 = (0x4 << 4),
> +       MAX98927_PCM_Sample_rate_setup_2_SPK_SR_0111 = (0x6 << 4),
> +       MAX98927_PCM_Sample_rate_setup_2_SPK_SR_1001 = (0x8 << 4),
> +       MAX98927_PCM_Sample_rate_setup_2_SPK_SR_1011 = (0xa << 4),
> +       MAX98927_PCM_Sample_rate_setup_2_SPK_SR_1101 = (0xc << 4),
> +       MAX98927_PCM_Sample_rate_setup_2_SPK_SR_  = (0xf << 4),
> +
> +       /* PCM to speaker monomix A (Address 0x0025)*/
> +       MAX98927_PCM_to_speaker_monomix_A  = 0x0025,
> +       MAX98927_PCM_to_spkmonomix_A_DMONOMIX_CH0_SOURCE_Mask  = (0xf << 0),
> +       MAX98927_PCM_to_spkmonomix_A_DMONOMIX_CFG_Mask  = (0x3 << 6),
> +       MAX98927_PCM_to_spkmonomix_A_DMONOMIX_CFG_1 = (0x0 << 6),
> +       MAX98927_PCM_to_spkmonomix_A_DMONOMIX_CFG_3 = (0x0 << 6),
> +
> +       /* PCM to speaker monomix B (Address 0x0026)*/
> +       MAX98927_PCM_to_spkmonomix_B  = 0x0026,
> +       MAX98927_PCM_to_spkmonomix_B_DMONOMIX_CH1_SOURCE_Mask  = (0xf << 0),
> +
> +       /* ICC RX Enables A (Address 0x0027)*/
> +       MAX98927_ICC_RX_Enables_A = 0x0027,
> +       MAX98927_ICC_RX_Enables_A_ICC_RX_CH0_EN = (0x1 << 0),
> +       MAX98927_ICC_RX_Enables_A_ICC_RX_CH1_EN = (0x1 << 1),
> +       MAX98927_ICC_RX_Enables_A_ICC_RX_CH2_EN = (0x1 << 2),
> +       MAX98927_ICC_RX_Enables_A_ICC_RX_CH3_EN = (0x1 << 3),
> +       MAX98927_ICC_RX_Enables_A_ICC_RX_CH4_EN = (0x1 << 4),
> +       MAX98927_ICC_RX_Enables_A_ICC_RX_CH5_EN = (0x1 << 5),
> +       MAX98927_ICC_RX_Enables_A_ICC_RX_CH6_EN = (0x1 << 6),
> +       MAX98927_ICC_RX_Enables_A_ICC_RX_CH7_EN = (0x1 << 7),
> +
> +       /* ICC RX Enables B (Address 0x0028)*/
> +       MAX98927_ICC_RX_Enables_B = 0x0028,
> +       MAX98927_ICC_RX_Enables_B_ICC_RX_CH8_EN = (0x1 << 0),
> +       MAX98927_ICC_RX_Enables_B_ICC_RX_CH9_EN = (0x1 << 1),
> +       MAX98927_ICC_RX_Enables_B_ICC_RX_CH10_EN  = (0x1 << 2),
> +       MAX98927_ICC_RX_Enables_B_ICC_RX_CH11_EN  = (0x1 << 3),
> +       MAX98927_ICC_RX_Enables_B_ICC_RX_CH12_EN  = (0x1 << 4),
> +       MAX98927_ICC_RX_Enables_B_ICC_RX_CH13_EN  = (0x1 << 5),
> +       MAX98927_ICC_RX_Enables_B_ICC_RX_CH14_EN  = (0x1 << 6),
> +       MAX98927_ICC_RX_Enables_B_ICC_RX_CH15_EN  = (0x1 << 7),
> +
> +       /* ICC TX Enables A (Address 0x002b)*/
> +       MAX98927_ICC_TX_Enables_A = 0x002b,
> +       MAX98927_ICC_TX_Enables_A_ICC_TX_CH0_EN = (0x1 << 0),
> +       MAX98927_ICC_TX_Enables_A_ICC_TX_CH1_EN = (0x1 << 1),
> +       MAX98927_ICC_TX_Enables_A_ICC_TX_CH2_EN = (0x1 << 2),
> +       MAX98927_ICC_TX_Enables_A_ICC_TX_CH3_EN = (0x1 << 3),
> +       MAX98927_ICC_TX_Enables_A_ICC_TX_CH4_EN = (0x1 << 4),
> +       MAX98927_ICC_TX_Enables_A_ICC_TX_CH5_EN = (0x1 << 5),
> +       MAX98927_ICC_TX_Enables_A_ICC_TX_CH6_EN = (0x1 << 6),
> +       MAX98927_ICC_TX_Enables_A_ICC_TX_CH7_EN = (0x1 << 7),
> +
> +       /* ICC TX Enables B (Address 0x002c)*/
> +       MAX98927_ICC_TX_Enables_B = 0x002c,
> +       MAX98927_ICC_TX_Enables_B_ICC_TX_CH8_EN = (0x1 << 0),
> +       MAX98927_ICC_TX_Enables_B_ICC_TX_CH9_EN = (0x1 << 1),
> +       MAX98927_ICC_TX_Enables_B_ICC_TX_CH10_EN  = (0x1 << 2),
> +       MAX98927_ICC_TX_Enables_B_ICC_TX_CH11_EN  = (0x1 << 3),
> +       MAX98927_ICC_TX_Enables_B_ICC_TX_CH12_EN  = (0x1 << 4),
> +       MAX98927_ICC_TX_Enables_B_ICC_TX_CH13_EN  = (0x1 << 5),
> +       MAX98927_ICC_TX_Enables_B_ICC_TX_CH14_EN  = (0x1 << 6),
> +       MAX98927_ICC_TX_Enables_B_ICC_TX_CH15_EN  = (0x1 << 7),
> +
> +       /* ICC Data Order Select (Address 0x002d)*/
> +       MAX98927_ICC_Data_Order_Select = 0x002d,
> +       MAX98927_ICC_Data_Order_Select_ICC_DRIVE_MODE = (0x1 << 3),
> +
> +       /* ICC HiZ Manual Mode (Address 0x002e)*/
> +       MAX98927_ICC_HiZ_Manual_Mode  = 0x002e,
> +       MAX98927_ICC_HiZ_Manual_Mode_ICC_TX_HIZ_MANUAL   = (0x1 << 0),
> +       MAX98927_ICC_HiZ_Manual_Mode_ICC_TX_EXTRA_HIZ = (0x1 << 1),
> +
> +       /* ICC TX HiZ Enables A (Address 0x002f)*/
> +       MAX98927_ICC_TX_HiZ_Enables_A = 0x002f,
> +       MAX98927_ICC_TX_HiZ_Enables_A_ICC_TX_CH0_HIZ = (0x1 << 0),
> +       MAX98927_ICC_TX_HiZ_Enables_A_ICC_TX_CH1_HIZ = (0x1 << 1),
> +       MAX98927_ICC_TX_HiZ_Enables_A_ICC_TX_CH2_HIZ = (0x1 << 2),
> +       MAX98927_ICC_TX_HiZ_Enables_A_ICC_TX_CH3_HIZ = (0x1 << 3),
> +       MAX98927_ICC_TX_HiZ_Enables_A_ICC_TX_CH4_HIZ = (0x1 << 4),
> +       MAX98927_ICC_TX_HiZ_Enables_A_ICC_TX_CH5_HIZ = (0x1 << 5),
> +       MAX98927_ICC_TX_HiZ_Enables_A_ICC_TX_CH6_HIZ = (0x1 << 6),
> +       MAX98927_ICC_TX_HiZ_Enables_A_ICC_TX_CH7_HIZ = (0x1 << 7),
> +
> +       /* ICC TX HiZ Enables B (Address 0x0030)*/
> +       MAX98927_ICC_TX_HiZ_Enables_B = 0x0030,
> +       MAX98927_ICC_TX_HiZ_Enables_B_ICC_TX_CH8_HIZ = (0x1 << 0),
> +       MAX98927_ICC_TX_HiZ_Enables_B_ICC_TX_CH9_HIZ = (0x1 << 1),
> +       MAX98927_ICC_TX_HiZ_Enables_B_ICC_TX_CH10_HIZ = (0x1 << 2),
> +       MAX98927_ICC_TX_HiZ_Enables_B_ICC_TX_CH11_HIZ = (0x1 << 3),
> +       MAX98927_ICC_TX_HiZ_Enables_B_ICC_TX_CH12_HIZ = (0x1 << 4),
> +       MAX98927_ICC_TX_HiZ_Enables_B_ICC_TX_CH13_HIZ = (0x1 << 5),
> +       MAX98927_ICC_TX_HiZ_Enables_B_ICC_TX_CH14_HIZ = (0x1 << 6),
> +       MAX98927_ICC_TX_HiZ_Enables_B_ICC_TX_CH15_HIZ = (0x1 << 7),
> +
> +       /* ICC Link Enables (Address 0x0031)*/
> +       MAX98927_ICC_Link_Enables = 0x0031,
> +       MAX98927_ICC_Link_Enables_ICC_LINK_EN = (0x1 << 1),
> +
> +       /* PDM Tx Enables (Address 0x0032)*/
> +       MAX98927_PDM_Tx_Enables   = 0x0032,
> +       MAX98927_PDM_Tx_Enables_PDM_TX_EN  = (0x1 << 0),
> +       MAX98927_PDM_Tx_Enables_PDM_TX_CLK_DIV2 = (0x1 << 1),
> +
> +       /* PDM Tx HiZ Control (Address 0x0033)*/
> +       MAX98927_PDM_Tx_HiZ_Control = 0x0033,
> +       MAX98927_PDM_Tx_HiZ_Control_PDM_TX_HIZ  = (0x1 << 0),
> +
> +       /* PDM Tx Control (Address 0x0034)*/
> +       MAX98927_PDM_Tx_Control   = 0x0034,
> +       MAX98927_PDM_Tx_Control_PDM_TX_CH0_SOURCE = (0x1 << 0),
> +       MAX98927_PDM_Tx_Control_PDM_TX_CH1_SOURCE = (0x1 << 1),
> +
> +       /* PDM Rx Enable (Address 0x0034)*/
> +       MAX98927_PDM_Rx_Enable = 0x0035,
> +       MAX98927_PDM_Rx_Enable_PDM_RX_EN = (0x1 << 0),
> +       MAX98927_PDM_Rx_Enable_PDM_DSP_EN  = (0x1 << 1),
> +       MAX98927_PDM_Rx_Enable_PDM_DITH_EN = (0x1 << 2),
> +       MAX98927_PDM_Rx_Enable_PDM_RX_CH_SEL = (0x1 << 3),
> +       MAX98927_PDM_Rx_Enable_PDM_FIFO_RDY_LVL_Mask = (0xf << 4),
> +
> +       /* AMP volume control (Address 0x0036)*/
> +       MAX98927_AMP_volume_control = 0x0036,
> +       MAX98927_AMP_volume_control_AMP_VOL_Mask  = (0x7f << 0),
> +       MAX98927_AMP_volume_control_AMP_VOL_SEL = (0x1 << 7),
> +
> +       /* AMP DSP Config (Address 0x0037)*/
> +       MAX98927_AMP_DSP_Config   = 0x0037,
> +       MAX98927_AMP_DSP_Config_AMP_DCBLK_EN = (0x1 << 0),
> +       MAX98927_AMP_DSP_Config_AMP_DITH_EN  = (0x1 << 1),
> +       MAX98927_AMP_DSP_Config_DAC_HALF_REF_CURRENT = (0x1 << 2),
> +       MAX98927_AMP_DSP_Config_DAC_DOUBLE_RFB  = (0x1 << 3),
> +       MAX98927_AMP_DSP_Config_AMP_VOL_RMP_BYPASS = (0x1 << 4),
> +       MAX98927_AMP_DSP_Config_DAC_INVERT = (0x1 << 5),
> +
> +       /* Tone Generator and DC Config (Address 0x0038)*/
> +       MAX98927_Tone_Generator_and_DC_Config = 0x0038,
> +       MAX98927_Tone_Generator_and_DC_Config_TONE_CONFIG_Mask  = (0xf << 0),
> +
> +       /* DRE Control (Address 0x0039)*/
> +       MAX98927_DRE_Control  = 0x0039,
> +       MAX98927_DRE_Control_DRE_EN = (0x1 << 0),
> +
> +       /* AMP enables (Address 0x003a)*/
> +       MAX98927_AMP_enables  = 0x003a,
> +       MAX98927_AMP_enables_SPK_EN = (0x1 << 0),
> +
> +       /* Speaker source select (Address 0x003b)*/
> +       MAX98927_Speaker_source_select = 0x003b,
> +       MAX98927_Speaker_source_select_SPK_SOURCE_Mask   = (0x3 << 0),
> +       MAX98927_Speaker_source_select_SPK_SOURCE_01 = (0x0 << 0),
> +       MAX98927_Speaker_source_select_SPK_SOURCE_11 = (0x2 << 0),
> +
> +       /* Speaker Gain (Address 0x003c)*/
> +       MAX98927_Speaker_Gain = 0x003c,
> +       MAX98927_Speaker_Gain_SPK_PCM_GAIN_Mask = (0x7 << 0),
> +       MAX98927_Speaker_Gain_SPK_PCM_GAIN_001  = (0x0 << 0),
> +       MAX98927_Speaker_Gain_SPK_PCM_GAIN_011  = (0x2 << 0),
> +       MAX98927_Speaker_Gain_SPK_PCM_GAIN_101  = (0x4 << 0),
> +       MAX98927_Speaker_Gain_SPK_PCM_GAIN_111  = (0x6 << 0),
> +       MAX98927_Speaker_Gain_SPK_PDM_GAIN_Mask = (0x7 << 4),
> +       MAX98927_Speaker_Gain_SPK_PDM_GAIN_001  = (0x0 << 4),
> +       MAX98927_Speaker_Gain_SPK_PDM_GAIN_011  = (0x2 << 4),
> +       MAX98927_Speaker_Gain_SPK_PDM_GAIN_101  = (0x4 << 4),
> +       MAX98927_Speaker_Gain_SPK_PDM_GAIN_111  = (0x6 << 4),
> +
> +       /* SSM Configuration (Address 0x003d)*/
> +       MAX98927_SSM_Configuration  = 0x003d,
> +       MAX98927_SSM_Configuration_SSM_MOD_INDEX_Mask = (0x7 << 0),
> +       MAX98927_SSM_Configuration_SSM_MOD_INDEX_001 = (0x0 << 0),
> +       MAX98927_SSM_Configuration_SSM_MOD_INDEX_011 = (0x2 << 0),
> +       MAX98927_SSM_Configuration_SSM_MOD_INDEX_101 = (0x4 << 0),
> +       MAX98927_SSM_Configuration_SSM_MOD_INDEX_ = (0x6 << 0),
> +       MAX98927_SSM_Configuration_SPK_FSW_SEL  = (0x1 << 3),
> +       MAX98927_SSM_Configuration_SSM_ENA = (0x1 << 7),
> +
> +       /* Measurement enables (Address 0x003e)*/
> +       MAX98927_Measurement_enables  = 0x003e,
> +       MAX98927_Measurement_enables_IVADC_V_EN = (0x1 << 0),
> +       MAX98927_Measurement_enables_IVADC_I_EN = (0x1 << 1),
> +
> +       /* Measurement DSP Config (Address 0x003f)*/
> +       MAX98927_Measurement_DSP_Config  = 0x003f,
> +       MAX98927_Measurement_DSP_Config_MEAS_V_DCBLK_EN  = (0x1 << 0),
> +       MAX98927_Measurement_DSP_Config_MEAS_I_DCBLK_EN  = (0x1 << 1),
> +       MAX98927_Measurement_DSP_Config_MEAS_DITH_EN = (0x1 << 2),
> +       MAX98927_Measurement_DSP_Config_MEAS_V_DCBLK_Mask  = (0x3 << 4),
> +       MAX98927_Measurement_DSP_Config_MEAS_V_DCBLK_01  = (0x0 << 4),
> +       MAX98927_Measurement_DSP_Config_MEAS_V_DCBLK_11  = (0x2 << 4),
> +       MAX98927_Measurement_DSP_Config_MEAS_I_DCBLK_Mask  = (0x3 << 6),
> +       MAX98927_Measurement_DSP_Config_MEAS_I_DCBLK_01  = (0x0 << 6),
> +       MAX98927_Measurement_DSP_Config_MEAS_I_DCBLK_11  = (0x2 << 6),
> +
> +       /* Boost Control 0 (Address 0x0040)*/
> +       MAX98927_Boost_Control_0  = 0x0040,
> +       MAX98927_Boost_Control_0_BST_VOUT_Mask  = (0x1f << 0),
> +       MAX98927_Boost_Control_0_EXT_PVDD_EN = (0x1 << 7),
> +
> +       /* Boost Control 3 (Address 0x0041)*/
> +       MAX98927_Boost_Control_3  = 0x0041,
> +       MAX98927_Boost_Control_3_BST_SKIPLOAD_Mask = (0x3 << 0),
> +       MAX98927_Boost_Control_3_BST_SKIPLOAD_01  = (0x0 << 0),
> +       MAX98927_Boost_Control_3_BST_SKIPLOAD_11  = (0x2 << 0),
> +       MAX98927_Boost_Control_3_BST_PHASE_Mask = (0x7 << 2),
> +       MAX98927_Boost_Control_3_BST_PHASE_001  = (0x0 << 2),
> +       MAX98927_Boost_Control_3_BST_PHASE_011  = (0x2 << 2),
> +       MAX98927_Boost_Control_3_BST_PHASE_  = (0x1 << 2),
> +       MAX98927_Boost_Control_3_BST_SLOWSTART  = (0x1 << 5),
> +
> +       /* Boost Control 1 (Address 0x0042)*/
> +       MAX98927_Boost_Control_1  = 0x0042,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Boost_Control_1_BST_ILIM_Mask  = (0x3f << 0),
> +
> +       /* Meas ADC Config (Address 0x0043)*/
> +       MAX98927_Meas_ADC_Config  = 0x0043,
> +       MAX98927_Meas_ADC_Config_MEAS_ADC_CH0_EN  = (0x1 << 0),
> +       MAX98927_Meas_ADC_Config_MEAS_ADC_CH1_EN  = (0x1 << 1),
> +       MAX98927_Meas_ADC_Config_MEAS_ADC_CH2_EN  = (0x1 << 2),
> +
> +       /* Meas ADC Base Divide MSByte (Address 0x0044)*/
> +       MAX98927_Meas_ADC_Base_Divide_MSByte = 0x0044,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Meas_ADC_Base_Divide_MSByte_MEAS_ADC_BASE_DIV_Mask
> +               = (0xff << 0),
> +
> +       /* Meas ADC Base Divide LSByte (Address 0x0045)*/
> +       MAX98927_Meas_ADC_Base_Divide_LSByte = 0x0045,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Meas_ADC_Base_Divide_LSByte_MEAS_ADC_BASE_DIV_Mask
> +               = (0xff << 0),
> +
> +       /* Meas ADC Chan 0 Divide (Address 0x0046)*/
> +       MAX98927_Meas_ADC_Chan_0_Divide  = 0x0046,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Meas_ADC_Chan_0_Divide_MEAS_ADC_CH0_DIV_Mask = (0xff << 0),
> +
> +       /* Meas ADC Chan 1 Divide (Address 0x0047)*/
> +       MAX98927_Meas_ADC_Chan_1_Divide  = 0x0047,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Meas_ADC_Chan_1_Divide_MEAS_ADC_CH1_DIV_Mask = (0xff << 0),
> +
> +       /* Meas ADC Chan 2 Divide (Address 0x0048)*/
> +       MAX98927_Meas_ADC_Chan_2_Divide  = 0x0048,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Meas_ADC_Chan_2_Divide_MEAS_ADC_CH2_DIV_Mask = (0xff << 0),
> +
> +       /* Meas ADC Chan 0 Filt Config (Address 0x0049)*/
> +       MAX98927_Meas_ADC_Chan_0_Filt_Config = 0x0049,
> +       MAX98927_Meas_ADC_Chan_0_Filt_Config_MEAS_ADC_CH0_FILT_AVG_Mask
> +               = (0x7 << 0),
> +       MAX98927_Meas_ADC_Chan_0_Filt_Config_MEAS_ADC_CH0_FILT_AVG_001
> +               = (0x0 << 0),
> +       MAX98927_Meas_ADC_Chan_0_Filt_Config_MEAS_ADC_CH0_FILT_AVG_011
> +               = (0x2 << 0),
> +       MAX98927_Meas_ADC_Chan_0_Filt_Config_MEAS_ADC_CH0_FILT_AVG_101
> +               = (0x4 << 0),
> +       MAX98927_Meas_ADC_Chan_0_Filt_Config_MEAS_ADC_CH0_FILT_EN
> +               = (0x1 << 3),
> +
> +       /* Meas ADC Chan 1 Filt Config (Address 0x004a)*/
> +       MAX98927_Meas_ADC_Chan_1_Filt_Config = 0x004a,
> +       MAX98927_Meas_ADC_Chan_1_Filt_Config_MEAS_ADC_CH1_FILT_AVG_Mask
> +               = (0x7 << 0),
> +       MAX98927_Meas_ADC_Chan_1_Filt_Config_MEAS_ADC_CH1_FILT_AVG_001
> +               = (0x0 << 0),
> +       MAX98927_Meas_ADC_Chan_1_Filt_Config_MEAS_ADC_CH1_FILT_AVG_011
> +               = (0x2 << 0),
> +       MAX98927_Meas_ADC_Chan_1_Filt_Config_MEAS_ADC_CH1_FILT_AVG_101
> +               = (0x4 << 0),
> +       MAX98927_Meas_ADC_Chan_1_Filt_Config_MEAS_ADC_CH1_FILT_EN
> +               = (0x1 << 3),
> +
> +       /* Meas ADC Chan 2 Filt Config (Address 0x004b)*/
> +       MAX98927_Meas_ADC_Chan_2_Filt_Config = 0x004b,
> +       MAX98927_Meas_ADC_Chan_2_Filt_Config_MEAS_ADC_CH2_FILT_AVG_Mask
> +               = (0x7 << 0),
> +       MAX98927_Meas_ADC_Chan_2_Filt_Config_MEAS_ADC_CH2_FILT_AVG_001
> +               = (0x0 << 0),
> +       MAX98927_Meas_ADC_Chan_2_Filt_Config_MEAS_ADC_CH2_FILT_AVG_011
> +               = (0x2 << 0),
> +       MAX98927_Meas_ADC_Chan_2_Filt_Config_MEAS_ADC_CH2_FILT_AVG_101
> +               = (0x4 << 0),
> +       MAX98927_Meas_ADC_Chan_2_Filt_Config_MEAS_ADC_CH2_FILT_EN
> +               = (0x1 << 3),
> +
> +       /* Meas ADC Chan 0 Readback (Address 0x004c)*/
> +       MAX98927_Meas_ADC_Chan_0_Readback  = 0x004c,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Meas_ADC_Chan_0_Readback_MEAS_ADC_CH0_DATA_Mask
> +               = (0xff << 0),
> +
> +       /* Meas ADC Chan 1 Readback (Address 0x004d)*/
> +       MAX98927_Meas_ADC_Chan_1_Readback  = 0x004d,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Meas_ADC_Chan_1_Readback_MEAS_ADC_CH1_DATA_Mask
> +               = (0xff << 0),
> +
> +       /* Meas ADC Chan 2 Readback (Address 0x004e)*/
> +       MAX98927_Meas_ADC_Chan_2_Readback  = 0x004e,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Meas_ADC_Chan_2_Readback_MEAS_ADC_CH2_DATA_Mask
> +               = (0xff << 0),
> +
> +       /* Brownout status (Address 0x0051)*/
> +       MAX98927_Brownout_status  = 0x0051,
> +       MAX98927_Brownout_status_BDE_STATE_Mask = (0xf << 0),
> +
> +       /* Brownout enables (Address 0x0052)*/
> +       MAX98927_Brownout_enables = 0x0052,
> +       MAX98927_Brownout_enables_BDE_EN = (0x1 << 0),
> +       MAX98927_Brownout_enables_BDE_AMP_EN = (0x1 << 1),
> +       MAX98927_Brownout_enables_AMP_DSP_EN = (0x1 << 2),
> +
> +       /* Brownout level infinite hold (Address 0x0053)*/
> +       MAX98927_Brownout_level_infinite_hold = 0x0053,
> +       MAX98927_Brownout_level_infinite_hold_BDE_L8_INF_HLD = (0x1 << 1),
> +
> +       /* Brownout level infinite hold clear (Address 0x0054)*/
> +       MAX98927_Brownout_level_infinite_hold_clear  = 0x0054,
> +       MAX98927_Brownout_level_infinite_hold_clear_BDE_L8_HLD_RLS
> +               = (0x1 << 1),
> +
> +       /* Brownout level hold (Address 0x0055)*/
> +       MAX98927_Brownout_level_hold  = 0x0055,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout_level_hold_BDE_HLD_Mask = (0xff << 0),
> +
> +       /* Brownout  level 1 threshold (Address 0x0056)*/
> +       MAX98927_Brownout__level_1_threshold = 0x0056,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_1_threshold_BDE_L1_VTHRESH_Mask  = (0xff << 0),
> +
> +       /* Brownout  level 2 threshold (Address 0x0057)*/
> +       MAX98927_Brownout__level_2_threshold = 0x0057,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_2_threshold_BDE_L2_VTHRESH_Mask  = (0xff << 0),
> +
> +       /* Brownout  level 3 threshold (Address 0x0058)*/
> +       MAX98927_Brownout__level_3_threshold = 0x0058,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_3_threshold_BDE_L3_VTHRESH_Mask  = (0xff << 0),
> +
> +       /* Brownout  level 4 threshold (Address 0x0059)*/
> +       MAX98927_Brownout__level_4_threshold = 0x0059,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_4_threshold_BDE_L4_VTHRESH_Mask  = (0xff << 0),
> +
> +       /* Brownout  level 5 threshold (Address 0x005a)*/
> +       MAX98927_Brownout__level_5_threshold = 0x005a,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_5_threshold_BDE_L5_VTHRESH_Mask  = (0xff << 0),
> +
> +       /* Brownout  level 6 threshold (Address 0x005b)*/
> +       MAX98927_Brownout__level_6_threshold = 0x005b,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_6_threshold_BDE_L6_VTHRESH_Mask  = (0xff << 0),
> +
> +       /* Brownout  level 7 threshold (Address 0x005c)*/
> +       MAX98927_Brownout__level_7_threshold = 0x005c,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_7_threshold_BDE_L7_VTHRESH_Mask  = (0xff << 0),
> +
> +       /* Brownout  level 8 threshold (Address 0x005d)*/
> +       MAX98927_Brownout__level_8_threshold = 0x005d,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_8_threshold_BDE_L8_VTHRESH_Mask  = (0xff << 0),
> +
> +       /* Brownout threshold hysterysis (Address 0x005e)*/
> +       MAX98927_Brownout_threshold_hysterysis  = 0x005e,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout_threshold_hysterysis_BDE_VTHRESH_HYST_Mask
> +               = (0xff << 0),
> +       /* Brownout AMP limiter attack/release (Address 0x005f)*/
> +       MAX98927_Brownout_AMP_limiter_attack_release = 0x005f,
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_Mask
> +               = (0xf << 0),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_0001
> +               = (0x0 << 0),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_0011
> +               = (0x2 << 0),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_0101
> +               = (0x4 << 0),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_0111
> +               = (0x6 << 0),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_1001
> +               = (0x8 << 0),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_1011
> +               = (0xa << 0),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_1101
> +               = (0xc << 0),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_1111
> +               = (0xe << 0),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_Mask
> +               = (0xf << 4),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_0001
> +               = (0x0 << 4),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_0011
> +               = (0x2 << 4),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_0101
> +               = (0x4 << 4),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_0111
> +               = (0x6 << 4),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_1001
> +               = (0x8 << 4),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_1011
> +               = (0xa << 4),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_1101
> +               = (0xc << 4),
> +       MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_1111
> +               = (0xe << 4),
> +
> +       /* Brownout AMP gain attack/release (Address 0x0060)*/
> +       MAX98927_Brownout_AMP_gain_attack_release = 0x0060,
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_Mask
> +               = (0xf << 0),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_0001
> +               = (0x0 << 0),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_0011
> +               = (0x2 << 0),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_0101
> +               = (0x4 << 0),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_0111
> +               = (0x6 << 0),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_1001
> +               = (0x8 << 0),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_1011
> +               = (0xa << 0),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_1101
> +               = (0xc << 0),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_1111
> +               = (0xe << 0),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_Mask
> +               = (0xf << 4),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_0001
> +               = (0x0 << 4),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_0011
> +               = (0x2 << 4),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_0101
> +               = (0x4 << 4),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_0111
> +               = (0x6 << 4),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_1001
> +               = (0x8 << 4),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_1011
> +               = (0xa << 4),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_1101
> +               = (0xc << 4),
> +       MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_1111
> +               = (0xe << 4),
> +
> +       /* Brownout AMP1 clip mode (Address 0x0061)*/
> +       MAX98927_Brownout_AMP1_clip_mode = 0x0061,
> +       MAX98927_Brownout_AMP1_clip_mode_AMP_CLIP_MODE   = (0x1 << 0),
> +
> +       /* Brownout  level 1 current limit (Address 0x0062)*/
> +       MAX98927_Brownout__level_1_current_limit  = 0x0062,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_1_current_limit_BDE_L1_ILIM_Mask
> +               = (0x3f << 0),
> +
> +       /* Brownout  level 1 amp 1 control 1 (Address 0x0063)*/
> +       MAX98927_Brownout__level_1_amp_1_control_1 = 0x0063,
> +       MAX98927_Brownout__level_1_amp_1_control_1_BDE_L1_AMP1_LIM_Mask
> +               = (0xf << 0),
> +
> +       /* Brownout  level 1 amp 1 control 2 (Address 0x0064)*/
> +       MAX98927_Brownout__level_1_amp_1_control_2 = 0x0064,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_1_amp_1_control_2_BDE_L1_AMP1_CLIP_Mask
> +               = (0x3f << 0),
> +
> +       /* Brownout  level 1 amp 1 control 3 (Address 0x0065)*/
> +       MAX98927_Brownout__level_1_amp_1_control_3 = 0x0065,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_1_amp_1_control_3_BDE_L1_AMP1_GAIN_Mask
> +               = (0x3f << 0),
> +
> +       /* Brownout  level 2 current limit (Address 0x0066)*/
> +       MAX98927_Brownout__level_2_current_limit  = 0x0066,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_2_current_limit_BDE_L2_ILIM_Mask = (0x3f << 0),
> +
> +       /* Brownout  level 2 amp 1 control 1 (Address 0x0067)*/
> +       MAX98927_Brownout__level_2_amp_1_control_1 = 0x0067,
> +       MAX98927_Brownout__level_2_amp_1_control_1_BDE_L2_AMP1_LIM_Mask
> +               = (0xf << 0),
> +
> +       /* Brownout  level 2 amp 1 control 2 (Address 0x0068)*/
> +       MAX98927_Brownout__level_2_amp_1_control_2 = 0x0068,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_2_amp_1_control_2_BDE_L2_AMP1_CLIP_Mask
> +               = (0x3f << 0),
> +
> +       /* Brownout  level 2 amp 1 control 3 (Address 0x0069)*/
> +       MAX98927_Brownout__level_2_amp_1_control_3 = 0x0069,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_2_amp_1_control_3_BDE_L2_AMP1_GAIN_Mask
> +               = (0x3f << 0),
> +
> +       /* Brownout  level 3 current limit (Address 0x006a)*/
> +       MAX98927_Brownout__level_3_current_limit  = 0x006a,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_3_current_limit_BDE_L3_ILIM_Mask = (0x3f << 0),
> +
> +       /* Brownout  level 3 amp 1 control 1 (Address 0x006b)*/
> +       MAX98927_Brownout__level_3_amp_1_control_1 = 0x006b,
> +       MAX98927_Brownout__level_3_amp_1_control_1_BDE_L3_AMP1_LIM_Mask
> +               = (0xf << 0),
> +
> +       /* Brownout  level 3 amp 1 control 2 (Address 0x006c)*/
> +       MAX98927_Brownout__level_3_amp_1_control_2 = 0x006c,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_3_amp_1_control_2_BDE_L3_AMP1_CLIP_Mask
> +               = (0x3f << 0),
> +
> +       /* Brownout  level 3 amp 1 control 3 (Address 0x006d)*/
> +       MAX98927_Brownout__level_3_amp_1_control_3 = 0x006d,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_3_amp_1_control_3_BDE_L3_AMP1_GAIN_Mask
> +               = (0x3f << 0),
> +
> +       /* Brownout  level 4 current limit (Address 0x006e)*/
> +       MAX98927_Brownout__level_4_current_limit  = 0x006e,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_4_current_limit_BDE_L4_ILIM_Mask = (0x3f << 0),
> +
> +       /* Brownout  level 4 amp 1 control 1 (Address 0x006f)*/
> +       MAX98927_Brownout__level_4_amp_1_control_1 = 0x006f,
> +       MAX98927_Brownout__level_4_amp_1_control_1_BDE_L4_AMP1_LIM_Mask
> +               = (0xf << 0),
> +
> +       /* Brownout  level 4 amp 1 control 2 (Address 0x0070)*/
> +       MAX98927_Brownout__level_4_amp_1_control_2 = 0x0070,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_4_amp_1_control_2_BDE_L4_AMP1_CLIP_Mask
> +               = (0x3f << 0),
> +
> +       /* Brownout  level 4 amp 1 control 3 (Address 0x0071)*/
> +       MAX98927_Brownout__level_4_amp_1_control_3 = 0x0071,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_4_amp_1_control_3_BDE_L4_AMP1_GAIN_Mask
> +               = (0x3f << 0),
> +
> +       /* Brownout  level 5 current limit (Address 0x0072)*/
> +       MAX98927_Brownout__level_5_current_limit  = 0x0072,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_5_current_limit_BDE_L5_ILIM_Mask = (0x3f << 0),
> +
> +       /* Brownout  level 5 amp 1 control 1 (Address 0x0073)*/
> +       MAX98927_Brownout__level_5_amp_1_control_1 = 0x0073,
> +       MAX98927_Brownout__level_5_amp_1_control_1_BDE_L5_AMP1_LIM_Mask
> +               = (0xf << 0),
> +
> +       /* Brownout  level 5 amp 1 control 2 (Address 0x0074)*/
> +       MAX98927_Brownout__level_5_amp_1_control_2 = 0x0074,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_5_amp_1_control_2_BDE_L5_AMP1_CLIP_Mask
> +               = (0x3f << 0),
> +
> +       /* Brownout  level 5 amp 1 control 3 (Address 0x0075)*/
> +       MAX98927_Brownout__level_5_amp_1_control_3 = 0x0075,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_5_amp_1_control_3_BDE_L5_AMP1_GAIN_Mask
> +               = (0x3f << 0),
> +
> +       /* Brownout  level 6 current limit (Address 0x0076)*/
> +       MAX98927_Brownout__level_6_current_limit  = 0x0076,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_6_current_limit_BDE_L6_ILIM_Mask = (0x3f << 0),
> +
> +       /* Brownout  level 6 amp 1 control 1 (Address 0x0077)*/
> +       MAX98927_Brownout__level_6_amp_1_control_1 = 0x0077,
> +       MAX98927_Brownout__level_6_amp_1_control_1_BDE_L6_AMP1_LIM_Mask
> +               = (0xf << 0),
> +
> +       /* Brownout  level 6 amp 1 control 2 (Address 0x0078)*/
> +       MAX98927_Brownout__level_6_amp_1_control_2 = 0x0078,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_6_amp_1_control_2_BDE_L6_AMP1_CLIP_Mask
> +               = (0x3f << 0),
> +
> +       /* Brownout  level 6 amp 1 control 3 (Address 0x0079)*/
> +       MAX98927_Brownout__level_6_amp_1_control_3 = 0x0079,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_6_amp_1_control_3_BDE_L6_AMP1_GAIN_Mask
> +               = (0x3f << 0),
> +
> +       /* Brownout  level 7 current limit (Address 0x007a)*/
> +       MAX98927_Brownout__level_7_current_limit  = 0x007a,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_7_current_limit_BDE_L7_ILIM_Mask = (0x3f << 0),
> +
> +       /* Brownout  level 7 amp 1 control 1 (Address 0x007b)*/
> +       MAX98927_Brownout__level_7_amp_1_control_1 = 0x007b,
> +       MAX98927_Brownout__level_7_amp_1_control_1_BDE_L7_AMP1_LIM_Mask
> +               = (0xf << 0),
> +
> +       /* Brownout  level 7 amp 1 control 2 (Address 0x007c)*/
> +       MAX98927_Brownout__level_7_amp_1_control_2 = 0x007c,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_7_amp_1_control_2_BDE_L7_AMP1_CLIP_Mask
> +               = (0x3f << 0),
> +
> +       /* Brownout  level 7 amp 1 control 3 (Address 0x007d)*/
> +       MAX98927_Brownout__level_7_amp_1_control_3 = 0x007d,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_7_amp_1_control_3_BDE_L7_AMP1_GAIN_Mask
> +               = (0x3f << 0),
> +
> +       /* Brownout  level 8 current limit (Address 0x007e)*/
> +       MAX98927_Brownout__level_8_current_limit  = 0x007e,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_8_current_limit_BDE_L8_ILIM_Mask = (0x3f << 0),
> +
> +       /* Brownout  level 8 amp 1 control 1 (Address 0x007f)*/
> +       MAX98927_Brownout__level_8_amp_1_control_1 = 0x007f,
> +       MAX98927_Brownout__level_8_amp_1_control_1_BDE_L8_AMP1_LIM_Mask
> +               = (0xf << 0),
> +
> +       /* Brownout  level 8 amp 1 control 2 (Address 0x0080)*/
> +       MAX98927_Brownout__lvl_8_amp_1_control_2 = 0x0080,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__lvl_8_amp_1_control_2_BDE_L8_AMP1_CLIP_Mask
> +               = (0x3f << 0),
> +       MAX98927_Brownout__lvl_8_amp_1_control_2_BDE_L8_AMP1_MUTE
> +               = (0x1 << 7),
> +
> +       /* Brownout  level 8 amp 1 control 3 (Address 0x0081)*/
> +       MAX98927_Brownout__level_8_amp_1_control_3 = 0x0081,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Brownout__level_8_amp_1_control_3_BDE_L8_AMP1_GAIN_Mask
> +               = (0x3f << 0),
> +
> +       /* Env Tracker Vout Headroom (Address 0x0082)*/
> +       MAX98927_Env_Tracker_Vout_Headroom = 0x0082,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Env_Tracker_Vout_Head_ENV_TRACKER_BST_VOUT_HEADROOM_Mask
> +               = (0x1f << 0),
> +
> +       /* Env Tracker Boost Vout Delay (Address 0x0083)*/
> +       MAX98927_Env_Tracker_Boost_Vout_Delay = 0x0083,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Env_Tracker_Boost_V_Delay_ENV_TRACKER_BST_VOUT_DELAY_Mask
> +               = (0x1f << 0),
> +       MAX98927_Env_Tracker_Boost_Vout_Delay_ENV_TRACKER_BDE_MODE
> +               = (0x1 << 7),
> +
> +       /* Env Tracker Release Rate (Address 0x0084)*/
> +       MAX98927_Env_Tracker_Release_Rate  = 0x0084,
> +       MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_RLS_RATE_Mask
> +               = (0x7 << 0),
> +       MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_RLS_RATE_001
> +               = (0x0 << 0),
> +       MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_RLS_RATE_011
> +               = (0x2 << 0),
> +       MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_RLS_RATE_101
> +               = (0x4 << 0),
> +       MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_RLS_RATE_111
> +               = (0x6 << 0),
> +       MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_PEAK_DET_LPF_BYP_EN
> +               = (0x1 << 3),
> +       MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_RLS_RATE_SCALE_Mask
> +               = (0x3 << 4),
> +       MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_RLS_RATE_SCALE_01
> +               = (0x0 << 4),
> +       MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_RLS_RATE_SCALE_11
> +               = (0x2 << 4),
> +
> +       /* Env Tracker Hold Rate (Address 0x0085)*/
> +       MAX98927_Env_Tracker_Hold_Rate = 0x0085,
> +       MAX98927_Env_Tracker_Hold_Rate_ENV_TRACKER_HOLD_RATE_Mask
> +               = (0x7 << 0),
> +       MAX98927_Env_Tracker_Hold_Rate_ENV_TRACKER_HOLD_RATE_001
> +               = (0x0 << 0),
> +       MAX98927_Env_Tracker_Hold_Rate_ENV_TRACKER_HOLD_RATE_011
> +               = (0x2 << 0),
> +       MAX98927_Env_Tracker_Hold_Rate_ENV_TRACKER_HOLD_RATE_101
> +               = (0x4 << 0),
> +       MAX98927_Env_Tracker_Hold_Rate_ENV_TRACKER_HOLD_RATE_111
> +               = (0x6 << 0),
> +
> +       /* Env Tracker Control (Address 0x0086)*/
> +       MAX98927_Env_Tracker_Control  = 0x0086,
> +       MAX98927_Env_Tracker_Control_ENV_TRACKER_EN  = (0x1 << 0),
> +
> +       /* Env Tracker  Boost Vout ReadBack (Address 0x0087)*/
> +       MAX98927_Env_Tracker__Boost_Vout_ReadBack = 0x0087,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Env_Tracker__Boost_Vout_RB_ENV_TRACKER_BST_VOUT_RD_Mask
> +               = (0x1f << 0),
> +
> +       /* Advanced Settings (Address 0x0089)*/
> +       MAX98927_Advanced_Settings  = 0x0089,
> +       MAX98927_Advanced_Settings_DAC_HALF_FIR = (0x1 << 0),
> +       MAX98927_Advanced_Settings_PDM_MOD_SEL  = (0x1 << 1),
> +       MAX98927_Advanced_Settings_ISOCH_EN  = (0x1 << 2),
> +
> +       /* DAC Test 1 (Address 0x009f)*/
> +       MAX98927_DAC_Test_1 = 0x009f,
> +       MAX98927_DAC_Test_1_DAC_PCM_TIMING = (0x1 << 0),
> +       MAX98927_DAC_Test_1_DAC_HALFI_AMP  = (0x1 << 1),
> +       MAX98927_DAC_Test_1_DAC_LONG_HOLD  = (0x1 << 3),
> +       MAX98927_DAC_Test_1_DAC_DISABLE_CHOP = (0x1 << 4),
> +       MAX98927_DAC_Test_1_DAC_TM  = (0x1 << 5),
> +       MAX98927_DAC_Test_1_DAC_INVERT_DACCLK = (0x1 << 6),
> +
> +       /* Authentication key 0 (Address 0x00ea)*/
> +       MAX98927_Authentication_key_0 = 0x00ea,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_key_0_AUTH_KEY_Mask  = (0xff << 0),
> +
> +       /* Authentication key 1 (Address 0x00eb)*/
> +       MAX98927_Authentication_key_1 = 0x00eb,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_key_1_AUTH_KEY_Mask  = (0xff << 0),
> +
> +       /* Authentication key 2 (Address 0x00ec)*/
> +       MAX98927_Authentication_key_2 = 0x00ec,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_key_2_AUTH_KEY_Mask  = (0xff << 0),
> +
> +       /* Authentication key 3 (Address 0x00ed)*/
> +       MAX98927_Authentication_key_3 = 0x00ed,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_key_3_AUTH_KEY_Mask  = (0xff << 0),
> +
> +       /* Authentication enable (Address 0x00ee)*/
> +       MAX98927_Authentication_enable = 0x00ee,
> +       MAX98927_Authentication_enable_AUTH_EN  = (0x1 << 0),
> +
> +       /* Authentication result 0 (Address 0x00ef)*/
> +       MAX98927_Authentication_result_0 = 0x00ef,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_result_0_AUTH_RESULT_Mask  = (0xff << 0),
> +
> +       /* Authentication result 1 (Address 0x00f0)*/
> +       MAX98927_Authentication_result_1 = 0x00f0,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_result_1_AUTH_RESULT_Mask  = (0xff << 0),
> +
> +       /* Authentication result 2 (Address 0x00f1)*/
> +       MAX98927_Authentication_result_2 = 0x00f1,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_result_2_AUTH_RESULT_Mask  = (0xff << 0),
> +
> +       /* Authentication result 3 (Address 0x00f2)*/
> +       MAX98927_Authentication_result_3 = 0x00f2,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_result_3_AUTH_RESULT_Mask  = (0xff << 0),
> +
> +       /* Authentication result 4 (Address 0x00f3)*/
> +       MAX98927_Authentication_result_4 = 0x00f3,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_result_4_AUTH_RESULT_Mask  = (0xff << 0),
> +
> +       /* Authentication result 5 (Address 0x00f4)*/
> +       MAX98927_Authentication_result_5 = 0x00f4,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_result_5_AUTH_RESULT_Mask  = (0xff << 0),
> +
> +       /* Authentication result 6 (Address 0x00f5)*/
> +       MAX98927_Authentication_result_6 = 0x00f5,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_result_6_AUTH_RESULT_Mask  = (0xff << 0),
> +
> +       /* Authentication result 7 (Address 0x00f6)*/
> +       MAX98927_Authentication_result_7 = 0x00f6,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_result_7_AUTH_RESULT_Mask  = (0xff << 0),
> +
> +       /* Authentication result 8 (Address 0x00f7)*/
> +       MAX98927_Authentication_result_8 = 0x00f7,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_result_8_AUTH_RESULT_Mask  = (0xff << 0),
> +
> +       /* Authentication result 9 (Address 0x00f8)*/
> +       MAX98927_Authentication_result_9 = 0x00f8,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_result_9_AUTH_RESULT_Mask  = (0xff << 0),
> +
> +       /* Authentication result 10 (Address 0x00f9)*/
> +       MAX98927_Authentication_result_10  = 0x00f9,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_result_10_AUTH_RESULT_Mask = (0xff << 0),
> +
> +       /* Authentication result 11 (Address 0x00fa)*/
> +       MAX98927_Authentication_result_11  = 0x00fa,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_result_11_AUTH_RESULT_Mask = (0xff << 0),
> +
> +       /* Authentication result 12 (Address 0x00fb)*/
> +       MAX98927_Authentication_result_12  = 0x00fb,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_result_12_AUTH_RESULT_Mask = (0xff << 0),
> +
> +       /* Authentication result 13 (Address 0x00fc)*/
> +       MAX98927_Authentication_result_13  = 0x00fc,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_result_13_AUTH_RESULT_Mask = (0xff << 0),
> +
> +       /* Authentication result 14 (Address 0x00fd)*/
> +       MAX98927_Authentication_result_14  = 0x00fd,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_result_14_AUTH_RESULT_Mask = (0xff << 0),
> +
> +       /* Authentication result 15 (Address 0x00fe)*/
> +       MAX98927_Authentication_result_15  = 0x00fe,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_Authentication_result_15_AUTH_RESULT_Mask = (0xff << 0),
> +
> +       /* Global Enable (Address 0x00ff)*/
> +       MAX98927_Global_Enable = 0x00ff,
> +       MAX98927_Global_Enable_EN = (0x1 << 0),
> +       /* Software Reset (Address 0x0100)*/
> +       MAX98927_Software_Reset   = 0x0100,
> +       MAX98927_Software_Reset_RST = (0x1 << 0),
> +
> +       /* REV ID (Address 0x01ff)*/
> +       MAX98927_REV_ID  = 0x01ff,
> +       /*#BYHAND width >= 5:*/
> +       MAX98927_REV_ID_REV_ID_Mask = (0xff << 0),
> +} MAX98927Registers;
> +
> +struct max98927_reg_default {
> +       unsigned int ch;
> +       unsigned int reg;
> +       unsigned int def;
> +};
> +struct max98927_priv {
> +       struct regmap *regmap;
> +       struct regmap *sub_regmap;
> +       struct snd_soc_codec *codec;
> +       struct max98927_pdata *pdata;
> +       const uint32_t *regcfg;
> +       uint32_t regcfg_sz;
> +       unsigned int spk_gain;
> +       unsigned int sysclk;
> +       unsigned int v_l_slot;
> +       unsigned int i_l_slot;
> +       unsigned int v_r_slot;
> +       unsigned int i_r_slot;
> +       bool interleave_mode;
> +       unsigned int ch_size;
> +       unsigned int rate;
> +       unsigned int iface;
> +       unsigned int master;
> +       unsigned int thres_hyste;
> +       unsigned int level5_hold;
> +       unsigned int level6_hold;
> +       unsigned int level7_hold;
> +       unsigned int level8_hold;
> +       unsigned int amp_limit;
> +       unsigned int amp_limit_rel;
> +       unsigned int amp1_level;
> +       unsigned int amp2_level;
> +       unsigned int amp3_level;
> +       unsigned int amp1_level8;
> +       unsigned int amp2_level8;
> +       unsigned int amp3_level8;
> +       unsigned int amp1_level7;
> +       unsigned int amp2_level7;
> +       unsigned int amp3_level7;
> +       unsigned int amp1_level6;
> +       unsigned int amp2_level6;
> +       unsigned int amp3_level6;
> +       unsigned int amp1_level5;
> +       unsigned int amp2_level5;
> +       unsigned int amp3_level5;
> +       unsigned int digital_gain;
> +       unsigned int pdm_gain;
> +       unsigned int level_hold;
> +       struct i2c_client *sub_i2c;
> +       int sub_reg;
> +       int sub_bus;
> +};
> +
> +#define MAX98927_GLOBAL_SHIFT 0
> +#define M98927_DAI_MSEL_SHIFT 4
> +#define M98927_DAI_BSEL_SHIFT 0
> +#define M98927_DAI_BSEL_32 (2 << M98927_DAI_BSEL_SHIFT)
> +#define M98927_DAI_BSEL_48 (3 << M98927_DAI_BSEL_SHIFT)
> +#define M98927_DAI_BSEL_64 (4 << M98927_DAI_BSEL_SHIFT)
> +#define M98927_DAI_MSEL_32 (2 << M98927_DAI_MSEL_SHIFT)
> +#define M98927_DAI_MSEL_48 (3 << M98927_DAI_MSEL_SHIFT)
> +#define M98927_DAI_MSEL_64 (4 << M98927_DAI_MSEL_SHIFT)
> +#define MAX98927_Speaker_Gain_Width 3
> +#define MAX98927_SPK_RMP_EN_SHIFT 4
> +#define MAX98927_PDM_GAIN_SHIFT 4
> +#define MAX98927_pdm_Gain_Width 3
> +#define MAX98927_AMP_VOL_WIDTH 7
> +#define MAX98927_AMP_VOL_LOCATION_SHIFT 7
> +#define MAX98927_PDM_Rx_Enable_PDM_CH_SHIFT 3
> +#define MAX98927_PCM_to_speaker_monomix_A_SHIFT 6
> +#define MAX98927_PCM_Sample_rate_setup_2_DIG_IF_SR_48000    (0x8 << 4)
> +#define MAX98927_PCM_FORMAT_DSP_A    (0x3 << 3)
> +#define MAX98927_DRE_Control_DRE_SHIFT   0x1
> +#define MAX98927_PCM_Master_Mode_PCM_MCLK_RATE_SHIFT    (2)
> +#define MAX98927_Brownout_AMP_limiter_attack_release_shift 4
> +#define MAX98927_BDE_DSP_SHIFT 2
> +#define MAX98927_Speaker_Gain_SPK_PDM_GAIN_SHIFT (4)
> +#define MAX98927_BDE_AMP_SHIFT (1)
> +#define MAX98927_PCM_Tx_Ch_Sources_A_I_SHIFT (4)
> +#endif
> --
> 1.9.1
>



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
