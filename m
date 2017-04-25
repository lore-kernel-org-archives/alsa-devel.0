From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: Re: Applied "ASoC: Add support for Maxim Integrated
 MAX98927 Amplifier" to the asoc tree
Date: Tue, 25 Apr 2017 09:51:11 -0700
Message-ID: <CAN4-oj=+WuNShte3e27XCWNHVTw6dBTUiQ=dmCLcX6nA9zx1eg@mail.gmail.com>
References: <1490922994-19294-1-git-send-email-ryans.lee@maximintegrated.com>
 <E1cwCZ1-0001o4-Q5@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0090.outbound.protection.outlook.com [104.47.38.90])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B29D266F9D
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 18:51:19 +0200 (CEST)
Received: by mail-oi0-f45.google.com with SMTP id j201so178787470oih.2
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 09:51:16 -0700 (PDT)
In-Reply-To: <E1cwCZ1-0001o4-Q5@debutante>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, romain.perier@collabora.com, bardliao@realtek.com, lars@metafoo.de, Axel Lin <axel.lin@ingics.com>, Paul.Handrigan@cirrus.com, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, nh6z@nh6z.net, robh+dt@kernel.org, ckeepax@opensource.wolfsonmicro.com, Dylan Reid <dgreid@google.com>, oder_chiou@realtek.com, Ryan Lee <ryan.lee.maxim@gmail.com>, KCHSU0@nuvoton.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

'

On Thu, Apr 6, 2017 at 11:55 AM, Mark Brown <broonie@kernel.org> wrote:
> The patch
>
>    ASoC: Add support for Maxim Integrated MAX98927 Amplifier
>
> has been applied to the asoc tree at
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark

I have tried to check MAX98927 driver on linux-next tree and
'git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git' but
have failed.
So I wanted to check the current status of MAX98927 driver.
I'm sorry for top-posting.

