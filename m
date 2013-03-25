From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 22/54 v2] ASoC: switch over to use
 snd_soc_register_component() on jz4740 i2s
Date: Mon, 25 Mar 2013 11:48:36 +0100
Message-ID: <51502B84.9040909@metafoo.de>
References: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
 <8738vpf3qd.wl%kuninori.morimoto.gx@renesas.com>
 <877gl1dow7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-222.synserver.de (smtp-out-222.synserver.de
 [212.40.185.222])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BD88261694
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 11:46:29 +0100 (CET)
In-Reply-To: <877gl1dow7.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/21/2013 11:32 AM, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  sound/soc/jz4740/jz4740-i2s.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
> index 6cef491..9a12644 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -425,6 +425,10 @@ static struct snd_soc_dai_driver jz4740_i2s_dai = {
>  	.resume = jz4740_i2s_resume,
>  };
>  
> +static const struct snd_soc_component_driver jz4740_i2s_component = {
> +	.name		= "jz4740-i2s",
> +};
> +
>  static int jz4740_i2s_dev_probe(struct platform_device *pdev)
>  {
>  	struct jz4740_i2s *i2s;
> @@ -469,7 +473,8 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, i2s);
> -	ret = snd_soc_register_dai(&pdev->dev, &jz4740_i2s_dai);
> +	ret = snd_soc_register_component(&pdev->dev, &jz4740_i2s_component,
> +					 &jz4740_i2s_dai, 1);
>  
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to register DAI\n");
> @@ -496,7 +501,7 @@ static int jz4740_i2s_dev_remove(struct platform_device *pdev)
>  {
>  	struct jz4740_i2s *i2s = platform_get_drvdata(pdev);
>  
> -	snd_soc_unregister_dai(&pdev->dev);
> +	snd_soc_unregister_component(&pdev->dev);
>  
>  	clk_put(i2s->clk_i2s);
>  	clk_put(i2s->clk_aic);
