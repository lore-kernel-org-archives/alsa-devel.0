From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: mxs-saif: Remove platform data
Date: Wed, 31 Oct 2012 14:40:12 +0800
Message-ID: <20121031064010.GC8100@S2100-06.ap.freescale.net>
References: <1351653605-30512-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 2683E2615E4
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 07:15:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1351653605-30512-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, dong.aisheng@linaro.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 31, 2012 at 01:20:04AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> All MXS users have been converted to device tree and the board files have been
> removed.
> 
> No need to keep platform data in the driver.
>   
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  sound/soc/mxs/mxs-saif.c |    8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
> index aa037b2..7c3154d 100644
> --- a/sound/soc/mxs/mxs-saif.c
> +++ b/sound/soc/mxs/mxs-saif.c
> @@ -652,7 +652,6 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct resource *iores, *dmares;
>  	struct mxs_saif *saif;
> -	struct mxs_saif_platform_data *pdata;

Remove the definition of "struct mxs_saif_platform_data" altogether?

Shawn

>  	struct pinctrl *pinctrl;
>  	int ret = 0;
>  
> @@ -682,13 +681,6 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
>  			if (saif->master_id < 0)
>  				return saif->master_id;
>  		}
> -	} else {
> -		saif->id = pdev->id;
> -		pdata = pdev->dev.platform_data;
> -		if (pdata && !pdata->master_mode)
> -			saif->master_id = pdata->master_id;
> -		else
> -			saif->master_id = saif->id;
>  	}
>  
>  	if (saif->master_id < 0 || saif->master_id >= ARRAY_SIZE(mxs_saif)) {
> -- 
> 1.7.9.5
> 
