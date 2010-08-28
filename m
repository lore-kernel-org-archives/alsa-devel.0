From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/2] ASoC: Add HP iPAQ RX1950 support
Date: Sat, 28 Aug 2010 10:06:17 +0100
Message-ID: <20100828090604.GB9324@opensource.wolfsonmicro.com>
References: <1282984632-12665-1-git-send-email-anarsoul@gmail.com>
	<1282985666-13973-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EBA992462E
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 11:06:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282985666-13973-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 28, 2010 at 11:54:26AM +0300, Vasily Khoruzhick wrote:

This is basically fine but needs to be redone against current ASoC due
to Liam's multi-component work - the way the machine driver is
registered with the system has changed.  See either -next or

 git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

for the latest code.

> +static int rx1950_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	runtime->hw.rate_min = hw_rates.list[0];
> +	runtime->hw.rate_max = hw_rates.list[hw_rates.count - 1];
> +	runtime->hw.rates = SNDRV_PCM_RATE_KNOT;
> +
> +	return snd_pcm_hw_constraint_list(runtime, 0,
> +					SNDRV_PCM_HW_PARAM_RATE,
> +					&hw_rates);
> +}

Where does this constraint come from?  It's the sort of thing that
sounds like it comes from one of the chips so I'd expect their drivers
to be figuring it out.  Let's see below...

> +static int rx1950_spk_power(struct snd_soc_dapm_widget *w,
> +				struct snd_kcontrol *kcontrol, int event)
> +{
> +	if (SND_SOC_DAPM_EVENT_ON(event))
> +		gpio_direction_output(S3C2410_GPA(1), 1);
> +	else
> +		gpio_direction_output(S3C2410_GPA(1), 0);
> +
> +	return 0;
> +}

We should really make a standard GPIO DAPM thing.  Not a problem for
this driver, though.

> +	switch (rate) {
> +	case 16000:
> +	case 48000:
> +		clk_source = S3C24XX_CLKSRC_PCLK;
> +		fs_mode = S3C2410_IISMOD_384FS;
> +		div = s3c24xx_i2s_get_clockrate() / (384 * rate);
> +		if (s3c24xx_i2s_get_clockrate() % (384 * rate) > (182 * rate))
> +			div++;
> +		break;
> +	case 44100:
> +	case 88200:
> +		clk_source = S3C24XX_CLKSRC_MPLL;
> +		fs_mode = S3C2410_IISMOD_256FS;
> +		div = clk_get_rate(xtal) / (256 * rate);
> +		if (clk_get_rate(xtal) % (256 * rate) > (128 * rate))
> +			div++;
> +		break;

...right, it's the CPU driver which is a bit more manual than is ideal.
OK, again not a problem for this driver.
