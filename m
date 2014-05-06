From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [RFC 2/4] ASoC: Intel: Add merrifield machine
 driver
Date: Tue, 06 May 2014 16:17:19 +0100
Message-ID: <1399389439.2814.30.camel@loki>
References: <1399312908-20744-1-git-send-email-vinod.koul@intel.com>
 <1399312908-20744-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F8AA261A3A
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 17:17:54 +0200 (CEST)
In-Reply-To: <1399312908-20744-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: jeeja.kp@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2014-05-05 at 23:31 +0530, Vinod Koul wrote:
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>  sound/soc/intel/Kconfig                  |   17 +
>  sound/soc/intel/board/Makefile           |    4 +
>  sound/soc/intel/board/merr_dpcm_wm8958.c |  619 ++++++++++++++++++++++++++++++
>  3 files changed, 640 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/intel/board/Makefile
>  create mode 100644 sound/soc/intel/board/merr_dpcm_wm8958.c
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 3c81b38..422c32d 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -49,3 +49,20 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
>  	help
>  	  This adds audio driver for Intel Baytrail platform based boards
>  	  with the RT5640 audio codec.
> +
> +config SND_SOC_INTEL_MRFLD_WM8958_MACH
> +	tristate "SOC Machine Audio driver for Intel Merrifield MID platform"
> +	depends on X86
> +	select SND_SOC_WM8994
> +	select MFD_CORE
> +	select MFD_WM8994
> +	select REGULATOR_WM8994
> +	select SND_SST_MFLD_PLATFORM
> +	select SND_SST_MACHINE
> +	select SND_INTEL_SST
> +	default n
> +	help
> +	  This adds support for ASoC machine driver for Intel(R) MID Merrifield platform
> +          used as alsa device in audio substem in Intel(R) MID devices
> +          Say Y if you have such a device
> +          If unsure select "N".
> diff --git a/sound/soc/intel/board/Makefile b/sound/soc/intel/board/Makefile
> new file mode 100644
> index 0000000..fdfbecf
> --- /dev/null
> +++ b/sound/soc/intel/board/Makefile
> @@ -0,0 +1,4 @@
> +# Merrifield board
> +snd-merr-dpcm-wm8958-objs := merr_dpcm_wm8958.o
> +
> +obj-$(CONFIG_SND_SOC_INTEL_MRFLD_WM8958_MACH) += snd-merr-dpcm-wm8958.o
> diff --git a/sound/soc/intel/board/merr_dpcm_wm8958.c b/sound/soc/intel/board/merr_dpcm_wm8958.c
> new file mode 100644
> index 0000000..4c17746
> --- /dev/null
> +++ b/sound/soc/intel/board/merr_dpcm_wm8958.c
> @@ -0,0 +1,619 @@
> +/*
> + *  merr_dpcm_wm8958.c - ASoc DPCM Machine driver for Intel Merrfield MID platform
> + *
> + *  Copyright (C) 2013-14 Intel Corp
> + *  Author: Vinod Koul <vinod.koul@intel.com>
> + *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/async.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/jack.h>
> +#include <linux/input.h>
> +
> +#include <linux/mfd/wm8994/core.h>
> +#include <linux/mfd/wm8994/registers.h>
> +#include <linux/mfd/wm8994/pdata.h>
> +#include "../../codecs/wm8994.h"
> +#include "../platform-libs/controls_v2.h"
> +
> +/* Codec PLL output clk rate */
> +#define CODEC_SYSCLK_RATE			24576000
> +/* Input clock to codec at MCLK1 PIN */
> +#define CODEC_IN_MCLK1_RATE			19200000
> +/* Input clock to codec at MCLK2 PIN */
> +#define CODEC_IN_MCLK2_RATE			32768
> +/*  define to select between MCLK1 and MCLK2 input to codec as its clock */
> +#define CODEC_IN_MCLK1				1
> +#define CODEC_IN_MCLK2				2
> +
> +struct mrfld_8958_mc_private {
> +	struct snd_soc_jack jack;
> +	int jack_retry;
> +};
> +
> +
> +static inline struct snd_soc_codec *mrfld_8958_get_codec(struct snd_soc_card *card)
> +{
> +	bool found = false;
> +	struct snd_soc_codec *codec;
> +
> +	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
> +		if (!strstr(codec->name, "wm8994-codec")) {
> +			pr_debug("codec was %s", codec->name);
> +			continue;
> +		} else {
> +			found = true;
> +			break;
> +		}
> +	}
> +	if (found == false) {
> +		pr_warn("%s: cant find codec", __func__);
> +		return NULL;
> +	}
> +	return codec;
> +}
> +
> +/* TODO: find better way of doing this */
> +static struct snd_soc_dai *find_codec_dai(struct snd_soc_card *card, const char *dai_name)
> +{
> +	int i;
> +	for (i = 0; i < card->num_rtd; i++) {
> +		if (!strcmp(card->rtd[i].codec_dai->name, dai_name))
> +			return card->rtd[i].codec_dai;
> +	}
> +	pr_err("%s: unable to find codec dai\n", __func__);
> +	/* this should never occur */
> +	WARN_ON(1);
> +	return NULL;
> +}
> +

