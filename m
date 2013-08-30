From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: Drop SND_SOC_FSL_UTILS from
	SND_SOC_IMX_SPDIF
Date: Fri, 30 Aug 2013 10:19:06 +0800
Message-ID: <20130830021905.GA10481@MrMyself>
References: <1377808301-10344-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6386B2655AA
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2013 04:21:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1377808301-10344-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 29, 2013 at 05:31:41PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> SND_SOC_FSL_UTILS is only used by PowerPC machines, so let's drop it in the
> i.mx case.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Nicolin Chen <b42378@freescale.com>

> ---
>  sound/soc/fsl/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index a708380..704e246 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -197,7 +197,6 @@ config SND_SOC_IMX_SPDIF
>  	tristate "SoC Audio support for i.MX boards with S/PDIF"
>  	select SND_SOC_IMX_PCM_DMA
>  	select SND_SOC_FSL_SPDIF
> -	select SND_SOC_FSL_UTILS
>  	select SND_SOC_SPDIF
>  	help
>  	  SoC Audio support for i.MX boards with S/PDIF
> -- 
> 1.8.1.2
> 
> 
