From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v2] ASoC: atmel: Remove redundant dev_err()
 call in probe function
Date: Thu, 1 Mar 2018 14:42:54 +0100
Message-ID: <20180301134254.GW1479@piout.net>
References: <20180301133731.GA30722@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id D0BD926790A
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 14:42:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180301133731.GA30722@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: alsa-devel@alsa-project.org

On 01/03/2018 at 14:37:31 +0100, Ladislav Michl wrote:
> There is an error message within devm_ioremap_resource already,
> so remove the redundant dev_err() call.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  Changes:
>  - v2: None, just added Ack.
> 
>  sound/soc/atmel/atmel-classd.c | 7 ++-----
>  sound/soc/atmel/atmel-pdmic.c  | 7 ++-----
>  2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
> index 9baaf6bc5fbd..3d70061901a0 100644
> --- a/sound/soc/atmel/atmel-classd.c
> +++ b/sound/soc/atmel/atmel-classd.c
> @@ -583,11 +583,8 @@ static int atmel_classd_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	io_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(io_base)) {
> -		ret =  PTR_ERR(io_base);
> -		dev_err(dev, "failed to remap register memory: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(io_base))
> +		return PTR_ERR(io_base);
>  
>  	dd->phy_base = res->start;
>  	dd->dev = dev;
> diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
> index 94f852574a44..915c2b064de1 100644
> --- a/sound/soc/atmel/atmel-pdmic.c
> +++ b/sound/soc/atmel/atmel-pdmic.c
> @@ -633,11 +633,8 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	io_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(io_base)) {
> -		ret = PTR_ERR(io_base);
> -		dev_err(dev, "failed to remap register memory: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(io_base))
> +		return PTR_ERR(io_base);
>  
>  	dd->phy_base = res->start;
>  
> -- 
> 2.16.2
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