It would be good if we could eventually make the above 2 calls generic
in core. Seem to be quite useful functions.

> +/* Function to switch the input clock for codec,  When audio is in
> + * progress input clock to codec will be through MCLK1 which is 19.2MHz
> + * while in off state input clock to codec will be through 32KHz through
> + * MCLK2
> + * card	: Sound card structure
> + * src	: Input clock source to codec
> + */
> +static int mrfld_8958_set_codec_clk(struct snd_soc_card *card, int src)
> +{
> +	struct snd_soc_dai *aif1_dai = find_codec_dai(card, "wm8994-aif1");
> +	int ret;
> +
> +	if (!aif1_dai)
> +		return -ENODEV;
> +
> +	switch (src) {
> +	case CODEC_IN_MCLK1:
> +		/* Turn ON the PLL to generate required sysclk rate
> +		 * from MCLK1 */
> +		ret = snd_soc_dai_set_pll(aif1_dai,
> +			WM8994_FLL1, WM8994_FLL_SRC_MCLK1,
> +			CODEC_IN_MCLK1_RATE, CODEC_SYSCLK_RATE);
> +		if (ret < 0) {
> +			pr_err("Failed to start FLL: %d\n", ret);
> +			return ret;
> +		}
> +		/* Switch to MCLK1 input */
> +		ret = snd_soc_dai_set_sysclk(aif1_dai, WM8994_SYSCLK_FLL1,
> +				CODEC_SYSCLK_RATE, SND_SOC_CLOCK_IN);
> +		if (ret < 0) {
> +			pr_err("Failed to set codec sysclk configuration %d\n",
> +				 ret);
> +			return ret;
> +		}
> +		break;
> +	case CODEC_IN_MCLK2:
> +		/* Switch to MCLK2 */
> +		ret = snd_soc_dai_set_sysclk(aif1_dai, WM8994_SYSCLK_MCLK2,
> +				32768, SND_SOC_CLOCK_IN);
> +		if (ret < 0) {
> +			pr_err("Failed to switch to MCLK2: %d", ret);
> +			return ret;
> +		}
> +		/* Turn off PLL for MCLK1 */
> +		ret = snd_soc_dai_set_pll(aif1_dai, WM8994_FLL1, 0, 0, 0);
> +		if (ret < 0) {
> +			pr_err("Failed to stop the FLL: %d", ret);
> +			return ret;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int mrfld_wm8958_set_clk_fmt(struct snd_soc_dai *codec_dai)
> +{
> +	unsigned int fmt;
> +	int ret = 0;
> +	struct snd_soc_card *card = codec_dai->card;
> +
> +	pr_err("setting snd_soc_dai_set_tdm_slot\n");
> +	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0, 0, 4, SNDRV_PCM_FORMAT_S24_LE);
> +	if (ret < 0) {
> +		pr_err("can't set codec pcm format %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* WM8958 slave Mode */
> +	fmt =   SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF
> +		| SND_SOC_DAIFMT_CBS_CFS;
> +	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
> +	if (ret < 0) {
> +		pr_err("can't set codec DAI configuration %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* FIXME: move this to SYS_CLOCK event handler when codec driver
> +	 * dependency is clean.
> +	 */
> +	/* Switch to 19.2MHz MCLK1 input clock for codec */
> +	ret = mrfld_8958_set_codec_clk(card, CODEC_IN_MCLK1);
> +
> +	return ret;
> +}
> +
> +static int mrfld_8958_hw_params(struct snd_pcm_substream *substream,
> +			   struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +
> +	if (!strcmp(codec_dai->name, "wm8994-aif1"))
> +		return mrfld_wm8958_set_clk_fmt(codec_dai);
> +	return 0;
> +}
> +
> +static int mrfld_wm8958_compr_set_params(struct snd_compr_stream *cstream)
> +{
> +	return 0;
> +}

Do we need to implement this if it's not used ?


---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
