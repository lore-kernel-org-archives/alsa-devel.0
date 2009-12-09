From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/7] ASoC: S3C64XX: Pass I2S base address
	from platform	data
Date: Wed, 9 Dec 2009 11:09:00 +0000
Message-ID: <20091209110900.GE19851@opensource.wolfsonmicro.com>
References: <1260332994-11535-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B759103863
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 12:09:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1260332994-11535-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassisinghbrar@gmail.com
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 09, 2009 at 01:29:54PM +0900, jassisinghbrar@gmail.com wrote:

> +
> +	if (!request_mem_region(res->start, resource_size(res),
> +							"s3c64xx-i2s")) {
> +		dev_err(&pdev->dev, "Unable to request SFR region\n");
> +		return -EBUSY;
> +	}
> +

This feels like it should be in the patch that requested the resource
rather than here.  Probably ought to have a version that does the
request in 2.6.33 too if we can...

> @@ -191,7 +198,8 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
>  
>  	clk_enable(i2s->iis_cclk);
>  
> -	ret = s3c_i2sv2_probe(pdev, dai, i2s, 0);
> +	ret = s3c_i2sv2_probe(pdev, dai, i2s,
> +			i2s->dma_playback->dma_addr - S3C2412_IISTXD);
>  	if (ret)
>  		goto err_clk;

A comment explaining why we're doing the subtraction wouldn't hurt; the
code is OK.
