From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Add support Voice DAI
Date: Thu, 9 Apr 2009 15:06:54 +0100
Message-ID: <20090409140654.GC18152@sirena.org.uk>
References: <49DDFE1D.3090009@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CC3E103803
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Apr 2009 16:06:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49DDFE1D.3090009@samsung.com>
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
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com, kyungmin.park@samsung.com, bhmin@samsung.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 09, 2009 at 10:54:37PM +0900, Joonyoung Shim wrote:

> The PCM voice interface has two modes
> - PCM mode1 : This uses the rising edge of the clock signal
> - PCM mode2 : This uses the falling edge of the clock signal

> PCM mode1 and mode2 have a look of DSP_A and DSP_B, so we used DSP_A and
> DSP_B.

That sounds wrong - the difference between modes A and B is an extra
cycle on BCLK after LRP, not the polarity of the signal.  I'd expect
that it should be one or the other of these modes with the option to
invert BCLK.

> +static int twl4030_voice_startup(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_device *socdev = rtd->socdev;
> +	struct snd_soc_codec *codec = socdev->card->codec;
> +	u8 infreq;
> +
> +	/* If the system master clock is not 26MHz, the voice PCM interface is
> +	 * not avilable.
> +	 */
> +	infreq = twl4030_read_reg_cache(codec, TWL4030_REG_APLL_CTL)
> +		& TWL4030_APLL_INFREQ;
> +
> +	if (infreq != TWL4030_APLL_INFREQ_26000KHZ)
> +		return -EPERM;
> +
> +	return 0;
> +}

It's probably worth a comment here telling users that they'll need to
call set_sysclk() in their init() function rather than hw_params() -
otherwise this might get called before the clock is set up.

> +		/* change rate and set CODECPDZ */
> +		twl4030_codec_enable(codec, 0);
> +		twl4030_write(codec, TWL4030_REG_CODEC_MODE, mode);
> +		twl4030_codec_enable(codec, 1);

Hrm.  This codec_enable() call looks fishy - what's the effect if the
other DAI is running when the voice DAI is configured?  Though there may
be no way round this...

> +struct snd_soc_dai twl4030_dai[] = {
> +{	.name = "twl4030",

The { should ideally be on a line by itself (for both DAIs).
