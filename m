From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: axentia: tse850: add ASoC driver for the
 Axentia TSE-850
Date: Wed, 9 Nov 2016 17:27:43 +0100
Message-ID: <3d6b99e8-f19f-51fd-1676-c3a4549ec312@axentia.se>
References: <1478622057-12426-1-git-send-email-peda@axentia.se>
 <1478622057-12426-3-git-send-email-peda@axentia.se>
 <20161109133852.nvlyiqow2xpbc6ga@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161109133852.nvlyiqow2xpbc6ga-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 2016-11-09 14:38, Mark Brown wrote:
> On Tue, Nov 08, 2016 at 05:20:57PM +0100, Peter Rosin wrote:
> 
>> +++ b/sound/soc/axentia/Kconfig
>> @@ -0,0 +1,10 @@
>> +config SND_SOC_AXENTIA_TSE850_PCM5142
>> +	tristate "ASoC driver for the Axentia TSE-850"
>> +	depends on ARCH_AT91 && OF
>> +	select ATMEL_SSC
>> +	select SND_ATMEL_SOC
>> +	select SND_ATMEL_SOC_SSC_DMA
>> +	select SND_SOC_PCM512x_I2C
>> +	help
>> +	  Say Y if you want to add support for the ASoC driver for the
>> +	  Axentia TSE-850 with a PCM5142 codec.
> 
> This just looks like a normal machine driver for an Atmel system which
> would usually go in the atemel directory - why is a new directory being
> created?

I thought atmel in this context meant that Atmel made the board, not that
the board was based on an Atmel cpu.

I'll move it for v2.

>> +static int tse850_get_mux2(struct snd_kcontrol *kctrl,
>> +			   struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kctrl);
>> +	struct snd_soc_card *card = dapm->card;
>> +	struct tse850_priv *tse850 = snd_soc_card_get_drvdata(card);
>> +	int ret;
>> +
>> +	ret = gpiod_get_value(tse850->loop2);
>> +	if (ret < 0)
>> +		return ret;
> 
> We can't reliably read the value of output GPIOs (though in practice the
> majority do support it) so it'd be better practice to use a state
> variable to remember what we set.  I'd also expect this to use the
> _cansleep() GPIO calls as it's not in a context where sleeping would be
> a problem.

Ok, I'll add _cansleep and cached values for v2.

>> +int tse850_get_ana(struct snd_kcontrol *kctrl,
>> +		   struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kctrl);
>> +	struct snd_soc_card *card = dapm->card;
>> +	struct tse850_priv *tse850 = snd_soc_card_get_drvdata(card);
>> +	int ret;
>> +
>> +	ret = regulator_get_voltage(tse850->ana);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (ret < 11000000)
>> +		ret = 11000000;
>> +	else if (ret > 20000000)
>> +		ret = 20000000;
> 
> This needs some comments...

Ok, I'll add some words...

>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct device *dev = rtd->dev;
>> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>> +	int dir = substream->stream != SNDRV_PCM_STREAM_PLAYBACK;
>> +	int div_id = dir ? ATMEL_SSC_RCMR_PERIOD : ATMEL_SSC_TCMR_PERIOD;
>> +	int period = snd_soc_params_to_frame_size(params) / 2 - 1;
> 
> Please write the logic out as normal if statements for legibility.  It's
> a bit concerning that we even need this function, it looks like pretty
> basic stuff that I'd expect the CPU DAI to just be doing - why can't
> this be the default behaviour of the CPU DAI?

I don't know and obviously don't have all the relevant HW to test
changes. Do you want me to attempt such a change anyway?
Adding Cc: Nicolas Ferre

>> +static int tse850_init(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +	struct snd_soc_dapm_context *dapm = &rtd->card->dapm;
>> +
>> +	return snd_soc_dapm_add_routes(dapm, tse850_intercon,
>> +				       ARRAY_SIZE(tse850_intercon));
> 
> Set this up in the card data structure rather than open coding the call,
> you can register DAPM routes there too.

Right.

Thanks for looking!

Cheers,
Peter

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
