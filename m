From: Arnaud Patard <apatard@mandriva.com>
Subject: Re: [patch 4/6] cs42l51: add asoc driver
Date: Wed, 12 May 2010 15:46:53 +0200
Message-ID: <m37hn9ut9u.fsf@anduin.mandriva.com>
References: <20100511162342.640158675@mandriva.com>
	<20100511162602.226980713@mandriva.com>
	<20100512095627.GE4330@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mandriva.com (mx1.moondrake.net [212.85.150.166])
	by alsa0.perex.cz (Postfix) with ESMTP id 9067D24436
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 15:47:59 +0200 (CEST)
In-Reply-To: <20100512095627.GE4330@rakim.wolfsonmicro.main> (Mark Brown's
	message of "Wed, 12 May 2010 10:56:27 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, saeed@marvell.com, tbm@cyrius.com
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

Hi,

> On Tue, May 11, 2010 at 06:23:46PM +0200, apatard@mandriva.com wrote:
>
>> This patch is adding a ASoC driver for the cs42l51 from Cirrus Logic.
>> Master mode and spi mode are not supported.
>
> This is mostly OK - there's quite a few comments below but there's no
> massive structural things in here, it's generally small, local things.
>
>> + * Based on cs4270.c - Copyright (c) Timur Tabi <timur@freescale.com>
>
> While we're picking up on the copyright stuff IIRC it's actually
> Freescale copyright rather than Timur's personal copyright :)
>
>> +enum funct_mode {
>> +	MODE_SLAVE,
>> +	MODE_SLAVE_AUTO,
>> +	MODE_MASTER,
>> +};
>
> I'd prefer a more meaningful name than "funct_mode" here - I don't
> really know what a funct is.
>
>> +static unsigned int cs42l51_read_reg_cache(struct snd_soc_codec *codec,
>> +	unsigned int reg)
>> +{
>> +	u8 *cache = codec->reg_cache;
>> +
>> +	if ((reg < CS42L51_FIRSTREG) || (reg > CS42L51_LASTREG))
>> +		return -EIO;
>> +
>> +	return cache[reg - CS42L51_FIRSTREG];
>
> Please just use the standard register cache access stuff in soc-cache.c.
> The first register is 1 so you're only burning a single byte of RAM by
> using the generic code.

I'm using i2c_smbus_read_i2c_block_data() and didn't notice it in the
soc-cache.c file. I didn't look further so it's possible that there's
actually something working for my case.

>
>> +	if (ret != MK_CHIP_REV(CHIP_ID, CHIP_REV)) {
>
> Are you sure there's only one device revision in production?

According to the specs there are 2 revs id, the A and B. As I've got a
rev B, I assumed that the rev A has not been on prod. I've changed the
check to handle both revs.

>
>> +		dev_err(&i2c_client->dev, "Invalid chip id\n");
>> +		ret = -ENODEV;
>> +		goto error;
>> +	}
>
>> +	dev_info(&i2c_client->dev, "found device at I2C address %X\n",
>> +				i2c_client->addr);
>
> The dev_() will already be including the I2C address in the log message
> anyway.  I'd be inclined to just drop this, or make it log the device
> revision.

I'll make it log the device revision then. I prefer having a message
telling us something was found than no message at all. It's usefull when
debugging.

>
>> +	ret = cs42l51_fill_cache(codec);
>> +	if (ret < 0) {
>> +		dev_err(&i2c_client->dev, "failed to fill register cache\n");
>> +		goto error;
>> +	}
>
> Normal practice is to reset the chip so it's in a known sensible state
> when the driver starts trying to use it.  Is there a good reason not to
> do this here?

The default reset state is good except for the bits I'm changing few
lines later.

>
>> +	/*
>> +	 * DAC configuration (right place to do that ?)
>
> It's OK to do this for things that the user would unconditionally want.
>
>> +	 * - Use signal processor
>
> What does this mean? It sounds like something that would need to be
> power managed via DAPM?

there are 3 options for DAC:
00 - PCM Serial Port to DAC
01 - Signal Processing Engine to DAC
10 - ADC Serial Port to DAC

but only the "signal processing engine to DAC" configuration is
useful. Using others are dropping some functionnalities.

>
>> +	 * - auto mute
>
> This is probably OK, but exposing as a user visible control would be
> better.

there's a control for that. I'm only setting the register in a known
good state.

>
>> +	 * - vol changes immediate
>
> This is OK.
>
>> +	 * - no de-emphasize
>
> This is normally exposed as a user selectable switch.

idem

>
>> +	/* Unmute PCM-A & PCM-B and set default vol to */
>> +	ret = cs42l51_i2c_write(codec, PCMA_VOL, 0x60);
>> +	if (ret < 0)
>> +		goto error;
>
> This should not be done in the driver, leave it up to userspace.  This
> driver will be used by all systems using this CODEC so just rely on the
> hardware defaults to provide a sane power on configuration - the
> designers will usually ensure that this is at least not harmful.
>

ok. Default is 0db with channel enabled so it's fine I guess.

>> +	/* route microphone */
>> +	ret = cs42l51_i2c_write(codec, ADC_INPUT, 0xF0);
>> +	if (ret < 0)
>> +		goto error;
>
> Ditto.

That's the only way to get microphone support, that's why I didn't
consider it as an option.

>
>> +error_reg:
>> +	snd_soc_unregister_codec(codec);
>> +error:
>> +	return ret;
>
> You're missing some error handling here - there's no free of the device
> data, for example.
>
>> +static int cs42l51_get_chan_mix(struct snd_kcontrol *kcontrol,
>> +			struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
>> +	unsigned long value = snd_soc_read(codec, PCM_MIXER)&3;
>> +
>> +	switch (value) {
>> +	default:
>> +	case 0:
>> +		ucontrol->value.integer.value[0] = 0;
>> +		break;
>> +	case 1:
>> +	case 2:
>> +		ucontrol->value.integer.value[0] = 1;
>> +		break;
>> +	case 3:
>> +		ucontrol->value.integer.value[0] = 2;
>> +		break;
>> +	}
>> +
>> +	return 0;
>> +}
>
> Some comments here might be a little clearer...  Why is the difference
> between 1 and 2 not interesting?

1 and 2 are 2 values for the same things. (L+R)/2 signal is sent to both channels.

>
>> +static const char *mic_boost[] = { "+16dB", "+32dB"};
>
> Could use TLV for this too.
>
>> +static const struct soc_enum cs42l51_mix[] = {
>> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(chan_mix), chan_mix),
>> +	SOC_ENUM_DOUBLE(MIC_CTL, 0, 1, 2, mic_boost),
>> +};
>
> Don't do this, declare separate variables for each.  Indexing into a
> table of mixer elements doesn't help leigibility and is asking for off
> by one errors.  Some drivers do this for historical reasons but modern
> drivers don't.
>
>> +	SOC_DOUBLE_R("PCM Playback Switch", PCMA_VOL, PCMB_VOL, 7, 1, 1),
>
> I suspect that this should be managed via the DAI mute function.

I wondered about this too and I choose to not use it. My thoughts was
that if I was to go and implement the DAI mute, it should rather mute
PCM playback and Analog playback channels at the same time I guess.

>
>> +	SOC_SINGLE("Playback Deemphasis", DAC_CTL, 3, 1, 0),
>
> Should have "Switch" at the end of the control name.
>
>> +	SOC_SINGLE("Mic Bias", MIC_POWER_CTL, 1, 1, 1),
>
> This should be a DAPM MICBIAS control.
>
>> +	SOC_DOUBLE("Mic Powerdown", MIC_POWER_CTL, 2, 3, 1, 0),
>
> What does this do?  Sounds like it should be DAPM controls.

It's to power down (or not) the 2 preamplifiers of the microphone
channels and not to power down the microphone. Maybe the name is not the
best one. Better names accepted.
With this new explanation, should I convert it to DAPM or is it fine as
mixer control ?


Arnaud
