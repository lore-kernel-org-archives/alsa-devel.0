From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: New codec for STAC9766 used on Efika
Date: Fri, 1 May 2009 11:14:03 +0100
Message-ID: <20090501101402.GB6975@sirena.org.uk>
References: <9e4733910904301330h54581775i592d1ee4049a8dd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FA1E2415F
	for <alsa-devel@alsa-project.org>;
	Fri,  1 May 2009 12:14:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910904301330h54581775i592d1ee4049a8dd0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matt Sealey <matt@genesi-usa.com>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 30, 2009 at 04:30:12PM -0400, Jon Smirl wrote:
> Could you please review this new STAC9766 codec implementation. Some

Please do CC me on ASoC patches; I've asked you to do this several times
before and it's standard practice for kernel patch submissions to CC the
relevant maintainers.

Overall the driver looks fairly good, just needs a bit of tidying up.

> of the controls aren't where they need to be. For example the mutes on
> the mixer inputs. I'm not sure where they are supposed to go.

Could you be more specific?  Generally the mute would be used as a
switch and appear in the list of controls passed to the mixer.

> How should SPDIF support work? The hardware supports simultaneous use
> of analog and SPDIF.  Do I want one DAI or two?  If I have two DAI

Having taken a step back and looked at the datasheet what's going on
here is that the CODEC has a S/PDIF output which can take either an AC97
timeslot or the output of the ADC as input.  The AC97 timeslot input
should probably be represented as a DAI, feeding into a mux selecting
the input to be output to S/PDIF.

> then ALSA needs to interleave the samples into a single DMA stream. So
> if one stream isn't active it needs to be filled with silence.

The AC97 controller driver should be able to expose multiple data
streams - normally the hardware has direct support for this.

> I get a few errors from the current config:
> Failed to add route All Analog Mixer->Pop Bypass Mux

You've called the mixer both "All Analog Mixer" and "All Analog".

> dapm: STAC9766: configuring unknown pin OUT3
> dapm: STAC9766: configuring unknown pin MONOOUT
> Failed to add route HPOUTL->Headphone Jack
> dapm: STAC9766: configuring unknown pin OUT3
> dapm: STAC9766: configuring unknown pin MONOOUT
> Failed to add route HPOUTL->Headphone Jack

For the rest I'd suggest checking your machine driver; there's no
references to any OUT3, HPOUTL or MONOOUT pins in your driver and
Headphone Jack should definitely be part of the machine driver.

> /*
>  * stac9766.c  --  ALSA Soc STAC9766 codec support

SoC.

>  *
>  * Copyright 2008 Jon Smirl, Digispeaker

2009, I expect.

> static const u16 stac9766_reg[] = {
>         0x6A90, 0x8000, 0x8000, 0x8000, // 6

No C++ comments, please.

> static const struct soc_enum stac9766_enum[] = {
> 	SOC_ENUM_DOUBLE(AC97_REC_SEL, 8, 0, 8, stac9766_record_mux), /* Record Mux 0 */

Please define individual variables rather than using a table like this -
it does nothing for legibility to have to use array indexes to refer to
the enums.  Some older drivers do this as a result of being converted
from pre-ASoC driers where it made more sense to have the table.

> 	SOC_SINGLE("Mixer PC Beep Volume", AC97_PC_BEEP, 1, 15, 1),

For the "Mixer x Volume" controls you should change the name so that it
lines up with the names that are generated for the mixer switches.  This
will allow ALSA to present them as a single control to users, making UIs
work better.  You want the control names to be the same apart from the
final "Switch" or "Volume".

It'd also be worth considering adding TLV information to the volume
controls if the gains are documented, but it's not essential.

> 	SOC_SINGLE("Mic Gain", AC97_STAC_ANALOG_SPECIAL, 2, 1, 1),

Mic Volume, probably.

> 	SOC_DOUBLE("Record Gain", AC97_REC_GAIN, 8, 0, 31, 1),

Volume, again - gain and attenuation are both just volumes.

> static const struct snd_soc_dapm_widget stac9766_dapm_widgets[] = {
> 	SND_SOC_DAPM_INPUT("PCMOut"),

If my brief glance at the datasheet is accurate this is actually your
AC97 DAI and shouldn't be a pin.

> 	SND_SOC_DAPM_ADC("ADC", "Analog Capture", AC97_POWERDOWN, 8, 1),

> 	SND_SOC_DAPM_OUTPUT("PCMIn"),

This is the AC97 DAI too.

> 	/* Record Mux */
> 	{"ADC", NULL, "Mic1/2 Mux"},
> 	{"ADC", NULL, "CD"},
> 	{"ADC", NULL, "Video"},
> 	{"ADC", NULL, "AUX"},
> 	{"ADC", NULL, "Line"},
> 	{"ADC", NULL, "Record All Mux"},
> 	{"ADC", NULL, "Phone"},

You should be putting the controls from the mux in rather the NULLs here
- at the minute it looks to DAPM like all the paths are permanantly
connected.

> 	{NULL, NULL, NULL},

This isn't required.

> 		val = soc_ac97_ops.read(codec->ac97, reg);
> 		return val;
> 	}
> 	return cache[reg / 2];

Indentation.

> static int ac97_analog_prepare(struct snd_pcm_substream *substream,
> 			     struct snd_soc_dai *dai)
> {
> 	struct snd_soc_codec *codec = dai->codec;
> 	struct snd_pcm_runtime *runtime = substream->runtime;
> 	unsigned short reg, vra;
> 
> 	vra = stac9766_ac97_read(codec, AC97_EXTENDED_STATUS);
> 
> 	//vra |= 0x4;

Either this should go or it should be uncommented.

> static int ac97_digital_prepare(struct snd_pcm_substream *substream,
> 			     struct snd_soc_dai *dai)
> {
> 	printk("stac9766: ac97_digital_prepare\n");
> 
> 	return 0;
> }

This function can just be removed.

> static int stac9766_set_bias_level(struct snd_soc_codec *codec,
> 						enum snd_soc_bias_level level)
> {
> 	switch (level) {
> 	case SND_SOC_BIAS_ON: /* full On */
> 		stac9766_ac97_write(codec, AC97_POWERDOWN, 0x0000);
> 		break;
> 	case SND_SOC_BIAS_PREPARE: /* partial On */
> 		stac9766_ac97_write(codec, AC97_POWERDOWN, 0x0000);
> 		break;

These should be noops if you're using DAPM.

> 	.playback = {
> 		.stream_name	= "stac9766 analog",
> 		.channels_min	= 1,
> 		.channels_max	= 2,
> 		.rates		= SNDRV_PCM_RATE_8000_48000,
> 		.formats	= SNDRV_PCM_FMTBIT_S32_BE,

Are you sure about this?  AC97 generally does 16 bit samples...

> static int __init stac9766_probe(struct platform_device *pdev)

__devinit.

> static __init int stac9766_driver_init(void)
> {
> 	snd_soc_register_dais(stac9766_dai, ARRAY_SIZE(stac9766_dai));

This should be done when your driver probes - it is only done on module
init for drivers which are not able to probe through normal methods.
