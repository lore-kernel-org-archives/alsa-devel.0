From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: [PATCH] ASoC: Add new TI TLV320AIC3204 CODEC driver
Date: Sun, 20 Jun 2010 21:28:41 +1000
Message-ID: <20100620112841.GB1609@www.longlandclan.yi.org>
References: <1276833465-31702-1-git-send-email-redhatter@gentoo.org>
	<1276899876-19001-1-git-send-email-redhatter@gentoo.org>
	<20100619011221.GC2463@opensource.wolfsonmicro.com>
	<20100619094908.GD30868@www.longlandclan.yi.org>
	<20100619105706.GA2409@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2EDDE2440B
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jun 2010 13:29:05 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OQIht-0007w7-Q0
	for alsa-devel@alsa-project.org; Sun, 20 Jun 2010 21:28:58 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OQIhm-0007ui-RX
	for alsa-devel@alsa-project.org; Sun, 20 Jun 2010 21:28:57 +1000
Content-Disposition: inline
In-Reply-To: <20100619105706.GA2409@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

[Dropping Linux kernel mailing lists, since this is ALSA-specific.]

On Sat, Jun 19, 2010 at 11:57:07AM +0100, Mark Brown wrote:
> On Sat, Jun 19, 2010 at 07:49:08PM +1000, Stuart Longland wrote:
> > On Sat, Jun 19, 2010 at 02:12:21AM +0100, Mark Brown wrote:
> > > On Sat, Jun 19, 2010 at 08:24:36AM +1000, Stuart Longland wrote:
> =

> > > > +	/* LDO Enable */
> > > > +	u8	ldo_en;
> =

> > > Similarly here.
> =

> > Well, I didn't see the point in allocating 32-bits when I'd only be
> > using 1 of them.  However, I can change it to an int if need be.  I'm
> > not certain that C has a true "bool" type, but I could be wrong.
> =

> C99 introduced a bool type, and there's always been bitfields.  Besides,
> you're microoptimising something that doesn't need it.  When you write
> u8 that means you really need this field to be unsigned and 8 bits which
> is a bit confusing for something that's actually just a flag.

No worries, I'll swap it for a bool then. :-)

> > > > +	/* Oversampling rate (both ADC and DAC) */
> > > > +	u8	osr;
> =

> > > Why is this platform data rather than a runtime configurable option?
> =

> > How would the application elect a particular oversampling rate?  I'll
> > admit I'm very new to the ALSA framework in general, but I didn't
> > realise there was an oversampling rate setting.  I'll have a look at how
> > the other drivers do it.
> =

> The oversampling rate selection is a performance/power tradeoff.  The
> user may choose to do things like use high performance when listening to
> music but step back a bit when playing system sounds, for example.
> =

> There's no specific ALSA control for it, just make it a Switch.

Are switches variable?  For what its worth, I've simplified things by
assuming the oversampling rate is identical for DAC and ADC.  It is
possible to have DAC OSRs up to 1024... but the ADC OSR is limited to
128.  I keep them identical as it simplifies clock generation.

I'm thinking if I make this a control, it'd have to be some numeric
control (not a TLV, but something similar with a linear scale).

> > > This looks suspiciously close to the standard show_reg() - it seems
> > > wrong that you should need it.
> =

> > Well, the main difference; standard show_reg uses %4x as its format; and
> > therefore wastes two characters printing nothing useful.  Given space is
> > already tight for displaying register dumps via debugfs, any little bit
> > helps. :-)
> =

> > Certainly there's no explicit reason why it is necessary and it can go.
> =

> If you want to do this it'd be better to add support to the core, for
> example by keying off a register width supplied by the CODEC.

I'll give this some thought... as it'd also be useful to format the
register numbers as being 16-bits wide rather than 8-bits too.

> > > > +	/*
> > > > +	 * These registers are not manipulated by us, so we must read the=
m from
> > > > +	 * the CODEC directly.
> > > > +	 */
> =

> > > Hrm?  Also, it strikes me that this code is also used in the WCLK
> > > function and might benefit from being factored out - it's moderately
> > > verbose.
> =

> > The ADC flags register (and the DAC flags registers) are read-only and
> > manipulated by the CODEC when the ADCs and DACs are actually powered up.
> > I could use the flags set elsewhere, but this reflects what *is* the
> > present state, not what ought to be the present state.
> =

> This strikes me as something that's going to hit a race condition at
> some point - if the two differ I'd hope that the state the driver has
> set is going to be the actual CODEC state very soon.

