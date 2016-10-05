From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH 06/14] ASoC: Add sun8i digital audio codec
Date: Wed, 05 Oct 2016 18:19:46 +0800
Message-ID: <4537251475662786@web5h.yandex.ru>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com><cover.1475571575.git.mylene.josserand@free-electrons.com> <85cbd9926e52d0aa03f6bbfd8794373d8db491e0.1475571575.git.mylene.josserand@free-electrons.com>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBRNH2O7QKGQEMWAPSFQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <85cbd9926e52d0aa03f6bbfd8794373d8db491e0.1475571575.git.mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?utf-8?B?TXlsw6huZSBKb3NzZXJhbmQ=?= <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "wens-jdAy2FN1RRM@public.gmane.org" <wens-jdAy2FN1RRM@public.gmane.org>, "mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org" <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "tiwai-IBi9RG/b67k@public.gmane.org" <tiwai-IBi9RG/b67k@public.gmane.org>, "lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



04.10.2016, 17:54, "Myl=C3=A8ne Josserand" <mylene.josserand@free-electrons=
.com>:
> Add the digital sun8i audio codec which handles the base register
> (without DAI).
> The driver handles only the basic playback of the A33 codec, from
> the DAC to the headphones. All other features (microphone, capture,
> etc) will be added later.
>
> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org=
>
> ---
> =C2=A0sound/soc/sunxi/Kconfig | 9 +
> =C2=A0sound/soc/sunxi/Makefile | 1 +
> =C2=A0sound/soc/sunxi/sun8i-codec.c | 492 +++++++++++++++++++++++++++++++=
+++++++++++
> =C2=A03 files changed, 502 insertions(+)
> =C2=A0create mode 100644 sound/soc/sunxi/sun8i-codec.c
>
> diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
> index 7aee95a..9e287b0 100644
> --- a/sound/soc/sunxi/Kconfig
> +++ b/sound/soc/sunxi/Kconfig
> @@ -27,6 +27,15 @@ config SND_SUN4I_SPDIF
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Say Y o=
r M to add support for the S/PDIF audio block in the Allwinner
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0A10 and=
 affiliated SoCs.
>
> +config SND_SUN8I_CODEC
> + tristate "Allwinner SUN8I audio codec"
> + select REGMAP_MMIO
> + help
> + This option enables the digital part of the internal audio codec for
> + Allwinner sun8i SoC.
> +
> + Say Y or M if you want to add sun8i digital audio codec support.
> +
> =C2=A0config SND_SUN8I_CODEC_ANALOG
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "Allwinner=
 SUN8I analog codec"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select REGMAP_MMIO
> diff --git a/sound/soc/sunxi/Makefile b/sound/soc/sunxi/Makefile
> index 241c0df..1da63d3 100644
> --- a/sound/soc/sunxi/Makefile
> +++ b/sound/soc/sunxi/Makefile
> @@ -1,4 +1,5 @@
> =C2=A0obj-$(CONFIG_SND_SUN4I_CODEC) +=3D sun4i-codec.o
> =C2=A0obj-$(CONFIG_SND_SUN4I_I2S) +=3D sun4i-i2s.o
> =C2=A0obj-$(CONFIG_SND_SUN4I_SPDIF) +=3D sun4i-spdif.o
> +obj-$(CONFIG_SND_SUN8I_CODEC) +=3D sun8i-codec.o
> =C2=A0obj-$(CONFIG_SND_SUN8I_CODEC_ANALOG) +=3D sun8i-codec-analog.o
> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.=
c
> new file mode 100644
> index 0000000..e157f89
> --- /dev/null
> +++ b/sound/soc/sunxi/sun8i-codec.c
> @@ -0,0 +1,492 @@
> +/*
> + * This driver supports the digital controls for the internal codec
> + * found in Allwinner's A33 and A23 SoCs.
> + *
> + * (C) Copyright 2010-2016
> + * Reuuimlla Technology Co., Ltd. <www.reuuimllatech.com>
> + * huangxin <huangxin-VvRAZUq9tDuYHARAtoI1EgC/G2K4zDHf@public.gmane.org>
> + * Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/regmap.h>
> +
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +
> +/* CODEC_OFFSET represents the offset of the codec registers
> + * and not all the DAI registers
> + */
> +#define CODEC_OFFSET 0x200
> +#define CODEC_BASSADDRESS 0x01c22c00

