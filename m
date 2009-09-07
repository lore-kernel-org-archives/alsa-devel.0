From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: AK4671: add ak4671 codec driver
Date: Mon, 7 Sep 2009 11:23:12 +0100
Message-ID: <20090907102312.GC29898@rakim.wolfsonmicro.main>
References: <4AA47AE4.9080803@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 38F981037FC
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 12:23:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4AA47AE4.9080803@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 07, 2009 at 12:15:48PM +0900, Joonyoung Shim wrote:

> +static int ak4671_pll_event(struct snd_soc_dapm_widget *w,
> +		struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +	u8 reg;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		reg = snd_soc_read(codec, AK4671_PLL_MODE_SELECT1);
> +		reg |= AK4671_PMPLL;
> +		snd_soc_write(codec, AK4671_PLL_MODE_SELECT1, reg);
> +		/* pll lock time: max 40ms */
> +		mdelay(40);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		reg = snd_soc_read(codec, AK4671_PLL_MODE_SELECT1);
> +		reg &= ~AK4671_PMPLL;
> +		snd_soc_write(codec, AK4671_PLL_MODE_SELECT1, reg);
> +		break;
> +	}

I think you need some reference counting or a supply widget here since
this event is there for all the DACs and ADCs:

> +	/* DAC */
> +	SND_SOC_DAPM_DAC_E("DAC Left", "Left HiFi Playback",
> +			AK4671_AD_DA_POWER_MANAGEMENT, 6, 0, ak4671_pll_event,
> +			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> +	SND_SOC_DAPM_DAC_E("DAC Right", "Right HiFi Playback",
> +			AK4671_AD_DA_POWER_MANAGEMENT, 7, 0, ak4671_pll_event,
> +			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> +
> +	/* ADC */
> +	SND_SOC_DAPM_ADC_E("ADC Left", "Left HiFi Capture",
> +			AK4671_AD_DA_POWER_MANAGEMENT, 4, 0, ak4671_pll_event,
> +			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> +	SND_SOC_DAPM_ADC_E("ADC Right", "Right HiFi Capture",
> +			AK4671_AD_DA_POWER_MANAGEMENT, 5, 0, ak4671_pll_event,
> +			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),

This shouldn't be a problem if they all go on or off at once (except for
the extra latency from waiting for the PLL to go on) but unless I'm
missing something if capture and playback are stopped independantly I'd
expect that the PLL will get shut down when the first one happens,
causing problems for the still active stream.
