From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: fix kernel panic in probe
	function
Date: Thu, 18 Sep 2014 15:40:55 -0700
Message-ID: <20140918224055.GA29065@Alpha>
References: <1411065489-21496-1-git-send-email-michael@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id DF2DA262626
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 00:41:02 +0200 (CEST)
Received: by mail-pa0-f53.google.com with SMTP id rd3so2423957pab.26
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 15:41:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411065489-21496-1-git-send-email-michael@amarulasolutions.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: broonie@kernel.org, Li.Xiubo@freescale.com, timur@tabi.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 18, 2014 at 08:38:09PM +0200, Michael Trimarchi wrote:
> code can raise a panic when the ssi_private->pdev is null
> 
> [...]
> 	/*
> 	 * If codec-handle property is missing from SSI node, we assume
> 	 * that the machine driver uses new binding which does not require
> 	 * SSI driver to trigger machine driver's probe.
> 	 */
> 	if (!of_get_property(np, "codec-handle", NULL))
> 		goto done;
> [...]
> 	ssi_private->pdev =
> 		platform_device_register_data(&pdev->dev, name, 0, NULL, 0);
> [...]
> done:
> 	if (ssi_private->dai_fmt)
> 		_fsl_ssi_set_dai_fmt(ssi_private, ssi_private->dai_fmt);
> 
> Proposal was to not use ssi_private->pdev->dev here but adding a new parameter
> of *dev pointer to this _set_dai_fmt() -- passing pdev->dev in probe() and
> cpu_dai->dev in fsl_ssi_set_dai_fmt().
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Reported-by: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
> Cc: Nicolin Chen <nicoleotsuka@gmail.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you

> ---
>  sound/soc/fsl/fsl_ssi.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 87eb577..de6ab06 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -748,8 +748,9 @@ static int fsl_ssi_hw_free(struct snd_pcm_substream *substream,
>  	return 0;
>  }
>  
> -static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
> -		unsigned int fmt)
> +static int _fsl_ssi_set_dai_fmt(struct device *dev,
> +				struct fsl_ssi_private *ssi_private,
> +				unsigned int fmt)
>  {
>  	struct regmap *regs = ssi_private->regs;
>  	u32 strcr = 0, stcr, srcr, scr, mask;
> @@ -758,7 +759,7 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
>  	ssi_private->dai_fmt = fmt;
>  
>  	if (fsl_ssi_is_i2s_master(ssi_private) && IS_ERR(ssi_private->baudclk)) {
> -		dev_err(&ssi_private->pdev->dev, "baudclk is missing which is necessary for master mode\n");
> +		dev_err(dev, "baudclk is missing which is necessary for master mode\n");
>  		return -EINVAL;
>  	}
>  
> @@ -913,7 +914,7 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
>  {
>  	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
>  
> -	return _fsl_ssi_set_dai_fmt(ssi_private, fmt);
> +	return _fsl_ssi_set_dai_fmt(cpu_dai->dev, ssi_private, fmt);
>  }
>  
>  /**
> @@ -1387,7 +1388,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>  
>  done:
>  	if (ssi_private->dai_fmt)
> -		_fsl_ssi_set_dai_fmt(ssi_private, ssi_private->dai_fmt);
> +		_fsl_ssi_set_dai_fmt(&pdev->dev, ssi_private,
> +				     ssi_private->dai_fmt);
>  
>  	return 0;
>  
> -- 
> 1.8.1.2
> 
