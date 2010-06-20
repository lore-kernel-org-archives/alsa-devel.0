From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add new TI TLV320AIC3204 CODEC driver
Date: Sun, 20 Jun 2010 14:20:18 +0100
Message-ID: <20100620132017.GB2405@opensource.wolfsonmicro.com>
References: <1276833465-31702-1-git-send-email-redhatter@gentoo.org>
	<1276899876-19001-1-git-send-email-redhatter@gentoo.org>
	<20100619011221.GC2463@opensource.wolfsonmicro.com>
	<20100619094908.GD30868@www.longlandclan.yi.org>
	<20100619105706.GA2409@opensource.wolfsonmicro.com>
	<20100620112841.GB1609@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F09CE24347
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jun 2010 15:20:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100620112841.GB1609@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 20, 2010 at 09:28:41PM +1000, Stuart Longland wrote:
> On Sat, Jun 19, 2010 at 11:57:07AM +0100, Mark Brown wrote:
> > On Sat, Jun 19, 2010 at 07:49:08PM +1000, Stuart Longland wrote:
> > > On Sat, Jun 19, 2010 at 02:12:21AM +0100, Mark Brown wrote:
> > > > On Sat, Jun 19, 2010 at 08:24:36AM +1000, Stuart Longland wrote:

> > There's no specific ALSA control for it, just make it a Switch.

> Are switches variable?  For what its worth, I've simplified things by
> assuming the oversampling rate is identical for DAC and ADC.  It is
> possible to have DAC OSRs up to 1024... but the ADC OSR is limited to
> 128.  I keep them identical as it simplifies clock generation.

> I'm thinking if I make this a control, it'd have to be some numeric
> control (not a TLV, but something similar with a linear scale).

If there's a range of selectable options then use an enum.  Otherwise a
regular ALSA control gives a linear mapping, but you can't skip any
values.

> > > Well, when the problem goes, so can the comment. :-)  One question
> > > though, the shift value derives the mask for further operations on these
> > > registers... if we were to change the shift value so it reflected how
> > > other widget types work, how does one define the mask?

> > I'd intuitively expect it to be relative to the start of the controlled
> > data rather than the start of the register.

> Correct... but how do you define the mask's width?  Would that be
> derived from min or max (or both)?

I'd expect it to define the bits to be overwritten by the update - it'd
be related to the min and the max in that both need to be stored in a
value masked out but not directly (note that I've not gone so far as to
look at the actual control definition here).

> I wasn't sure how else to do it, and this seemed to be the most flexible
> option.  However, if it's better as platform data, then platform data it
> is. ;-)

It's flexible but it's flexibility that it's not possible to actually
use - like I say, these things get fixed when the board is laid out in
almost all cases.

> Yeah, this is to be expected, doesn't mean I haven't been caught out by
> it more than once.  The thing with the TLV320AIC3204... the bit clock is
> derived from one of two sources (actually four)... the ADC's clock, or
> the DAC's clock.  If the ADCs are powered down, there's no ADC clock.
> Likewise for the DAC.

Consider creating supply widgets for the actual DACs and ADCs then using
those to supply the clocks and NOPM DAC/ADC widgets.  Not thought that
through fully but I think it'd do the right thing.

> > If you track this in the audio path setup/teardown path instead of
> > looking at the DAC power status you should find everything works fine.

> I'll have a closer look then.  I figured I was "doing it wrong", but
> couldn't see what the right way was.  Would the event-handling widgets
> be of use here?

Possibly, another way of dealing with it might be to set the sources for
all the clocks whenever you power up or down a DAC or ADC rather than
based off the clock widgets themselves.

> > > I wasn't sure about the link between AVDD and DVDD, so I left that
> > > configurable.  I'm guessing most will probably want it disabled.  This
> > > was configured using arbitrary register initialisation scripts, passed
> > > in via the CODEC setup data... so at least things are headded in the
> > > right direction. :-)

> > What does this register actually do?  Does it describe the hardware
> > configuration to the device?

> This is where I'm not clear on exactly what's going on... TI's
> documentation seems to have a fair bit to be desired.  When the CODEC
> powers up, the AVDD and DVDD are weakly connected together by some high
> resistance inside the chip.

> This register allows you to break that link so that AVDD and DVDD are
> separate.  I'm guessing this would be the norm, perhaps I'll just ditch
> the relevant platform data configuration.

That sounds... intresting.  I note that there's an LDO in there - is
this for bootstrapping the LDO by any chance?  Power DVDD from AVDD
until the LDO has been enabled by software and then disable the link.
