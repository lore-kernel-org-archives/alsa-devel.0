From: Sangbeom Kim <sbkim73@samsung.com>
Subject: RE: [PATCH] ASoC: samsung: Fix checking return value of clk_get
Date: Thu, 15 Sep 2011 11:17:03 +0900
Message-ID: <00ba01cc734d$8f9bf320$aed3d960$@com>
References: <1315925062.6042.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1315925062.6042.1.camel@phoenix>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Axel Lin' <axel.lin@gmail.com>, linux-kernel@vger.kernel.org
Cc: 'Christian Pellegrin' <chripell@evolware.org>, 'Ben Dooks' <ben@simtec.co.uk>, 'Jassi Brar' <jassisinghbrar@gmail.com>, 'Liam Girdwood' <lrg@ti.com>, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-09-13 at 22:44 +0800, Axel Lin wrote:
>  	s3c2412_i2s.iis_cclk = clk_get(dai->dev, "i2sclk");
> -	if (s3c2412_i2s.iis_cclk == NULL) {
> +	if (IS_ERR(s3c2412_i2s.iis_cclk)) {
>  		pr_err("failed to get i2sclk clock\n");
>  		iounmap(s3c2412_i2s.regs);
>  		return -ENODEV;
Why don't you use PTR_ERR() for return value?

> diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-
> i2s.c
> index 63d8849..9f888bc 100644
> --- a/sound/soc/samsung/s3c24xx-i2s.c
> +++ b/sound/soc/samsung/s3c24xx-i2s.c
> @@ -383,7 +383,7 @@ static int s3c24xx_i2s_probe(struct snd_soc_dai *dai)
>  		return -ENXIO;
> 
>  	s3c24xx_i2s.iis_clk = clk_get(dai->dev, "iis");
> -	if (s3c24xx_i2s.iis_clk == NULL) {
> +	if (IS_ERR(s3c24xx_i2s.iis_clk)) {
>  		pr_err("failed to get iis_clock\n");
>  		iounmap(s3c24xx_i2s.regs);
>  		return -ENODEV;
Ditto

> diff --git a/sound/soc/samsung/s3c24xx_uda134x.c
> b/sound/soc/samsung/s3c24xx_uda134x.c
> index dc9d551..4da57cd 100644
> --- a/sound/soc/samsung/s3c24xx_uda134x.c
> +++ b/sound/soc/samsung/s3c24xx_uda134x.c
> @@ -66,13 +66,13 @@ static int s3c24xx_uda134x_startup(struct
> snd_pcm_substream *substream)
>  	pr_debug("%s %d\n", __func__, clk_users);
>  	if (clk_users == 0) {
>  		xtal = clk_get(&s3c24xx_uda134x_snd_device->dev, "xtal");
> -		if (!xtal) {
> +		if (IS_ERR(xtal)) {
>  			printk(KERN_ERR "%s cannot get xtal\n", __func__);
>  			ret = -EBUSY;
Ditto

>  		} else {
>  			pclk = clk_get(&s3c24xx_uda134x_snd_device->dev,
>  				       "pclk");
> -			if (!pclk) {
> +			if (IS_ERR(pclk)) {
>  				printk(KERN_ERR "%s cannot get pclk\n",
>  				       __func__);
>  				clk_put(xtal);
> --
> 1.7.4.1
> 

Thanks,

Sangbeom
