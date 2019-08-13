From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: ti: Fix typos in ti/Kconfig
Date: Tue, 13 Aug 2019 12:35:11 +0300
Message-ID: <9674e996-ef05-5da3-9d20-1ad5c44a6176@ti.com>
References: <20190813034235.30673-1-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813034235.30673-1-standby24x7@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Masanari Iida <standby24x7@gmail.com>, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 13/08/2019 6.42, Masanari Iida wrote:
> This patch fixes some spelling typo in Kconfig.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  sound/soc/ti/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
> index 2197f3e1eaed..87a9b9dd4e98 100644
> --- a/sound/soc/ti/Kconfig
> +++ b/sound/soc/ti/Kconfig
> @@ -12,7 +12,7 @@ config SND_SOC_TI_SDMA_PCM
>  
>  comment "Texas Instruments DAI support for:"
>  config SND_SOC_DAVINCI_ASP
> -	tristate "daVinci Audio Serial Port (ASP) or McBSP suport"
> +	tristate "daVinci Audio Serial Port (ASP) or McBSP support"
>  	depends on ARCH_DAVINCI || COMPILE_TEST
>  	select SND_SOC_TI_EDMA_PCM
>  	help
> @@ -33,7 +33,7 @@ config SND_SOC_DAVINCI_MCASP
>  	  - Keystone devices
>  
>  config SND_SOC_DAVINCI_VCIF
> -	tristate "daVinci Voice Interface (VCIF) suport"
> +	tristate "daVinci Voice Interface (VCIF) support"
>  	depends on ARCH_DAVINCI || COMPILE_TEST
>  	select SND_SOC_TI_EDMA_PCM
>  	help
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
