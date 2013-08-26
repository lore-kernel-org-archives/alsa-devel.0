From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v2 1/2] ASoC: fsl_spdif: Remove unnecessary
 dev_set_drvdata()
Date: Mon, 26 Aug 2013 14:05:56 +0800
Message-ID: <20130826060556.GA12524@MrMyself>
References: <1377292486-7591-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 30A712608A1
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2013 08:14:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1377292486-7591-1-git-send-email-festevam@gmail.com>
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

Good to know this. Thank you :)

Acked-by: Nicolin Chen <b42378@freescale.com>
(
 I'm not sure if I can use 'Acked-by'.
 If not, pls replace it to 'Reviewed-by'
 Thanks a lot.
)

On Fri, Aug 23, 2013 at 06:14:45PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Driver core clears the driver data to NULL after device_release or on probe 
> failure, so just remove it from here.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Also remove dev_set_drvdata from the remove function
> 
>  sound/soc/fsl/fsl_spdif.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 42a4382..a8ef46a 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -1184,7 +1184,7 @@ static int fsl_spdif_probe(struct platform_device *pdev)
>  					 &spdif_priv->cpu_dai_drv, 1);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register DAI: %d\n", ret);
> -		goto error_dev;
> +		return ret;
>  	}
>  
>  	ret = imx_pcm_dma_init(pdev);
> @@ -1197,8 +1197,6 @@ static int fsl_spdif_probe(struct platform_device *pdev)
>  
>  error_component:
>  	snd_soc_unregister_component(&pdev->dev);
> -error_dev:
> -	dev_set_drvdata(&pdev->dev, NULL);
>  
>  	return ret;
>  }
> @@ -1207,7 +1205,6 @@ static int fsl_spdif_remove(struct platform_device *pdev)
>  {
>  	imx_pcm_dma_exit(pdev);
>  	snd_soc_unregister_component(&pdev->dev);
> -	dev_set_drvdata(&pdev->dev, NULL);
>  
>  	return 0;
>  }
> -- 
> 1.8.1.2
> 
> 
