From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: add wm8960 support
Date: Tue, 11 Aug 2015 20:42:59 -0700
Message-ID: <20150812034257.GA2980@Asurada-CZ80>
References: <dc4e5a52a90982cea95445e27a30f2ad6cb73513.1439349623.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id B317F2605E8
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 05:43:05 +0200 (CEST)
Received: by pacgr6 with SMTP id gr6so4782935pac.2
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 20:43:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <dc4e5a52a90982cea95445e27a30f2ad6cb73513.1439349623.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 12, 2015 at 11:22:30AM +0800, Zidan Wang wrote:
> add wm8960 support for fsl-asoc-card
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

> +	gpr_np = of_parse_phandle(np, "gpr", 0);
> +	if (gpr_np) {
> +		priv->gpr = syscon_node_to_regmap(gpr_np);
> +		if (IS_ERR(priv->gpr)) {
> +			ret = PTR_ERR(priv->gpr);
> +			dev_err(&pdev->dev, "failed to get gpr regmap\n");
> +			goto fail;
> +		}
> +		/*
> +		 * for imx6ul we should set SAI2_MCLK_DIR to enable
> +		 * codec MCLK
> +		 */
> +		if (of_device_is_compatible(np, "fsl,imx6ul-evk-wm8960"))
> +			regmap_update_bits(priv->gpr, 4, 1 << 20, 1 << 20);

What's this SAI2_MCLK_DIR? Can you provide the description of it?

And why not put it inside:
 +	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8960")) {
 +		priv->card.set_bias_level = fsl_asoc_card_set_bias_level;
 +		priv->codec_priv.fll_id = WM8960_SYSCLK_AUTO;
 +		priv->codec_priv.pll_id = WM8960_SYSCLK_AUTO;
 +		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;

> @@ -521,7 +545,10 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  	/* Normal DAI Link */
>  	priv->dai_link[0].cpu_of_node = cpu_np;
>  	priv->dai_link[0].codec_of_node = codec_np;
> -	priv->dai_link[0].codec_dai_name = codec_dev->name;
> +	if (strstr(codec_dev->name, "wm8960"))
> +		priv->dai_link[0].codec_dai_name = "wm8960-hifi";
> +	else
> +		priv->dai_link[0].codec_dai_name = codec_dev->name;

What happens to the codec_dev->name over here so that you need to
specify the name?

Nicolin
