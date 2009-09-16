From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] S3C64XX I2S: Added machine driver for
	WM8580
Date: Wed, 16 Sep 2009 21:00:27 +0100
Message-ID: <20090916200027.GH3589@rakim.wolfsonmicro.main>
References: <1253095362-571-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 336F410388E
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Sep 2009 22:00:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253095362-571-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, jsgood.yang@samsung.com, ilho215.lee@samsung.com, thomas.ab@samsung.com, ki0351.kim@samsung.com, ben@trinity.fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 16, 2009 at 07:02:42PM +0900, Jassi wrote:

> New machine driver for WM8580 I2S i/f on SMDK64XX.
> By default SoC-Slave is set and WM8580 is configured to use it's
> PLLA to generate clocks from a 12MHz crystal attached to WM8580.

This looks sane as a starting point and most of the driver looks OK.

> I2S controller-0 is set as default, set S3C64XX_I2S_CNTRLR to 2
> inorder to use I2S_v4 controller of S3C6410.

I'm not entirely sure what's going on in this configuration - the
primary AIFs of the CODEC appear to be hard wired to the IISv4 interface
in the schematics I have, IIS port 0 is only wired to the secondary AIF
of the WM8580 so will need support for that implementing.  The end
result should be an extra set of DAI links for the secondary AIF.  Could
you clarify, please?

> +/* SMDK64XX has a 12MHZ crystal attached to WM8580 */
> +#define SMDK64XX_WM8580_FREQ (12000000)

No need for the () here.

> +	switch (params_rate(params)) {
> +	case 8000:
> +		pll_out = 8192000 / 4; break;

These are all a bit odd - you're taking two magic numbers and performing
an operation on them, giving another magic number.  For the most part
the resulting magic number is always 256fs (I suspect the cases where
they aren't should be 256fs).  Probably replacing all of this with

	pll_out = params_rate(params) * 256

would work.

> +	/* We block CODCLK from MCLK of WM8580 */
> +	ret = snd_soc_dai_set_sysclk(cpu_dai, S3C64XX_CODCLKSRC_EXT,
> +					0, SND_SOC_CLOCK_IN);
> +	if (ret < 0)
> +		return ret;

The code is OK (modulo the issues with the previous patch) but the
comment is exceptionally difficult to parse.

> +	/* Explicitly set WM8580-ADC/DAC to source from MCLK */
> +	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_ADC_CLKSEL,
> +					WM8580_CLKSRC_MCLK);

Obviously this will need updating for the actual patch for the WM8580
driver.

> +	if (ret < 0)
> +		return ret;
> +	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_DAC_CLKSEL,

Missing blank line here.

> +	/* Don't output to the disconnected pin */
> +	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_CLKOUTSRC,
> +					WM8580_CLKSRC_NONE);
> +	if (ret < 0)
> +		return ret;

If you're going to do this do it on init, it's nothing to do with
starting the audio stream.

> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_U8:
> +	case SNDRV_PCM_FORMAT_S8:
> +		bfs = 16;
> +		rfs = 256;
> +		break;
> +	case SNDRV_PCM_FORMAT_U16_LE:
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		bfs = 32;
> +		rfs = 256;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

This ought to get factored out into the CPU DAI driver, at least as a
library function - there's nothing board specific going on here.

> +	/* LineIn enabled by default */
> +	snd_soc_dapm_disable_pin(codec, "MicIn");
> +	snd_soc_dapm_enable_pin(codec, "LineIn");

Please add a comment explaining that if this is changed it needs to be
done with a resistor fit mod - this begs the question "How do I change
away from the default?", especially given the many switches for things
like this on the board.

For completeness if you're going to handle the mapping to the external
jacks there's also the possiblity that the signals will be switched out
to the PMIC card or WM9713.  It's probably better to just not bother,
it's not really adding anything since there's no jack detect or anything
on the board.  All that'll happen is that people are forced to rebuild
for DIP switch changes.

The other option would be to add controls mirroring the DIP switch
settings, but that'd not really cover the resistor fit stuff.

> +	/* Stereo enabled by default */
> +	snd_soc_dapm_enable_pin(codec, "Front-L/R");
> +	snd_soc_dapm_disable_pin(codec, "Center/Sub");
> +	snd_soc_dapm_disable_pin(codec, "Rear-L/R");

Similar issues here - putting a fixed configuration from this in the
driver doesn't buy anything.
