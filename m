From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v3 3/3] ASoC: zx-i2s: introduce pclk for
	zx2967 family
Date: Wed, 8 Feb 2017 22:25:41 +0800
Message-ID: <20170208142539.GN3407@dragon>
References: <1486522955-14528-1-git-send-email-baoyou.xie@linaro.org>
 <1486522955-14528-3-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EA80261A1A
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 15:26:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1486522955-14528-3-git-send-email-baoyou.xie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, xie.baoyou@zte.com.cn, mathieu.poirier@linaro.org, vinod.koul@intel.com, linux-kernel@vger.kernel.org, mturquette@baylibre.com, tiwai@suse.com, sboyd@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, jun.nie@linaro.org, shawn.guo@linaro.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 08, 2017 at 11:02:35AM +0800, Baoyou Xie wrote:
> The pclk is necessary for zx2967 I2S controller. the driver
> currently doesn't handle it. This is something we need to fix.
> 
> In turn, the driver supports zx296718's I2S controller.
> 
> By the way, this patch also change the clock name from tx to wclk
> to make it clear.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  sound/soc/zte/zx-i2s.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/zte/zx-i2s.c b/sound/soc/zte/zx-i2s.c
> index ed7a56d..2d486ea 100644
> --- a/sound/soc/zte/zx-i2s.c
> +++ b/sound/soc/zte/zx-i2s.c
> @@ -95,7 +95,7 @@
>  struct zx_i2s_info {
>  	struct snd_dmaengine_dai_dma_data	dma_playback;
>  	struct snd_dmaengine_dai_dma_data	dma_capture;
> -	struct clk				*dai_clk;
> +	struct clk				*dai_wclk, *dai_pclk;

It's better to have them on two lines, I would say.

>  	void __iomem				*reg_base;
>  	int					master;
>  	resource_size_t				mapbase;
> @@ -275,8 +275,9 @@ static int zx_i2s_hw_params(struct snd_pcm_substream *substream,
>  	writel_relaxed(val, i2s->reg_base + ZX_I2S_TIMING_CTRL);
>  
>  	if (i2s->master)
> -		ret = clk_set_rate(i2s->dai_clk,
> -				   params_rate(params) * ch_num * CLK_RAT);
> +		ret = clk_set_rate(i2s->dai_wclk,
> +				params_rate(params) * ch_num * CLK_RAT);
> +
>  	return ret;
>  }
>  
> @@ -328,8 +329,19 @@ static int zx_i2s_startup(struct snd_pcm_substream *substream,
>  			  struct snd_soc_dai *dai)
>  {
>  	struct zx_i2s_info *zx_i2s = dev_get_drvdata(dai->dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(zx_i2s->dai_wclk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(zx_i2s->dai_pclk);
> +	if (ret) {
> +		clk_disable_unprepare(zx_i2s->dai_wclk);
> +		return ret;
> +	}
>  
> -	return clk_prepare_enable(zx_i2s->dai_clk);
> +	return ret;
>  }
>  
>  static void zx_i2s_shutdown(struct snd_pcm_substream *substream,
> @@ -337,7 +349,8 @@ static void zx_i2s_shutdown(struct snd_pcm_substream *substream,
>  {
>  	struct zx_i2s_info *zx_i2s = dev_get_drvdata(dai->dev);
>  
> -	clk_disable_unprepare(zx_i2s->dai_clk);
> +	clk_disable_unprepare(zx_i2s->dai_wclk);
> +	clk_disable_unprepare(zx_i2s->dai_pclk);
>  }
>  
>  static struct snd_soc_dai_ops zx_i2s_dai_ops = {
> @@ -381,10 +394,16 @@ static int zx_i2s_probe(struct platform_device *pdev)
>  	if (!zx_i2s)
>  		return -ENOMEM;
>  
> -	zx_i2s->dai_clk = devm_clk_get(&pdev->dev, "tx");
> -	if (IS_ERR(zx_i2s->dai_clk)) {
> -		dev_err(&pdev->dev, "Fail to get clk\n");
> -		return PTR_ERR(zx_i2s->dai_clk);
> +	zx_i2s->dai_wclk = devm_clk_get(&pdev->dev, "wclk");
> +	if (IS_ERR(zx_i2s->dai_wclk)) {
> +		dev_err(&pdev->dev, "Fail to get wclk\n");
> +		return PTR_ERR(zx_i2s->dai_wclk);
> +	}
> +
> +	zx_i2s->dai_pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (IS_ERR(zx_i2s->dai_pclk)) {
> +		dev_info(&pdev->dev, "have no pclk\n");
> +		zx_i2s->dai_pclk = NULL;

The 'pclk' is actually required instead of optional.  Since we haven't
got any in-tree DTB with I2S device yet, there is no DT compatibility to
maintain.  So it should be good to make 'pclk' required right now.

Shawn

>  	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -- 
> 2.7.4
> 
