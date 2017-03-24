From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: imx-wm8960: Let codec driver
 enable/disable its MCLK
Date: Fri, 24 Mar 2017 10:48:31 -0700
Message-ID: <20170324174830.GA3896@Asurada-Nvidia>
References: <1490346888-30937-1-git-send-email-daniel.baluta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A88EE2669DD
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 18:47:48 +0100 (CET)
Received: by mail-pg0-f65.google.com with SMTP id 81so1685298pgh.3
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 10:47:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1490346888-30937-1-git-send-email-daniel.baluta@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: daniel.baluta@nxp.com, alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org, shengjiu.wang@nxp.com, tiwai@suse.com, lgirdwood@gmail.com, timur@tabi.org, mihai.serban@nxp.com, broonie@kernel.org, viorel.suman@nxp.com, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 24, 2017 at 11:14:48AM +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> WM8962 needs its MCLK when powerup in wm8962_resume(). Thus it's better
> to control the MCLK in codec driver. Thus remove the clock enable in
> machine driver accordingly.
> 
> While at it, get rid of imx_wm8962_remove function since it is now
> empty.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
> Changes since v1:
> 	* s/wm8960/imx-wm890/ in subject prefix

imx-wm8962 vs imx-wm8960 :)

> 	* s/dirver/driver in commit message
> 	* took ownership over the patch from Nicolin Chen
> 	as per his agreement.
> 
>  sound/soc/fsl/imx-wm8962.c | 40 ++++++++--------------------------------
>  1 file changed, 8 insertions(+), 32 deletions(-)
> 
> diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
> index 1b60958..3d894d9 100644
> --- a/sound/soc/fsl/imx-wm8962.c
> +++ b/sound/soc/fsl/imx-wm8962.c
> @@ -33,7 +33,6 @@ struct imx_wm8962_data {
>  	struct snd_soc_card card;
>  	char codec_dai_name[DAI_NAME_SIZE];
>  	char platform_name[DAI_NAME_SIZE];
> -	struct clk *codec_clk;
>  	unsigned int clk_frequency;
>  };
>  
> @@ -163,6 +162,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
>  	struct imx_priv *priv = &card_priv;
>  	struct i2c_client *codec_dev;
>  	struct imx_wm8962_data *data;
> +	struct clk *codec_clk;
>  	int int_port, ext_port;
>  	int ret;
>  
> @@ -231,19 +231,14 @@ static int imx_wm8962_probe(struct platform_device *pdev)
>  		goto fail;
>  	}
>  
> -	data->codec_clk = devm_clk_get(&codec_dev->dev, NULL);
> -	if (IS_ERR(data->codec_clk)) {
> -		ret = PTR_ERR(data->codec_clk);
> +	codec_clk = devm_clk_get(&codec_dev->dev, NULL);

I actually just noticed a problem here -- not from your change but
it existed in the first place. IIRC, devm_clk_get() would only be
properly clk_put() for this driver if we passed pdev->dev while we
are using codec_dev->dev. So here we probably should use clk_get()
instead and call a clk_put() right after fetching the clock rate.

Would you please fix this issue along with this change since you
are touching the exact same line of the code?

Thanks
Nicolin

> +	if (IS_ERR(codec_clk)) {
> +		ret = PTR_ERR(codec_clk);
>  		dev_err(&codec_dev->dev, "failed to get codec clk: %d\n", ret);
>  		goto fail;
>  	}
>  
> -	data->clk_frequency = clk_get_rate(data->codec_clk);
> -	ret = clk_prepare_enable(data->codec_clk);
> -	if (ret) {
> -		dev_err(&codec_dev->dev, "failed to enable codec clk: %d\n", ret);
> -		goto fail;
> -	}
> +	data->clk_frequency = clk_get_rate(codec_clk);
>  
>  	data->dai.name = "HiFi";
>  	data->dai.stream_name = "HiFi";
> @@ -258,10 +253,10 @@ static int imx_wm8962_probe(struct platform_device *pdev)
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
> @@ -277,16 +272,9 @@ static int imx_wm8962_probe(struct platform_device *pdev)
>  	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
>  	if (ret) {
>  		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
> -		goto clk_fail;
> +		goto fail;
>  	}
>  
> -	of_node_put(ssi_np);
> -	of_node_put(codec_np);
> -
> -	return 0;
> -
> -clk_fail:
> -	clk_disable_unprepare(data->codec_clk);
>  fail:
>  	of_node_put(ssi_np);
>  	of_node_put(codec_np);
> @@ -294,17 +282,6 @@ static int imx_wm8962_probe(struct platform_device *pdev)
>  	return ret;
>  }
