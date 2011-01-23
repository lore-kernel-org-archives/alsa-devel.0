From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: UCM questions
Date: Sun, 23 Jan 2011 00:41:29 +0000
Message-ID: <20110123004129.GB22878@opensource.wolfsonmicro.com>
References: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
	<20110121113744.GA18682@sirena.org.uk>
	<AANLkTinxwo_GErQroF4S-_z3G0UyT2sD4nBVbXVJz122@mail.gmail.com>
	<20110121164329.GB6200@opensource.wolfsonmicro.com>
	<AANLkTim_Q=oTfHS33R2hf6B3gC1Dj2fpiCAjfa7kJFw7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C13B210384E
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2011 01:41:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTim_Q=oTfHS33R2hf6B3gC1Dj2fpiCAjfa7kJFw7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 21, 2011 at 02:53:30PM -0600, pl bossart wrote:

In addition to what Liam said...

> Next, if everyone can add #defines and craft new strings to represent
> verbs, this central application/module will either ask for use cases
> that are not supported everywhere, or limit itself to 'common' use
> cases. Or do we expect to rewrite this on each and every platform?

Given the amount of OS integration involved and the way people do these
things I'd imagine that the actual decision making module is probably
going to be very OS specific - there's so much other infrastructure to
hook into and so much variation in what that looks like that we will
need to cope with random use cases being defined by the system.  Making
the values strings was largely a recognition of that, it means that
people don't need to patch UCM if they want to go and do their own
thing.  This all makes it easier to adopt UCM and deploy new use cases.

> Wouldn't it make sense to avoid branches and proliferation by limiting
> the definition of use cases and instead only allow for changes in
> configuration files?

I'm not 100% sure I'm parsing this correctly but if you're suggesting
explicitly enumerating all use cases in the code I suspect you'd just
see system integrators patching locally or abusing predefined use cases
they don't currently need rather than working upstream to integrate
their use cases.  Distros and so on who need to work over a wide range
of devices are more likely to be affected, I think the most effective
thing for them is going to be to keep the standard repository of use
case definitions actively maintained so that there's something for
effort to coalesce around.
