From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Thu, 15 Sep 2011 23:38:22 +0100
Message-ID: <20110915223821.GA3218@opensource.wolfsonmicro.com>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
	<1315936777-27994-2-git-send-email-timur@freescale.com>
	<20110915102430.GD7988@opensource.wolfsonmicro.com>
	<4E7214ED.9050703@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A713F24564
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 00:38:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E7214ED.9050703@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2011 at 10:08:29AM -0500, Timur Tabi wrote:
> Mark Brown wrote:

> > This changelog doesn't correspond to reality.  The set_sysclk() function
> > in the driver makes no effort to constrain the sample rates based on
> > sysclk, as is normal for CODEC drivers as the system clock is frequently
> > configured based on the current sample rate (at the minute the
> > configured clock is used to set up the clock dividers within the CODEC
> > based on sample rate). 

> My understanding of the .set_sysclk() function is that one of its primary
> purpose is to tell the codec what master frequency to use for its sample rate
> clock divider.  Although that doesn't technically happen in the .set_sysclk
> function itself, that function is typically required.  Without that function,
> codecs must hard-code their mclk frequency, which therefore also locks the list
> of supported sample rates.

You're missing the point here.  Your changelog says:

| ASoC codec drivers can use the .set_sysclk function to dynamically specify
| the list of support sample rates, because that list is often based on
| the input clock frequency.  Although the WM8776 includes a .set_sysclk

This isn't what happens at all.  The constraints set in the DAIs
generally just list all the sample rates the device can possibly
support, there's no dynamic information injected into the subsystem
about what's supported.  This is because in many systems the various
clock rates are dynamically controlled and so the clocks are adjusted to
reflect the sample rates the application layer wants.  As a result we
never actually bother specifying the supported rates for the current
clock at all, we just try to make the best of what we're given when it
comes to configuring which is a rather different thing.

There are actually a few drivers that do try to specify the rates they
support based on the sysclk but these are generally more difficult to
use due to the system integration issues that result when the sysclk is
varied.

| function, it was also hard-coding the supported sample rates to a list
| that depends on a specific input clock frequency.

This isn't the case; for example the current sample rate list includes
both 44.1kHz and 48kHz (and other 8kHz based rates) which can't be
generated from the same system clock.

> 3. The codec driver later uses that frequency to determine which sample rates
> are actually supported.

This is the bit that doesn't actually happen - what the drivers actually
do is take a stab at using the clocks they have to configure themselves
when they need to do so.  Any errors that are generated are a byproduct
and they happen very late on in the process and depending on the idiom
we may end up making a best effort rather than actually doing what we're
being asked to do rather than rejecting invalid configurations.

> How is this problematic?  On the P1022DS, I can dynamically switch between two
> mclk frequencies on the codec just by touching a gpio.

It's not a problem to do this, the problem is purely with the changelog.
All you're actually doing is increasing the range of supported rates in
the driver, the discussion of both the current code and the interaction
with set_sysclk() is based on a misunderstanding of how this works.

> > What's actually going on here is that the driver is being cautious about
> > supporting non-audio clock rates (mostly because the digital performance
> > is mainly specified for audio rates) and 192kHz was omitted from the DAC
> > rates.  The change itself is OK but please resubmit with a more accurate
> > changelog.

> The only change that I understand that you want is to clarify that the sample
> rate calculation doesn't happen directly in set_sysclk().  Is there anything
> else you're expecting?

Hopefully the above makes things clearer - all you're doing here is
expanding the range of supported sample rates, the diagnosis of the
problem is substantially off base.  Given that the changelogs are the
main documentation I'd rather not see stuff like this going in there.
