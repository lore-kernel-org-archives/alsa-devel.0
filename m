From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 4/6] cs42l51: add asoc driver
Date: Wed, 12 May 2010 15:08:35 +0100
Message-ID: <20100512140835.GC8082@rakim.wolfsonmicro.main>
References: <20100511162342.640158675@mandriva.com>
	<20100511162602.226980713@mandriva.com>
	<20100512095627.GE4330@rakim.wolfsonmicro.main>
	<m37hn9ut9u.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EE3C12443E
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 16:08:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m37hn9ut9u.fsf@anduin.mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <apatard@mandriva.com>
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, saeed@marvell.com, tbm@cyrius.com
List-Id: alsa-devel@alsa-project.org

On Wed, May 12, 2010 at 03:46:53PM +0200, Arnaud Patard wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
> > On Tue, May 11, 2010 at 06:23:46PM +0200, apatard@mandriva.com wrote:

> >> +	if ((reg < CS42L51_FIRSTREG) || (reg > CS42L51_LASTREG))
> >> +		return -EIO;

> >> +	return cache[reg - CS42L51_FIRSTREG];

> > Please just use the standard register cache access stuff in soc-cache.c.
> > The first register is 1 so you're only burning a single byte of RAM by
> > using the generic code.

> I'm using i2c_smbus_read_i2c_block_data() and didn't notice it in the
> soc-cache.c file. I didn't look further so it's possible that there's
> actually something working for my case.

The soc-cache stuff doesn't deal with initialising the cache so you can
still use that to initialise the cache.  Generally people use the I2C
APIs rather than smbus ones, smbus is just an I2C subset.

> >> +	ret = cs42l51_fill_cache(codec);
> >> +	if (ret < 0) {
> >> +		dev_err(&i2c_client->dev, "failed to fill register cache\n");
> >> +		goto error;
> >> +	}

> > Normal practice is to reset the chip so it's in a known sensible state
> > when the driver starts trying to use it.  Is there a good reason not to
> > do this here?

> The default reset state is good except for the bits I'm changing few
> lines later.

In that case a table of register defaults plus doing a reset is likely
to be more robust.

> >> +	 * - Use signal processor

> > What does this mean? It sounds like something that would need to be
> > power managed via DAPM?

> there are 3 options for DAC:
> 00 - PCM Serial Port to DAC
> 01 - Signal Processing Engine to DAC
> 10 - ADC Serial Port to DAC

> but only the "signal processing engine to DAC" configuration is
> useful. Using others are dropping some functionnalities.

This sounds like useful stuff to offer to the user as a runtime option -
ADC->DAC can be used for bypass paths, and PCM to DAC will presumably
save power if the DSP is not in use.

> >> +	/* route microphone */
> >> +	ret = cs42l51_i2c_write(codec, ADC_INPUT, 0xF0);
> >> +	if (ret < 0)
> >> +		goto error;

> > Ditto.

> That's the only way to get microphone support, that's why I didn't
> consider it as an option.

The routing should be runtime configurable.  I've no idea what the
options the chip offers are, but presumably some of the other options
are usable.

> >> +	SOC_DOUBLE_R("PCM Playback Switch", PCMA_VOL, PCMB_VOL, 7, 1, 1),

> > I suspect that this should be managed via the DAI mute function.

> I wondered about this too and I choose to not use it. My thoughts was
> that if I was to go and implement the DAI mute, it should rather mute
> PCM playback and Analog playback channels at the same time I guess.

No, the purpose of the DAI mute is specifically to stop the data coming
out of the DAC while the digital audio interface is coming up - some
systems see noise there when starting up so we do the DAC unmute last in
the stream start to ensure that we don't play any of that back to the
user.

> >> +	SOC_DOUBLE("Mic Powerdown", MIC_POWER_CTL, 2, 3, 1, 0),

> > What does this do?  Sounds like it should be DAPM controls.

> It's to power down (or not) the 2 preamplifiers of the microphone
> channels and not to power down the microphone. Maybe the name is not the
> best one. Better names accepted.
> With this new explanation, should I convert it to DAPM or is it fine as
> mixer control ?

That's definitely something that should be managed via DAPM - we only
need to power up the amplifier when the signal is being used.
