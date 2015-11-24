From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 1/3] ASoC: fsl_esai: spba clock is needed by esai
 device
Date: Tue, 24 Nov 2015 17:21:30 -0600
Message-ID: <20151124232130.GA3400@rob-hp-laptop>
References: <cover.1448348336.git.shengjiu.wang@freescale.com>
 <37808c01df126622c41c2d413fddf838dc2aa71d.1448348336.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <37808c01df126622c41c2d413fddf838dc2aa71d.1448348336.git.shengjiu.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shengjiu Wang <shengjiu.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Xiubo.Lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 24, 2015 at 03:03:28PM +0800, Shengjiu Wang wrote:
> ESAI need to enable the spba clock, when sdma is using share peripheral
> script. In this case, there is two spba master port is used, if don't
> enable the clock, the spba bus will have arbitration issue, which may
> cause read/write wrong data from/to ESAI registers.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/fsl,esai.txt |  5 +++++

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  sound/soc/fsl/fsl_esai.c                             | 13 +++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
> index d3b6b5f..cd3ee5d 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,esai.txt
> @@ -27,6 +27,11 @@ Required properties:
>  			  derive HCK, SCK and FS.
>  	"fsys"		  The system clock derived from ahb clock used to
>  			  derive HCK, SCK and FS.
> +	"spba"		  The spba clock is required when ESAI is placed as a
> +			  bus slave of the Shared Peripheral Bus and when two
> +			  or more bus masters (CPU, DMA or DSP) try to access
> +			  it. This property is optional depending on the SoC
> +			  design.
>  
>    - fsl,fifo-depth	: The number of elements in the transmit and receive
>  			  FIFOs. This number is the maximum allowed value for
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 504e731..4d7589c 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -35,6 +35,7 @@
>   * @coreclk: clock source to access register
>   * @extalclk: esai clock source to derive HCK, SCK and FS
>   * @fsysclk: system clock source to derive HCK, SCK and FS
> + * @spbaclk: SPBA clock (optional, depending on SoC design)
>   * @fifo_depth: depth of tx/rx FIFO
>   * @slot_width: width of each DAI slot
>   * @slots: number of slots
> @@ -54,6 +55,7 @@ struct fsl_esai {
>  	struct clk *coreclk;
>  	struct clk *extalclk;
>  	struct clk *fsysclk;
> +	struct clk *spbaclk;
>  	u32 fifo_depth;
>  	u32 slot_width;
>  	u32 slots;
> @@ -469,6 +471,9 @@ static int fsl_esai_startup(struct snd_pcm_substream *substream,
>  	ret = clk_prepare_enable(esai_priv->coreclk);
>  	if (ret)
>  		return ret;
> +	ret = clk_prepare_enable(esai_priv->spbaclk);
> +	if (ret)
> +		goto err_spbaclk;
>  	if (!IS_ERR(esai_priv->extalclk)) {
>  		ret = clk_prepare_enable(esai_priv->extalclk);
>  		if (ret)
> @@ -499,6 +504,8 @@ err_fsysclk:
>  	if (!IS_ERR(esai_priv->extalclk))
>  		clk_disable_unprepare(esai_priv->extalclk);
>  err_extalck:
> +	clk_disable_unprepare(esai_priv->spbaclk);
> +err_spbaclk:
>  	clk_disable_unprepare(esai_priv->coreclk);
>  
>  	return ret;
> @@ -564,6 +571,7 @@ static void fsl_esai_shutdown(struct snd_pcm_substream *substream,
>  		clk_disable_unprepare(esai_priv->fsysclk);
>  	if (!IS_ERR(esai_priv->extalclk))
>  		clk_disable_unprepare(esai_priv->extalclk);
> +	clk_disable_unprepare(esai_priv->spbaclk);
>  	clk_disable_unprepare(esai_priv->coreclk);
>  }
>  
> @@ -819,6 +827,11 @@ static int fsl_esai_probe(struct platform_device *pdev)
>  		dev_warn(&pdev->dev, "failed to get fsys clock: %ld\n",
>  				PTR_ERR(esai_priv->fsysclk));
>  
> +	esai_priv->spbaclk = devm_clk_get(&pdev->dev, "spba");
> +	if (IS_ERR(esai_priv->spbaclk))
> +		dev_warn(&pdev->dev, "failed to get spba clock: %ld\n",
> +				PTR_ERR(esai_priv->spbaclk));
> +
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
