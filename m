From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/3] dmaengine: omap-dma: make omap_dma_filter_fn private
Date: Fri, 8 Mar 2019 16:32:52 +0200
Message-ID: <641ebb44-7278-f298-c03d-8251dcd6c71e@ti.com>
References: <20190307151646.1016966-1-arnd@arndb.de>
 <20190307151646.1016966-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307151646.1016966-2-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 07/03/2019 17.16, Arnd Bergmann wrote:
> With the audio driver no longer referring to this function, it
> can be made private to the dmaengine driver itself, and the
> header file removed.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/ti/omap-dma.c      |  3 ++-
>  include/linux/omap-dma.h       |  2 --
>  include/linux/omap-dmaengine.h | 21 ---------------------
>  3 files changed, 2 insertions(+), 24 deletions(-)
>  delete mode 100644 include/linux/omap-dmaengine.h
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index a4a931ddf6f6..5bf635ba234d 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -205,6 +205,7 @@ static const unsigned es_bytes[] = {
>  	[CSDP_DATA_TYPE_32] = 4,
>  };
>  
> +static bool omap_dma_filter_fn(struct dma_chan *chan, void *param);
>  static struct of_dma_filter_info omap_dma_info = {
>  	.filter_fn = omap_dma_filter_fn,
>  };
> @@ -1640,7 +1641,7 @@ static struct platform_driver omap_dma_driver = {
>  	},
>  };
>  
> -bool omap_dma_filter_fn(struct dma_chan *chan, void *param)
> +static bool omap_dma_filter_fn(struct dma_chan *chan, void *param)
>  {
>  	if (chan->device->dev->driver == &omap_dma_driver.driver) {
>  		struct omap_dmadev *od = to_omap_dma_dev(chan->device);
> diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
> index 840ce551e773..ba3cfbb52312 100644
> --- a/include/linux/omap-dma.h
> +++ b/include/linux/omap-dma.h
> @@ -1,8 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef __LINUX_OMAP_DMA_H
>  #define __LINUX_OMAP_DMA_H
> -#include <linux/omap-dmaengine.h>
> -
>  /*
>   *  Legacy OMAP DMA handling defines and functions
>   *
> diff --git a/include/linux/omap-dmaengine.h b/include/linux/omap-dmaengine.h
> deleted file mode 100644
> index 8e6906c72e90..000000000000
> --- a/include/linux/omap-dmaengine.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/*
> - * OMAP DMA Engine support
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#ifndef __LINUX_OMAP_DMAENGINE_H
> -#define __LINUX_OMAP_DMAENGINE_H
> -
> -struct dma_chan;
> -
> -#if defined(CONFIG_DMA_OMAP) || (defined(CONFIG_DMA_OMAP_MODULE) && defined(MODULE))
> -bool omap_dma_filter_fn(struct dma_chan *, void *);
> -#else
> -static inline bool omap_dma_filter_fn(struct dma_chan *c, void *d)
> -{
> -	return false;
> -}
> -#endif
> -#endif /* __LINUX_OMAP_DMAENGINE_H */
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
