From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 1/4] ASoC: fsl_sai: Add driver suspend
 and resume to support MEGA Fast
Date: Tue, 15 Sep 2015 22:08:25 -0700
Message-ID: <20150916050825.GA31293@Asurada-CZ80>
References: <6fa4e6ebf1f34f5d637324c9f62e68b03037568c.1438928296.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 13F9A260525
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 07:08:32 +0200 (CEST)
Received: by pacex6 with SMTP id ex6so198146182pac.0
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 22:08:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6fa4e6ebf1f34f5d637324c9f62e68b03037568c.1438928296.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 07, 2015 at 02:21:05PM +0800, Zidan Wang wrote:
> For i.MX6 SoloX, there is a mode of the SoC to shutdown all power source of
> modules during system suspend and resume procedure. Thus, SAI needs to save
> all the values of registers before the system suspend and restore them after
> the system resume.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

For this series,

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

I'm still having trouble to test system suspend/resume even without
these PATCHes. But they look fine to me.

Thank you
Nicolin

> ---
>  sound/soc/fsl/fsl_sai.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index a18fd92..5c737f1 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -637,6 +637,8 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
>  static bool fsl_sai_volatile_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
> +	case FSL_SAI_TCSR:
> +	case FSL_SAI_RCSR:
>  	case FSL_SAI_TFR:
>  	case FSL_SAI_RFR:
>  	case FSL_SAI_TDR:
> @@ -681,6 +683,7 @@ static const struct regmap_config fsl_sai_regmap_config = {
>  	.readable_reg = fsl_sai_readable_reg,
>  	.volatile_reg = fsl_sai_volatile_reg,
>  	.writeable_reg = fsl_sai_writeable_reg,
> +	.cache_type = REGCACHE_FLAT,
>  };
>  
>  static int fsl_sai_probe(struct platform_device *pdev)
> @@ -802,10 +805,40 @@ static const struct of_device_id fsl_sai_ids[] = {
>  	{ /* sentinel */ }
>  };
>  
> +#if CONFIG_PM_SLEEP
> +static int fsl_sai_suspend(struct device *dev)
> +{
> +	struct fsl_sai *sai = dev_get_drvdata(dev);
> +
> +	regcache_cache_only(sai->regmap, true);
> +	regcache_mark_dirty(sai->regmap);
> +
> +	return 0;
> +}
> +
> +static int fsl_sai_resume(struct device *dev)
> +{
> +	struct fsl_sai *sai = dev_get_drvdata(dev);
> +
> +	regcache_cache_only(sai->regmap, false);
> +	regmap_write(sai->regmap, FSL_SAI_TCSR, FSL_SAI_CSR_SR);
> +	regmap_write(sai->regmap, FSL_SAI_RCSR, FSL_SAI_CSR_SR);
> +	msleep(1);
> +	regmap_write(sai->regmap, FSL_SAI_TCSR, 0);
> +	regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
> +	return regcache_sync(sai->regmap);
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static const struct dev_pm_ops fsl_sai_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(fsl_sai_suspend, fsl_sai_resume)
> +};
> +
>  static struct platform_driver fsl_sai_driver = {
>  	.probe = fsl_sai_probe,
>  	.driver = {
>  		.name = "fsl-sai",
> +		.pm = &fsl_sai_pm_ops,
>  		.of_match_table = fsl_sai_ids,
>  	},
>  };
> -- 
> 1.9.1
> 
