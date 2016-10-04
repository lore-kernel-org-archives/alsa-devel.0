From: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 04/14] ASoC: Add sun8i analog codec driver
Date: Tue, 4 Oct 2016 12:21:18 +0200
Message-ID: <CAEKpxBk-e-sXXWD7p6Db_EsFP1bTVjeFsroy7+r5V-ZYC4ndmg@mail.gmail.com>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <cover.1475569400.git.mylene.josserand@free-electrons.com> <db0f628732e8b52b36b8204f146573926957e654.1475571575.git.mylene.josserand@free-electrons.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBH4FZ27QKGQETRYYSWA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <db0f628732e8b52b36b8204f146573926957e654.1475571575.git.mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 4 October 2016 at 11:46, Myl=C3=A8ne Josserand
<mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> Add the analog part of the sun8i (A33) codec driver. This driver
> implements all the analog part of the codec using PRCM registers.
>
> The read/write regmap functions must be handled in a custom way as
> the PRCM register behaves as "mailbox" register.
>
> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org=
>
> ---
>  sound/soc/sunxi/Kconfig              |   7 +
>  sound/soc/sunxi/Makefile             |   1 +
>  sound/soc/sunxi/sun8i-codec-analog.c | 304 +++++++++++++++++++++++++++++=
++++++
>  3 files changed, 312 insertions(+)
>  create mode 100644 sound/soc/sunxi/sun8i-codec-analog.c
>
> diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
> index dd23682..7aee95a 100644
> --- a/sound/soc/sunxi/Kconfig
> +++ b/sound/soc/sunxi/Kconfig
> @@ -26,4 +26,11 @@ config SND_SUN4I_SPDIF
>         help
>           Say Y or M to add support for the S/PDIF audio block in the All=
winner
>           A10 and affiliated SoCs.
> +
> +config SND_SUN8I_CODEC_ANALOG
> +       tristate "Allwinner SUN8I analog codec"
> +       select REGMAP_MMIO
> +        help
> +         Say Y or M if you want to add sun8i analog audiocodec support
> +
>  endmenu
> diff --git a/sound/soc/sunxi/Makefile b/sound/soc/sunxi/Makefile
> index 604c7b84..241c0df 100644
> --- a/sound/soc/sunxi/Makefile
> +++ b/sound/soc/sunxi/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_SND_SUN4I_CODEC) +=3D sun4i-codec.o
>  obj-$(CONFIG_SND_SUN4I_I2S) +=3D sun4i-i2s.o
>  obj-$(CONFIG_SND_SUN4I_SPDIF) +=3D sun4i-spdif.o
> +obj-$(CONFIG_SND_SUN8I_CODEC_ANALOG) +=3D sun8i-codec-analog.o
> diff --git a/sound/soc/sunxi/sun8i-codec-analog.c b/sound/soc/sunxi/sun8i=
-codec-analog.c
> new file mode 100644
> index 0000000..be3d540
> --- /dev/null
> +++ b/sound/soc/sunxi/sun8i-codec-analog.c
> @@ -0,0 +1,304 @@
> +/*
> + * This driver supports the analog controls for the internal codec
> + * found in Allwinner's A31s, A33 and A23 SoCs.
> + *
> + * Copyright 2016 Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> + * Copyright 2016 Myl=C3=A8ne Josserand <mylene.josserand@free-electrons=
.com>
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
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/tlv.h>
> +
> +/* Codec analog control register offsets and bit fields */
> +#define SUN8I_ADDA_HP_VOLC                             0x00
> +#define SUN8I_ADDA_HP_VOLC_PA_CLK_GATE                 7
> +#define SUN8I_ADDA_HP_VOLC_HP_VOL                      0
> +#define SUN8I_ADDA_LOMIXSC                             0x01
> +#define SUN8I_ADDA_LOMIXSC_MIC1                        6
> +#define SUN8I_ADDA_LOMIXSC_MIC2                        5
> +#define SUN8I_ADDA_LOMIXSC_PHONE                       4
> +#define SUN8I_ADDA_LOMIXSC_PHONEN                      3
> +#define SUN8I_ADDA_LOMIXSC_LINEINL                     2
> +#define SUN8I_ADDA_LOMIXSC_DACL                        1
> +#define SUN8I_ADDA_LOMIXSC_DACR                        0
> +#define SUN8I_ADDA_ROMIXSC                             0x02
> +#define SUN8I_ADDA_ROMIXSC_MIC1                        6
> +#define SUN8I_ADDA_ROMIXSC_MIC2                        5
> +#define SUN8I_ADDA_ROMIXSC_PHONE                       4
> +#define SUN8I_ADDA_ROMIXSC_PHONEP                      3
> +#define SUN8I_ADDA_ROMIXSC_LINEINR                     2
> +#define SUN8I_ADDA_ROMIXSC_DACR                        1
> +#define SUN8I_ADDA_ROMIXSC_DACL                        0
> +#define SUN8I_ADDA_DAC_PA_SRC                          0x03
> +#define SUN8I_ADDA_DAC_PA_SRC_DACAREN                  7
> +#define SUN8I_ADDA_DAC_PA_SRC_DACALEN                  6
> +#define SUN8I_ADDA_DAC_PA_SRC_RMIXEN                   5
> +#define SUN8I_ADDA_DAC_PA_SRC_LMIXEN                   4
> +#define SUN8I_ADDA_DAC_PA_SRC_RHPPAMUTE                3
> +#define SUN8I_ADDA_DAC_PA_SRC_LHPPAMUTE                2
> +#define SUN8I_ADDA_DAC_PA_SRC_RHPIS                    1
> +#define SUN8I_ADDA_DAC_PA_SRC_LHPIS                    0
> +#define SUN8I_ADDA_PHONEIN_GCTRL                       0x04
> +#define SUN8I_ADDA_PHONEIN_GCTRL_PHONEPG               4
> +#define SUN8I_ADDA_PHONEIN_GCTRL_PHONENG               0
> +#define SUN8I_ADDA_LINEIN_GCTRL                        0x05
> +#define SUN8I_ADDA_LINEIN_GCTRL_LINEING                4
> +#define SUN8I_ADDA_LINEIN_GCTRL_PHONEG                 0
> +#define SUN8I_ADDA_MICIN_GCTRL                         0x06
> +#define SUN8I_ADDA_MICIN_GCTRL_MIC1G                   4
> +#define SUN8I_ADDA_MICIN_GCTRL_MIC2G                   0
> +#define SUN8I_ADDA_PAEN_HP_CTRL                        0x07
> +#define SUN8I_ADDA_PAEN_HP_CTRL_HPPAEN                 7
> +#define SUN8I_ADDA_PAEN_HP_CTRL_HPCOM_FC               5
> +#define SUN8I_ADDA_PAEN_HP_CTRL_COMPTEN                4
> +#define SUN8I_ADDA_PAEN_HP_CTRL_PA_ANTI_POP_CTRL       2
> +#define SUN8I_ADDA_PAEN_HP_CTRL_LTRNMUTE               1
> +#define SUN8I_ADDA_PAEN_HP_CTRL_RTLNMUTE               0
> +#define SUN8I_ADDA_PHONEOUT_CTRL                       0x08
> +#define SUN8I_ADDA_PHONEOUT_CTRL_PHONEOUTG             5
> +#define SUN8I_ADDA_PHONEOUT_CTRL_PHONEOUTEN            4
> +#define SUN8I_ADDA_PHONEOUT_CTRL_PHONEOUTS3            3
> +#define SUN8I_ADDA_PHONEOUT_CTRL_PHONEOUTS2            2
> +#define SUN8I_ADDA_PHONEOUT_CTRL_PHONEOUTS1            1
> +#define SUN8I_ADDA_PHONEOUT_CTRL_PHONEOUTS0            0
> +#define SUN8I_ADDA_PHONE_GAIN_CTRL                     0x09
> +#define SUN8I_ADDA_PHONE_GAIN_CTRL_PHONEPREG           0
> +#define SUN8I_ADDA_MIC2G_CTRL                          0x0a
> +#define SUN8I_ADDA_MIC2G_CTRL_MIC2AMPEN                7
> +#define SUN8I_ADDA_MIC2G_CTRL_MIC2BOOST                4
> +#define SUN8I_ADDA_MIC1G_MICBIAS_CTRL                  0x0b
> +#define SUN8I_ADDA_MIC1G_MICBIAS_CTRL_HMICBIASEN       7
> +#define SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MMICBIASEN       6
> +#define SUN8I_ADDA_MIC1G_MICBIAS_CTRL_HMICBIAS_MODE    5
> +#define SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MIC1AMPEN        3
> +#define SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MIC1BOOST        0
> +#define SUN8I_ADDA_PA_ANTI_POP_CTRL                    0x0e
> +#define SUN8I_ADDA_ADC_AP_EN                           0x0f
> +
> +/* Analog control register access bits */
> +#define ADDA_PR                                0x0 /* PRCM base + 0x1c0 =
*/
> +#define ADDA_PR_RESET                          BIT(28)
> +#define ADDA_PR_WRITE                          BIT(24)
> +#define ADDA_PR_ADDR_SHIFT                     16
> +#define ADDA_PR_ADDR_MASK                      GENMASK(4, 0)
> +#define ADDA_PR_DATA_IN_SHIFT                  8
> +#define ADDA_PR_DATA_IN_MASK                   GENMASK(7, 0)
> +#define ADDA_PR_DATA_OUT_SHIFT                 0
> +#define ADDA_PR_DATA_OUT_MASK                  GENMASK(7, 0)
> +
> +/* regmap access bits */
> +static int adda_reg_read(void *context, unsigned int reg, unsigned int *=
val)
> +{
> +       void __iomem *base =3D context;
> +       u32 tmp;
> +
> +       tmp =3D readl(base);
> +
> +       /* De-assert reset */
> +       writel(tmp | ADDA_PR_RESET, base);
> +
> +       tmp &=3D ~(ADDA_PR_ADDR_MASK << ADDA_PR_ADDR_SHIFT);
> +       tmp |=3D reg << ADDA_PR_ADDR_SHIFT;
> +       writel(tmp, base);
> +
> +       *val =3D readl(base) & ADDA_PR_DATA_OUT_MASK;
> +
> +       return 0;
> +}
> +
> +static int adda_reg_write(void *context, unsigned int reg, unsigned int =
val)
> +{
> +       void __iomem *base =3D context;
> +       u32 tmp;
> +
> +       tmp =3D readl(base);
> +       /* De-assert reset */
> +       writel(tmp | ADDA_PR_RESET, base);
> +
> +       /* Write the address */
> +       tmp &=3D ~(ADDA_PR_ADDR_MASK << ADDA_PR_ADDR_SHIFT);
> +       tmp |=3D reg << ADDA_PR_ADDR_SHIFT;
> +       writel(tmp, base);
> +
> +       /* Write the value */
> +       tmp &=3D ~(ADDA_PR_DATA_IN_MASK << ADDA_PR_DATA_IN_SHIFT);
> +       tmp |=3D val << ADDA_PR_DATA_IN_SHIFT;
> +       writel(tmp, base);
> +
> +       /* Indicate that the previous value must be written */
> +       writel(readl(base) | ADDA_PR_WRITE, base);
> +
> +       /* Reset the write bit */
> +       writel(readl(base) & ~(ADDA_PR_WRITE), base);
> +
> +       return 0;
> +}
> +
> +struct regmap_config adda_pr_regmap_cfg =3D {
> +       .name           =3D "adda-pr",
> +       .reg_bits       =3D 5,
> +       .reg_stride     =3D 1,
> +       .val_bits       =3D 8,
> +       .reg_read       =3D adda_reg_read,
> +       .reg_write      =3D adda_reg_write,
> +       .fast_io        =3D true,
> +       .max_register   =3D 24,
> +};
> +
> +static DECLARE_TLV_DB_SCALE(sun8i_codec_headphone_volume_scale, -6300, 1=
00, 1);
> +
> +static const struct snd_kcontrol_new sun8i_analog_widgets[] =3D {
> +       SOC_SINGLE_TLV("Headphone Volume", SUN8I_ADDA_HP_VOLC,
> +                      SUN8I_ADDA_HP_VOLC_HP_VOL, 0x3F, 0,
> +                      sun8i_codec_headphone_volume_scale),
> +
> +       /* Playback Switch */
> +       SOC_DOUBLE("DAC Playback Switch", SUN8I_ADDA_DAC_PA_SRC,
> +                  SUN8I_ADDA_DAC_PA_SRC_DACALEN, SUN8I_ADDA_DAC_PA_SRC_D=
ACAREN,
> +                  1, 0),
> +
> +       SOC_DOUBLE("Headphone Playback Switch", SUN8I_ADDA_DAC_PA_SRC,
> +                  SUN8I_ADDA_DAC_PA_SRC_LHPPAMUTE,
> +                  SUN8I_ADDA_DAC_PA_SRC_RHPPAMUTE, 1, 0),
> +};
> +
> +/* headphone controls */
> +static const char * const sun8i_codec_hp_src_enum_text[] =3D {
> +       "DAC", "Mixer",
> +};
> +
> +static SOC_ENUM_DOUBLE_DECL(sun8i_codec_hp_src_enum,
> +                           SUN8I_ADDA_DAC_PA_SRC,
> +                           SUN8I_ADDA_DAC_PA_SRC_LHPIS,
> +                           SUN8I_ADDA_DAC_PA_SRC_RHPIS,
> +                           sun8i_codec_hp_src_enum_text);
> +
> +static const struct snd_kcontrol_new sun8i_codec_hp_src[] =3D {
> +       SOC_DAPM_ENUM("Headphone Source Playback Route",
> +                     sun8i_codec_hp_src_enum),
> +};
> +
> +static const struct snd_kcontrol_new sun8i_codec_mixer_controls[] =3D {
> +       SOC_DAPM_SINGLE("DAC Left Playback Switch",
> +                       SUN8I_ADDA_LOMIXSC,
> +                       SUN8I_ADDA_LOMIXSC_DACL, 1, 0),
> +       SOC_DAPM_SINGLE("DAC Right Playback Switch",
> +                       SUN8I_ADDA_ROMIXSC,
> +                       SUN8I_ADDA_ROMIXSC_DACR, 1, 0),
> +       SOC_DAPM_SINGLE("DAC Reversed Left Playback Switch",
> +                       SUN8I_ADDA_LOMIXSC,
> +                       SUN8I_ADDA_LOMIXSC_DACR, 1, 0),
> +       SOC_DAPM_SINGLE("DAC Reversed Right Playback Switch",
> +                       SUN8I_ADDA_ROMIXSC,
> +                       SUN8I_ADDA_ROMIXSC_DACL, 1, 0),
> +};
> +
> +static const struct snd_soc_dapm_widget sun8i_codec_analog_dapm_widgets[=
] =3D {
> +       /* Mixers */
> +       SOC_MIXER_ARRAY("Left Mixer", SUN8I_ADDA_DAC_PA_SRC,
> +                       SUN8I_ADDA_DAC_PA_SRC_LMIXEN, 0,
> +                       sun8i_codec_mixer_controls),
> +       SOC_MIXER_ARRAY("Right Mixer", SUN8I_ADDA_DAC_PA_SRC,
> +                       SUN8I_ADDA_DAC_PA_SRC_RMIXEN, 0,
> +                       sun8i_codec_mixer_controls),
> +
> +       /* Headphone output path */
> +       SND_SOC_DAPM_MUX("Headphone Source Playback Route",
> +                        SND_SOC_NOPM, 0, 0, sun8i_codec_hp_src),
> +       SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUN8I_ADDA_PAEN_HP_CTRL,
> +                            SUN8I_ADDA_PAEN_HP_CTRL_HPPAEN, 0, NULL, 0),
> +
> +       /* Headphone outputs */
> +       SND_SOC_DAPM_OUTPUT("HP"),
> +
> +};
> +
> +static const struct snd_soc_dapm_route sun8i_codec_analog_dapm_routes[] =
=3D {
> +       /* Left Mixer Routes */
> +       { "Left Mixer", "DAC Playback Switch", "Left DAC" },
> +       { "Left Mixer", "DAC Reversed Left Playback Switch", "Right DAC" =
},
> +
> +       /* Right Mixer Routes */
> +       { "Right Mixer", "DAC Playback Switch", "Right DAC" },
> +       { "Right Mixer", "DAC Reversed Right Playback Switch", "Left DAC"=
 },
> +
> +       /* Headphone Routes */
> +       { "Headphone Source Playback Route", "DAC", "Left DAC" },
> +       { "Headphone Source Playback Route", "DAC", "Right DAC" },
> +       { "Headphone Source Playback Route", "Mixer", "Left Mixer" },
> +       { "Headphone Source Playback Route", "Mixer", "Right Mixer" },
> +       { "Headphone Amp", NULL, "Headphone Source Playback Route" },
> +       { "HP", NULL, "Headphone Amp" },
> +};
> +
> +static const struct snd_soc_component_driver sun8i_codec_analog_cmpnt_dr=
v =3D {
> +       .name                   =3D "sun8i-codec-analog",
> +       .controls               =3D sun8i_analog_widgets,
> +       .num_controls           =3D ARRAY_SIZE(sun8i_analog_widgets),
> +       .dapm_widgets           =3D sun8i_codec_analog_dapm_widgets,
> +       .num_dapm_widgets       =3D ARRAY_SIZE(sun8i_codec_analog_dapm_wi=
dgets),
> +       .dapm_routes            =3D sun8i_codec_analog_dapm_routes,
> +       .num_dapm_routes        =3D ARRAY_SIZE(sun8i_codec_analog_dapm_ro=
utes),
> +};
> +
> +static const struct of_device_id sun8i_codec_analog_of_match[] =3D {
> +       { .compatible =3D "allwinner,sun8i-codec-analog", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, sun8i_codec_analog_of_match);
> +
> +static int sun8i_codec_analog_probe(struct platform_device *pdev)
> +{
> +       struct resource *res;
> +       struct regmap *regmap;
> +       void __iomem *base;
> +
> +       /* Get PRCM resources and registers */
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(base)) {
> +               dev_err(&pdev->dev, "Failed to map PRCM registers\n");
> +               return PTR_ERR(base);
> +       }
> +
> +       regmap =3D devm_regmap_init(&pdev->dev, NULL, base, &adda_pr_regm=
ap_cfg);
> +       if (IS_ERR(regmap)) {
> +               dev_err(&pdev->dev, "Regmap initialisation failed\n");
> +               return PTR_ERR(regmap);
> +       }
> +
> +       return devm_snd_soc_register_component(&pdev->dev,
> +                                              &sun8i_codec_analog_cmpnt_=
drv,
> +                                              NULL, 0);
> +}
> +
> +static struct platform_driver sun8i_codec_analog_driver =3D {
> +       .driver =3D {
> +               .name =3D "sun8i-codec-analog",
> +               .of_match_table =3D sun8i_codec_analog_of_match,
> +       },
> +       .probe =3D sun8i_codec_analog_probe,
> +};
> +module_platform_driver(sun8i_codec_analog_driver);
> +
> +MODULE_DESCRIPTION("Allwinner A31s/A33/A23 codec analog controls driver"=
);
Does the A31s have the prcm for the codec?, as I was under the
impression that it was the same as the A31 and I can't seem to find a
datasheet for that SoC. You could also add H3 and A64 here.
CK
> +MODULE_AUTHOR("Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>");
> +MODULE_AUTHOR("Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTGGXanvQGlWp@public.gmane.org=
m>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:sun8i-codec-analog");
> --
> 2.9.3
>
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
