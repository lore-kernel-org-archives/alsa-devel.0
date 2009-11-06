From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/7] S3C PCM: Added the CPU driver for
	PCM	controllers
Date: Fri, 6 Nov 2009 17:50:59 +0000
Message-ID: <20091106175058.GH4938@sirena.org.uk>
References: <1257384917-18368-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B9CAC244F6
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 18:51:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257384917-18368-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 05, 2009 at 10:35:17AM +0900, Jassi Brar wrote:
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

This looks basically good.  A few comments but they're pretty much
nitpicks:

> +	clk = (clkctl & S3C_PCM_CLKCTL_SERCLKSEL_PCLK) ?
> +					pcm->pclk : pcm->cclk;

This would be clearer as an if statement - the ternery operator isn't
massively legible at the best of times, especially when statements end
up spanning multiple lines.

> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		/* Nothing to do, Master by default */
> +		break;
> +	default:
> +		spin_unlock_irq(&pcm->lock);
> +		dev_err(pcm->dev, "Unsupported master/slave format!\n");
> +		return -EINVAL;
> +	}

A goto to handle the lock unwinding might be appropriate.

> +	case S3C_PCM_CLKSRC_MUX:
> +		clkctl &= ~S3C_PCM_CLKCTL_SERCLKSEL_PCLK;
> +
> +		if (clk_get_rate(pcm->cclk) != freq)
> +			clk_set_rate(pcm->cclk, freq);
> +

May as well just clk_set_rate() unconditionally, it'll do no harm to do
a null change.

> +struct clk *s3c_pcm_get_clock(struct snd_soc_dai *cpu_dai)
> +{
> +	struct s3c_pcm_info *pcm = to_info(cpu_dai);
> +	void __iomem *regs = pcm->regs;
> +	u32 clkctl = readl(regs + S3C_PCM_CLKCTL);
> +
> +	if (clkctl & S3C_PCM_CLKCTL_SERCLKSEL_PCLK)
> +		return pcm->pclk;
> +	else
> +		return pcm->cclk;
> +}
> +EXPORT_SYMBOL_GPL(s3c_pcm_get_clock);

How will this be used?

> +	/* Check for valid device index */
> +	if (pdev->id >= ARRAY_SIZE(s3c_pcm)) {
> +		dev_err(&pdev->dev, "id %d out of range\n", pdev->id);
> +		return -EINVAL;
> +	}

id could be less than zero too.
