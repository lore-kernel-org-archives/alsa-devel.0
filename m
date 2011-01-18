From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: Add FreeScale SGTL5000 codec
	suppor
Date: Tue, 18 Jan 2011 11:02:55 +0000
Message-ID: <20110118110255.GB26498@opensource.wolfsonmicro.com>
References: <20110117064816.GA2158@ubuntu.localdomain>
	<20110117153210.GJ21113@opensource.wolfsonmicro.com>
	<20110118023255.GA9481@ubuntu.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 01FA2103813
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 12:02:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110118023255.GA9481@ubuntu.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zeng Zhaoming <zhaoming.zeng@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, Zeng Zhaoming <zengzm.kernel@gmail.com>, lrg@slimlogic.co.uk, arnaud.patard@rtp-net.org, linuxzsc@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 18, 2011 at 10:32:55AM +0800, Zeng Zhaoming wrote:
> On Mon 2011-01-17 15:32:11, Mark Brown wrote:

> > It's not clear why you're storing some of this stuff in the private data
> > - for example, capture_channels is only referred to in the place where
> > it is set (so you may as well use the original value) and small_pop is
> > set unconditionally (it looks like the intention was to have platform
> > data for it?).

> yes, you are right. lrclk and capture_channels fields can be remove.
> small_pop is a configurable option of platform data.

Your patch unconditionally sets small_pop, there's no configuration via
platform data or otherwise.

> > of event and never turns anything off.  If this can't just be set once
> > at startup then a comment explaining why an event is needed would be
> > good.

> the odd code is cuased by:

Please note what I'm saying about making the code clear.

> > > +     case SND_SOC_DAPM_PRE_PMU:
> > > +             snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
> > > +                     SGTL5000_VAG_POWERUP|SGTL5000_DAC_POWERUP,
> > > +                     SGTL5000_VAG_POWERUP|SGTL5000_DAC_POWERUP);
> > > +             break;
> > > +
> > > +     case SND_SOC_DAPM_POST_PMD:
> > > +             snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
> > > +                     SGTL5000_DAC_POWERUP, 0);
> > > +             break;

> > Why does the powerdown not disable VAG_POWERUP?  My first thought was
> > that VAG_POWERUP ought to be a supply widget...

> My first version, VAG_POWERUP is a supply widget, but spec says:
> The headphone (and/or lineout) powerup should be set BEFORE clearing this bit.

> But the powerdown sequence go against it.
> So I turn to powerup VAG with DAC, and powerdown it before HP and Line_out.

The above doesn't seem to tie in with your code terribly well.  A
frequent issue throughout this code is that you're doing a bunch of
unusual stuff and it's really not clear what the code is supposed to do,
please work to make the code more comprehensible.  This is a problem
both from a legibility point of view and from the point of view of being
likely to break if the core changes.

The same issue applies to a lot of the other concerns I raised, for
brevity I've cut most of the discussion - in general the major issue
with the code is that it's really hard to read.

> > > +     switch (sys_fs / sgtl5000->lrclk) {
> > > +     case 4:
> > > +             clk_ctl |= SGTL5000_RATE_MODE_DIV_4 << SGTL5000_RATE_MODE_SHIFT;
> > > +             break;
> > > +     case 2:
> > > +             clk_ctl |= SGTL5000_RATE_MODE_DIV_2 << SGTL5000_RATE_MODE_SHIFT;
> > > +             break;
> > > +     default:
> > > +             break;
> > > +     }

> > I'd expect to see this error out if it can't find an appropriate
> > divider?

> the default means sys_fs / lrclk = 1, not a error.

So what happens when sys_fs / lrclk is not 1?  If nothing else the above
code needs to be *much* clearer.
