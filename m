From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v2 5/7] ASoC: stm32: add DFSDM DAI support
Date: Sun, 19 Feb 2017 14:56:05 +0000
Message-ID: <a9cf136c-2c8c-eafc-d175-4977c7ea4925@kernel.org>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-6-git-send-email-arnaud.pouliquen@st.com>
 <20170214174534.35ytbpax75mxcayg@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170214174534.35ytbpax75mxcayg-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, olivier moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 14/02/17 17:45, Mark Brown wrote:
> On Mon, Feb 13, 2017 at 05:38:27PM +0100, Arnaud Pouliquen wrote:
> 
> This looks basically fine as a system specific driver but as some of the
> comments in here say there's bits of it could perhaps be genericised but
> I'm not sure we need to do that right now.  I'm not sure the abstraction
> is exactly comfortable but having another bit of hardware doing a bridge
> to IIO might be the best way to figure out something better.
Agreed.  To an extent we are fishing around in the dark at the moment.
Lets wait until we have a few more cases of similar hardware before trying
too much generalization.  This is acting as a good exploration of what
is needed.

Ideally Lars might upstream some of the other bits he has in his tree
to do with DSP processing on ADC streams and that might provide us with
more clues on generality (at least at the lowest layers)
(Apparently he's busy - though he always makes that excuse :)
Joking aside, the exploration Analog and in particular Lars does around
pushing the limits of how things interact is always useful!)

> 
>> +	.period_bytes_min = 40, /* 8 khz 5 ms */
>> +	.period_bytes_max = 4 * PAGE_SIZE,
>> +	.buffer_bytes_max = 16 * PAGE_SIZE
> 
> What's the physical minimum period limit?  The comment makes this sound
> like it's just made up.
> 
>> +	unsigned int shift = 24 -priv->max_scaling;
>> +	
> 
> Missing space after -.
> 
>> +	dev_dbg(dai->dev, "%s: enter\n", __func__);
>> +	return 0;
>> +	return snd_pcm_hw_constraint_list(substream->runtime, 0,
>> +					  SNDRV_PCM_HW_PARAM_RATE,
>> +					  &priv->rates_const);
> 
> Looks like debug changes got left in?
> 
>> +static int stm32_adfsdm_set_sysclk(struct snd_soc_dai *dai, int clk_id,
>> +				   unsigned int freq, int dir)
>> +{
>> +	struct stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai);
>> +	struct stm32_adfsdm_pdata *pdata = priv->pdata;
>> +
>> +	dev_dbg(dai->dev, "%s: enter for dai %d\n", __func__, dai->id);
>> +	if (dir == SND_SOC_CLOCK_IN) {
>> +		pdata->ops->set_sysclk(pdata->adc, freq);
>> +		priv->dmic_clk = freq;
>> +	}
>> +
>> +	/* Determine supported rate which depends on SPI/manchester clock */
>> +	return stm32_adfsdm_get_supported_rates(dai, &priv->rates_const.mask);
> 
> Since the DAI is unidirectional it doesn't matter but obviously if it
> weren't then the fact that getting the supported rates involves setting
> the hwparams means this could become disruptive.  If we're going to
> genericise this to be a more general IIO/ASoC bridge that could matter.
> 
>> +static int stm32_adfsdm_dai_remove(struct snd_soc_dai *dai)
>> +{
>> +	dev_dbg(dai->dev, "%s: enter for dai %d\n", __func__, dai->id);
>> +
>> +	return 0;
>> +}
> 
> Remove empty functions, though in this case I think you want to add
> something to disconnect the XRUN callback just in order to be sure it
> can't be mistakenly called.
> 