Yeah... it's problematic... by far this is the thing that needs the most
work out of all of it.

> > There is common code between the WCLK and BCLK functions; in fact I did
> > consider making it the one callback, but since they are separate in the
> > registers, I kept them separate in the callbacks.
> =

> I was thinking more a utility function that both callbacks use to work
> out which of the DACs and ADCs are powered.

Ahh yes, makes sense.

> > Now that the mixer is working okay, I could cut this down... but also I
> > hope that others who follow the same path as me, might find this helpful
> > to determine what's going on.
> =

> If we're going to do that we'd need to be doing it for every single TLV
> control in every single driver...

Understood, I'll tidy this up in the next revision.

> > Well, when the problem goes, so can the comment. :-)  One question
> > though, the shift value derives the mask for further operations on these
> > registers... if we were to change the shift value so it reflected how
> > other widget types work, how does one define the mask?
> =

> I'd intuitively expect it to be relative to the start of the controlled
> data rather than the start of the register.

Correct... but how do you define the mask's width?  Would that be
derived from min or max (or both)?

> > > > +	SOC_SINGLE("Differential Output Switch", AIC3204_DACS2,
> > > > +			AIC3204_DACS2_RMOD_INV_SHIFT, 1, 0),
> =

> > > This feels like platform data - the use of differential outputs is
> > > normally a property of the physical wiring of the board, it's very ra=
re
> > > to be able to vary this usefully at runtime.
> =

> > Arguably, so is the DAC audio path routing.  I wasn't sure how to set
> > this up at the time, initially it was CODEC setup data, then I moved it
> > into the mixer.
> =

> The DAC routing can be usefully varied at runtime depending on the use
> case - for example, sometimes people choose to route a mono signal into
> both DACs to give stereo output.  It would be very unusual hardware that =

> provided a way of switching between single ended and differential in a
> similar fashion.

Indeed the routing controls I've provided via standard SOC controls,
allows this.  It also allows routing a stereo signal to a mono output
(which is what we do; since the I=B2S bus doesn't seem to like mono).

I wasn't sure how else to do it, and this seemed to be the most flexible
option.  However, if it's better as platform data, then platform data it
is. ;-)

> > > > +	SOC_ENUM("MICBIAS Level", aic3204_enum_micbias_voltage),
> > > > +	SOC_ENUM("MICBIAS Source", aic3204_enum_micbias_src),
> =

> > > These I would expect to be managed in kernel - they're normally eithe=
r a
> > > property of the board or need to be managed in conjunction with jack
> > > detection code which tends to live in kernel.
> =

> > I'll look into this... I was aware of the MICBIAS widget, but will have
> > to do some further research here.  As to the others... I wasn't sure how
> > they should be handled.
> =

> Platform data initially then provide a runtime API for machine drivers
> if requireed.

Okay, sounds reasonable. :-)

