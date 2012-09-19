From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: add support for the Freescale /
 iVeia P1022 RDK reference board
Date: Tue, 18 Sep 2012 22:32:59 -0400
Message-ID: <20120919023259.GB8832@opensource.wolfsonmicro.com>
References: <1347657278-25295-1-git-send-email-timur@freescale.com>
 <1347657278-25295-5-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DC9C3265129
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 04:33:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347657278-25295-5-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 14, 2012 at 04:14:38PM -0500, Timur Tabi wrote:

>  sound/soc/fsl/Kconfig     |   14 ++
>  sound/soc/fsl/Makefile    |    4 +
>  sound/soc/fsl/p1022_rdk.c |  455 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 473 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/fsl/p1022_rdk.c

This adds a new device tree binding so it should be documented.

> +	/* Tell the codec driver what the serial protocol is. */
> +	ret = snd_soc_dai_set_fmt(rtd->codec_dai, mdata->dai_format);
> +	if (ret < 0) {
> +		dev_err(dev, "could not set codec driver audio format\n");
> +		return ret;
> +	}

This should normally be done via the dai_fmt member of the dai_link
structure.

> +	ret = snd_soc_dai_set_pll(rtd->codec_dai, 0, 0, mdata->clk_frequency,
> +		mdata->clk_frequency);
> +	if (ret < 0) {
> +		dev_err(dev, "could not set codec PLL frequency\n");
> +		return ret;
> +	}

We never stop the PLL - normally you'd want to stop it when the audio
stops.  But..

> +	/* Tell the WM8960 to set SYSCLK equal to MCLK input (bypass PLL) */
> +	ret = snd_soc_dai_set_clkdiv(rtd->codec_dai, WM8960_SYSCLKDIV,
> +		WM8960_SYSCLK_MCLK | WM8960_SYSCLK_DIV_1);
> +	if (ret < 0) {
> +		dev_err(dev, "could not set codec driver clock source\n");
> +		return ret;
> +	}

...we don't appear to use the PLL output anyway so why not just leave it
off?  As this is fixed it's better style to do the setup in late_init()
or the init function for the DAI link.

Also we should log the return codes when we log failures.

> +	/* Get the serial format and clock direction. */
> +	sprop = of_get_property(np, "fsl,mode", NULL);
> +	if (!sprop) {
> +		dev_err(&pdev->dev, "fsl,mode property not found\n");
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	if (strcasecmp(sprop, "i2s-slave") == 0) {
> +		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
> +			SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM;
> +		mdata->codec_clk_direction = SND_SOC_CLOCK_OUT;
> +		mdata->cpu_clk_direction = SND_SOC_CLOCK_IN;

Why would this be something that individual systems would want to
change, and if it is something it's useful to vary why not at runtime?
I suspect the best thing here is just to pick a format and use it, if
there is a reason to vary this it's probably a higher level thing.

> +	snd_soc_unregister_card(card);
> +	kfree(mdata);

devm_kzalloc().
