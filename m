From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: suppress error
 message for EPROBE_DEFER
Date: Fri, 19 Jul 2019 10:45:34 -0400
Message-ID: <4018df8f-3d34-a62f-8e83-14dd0dece94d@ti.com>
References: <20190719143637.2018-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76E40F80363
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2019 16:45:37 +0200 (CEST)
In-Reply-To: <20190719143637.2018-1-l.stach@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Lucas Stach <l.stach@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On 7/19/19 10:36 AM, Lucas Stach wrote:
> Both the supplies and reset GPIO might need a probe deferral for the
> resource to be available. Don't print a error message in that case, as
> it is a normal operating condition.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  sound/soc/codecs/tlv320aic31xx.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
> index 9b37e98da0db..26a4f6cd3288 100644
> --- a/sound/soc/codecs/tlv320aic31xx.c
> +++ b/sound/soc/codecs/tlv320aic31xx.c
> @@ -1553,7 +1553,8 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
>  	aic31xx->gpio_reset = devm_gpiod_get_optional(aic31xx->dev, "reset",
>  						      GPIOD_OUT_LOW);
>  	if (IS_ERR(aic31xx->gpio_reset)) {
> -		dev_err(aic31xx->dev, "not able to acquire gpio\n");
> +		if (PTR_ERR(aic31xx->gpio_reset) != -EPROBE_DEFER)
> +			dev_err(aic31xx->dev, "not able to acquire gpio\n");
>  		return PTR_ERR(aic31xx->gpio_reset);
>  	}
>  
> @@ -1564,7 +1565,9 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
>  				      ARRAY_SIZE(aic31xx->supplies),
>  				      aic31xx->supplies);
>  	if (ret) {
> -		dev_err(aic31xx->dev, "Failed to request supplies: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(aic31xx->dev,
> +				"Failed to request supplies: %d\n", ret);


I can't be the only one who thinks this looks much less readable than
just breaking the 80 char line by a little..

All these one-off handlers for probe defer are cluttering the code base,
was there some issue with just yielding for a time in these _get()
functions until the device finally probes?

Anyway that's unrelated to this, for this patch:

Acked-by: Andrew F. Davis <afd@ti.com>


>  		return ret;
>  	}
>  
> 
