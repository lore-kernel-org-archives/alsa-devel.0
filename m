From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: eve: Enable mclk and ssp sclk
	early
Date: Mon, 18 Sep 2017 09:12:36 +0530
Message-ID: <20170918034236.GH30097@localhost>
References: <1504794565-19168-1-git-send-email-subhransu.s.prusty@intel.com>
 <1505012579-19568-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 270FF266819
 for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2017 05:38:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1505012579-19568-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen M <naveen.m@intel.com>
Cc: Harsha Priya <harshapriya.n@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 10, 2017 at 08:32:59AM +0530, Naveen M wrote:
> rt5663 needs mclk/sclk early to synchronize its internal clocks.
> Clocks are enabled in hw_params and disabled in platform_clk_control
> as the codec requires mclk/bclk need to turned ON before set_sysclk
> call for a successful clock synchronization.

This would be dependent on the series Subhransu posted right? If so please
do mention that

> +static int kabylake_enable_ssp_clks(struct snd_soc_card *card)
> +{
> +

we don't need the empty line here

> +	struct kbl_codec_private *priv = snd_soc_card_get_drvdata(card);
> +	int ret;
> +
> +	/* Enable MCLK */
> +	ret = clk_set_rate(priv->mclk, 24000000);
> +	if (ret < 0) {
> +		dev_err(card->dev, "Can't set rate for mclk, err: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(priv->mclk);
> +	if (ret < 0) {
> +		dev_err(card->dev, "Can't enable mclk, err: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Enable SCLK */
> +	ret = clk_set_rate(priv->sclk, 3072000);

why do we need both mclk and sclk for this codec? One should be enough for
codec to sync

> +	if (ret < 0) {
> +		dev_err(card->dev, "Can't set rate for sclk, err: %d\n", ret);
> +		clk_disable_unprepare(priv->mclk);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(priv->sclk);
> +	if (ret < 0) {
> +		dev_err(card->dev, "Can't enable sclk, err: %d\n", ret);
> +		clk_disable_unprepare(priv->mclk);
> +	}
> +
> +	return 0;

this looks wrong to me, shouldn't this be return ret;

> @@ -647,6 +710,7 @@ static int kabylake_audio_probe(struct platform_device *pdev)
>  {
>  	struct kbl_codec_private *ctx;
>  	struct skl_machine_pdata *pdata;
> +	int ret = 0;
>  
>  	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
>  	if (!ctx)
> @@ -662,6 +726,34 @@ static int kabylake_audio_probe(struct platform_device *pdev)
>  		dmic_constraints = pdata->dmic_num == 2 ?
>  			&constraints_dmic_2ch : &constraints_dmic_channels;
>  
> +	ctx->mclk = devm_clk_get(&pdev->dev, "ssp1_mclk");
> +	if (IS_ERR(ctx->mclk)) {
> +		ret = PTR_ERR(ctx->mclk);
> +		if (ret == -ENOENT) {
> +			dev_info(&pdev->dev,
> +				"Failed to get ssp1_mclk, defer probe\n");

can you check this, I think driver core emits warnings as well, so do we
need it here?

> +			return -EPROBE_DEFER;
> +		}
> +
> +		dev_err(&pdev->dev, "Failed to get ssp1_mclk with err:%d\n",
> +								ret);
> +		return ret;
> +	}
> +
> +	ctx->sclk = devm_clk_get(&pdev->dev, "ssp1_sclk");
> +	if (IS_ERR(ctx->sclk)) {
> +		ret = PTR_ERR(ctx->sclk);
> +		if (ret == -ENOENT) {
> +			dev_info(&pdev->dev,
> +				"Failed to get ssp1_sclk, defer probe\n");

shouldn't the mclk ref be given back?

-- 
~Vinod
