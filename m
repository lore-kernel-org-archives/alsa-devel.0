From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 10/17] ASoC: mxs: Use generic dmaengine PCM
Date: Wed, 17 Apr 2013 21:50:05 +0800
Message-ID: <20130417135003.GA20563@S2101-09.ap.freescale.net>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-11-git-send-email-lars@metafoo.de>
 <20130417084304.GK11245@S2101-09.ap.freescale.net>
 <516E6B2B.5000805@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DE5C26164D
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 15:50:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <516E6B2B.5000805@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 17, 2013 at 11:28:11AM +0200, Lars-Peter Clausen wrote:
> Can you see whether the patch below fixes it?
> 
No, it does not fix the problem.

Shawn

> diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
> index b563141..675c348 100644
> --- a/sound/soc/mxs/mxs-saif.c
> +++ b/sound/soc/mxs/mxs-saif.c
> @@ -611,21 +611,28 @@ static int mxs_saif_dai_probe(struct snd_soc_dai *dai)
>  }
> 
>  static struct snd_soc_dai_driver mxs_saif_dai = {
> -	.name = "mxs-saif",
> -	.probe = mxs_saif_dai_probe,
> -	.playback = {
> -		.channels_min = 2,
> -		.channels_max = 2,
> -		.rates = MXS_SAIF_RATES,
> -		.formats = MXS_SAIF_FORMATS,
> +	{
> +		.name = "mxs-saif",
> +		.probe = mxs_saif_dai_probe,
> +		.playback = {
> +			.channels_min = 2,
> +			.channels_max = 2,
> +			.rates = MXS_SAIF_RATES,
> +			.formats = MXS_SAIF_FORMATS,
> +		},
> +		.ops = &mxs_saif_dai_ops,
>  	},
> -	.capture = {
> -		.channels_min = 2,
> -		.channels_max = 2,
> -		.rates = MXS_SAIF_RATES,
> -		.formats = MXS_SAIF_FORMATS,
> +	{
> +		.name = "mxs-saif",
> +		.probe = mxs_saif_dai_probe,
> +		.capture = {
> +			.channels_min = 2,
> +			.channels_max = 2,
> +			.rates = MXS_SAIF_RATES,
> +			.formats = MXS_SAIF_FORMATS,
> +		},
> +		.ops = &mxs_saif_dai_ops,
>  	},
> -	.ops = &mxs_saif_dai_ops,
>  };
> 
>  static const struct snd_soc_component_driver mxs_saif_component = {
> @@ -769,7 +776,7 @@ static int mxs_saif_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, saif);
> 
>  	ret = snd_soc_register_component(&pdev->dev, &mxs_saif_component,
> -					 &mxs_saif_dai, 1);
> +					 &mxs_saif_dai[saif->id], 1);
>  	if (ret) {
>  		dev_err(&pdev->dev, "register DAI failed\n");
>  		return ret;
