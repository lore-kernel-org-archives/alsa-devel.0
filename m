From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/3] ASoC: ti: fix davinci_mcasp_probe dependencies
Date: Thu, 7 Mar 2019 15:25:23 +0200
Message-ID: <8e98c10d-cf71-296d-eeae-97a8ffc2b9d7@ti.com>
References: <20190304203114.1894822-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190304203114.1894822-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Arnd,

On 04/03/2019 22.30, Arnd Bergmann wrote:
> The SND_SOC_DAVINCI_MCASP driver can use either edma or sdma as
> a back-end, and it takes the presence of the respective dma engine
> drivers in the configuration as an indication to which ones should be
> built. However, this is flawed in multiple ways:
> 
> - With CONFIG_TI_EDMA=m and CONFIG_SND_SOC_DAVINCI_MCASP=y,
>   is enabled as =m, and we get a link error:
>   sound/soc/ti/davinci-mcasp.o: In function `davinci_mcasp_probe':
>   davinci-mcasp.c:(.text+0x930): undefined reference to `edma_pcm_platform_register'

In non randconfig case both edma and sdma DMAengine driver would be
built in so I did missed this for sure.

> - When CONFIG_SND_SOC_DAVINCI_MCASP=m has already been selected by
>   another driver, the same link error appears even if CONFIG_TI_EDMA
>   is disabled
> 
> There are possibly other issues here, but it seems that the only reasonable
> solution is to always build both SND_SOC_TI_EDMA_PCM and
> SND_SOC_TI_SDMA_PCM as a dependency here. Both are fairly small and
> do not have any other compile-time dependencies, so the cost is
> very small, and makes the configuration stage much more consistent.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Fixes: f2055e145f29 ("ASoC: ti: Merge davinci and omap directories")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/ti/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
> index 4bf3c15d4e51..ee7c202c69b7 100644
> --- a/sound/soc/ti/Kconfig
> +++ b/sound/soc/ti/Kconfig
> @@ -21,8 +21,8 @@ config SND_SOC_DAVINCI_ASP
>  
>  config SND_SOC_DAVINCI_MCASP
>  	tristate "Multichannel Audio Serial Port (McASP) support"
> -	select SND_SOC_TI_EDMA_PCM if TI_EDMA
> -	select SND_SOC_TI_SDMA_PCM if DMA_OMAP
> +	select SND_SOC_TI_EDMA_PCM
> +	select SND_SOC_TI_SDMA_PCM
>  	help
>  	  Say Y or M here if you want to have support for McASP IP found in
>  	  various Texas Instruments SoCs like:
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
