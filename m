From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] dmaengine: edma: make edma_filter_fn private
Date: Fri, 8 Mar 2019 16:32:37 +0200
Message-ID: <de62088c-c09c-a198-412e-6507168bb31e@ti.com>
References: <20190307151646.1016966-1-arnd@arndb.de>
 <20190307151646.1016966-3-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307151646.1016966-3-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 07/03/2019 17.16, Arnd Bergmann wrote:
> With the audio driver no longer referring to this function, it
> can be made private to the dmaengine driver itself, and the
> header file removed.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/ti/edma.c |  5 +++--
>  include/linux/edma.h  | 29 -----------------------------
>  2 files changed, 3 insertions(+), 31 deletions(-)
>  delete mode 100644 include/linux/edma.h
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index ceabdea40ae0..f2549ee3fb49 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -15,7 +15,6 @@
>  
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/edma.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> @@ -2185,6 +2184,8 @@ static struct dma_chan *of_edma_xlate(struct of_phandle_args *dma_spec,
>  }
>  #endif
>  
> +static bool edma_filter_fn(struct dma_chan *chan, void *param);
> +
>  static int edma_probe(struct platform_device *pdev)
>  {
>  	struct edma_soc_info	*info = pdev->dev.platform_data;
> @@ -2524,7 +2525,7 @@ static struct platform_driver edma_tptc_driver = {
>  	},
>  };
>  
> -bool edma_filter_fn(struct dma_chan *chan, void *param)
> +static bool edma_filter_fn(struct dma_chan *chan, void *param)
>  {
>  	bool match = false;
>  
> diff --git a/include/linux/edma.h b/include/linux/edma.h
> deleted file mode 100644
> index a1307e7827e8..000000000000
> --- a/include/linux/edma.h
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -/*
> - * TI EDMA DMA engine driver
> - *
> - * Copyright 2012 Texas Instruments
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation version 2.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> -#ifndef __LINUX_EDMA_H
> -#define __LINUX_EDMA_H
> -
> -struct dma_chan;
> -
> -#if defined(CONFIG_TI_EDMA) || defined(CONFIG_TI_EDMA_MODULE)
> -bool edma_filter_fn(struct dma_chan *, void *);
> -#else
> -static inline bool edma_filter_fn(struct dma_chan *chan, void *param)
> -{
> -	return false;
> -}
> -#endif
> -
> -#endif
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
