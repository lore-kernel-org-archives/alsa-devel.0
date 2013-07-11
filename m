From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 6/6] ASoC: omap-dmic: Cleanup the probe
	function
Date: Thu, 11 Jul 2013 13:10:02 +0200
Message-ID: <51DE928A.4090402@metafoo.de>
References: <1373537930-10467-1-git-send-email-peter.ujfalusi@ti.com>
 <1373537930-10467-7-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-052.synserver.de (smtp-out-052.synserver.de
 [212.40.185.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D7112657BC
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 13:09:25 +0200 (CEST)
In-Reply-To: <1373537930-10467-7-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 07/11/2013 12:18 PM, Peter Ujfalusi wrote:
> Move the clk_get later in the function. In this way we do not need to use
> goto in other error cases.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

How about using devm_clk_get?

> ---
>  sound/soc/omap/omap-dmic.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
> index f66b033..1b6c507 100644
> --- a/sound/soc/omap/omap-dmic.c
> +++ b/sound/soc/omap/omap-dmic.c
> @@ -463,17 +463,10 @@ static int asoc_dmic_probe(struct platform_device *pdev)
>  
>  	mutex_init(&dmic->mutex);
>  
> -	dmic->fclk = clk_get(dmic->dev, "fck");
> -	if (IS_ERR(dmic->fclk)) {
> -		dev_err(dmic->dev, "cant get fck\n");
> -		return -ENODEV;
> -	}
> -
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
>  	if (!res) {
>  		dev_err(dmic->dev, "invalid dma memory resource\n");
> -		ret = -ENODEV;
> -		goto err_put_clk;
> +		return -ENODEV;
>  	}
>  	dmic->dma_data.addr = res->start + OMAP_DMIC_DATA_REG;
>  
> @@ -482,23 +475,24 @@ static int asoc_dmic_probe(struct platform_device *pdev)
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
>  	if (!res) {
>  		dev_err(dmic->dev, "invalid memory resource\n");
> -		ret = -ENODEV;
> -		goto err_put_clk;
> +		return -ENODEV;
>  	}
>  
>  	dmic->io_base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(dmic->io_base))
>  		return PTR_ERR(dmic->io_base);
>  
> +	dmic->fclk = clk_get(dmic->dev, "fck");
> +	if (IS_ERR(dmic->fclk)) {
> +		dev_err(dmic->dev, "cant get fck\n");
> +		return -ENODEV;
> +	}
> +
>  	ret = snd_soc_register_component(&pdev->dev, &omap_dmic_component,
>  					 &omap_dmic_dai, 1);
>  	if (ret)
> -		goto err_put_clk;
> -
> -	return 0;
> +		clk_put(dmic->fclk);
>  
> -err_put_clk:
> -	clk_put(dmic->fclk);
>  	return ret;
>  }
>  