> > > > +static const struct snd_soc_dapm_widget aic3204_dapm_widgets[] =3D=
 {
> > > > +	/* Driver/Amplifier Selection */
> > > > +	SND_SOC_DAPM_SWITCH("HPL Playback Switch", AIC3204_OUTDRV,
> > > > +			AIC3204_OUTDRV_HPL_UP_SHIFT, 0,
> > > > +			&aic3204_hpl_switch),
> > > > +	SND_SOC_DAPM_SWITCH("HPR Playback Switch", AIC3204_OUTDRV,
> > > > +			AIC3204_OUTDRV_HPR_UP_SHIFT, 0,
> > > > +			&aic3204_hpr_switch),
> =

> > > A lot of these SWITCH controls feel like they ought to be PGAs and the
> > > switch controls mutes on those.  When muting an output you normally
> > > don't want to power up and down the path since that is slow and tends=
 to
> > > trigger audible issues, you'd normally control the power for path
> > > endpoints and elements that affect routing only.
> =

> > They are PGAs connecting the driver to its mixer... I wasn't sure how
> > the PGAs worked in DAPM.  I knew this did work however, the only catch
> =

> These should definitely be PGA widgets as described above.

No problems, I'll convert these.

> > is that DAPM won't power up the DACs unless you switch them through via
> > these mixers to one of the output drivers.  I'll have a closer look at
> > the PGAs and see what they're doing.
> =

> Not powering up the DACs unless there is a connected output path is the
> expected behaviour.

Yeah, this is to be expected, doesn't mean I haven't been caught out by
it more than once.  The thing with the TLV320AIC3204... the bit clock is
derived from one of two sources (actually four)... the ADC's clock, or
the DAC's clock.  If the ADCs are powered down, there's no ADC clock.
Likewise for the DAC.

The end result is that when ALSA tries recording or playback with the
DACs and ADCs powered down, it falls flat on its face because the clocks
aren't present.  Easily fixed ... you just connect the PGAs up in
alsamixer, but it's one of the gotchas with this driver. ;-)

> > > It surprises me that the ordering matters too much here; worst case y=
ou
> > > leave the interface declocked a little longer when you need to switch
> > > sources but that doesn't seem like the end of the world?
> =

> > Well, what I found is that if I didn't do it there... it would call the
> > WCLK and BCLK functions before powering up the DACs/ADCs.  Since they
> > have no idea whether recording or playback is in progress (I wasn't sure
> > how to extract this information), the functions rely on the flags
> > registers to determine this.
> =

> If you track this in the audio path setup/teardown path instead of
> looking at the DAC power status you should find everything works fine.

I'll have a closer look then.  I figured I was "doing it wrong", but
couldn't see what the right way was.  Would the event-handling widgets
be of use here?

> > > > +static int aic3204_mute(struct snd_soc_dai *dai, int mute)
> > > > +{
> =

> > > ...
> =

> > > > +	aic3204_write(codec, AIC3204_DACS2, dacs2);	/* Unmute DAC */
> =

> > > ...or possibly mute it :)
> =

> > Yes, obsolete comment I guess. :-)  This is also a mixer control...
> > which is better... leave it to ASoC core, or the user to control PCM
> > mute?  The user can mute using the line driver controls... so I guess I
> > should ditch the "PCM Playback Switch" control.
> =

> Remove the mixer control.  The automatic management ensures that no
> noise that is generated when starting up the audio stream propagates
> into the output path and that any soft unmute support in the CODEC gets
> used to stop you having a hard power up with an active signal.

Okay, it'll be gone in the next patch.

> > > > +	for (i =3D 0; i < AIC3204_CACHEREGNUM; i++) {
> > > > +		data[0] =3D i;
> > > > +		data[1] =3D cache[i];
> > > > +		codec->hw_write(codec->control_data, data, 2);
> =

> > > Since you've got a register defaults table you could skip rewriting
> > > registers which have their default value.
> =

> > Indeed, suspend/resume isn't tested at all, so no idea if it works or
> > not.  I should probably do a forced reset too just to be on the safe
> > side.  This is a reminant from the aic3x driver.
> =

> The reset should not be required, either the device will be as you left
> it or the power will have gone so it will be in the reset state anyway.

Yep, fair enough... I guess I like making absolutely sure.  Another
hacky way of doing this would be to fiddle with the cache so that the
reset register has the correct value to cause a soft reset, but let's
not go there. ;-)

> > > > +	/* LDO enable, analogue blocks enable */
> > > > +	snd_soc_update_bits(codec, AIC3204_LDO,
> > > > +			AIC3204_LDO_ANALOG | AIC3204_LDO_AVDD_UP,
> > > > +			AIC3204_LDO_ANALOG_ENABLED |
> > > > +			(aic3204->pdata.ldo_en
> > > > +			  ? AIC3204_LDO_AVDD_UP : 0));
> =

> > > This looks a bit fishy since the mask covers more bits than can ever =
be
> > > enabled - it reads like the other two bits should be unconditionally
> > > cleared.
> =

> > Would I be better breaking that statement up into two statements?  I did
> =

> Yes, it would be much more legible.

No worries, I'll break this up.

> > I wasn't sure about the link between AVDD and DVDD, so I left that
> > configurable.  I'm guessing most will probably want it disabled.  This
> > was configured using arbitrary register initialisation scripts, passed
> > in via the CODEC setup data... so at least things are headded in the
> > right direction. :-)
> =

> What does this register actually do?  Does it describe the hardware
> configuration to the device?

This is where I'm not clear on exactly what's going on... TI's
documentation seems to have a fair bit to be desired.  When the CODEC
powers up, the AVDD and DVDD are weakly connected together by some high
resistance inside the chip.

This register allows you to break that link so that AVDD and DVDD are
separate.  I'm guessing this would be the norm, perhaps I'll just ditch
the relevant platform data configuration.

BTW: thanks for the advice thus far. :-)
-- =

Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
