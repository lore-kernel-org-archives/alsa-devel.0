From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 1/5] ASoC: sirf: add sirf platform
 driver which provides DMA
Date: Sun, 05 Jan 2014 12:22:58 +0100
Message-ID: <52C94092.2050105@metafoo.de>
References: <1388729104-28643-1-git-send-email-rongjun.ying@csr.com>
 <1388729104-28643-2-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-079.synserver.de (smtp-out-019.synserver.de
 [212.40.185.19])
 by alsa0.perex.cz (Postfix) with ESMTP id CA503260376
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 12:22:43 +0100 (CET)
In-Reply-To: <1388729104-28643-2-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Workgroup.linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 01/03/2014 07:05 AM, RongJun Ying wrote:
> From: Rongjun Ying <Rongjun.Ying@csr.com>
> 
> this driver uses dmaengine APIs and provides DMA to the CPU DAIs
> of I2S, USP and SiRF-soc-inner.
> SiRFSoC has 3 audio DAIs: I2S, USP(Universal Serial Ports) and DAI
> connected to soc-inner-codec, all of them will use the same DMA
> driver here.
> 
> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
> ---
>  -v3:
>  Automatically discovering the configuration of pcm hardware from
>  the dmaengine driver
>  
>  sound/soc/Kconfig         |    1 +
>  sound/soc/Makefile        |    1 +
>  sound/soc/sirf/Kconfig    |    4 ++
>  sound/soc/sirf/Makefile   |    3 ++
>  sound/soc/sirf/sirf-pcm.c |   68 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 77 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/sirf/Kconfig
>  create mode 100644 sound/soc/sirf/Makefile
>  create mode 100644 sound/soc/sirf/sirf-pcm.c
> 
> diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
> index d62ce48..0060b31 100644
> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -50,6 +50,7 @@ source "sound/soc/pxa/Kconfig"
>  source "sound/soc/samsung/Kconfig"
>  source "sound/soc/s6000/Kconfig"
>  source "sound/soc/sh/Kconfig"
> +source "sound/soc/sirf/Kconfig"
>  source "sound/soc/spear/Kconfig"
>  source "sound/soc/tegra/Kconfig"
>  source "sound/soc/txx9/Kconfig"
> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
> index 62a1822..5f1df02 100644
> --- a/sound/soc/Makefile
> +++ b/sound/soc/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_SND_SOC)	+= pxa/
>  obj-$(CONFIG_SND_SOC)	+= samsung/
>  obj-$(CONFIG_SND_SOC)	+= s6000/
>  obj-$(CONFIG_SND_SOC)	+= sh/
> +obj-$(CONFIG_SND_SOC)	+= sirf/
>  obj-$(CONFIG_SND_SOC)	+= spear/
>  obj-$(CONFIG_SND_SOC)	+= tegra/
>  obj-$(CONFIG_SND_SOC)	+= txx9/
> diff --git a/sound/soc/sirf/Kconfig b/sound/soc/sirf/Kconfig
> new file mode 100644
> index 0000000..1637089
> --- /dev/null
> +++ b/sound/soc/sirf/Kconfig
> @@ -0,0 +1,4 @@
> +config SND_SIRF_SOC
> +	tristate "Platform DMA driver for the SiRF SoC chips"
> +	depends on ARCH_SIRF && SND_SOC
> +	select SND_SOC_GENERIC_DMAENGINE_PCM
> diff --git a/sound/soc/sirf/Makefile b/sound/soc/sirf/Makefile
> new file mode 100644
> index 0000000..f268b83
> --- /dev/null
> +++ b/sound/soc/sirf/Makefile
> @@ -0,0 +1,3 @@
> +snd-soc-sirf-objs := sirf-pcm.o
> +
> +obj-$(CONFIG_SND_SIRF_SOC) += snd-soc-sirf.o
> diff --git a/sound/soc/sirf/sirf-pcm.c b/sound/soc/sirf/sirf-pcm.c
> new file mode 100644
> index 0000000..e4cb3a6
> --- /dev/null
> +++ b/sound/soc/sirf/sirf-pcm.c
> @@ -0,0 +1,68 @@
> +/*
> + * ALSA PCM interface for the SiRF SoC
> + *
> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include <linux/module.h>
> +#include <sound/dmaengine_pcm.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +
> +static struct dma_chan *sirf_pcm_request_chan(struct snd_soc_pcm_runtime *rtd,
> +	struct snd_pcm_substream *substream)
> +{
> +	struct snd_dmaengine_dai_dma_data *dma_data;
> +
> +	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
> +
> +	return dma_request_slave_channel(rtd->cpu_dai->dev,
> +			dma_data->chan_name);
> +}
> +
> +static const struct snd_dmaengine_pcm_config sirf_dmaengine_pcm_config = {
> +	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
> +	.compat_request_channel = sirf_pcm_request_chan,
> +};
> +
> +static int sirf_pcm_probe(struct platform_device *pdev)
> +{
> +	return devm_snd_dmaengine_pcm_register(&pdev->dev,
> +		&sirf_dmaengine_pcm_config,
> +		SND_DMAENGINE_PCM_FLAG_NO_DT |
> +		SND_DMAENGINE_PCM_FLAG_COMPAT);

Since your platform is using DT you should drop the NO_DT and COMPAT flags.
Your sirf_pcm_request_chan is essentially doing the same as what the DT path
in the generic driver does.

> +}
> +
> +static struct platform_driver sirf_pcm_driver = {
> +	.driver = {
> +		.name = "sirf-pcm-audio",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = sirf_pcm_probe,
> +};

Also I wouldn't bother to register a extra device for the PCM, just call
devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0) from the DAI drivers,
that's what everybody else is doing.

- Lars
