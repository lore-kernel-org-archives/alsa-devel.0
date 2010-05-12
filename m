From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 4/6] cs42l51: add asoc driver
Date: Wed, 12 May 2010 10:56:27 +0100
Message-ID: <20100512095627.GE4330@rakim.wolfsonmicro.main>
References: <20100511162342.640158675@mandriva.com>
	<20100511162602.226980713@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1AD7F2412E
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 11:56:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100511162602.226980713@mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: apatard@mandriva.com
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, saeed@marvell.com, tbm@cyrius.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 11, 2010 at 06:23:46PM +0200, apatard@mandriva.com wrote:

> This patch is adding a ASoC driver for the cs42l51 from Cirrus Logic.
> Master mode and spi mode are not supported.

This is mostly OK - there's quite a few comments below but there's no
massive structural things in here, it's generally small, local things.

> + * Based on cs4270.c - Copyright (c) Timur Tabi <timur@freescale.com>

While we're picking up on the copyright stuff IIRC it's actually
Freescale copyright rather than Timur's personal copyright :)

> +enum funct_mode {
> +	MODE_SLAVE,
> +	MODE_SLAVE_AUTO,
> +	MODE_MASTER,
> +};

I'd prefer a more meaningful name than "funct_mode" here - I don't
really know what a funct is.

> +static unsigned int cs42l51_read_reg_cache(struct snd_soc_codec *codec,
> +	unsigned int reg)
> +{
> +	u8 *cache = codec->reg_cache;
> +
> +	if ((reg < CS42L51_FIRSTREG) || (reg > CS42L51_LASTREG))
> +		return -EIO;
> +
> +	return cache[reg - CS42L51_FIRSTREG];

Please just use the standard register cache access stuff in soc-cache.c.
The first register is 1 so you're only burning a single byte of RAM by
using the generic code.

> +	if (ret != MK_CHIP_REV(CHIP_ID, CHIP_REV)) {

Are you sure there's only one device revision in production?

> +		dev_err(&i2c_client->dev, "Invalid chip id\n");
> +		ret = -ENODEV;
> +		goto error;
> +	}

> +	dev_info(&i2c_client->dev, "found device at I2C address %X\n",
> +				i2c_client->addr);

The dev_() will already be including the I2C address in the log message
anyway.  I'd be inclined to just drop this, or make it log the device
revision.

> +	ret = cs42l51_fill_cache(codec);
> +	if (ret < 0) {
> +		dev_err(&i2c_client->dev, "failed to fill register cache\n");
> +		goto error;
> +	}

Normal practice is to reset the chip so it's in a known sensible state
when the driver starts trying to use it.  Is there a good reason not to
do this here?

> +	/*
> +	 * DAC configuration (right place to do that ?)

It's OK to do this for things that the user would unconditionally want.

> +	 * - Use signal processor

What does this mean? It sounds like something that would need to be
power managed via DAPM?

> +	 * - auto mute

This is probably OK, but exposing as a user visible control would be
better.

> +	 * - vol changes immediate

This is OK.

> +	 * - no de-emphasize

This is normally exposed as a user selectable switch.

> +	/* Unmute PCM-A & PCM-B and set default vol to */
> +	ret = cs42l51_i2c_write(codec, PCMA_VOL, 0x60);
> +	if (ret < 0)
> +		goto error;

This should not be done in the driver, leave it up to userspace.  This
driver will be used by all systems using this CODEC so just rely on the
hardware defaults to provide a sane power on configuration - the
designers will usually ensure that this is at least not harmful.

> +	/* route microphone */
> +	ret = cs42l51_i2c_write(codec, ADC_INPUT, 0xF0);
> +	if (ret < 0)
> +		goto error;

Ditto.

> +error_reg:
> +	snd_soc_unregister_codec(codec);
> +error:
> +	return ret;

You're missing some error handling here - there's no free of the device
data, for example.

> +static int cs42l51_get_chan_mix(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	unsigned long value = snd_soc_read(codec, PCM_MIXER)&3;
> +
> +	switch (value) {
> +	default:
> +	case 0:
> +		ucontrol->value.integer.value[0] = 0;
> +		break;
> +	case 1:
> +	case 2:
> +		ucontrol->value.integer.value[0] = 1;
> +		break;
> +	case 3:
> +		ucontrol->value.integer.value[0] = 2;
> +		break;
> +	}
> +
> +	return 0;
> +}

Some comments here might be a little clearer...  Why is the difference
between 1 and 2 not interesting?

> +static const char *mic_boost[] = { "+16dB", "+32dB"};

Could use TLV for this too.

> +static const struct soc_enum cs42l51_mix[] = {
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(chan_mix), chan_mix),
> +	SOC_ENUM_DOUBLE(MIC_CTL, 0, 1, 2, mic_boost),
> +};

Don't do this, declare separate variables for each.  Indexing into a
table of mixer elements doesn't help leigibility and is asking for off
by one errors.  Some drivers do this for historical reasons but modern
drivers don't.

> +	SOC_DOUBLE_R("PCM Playback Switch", PCMA_VOL, PCMB_VOL, 7, 1, 1),

I suspect that this should be managed via the DAI mute function.

> +	SOC_SINGLE("Playback Deemphasis", DAC_CTL, 3, 1, 0),

Should have "Switch" at the end of the control name.

> +	SOC_SINGLE("Mic Bias", MIC_POWER_CTL, 1, 1, 1),

This should be a DAPM MICBIAS control.

> +	SOC_DOUBLE("Mic Powerdown", MIC_POWER_CTL, 2, 3, 1, 0),

What does this do?  Sounds like it should be DAPM controls.

> +	default:
> +		printk(KERN_ERR "cs4270: invalid DAI format\n");

Cut'n'paste.

> +/* Fill me */
> +static struct cs42l51_ratios master_ratios[] = { {},
> +};

Just remove this stuff for master mode if it's not implemented.

> +	for (i = 0; i < ARRAY_SIZE(cs42l51_snd_controls); i++) {
> +		ret = snd_ctl_add(codec->card,
> +				snd_soc_cnew(&cs42l51_snd_controls[i],
> +				codec, NULL));
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "failed to add controls\n");
> +			snd_soc_free_pcms(socdev);
> +			return ret;
> +		}
> +	}

snd_soc_add_controls() rather than open coding.

> +#define BEEP_FREQ		0x12
> +#define BEEP_VOL		0x13
> +#define BEEP_CONF		0x14

Please namespace everything in the header - things like this are asking
for namespace clashes.
