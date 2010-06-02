From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] AsoC/s6000: use resource_size for
 {request/release}_mem_region and ioremap
Date: Wed, 2 Jun 2010 11:51:23 +0100
Message-ID: <20100602105123.GB3020@opensource.wolfsonmicro.com>
References: <4C063751.2060001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C4883103853
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 12:51:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C063751.2060001@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 02, 2010 at 06:49:53PM +0800, Wan ZongShun wrote:
> The size calculation is end - start + 1. But,sometimes, the '1' can
> be forgotten carelessly, witch will have potential risk, so use resource_size
> for {request/release}_mem_region and ioremap here should be good habit.
> 
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

CCing in Daniel who wrote the S6000 support.  Daniel, do you want to add
an entry to MAINTAINERS for this stuff or are you happy without having
stuff run past you?

> ---
>  sound/soc/s6000/s6000-i2s.c |   38 +++++++++++++++++---------------------
>  1 files changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/sound/soc/s6000/s6000-i2s.c b/sound/soc/s6000/s6000-i2s.c
> index 5b9ac17..59e3fa7 100644
> --- a/sound/soc/s6000/s6000-i2s.c
> +++ b/sound/soc/s6000/s6000-i2s.c
> @@ -451,16 +451,15 @@ static int __devinit s6000_i2s_probe(struct platform_device *pdev)
>  		goto err_release_none;
>  	}
> 
> -	region = request_mem_region(scbmem->start,
> -				    scbmem->end - scbmem->start + 1,
> -				    pdev->name);
> +	region = request_mem_region(scbmem->start, resource_size(scbmem),
> +								pdev->name);
>  	if (!region) {
>  		dev_err(&pdev->dev, "I2S SCB region already claimed\n");
>  		ret = -EBUSY;
>  		goto err_release_none;
>  	}
> 
> -	mmio = ioremap(scbmem->start, scbmem->end - scbmem->start + 1);
> +	mmio = ioremap(scbmem->start, resource_size(scbmem));
>  	if (!mmio) {
>  		dev_err(&pdev->dev, "can't ioremap SCB region\n");
>  		ret = -ENOMEM;
> @@ -474,9 +473,8 @@ static int __devinit s6000_i2s_probe(struct platform_device *pdev)
>  		goto err_release_map;
>  	}
> 
> -	region = request_mem_region(sifmem->start,
> -				    sifmem->end - sifmem->start + 1,
> -				    pdev->name);
> +	region = request_mem_region(sifmem->start, resource_size(sifmem),
> +								pdev->name);
>  	if (!region) {
>  		dev_err(&pdev->dev, "I2S SIF region already claimed\n");
>  		ret = -EBUSY;
> @@ -490,8 +488,8 @@ static int __devinit s6000_i2s_probe(struct platform_device *pdev)
>  		goto err_release_sif;
>  	}
> 
> -	region = request_mem_region(dma1->start, dma1->end - dma1->start + 1,
> -				    pdev->name);
> +	region = request_mem_region(dma1->start, resource_size(dma1),
> +								pdev->name);
>  	if (!region) {
>  		dev_err(&pdev->dev, "I2S DMA region already claimed\n");
>  		ret = -EBUSY;
> @@ -500,9 +498,8 @@ static int __devinit s6000_i2s_probe(struct platform_device *pdev)
> 
>  	dma2 = platform_get_resource(pdev, IORESOURCE_DMA, 1);
>  	if (dma2) {
> -		region = request_mem_region(dma2->start,
> -					    dma2->end - dma2->start + 1,
> -					    pdev->name);
> +		region = request_mem_region(dma2->start, resource_size(dma2),
> +								pdev->name);
>  		if (!region) {
>  			dev_err(&pdev->dev,
>  				"I2S DMA region already claimed\n");
> @@ -561,15 +558,15 @@ err_release_dev:
>  	kfree(dev);
>  err_release_dma2:
>  	if (dma2)
> -		release_mem_region(dma2->start, dma2->end - dma2->start + 1);
> +		release_mem_region(dma2->start, resource_size(dma2));
>  err_release_dma1:
> -	release_mem_region(dma1->start, dma1->end - dma1->start + 1);
> +	release_mem_region(dma1->start, resource_size(dma1));
>  err_release_sif:
> -	release_mem_region(sifmem->start, (sifmem->end - sifmem->start) + 1);
> +	release_mem_region(sifmem->start, resource_size(sifmem));
>  err_release_map:
>  	iounmap(mmio);
>  err_release_scb:
> -	release_mem_region(scbmem->start, (scbmem->end - scbmem->start) + 1);
> +	release_mem_region(scbmem->start, resource_size(scbmem));
>  err_release_none:
>  	return ret;
>  }
> @@ -590,19 +587,18 @@ static void __devexit s6000_i2s_remove(struct platform_device *pdev)
>  	kfree(dev);
> 
>  	region = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> -	release_mem_region(region->start, region->end - region->start + 1);
> +	release_mem_region(region->start, resource_size(region));
> 
>  	region = platform_get_resource(pdev, IORESOURCE_DMA, 1);
>  	if (region)
> -		release_mem_region(region->start,
> -				   region->end - region->start + 1);
> +		release_mem_region(region->start, resource_size(region));
> 
>  	region = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	release_mem_region(region->start, (region->end - region->start) + 1);
> +	release_mem_region(region->start, resource_size(region));
> 
>  	iounmap(mmio);
>  	region = platform_get_resource(pdev, IORESOURCE_IO, 0);
> -	release_mem_region(region->start, (region->end - region->start) + 1);
> +	release_mem_region(region->start, resource_size(region));
>  }
> 
>  static struct platform_driver s6000_i2s_driver = {
> -- 
> 1.6.3.3
