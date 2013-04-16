From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 03/17] ASoC: Add a generic dmaengine_pcm
	driver
Date: Tue, 16 Apr 2013 16:11:05 +0200
Message-ID: <20130416141105.GB13272@pengutronix.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 0E49F264FD1
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 16:12:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1366046404-8759-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 15, 2013 at 07:19:50PM +0200, Lars-Peter Clausen wrote:
> This patch adds a generic dmaengine PCM driver. It builds on top of the
> dmaengine PCM library and adds the missing pieces like DMA channel management,
> buffer management and channel configuration. It will be able to replace the
> majority of the existing platform specific dmaengine based PCM drivers.
> Devicetree is used to map the DMA channels to the PCM device.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  include/sound/dmaengine_pcm.h         |  25 ++++
>  sound/soc/Kconfig                     |   4 +
>  sound/soc/Makefile                    |   4 +
>  sound/soc/soc-generic-dmaengine-pcm.c | 241 ++++++++++++++++++++++++++++++++++
>  4 files changed, 274 insertions(+)
>  create mode 100644 sound/soc/soc-generic-dmaengine-pcm.c
> 
> diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
> index d015d67..e0bf24e 100644
> --- a/include/sound/dmaengine_pcm.h
> +++ b/include/sound/dmaengine_pcm.h
> @@ -72,4 +72,29 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
>  	const struct snd_dmaengine_dai_dma_data *dma_data,
>  	struct dma_slave_config *config);
>  
> +/**
> + * struct snd_dmaengine_pcm_config - Configuration data for dmaengine based PCM
> + * @prepare_slave_config: Callback used to fill in the DMA slave_config for a
> + *   PCM substream. Will be called from the PCM drivers hwparams callback.
> + * @pcm_hardware: snd_pcm_hardware struct to be used for the PCM.
> + * @prealloc_buffer_size: Size of the preallocated audio buffer.
> + */
> +struct snd_dmaengine_pcm_config {
> +	int (*prepare_slave_config)(struct snd_pcm_substream *substream,
> +			struct snd_pcm_hw_params *params,
> +			struct dma_slave_config *slave_config);
> +
> +	const struct snd_pcm_hardware *pcm_hardware;
> +	unsigned int prealloc_buffer_size;
> +};
> +
> +int snd_dmaengine_pcm_register(struct device *dev,
> +	const struct snd_dmaengine_pcm_config *config,
> +	unsigned int flags);
> +void snd_dmaengine_pcm_unregister(struct device *dev);
> +
> +int snd_dmaengine_pcm_prepare_slave_config(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params,
> +	struct dma_slave_config *slave_config);
> +
>  #endif
> diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
> index 5da8ca7..9e675c7 100644
> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -29,6 +29,10 @@ config SND_SOC_AC97_BUS
>  config SND_SOC_DMAENGINE_PCM
>  	bool
>  
> +config SND_SOC_GENERIC_DMAENGINE_PCM
> +	bool
> +	select SND_SOC_DMAENGINE_PCM
> +
>  # All the supported SoCs
>  source "sound/soc/atmel/Kconfig"
>  source "sound/soc/au1x/Kconfig"
> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
> index 99f32f7..197b6ae 100644
> --- a/sound/soc/Makefile
> +++ b/sound/soc/Makefile
> @@ -5,6 +5,10 @@ ifneq ($(CONFIG_SND_SOC_DMAENGINE_PCM),)
>  snd-soc-core-objs += soc-dmaengine-pcm.o
>  endif
>  
> +ifneq ($(CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM),)
> +snd-soc-core-objs += soc-generic-dmaengine-pcm.o
> +endif
> +
>  obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
>  obj-$(CONFIG_SND_SOC)	+= codecs/
>  obj-$(CONFIG_SND_SOC)	+= generic/
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> new file mode 100644
> index 0000000..acfc926
> --- /dev/null
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -0,0 +1,241 @@
> +/*
> + *  Copyright (C) 2013, Analog Devices Inc.
> + *	Author: Lars-Peter Clausen <lars@metafoo.de>
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under  the terms of the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the License, or (at your
> + *  option) any later version.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/dmaengine.h>
> +#include <linux/slab.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>
> +
> +#include <sound/dmaengine_pcm.h>
> +
> +struct dmaengine_pcm {
> +	struct dma_chan *chan[SNDRV_PCM_STREAM_CAPTURE + 1];
> +	const struct snd_dmaengine_pcm_config *config;
> +	struct snd_soc_platform platform;
> +};
> +
> +static struct dmaengine_pcm *soc_platform_to_pcm(struct snd_soc_platform *p)
> +{
> +	return container_of(p, struct dmaengine_pcm, platform);
> +}
> +
> +/**
> + * snd_dmaengine_pcm_prepare_slave_config() - Generic prepare_slave_config callback
> + * @substream: PCM substream
> + * @params: hw_params
> + * @slave_config: DMA slave config to prepare
> + *
> + * This function can be used as a generic prepare_slave_config callback for
> + * platforms which make use of the snd_dmaengine_dai_dma_data struct for their
> + * DAI DMA data. Internally the function will first call
> + * snd_hwparams_to_dma_slave_config to fill in the slave config based on the
> + * hw_params, followed by snd_dmaengine_set_config_from_dai_data to fill in the
> + * remaining fields based on the DAI DMA data.
> + */
> +int snd_dmaengine_pcm_prepare_slave_config(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params, struct dma_slave_config *slave_config)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_dmaengine_dai_dma_data *dma_data;
> +	int ret;
> +
> +	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
> +
> +	ret = snd_hwparams_to_dma_slave_config(substream, params, slave_config);
> +	if (ret)
> +		return ret;
> +
> +	snd_dmaengine_pcm_set_config_from_dai_data(substream, dma_data,
> +		slave_config);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_prepare_slave_config);
> +
> +static int dmaengine_pcm_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
> +	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
> +	struct dma_slave_config slave_config;
> +	int ret;
> +
> +	if (pcm->config->prepare_slave_config) {
> +		ret = pcm->config->prepare_slave_config(substream, params,
> +				&slave_config);
> +		if (ret)
> +			return ret;
> +
> +		ret = dmaengine_slave_config(chan, &slave_config);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
> +}
> +
> +static int dmaengine_pcm_open(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
> +	struct dma_chan *chan = pcm->chan[substream->stream];
> +	int ret;
> +
> +	ret = snd_soc_set_runtime_hwparams(substream,
> +				pcm->config->pcm_hardware);
> +	if (ret)
> +		return ret;
> +
> +	return snd_dmaengine_pcm_open(substream, chan);
> +}
> +
> +static struct device *dmaengine_dma_dev(struct dmaengine_pcm *pcm,
> +	struct snd_pcm_substream *substream)
> +{
> +	if (!pcm->chan[substream->stream])
> +		return NULL;
> +
> +	return pcm->chan[substream->stream]->device->dev;
> +}
> +
> +static void dmaengine_pcm_free(struct snd_pcm *pcm)
> +{
> +	snd_pcm_lib_preallocate_free_for_all(pcm);
> +}
> +
> +static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
> +	const struct snd_dmaengine_pcm_config *config = pcm->config;
> +	struct snd_pcm_substream *substream;
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
> +		substream = rtd->pcm->streams[i].substream;
> +		if (!substream)
> +			continue;
> +
> +		if (!pcm->chan[i]) {
> +			dev_err(rtd->platform->dev,
> +				"Missing dma channel for stream: %d\n", i);
> +			ret = -EINVAL;
> +			goto err_free;
> +		}
> +
> +		ret = snd_pcm_lib_preallocate_pages(substream,
> +				SNDRV_DMA_TYPE_DEV,
> +				dmaengine_dma_dev(pcm, substream),
> +				config->prealloc_buffer_size,
> +				config->pcm_hardware->buffer_bytes_max);
> +		if (ret)
> +			goto err_free;
> +	}
> +
> +	return 0;
> +
> +err_free:
> +	dmaengine_pcm_free(rtd->pcm);
> +	return ret;
> +}
> +
> +static const struct snd_pcm_ops dmaengine_pcm_ops = {
> +	.open		= dmaengine_pcm_open,
> +	.close		= snd_dmaengine_pcm_close,
> +	.ioctl		= snd_pcm_lib_ioctl,
> +	.hw_params	= dmaengine_pcm_hw_params,
> +	.hw_free	= snd_pcm_lib_free_pages,
> +	.trigger	= snd_dmaengine_pcm_trigger,
> +	.pointer	= snd_dmaengine_pcm_pointer,
> +};
> +
> +static const struct snd_soc_platform_driver dmaengine_pcm_platform = {
> +	.ops		= &dmaengine_pcm_ops,
> +	.pcm_new	= dmaengine_pcm_new,
> +	.pcm_free	= dmaengine_pcm_free,
> +};
> +
> +static const char * const dmaengine_pcm_dma_channel_names[] = {
> +	[SNDRV_PCM_STREAM_PLAYBACK] = "tx",
> +	[SNDRV_PCM_STREAM_CAPTURE] = "rx",
> +};
> +
> +/**
> + * snd_dmaengine_pcm_register - Register a dmaengine based PCM device
> + * @dev: The parent device for the PCM device
> + * @config: Platform specific PCM configuration
> + * @flags: Platform specific quirks
> + */
> +int snd_dmaengine_pcm_register(struct device *dev,
> +	const struct snd_dmaengine_pcm_config *config, unsigned int flags)
> +{
> +	struct dmaengine_pcm *pcm;
> +	unsigned int i;
> +
> +	if (!dev->of_node)
> +		return -EINVAL;
> +
> +	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
> +	if (!pcm)
> +		return -ENOMEM;
> +
> +	pcm->config = config;
> +
> +	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
> +		pcm->chan[i] = of_dma_request_slave_channel(dev->of_node,
> +					dmaengine_pcm_dma_channel_names[i]);
> +	}

Perhaps you should use dma_request_slave_channel here? Then you could
also drop the of_dma.h include.

Regards,

Markus

> +
> +	return snd_soc_add_platform(dev, &pcm->platform,
> +				&dmaengine_pcm_platform);
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_register);
> +
> +/**
> + * snd_dmaengine_pcm_unregister - Removes a dmaengine based PCM device
> + * @dev: Parent device the PCM was register with
> + *
> + * Removes a dmaengine based PCM device previously registered with
> + * snd_dmaengine_pcm_register.
> + */
> +void snd_dmaengine_pcm_unregister(struct device *dev)
> +{
> +	struct snd_soc_platform *platform;
> +	struct dmaengine_pcm *pcm;
> +	unsigned int i;
> +
> +	platform = snd_soc_lookup_platform(dev);
> +	if (!platform)
> +		return;
> +
> +	pcm = soc_platform_to_pcm(platform);
> +
> +	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
> +		if (pcm->chan[i])
> +			dma_release_channel(pcm->chan[i]);
> +	}
> +
> +	snd_soc_remove_platform(platform);
> +	kfree(pcm);
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_unregister);
> +
> +MODULE_LICENSE("GPL");
> -- 
> 1.8.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
