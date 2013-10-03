From: Gururaja Hebbar <gururaja.hebbar@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: add support for
	suspend and resume
Date: Thu, 3 Oct 2013 12:18:58 +0530
Message-ID: <524D135A.8040405@ti.com>
References: <1380631802-19498-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id CD35026552E
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2013 08:49:33 +0200 (CEST)
In-Reply-To: <1380631802-19498-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org
Cc: marek.belisko@gmail.com, broonie@kernel.org, s.neumann@raumfeld.com, nsekhar@ti.com
List-Id: alsa-devel@alsa-project.org

On Tuesday 01 October 2013 06:20 PM, Daniel Mack wrote:
> When the system returns from suspend, it looses its configuration. Most
> of it is restored by running a normal audio stream startup, but the DAI
> format is left unset as that's configured on the audio device creation.
> 
> Hence, it suffices here to care for the registers which are touched by
> davinci_mcasp_set_dai_fmt() and restore them when the system is resumed.


I believe you have confirmed below are the only registers/fields which
will lose context across suspend/resume.

Regards
Gururaja


> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  sound/soc/davinci/davinci-mcasp.c | 39 +++++++++++++++++++++++++++++++++++++++
>  sound/soc/davinci/davinci-mcasp.h | 12 ++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index 591f853..5023da7 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -1272,12 +1272,51 @@ static int davinci_mcasp_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int davinci_mcasp_suspend(struct device *dev)
> +{
> +	struct davinci_audio_dev *a = dev_get_drvdata(dev);
> +	void __iomem *base = a->base;
> +
> +	a->context.txfmtctl = mcasp_get_reg(base + DAVINCI_MCASP_TXFMCTL_REG);
> +	a->context.rxfmtctl = mcasp_get_reg(base + DAVINCI_MCASP_RXFMCTL_REG);
> +	a->context.txfmt = mcasp_get_reg(base + DAVINCI_MCASP_TXFMT_REG);
> +	a->context.rxfmt = mcasp_get_reg(base + DAVINCI_MCASP_RXFMT_REG);
> +	a->context.aclkxctl = mcasp_get_reg(base + DAVINCI_MCASP_ACLKXCTL_REG);
> +	a->context.aclkrctl = mcasp_get_reg(base + DAVINCI_MCASP_ACLKRCTL_REG);
> +	a->context.pdir = mcasp_get_reg(base + DAVINCI_MCASP_PDIR_REG);
> +
> +	return 0;
> +}
> +
> +static int davinci_mcasp_resume(struct device *dev)
> +{
> +	struct davinci_audio_dev *a = dev_get_drvdata(dev);
> +	void __iomem *base = a->base;
> +
> +	mcasp_set_reg(base + DAVINCI_MCASP_TXFMCTL_REG, a->context.txfmtctl);
> +	mcasp_set_reg(base + DAVINCI_MCASP_RXFMCTL_REG, a->context.rxfmtctl);
> +	mcasp_set_reg(base + DAVINCI_MCASP_TXFMT_REG, a->context.txfmt);
> +	mcasp_set_reg(base + DAVINCI_MCASP_RXFMT_REG, a->context.rxfmt);
> +	mcasp_set_reg(base + DAVINCI_MCASP_ACLKXCTL_REG, a->context.aclkxctl);
> +	mcasp_set_reg(base + DAVINCI_MCASP_ACLKRCTL_REG, a->context.aclkrctl);
> +	mcasp_set_reg(base + DAVINCI_MCASP_PDIR_REG, a->context.pdir);
> +
> +	return 0;
> +}
> +#endif
> +
> +SIMPLE_DEV_PM_OPS(davinci_mcasp_pm_ops,
> +		  davinci_mcasp_suspend,
> +		  davinci_mcasp_resume);
> +
>  static struct platform_driver davinci_mcasp_driver = {
>  	.probe		= davinci_mcasp_probe,
>  	.remove		= davinci_mcasp_remove,
>  	.driver		= {
>  		.name	= "davinci-mcasp",
>  		.owner	= THIS_MODULE,
> +		.pm	= &davinci_mcasp_pm_ops,
>  		.of_match_table = mcasp_dt_ids,
>  	},
>  };
> diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
> index a9ac0c1..a2e27e1 100644
> --- a/sound/soc/davinci/davinci-mcasp.h
> +++ b/sound/soc/davinci/davinci-mcasp.h
> @@ -43,6 +43,18 @@ struct davinci_audio_dev {
>  	/* McASP FIFO related */
>  	u8	txnumevt;
>  	u8	rxnumevt;
> +
> +#ifdef CONFIG_PM_SLEEP
> +	struct {
> +		u32	txfmtctl;
> +		u32	rxfmtctl;
> +		u32	txfmt;
> +		u32	rxfmt;
> +		u32	aclkxctl;
> +		u32	aclkrctl;
> +		u32	pdir;
> +	} context;
> +#endif
>  };
>  
>  #endif	/* DAVINCI_MCASP_H */
> 
