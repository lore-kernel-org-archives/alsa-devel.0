From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: Add support for HifiBerry DAC
Date: Fri, 13 May 2016 14:20:57 +0200
Message-ID: <C139252A-23AC-4C37-A5E5-E0D7AF1DCC89@martin.sperl.org>
References: <1463130853-25096-1-git-send-email-kernel@martin.sperl.org> <1463130853-25096-3-git-send-email-kernel@martin.sperl.org> <20160513105409.GB22038@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160513105409.GB22038-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>, Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


> On 13.05.2016, at 12:54, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> On Fri, May 13, 2016 at 09:14:13AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> 
>> +static int snd_rpi_hifiberry_dac_init(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +	return 0;
>> +}
> 
> Remove empty functions.  Either they are redundant or you really need to
> do something in them.
> 
Sure this can get removed.

As said - it is just pushing the patches upstream,
so I did not even touch it. 

>> +static struct snd_soc_dai_link snd_rpi_hifiberry_dac_dai[] = {
>> +{
>> +	.name		= "HifiBerry DAC",
>> +	.stream_name	= "HifiBerry DAC HiFi",
>> +	.cpu_dai_name	= "bcm2708-i2s.0",
>> +	.codec_dai_name	= "pcm5102a-hifi",
>> +	.platform_name	= "bcm2708-i2s.0",
>> +	.codec_name	= "pcm5102a-codec",
> 
> I would expect all this to be done with DT references in a DT driver
> rather than hard coding static names - look at how simple-card does this.
> You could almost use simple-card here but the BCLK ratio requirement is
> probably a bit much, I'm not immediately seeing a nice way to specify
> the ratio there since it depends on the sample width.

Actually it is just: <sample-width> * <number of channels>
where number of channels is fixed to 2 for bcm2835-i2s.

So maybe that already happens automatically in the framework?

I will need to test it...

I also know that some of the audio guys working on the rpi
would like to be able to configure BCLK ratios based on both:
sample frequency and sample_width.

Basically they want to control the clock divider/clock parent
trying to avoid fractional dividers.

Something like this could get added to the core?
Is there interest in getting something like this?

Could look like this:
bclk-ratios = 
  /* for 96kHz at 16bit/channel use bclk-ratio 40 */
  <96000 16 40>, 
  /* for 48kHz at 32bit/channel use bclk-ratio 80 */
  <48000 16 80>,
  /* for any (other) sample frequency at 16 bit use bclk-ratio 32 */
  <0 16 32>,
  /* for any (other) sample frequency at 32 bit use bclk-ratio 64 */
  <0 32 64>;

but there could also be other approaches as well,
how this could get described in the device tree.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
