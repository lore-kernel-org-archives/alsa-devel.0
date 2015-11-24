From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 2/3] ASoC: fsl_spdif: spba clk is needed by spdif
 device
Date: Tue, 24 Nov 2015 17:23:39 -0600
Message-ID: <20151124232339.GA4565@rob-hp-laptop>
References: <cover.1448348336.git.shengjiu.wang@freescale.com>
 <6f03afc87c7958b975df66b163c1186be979afb6.1448348336.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6f03afc87c7958b975df66b163c1186be979afb6.1448348336.git.shengjiu.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shengjiu Wang <shengjiu.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Xiubo.Lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 24, 2015 at 03:03:29PM +0800, Shengjiu Wang wrote:
> SPDIF need to enable the spba clock, when sdma is using share peripheral
> script. In this case, there is two spba master port is used, if don't
> enable the clock, the spba bus will have arbitration issue, which may
> cause read/write wrong data from/to SPDIF registers.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/fsl,spdif.txt |  5 +++++

For the binding:

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  sound/soc/fsl/fsl_spdif.c                             | 15 +++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.txt b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> index b5ee32e..4ca39dd 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> @@ -27,6 +27,11 @@ Required properties:
>  			  Transceiver Clock Diagram" of SoC reference manual.
>  			  It can also be referred to TxClk_Source bit of
>  			  register SPDIF_STC.
> +	"spba"		  The spba clock is required when SPDIF is placed as a
> +			  bus slave of the Shared Peripheral Bus and when two
> +			  or more bus masters (CPU, DMA or DSP) try to access
> +			  it. This property is optional depending on the SoC
> +			  design.
>  
>     - big-endian		: If this property is absent, the native endian mode
>  			  will be in use as default, or the big endian mode
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 28a8823..64e2a1f 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -88,6 +88,7 @@ struct spdif_mixer_control {
>   * @rxclk: rx clock sources for capture
>   * @coreclk: core clock for register access via DMA
>   * @sysclk: system clock for rx clock rate measurement
> + * @spbaclk: SPBA clock (optional, depending on SoC design)
>   * @dma_params_tx: DMA parameters for transmit channel
>   * @dma_params_rx: DMA parameters for receive channel
>   */
> @@ -106,6 +107,7 @@ struct fsl_spdif_priv {
>  	struct clk *rxclk;
>  	struct clk *coreclk;
>  	struct clk *sysclk;
> +	struct clk *spbaclk;
>  	struct snd_dmaengine_dai_dma_data dma_params_tx;
>  	struct snd_dmaengine_dai_dma_data dma_params_rx;
>  	/* regcache for SRPC */
> @@ -474,6 +476,12 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
>  			return ret;
>  		}
>  
> +		ret = clk_prepare_enable(spdif_priv->spbaclk);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to enable spba clock\n");
> +			goto err_spbaclk;
> +		}
> +
>  		ret = spdif_softreset(spdif_priv);
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to soft reset\n");
> @@ -515,6 +523,8 @@ disable_txclk:
>  	for (i--; i >= 0; i--)
>  		clk_disable_unprepare(spdif_priv->txclk[i]);
>  err:
> +	clk_disable_unprepare(spdif_priv->spbaclk);
> +err_spbaclk:
>  	clk_disable_unprepare(spdif_priv->coreclk);
>  
>  	return ret;
> @@ -548,6 +558,7 @@ static void fsl_spdif_shutdown(struct snd_pcm_substream *substream,
>  		spdif_intr_status_clear(spdif_priv);
>  		regmap_update_bits(regmap, REG_SPDIF_SCR,
>  				SCR_LOW_POWER, SCR_LOW_POWER);
> +		clk_disable_unprepare(spdif_priv->spbaclk);
>  		clk_disable_unprepare(spdif_priv->coreclk);
>  	}
>  }
> @@ -1261,6 +1272,10 @@ static int fsl_spdif_probe(struct platform_device *pdev)
>  		return PTR_ERR(spdif_priv->coreclk);
>  	}
>  
> +	spdif_priv->spbaclk = devm_clk_get(&pdev->dev, "spba");
> +	if (IS_ERR(spdif_priv->spbaclk))
> +		dev_warn(&pdev->dev, "no spba clock in devicetree\n");
> +
>  	/* Select clock source for rx/tx clock */
>  	spdif_priv->rxclk = devm_clk_get(&pdev->dev, "rxtx1");
>  	if (IS_ERR(spdif_priv->rxclk)) {
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
