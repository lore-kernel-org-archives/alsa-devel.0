From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: multi-component: SAMSUNG: Modify the
	name of I2S driver
Date: Sun, 25 Jul 2010 23:57:03 -0700
Message-ID: <B9F57799-417E-4006-80D4-7768EE347BF5@opensource.wolfsonmicro.com>
References: <4C4CEDE1.5010605@samsung.com>
	(sfid-20100726_031705_187735_0E73D5AC)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC16924677
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 08:56:52 +0200 (CEST)
In-Reply-To: <4C4CEDE1.5010605@samsung.com>
	(sfid-20100726_031705_187735_0E73D5AC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kyungmin Park <kyungmin.park@samsung.com>, "jassi.brar@samsung.com" <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 25 Jul 2010, at 19:07, Chanwoo Choi <cw00.choi@samsung.com> wrote:

> This patch modify the name of I2S driver(S3C64XX/S3C24xx
> /S3C2412) from "*-iis-*" to "*-i2s-*". The mismatch of I2S name
> exist in the following sound driver. These files write the
> "cpu_dai_name" of I2S as "*-i2s-*".
> 
> - sound/soc/s3c24xx/aquila_wm8994.c : "s3c64xx-i2s-v4-dai"
> - sound/soc/s3c24xx/goni_wm8994.c : "s3c64xx-i2s-v4-dai"
> - sound/soc/s3c24xx/smdk64xx_wm8580.c "s3c64xx-i2s-v4-dai"
> - sound/soc/s3c24xx/jive_wm8750.c : "s3c2412-i2s-dai"
> - sound/soc/s3c24xx/neo1973_wm8753.c : "s3c24xx-i2s-dai"
> - sound/soc/s3c24xx/neo1973_gta02_wm8753.c : "s3c24xx-i2s-dai"
> - sound/soc/s3c24xx/s3c24xx_simtec_hermes.c : "s3c24xx-i2s-dai"
> - sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c : "s3c24xx-i2s-dai"
> - sound/soc/s3c24xx/s3c24xx_uda134x.c : "s3c24xx-i2s-dai"
> - sound/soc/s3c24xx/smartq_wm8987.c : "s3c64xx-i2s-dai.0"
> 
> or, It is should modify "cpu_dai_name" of sound drvier files
> instead of modifying the name of I2S driver.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but Jassi really should also comment here.

> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> sound/soc/s3c24xx/s3c2412-i2s.c    |    2 +-
> sound/soc/s3c24xx/s3c24xx-i2s.c    |    2 +-
> sound/soc/s3c24xx/s3c64xx-i2s-v4.c |    2 +-
> sound/soc/s3c24xx/s3c64xx-i2s.c    |    2 +-
> 4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
> index aa116f6..f7c23ae 100644
> --- a/sound/soc/s3c24xx/s3c2412-i2s.c
> +++ b/sound/soc/s3c24xx/s3c2412-i2s.c
> @@ -188,7 +188,7 @@ static struct platform_driver s3c2412_iis_driver = {
>  	.probe  = s3c2412_iis_dev_probe,
>  	.remove = s3c2412_iis_dev_remove,
>  	.driver = {
> -		.name = "s3c2412-iis-dai",
> +		.name = "s3c2412-i2s-dai",
>  		.owner = THIS_MODULE,
>  	},
> };
> diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
> index a6cbeef..20712ad 100644
> --- a/sound/soc/s3c24xx/s3c24xx-i2s.c
> +++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
> @@ -495,7 +495,7 @@ static struct platform_driver s3c24xx_iis_driver = {
>  	.probe  = s3c24xx_iis_dev_probe,
>  	.remove = s3c24xx_iis_dev_remove,
>  	.driver = {
> -		.name = "s3c24xx-iis-dai",
> +		.name = "s3c24xx-i2s-dai",
>  		.owner = THIS_MODULE,
>  	},
> };
> diff --git a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
> index 885040b..2846ea2 100644
> --- a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
> +++ b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
> @@ -195,7 +195,7 @@ static struct platform_driver s3c64xx_i2sv4_driver = {
>  	.probe  = s3c64xx_i2sv4_dev_probe,
>  	.remove = s3c64xx_i2sv4_dev_remove,
>  	.driver = {
> -		.name = "s3c64xx-iis-v4-dai",
> +		.name = "s3c64xx-i2s-v4-dai",
>  		.owner = THIS_MODULE,
>  	},
> };
> diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
> index 161189b..2017639 100644
> --- a/sound/soc/s3c24xx/s3c64xx-i2s.c
> +++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
> @@ -218,7 +218,7 @@ static struct platform_driver s3c64xx_iis_driver = {
>  	.probe  = s3c64xx_iis_dev_probe,
>  	.remove = s3c64xx_iis_dev_remove,
>  	.driver = {
> -		.name = "s3c64xx-iis-dai",
> +		.name = "s3c64xx-i2s-dai",
>  		.owner = THIS_MODULE,
>  	},
> };
> -- 
> 1.6.3.3
> 
