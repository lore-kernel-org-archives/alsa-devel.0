From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: fsl: Drop SND_SOC_FSL_UTILS from
	i.mx machine code
Date: Sun, 18 Aug 2013 13:23:16 +0800
Message-ID: <20130818052314.GB1545@S2101-09.ap.freescale.net>
References: <1376768292-852-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 7723B260319
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 07:22:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1376768292-852-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 17, 2013 at 04:38:12PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> SND_SOC_FSL_UTILS is only used by PowerPC machines, so let's drop it in the
> i.mx case.

Yes, that's true since commit 8f549d7 (ASoC: fsl: remove helper
fsl_asoc_get_codec_dev_name), so,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  sound/soc/fsl/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index e15f771..3a4808d 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -175,7 +175,6 @@ config SND_SOC_IMX_WM8962
>  	select SND_SOC_IMX_PCM_DMA
>  	select SND_SOC_IMX_AUDMUX
>  	select SND_SOC_FSL_SSI
> -	select SND_SOC_FSL_UTILS
>  	help
>  	  Say Y if you want to add support for SoC audio on an i.MX board with
>  	  a wm8962 codec.
> @@ -187,7 +186,6 @@ config SND_SOC_IMX_SGTL5000
>  	select SND_SOC_IMX_PCM_DMA
>  	select SND_SOC_IMX_AUDMUX
>  	select SND_SOC_FSL_SSI
> -	select SND_SOC_FSL_UTILS
>  	help
>  	  Say Y if you want to add support for SoC audio on an i.MX board with
>  	  a sgtl5000 codec.
> -- 
> 1.8.1.2
> 
