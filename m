From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [RFT v2 3/3] ASoC: samsung: Add proper error paths
 to s3c24xx I2S driver
Date: Fri, 28 Jul 2017 10:17:02 +0530
Message-ID: <6ee4fbe7-1b0d-d76d-f52e-3ccbe04309c8@gmail.com>
References: <20170727171338.13300-1-krzk@kernel.org>
 <20170727171338.13300-4-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 49DE926761A
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 06:47:49 +0200 (CEST)
Received: by mail-pg0-f67.google.com with SMTP id d193so22453724pgc.2
 for <alsa-devel@alsa-project.org>; Thu, 27 Jul 2017 21:47:49 -0700 (PDT)
In-Reply-To: <20170727171338.13300-4-krzk@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On Thursday 27 July 2017 10:43 PM, Krzysztof Kozlowski wrote:
> s3c2412_i2s_probe() might fail so driver has to revert work done by
> s3c_i2sv2_probe() (clock enabling).  Missing doing this would lead to
> clock enable in-balance.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>
> ---
>
> Please, kindly test on S3C24xx hardware.
>
> Changes since v1:
> 1. Drop clk assignment to disable proper clock on remove()
> ---
>   sound/soc/samsung/s3c-i2s-v2.c  |  9 +++++++++
>   sound/soc/samsung/s3c-i2s-v2.h  |  7 +++++++
>   sound/soc/samsung/s3c2412-i2s.c | 13 +++++++++----
>   3 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
> index 3894bda06ebb..58c3e9bfc6b7 100644
> --- a/sound/soc/samsung/s3c-i2s-v2.c
> +++ b/sound/soc/samsung/s3c-i2s-v2.c
> @@ -651,6 +651,15 @@ int s3c_i2sv2_probe(struct snd_soc_dai *dai,
>   }
>   EXPORT_SYMBOL_GPL(s3c_i2sv2_probe);
>   
> +void s3c_i2sv2_cleanup(struct snd_soc_dai *dai,
> +		      struct s3c_i2sv2_info *i2s)
> +{
> +	clk_disable_unprepare(i2s->iis_pclk);
> +	clk_put(i2s->iis_pclk);
> +	i2s->iis_pclk = NULL;
> +}
> +EXPORT_SYMBOL_GPL(s3c_i2sv2_cleanup);
> +
>   #ifdef CONFIG_PM
>   static int s3c2412_i2s_suspend(struct snd_soc_dai *dai)
>   {
> diff --git a/sound/soc/samsung/s3c-i2s-v2.h b/sound/soc/samsung/s3c-i2s-v2.h
> index 182d80564e37..3fca20f7a853 100644
> --- a/sound/soc/samsung/s3c-i2s-v2.h
> +++ b/sound/soc/samsung/s3c-i2s-v2.h
> @@ -92,6 +92,13 @@ extern int s3c_i2sv2_probe(struct snd_soc_dai *dai,
>   			   unsigned long base);
>   
>   /**
> + * s3c_i2sv2_cleanup - cleanup resources allocated in s3c_i2sv2_probe
> + * @dai: The ASoC DAI structure supplied to the original probe.
> + * @i2s: Our local i2s structure to fill in.
> + */
> +extern void s3c_i2sv2_cleanup(struct snd_soc_dai *dai,
> +			      struct s3c_i2sv2_info *i2s);
> +/**
>    * s3c_i2sv2_register_component - register component and dai with soc core
>    * @dev: DAI device
>    * @id: DAI ID
> diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
> index bcd1cbdeac93..cc0840fff5aa 100644
> --- a/sound/soc/samsung/s3c2412-i2s.c
> +++ b/sound/soc/samsung/s3c2412-i2s.c
> @@ -65,7 +65,8 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
>   	s3c2412_i2s.iis_cclk = devm_clk_get(dai->dev, "i2sclk");
>   	if (IS_ERR(s3c2412_i2s.iis_cclk)) {
>   		pr_err("failed to get i2sclk clock\n");
> -		return PTR_ERR(s3c2412_i2s.iis_cclk);
> +		ret = PTR_ERR(s3c2412_i2s.iis_cclk);
> +		goto err;
>   	}
>   
>   	/* Set MPLL as the source for IIS CLK */
> @@ -73,20 +74,24 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
>   	clk_set_parent(s3c2412_i2s.iis_cclk, clk_get(NULL, "mpll"));
>   	ret = clk_prepare_enable(s3c2412_i2s.iis_cclk);
>   	if (ret)
> -		return ret;
> -
> -	s3c2412_i2s.iis_cclk = s3c2412_i2s.iis_pclk;
> +		goto err;
>   
>   	/* Configure the I2S pins (GPE0...GPE4) in correct mode */
>   	s3c_gpio_cfgall_range(S3C2410_GPE(0), 5, S3C_GPIO_SFN(2),
>   			      S3C_GPIO_PULL_NONE);
>   
>   	return 0;
> +
> +err:
> +	s3c_i2sv2_cleanup(dai, &s3c2412_i2s);
> +
> +	return ret;
>   }
>   
>   static int s3c2412_i2s_remove(struct snd_soc_dai *dai)
>   {
>   	clk_disable_unprepare(s3c2412_i2s.iis_cclk);
> +	s3c_i2sv2_cleanup(dai, &s3c2412_i2s);
>   
>   	return 0;
>   }
