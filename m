From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: sgtl5000: Let the codec acquire
	its clock
Date: Mon, 10 Jun 2013 23:41:28 +0800
Message-ID: <20130610154126.GF6381@S2101-09.ap.freescale.net>
References: <1370826467-30399-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 by alsa0.perex.cz (Postfix) with ESMTP id C5FD12616FA
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 17:41:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1370826467-30399-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lars@metafoo.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 09, 2013 at 10:07:46PM -0300, Fabio Estevam wrote:
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index a60aaa0..823151b 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -129,20 +129,10 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  	}
>  
>  	data->codec_clk = clk_get(&codec_dev->dev, NULL);
> -	if (IS_ERR(data->codec_clk)) {
> -		/* assuming clock enabled by default */
> -		data->codec_clk = NULL;
> -		ret = of_property_read_u32(codec_np, "clock-frequency",
> -					&data->clk_frequency);
> -		if (ret) {
> -			dev_err(&codec_dev->dev,
> -				"clock-frequency missing or invalid\n");
> -			goto fail;
> -		}
> -	} else {
> -		data->clk_frequency = clk_get_rate(data->codec_clk);
> -		clk_prepare_enable(data->codec_clk);
> -	}
> +	if (IS_ERR(data->codec_clk))
> +		goto fail;
> +
> +	data->clk_frequency = clk_get_rate(data->codec_clk);
>  
>  	data->dai.name = "HiFi";
>  	data->dai.stream_name = "HiFi";
> @@ -157,10 +147,10 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  	data->card.dev = &pdev->dev;
>  	ret = snd_soc_of_parse_card_name(&data->card, "model");
>  	if (ret)
> -		goto clk_fail;
> +		goto fail;
>  	ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");
>  	if (ret)
> -		goto clk_fail;
> +		goto fail;
>  	data->card.num_links = 1;
>  	data->card.owner = THIS_MODULE;
>  	data->card.dai_link = &data->dai;
> @@ -170,7 +160,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  	ret = snd_soc_register_card(&data->card);
>  	if (ret) {
>  		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
> -		goto clk_fail;
> +		goto fail;
>  	}
>  
>  	platform_set_drvdata(pdev, data);
> @@ -179,8 +169,6 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -clk_fail:
> -	clk_put(data->codec_clk);

Why can this clk_put() be removed now?

>  fail:
>  	if (ssi_np)
>  		of_node_put(ssi_np);
> @@ -194,10 +182,6 @@ static int imx_sgtl5000_remove(struct platform_device *pdev)
>  {
>  	struct imx_sgtl5000_data *data = platform_get_drvdata(pdev);
>  
> -	if (data->codec_clk) {
> -		clk_disable_unprepare(data->codec_clk);
> -		clk_put(data->codec_clk);

Ditto

Shawn

> -	}
>  	snd_soc_unregister_card(&data->card);
>  
>  	return 0;
> -- 
> 1.8.1.2
> 
