From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: fsl: Separation of the main
 audio options and boards
Date: Mon, 10 Feb 2014 13:53:59 +0800
Message-ID: <20140210055357.GE9628@S2101-09.ap.freescale.net>
References: <1391621512-15064-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A8AF2608EA
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 06:53:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1391621512-15064-1-git-send-email-shc_work@mail.ru>
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

On Wed, Feb 05, 2014 at 09:31:51PM +0400, Alexander Shiyan wrote:
> This patch provide separation of the main audio options and boards.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  sound/soc/fsl/Kconfig | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 07f8f14..ecc1092 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -1,3 +1,5 @@
> +menu "SoC Audio for Freescale CPUs"
> +
>  config SND_SOC_FSL_SAI
>  	tristate
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
> @@ -14,13 +16,27 @@ config SND_SOC_FSL_ESAI
>  config SND_SOC_FSL_UTILS
>  	tristate
>  
> -menuconfig SND_POWERPC_SOC
> +config SND_SOC_IMX_PCM_DMA
> +	tristate
> +	select SND_SOC_GENERIC_DMAENGINE_PCM
> +
> +config SND_SOC_IMX_AUDMUX
> +	tristate
> +
> +config SND_POWERPC_SOC
>  	tristate "SoC Audio for Freescale PowerPC CPUs"
>  	depends on FSL_SOC || PPC_MPC52xx
>  	help
>  	  Say Y or M if you want to add support for codecs attached to
>  	  the PowerPC CPUs.
>  
> +config SND_IMX_SOC
> +	tristate "SoC Audio for Freescale i.MX CPUs"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	help
> +	  Say Y or M if you want to add support for codecs attached to
> +	  the i.MX CPUs.
> +
>  if SND_POWERPC_SOC
>  
>  config SND_MPC52xx_DMA
> @@ -29,6 +45,8 @@ config SND_MPC52xx_DMA
>  config SND_SOC_POWERPC_DMA
>  	tristate
>  
> +comment "SoC Audio support for Freescale PPC boards:"
> +
>  config SND_SOC_MPC8610_HPCD
>  	tristate "ALSA SoC support for the Freescale MPC8610 HPCD board"
>  	# I2C is necessary for the CS4270 driver
> @@ -106,13 +124,6 @@ config SND_MPC52xx_SOC_EFIKA
>  
>  endif # SND_POWERPC_SOC
>  
> -menuconfig SND_IMX_SOC
> -	tristate "SoC Audio for Freescale i.MX CPUs"
> -	depends on ARCH_MXC || COMPILE_TEST
> -	help
> -	  Say Y or M if you want to add support for codecs attached to
> -	  the i.MX CPUs.
> -
>  if SND_IMX_SOC
>  
>  config SND_SOC_IMX_SSI
> @@ -122,12 +133,7 @@ config SND_SOC_IMX_PCM_FIQ
>  	tristate
>  	select FIQ

Hmm, why do you choose to have SND_SOC_IMX_SSI and SND_SOC_IMX_PCM_FIQ
still stay in board section?

Shawn

>  
> -config SND_SOC_IMX_PCM_DMA
> -	tristate
> -	select SND_SOC_GENERIC_DMAENGINE_PCM
> -
> -config SND_SOC_IMX_AUDMUX
> -	tristate
> +comment "SoC Audio support for Freescale i.MX boards:"
>  
>  config SND_MXC_SOC_WM1133_EV1
>  	tristate "Audio on the i.MX31ADS with WM1133-EV1 fitted"
> @@ -219,3 +225,5 @@ config SND_SOC_IMX_MC13783
>  	select SND_SOC_IMX_PCM_DMA
>  
>  endif # SND_IMX_SOC
> +
> +endmenu
> -- 
> 1.8.3.2
> 
