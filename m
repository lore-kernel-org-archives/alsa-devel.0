From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH V2] ASoC: add RT286 CODEC driver
Date: Wed, 4 Dec 2013 16:36:41 +0200
Message-ID: <CALq1K=+Lh_g3kZfftVdCpTbWGVoR_yZdqDGfnC9ECs4nRfDvzg@mail.gmail.com>
References: <1386164488-32227-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f177.google.com (mail-vc0-f177.google.com
 [209.85.220.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 97367261701
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 15:37:02 +0100 (CET)
Received: by mail-vc0-f177.google.com with SMTP id hv10so11368589vcb.36
 for <alsa-devel@alsa-project.org>; Wed, 04 Dec 2013 06:37:01 -0800 (PST)
In-Reply-To: <1386164488-32227-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 4, 2013 at 3:41 PM,  <bardliao@realtek.com> wrote:
> From: Bard Liao <bardliao@realtek.com>
>
> This patch adds the ALC286 codec driver.
>
> Signed-off-by: Bard Liao <bardliao@realtek.com>
>

Please add change log while you are sending verX patch.


> ---
>
> This is the initial codec driver of ALC286.
> I tested Headset recording and Speaker playback.
> I tested with snd_soc_register_codec because my kernel doesn't support devm_snd_soc_register_codec yet.
>
> ---
>  include/sound/rt286.h     |   19 +
>  sound/soc/codecs/Kconfig  |    4 +
>  sound/soc/codecs/Makefile |    2 +
>  sound/soc/codecs/rt286.c  | 1367 +++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/rt286.h  |   89 +++
>  5 files changed, 1481 insertions(+)
>  create mode 100644 include/sound/rt286.h
>  create mode 100644 sound/soc/codecs/rt286.c
>  create mode 100644 sound/soc/codecs/rt286.h
>
> diff --git a/include/sound/rt286.h b/include/sound/rt286.h
> new file mode 100644
> index 0000000..6c0c1c9
> --- /dev/null
> +++ b/include/sound/rt286.h
> @@ -0,0 +1,19 @@
> +/*
> + * linux/sound/rt286.h -- Platform data for RT286
> + *
> + * Copyright 2013 Realtek Microelectronics
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __LINUX_SND_RT286_H
> +#define __LINUX_SND_RT286_H
> +
> +struct rt286_platform_data {
> +       bool cbj_en; /*combo jack enable*/
> +       bool irq_en; /*IRQ enable*/
> +};
> +
> +#endif
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 983d087a..755a39d 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -61,6 +61,7 @@ config SND_SOC_ALL_CODECS
>         select SND_SOC_PCM3008
>         select SND_SOC_RT5631 if I2C
>         select SND_SOC_RT5640 if I2C
> +       select SND_SOC_RT286 if I2C
>         select SND_SOC_SGTL5000 if I2C
>         select SND_SOC_SI476X if MFD_SI476X_CORE
>         select SND_SOC_SN95031 if INTEL_SCU_IPC
> @@ -319,6 +320,9 @@ config SND_SOC_RT5631
>  config SND_SOC_RT5640
>         tristate
>
> +config SND_SOC_RT286
> +       tristate
> +
>  #Freescale sgtl5000 codec
>  config SND_SOC_SGTL5000
>         tristate
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index bc12676..b31615c 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -48,6 +48,7 @@ snd-soc-pcm1792a-codec-objs := pcm1792a.o
>  snd-soc-pcm3008-objs := pcm3008.o
>  snd-soc-rt5631-objs := rt5631.o
>  snd-soc-rt5640-objs := rt5640.o
> +snd-soc-rt286-objs := rt286.o
>  snd-soc-sgtl5000-objs := sgtl5000.o
>  snd-soc-alc5623-objs := alc5623.o
>  snd-soc-alc5632-objs := alc5632.o
> @@ -181,6 +182,7 @@ obj-$(CONFIG_SND_SOC_PCM1792A)      += snd-soc-pcm1792a-codec.o
>  obj-$(CONFIG_SND_SOC_PCM3008)  += snd-soc-pcm3008.o
>  obj-$(CONFIG_SND_SOC_RT5631)   += snd-soc-rt5631.o
>  obj-$(CONFIG_SND_SOC_RT5640)   += snd-soc-rt5640.o
> +obj-$(CONFIG_SND_SOC_RT286)    += snd-soc-rt286.o
>  obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
>  obj-$(CONFIG_SND_SOC_SIGMADSP) += snd-soc-sigmadsp.o
>  obj-$(CONFIG_SND_SOC_SI476X)   += snd-soc-si476x.o
> diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
> new file mode 100644
> index 0000000..e7aef0d
> --- /dev/null
> +++ b/sound/soc/codecs/rt286.c
> @@ -0,0 +1,1367 @@
> +/*
> + * rt286.c  --  RT286 ALSA SoC audio codec driver
> + *
> + * Copyright 2013 Realtek Semiconductor Corp.
> + * Author: Bard Liao <bardliao@realtek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/pm.h>
> +#include <linux/i2c.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/acpi.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/initval.h>
> +#include <sound/tlv.h>
> +#include <sound/rt286.h>
> +
> +#include "../../pci/hda/hda_codec.h"
> +#include "rt286.h"
> +
> +struct rt286_priv {
> +       struct regmap *regmap;
> +       struct rt286_platform_data pdata;
> +       int sys_clk;
> +};
> +
> +static unsigned int rt286_reg_cache[TOTAL_NODE_ID + 1] = {
You don't need TOTAL_NODE_ID + 1 in array declaration.

> +       [NODE_ID_DAC_OUT1] = 0x7f7f,
> +       [NODE_ID_DAC_OUT2] = 0x7f7f,
> +       [NODE_ID_SPDIF] = 0x0000,
> +       [NODE_ID_ADC_IN1] = 0x4343,
> +       [NODE_ID_ADC_IN2] = 0x4343,
> +       [NODE_ID_MIC1] = 0x0000,
> +       [NODE_ID_MIXER_IN] = 0x000b,
> +       [NODE_ID_MIXER_OUT1] = 0x0002,
> +       [NODE_ID_MIXER_OUT2] = 0x0000,
> +       [NODE_ID_SPK_OUT] = 0x0000,
> +       [NODE_ID_HP_OUT] = 0x0000,
> +       [NODE_ID_MIXER_IN1] = 0x0000,
> +       [NODE_ID_MIXER_IN2] = 0x0000,
> +};
