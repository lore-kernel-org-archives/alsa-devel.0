From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Add WM8994 PCM Machine
	driver
Date: Thu, 16 Jun 2011 09:40:01 +0100
Message-ID: <4DF9C161.4030401@ti.com>
References: <1308206544-6215-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 51D1D2463F
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 10:40:11 +0200 (CEST)
In-Reply-To: <1308206544-6215-1-git-send-email-sbkim73@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 16/06/11 07:42, Sangbeom Kim wrote:
> This patch add WM8994 PCM machine driver to support PCM audio
> on SMDKV310, SMDKC210 boards.
> Playback and Capture supports 8kHz sampling rates.
> and It is tested on SMDKV310, SMDKC210.
> 
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> ---
>  sound/soc/samsung/Kconfig          |    8 ++
>  sound/soc/samsung/Makefile         |    2 +
>  sound/soc/samsung/smdk_wm8994pcm.c |  176 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 185 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/samsung/smdk_wm8994pcm.c
> 
> diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
> index b8c7a2e..db2bc49 100644
> --- a/sound/soc/samsung/Kconfig
> +++ b/sound/soc/samsung/Kconfig
> @@ -170,3 +170,11 @@ config SND_SOC_SMDK_WM8580_PCM
>  	select SND_SAMSUNG_PCM
>  	help
>  	  Say Y if you want to add support for SoC audio on the SMDK.
> +
> +config SND_SOC_SMDK_WM8994_PCM
> +	tristate "SoC PCM Audio support for WM8994 on SMDK"
> +	depends on SND_SOC_SAMSUNG && (MACH_SMDKC210 || MACH_SMDKV310)
> +	select SND_SOC_WM8994
> +	select SND_SAMSUNG_PCM
> +	help
> +	  Say Y if you want to add support for SoC audio on the SMDK.
> diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
> index 6c598fc..4a3a428 100644
> --- a/sound/soc/samsung/Makefile
> +++ b/sound/soc/samsung/Makefile
> @@ -35,6 +35,7 @@ snd-soc-s3c64xx-smartq-wm8987-objs := smartq_wm8987.o
>  snd-soc-goni-wm8994-objs := goni_wm8994.o
>  snd-soc-smdk-spdif-objs := smdk_spdif.o
>  snd-soc-smdk-wm8580pcm-objs := smdk_wm8580pcm.o
> +snd-soc-smdk-wm8994pcm-objs := smdk_wm8994pcm.o
>  
>  obj-$(CONFIG_SND_SOC_SAMSUNG_JIVE_WM8750) += snd-soc-jive-wm8750.o
>  obj-$(CONFIG_SND_SOC_SAMSUNG_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
> @@ -53,3 +54,4 @@ obj-$(CONFIG_SND_SOC_SMARTQ) += snd-soc-s3c64xx-smartq-wm8987.o
>  obj-$(CONFIG_SND_SOC_SAMSUNG_SMDK_SPDIF) += snd-soc-smdk-spdif.o
>  obj-$(CONFIG_SND_SOC_GONI_AQUILA_WM8994) += snd-soc-goni-wm8994.o
>  obj-$(CONFIG_SND_SOC_SMDK_WM8580_PCM) += snd-soc-smdk-wm8580pcm.o
> +obj-$(CONFIG_SND_SOC_SMDK_WM8994_PCM) += snd-soc-smdk-wm8994pcm.o
> diff --git a/sound/soc/samsung/smdk_wm8994pcm.c b/sound/soc/samsung/smdk_wm8994pcm.c
> new file mode 100644
> index 0000000..756c228
> --- /dev/null
> +++ b/sound/soc/samsung/smdk_wm8994pcm.c
> @@ -0,0 +1,176 @@
> +/*
> + *  sound/soc/samsung/smdk_wm8994pcm.c
> + *
> + *  Copyright (c) 2011 Samsung Electronics Co., Ltd
> + *		http://www.samsung.com
> + *
> + *  This program is free software; you can redistribute  it and/or  modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + */
> +#include <sound/soc.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +
> +#include "../codecs/wm8994.h"
> +#include "dma.h"
> +#include "pcm.h"
> +
> +/*
> + * Board Settings:
> + *  o '1' means 'ON'
> + *  o '0' means 'OFF'
> + *  o 'X' means 'Don't care'
> + *
> + * SMDKC210, SMDKV310: CFG3- 1001, CFG5-1000, CFG7-111111
> + */
> +
> +/*
> + * Configure audio route as :-
> + * $ amixer sset 'DAC1' on,on
> + * $ amixer sset 'Right Headphone Mux' 'DAC'
> + * $ amixer sset 'Left Headphone Mux' 'DAC'
> + * $ amixer sset 'DAC1R Mixer AIF1.1' on
> + * $ amixer sset 'DAC1L Mixer AIF1.1' on
> + * $ amixer sset 'IN2L' on
> + * $ amixer sset 'IN2L PGA IN2LN' on
> + * $ amixer sset 'MIXINL IN2L' on
> + * $ amixer sset 'AIF1ADC1L Mixer ADC/DMIC' on
> + * $ amixer sset 'IN2R' on
> + * $ amixer sset 'IN2R PGA IN2RN' on
> + * $ amixer sset 'MIXINR IN2R' on
> + * $ amixer sset 'AIF1ADC1R Mixer ADC/DMIC' on
> + */
> +
> +/* SMDK has a 16.9344MHZ crystal attached to WM8994 */
> +#define SMDK_WM8994_FREQ 16934400
> +
> +static int smdk_wm8994_pcm_hw_params(struct snd_pcm_substream *substream,
> +			      struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	unsigned long mclk_freq;
> +	int rfs, ret;
> +
> +	switch(params_rate(params)) {
> +	case 8000:
> +		rfs = 512;
> +		break;
> +	default:
> +		printk(KERN_ERR "%s:%d Sampling Rate %u not supported!\n",
> +		__func__, __LINE__, params_rate(params));

Better to use dev_err here.

Thanks

Liam