I don't think this kind of absolute address should exist here...
It should exist in device tree...

> +#define SUN8I_SYSCLK_CTL (0x20c - CODEC_OFFSET)
> +#define SUN8I_SYSCLK_CTL_AIF1CLK_ENA (11)
> +#define SUN8I_SYSCLK_CTL_SYSCLK_ENA (3)
> +#define SUN8I_SYSCLK_CTL_SYSCLK_SRC (0)
> +#define SUN8I_MOD_CLK_ENA (0x210 - CODEC_OFFSET)
> +#define SUN8I_MOD_CLK_ENA_AIF1 (15)
> +#define SUN8I_MOD_CLK_ENA_DAC (2)
> +#define SUN8I_MOD_RST_CTL (0x214 - CODEC_OFFSET)
> +#define SUN8I_MOD_RST_CTL_AIF1 (15)
> +#define SUN8I_MOD_RST_CTL_DAC (2)
> +#define SUN8I_SYS_SR_CTRL (0x218 - CODEC_OFFSET)
> +#define SUN8I_SYS_SR_CTRL_AIF1_FS (12)
> +#define SUN8I_SYS_SR_CTRL_AIF2_FS (8)
> +#define SUN8I_AIF1CLK_CTRL (0x240 - CODEC_OFFSET)
> +#define SUN8I_AIF1CLK_CTRL_AIF1_MSTR_MOD (15)
> +#define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV (14)
> +#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV (13)
> +#define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV (9)
> +#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV (6)
> +#define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ (4)
> +#define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT (2)
> +#define SUN8I_AIF1_DACDAT_CTRL (0x248 - CODEC_OFFSET)
> +#define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA (15)
> +#define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA (14)
> +#define SUN8I_DAC_DIG_CTRL (0x320 - CODEC_OFFSET)
> +#define SUN8I_DAC_DIG_CTRL_ENDA (15)
> +#define SUN8I_DAC_MXR_SRC (0x330 - CODEC_OFFSET)
> +#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA0L (15)
> +#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA1L (14)
> +#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF2DACL (13)
> +#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_ADCL (12)
> +#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA0R (11)
> +#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA1R (10)
> +#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF2DACR (9)
> +#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_ADCR (8)
> +
> +struct sun8i_codec {
> + struct device *dev;
> + struct regmap *regmap;
> + struct clk *clk_module;
> + struct clk *clk_apb;
> +};
> +
> +static int sun8i_codec_get_hw_rate(struct snd_pcm_hw_params *params)
> +{
> + unsigned int rate =3D params_rate(params);
> +
> + switch (rate) {
> + case 8000:
> + case 7350:
> + return 0x0;
> + case 11025:
> + return 0x1;
> + case 12000:
> + return 0x2;
> + case 16000:
> + return 0x3;
> + case 22050:
> + return 0x4;
> + case 24000:
> + return 0x5;
> + case 32000:
> + return 0x6;
> + case 44100:
> + return 0x7;
> + case 48000:
> + return 0x8;
> + case 96000:
> + return 0x9;
> + case 192000:
> + return 0xa;
> + default:
> + return -EINVAL;
> + }
> +}
> +
> +static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> + struct sun8i_codec *scodec =3D snd_soc_codec_get_drvdata(dai->codec);
> + unsigned long value;
> +
> + /* clock masters */
> + switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> + case SND_SOC_DAIFMT_CBS_CFS: /* DAI Slave */
> + value =3D 0x0; /* Codec Master */
> + break;
> + case SND_SOC_DAIFMT_CBM_CFM: /* DAI Master */
> + value =3D 0x1; /* Codec Slave */
> + break;
> + default:
> + return -EINVAL;
> + }
> + regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
> + BIT(SUN8I_AIF1CLK_CTRL_AIF1_MSTR_MOD),
> + value << SUN8I_AIF1CLK_CTRL_AIF1_MSTR_MOD);
> +
> + /* clock inversion */
> + switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> + case SND_SOC_DAIFMT_NB_NF: /* Normal */
> + value =3D 0x0;
> + break;
> + case SND_SOC_DAIFMT_IB_IF: /* Inversion */
> + value =3D 0x1;
> + break;
> + default:
> + return -EINVAL;
> + }
> + regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
> + BIT(SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV),
> + value << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV);
> + regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
> + BIT(SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV),
> + value << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV);
> +
> + /* DAI format */
> + switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> + case SND_SOC_DAIFMT_I2S:
> + value =3D 0x0;
> + break;
> + case SND_SOC_DAIFMT_LEFT_J:
> + value =3D 0x1;
> + break;
> + case SND_SOC_DAIFMT_RIGHT_J:
> + value =3D 0x2;
> + break;
> + case SND_SOC_DAIFMT_DSP_A:
> + case SND_SOC_DAIFMT_DSP_B:
> + value =3D 0x3;
> + break;
> + default:
> + return -EINVAL;
> + }
> + regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
> + BIT(SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT),
> + value << SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT);
> +
> + return 0;
> +}
> +
> +static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
> + struct snd_pcm_hw_params *params,
> + struct snd_soc_dai *dai)
> +{
> + int rs_value =3D 0;
> + u32 bclk_lrck_div =3D 0, sample_resolution;
> + int sample_rate =3D 0;
> + struct sun8i_codec *scodec =3D snd_soc_codec_get_drvdata(dai->codec);
> +
> + switch (params_format(params)) {
> + case SNDRV_PCM_FORMAT_S16_LE:
> + sample_resolution =3D 16;
> + break;
> + case SNDRV_PCM_FORMAT_S20_3LE:
> + case SNDRV_PCM_FORMAT_S24_LE:
> + case SNDRV_PCM_FORMAT_S32_LE:
> + sample_resolution =3D 24;
> + break;
> + default:
> + return -EINVAL;
> + }
> +
> + /*calculate word select bit*/
> + switch (sample_resolution) {
> + case 8:
> + rs_value =3D 0x0;
> + break;
> + case 16:
> + rs_value =3D 0x1;
> + break;
> + case 20:
> + rs_value =3D 0x2;
> + break;
> + case 24:
> + rs_value =3D 0x3;
> + break;
> + default:
> + break;
> + }
> + regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
> + 0x3 << SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ,
> + rs_value << SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ);
> +
> + /* calculate bclk_lrck_div Ratio */
> + bclk_lrck_div =3D sample_resolution * 2;
> + switch (bclk_lrck_div) {
> + case 16:
> + bclk_lrck_div =3D 0;
> + break;
> + case 32:
> + bclk_lrck_div =3D 1;
> + break;
> + case 64:
> + bclk_lrck_div =3D 2;
> + break;
> + case 128:
> + bclk_lrck_div =3D 3;
> + break;
> + case 256:
> + bclk_lrck_div =3D 4;
> + break;
> + default:
> + break;
> + }
> + regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
> + 0x7 << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV,
> + bclk_lrck_div << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
> +
> + sample_rate =3D sun8i_codec_get_hw_rate(params);
> + if (sample_rate < 0)
> + return sample_rate;
> +
> + regmap_update_bits(scodec->regmap, SUN8I_SYS_SR_CTRL,
> + 0xf << SUN8I_SYS_SR_CTRL_AIF1_FS,
> + sample_rate << SUN8I_SYS_SR_CTRL_AIF1_FS);
> + regmap_update_bits(scodec->regmap, SUN8I_SYS_SR_CTRL,
> + 0xf << SUN8I_SYS_SR_CTRL_AIF2_FS,
> + sample_rate << SUN8I_SYS_SR_CTRL_AIF2_FS);
> +
> + return 0;
> +}
> +
> +static const struct snd_kcontrol_new sun8i_output_left_mixer_controls[] =
=3D {
> + SOC_DAPM_SINGLE("LSlot 0", SUN8I_DAC_MXR_SRC,
> + SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA0L, 1, 0),
> + SOC_DAPM_SINGLE("LSlot 1", SUN8I_DAC_MXR_SRC,
> + SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA1L, 1, 0),
> + SOC_DAPM_SINGLE("DACL", SUN8I_DAC_MXR_SRC,
> + SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF2DACL, 1, 0),
> + SOC_DAPM_SINGLE("ADCL", SUN8I_DAC_MXR_SRC,
> + SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_ADCL, 1, 0),
> +};
> +
> +static const struct snd_kcontrol_new sun8i_output_right_mixer_controls[]=
 =3D {
> + SOC_DAPM_SINGLE("RSlot 0", SUN8I_DAC_MXR_SRC,
> + SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA0R, 1, 0),
> + SOC_DAPM_SINGLE("RSlot 1", SUN8I_DAC_MXR_SRC,
> + SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA1R, 1, 0),
> + SOC_DAPM_SINGLE("DACR", SUN8I_DAC_MXR_SRC,
> + SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF2DACR, 1, 0),
> + SOC_DAPM_SINGLE("ADCR", SUN8I_DAC_MXR_SRC,
> + SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_ADCR, 1, 0),
> +};
> +
> +static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] =3D {
> + /* Digital parts of the DACs */
> + SND_SOC_DAPM_SUPPLY("DAC", SUN8I_DAC_DIG_CTRL, SUN8I_DAC_DIG_CTRL_ENDA,
> + 0, NULL, 0),
> +
> + /* Analog DAC */
> + SND_SOC_DAPM_DAC("Left DAC", "Playback", SUN8I_AIF1_DACDAT_CTRL,
> + SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA, 0),
> + SND_SOC_DAPM_DAC("Right DAC", "Playback", SUN8I_AIF1_DACDAT_CTRL,
> + SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA, 0),
> +
> + /* DAC Mixers */
> + SND_SOC_DAPM_MIXER("Left DAC Mixer", SND_SOC_NOPM, 0, 0,
> + sun8i_output_left_mixer_controls,
> + ARRAY_SIZE(sun8i_output_left_mixer_controls)),
> + SND_SOC_DAPM_MIXER("Right DAC Mixer", SND_SOC_NOPM, 0, 0,
> + sun8i_output_right_mixer_controls,
> + ARRAY_SIZE(sun8i_output_right_mixer_controls)),
> +
> + /* Clocks */
> + SND_SOC_DAPM_SUPPLY("MODCLK AFI1", SUN8I_MOD_CLK_ENA,
> + SUN8I_MOD_CLK_ENA_AIF1, 0, NULL, 0),
> + SND_SOC_DAPM_SUPPLY("MODCLK DAC", SUN8I_MOD_CLK_ENA,
> + SUN8I_MOD_CLK_ENA_DAC, 0, NULL, 0),
> + SND_SOC_DAPM_SUPPLY("AIF1", SUN8I_SYSCLK_CTL,
> + SUN8I_SYSCLK_CTL_AIF1CLK_ENA, 0, NULL, 0),
> + SND_SOC_DAPM_SUPPLY("SYSCLK", SUN8I_SYSCLK_CTL,
> + SUN8I_SYSCLK_CTL_SYSCLK_ENA, 0, NULL, 0),
> +
> + SND_SOC_DAPM_SUPPLY("AIF1 PLL", SUN8I_SYSCLK_CTL, 0x9, 0, NULL, 0),
> + /* Inversion as 0=3DAIF1, 1=3DAIF2 */
> + SND_SOC_DAPM_SUPPLY("SYSCLK AIF1", SUN8I_SYSCLK_CTL,
> + SUN8I_SYSCLK_CTL_SYSCLK_SRC, 1, NULL, 0),
> +
> + /* Module reset */
> + SND_SOC_DAPM_SUPPLY("RST AIF1", SUN8I_MOD_RST_CTL,
> + SUN8I_MOD_RST_CTL_AIF1, 0, NULL, 0),
> + SND_SOC_DAPM_SUPPLY("RST DAC", SUN8I_MOD_RST_CTL,
> + SUN8I_MOD_RST_CTL_DAC, 0, NULL, 0),
> +
> + /* Headphone outputs */
> + SND_SOC_DAPM_OUTPUT("HPOUTL"),
> + SND_SOC_DAPM_OUTPUT("HPOUTR"),
> +
> +};
> +
> +static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] =3D {
> + /* Clock Routes */
> + { "AIF1", NULL, "SYSCLK AIF1" },
> + { "AIF1 PLL", NULL, "AIF1" },
> + { "RST AIF1", NULL, "AIF1 PLL" },
> + { "MODCLK AFI1", NULL, "RST AIF1" },
> + { "DAC", NULL, "MODCLK AFI1" },
> +
> + { "RST DAC", NULL, "SYSCLK" },
> + { "MODCLK DAC", NULL, "RST DAC" },
> + { "DAC", NULL, "MODCLK DAC" },
> +
> + /* DAC Routes */
> + { "Left DAC", NULL, "DAC" },
> + { "Right DAC", NULL, "DAC" },
> +
> + /* DAC Mixer Routes */
> + { "Left DAC Mixer", "LSlot 0", "Left DAC"},
> + { "Right DAC Mixer", "RSlot 0", "Right DAC"},
> +
> + /* End of route : HP out */
> + { "HPOUTL", NULL, "Left DAC Mixer" },
> + { "HPOUTR", NULL, "Right DAC Mixer" },
> +};
> +
> +static struct snd_soc_dai_ops sun8i_codec_dai_ops =3D {
> + .hw_params =3D sun8i_codec_hw_params,
> + .set_fmt =3D sun8i_set_fmt,
> +};
> +
> +static struct snd_soc_dai_driver sun8i_codec_dai =3D {
> + .name =3D "sun8i",
> + /* playback capabilities */
> + .playback =3D {
> + .stream_name =3D "Playback",
> + .channels_min =3D 1,
> + .channels_max =3D 2,
> + .rates =3D SNDRV_PCM_RATE_8000_192000 |
> + SNDRV_PCM_RATE_KNOT,
> + .formats =3D SNDRV_PCM_FMTBIT_S8 |
> + SNDRV_PCM_FMTBIT_S16_LE |
> + SNDRV_PCM_FMTBIT_S18_3LE |
> + SNDRV_PCM_FMTBIT_S20_3LE |
> + SNDRV_PCM_FMTBIT_S24_LE |
> + SNDRV_PCM_FMTBIT_S32_LE,
> + },
> + /* pcm operations */
> + .ops =3D &sun8i_codec_dai_ops,
> +};
> +EXPORT_SYMBOL(sun8i_codec_dai);
> +
> +static int sun8i_soc_probe(struct snd_soc_codec *codec)
> +{
> + return 0;
> +}
> +
> +/* power down chip */
> +static int sun8i_soc_remove(struct snd_soc_codec *codec)
> +{
> + return 0;
> +}
> +
> +static struct snd_soc_codec_driver sun8i_soc_codec =3D {
> + .probe =3D sun8i_soc_probe,
> + .remove =3D sun8i_soc_remove,
> + .component_driver =3D {
> + .dapm_widgets =3D sun8i_codec_dapm_widgets,
> + .num_dapm_widgets =3D ARRAY_SIZE(sun8i_codec_dapm_widgets),
> + .dapm_routes =3D sun8i_codec_dapm_routes,
> + .num_dapm_routes =3D ARRAY_SIZE(sun8i_codec_dapm_routes),
> + },
> +};
> +
> +static const struct regmap_config sun8i_codec_regmap_config =3D {
> + .reg_bits =3D 32,
> + .reg_stride =3D 4,
> + .val_bits =3D 32,
> + .max_register =3D SUN8I_DAC_MXR_SRC,
> +};
> +
> +static int sun8i_codec_probe(struct platform_device *pdev)
> +{
> + struct resource *res_base;
> + struct sun8i_codec *scodec;
> + void __iomem *base;
> +
> + scodec =3D devm_kzalloc(&pdev->dev, sizeof(*scodec), GFP_KERNEL);
> + if (!scodec)
> + return -ENOMEM;
> +
> + scodec->dev =3D &pdev->dev;
> +
> + /* Get the clocks from the DT */
> + scodec->clk_module =3D devm_clk_get(&pdev->dev, "codec");
> + if (IS_ERR(scodec->clk_module)) {
> + dev_err(&pdev->dev, "Failed to get the module clock\n");
> + return PTR_ERR(scodec->clk_module);
> + }
> + if (clk_prepare_enable(scodec->clk_module))
> + pr_err("err:open failed;\n");
> +
> + scodec->clk_apb =3D devm_clk_get(&pdev->dev, "apb");
> + if (IS_ERR(scodec->clk_apb)) {
> + dev_err(&pdev->dev, "Failed to get the apb clock\n");
> + return PTR_ERR(scodec->clk_apb);
> + }
> + if (clk_prepare_enable(scodec->clk_apb))
> + pr_err("err:open failed;\n");
> +
> + /* Get base resources, registers and regmap */
> + res_base =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "audio"=
);
> + base =3D devm_ioremap_resource(&pdev->dev, res_base);
> + if (IS_ERR(base)) {
> + dev_err(&pdev->dev, "Failed to map the registers\n");
> + return PTR_ERR(base);
> + }
> +
> + scodec->regmap =3D devm_regmap_init_mmio(&pdev->dev, base,
> + &sun8i_codec_regmap_config);
> + if (IS_ERR(scodec->regmap)) {
> + dev_err(&pdev->dev, "Failed to create our regmap\n");
> + return PTR_ERR(scodec->regmap);
> + }
> +
> + /* Set the codec data as driver data */
> + dev_set_drvdata(&pdev->dev, scodec);
> +
> + snd_soc_register_codec(&pdev->dev, &sun8i_soc_codec, &sun8i_codec_dai,
> + 1);
> +
> + return 0;
> +}
> +
> +static int sun8i_codec_remove(struct platform_device *pdev)
> +{
> + struct snd_soc_card *card =3D platform_get_drvdata(pdev);
> + struct sun8i_codec *scodec =3D snd_soc_card_get_drvdata(card);
> +
> + snd_soc_unregister_codec(&pdev->dev);
> + clk_disable_unprepare(scodec->clk_module);
> + clk_disable_unprepare(scodec->clk_apb);
> +
> + return 0;
> +}
> +
> +static const struct of_device_id sun8i_codec_of_match[] =3D {
> + { .compatible =3D "allwinner,sun8i-a33-codec" },
> + { .compatible =3D "allwinner,sun8i-a23-codec" },
> + {}
> +};
> +MODULE_DEVICE_TABLE(of, sun8i_codec_of_match);
> +
> +static struct platform_driver sun8i_codec_driver =3D {
> + .driver =3D {
> + .name =3D "sun8i-codec",
> + .owner =3D THIS_MODULE,
> + .of_match_table =3D sun8i_codec_of_match,
> + },
> + .probe =3D sun8i_codec_probe,
> + .remove =3D sun8i_codec_remove,
> +};
> +module_platform_driver(sun8i_codec_driver);
> +
> +MODULE_DESCRIPTION("Allwinner A33 (sun8i) codec driver");
> +MODULE_AUTHOR("huanxin<huanxin-jFKXxz0WcGyYHARAtoI1EgC/G2K4zDHf@public.gmane.org>");
> +MODULE_AUTHOR("Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTGGXanvQGlWp@public.gmane.org=
m>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:sun8i-codec");
> --
> 2.9.3
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
