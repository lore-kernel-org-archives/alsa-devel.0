From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 3/4] ASoC: imx-sgtl5000: Do a sanity
 check on the codec clock
Date: Thu, 25 Apr 2013 13:20:30 +0800
Message-ID: <20130425052028.GC1389@S2101-09.ap.freescale.net>
References: <1366815286-31820-1-git-send-email-festevam@gmail.com>
 <1366815286-31820-3-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id BFAB1265D4C
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 07:21:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1366815286-31820-3-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 24, 2013 at 11:54:45AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Only turn on the codec clock if it is within the valid range.
> 
> Also, disable the codec clock on the clk_fail path.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - None
> 
>  sound/soc/fsl/imx-sgtl5000.c |   18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index 9c286e6..18af815 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -56,6 +56,15 @@ static const struct snd_soc_dapm_widget imx_sgtl5000_dapm_widgets[] = {
>  	SND_SOC_DAPM_SPK("Ext Spk", NULL),
>  };
>  
> +static int sgtl5000_is_valid_sysclk(int freq)
> +{
> +
> +	if (freq < 8000000 || freq > 27000000)
> +		return -EINVAL;
> +	else
> +		return 0;
> +}
> +
>  static int imx_sgtl5000_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -135,9 +144,13 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  		goto fail;
>  	}
>  
> -	data->clk_frequency = clk_get_rate(data->codec_clk);
> -	clk_prepare_enable(data->codec_clk);
> +	data->clk_frequency = clk_get_rate(data->codec_clk);
> +	ret = sgtl5000_is_valid_sysclk(data->clk_frequency);
> +	if (ret)
> +		goto fail;

In this patch, you haven't converted clk_get to devm_clk_get yet.  If
you goto "fail" here, clk_put() below will be skipped.

Shawn

>  
> +	clk_prepare_enable(data->codec_clk);
> +
>  	data->dai.name = "HiFi";
>  	data->dai.stream_name = "HiFi";
>  	data->dai.codec_dai_name = "sgtl5000";
> @@ -172,6 +185,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  	return 0;
>  
>  clk_fail:
> +	clk_disable_unprepare(data->codec_clk);
>  	clk_put(data->codec_clk);
>  fail:
>  	if (ssi_np)
> -- 
> 1.7.9.5
> 
