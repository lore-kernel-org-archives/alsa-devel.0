From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC] SoC WM8940 Driver
Date: Sat, 25 Apr 2009 19:03:47 +0100
Message-ID: <20090425180346.GA4072@sirena.org.uk>
References: <49F21310.4060009@cam.ac.uk> <20090425102100.GA4394@sirena.org.uk>
	<49F345A8.1030901@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 43A5224500
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Apr 2009 20:03:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49F345A8.1030901@cam.ac.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 25, 2009 at 05:17:28PM +0000, Jonathan Cameron wrote:

> >> +static u16 wm8940_reg_defaults[] = {
> >> +	[WM8940_SOFTRESET] =		0x8940,
> >> +	[WM8940_POWER1] =		0x0000,

> > I'd really rather use the more standard ASoC style here with a simple
> > table of values.  The driver relies on the fact that the register
> > cache is fully specified for suspend and resume and having a straight
> > table makes sure that there aren't any missing values in the cache.

> Ok, though I'd place the alternate argument that it lead to rather
> less readable code than this sort of syntax where it readily apparent
> exactly what is in each register.

Sure - if you do this using an alternative syntax that'd be fine.  For
example, several of the other drivers use comments to provide the
register names.

> >> +	SOC_SINGLE("Digital Loopback Switch adc to dac", WM8940_COMPANDINGCTL,
> >> +		   0, 1, 0),

> > This should be called Digital Sidetone Switch and probably ought to be a
> > DAPM control - there's an ADC to DAC route.

> I'll take your word for it!

If you switch the ADC to the DAC then you've got an audio path between
them.

> >> +	SOC_SINGLE_TLV("Speaker Playback Volume", WM8940_SPKVOL,
> >> +		       0, 63, 0, wm8940_spk_vol_tlv),
> >> +	SOC_SINGLE("Speaker Playback Mute", WM8940_SPKVOL,  6, 1, 0),

> > Speaker Playback Switch; this also means that the sense of the control
> > needs to be inverted.  Look at the control in alsamixer and you'll see
> > that it figures out that these both control the same thing and displays
> > them as a single Speaker Playback control in the UI.

> I wish, alsamixer isn't exactly playing ball with busy box for some reason
> I haven't chased down.  Looking at this lot using amixer isn't much fun!

amixer should show you the same information - yo'll get a simple mixer
control with both switch and volume capabilites.

> I'll try and work out how to do it right before next posting! Need to lure
> the board side of things into a configuration where this is relevant.

If you've got a scope you can use that to generate clocks with broken
audio.

> >> +	case SND_SOC_BIAS_PREPARE:
> >> +		/* ensure bufioen and biasen */
> >> +		pwr_reg |= (1 << 2) | (1 << 3);
> >> +		/* set vmid to 2.5k for fast start */
> >> +		wm8940_write(codec, WM8940_POWER1, pwr_reg | 0x3);
> >> +		break;

> > This isn't what the low resistance VMID setting is for;

> I admit I didn't really understand what was going on here, so I think I cribbed
> it from another driver.  What should the setting be? (and what is that setting
> for?)

Sorry, didn't finish writing that bit.  You should be setting the bias
for normal operation in prepare - the fast startup is only for use
during initial bringup of VMID since the lower resistrance allows the
capacitor used to charge more quickly.

The resistance of the VMID resistor string allows you to trade the
accuracy with which the VMID reference voltage is held (and therefore
audio performance) for power consumption.  Since it can take time to
charge the capacitors and bring VMID up to the required voltage it's
desirable to maintian VMID while the system is active in order to allow
rapid startup of an audio stream but doing so consumes power so the
higher resistance value is provided in order to allow that consumption
to be reduced.  The savings involved are very small but can produce a
noticable benefit in small, power sensitive devices like MP3 players.