>
> From 7c0c2000716e64151b3c0c62026c18f31537ebe9 Mon Sep 17 00:00:00 2001
> From: Ryan Lee <ryans.lee@maximintegrated.com>
> Date: Tue, 4 Apr 2017 02:23:08 +0900
> Subject: [PATCH] ASoC: Add support for Maxim Integrated MAX98927 Amplifier
>
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  .../devicetree/bindings/sound/max98925.txt         |  22 -
>  .../devicetree/bindings/sound/max98926.txt         |  32 -
>  .../devicetree/bindings/sound/max9892x.txt         |  41 +
>  sound/soc/codecs/Kconfig                           |   5 +
>  sound/soc/codecs/Makefile                          |   2 +
>  sound/soc/codecs/max98927.c                        | 841 +++++++++++++++++++++
>  sound/soc/codecs/max98927.h                        | 272 +++++++
>  7 files changed, 1161 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/max98925.txt
>  delete mode 100644 Documentation/devicetree/bindings/sound/max98926.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/max9892x.txt
>  create mode 100644 sound/soc/codecs/max98927.c
>  create mode 100644 sound/soc/codecs/max98927.h
>
> diff --git a/Documentation/devicetree/bindings/sound/max98925.txt b/Documentation/devicetree/bindings/sound/max98925.txt
> deleted file mode 100644
> index 27be63e2aa0d..000000000000
> --- a/Documentation/devicetree/bindings/sound/max98925.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -max98925 audio CODEC
> -
> -This device supports I2C.
> -
> -Required properties:
> -
> -  - compatible : "maxim,max98925"
> -
> -  - vmon-slot-no : slot number used to send voltage information
> -
> -  - imon-slot-no : slot number used to send current information
> -
> -  - reg : the I2C address of the device for I2C
> -
> -Example:
> -
> -codec: max98925@1a {
> -       compatible = "maxim,max98925";
> -       vmon-slot-no = <0>;
> -       imon-slot-no = <2>;
> -       reg = <0x1a>;
> -};
> diff --git a/Documentation/devicetree/bindings/sound/max98926.txt b/Documentation/devicetree/bindings/sound/max98926.txt
> deleted file mode 100644
> index 0b7f4e4d5f9a..000000000000
> --- a/Documentation/devicetree/bindings/sound/max98926.txt
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -max98926 audio CODEC
> -
> -This device supports I2C.
> -
> -Required properties:
> -
> -  - compatible : "maxim,max98926"
> -
> -  - vmon-slot-no : slot number used to send voltage information
> -                   or in inteleave mode this will be used as
> -                   interleave slot.
> -
> -  - imon-slot-no : slot number used to send current information
> -
> -  - interleave-mode : When using two MAX98926 in a system it is
> -                      possible to create ADC data that that will
> -                      overflow the frame size. Digital Audio Interleave
> -                      mode provides a means to output VMON and IMON data
> -                      from two devices on a single DOUT line when running
> -                      smaller frames sizes such as 32 BCLKS per LRCLK or
> -                      48 BCLKS per LRCLK.
> -
> -  - reg : the I2C address of the device for I2C
> -
> -Example:
> -
> -codec: max98926@1a {
> -   compatible = "maxim,max98926";
> -   vmon-slot-no = <0>;
> -   imon-slot-no = <2>;
> -   reg = <0x1a>;
> -};
> diff --git a/Documentation/devicetree/bindings/sound/max9892x.txt b/Documentation/devicetree/bindings/sound/max9892x.txt
> new file mode 100644
> index 000000000000..f6171591ddc6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/max9892x.txt
> @@ -0,0 +1,41 @@
> +Maxim Integrated MAX98925/MAX98926/MAX98927 Speaker Amplifier
> +
> +This device supports I2C.
> +
> +Required properties:
> +
> +  - compatible : should be one of the following
> +    - "maxim,max98925"
> +    - "maxim,max98926"
> +    - "maxim,max98927"
> +
> +  - vmon-slot-no : slot number used to send voltage information
> +                   or in inteleave mode this will be used as
> +                   interleave slot.
> +                   MAX98925/MAX98926 slot range : 0 ~ 30,  Default : 0
> +                   MAX98927 slot range : 0 ~ 15,  Default : 0
> +
> +  - imon-slot-no : slot number used to send current information
> +                   MAX98925/MAX98926 slot range : 0 ~ 30,  Default : 0
> +                   MAX98927 slot range : 0 ~ 15,  Default : 0
> +
> +  - interleave-mode : When using two MAX9892X in a system it is
> +                   possible to create ADC data that that will
> +                   overflow the frame size. Digital Audio Interleave
> +                   mode provides a means to output VMON and IMON data
> +                   from two devices on a single DOUT line when running
> +                   smaller frames sizes such as 32 BCLKS per LRCLK or
> +                   48 BCLKS per LRCLK.
> +                   Range : 0 (off), 1 (on),  Default : 0
> +
> +  - reg : the I2C address of the device for I2C
> +
> +Example:
> +
> +codec: max98927@3a {
> +   compatible = "maxim,max98927";
> +   vmon-slot-no = <0>;
> +   imon-slot-no = <1>;
> +   interleave-mode = <0>;
> +   reg = <0x3a>;
> +};
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 9e1718a8cb1c..65e31ab88280 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -89,6 +89,7 @@ config SND_SOC_ALL_CODECS
>         select SND_SOC_MAX9867 if I2C
>         select SND_SOC_MAX98925 if I2C
>         select SND_SOC_MAX98926 if I2C
> +       select SND_SOC_MAX98927 if I2C
>         select SND_SOC_MAX9850 if I2C
>         select SND_SOC_MAX9860 if I2C
>         select SND_SOC_MAX9768 if I2C
> @@ -585,6 +586,10 @@ config SND_SOC_MAX98925
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
> index 7e1dad79610b..64656c43200c 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -84,6 +84,7 @@ snd-soc-max98371-objs := max98371.o
>  snd-soc-max9867-objs := max9867.o
>  snd-soc-max98925-objs := max98925.o
>  snd-soc-max98926-objs := max98926.o
> +snd-soc-max98927-objs := max98927.o
>  snd-soc-max9850-objs := max9850.o
>  snd-soc-max9860-objs := max9860.o
>  snd-soc-mc13783-objs := mc13783.o
> @@ -312,6 +313,7 @@ obj-$(CONFIG_SND_SOC_MAX98357A)     += snd-soc-max98357a.o
>  obj-$(CONFIG_SND_SOC_MAX9867)  += snd-soc-max9867.o
>  obj-$(CONFIG_SND_SOC_MAX98925) += snd-soc-max98925.o
>  obj-$(CONFIG_SND_SOC_MAX98926) += snd-soc-max98926.o
> +obj-$(CONFIG_SND_SOC_MAX98927) += snd-soc-max98927.o
>  obj-$(CONFIG_SND_SOC_MAX9850)  += snd-soc-max9850.o
>  obj-$(CONFIG_SND_SOC_MAX9860)  += snd-soc-max9860.o
>  obj-$(CONFIG_SND_SOC_MC13783)  += snd-soc-mc13783.o
> diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
> new file mode 100644
> index 000000000000..b5ee29499e16
> --- /dev/null
> +++ b/sound/soc/codecs/max98927.c
> @@ -0,0 +1,841 @@
> +/*
> + * max98927.c  --  MAX98927 ALSA Soc Audio driver
> + *
> + * Copyright (C) 2016 Maxim Integrated Products
> + * Author: Ryan Lee <ryans.lee@maximintegrated.com>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + */
> +
> +#include <linux/acpi.h>
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
> +static struct reg_default max98927_reg[] = {
> +       {MAX98927_R0001_INT_RAW1,  0x00},
> +       {MAX98927_R0002_INT_RAW2,  0x00},
> +       {MAX98927_R0003_INT_RAW3,  0x00},
> +       {MAX98927_R0004_INT_STATE1,  0x00},
> +       {MAX98927_R0005_INT_STATE2,  0x00},
> +       {MAX98927_R0006_INT_STATE3,  0x00},
> +       {MAX98927_R0007_INT_FLAG1,  0x00},
> +       {MAX98927_R0008_INT_FLAG2,  0x00},
> +       {MAX98927_R0009_INT_FLAG3,  0x00},
> +       {MAX98927_R000A_INT_EN1,  0x00},
> +       {MAX98927_R000B_INT_EN2,  0x00},
> +       {MAX98927_R000C_INT_EN3,  0x00},
> +       {MAX98927_R000D_INT_FLAG_CLR1,  0x00},
> +       {MAX98927_R000E_INT_FLAG_CLR2,  0x00},
> +       {MAX98927_R000F_INT_FLAG_CLR3,  0x00},
> +       {MAX98927_R0010_IRQ_CTRL,  0x00},
> +       {MAX98927_R0011_CLK_MON,  0x00},
> +       {MAX98927_R0012_WDOG_CTRL,  0x00},
> +       {MAX98927_R0013_WDOG_RST,  0x00},
> +       {MAX98927_R0014_MEAS_ADC_THERM_WARN_THRESH,  0x00},
> +       {MAX98927_R0015_MEAS_ADC_THERM_SHDN_THRESH,  0x00},
> +       {MAX98927_R0016_MEAS_ADC_THERM_HYSTERESIS,  0x00},
> +       {MAX98927_R0017_PIN_CFG,  0x55},
> +       {MAX98927_R0018_PCM_RX_EN_A,  0x00},
> +       {MAX98927_R0019_PCM_RX_EN_B,  0x00},
> +       {MAX98927_R001A_PCM_TX_EN_A,  0x00},
> +       {MAX98927_R001B_PCM_TX_EN_B,  0x00},
> +       {MAX98927_R001C_PCM_TX_HIZ_CTRL_A,  0x00},
> +       {MAX98927_R001D_PCM_TX_HIZ_CTRL_B,  0x00},
> +       {MAX98927_R001E_PCM_TX_CH_SRC_A,  0x00},
> +       {MAX98927_R001F_PCM_TX_CH_SRC_B,  0x00},
> +       {MAX98927_R0020_PCM_MODE_CFG,  0x40},
> +       {MAX98927_R0021_PCM_MASTER_MODE,  0x00},
> +       {MAX98927_R0022_PCM_CLK_SETUP,  0x22},
> +       {MAX98927_R0023_PCM_SR_SETUP1,  0x00},
> +       {MAX98927_R0024_PCM_SR_SETUP2,  0x00},
> +       {MAX98927_R0025_PCM_TO_SPK_MONOMIX_A,  0x00},
> +       {MAX98927_R0026_PCM_TO_SPK_MONOMIX_B,  0x00},
> +       {MAX98927_R0027_ICC_RX_EN_A,  0x00},
> +       {MAX98927_R0028_ICC_RX_EN_B,  0x00},
> +       {MAX98927_R002B_ICC_TX_EN_A,  0x00},
> +       {MAX98927_R002C_ICC_TX_EN_B,  0x00},
> +       {MAX98927_R002E_ICC_HIZ_MANUAL_MODE,  0x00},
> +       {MAX98927_R002F_ICC_TX_HIZ_EN_A,  0x00},
> +       {MAX98927_R0030_ICC_TX_HIZ_EN_B,  0x00},
> +       {MAX98927_R0031_ICC_LNK_EN,  0x00},
> +       {MAX98927_R0032_PDM_TX_EN,  0x00},
> +       {MAX98927_R0033_PDM_TX_HIZ_CTRL,  0x00},
> +       {MAX98927_R0034_PDM_TX_CTRL,  0x00},
> +       {MAX98927_R0035_PDM_RX_CTRL,  0x00},
> +       {MAX98927_R0036_AMP_VOL_CTRL,  0x00},
> +       {MAX98927_R0037_AMP_DSP_CFG,  0x02},
> +       {MAX98927_R0038_TONE_GEN_DC_CFG,  0x00},
> +       {MAX98927_R0039_DRE_CTRL,  0x01},
> +       {MAX98927_R003A_AMP_EN,  0x00},
> +       {MAX98927_R003B_SPK_SRC_SEL,  0x00},
> +       {MAX98927_R003C_SPK_GAIN,  0x00},
> +       {MAX98927_R003D_SSM_CFG,  0x01},
> +       {MAX98927_R003E_MEAS_EN,  0x00},
> +       {MAX98927_R003F_MEAS_DSP_CFG,  0x04},
> +       {MAX98927_R0040_BOOST_CTRL0,  0x00},
> +       {MAX98927_R0041_BOOST_CTRL3,  0x00},
> +       {MAX98927_R0042_BOOST_CTRL1,  0x00},
> +       {MAX98927_R0043_MEAS_ADC_CFG,  0x00},
> +       {MAX98927_R0044_MEAS_ADC_BASE_MSB,  0x00},
> +       {MAX98927_R0045_MEAS_ADC_BASE_LSB,  0x00},
> +       {MAX98927_R0046_ADC_CH0_DIVIDE,  0x00},
> +       {MAX98927_R0047_ADC_CH1_DIVIDE,  0x00},
> +       {MAX98927_R0048_ADC_CH2_DIVIDE,  0x00},
> +       {MAX98927_R0049_ADC_CH0_FILT_CFG,  0x00},
> +       {MAX98927_R004A_ADC_CH1_FILT_CFG,  0x00},
> +       {MAX98927_R004B_ADC_CH2_FILT_CFG,  0x00},
> +       {MAX98927_R004C_MEAS_ADC_CH0_READ,  0x00},
> +       {MAX98927_R004D_MEAS_ADC_CH1_READ,  0x00},
> +       {MAX98927_R004E_MEAS_ADC_CH2_READ,  0x00},
> +       {MAX98927_R0051_BROWNOUT_STATUS,  0x00},
> +       {MAX98927_R0052_BROWNOUT_EN,  0x00},
> +       {MAX98927_R0053_BROWNOUT_INFINITE_HOLD,  0x00},
> +       {MAX98927_R0054_BROWNOUT_INFINITE_HOLD_CLR,  0x00},
> +       {MAX98927_R0055_BROWNOUT_LVL_HOLD,  0x00},
> +       {MAX98927_R005A_BROWNOUT_LVL1_THRESH,  0x00},
> +       {MAX98927_R005B_BROWNOUT_LVL2_THRESH,  0x00},
> +       {MAX98927_R005C_BROWNOUT_LVL3_THRESH,  0x00},
> +       {MAX98927_R005D_BROWNOUT_LVL4_THRESH,  0x00},
> +       {MAX98927_R005E_BROWNOUT_THRESH_HYSTERYSIS,  0x00},
> +       {MAX98927_R005F_BROWNOUT_AMP_LIMITER_ATK_REL,  0x00},
> +       {MAX98927_R0060_BROWNOUT_AMP_GAIN_ATK_REL,  0x00},
> +       {MAX98927_R0061_BROWNOUT_AMP1_CLIP_MODE,  0x00},
> +       {MAX98927_R0072_BROWNOUT_LVL1_CUR_LIMIT,  0x00},
> +       {MAX98927_R0073_BROWNOUT_LVL1_AMP1_CTRL1,  0x00},
> +       {MAX98927_R0074_BROWNOUT_LVL1_AMP1_CTRL2,  0x00},
> +       {MAX98927_R0075_BROWNOUT_LVL1_AMP1_CTRL3,  0x00},
> +       {MAX98927_R0076_BROWNOUT_LVL2_CUR_LIMIT,  0x00},
> +       {MAX98927_R0077_BROWNOUT_LVL2_AMP1_CTRL1,  0x00},
> +       {MAX98927_R0078_BROWNOUT_LVL2_AMP1_CTRL2,  0x00},
> +       {MAX98927_R0079_BROWNOUT_LVL2_AMP1_CTRL3,  0x00},
> +       {MAX98927_R007A_BROWNOUT_LVL3_CUR_LIMIT,  0x00},
> +       {MAX98927_R007B_BROWNOUT_LVL3_AMP1_CTRL1,  0x00},
> +       {MAX98927_R007C_BROWNOUT_LVL3_AMP1_CTRL2,  0x00},
> +       {MAX98927_R007D_BROWNOUT_LVL3_AMP1_CTRL3,  0x00},
> +       {MAX98927_R007E_BROWNOUT_LVL4_CUR_LIMIT,  0x00},
> +       {MAX98927_R007F_BROWNOUT_LVL4_AMP1_CTRL1,  0x00},
> +       {MAX98927_R0080_BROWNOUT_LVL4_AMP1_CTRL2,  0x00},
> +       {MAX98927_R0081_BROWNOUT_LVL4_AMP1_CTRL3,  0x00},
> +       {MAX98927_R0082_ENV_TRACK_VOUT_HEADROOM,  0x00},
> +       {MAX98927_R0083_ENV_TRACK_BOOST_VOUT_DELAY,  0x00},
> +       {MAX98927_R0084_ENV_TRACK_REL_RATE,  0x00},
> +       {MAX98927_R0085_ENV_TRACK_HOLD_RATE,  0x00},
> +       {MAX98927_R0086_ENV_TRACK_CTRL,  0x00},
> +       {MAX98927_R0087_ENV_TRACK_BOOST_VOUT_READ,  0x00},
> +       {MAX98927_R00FF_GLOBAL_SHDN,  0x00},
> +       {MAX98927_R0100_SOFT_RESET,  0x00},
> +       {MAX98927_R01FF_REV_ID,  0x40},
> +};
> +
> +static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
> +{
> +       struct snd_soc_codec *codec = codec_dai->codec;
> +       struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +       unsigned int mode = 0;
> +       unsigned int format = 0;
> +       unsigned int invert = 0;
> +
> +       dev_dbg(codec->dev, "%s: fmt 0x%08X\n", __func__, fmt);
> +
> +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +       case SND_SOC_DAIFMT_CBS_CFS:
> +               mode = MAX98927_PCM_MASTER_MODE_SLAVE;
> +               break;
> +       case SND_SOC_DAIFMT_CBM_CFM:
> +               max98927->master = true;
> +               mode = MAX98927_PCM_MASTER_MODE_MASTER;
> +               break;
> +       default:
> +               dev_err(codec->dev, "DAI clock mode unsupported");
> +               return -EINVAL;
> +       }
> +
> +       regmap_update_bits(max98927->regmap,
> +               MAX98927_R0021_PCM_MASTER_MODE,
> +               MAX98927_PCM_MASTER_MODE_MASK,
> +               mode);
> +
> +       switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +       case SND_SOC_DAIFMT_NB_NF:
> +               break;
> +       case SND_SOC_DAIFMT_IB_NF:
> +               invert = MAX98927_PCM_MODE_CFG_PCM_BCLKEDGE;
> +               break;
> +       default:
> +               dev_err(codec->dev, "DAI invert mode unsupported");
> +               return -EINVAL;
> +       }
> +
> +       regmap_update_bits(max98927->regmap,
> +               MAX98927_R0020_PCM_MODE_CFG,
> +               MAX98927_PCM_MODE_CFG_PCM_BCLKEDGE,
> +               invert);
> +
> +       /* interface format */
> +       switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +       case SND_SOC_DAIFMT_I2S:
> +               max98927->iface |= SND_SOC_DAIFMT_I2S;
> +               format = MAX98927_PCM_FORMAT_I2S;
> +               break;
> +       case SND_SOC_DAIFMT_LEFT_J:
> +               max98927->iface |= SND_SOC_DAIFMT_LEFT_J;
> +               format = MAX98927_PCM_FORMAT_LJ;
> +               break;
> +       case SND_SOC_DAIFMT_PDM:
> +               max98927->iface |= SND_SOC_DAIFMT_PDM;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       /* pcm channel configuration */
> +       if (max98927->iface & (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J)) {
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R0018_PCM_RX_EN_A,
> +                       MAX98927_PCM_RX_CH0_EN | MAX98927_PCM_RX_CH1_EN,
> +                       MAX98927_PCM_RX_CH0_EN | MAX98927_PCM_RX_CH1_EN);
> +
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R0020_PCM_MODE_CFG,
> +                       MAX98927_PCM_MODE_CFG_FORMAT_MASK,
> +                       format << MAX98927_PCM_MODE_CFG_FORMAT_SHIFT);
> +
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R003B_SPK_SRC_SEL,
> +                       MAX98927_SPK_SRC_MASK, 0);
> +
> +       } else
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R0018_PCM_RX_EN_A,
> +                       MAX98927_PCM_RX_CH0_EN | MAX98927_PCM_RX_CH1_EN, 0);
> +
> +       /* pdm channel configuration */
> +       if (max98927->iface & SND_SOC_DAIFMT_PDM) {
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R0035_PDM_RX_CTRL,
> +                       MAX98927_PDM_RX_EN_MASK, 1);
> +
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R003B_SPK_SRC_SEL,
> +                       MAX98927_SPK_SRC_MASK, 3);
> +       } else
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R0035_PDM_RX_CTRL,
> +                       MAX98927_PDM_RX_EN_MASK, 0);
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
> +       struct snd_soc_codec *codec = max98927->codec;
> +       /* BCLK/LRCLK ratio calculation */
> +       int blr_clk_ratio = params_channels(params) * max98927->ch_size;
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
> +                       dev_err(codec->dev, "failed to find proper clock rate.\n");
> +                       return -EINVAL;
> +               }
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R0021_PCM_MASTER_MODE,
> +                       MAX98927_PCM_MASTER_MODE_MCLK_MASK,
> +                       i << MAX98927_PCM_MASTER_MODE_MCLK_RATE_SHIFT);
> +       }
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
> +       regmap_update_bits(max98927->regmap,
> +               MAX98927_R0022_PCM_CLK_SETUP,
> +               MAX98927_PCM_CLK_SETUP_BSEL_MASK,
> +               value);
> +       return 0;
> +}
> +
> +static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
> +       struct snd_pcm_hw_params *params,
> +       struct snd_soc_dai *dai)
> +{
> +       struct snd_soc_codec *codec = dai->codec;
> +       struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +       unsigned int sampling_rate = 0;
> +       unsigned int chan_sz = 0;
> +
> +       /* pcm mode configuration */
> +       switch (snd_pcm_format_width(params_format(params))) {
> +       case 16:
> +               chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_16;
> +               break;
> +       case 24:
> +               chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_24;
> +               break;
> +       case 32:
> +               chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_32;
> +               break;
> +       default:
> +               dev_err(codec->dev, "format unsupported %d",
> +                       params_format(params));
> +               goto err;
> +       }
> +
> +       max98927->ch_size = snd_pcm_format_width(params_format(params));
> +
> +       regmap_update_bits(max98927->regmap,
> +               MAX98927_R0020_PCM_MODE_CFG,
> +               MAX98927_PCM_MODE_CFG_CHANSZ_MASK, chan_sz);
> +
> +       dev_dbg(codec->dev, "format supported %d",
> +               params_format(params));
> +
> +       /* sampling rate configuration */
> +       switch (params_rate(params)) {
> +       case 8000:
> +               sampling_rate = MAX98927_PCM_SR_SET1_SR_8000;
> +               break;
> +       case 11025:
> +               sampling_rate = MAX98927_PCM_SR_SET1_SR_11025;
> +               break;
> +       case 12000:
> +               sampling_rate = MAX98927_PCM_SR_SET1_SR_12000;
> +               break;
> +       case 16000:
> +               sampling_rate = MAX98927_PCM_SR_SET1_SR_16000;
> +               break;
> +       case 22050:
> +               sampling_rate = MAX98927_PCM_SR_SET1_SR_22050;
> +               break;
> +       case 24000:
> +               sampling_rate = MAX98927_PCM_SR_SET1_SR_24000;
> +               break;
> +       case 32000:
> +               sampling_rate = MAX98927_PCM_SR_SET1_SR_32000;
> +               break;
> +       case 44100:
> +               sampling_rate = MAX98927_PCM_SR_SET1_SR_44100;
> +               break;
> +       case 48000:
> +               sampling_rate = MAX98927_PCM_SR_SET1_SR_48000;
> +               break;
> +       default:
> +               dev_err(codec->dev, "rate %d not supported\n",
> +                       params_rate(params));
> +               goto err;
> +       }
> +       /* set DAI_SR to correct LRCLK frequency */
> +       regmap_update_bits(max98927->regmap,
> +               MAX98927_R0023_PCM_SR_SETUP1,
> +               MAX98927_PCM_SR_SET1_SR_MASK,
> +               sampling_rate);
> +       regmap_update_bits(max98927->regmap,
> +               MAX98927_R0024_PCM_SR_SETUP2,
> +               MAX98927_PCM_SR_SET2_SR_MASK,
> +               sampling_rate << MAX98927_PCM_SR_SET2_SR_SHIFT);
> +
> +       /* set sampling rate of IV */
> +       if (max98927->interleave_mode &&
> +           sampling_rate > MAX98927_PCM_SR_SET1_SR_16000)
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R0024_PCM_SR_SETUP2,
> +                       MAX98927_PCM_SR_SET2_IVADC_SR_MASK,
> +                       sampling_rate - 3);
> +       else
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R0024_PCM_SR_SETUP2,
> +                       MAX98927_PCM_SR_SET2_IVADC_SR_MASK,
> +                       sampling_rate);
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
> +       int clk_id, unsigned int freq, int dir)
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
> +static int max98927_dac_event(struct snd_soc_dapm_widget *w,
> +       struct snd_kcontrol *kcontrol, int event)
> +{
> +       struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
> +       struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
> +
> +       switch (event) {
> +       case SND_SOC_DAPM_POST_PMU:
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R003A_AMP_EN,
> +                       MAX98927_AMP_EN_MASK, 1);
> +               /* enable VMON and IMON */
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R003E_MEAS_EN,
> +                       MAX98927_MEAS_V_EN | MAX98927_MEAS_I_EN,
> +                       MAX98927_MEAS_V_EN | MAX98927_MEAS_I_EN);
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R00FF_GLOBAL_SHDN,
> +                       MAX98927_GLOBAL_EN_MASK, 1);
> +               break;
> +       case SND_SOC_DAPM_POST_PMD:
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R00FF_GLOBAL_SHDN,
> +                       MAX98927_GLOBAL_EN_MASK, 0);
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R003A_AMP_EN,
> +                       MAX98927_AMP_EN_MASK, 0);
> +               /* disable VMON and IMON */
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R003E_MEAS_EN,
> +                       MAX98927_MEAS_V_EN | MAX98927_MEAS_I_EN, 0);
> +               break;
> +       default:
> +               return 0;
> +       }
> +       return 0;
> +}
> +
> +static const char * const max98927_switch_text[] = {
> +       "Left", "Right", "LeftRight"};
> +
> +static const struct soc_enum dai_sel_enum =
> +       SOC_ENUM_SINGLE(MAX98927_R0025_PCM_TO_SPK_MONOMIX_A,
> +               MAX98927_PCM_TO_SPK_MONOMIX_CFG_SHIFT,
> +               3, max98927_switch_text);
> +
> +static const struct snd_kcontrol_new max98927_dai_controls =
> +       SOC_DAPM_ENUM("DAI Sel", dai_sel_enum);
> +
> +static const struct snd_soc_dapm_widget max98927_dapm_widgets[] = {
> +       SND_SOC_DAPM_AIF_IN("DAI_OUT", "HiFi Playback", 0, SND_SOC_NOPM, 0, 0),
> +       SND_SOC_DAPM_DAC_E("Amp Enable", "HiFi Playback", MAX98927_R003A_AMP_EN,
> +               0, 0, max98927_dac_event,
> +               SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
> +       SND_SOC_DAPM_MUX("DAI Sel Mux", SND_SOC_NOPM, 0, 0,
> +               &max98927_dai_controls),
> +       SND_SOC_DAPM_OUTPUT("BE_OUT"),
> +};
> +
> +static DECLARE_TLV_DB_SCALE(max98927_spk_tlv, 300, 300, 0);
> +static DECLARE_TLV_DB_SCALE(max98927_digital_tlv, -1600, 25, 0);
> +
> +static bool max98927_readable_register(struct device *dev, unsigned int reg)
> +{
> +       switch (reg) {
> +       case MAX98927_R0001_INT_RAW1 ... MAX98927_R0028_ICC_RX_EN_B:
> +       case MAX98927_R002B_ICC_TX_EN_A ... MAX98927_R002C_ICC_TX_EN_B:
> +       case MAX98927_R002E_ICC_HIZ_MANUAL_MODE
> +               ... MAX98927_R004E_MEAS_ADC_CH2_READ:
> +       case MAX98927_R0051_BROWNOUT_STATUS
> +               ... MAX98927_R0055_BROWNOUT_LVL_HOLD:
> +       case MAX98927_R005A_BROWNOUT_LVL1_THRESH
> +               ... MAX98927_R0061_BROWNOUT_AMP1_CLIP_MODE:
> +       case MAX98927_R0072_BROWNOUT_LVL1_CUR_LIMIT
> +               ... MAX98927_R0087_ENV_TRACK_BOOST_VOUT_READ:
> +       case MAX98927_R00FF_GLOBAL_SHDN:
> +       case MAX98927_R0100_SOFT_RESET:
> +       case MAX98927_R01FF_REV_ID:
> +               return true;
> +       default:
> +               return false;
> +       }
> +};
> +
> +static bool max98927_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +       switch (reg) {
> +       case MAX98927_R0001_INT_RAW1 ... MAX98927_R0009_INT_FLAG3:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
> +static const char * const max98927_boost_voltage_text[] = {
> +       "6.5V", "6.625V", "6.75V", "6.875V", "7V", "7.125V", "7.25V", "7.375V",
> +       "7.5V", "7.625V", "7.75V", "7.875V", "8V", "8.125V", "8.25V", "8.375V",
> +       "8.5V", "8.625V", "8.75V", "8.875V", "9V", "9.125V", "9.25V", "9.375V",
> +       "9.5V", "9.625V", "9.75V", "9.875V", "10V"
> +};
> +
> +static SOC_ENUM_SINGLE_DECL(max98927_boost_voltage,
> +               MAX98927_R0040_BOOST_CTRL0, 0,
> +               max98927_boost_voltage_text);
> +
> +static const char * const max98927_current_limit_text[] = {
> +       "1.00A", "1.10A", "1.20A", "1.30A", "1.40A", "1.50A", "1.60A", "1.70A",
> +       "1.80A", "1.90A", "2.00A", "2.10A", "2.20A", "2.30A", "2.40A", "2.50A",
> +       "2.60A", "2.70A", "2.80A", "2.90A", "3.00A", "3.10A", "3.20A", "3.30A",
> +       "3.40A", "3.50A", "3.60A", "3.70A", "3.80A", "3.90A", "4.00A", "4.10A"
> +};
> +
> +static SOC_ENUM_SINGLE_DECL(max98927_current_limit,
> +               MAX98927_R0042_BOOST_CTRL1, 1,
> +               max98927_current_limit_text);
> +
> +static const struct snd_kcontrol_new max98927_snd_controls[] = {
> +       SOC_SINGLE_TLV("Speaker Volume", MAX98927_R003C_SPK_GAIN,
> +               0, 6, 0,
> +               max98927_spk_tlv),
> +       SOC_SINGLE_TLV("Digital Volume", MAX98927_R0036_AMP_VOL_CTRL,
> +               0, (1<<MAX98927_AMP_VOL_WIDTH)-1, 0,
> +               max98927_digital_tlv),
> +       SOC_SINGLE("Amp DSP Switch", MAX98927_R0052_BROWNOUT_EN,
> +               MAX98927_BROWNOUT_DSP_SHIFT, 1, 0),
> +       SOC_SINGLE("Ramp Switch", MAX98927_R0037_AMP_DSP_CFG,
> +               MAX98927_AMP_DSP_CFG_RMP_SHIFT, 1, 0),
> +       SOC_SINGLE("DRE Switch", MAX98927_R0039_DRE_CTRL,
> +               MAX98927_DRE_EN_SHIFT, 1, 0),
> +       SOC_SINGLE("Volume Location Switch", MAX98927_R0036_AMP_VOL_CTRL,
> +               MAX98927_AMP_VOL_SEL_SHIFT, 1, 0),
> +       SOC_ENUM("Boost Output Voltage", max98927_boost_voltage),
> +       SOC_ENUM("Current Limit", max98927_current_limit),
> +};
> +
> +static const struct snd_soc_dapm_route max98927_audio_map[] = {
> +       {"Amp Enable", NULL, "DAI_OUT"},
> +       {"DAI Sel Mux", "Left", "Amp Enable"},
> +       {"DAI Sel Mux", "Right", "Amp Enable"},
> +       {"DAI Sel Mux", "LeftRight", "Amp Enable"},
> +       {"BE_OUT", NULL, "DAI Sel Mux"},
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
> +
> +       max98927->codec = codec;
> +       codec->control_data = max98927->regmap;
> +       codec->cache_bypass = 1;
> +
> +       /* Software Reset */
> +       regmap_write(max98927->regmap,
> +               MAX98927_R0100_SOFT_RESET, MAX98927_SOFT_RESET);
> +
> +       /* IV default slot configuration */
> +       regmap_write(max98927->regmap,
> +               MAX98927_R001C_PCM_TX_HIZ_CTRL_A,
> +               0xFF);
> +       regmap_write(max98927->regmap,
> +               MAX98927_R001D_PCM_TX_HIZ_CTRL_B,
> +               0xFF);
> +       regmap_write(max98927->regmap,
> +               MAX98927_R0025_PCM_TO_SPK_MONOMIX_A,
> +               0x80);
> +       regmap_write(max98927->regmap,
> +               MAX98927_R0026_PCM_TO_SPK_MONOMIX_B,
> +               0x1);
> +       /* Set inital volume (+13dB) */
> +       regmap_write(max98927->regmap,
> +               MAX98927_R0036_AMP_VOL_CTRL,
> +               0x38);
> +       regmap_write(max98927->regmap,
> +               MAX98927_R003C_SPK_GAIN,
> +               0x05);
> +       /* Enable DC blocker */
> +       regmap_write(max98927->regmap,
> +               MAX98927_R0037_AMP_DSP_CFG,
> +               0x03);
> +       /* Enable IMON VMON DC blocker */
> +       regmap_write(max98927->regmap,
> +               MAX98927_R003F_MEAS_DSP_CFG,
> +               0xF7);
> +       /* Boost Output Voltage & Current limit */
> +       regmap_write(max98927->regmap,
> +               MAX98927_R0040_BOOST_CTRL0,
> +               0x1C);
> +       regmap_write(max98927->regmap,
> +               MAX98927_R0042_BOOST_CTRL1,
> +               0x3E);
> +       /* Measurement ADC config */
> +       regmap_write(max98927->regmap,
> +               MAX98927_R0043_MEAS_ADC_CFG,
> +               0x04);
> +       regmap_write(max98927->regmap,
> +               MAX98927_R0044_MEAS_ADC_BASE_MSB,
> +               0x00);
> +       regmap_write(max98927->regmap,
> +               MAX98927_R0045_MEAS_ADC_BASE_LSB,
> +               0x24);
> +       /* Brownout Level */
> +       regmap_write(max98927->regmap,
> +               MAX98927_R007F_BROWNOUT_LVL4_AMP1_CTRL1,
> +               0x06);
> +       /* Envelope Tracking configuration */
> +       regmap_write(max98927->regmap,
> +               MAX98927_R0082_ENV_TRACK_VOUT_HEADROOM,
> +               0x08);
> +       regmap_write(max98927->regmap,
> +               MAX98927_R0086_ENV_TRACK_CTRL,
> +               0x01);
> +       regmap_write(max98927->regmap,
> +               MAX98927_R0087_ENV_TRACK_BOOST_VOUT_READ,
> +               0x10);
> +
> +       /* voltage, current slot configuration */
> +       regmap_write(max98927->regmap,
> +               MAX98927_R001E_PCM_TX_CH_SRC_A,
> +               (max98927->i_l_slot<<MAX98927_PCM_TX_CH_SRC_A_I_SHIFT|
> +               max98927->v_l_slot)&0xFF);
> +
> +       if (max98927->v_l_slot < 8) {
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R001C_PCM_TX_HIZ_CTRL_A,
> +                       1 << max98927->v_l_slot, 0);
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R001A_PCM_TX_EN_A,
> +                       1 << max98927->v_l_slot,
> +                       1 << max98927->v_l_slot);
> +       } else {
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R001D_PCM_TX_HIZ_CTRL_B,
> +                       1 << (max98927->v_l_slot - 8), 0);
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R001B_PCM_TX_EN_B,
> +                       1 << (max98927->v_l_slot - 8),
> +                       1 << (max98927->v_l_slot - 8));
> +       }
> +
> +       if (max98927->i_l_slot < 8) {
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R001C_PCM_TX_HIZ_CTRL_A,
> +                       1 << max98927->i_l_slot, 0);
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R001A_PCM_TX_EN_A,
> +                       1 << max98927->i_l_slot,
> +                       1 << max98927->i_l_slot);
> +       } else {
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R001D_PCM_TX_HIZ_CTRL_B,
> +                       1 << (max98927->i_l_slot - 8), 0);
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R001B_PCM_TX_EN_B,
> +                       1 << (max98927->i_l_slot - 8),
> +                       1 << (max98927->i_l_slot - 8));
> +       }
> +
> +       /* Set interleave mode */
> +       if (max98927->interleave_mode)
> +               regmap_update_bits(max98927->regmap,
> +                       MAX98927_R001F_PCM_TX_CH_SRC_B,
> +                       MAX98927_PCM_TX_CH_INTERLEAVE_MASK,
> +                       MAX98927_PCM_TX_CH_INTERLEAVE_MASK);
> +       return 0;
> +}
> +
> +static const struct snd_soc_codec_driver soc_codec_dev_max98927 = {
> +       .probe = max98927_probe,
> +       .component_driver = {
> +               .controls = max98927_snd_controls,
> +               .num_controls = ARRAY_SIZE(max98927_snd_controls),
> +               .dapm_widgets = max98927_dapm_widgets,
> +               .num_dapm_widgets = ARRAY_SIZE(max98927_dapm_widgets),
> +               .dapm_routes = max98927_audio_map,
> +               .num_dapm_routes = ARRAY_SIZE(max98927_audio_map),
> +       },
> +};
> +
> +static const struct regmap_config max98927_regmap = {
> +       .reg_bits         = 16,
> +       .val_bits         = 8,
> +       .max_register     = MAX98927_R01FF_REV_ID,
> +       .reg_defaults     = max98927_reg,
> +       .num_reg_defaults = ARRAY_SIZE(max98927_reg),
> +       .readable_reg     = max98927_readable_register,
> +       .volatile_reg     = max98927_volatile_reg,
> +       .cache_type       = REGCACHE_RBTREE,
> +};
> +
> +static void max98927_slot_config(struct i2c_client *i2c,
> +       struct max98927_priv *max98927)
> +{
> +       int value;
> +
> +       if (!of_property_read_u32(i2c->dev.of_node,
> +               "vmon-slot-no", &value))
> +               max98927->v_l_slot = value & 0xF;
> +       else
> +               max98927->v_l_slot = 0;
> +       if (!of_property_read_u32(i2c->dev.of_node,
> +               "imon-slot-no", &value))
> +               max98927->i_l_slot = value & 0xF;
> +       else
> +               max98927->i_l_slot = 1;
> +}
> +
> +static int max98927_i2c_probe(struct i2c_client *i2c,
> +       const struct i2c_device_id *id)
> +{
> +
> +       int ret = 0, value;
> +       int reg = 0;
> +       struct max98927_priv *max98927 = NULL;
> +
> +       max98927 = devm_kzalloc(&i2c->dev,
> +               sizeof(*max98927), GFP_KERNEL);
> +
> +       if (!max98927) {
> +               ret = -ENOMEM;
> +               return ret;
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
> +       /* regmap initialization */
> +       max98927->regmap
> +               = devm_regmap_init_i2c(i2c, &max98927_regmap);
> +       if (IS_ERR(max98927->regmap)) {
> +               ret = PTR_ERR(max98927->regmap);
> +               dev_err(&i2c->dev,
> +                       "Failed to allocate regmap: %d\n", ret);
> +               return ret;
> +       }
> +
> +       /* Check Revision ID */
> +       ret = regmap_read(max98927->regmap,
> +               MAX98927_R01FF_REV_ID, &reg);
> +       if (ret < 0) {
> +               dev_err(&i2c->dev,
> +                       "Failed to read: 0x%02X\n", MAX98927_R01FF_REV_ID);
> +               return ret;
> +       }
> +       dev_info(&i2c->dev, "MAX98927 revisionID: 0x%02X\n", reg);
> +
> +       /* voltage/current slot configuration */
> +       max98927_slot_config(i2c, max98927);
> +
> +       /* codec registeration */
> +       ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98927,
> +               max98927_dai, ARRAY_SIZE(max98927_dai));
> +       if (ret < 0)
> +               dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
> +
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
> +#if defined(CONFIG_OF)
> +static const struct of_device_id max98927_of_match[] = {
> +       { .compatible = "maxim,max98927", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, max98927_of_match);
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id max98927_acpi_match[] = {
> +       { "MX98927", 0 },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(acpi, max98927_acpi_match);
> +#endif
> +
> +static struct i2c_driver max98927_i2c_driver = {
> +       .driver = {
> +               .name = "max98927",
> +               .of_match_table = of_match_ptr(max98927_of_match),
> +               .acpi_match_table = ACPI_PTR(max98927_acpi_match),
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
> +MODULE_AUTHOR("Ryan Lee <ryans.lee@maximintegrated.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
> new file mode 100644
> index 000000000000..ece6a608cbe1
> --- /dev/null
> +++ b/sound/soc/codecs/max98927.h
> @@ -0,0 +1,272 @@
> +/*
> + * max98927.h  --  MAX98927 ALSA Soc Audio driver
> + *
> + * Copyright 2013-15 Maxim Integrated Products
> + * Author: Ryan Lee <ryans.lee@maximintegrated.com>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + */
> +#ifndef _MAX98927_H
> +#define _MAX98927_H
> +
> +/* Register Values */
> +#define MAX98927_R0001_INT_RAW1 0x0001
> +#define MAX98927_R0002_INT_RAW2 0x0002
> +#define MAX98927_R0003_INT_RAW3 0x0003
> +#define MAX98927_R0004_INT_STATE1 0x0004
> +#define MAX98927_R0005_INT_STATE2 0x0005
> +#define MAX98927_R0006_INT_STATE3 0x0006
> +#define MAX98927_R0007_INT_FLAG1 0x0007
> +#define MAX98927_R0008_INT_FLAG2 0x0008
> +#define MAX98927_R0009_INT_FLAG3 0x0009
> +#define MAX98927_R000A_INT_EN1 0x000A
> +#define MAX98927_R000B_INT_EN2 0x000B
> +#define MAX98927_R000C_INT_EN3 0x000C
> +#define MAX98927_R000D_INT_FLAG_CLR1   0x000D
> +#define MAX98927_R000E_INT_FLAG_CLR2   0x000E
> +#define MAX98927_R000F_INT_FLAG_CLR3   0x000F
> +#define MAX98927_R0010_IRQ_CTRL 0x0010
> +#define MAX98927_R0011_CLK_MON 0x0011
> +#define MAX98927_R0012_WDOG_CTRL 0x0012
> +#define MAX98927_R0013_WDOG_RST 0x0013
> +#define MAX98927_R0014_MEAS_ADC_THERM_WARN_THRESH 0x0014
> +#define MAX98927_R0015_MEAS_ADC_THERM_SHDN_THRESH 0x0015
> +#define MAX98927_R0016_MEAS_ADC_THERM_HYSTERESIS 0x0016
> +#define MAX98927_R0017_PIN_CFG 0x0017
> +#define MAX98927_R0018_PCM_RX_EN_A 0x0018
> +#define MAX98927_R0019_PCM_RX_EN_B 0x0019
> +#define MAX98927_R001A_PCM_TX_EN_A 0x001A
> +#define MAX98927_R001B_PCM_TX_EN_B 0x001B
> +#define MAX98927_R001C_PCM_TX_HIZ_CTRL_A 0x001C
> +#define MAX98927_R001D_PCM_TX_HIZ_CTRL_B 0x001D
> +#define MAX98927_R001E_PCM_TX_CH_SRC_A 0x001E
> +#define MAX98927_R001F_PCM_TX_CH_SRC_B 0x001F
> +#define MAX98927_R0020_PCM_MODE_CFG 0x0020
> +#define MAX98927_R0021_PCM_MASTER_MODE 0x0021
> +#define MAX98927_R0022_PCM_CLK_SETUP 0x0022
> +#define MAX98927_R0023_PCM_SR_SETUP1 0x0023
> +#define MAX98927_R0024_PCM_SR_SETUP2   0x0024
> +#define MAX98927_R0025_PCM_TO_SPK_MONOMIX_A 0x0025
> +#define MAX98927_R0026_PCM_TO_SPK_MONOMIX_B 0x0026
> +#define MAX98927_R0027_ICC_RX_EN_A 0x0027
> +#define MAX98927_R0028_ICC_RX_EN_B 0x0028
> +#define MAX98927_R002B_ICC_TX_EN_A 0x002B
> +#define MAX98927_R002C_ICC_TX_EN_B 0x002C
> +#define MAX98927_R002E_ICC_HIZ_MANUAL_MODE 0x002E
> +#define MAX98927_R002F_ICC_TX_HIZ_EN_A 0x002F
> +#define MAX98927_R0030_ICC_TX_HIZ_EN_B 0x0030
> +#define MAX98927_R0031_ICC_LNK_EN 0x0031
> +#define MAX98927_R0032_PDM_TX_EN 0x0032
> +#define MAX98927_R0033_PDM_TX_HIZ_CTRL 0x0033
> +#define MAX98927_R0034_PDM_TX_CTRL 0x0034
> +#define MAX98927_R0035_PDM_RX_CTRL 0x0035
> +#define MAX98927_R0036_AMP_VOL_CTRL 0x0036
> +#define MAX98927_R0037_AMP_DSP_CFG 0x0037
> +#define MAX98927_R0038_TONE_GEN_DC_CFG 0x0038
> +#define MAX98927_R0039_DRE_CTRL 0x0039
> +#define MAX98927_R003A_AMP_EN 0x003A
> +#define MAX98927_R003B_SPK_SRC_SEL 0x003B
> +#define MAX98927_R003C_SPK_GAIN 0x003C
> +#define MAX98927_R003D_SSM_CFG 0x003D
> +#define MAX98927_R003E_MEAS_EN 0x003E
> +#define MAX98927_R003F_MEAS_DSP_CFG 0x003F
> +#define MAX98927_R0040_BOOST_CTRL0 0x0040
> +#define MAX98927_R0041_BOOST_CTRL3 0x0041
> +#define MAX98927_R0042_BOOST_CTRL1 0x0042
> +#define MAX98927_R0043_MEAS_ADC_CFG 0x0043
> +#define MAX98927_R0044_MEAS_ADC_BASE_MSB 0x0044
> +#define MAX98927_R0045_MEAS_ADC_BASE_LSB 0x0045
> +#define MAX98927_R0046_ADC_CH0_DIVIDE 0x0046
> +#define MAX98927_R0047_ADC_CH1_DIVIDE 0x0047
> +#define MAX98927_R0048_ADC_CH2_DIVIDE 0x0048
> +#define MAX98927_R0049_ADC_CH0_FILT_CFG 0x0049
> +#define MAX98927_R004A_ADC_CH1_FILT_CFG 0x004A
> +#define MAX98927_R004B_ADC_CH2_FILT_CFG 0x004B
> +#define MAX98927_R004C_MEAS_ADC_CH0_READ 0x004C
> +#define MAX98927_R004D_MEAS_ADC_CH1_READ 0x004D
> +#define MAX98927_R004E_MEAS_ADC_CH2_READ 0x004E
> +#define MAX98927_R0051_BROWNOUT_STATUS 0x0051
> +#define MAX98927_R0052_BROWNOUT_EN 0x0052
> +#define MAX98927_R0053_BROWNOUT_INFINITE_HOLD 0x0053
> +#define MAX98927_R0054_BROWNOUT_INFINITE_HOLD_CLR 0x0054
> +#define MAX98927_R0055_BROWNOUT_LVL_HOLD 0x0055
> +#define MAX98927_R005A_BROWNOUT_LVL1_THRESH 0x005A
> +#define MAX98927_R005B_BROWNOUT_LVL2_THRESH 0x005B
> +#define MAX98927_R005C_BROWNOUT_LVL3_THRESH 0x005C
> +#define MAX98927_R005D_BROWNOUT_LVL4_THRESH 0x005D
> +#define MAX98927_R005E_BROWNOUT_THRESH_HYSTERYSIS 0x005E
> +#define MAX98927_R005F_BROWNOUT_AMP_LIMITER_ATK_REL 0x005F
> +#define MAX98927_R0060_BROWNOUT_AMP_GAIN_ATK_REL 0x0060
> +#define MAX98927_R0061_BROWNOUT_AMP1_CLIP_MODE 0x0061
> +#define MAX98927_R0072_BROWNOUT_LVL1_CUR_LIMIT 0x0072
> +#define MAX98927_R0073_BROWNOUT_LVL1_AMP1_CTRL1 0x0073
> +#define MAX98927_R0074_BROWNOUT_LVL1_AMP1_CTRL2 0x0074
> +#define MAX98927_R0075_BROWNOUT_LVL1_AMP1_CTRL3 0x0075
> +#define MAX98927_R0076_BROWNOUT_LVL2_CUR_LIMIT 0x0076
> +#define MAX98927_R0077_BROWNOUT_LVL2_AMP1_CTRL1 0x0077
> +#define MAX98927_R0078_BROWNOUT_LVL2_AMP1_CTRL2 0x0078
> +#define MAX98927_R0079_BROWNOUT_LVL2_AMP1_CTRL3 0x0079
> +#define MAX98927_R007A_BROWNOUT_LVL3_CUR_LIMIT 0x007A
> +#define MAX98927_R007B_BROWNOUT_LVL3_AMP1_CTRL1 0x007B
> +#define MAX98927_R007C_BROWNOUT_LVL3_AMP1_CTRL2 0x007C
> +#define MAX98927_R007D_BROWNOUT_LVL3_AMP1_CTRL3 0x007D
> +#define MAX98927_R007E_BROWNOUT_LVL4_CUR_LIMIT 0x007E
> +#define MAX98927_R007F_BROWNOUT_LVL4_AMP1_CTRL1 0x007F
> +#define MAX98927_R0080_BROWNOUT_LVL4_AMP1_CTRL2 0x0080
> +#define MAX98927_R0081_BROWNOUT_LVL4_AMP1_CTRL3 0x0081
> +#define MAX98927_R0082_ENV_TRACK_VOUT_HEADROOM 0x0082
> +#define MAX98927_R0083_ENV_TRACK_BOOST_VOUT_DELAY 0x0083
> +#define MAX98927_R0084_ENV_TRACK_REL_RATE 0x0084
> +#define MAX98927_R0085_ENV_TRACK_HOLD_RATE 0x0085
> +#define MAX98927_R0086_ENV_TRACK_CTRL 0x0086
> +#define MAX98927_R0087_ENV_TRACK_BOOST_VOUT_READ 0x0087
> +#define MAX98927_R00FF_GLOBAL_SHDN 0x00FF
> +#define MAX98927_R0100_SOFT_RESET 0x0100
> +#define MAX98927_R01FF_REV_ID 0x01FF
> +
> +/* MAX98927_R0018_PCM_RX_EN_A */
> +#define MAX98927_PCM_RX_CH0_EN (0x1 << 0)
> +#define MAX98927_PCM_RX_CH1_EN (0x1 << 1)
> +#define MAX98927_PCM_RX_CH2_EN (0x1 << 2)
> +#define MAX98927_PCM_RX_CH3_EN (0x1 << 3)
> +#define MAX98927_PCM_RX_CH4_EN (0x1 << 4)
> +#define MAX98927_PCM_RX_CH5_EN (0x1 << 5)
> +#define MAX98927_PCM_RX_CH6_EN (0x1 << 6)
> +#define MAX98927_PCM_RX_CH7_EN (0x1 << 7)
> +
> +/* MAX98927_R001A_PCM_TX_EN_A */
> +#define MAX98927_PCM_TX_CH0_EN (0x1 << 0)
> +#define MAX98927_PCM_TX_CH1_EN (0x1 << 1)
> +#define MAX98927_PCM_TX_CH2_EN (0x1 << 2)
> +#define MAX98927_PCM_TX_CH3_EN (0x1 << 3)
> +#define MAX98927_PCM_TX_CH4_EN (0x1 << 4)
> +#define MAX98927_PCM_TX_CH5_EN (0x1 << 5)
> +#define MAX98927_PCM_TX_CH6_EN (0x1 << 6)
> +#define MAX98927_PCM_TX_CH7_EN (0x1 << 7)
> +
> +/* MAX98927_R001E_PCM_TX_CH_SRC_A */
> +#define MAX98927_PCM_TX_CH_SRC_A_V_SHIFT (0)
> +#define MAX98927_PCM_TX_CH_SRC_A_I_SHIFT (4)
> +
> +/* MAX98927_R001F_PCM_TX_CH_SRC_B */
> +#define MAX98927_PCM_TX_CH_INTERLEAVE_MASK (0x1 << 5)
> +
> +/* MAX98927_R0020_PCM_MODE_CFG */
> +#define MAX98927_PCM_MODE_CFG_PCM_BCLKEDGE (0x1 << 2)
> +#define MAX98927_PCM_MODE_CFG_FORMAT_MASK (0x7 << 3)
> +#define MAX98927_PCM_MODE_CFG_FORMAT_SHIFT (3)
> +#define MAX98927_PCM_FORMAT_I2S (0x0 << 0)
> +#define MAX98927_PCM_FORMAT_LJ (0x1 << 0)
> +
> +#define MAX98927_PCM_MODE_CFG_CHANSZ_MASK (0x3 << 6)
> +#define MAX98927_PCM_MODE_CFG_CHANSZ_16 (0x1 << 6)
> +#define MAX98927_PCM_MODE_CFG_CHANSZ_24 (0x2 << 6)
> +#define MAX98927_PCM_MODE_CFG_CHANSZ_32 (0x3 << 6)
> +
> +/* MAX98927_R0021_PCM_MASTER_MODE */
> +#define MAX98927_PCM_MASTER_MODE_MASK (0x3 << 0)
> +#define MAX98927_PCM_MASTER_MODE_SLAVE (0x0 << 0)
> +#define MAX98927_PCM_MASTER_MODE_MASTER (0x3 << 0)
> +
> +#define MAX98927_PCM_MASTER_MODE_MCLK_MASK (0xF << 2)
> +#define MAX98927_PCM_MASTER_MODE_MCLK_RATE_SHIFT (2)
> +
> +/* MAX98927_R0022_PCM_CLK_SETUP */
> +#define MAX98927_PCM_CLK_SETUP_BSEL_MASK (0xF << 0)
> +
> +/* MAX98927_R0023_PCM_SR_SETUP1 */
> +#define MAX98927_PCM_SR_SET1_SR_MASK (0xF << 0)
> +
> +#define MAX98927_PCM_SR_SET1_SR_8000 (0x0 << 0)
> +#define MAX98927_PCM_SR_SET1_SR_11025 (0x1 << 0)
> +#define MAX98927_PCM_SR_SET1_SR_12000 (0x2 << 0)
> +#define MAX98927_PCM_SR_SET1_SR_16000 (0x3 << 0)
> +#define MAX98927_PCM_SR_SET1_SR_22050 (0x4 << 0)
> +#define MAX98927_PCM_SR_SET1_SR_24000 (0x5 << 0)
> +#define MAX98927_PCM_SR_SET1_SR_32000 (0x6 << 0)
> +#define MAX98927_PCM_SR_SET1_SR_44100 (0x7 << 0)
> +#define MAX98927_PCM_SR_SET1_SR_48000 (0x8 << 0)
> +
> +/* MAX98927_R0024_PCM_SR_SETUP2 */
> +#define MAX98927_PCM_SR_SET2_SR_MASK (0xF << 4)
> +#define MAX98927_PCM_SR_SET2_SR_SHIFT (4)
> +#define MAX98927_PCM_SR_SET2_IVADC_SR_MASK (0xf << 0)
> +
> +/* MAX98927_R0025_PCM_TO_SPK_MONOMIX_A */
> +#define MAX98927_PCM_TO_SPK_MONOMIX_CFG_MASK (0x3 << 6)
> +#define MAX98927_PCM_TO_SPK_MONOMIX_CFG_SHIFT (6)
> +
> +/* MAX98927_R0035_PDM_RX_CTRL */
> +#define MAX98927_PDM_RX_EN_MASK (0x1 << 0)
> +
> +/* MAX98927_R0036_AMP_VOL_CTRL */
> +#define MAX98927_AMP_VOL_SEL (0x1 << 7)
> +#define MAX98927_AMP_VOL_SEL_WIDTH (1)
> +#define MAX98927_AMP_VOL_SEL_SHIFT (7)
> +#define MAX98927_AMP_VOL_MASK (0x7f << 0)
> +#define MAX98927_AMP_VOL_WIDTH (7)
> +#define MAX98927_AMP_VOL_SHIFT (0)
> +
> +/* MAX98927_R0037_AMP_DSP_CFG */
> +#define MAX98927_AMP_DSP_CFG_DCBLK_EN (0x1 << 0)
> +#define MAX98927_AMP_DSP_CFG_DITH_EN (0x1 << 1)
> +#define MAX98927_AMP_DSP_CFG_RMP_BYPASS (0x1 << 4)
> +#define MAX98927_AMP_DSP_CFG_DAC_INV (0x1 << 5)
> +#define MAX98927_AMP_DSP_CFG_RMP_SHIFT (4)
> +
> +/* MAX98927_R0039_DRE_CTRL */
> +#define MAX98927_DRE_CTRL_DRE_EN       (0x1 << 0)
> +#define MAX98927_DRE_EN_SHIFT 0x1
> +
> +/* MAX98927_R003A_AMP_EN */
> +#define MAX98927_AMP_EN_MASK (0x1 << 0)
> +
> +/* MAX98927_R003B_SPK_SRC_SEL */
> +#define MAX98927_SPK_SRC_MASK (0x3 << 0)
> +
> +/* MAX98927_R003C_SPK_GAIN */
> +#define MAX98927_SPK_PCM_GAIN_MASK (0x7 << 0)
> +#define MAX98927_SPK_PDM_GAIN_MASK (0x7 << 4)
> +#define MAX98927_SPK_GAIN_WIDTH (3)
> +
> +/* MAX98927_R003E_MEAS_EN */
> +#define MAX98927_MEAS_V_EN (0x1 << 0)
> +#define MAX98927_MEAS_I_EN (0x1 << 1)
> +
> +/* MAX98927_R0040_BOOST_CTRL0 */
> +#define MAX98927_BOOST_CTRL0_VOUT_MASK (0x1f << 0)
> +#define MAX98927_BOOST_CTRL0_PVDD_MASK (0x1 << 7)
> +#define MAX98927_BOOST_CTRL0_PVDD_EN_SHIFT (7)
> +
> +/* MAX98927_R0052_BROWNOUT_EN */
> +#define MAX98927_BROWNOUT_BDE_EN (0x1 << 0)
> +#define MAX98927_BROWNOUT_AMP_EN (0x1 << 1)
> +#define MAX98927_BROWNOUT_DSP_EN (0x1 << 2)
> +#define MAX98927_BROWNOUT_DSP_SHIFT (2)
> +
> +/* MAX98927_R0100_SOFT_RESET */
> +#define MAX98927_SOFT_RESET (0x1 << 0)
> +
> +/* MAX98927_R00FF_GLOBAL_SHDN */
> +#define MAX98927_GLOBAL_EN_MASK (0x1 << 0)
> +
> +struct max98927_priv {
> +       struct regmap *regmap;
> +       struct snd_soc_codec *codec;
> +       struct max98927_pdata *pdata;
> +       unsigned int spk_gain;
> +       unsigned int sysclk;
> +       unsigned int v_l_slot;
> +       unsigned int i_l_slot;
> +       bool interleave_mode;
> +       unsigned int ch_size;
> +       unsigned int rate;
> +       unsigned int iface;
> +       unsigned int master;
> +       unsigned int digital_gain;
> +};
> +#endif
> --
> 2.11.0
>
