From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: add wm8960 support
Date: Wed, 12 Aug 2015 12:45:10 +0800
Message-ID: <20150812044505.GA21786@shlinux2>
References: <dc4e5a52a90982cea95445e27a30f2ad6cb73513.1439349623.git.zidan.wang@freescale.com>
 <20150812034257.GA2980@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0129.outbound.protection.outlook.com [65.55.169.129])
 by alsa0.perex.cz (Postfix) with ESMTP id D185226062B
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 07:55:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150812034257.GA2980@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 11, 2015 at 08:42:59PM -0700, Nicolin Chen wrote:
> On Wed, Aug 12, 2015 at 11:22:30AM +0800, Zidan Wang wrote:
> > add wm8960 support for fsl-asoc-card
> > 
> > Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> 
> > +	gpr_np = of_parse_phandle(np, "gpr", 0);
> > +	if (gpr_np) {
> > +		priv->gpr = syscon_node_to_regmap(gpr_np);
> > +		if (IS_ERR(priv->gpr)) {
> > +			ret = PTR_ERR(priv->gpr);
> > +			dev_err(&pdev->dev, "failed to get gpr regmap\n");
> > +			goto fail;
> > +		}
> > +		/*
> > +		 * for imx6ul we should set SAI2_MCLK_DIR to enable
> > +		 * codec MCLK
> > +		 */
> > +		if (of_device_is_compatible(np, "fsl,imx6ul-evk-wm8960"))
> > +			regmap_update_bits(priv->gpr, 4, 1 << 20, 1 << 20);
> 
> What's this SAI2_MCLK_DIR? Can you provide the description of it?
SAI2_MCLK_DIR: SD1_CLK data direction control when sai2.MCLK is selected (ALT2)
0 SD1_CLK output driver is disabled when configured for ALT2
1 SD1_CLK output driver is enabled when configured for ALT2

We are using SAI2 now, so we should enable SAI2_MCLK_DIR. If we want to use SAI1 and SAI3, we should also enable SAI1_MCLK_DIR and SAI3_MCLK_DIR. I don't consider SAI1 and SAI3 case, should i add it like below:

gpr = <&gpr reg shift val>

> 
> And why not put it inside:
>  +	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8960")) {
>  +		priv->card.set_bias_level = fsl_asoc_card_set_bias_level;
>  +		priv->codec_priv.fll_id = WM8960_SYSCLK_AUTO;
>  +		priv->codec_priv.pll_id = WM8960_SYSCLK_AUTO;
>  +		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
> 

Just imx6ul should enable such bit. Put inside is also ok.


> > @@ -521,7 +545,10 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
> >  	/* Normal DAI Link */
> >  	priv->dai_link[0].cpu_of_node = cpu_np;
> >  	priv->dai_link[0].codec_of_node = codec_np;
> > -	priv->dai_link[0].codec_dai_name = codec_dev->name;
> > +	if (strstr(codec_dev->name, "wm8960"))
> > +		priv->dai_link[0].codec_dai_name = "wm8960-hifi";
> > +	else
> > +		priv->dai_link[0].codec_dai_name = codec_dev->name;
> 
> What happens to the codec_dev->name over here so that you need to
> specify the name?
In wm8960 codec driver, codec dai name is "wm8960-hifi". Using codec_dev->name will cauce register card failed.

> 
> Nicolin
