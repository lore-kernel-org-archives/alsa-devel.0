From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC, master clock direction
Date: Fri, 18 Jul 2008 22:23:19 +0100
Message-ID: <20080718212313.GA12419@sirena.org.uk>
References: <9e4733910807180954s47157b84m90eed202d4ab3dc2@mail.gmail.com>
	<9e4733910807181244k1ad1a2f8tecfd8d2baa463f57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 12610245AC
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 23:23:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807181244k1ad1a2f8tecfd8d2baa463f57@mail.gmail.com>
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
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 18, 2008 at 03:44:37PM -0400, Jon Smirl wrote:
> On 7/18/08, Jon Smirl <jonsmirl@gmail.com> wrote:

> >  3) Something Freescale calls cellphone slave but it is more like clock
> >  distribution.

> >  In cellslave mode one i2s port is in normal slave mode. The clock from
> >  this port is used to drive up to three other i2s ports in master mode.

...

> >  When the clock frequency changes I need to notify the i2s drivers for
> >  the dependent channels. Do we need a third choice,
> >  SND_SOC_CLOCK_SLAVE? Alternatively I can use another clock id value.

Without having looked at how this works in hardware I'd probably
implement this by using a different clock id for the slave ports if I
wanted to use set_sysclk() to configure cell slave mode.  It sounds like
you've got to choose between two sources within the SoC, one being that
clocked in from the external source and the other regular clocks.  From
what you're saying as far as the individual I2S port is concerned it is
the master in both cases.

> 	switch (dir) {
> 	case SND_SOC_CLOCK_IN:
> 		return 0;
> 	case SND_SOC_CLOCK_OUT:
> 	default:
> 		if (!(psc_i2s->sicr & MPC52xx_PSC_SICR_CELLSLAVE)) {
> 			/* implement me */
> 			/* compute and set the needed dividers for the internal clock */
> 			return -EINVAL;
> 		}
> 		psc_i2s->sysclk = freq;
> 		return -EINVAL;
> 	}
> }

If you did use a separate clock id then you could set or clear
MPC52xx_PSC_SICR_CELLSLAVE as appropriate here which might be a bit
easier to write.  It depends on what's clearer and what work is needed
to configure the slave mode - I guess there may be other configuration
required?

Having said that the important thing here is that what you do is
sensible and idiomatic for people working on the platform so it may be
that what you've got already is the most expressive thing.  The clock
configuration is done by machine drivers which will obviously be
platform specific.
