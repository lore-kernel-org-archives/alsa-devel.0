From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Use
	devm_snd_soc_register_component()
Date: Thu, 9 Apr 2015 11:32:17 -0700
Message-ID: <20150409183216.GB3171@Asurada-CZ80>
References: <1428602201-17923-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id EF6A7265AE4
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 20:32:20 +0200 (CEST)
Received: by pdea3 with SMTP id a3so161563787pde.3
 for <alsa-devel@alsa-project.org>; Thu, 09 Apr 2015 11:32:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1428602201-17923-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 09, 2015 at 02:56:41PM -0300, Fabio Estevam wrote:
> Using devm_snd_soc_register_component() can make the code shorter and
> cleaner.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you
Nicolin

> ---
>  sound/soc/fsl/fsl_ssi.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 6b0c8f7..143cc16 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -1393,8 +1393,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> -	ret = snd_soc_register_component(&pdev->dev, &fsl_ssi_component,
> -					 &ssi_private->cpu_dai_drv, 1);
> +	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_ssi_component,
> +					      &ssi_private->cpu_dai_drv, 1);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register DAI: %d\n", ret);
>  		goto error_asoc_register;
> @@ -1407,13 +1407,13 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "could not claim irq %u\n",
>  					ssi_private->irq);
> -			goto error_irq;
> +			goto error_asoc_register;
>  		}
>  	}
>  
>  	ret = fsl_ssi_debugfs_create(&ssi_private->dbg_stats, &pdev->dev);
>  	if (ret)
> -		goto error_irq;
> +		goto error_asoc_register;
>  
>  	/*
>  	 * If codec-handle property is missing from SSI node, we assume
> @@ -1454,9 +1454,6 @@ done:
>  error_sound_card:
>  	fsl_ssi_debugfs_remove(&ssi_private->dbg_stats);
>  
> -error_irq:
> -	snd_soc_unregister_component(&pdev->dev);
> -
>  error_asoc_register:
>  	if (ssi_private->soc->imx)
>  		fsl_ssi_imx_clean(pdev, ssi_private);
> @@ -1472,7 +1469,6 @@ static int fsl_ssi_remove(struct platform_device *pdev)
>  
>  	if (ssi_private->pdev)
>  		platform_device_unregister(ssi_private->pdev);
> -	snd_soc_unregister_component(&pdev->dev);
>  
>  	if (ssi_private->soc->imx)
>  		fsl_ssi_imx_clean(pdev, ssi_private);
> -- 
> 1.9.1
> 
