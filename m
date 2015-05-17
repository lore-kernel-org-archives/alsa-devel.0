From: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v2 05/13] ASoC: qcom: support bitclk and osrclk per i2s
 port
Date: Sun, 17 May 2015 09:14:44 -0700
Message-ID: <20150517161444.GA10901@kwestfie-linux.qualcomm.com>
References: <1431779462-1732-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1431779562-2034-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431779562-2034-1-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 16, 2015 at 05:32:42AM -0700, Srinivas Kandagatla wrote:
> This patch adds support to allow bitclk and osrclk per i2s dai port.
> on APQ8016 there are 4 i2s ports each one has its own bit clks.
> 
> Without this patch its not possible to support multiple i2s ports in the
> lpass driver.

> @@ -400,18 +402,34 @@ int asoc_qcom_lpass_cpu_platform_probe(struct
> platform_device *pdev)
>  	if (variant->init)
>  		variant->init(pdev);
>  
> -	drvdata->mi2s_osr_clk = devm_clk_get(&pdev->dev, "mi2s-osr-clk");
> -	if (IS_ERR(drvdata->mi2s_osr_clk)) {
> -		dev_err(&pdev->dev, "%s() error getting mi2s-osr-clk:
> %ld\n",
> -				__func__, PTR_ERR(drvdata->mi2s_osr_clk));
> -		return PTR_ERR(drvdata->mi2s_osr_clk);
> -	}
> -
> -	drvdata->mi2s_bit_clk = devm_clk_get(&pdev->dev, "mi2s-bit-clk");
> -	if (IS_ERR(drvdata->mi2s_bit_clk)) {
> -		dev_err(&pdev->dev, "%s() error getting mi2s-bit-clk:
> %ld\n",
> -				__func__, PTR_ERR(drvdata->mi2s_bit_clk));
> -		return PTR_ERR(drvdata->mi2s_bit_clk);
> +	for (i = 0; i < variant->num_dai; i++) {
> +		dai_id = variant->dai_driver[i].id;
> +		if (variant->num_dai > 1)
> +			sprintf(clk_name, "mi2s-osr-clk%d", i);
> +		else
> +			sprintf(clk_name, "mi2s-osr-clk");
> +
> +		drvdata->mi2s_osr_clk[dai_id] = devm_clk_get(&pdev->dev,
> +								clk_name);
> +		if (IS_ERR(drvdata->mi2s_osr_clk[dai_id])) {
> +			dev_err(&pdev->dev,
> +				"%s() error getting mi2s-osr-clk: %ld\n",
> +				__func__,
> +			return PTR_ERR(drvdata->mi2s_osr_clk[dai_id]));

Should the previous two lines be:

+                             __func__, PTR_ERR(drvdata->mi2s_osr_clk[dai_id]));
+                     return PTR_ERR(drvdata->mi2s_osr_clk[dai_id]);

as you remove the return in patch 6?

> +		}
> +
> +		if (variant->num_dai > 1)
> +			sprintf(clk_name, "mi2s-bit-clk%d", i);
> +		else
> +			sprintf(clk_name, "mi2s-bit-clk");
> +
> +		drvdata->mi2s_bit_clk[dai_id] = devm_clk_get(&pdev->dev,
> clk_name);
> +		if (IS_ERR(drvdata->mi2s_bit_clk[dai_id])) {
> +			dev_err(&pdev->dev,
> +				"%s() error getting mi2s-bit-clk: %ld\n",
> +				__func__,
> PTR_ERR(drvdata->mi2s_bit_clk[i]));
> +			return PTR_ERR(drvdata->mi2s_bit_clk[dai_id]);
> +		}
>  	}

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
