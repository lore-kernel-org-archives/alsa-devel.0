From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 4/6] ASoC: fsl: create fsl_utils to
 accommodate the common functions
Date: Mon, 27 Feb 2012 15:36:48 -0600
Message-ID: <4F4BF770.3010205@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-5-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 120C8103B7F
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 22:54:26 +0100 (CET)
In-Reply-To: <1330092582-21180-5-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> There are some amount of code duplication between mpc8610_hpcd and

"There is"

> ---
> diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
> index 65087b1..46752af 100644
> --- a/sound/soc/fsl/Makefile
> +++ b/sound/soc/fsl/Makefile
> @@ -8,8 +8,10 @@ obj-$(CONFIG_SND_SOC_P1022_DS) += snd-soc-p1022-ds.o
>  
>  # Freescale PowerPC SSI/DMA Platform Support
>  snd-soc-fsl-ssi-objs := fsl_ssi.o
> +snd-soc-fsl-utils-objs := fsl_utils.o
>  snd-soc-fsl-dma-objs := fsl_dma.o
>  obj-$(CONFIG_SND_SOC_FSL_SSI) += snd-soc-fsl-ssi.o
> +obj-$(CONFIG_SND_SOC_FSL_UTILS) += snd-soc-fsl-utils.o
>  obj-$(CONFIG_SND_SOC_POWERPC_DMA) += snd-soc-fsl-dma.o

I think it would be easier to do this:

obj-$(CONFIG_SND_SOC_FSL_SSI) += snd-soc-fsl-ssi.o snd-soc-fsl-utils.o
obj-$(CONFIG_SND_SOC_POWERPC_DMA) += snd-soc-fsl-dma.o snd-soc-fsl-utils.o

Then you don't need to change the Kconfig.

> +static struct device_node *get_node_by_phandle_name(struct device_node *np,
> +	const char *name, const char *compatible)

...

> +static int get_parent_cell_index(struct device_node *np)

I think you should merge these two functions into their callers.  There's
not much point in keeping them separate now.  That will also allow you to
add dev_err() messages when returning error codes.

> +/**
> + * fsl_asoc_get_codec_dev_name - determine the dev_name for a codec node

Can you add kerneldoc descriptions of the parameters?

 * @np: pointer to the I2C device tree node
...

> + *
> + * This function determines the dev_name for an I2C node.  This is the name
> + * that would be returned by dev_name() if this device_node were part of a
> + * 'struct device'  It's ugly and hackish, but it works.
> + *
> + * The dev_name for such devices include the bus number and I2C address. For
> + * example, "cs4270.0-004f".
> + */
> +int fsl_asoc_get_codec_dev_name(struct device_node *np, char *buf, size_t len)
> +{
> +	const u32 *iprop;
> +	int addr;

'addr' should be a u32, actually.  I'm not sure why I made it a signed
integer.

> +
> +int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
> +			     const char *name,
> +			     struct snd_soc_dai_link *dai,
> +			     unsigned int *dma_channel_id,
> +			     unsigned int *dma_id)
> +{

Can you add kerneldoc comments to this function?

> +MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
> +MODULE_DESCRIPTION("Freescale ASoC utility code");
> +MODULE_LICENSE("GPL v2");

Is this really a module?

> diff --git a/sound/soc/fsl/fsl_utils.h b/sound/soc/fsl/fsl_utils.h
> new file mode 100644
> index 0000000..c928a15
> --- /dev/null
> +++ b/sound/soc/fsl/fsl_utils.h
> @@ -0,0 +1,29 @@
> +/**
> + * Freescale ALSA SoC Machine driver utility
> + *
> + * Author: Timur Tabi <timur@freescale.com>
> + *
> + * Copyright 2010 Freescale Semiconductor, Inc.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#ifndef _FSL_UTILS_H
> +#define _FSL_UTILS_H
> +
> +#define DAI_NAME_SIZE	32
> +
> +struct snd_soc_dai_link;
> +struct device_node;
> +
> +extern int fsl_asoc_get_codec_dev_name(struct device_node *np,
> +				       char *buf, size_t len);
> +extern int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
> +				    const char *name,
> +				    struct snd_soc_dai_link *dai,
> +				    unsigned int *dma_channel_id,
> +				    unsigned int *dma_id);

No 'extern' for function prototypes, please.


-- 
Timur Tabi
Linux kernel developer at Freescale
