From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V1 1/3] ASoC: fsl_esai: spba clock is
 needed by esai device
Date: Wed, 16 Sep 2015 23:50:57 -0700
Message-ID: <20150917065056.GA54360@Asurada-CZ80>
References: <cover.1442469788.git.shengjiu.wang@freescale.com>
 <dcd22cb04ad5b12478ed9a24ff1462fbc4d5be51.1442469788.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id CB27D26512B
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 08:51:04 +0200 (CEST)
Received: by padhk3 with SMTP id hk3so11899621pad.3
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 23:51:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <dcd22cb04ad5b12478ed9a24ff1462fbc4d5be51.1442469788.git.shengjiu.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, broonie@kernel.org, Xiubo.Lee@gmail.com, timur@tabi.org, lgirdwood@gmail.com, robh+dt@kernel.org, galak@codeaurora.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Sep 17, 2015 at 02:09:23PM +0800, Shengjiu Wang wrote:
> esai need to enable the spba clock, when sdma is using share peripheral
> script. If don't enable it, may cause the read/write wrong data from/to
> register.

It would be nicer to elaborate the SPBA as well, especially
the reason why it "may cause the read/write wrong data from/to
register".

> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>

> diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
> index d3b6b5f..d677203 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,esai.txt
> @@ -27,6 +27,8 @@ Required properties:
>  			  derive HCK, SCK and FS.
>  	"fsys"		  The system clock derived from ahb clock used to
>  			  derive HCK, SCK and FS.
> +	"dma"		  The spba clock is needed when sdma share peripheral
> +			  script is used.

It would be better to treat it as an optional property as ESAI
itself doesn't require it to be enabled while a specific SDMA
script does so as to access the registers successfully via the
arbiter. There is one of existing SoCs that doesn't have SDMA
and SPBA at all so they don't need it.

> @@ -469,6 +470,9 @@ static int fsl_esai_startup(struct snd_pcm_substream *substream,
>  	ret = clk_prepare_enable(esai_priv->coreclk);
>  	if (ret)
>  		return ret;
> +	ret = clk_prepare_enable(esai_priv->dmaclk);
> +	if (ret)
> +		return ret;

Needs a goto for a failed case in order to disable the coreclk.

> @@ -772,6 +778,13 @@ static int fsl_esai_probe(struct platform_device *pdev)
>  		dev_warn(&pdev->dev, "failed to get fsys clock: %ld\n",
>  				PTR_ERR(esai_priv->fsysclk));
>  
> +	esai_priv->dmaclk = devm_clk_get(&pdev->dev, "dma");
> +	if (IS_ERR(esai_priv->dmaclk)) {
> +		dev_err(&pdev->dev, "Cannot get dma clock: %ld\n",
> +				PTR_ERR(esai_priv->dmaclk));
> +		return PTR_ERR(esai_priv->dmaclk);
> +	}

This will break the old DTB -- would be solved by making the clock
optional though. And it would be better to follow the pattern of
previous error message.

Nicolin
