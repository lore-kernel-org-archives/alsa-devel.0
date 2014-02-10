From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: fsl: Allow to select individual
	common options
Date: Mon, 10 Feb 2014 13:59:45 +0800
Message-ID: <20140210055943.GF9628@S2101-09.ap.freescale.net>
References: <1391621512-15064-1-git-send-email-shc_work@mail.ru>
 <1391621512-15064-2-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 by alsa0.perex.cz (Postfix) with ESMTP id B76D72610AE
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 06:59:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1391621512-15064-2-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 05, 2014 at 09:31:52PM +0400, Alexander Shiyan wrote:
> This patch allow to select individual common sound options and
> as a result allow using sound cards/codecs based on DT description.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  sound/soc/fsl/Kconfig | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index ecc1092..ed74c19 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -1,14 +1,26 @@
>  menu "SoC Audio for Freescale CPUs"
>  
> +comment "Common SoC Audio options for Freescale CPUs:"
> +
>  config SND_SOC_FSL_SAI
>  	tristate
>  	select SND_SOC_GENERIC_DMAENGINE_PCM

Why do you skip SND_SOC_FSL_SAI and SND_SOC_FSL_ESAI for the change?

>  
>  config SND_SOC_FSL_SSI
> -	tristate
> +	tristate "Synchronous Serial Interface module support"
> +	help
> +	  Say Y if you want to add Synchronous Serial Interface (SSI)
> +	  support for the Freescale CPUs.
> +	  This option is only useful for out-of-tree drivers since
> +	  in-tree drivers select it automatically.
>  
>  config SND_SOC_FSL_SPDIF
> -	tristate
> +	tristate "Sony/Philips Digital Interface module support"
> +	help
> +	  Say Y if you want to add Sony/Philips Digital Interface (SPDIF)
> +	  support for the Freescale CPUs.
> +	  This option is only useful for out-of-tree drivers since
> +	  in-tree drivers select it automatically.
>  
>  config SND_SOC_FSL_ESAI
>  	tristate
> @@ -21,7 +33,12 @@ config SND_SOC_IMX_PCM_DMA
>  	select SND_SOC_GENERIC_DMAENGINE_PCM

Doesn't the simple card driver need this to work on IMX?

Shawn

>  
>  config SND_SOC_IMX_AUDMUX
> -	tristate
> +	tristate "Digital Audio Mux module support"
> +	help
> +	  Say Y if you want to add Digital Audio Mux (AUDMUX) support
> +	  for the ARM i.MX CPUs.
> +	  This option is only useful for out-of-tree drivers since
> +	  in-tree drivers select it automatically.
>  
>  config SND_POWERPC_SOC
>  	tristate "SoC Audio for Freescale PowerPC CPUs"
> -- 
> 1.8.3.2
> 
