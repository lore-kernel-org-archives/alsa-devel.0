From: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] sound: soc: codecs: Add es8328 codec
Date: Sat, 08 Feb 2014 16:17:28 +0800
Message-ID: <52F5E818.5050802@kosagi.com>
References: <1391749517-11787-1-git-send-email-xobs@kosagi.com> <1391749517-11787-2-git-send-email-xobs@kosagi.com> <20140207181238.GL1757@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140207181238.GL1757-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 8/2/14 2:12 AM, Mark Brown wrote:
> On Fri, Feb 07, 2014 at 01:05:15PM +0800, Sean Cross wrote:
> 
> Please use subject likes matching the style for the subsystem.  If
> your changelog looks different to others in the same area it
> probably needs an update.
> 
> In general this looks like it should be making much more use of
> the framework rather than open coding, it looks like it's very much
> hard coded for one use cae.

Alright, I'll try to use more of the framework provided.  I tried to
use one of the Wolfson codecs as an example.  Is there a "canonical"
driver that's up-to-date and uses an appreciable amount of framework?

>> +config SND_SOC_ES8328 +	tristate +
> 
> It looks like you're going to use this on an ARM system, you should
> add DT support and make it visible in Kconfig.
> 
>> +static const struct snd_soc_dapm_widget es8328_dapm_widgets[] =
>> { +	SND_SOC_DAPM_DAC("Speaker Volume", "HiFi Playback",
>> SND_SOC_NOPM, 0, 0),
> 
> Don't declare a stream by name, use DAPM routes to connect the
> stream to the widget.

Where can I read up on DAPM routes?  I don't see the word "route"
mentioned in the dapm.txt SoC documentation.

>> +	SND_SOC_DAPM_OUTPUT("VOUTL"), +	SND_SOC_DAPM_OUTPUT("VOUTR"), +
>> SND_SOC_DAPM_INPUT("LINE_IN"), +
>> SND_SOC_DAPM_INPUT("MIC_IN"), +
>> SND_SOC_DAPM_OUTPUT("HP_OUT"), +
>> SND_SOC_DAPM_OUTPUT("SPK_OUT"),
> 
> Something is messed up with your indentation, spaces vs tabs I
> expect.

Sloppy.  I'll fix this in the next revision.

Also, this is hard-coding widgets for this platform.  In reality,
there's an output LOUT1, ROUT1, LOUT2, ROUT2, in addition to LDAC and
RDAC.  The DAC outputs to both OUT1 and OUT2.  I feel this is the sort
of thing DAPM was designed to accommodate.

How can I specify LOUT1 etc., and how can I define the mapping of
outputs on my particular platform?  E.g. OUT2 goes to the Headset on
this board.

>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) { + +	if
>> (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> 
> An else clause is more idiomatic here.
> 
>> +		snd_soc_write(codec, ES8328_ADCCONTROL5, adc);
> 
> It's more idiomatic to use update_bits() here and save doing a
> manual read/modify/write cycle - it also avoids the write if not
> needed.

That makes sense.

>> +static int es8328_adc_enable(struct snd_soc_codec *codec) +{ +
>> u16 reg = snd_soc_read(codec, ES8328_CHIPPOWER); +	reg &=
>> ~(ES8328_CHIPPOWER_ADCVREF_OFF | +		 ES8328_CHIPPOWER_ADCPLL_OFF
>> | +		 ES8328_CHIPPOWER_ADCSTM_RESET | +
>> ES8328_CHIPPOWER_ADCDIG_OFF); +	snd_soc_write(codec,
>> ES8328_CHIPPOWER, reg);
> 
> This looks like it should be done in DAPM.

The codec has very strict power sequencing.  If I'm understanding the
document correctly, I'd add a DAPM widget for the DAC, and then
register a widget event for when the DAC gets opened, and do power
sequencing there?  Or is there a way to have multiple register writes
defined as a single DAPM widget?

>> + +	/* Set up microphone to be differential input */ +
>> snd_soc_write(codec, ES8328_ADCCONTROL2, 0xf0);
> 
> This looks like something that should be platform data and/or DAPM
> - other platforms may be wired differently.
> 
>> +	/* Set ADC to act as I2S master */ +	snd_soc_write(codec,
>> ES8328_ADCCONTROL3, 0x02);
> 
> set_dai_fmt().
> 
>> +	/* Set I2S to 16-bit mode */ +	snd_soc_write(codec,
>> ES8328_ADCCONTROL4, 0x18);
> 
> This should be being done in hw_params.
> 
>> +	/* Frequency clock of 272 */ +	snd_soc_write(codec,
>> ES8328_ADCCONTROL5, 0x02);
> 
> What is the frequency clock in this context?

The frequency is a specific divider defined in the datasheet.  There
is a table of frequencies and dividers for various frequencies.  One
option is to code this table into the driver and pick the frequency
clocks out of the table.

I decided to assume the codec has a fixed input frequency of 22.5792
MHz.  This means the codec can support 11.025, 22.05, and 44.1 kHz,
but cannot support 48 kHz.  It should be possible to instead feed the
codec a 24 MHz clock and run it at 48 kHz.  Pulseaudio runs at 44.1 by
default, so I went with that.

>> +	/* Power up LOUT2 ROUT2, and power down xOUT1 */ +
>> snd_soc_write(codec, ES8328_DACPOWER, +
>> ES8328_DACPOWER_ROUT2_ON | +			ES8328_DACPOWER_LOUT2_ON);
> 
> This looks like it should be being done in DAPM.
> 
>> +	/* Enable click-free power up */ +	snd_soc_write(codec,
>> ES8328_DACCONTROL6, ES8328_DACCONTROL6_CLICKFREE); +
>> snd_soc_write(codec, ES8328_DACCONTROL3, 0x36);
> 
> Just do this once on startup?

Correct.

>> +	/* Set I2S to 16-bit mode */ +	snd_soc_write(codec,
>> ES8328_DACCONTROL1, ES8328_DACCONTROL1_DACWL_16);
> 
> hw_params().
> 
>> +	/* No attenuation */ +	snd_soc_write(codec, ES8328_DACCONTROL4,
>> 0x00); +	snd_soc_write(codec, ES8328_DACCONTROL5, 0x00);
> 
> This and the rest of the function looks like it should be done in
> a combination of DAPM and normal ALSA controls.
> 
>> +	for (i = 0; i < 4; i++) +		snd_soc_write(codec, i +
>> ES8328_DACCONTROL24, old_volumes[i]);
> 
> You are probably looking for something like
> SOC_DAPM_SINGLE_AUTODISABLE.
> 
>> +static const struct snd_soc_dai_ops es8328_dai_ops = { +
>> .hw_params	= es8328_hw_params, +	.prepare	= es8328_pcm_prepare, +
>> .shutdown	= es8328_pcm_shutdown, +//	.digital_mute	=
>> es8328_mute,
> 
> Hrm?

Oops.  Leftover from some anti-pop work I did earlier.  I'll remove it.

>> +static const struct of_device_id es8328_of_match[] = { +	{
>> .compatible = "everest,es8328", }, +	{ } +}; 
>> +MODULE_DEVICE_TABLE(of, es8328_of_match);
> 
> Any device tree device needs a binding document.
> 

My fault for omitting one.

Much of the code in adc_enable() and dac_enable() come from the
reference manual.  They indicate that the codec has very strict
ordering requirements on registers that must be set during playback
and recording.  Again, is there any way to ensure that hw_params(),
set_dai_fmt(), and the DAPM widgets are called in a specific order?

Thank you for the feedback.

Sean

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
