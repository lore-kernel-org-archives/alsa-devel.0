From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: uda134x: fix bias level setup on
	initialization and runtime
Date: Thu, 24 Jun 2010 12:34:16 +0100
Message-ID: <363D67C2-D730-4665-B88A-EC92CC1A19D1@opensource.wolfsonmicro.com>
References: <1277378228-29658-1-git-send-email-vzapolskiy@gmail.com>
	<1277378228-29658-2-git-send-email-vzapolskiy@gmail.com>
	(sfid-20100624_121757_556521_CC32F796)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D1F4310380D
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 13:34:19 +0200 (CEST)
In-Reply-To: <1277378228-29658-2-git-send-email-vzapolskiy@gmail.com>
	(sfid-20100624_121757_556521_CC32F796)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 24 Jun 2010, at 12:17, Vladimir Zapolskiy wrote:

> 		/* ADC, DAC on */
> -		reg = uda134x_read_reg_cache(codec, UDA134X_STATUS1);
> -		uda134x_write(codec, UDA134X_STATUS1, reg | 0x03);
> +		if (pd->model == UDA134X_UDA1341) {
> +			reg = uda134x_read_reg_cache(codec, UDA134X_STATUS1);
> +			uda134x_write(codec, UDA134X_STATUS1, reg | 0x03);
> +		} else {
> +			reg = uda134x_read_reg_cache(codec, UDA134X_DATA011);
> +			uda134x_write(codec, UDA134X_DATA011, reg | 0x03);
> +		}

I'd be more comfortable if these used switch statements. That way any further
device specifics will slot in more easily.

Of course, this should really be using DAPM...

> 
> @@ -531,9 +541,7 @@ static int uda134x_soc_probe(struct platform_device *pdev)
> 	codec->num_dai = 1;
> 	codec->read = uda134x_read_reg_cache;
> 	codec->write = uda134x_write;
> -#ifdef POWER_OFF_ON_STANDBY
> -	codec->set_bias_level = uda134x_set_bias_level;
> -#endif
> +

These changes for the bias level configuration look to be unrelated to the addition of
the new CODEC and should be split into a separate patch. It'd also be much better to
remove this ifdefery, it should be handled via platform data or just done unconditionally.
