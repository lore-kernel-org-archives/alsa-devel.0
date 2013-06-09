From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/4] ASoC: codecs: adau1701: add support
	for pin muxing
Date: Sun, 09 Jun 2013 19:43:51 +0200
Message-ID: <51B4BED7.4060006@metafoo.de>
References: <1370605987-19290-1-git-send-email-zonque@gmail.com>
 <1370605987-19290-5-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EE5E26030F
 for <alsa-devel@alsa-project.org>; Sun,  9 Jun 2013 19:40:30 +0200 (CEST)
In-Reply-To: <1370605987-19290-5-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

> @@ -653,6 +676,13 @@ static int adau1701_i2c_probe(struct i2c_client *client,
>  
>  		of_property_read_u32(dev->of_node, "adi,pll-clkdiv",
>  				     &adau1701->pll_clkdiv);
> +		pin_config32 = of_get_property(dev->of_node,
> +					       "adi,pin-config", &size);
> +		size /= sizeof(u32);
> +		size = min(ARRAY_SIZE(adau1701->pin_config), size);
> +
> +		for (i = 0; i < size; i++)
> +			adau1701->pin_config[i] = be32_to_cpup(pin_config32 + i);
>  	}

of_property_read_u32_array

>  
>  	if (gpio_is_valid(gpio_nreset)) {
