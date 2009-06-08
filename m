From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and
	add	Left_J support
Date: Mon, 8 Jun 2009 17:53:28 +0100
Message-ID: <20090608165328.GB14026@rakim.wolfsonmicro.main>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
	<1244477000.30582.72.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EE54C244FF
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 18:53:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1244477000.30582.72.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 08, 2009 at 01:03:20PM -0300, Daniel Ribeiro wrote:
> Em Seg, 2009-06-08 =E0s 13:40 +0100, Mark Brown escreveu:

> > I'm inclined to go with sample here since it seems harder for the
> > machine drivers to get wrong but I've not really thought it through yet?

> But sample wouldn't cover all cases. eg, magician and ezx uses the same
> sample size, but magician needs 16bit frames and ezx 32bits frames.

See my reply to Philip - even with frame size his case is going to be
very hard to cover in a standard fashion since it's not clear what to do
when your frame clock is run too fast relative to your bit clock.  On
the receive side a lot of devices are just going to discard incomplete
stereo frames.

> Just to confirm that I'm understanding the terminology here..
> Sample size is SNDRV_PCM_FORMAT_*, and frame size is the actual distance
> in clocks between each SSPFRM assertion. Is this correct?

That's pretty much my understanding - sample size is the number of bits
clocked per mono sample on the wire and frame size is the number of bits
clocked per cycle of the frame clock.

> > OTOH I don't really see much difference between the two cases - it's
> > just an extra couple of parameters on the end of the call.  That said,

> I agree with pHilipp, I don't need to set network mode for normal
> operation, but i want to be able to use real network mode.

Network mode is just a detail of the implementation of the PXA here - it
should not be visible outside the pxa-ssp driver.  Or to put it another
way setting a tdm_slot of 1, 1 ought to result in the same behaviour as
disabling TDM as far as the user is concerned.

> Using set_tdm_slot to setup this also seems awkward, because the dma
> configuration to use is also affected by the frame size.

I'd not expect it to be?

> And finally, set_tdm_mode doesn't cover all use cases, I may want to
> receive on a timeslot and keep the TX line high impedance, or I may want
> to use a different timeslot for TX...

Yes, set_tdm_mode() needs separate RX and TX configuration regardless -
if we added the framing configuration in there we should definitely make
that change at that point.

> My suggestion here is to make a clear distinction between normal mode
> and network mode. We should not abuse SSCR0_MOD when we don't need it.
> We should not require the machine driver to call set_tdm_slot when it
> doesn't need to. And for frame sizes that really need SSCR0_MOD to be
> set we should issue a warning telling that network mode was
> "automatically" enabled.

I'd like to see all these details handled within the driver - knowing if
and when network mode are to be set up is the sort of thing that users
ought to be able to rely on the driver for.
