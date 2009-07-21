From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: AC97 on pcm030 board with WM9712 codec
Date: Tue, 21 Jul 2009 10:01:04 +0100
Message-ID: <20090721090104.GA12667@rakim.wolfsonmicro.main>
References: <1248132551.6532.267.camel@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0414B2436A
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 11:01:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1248132551.6532.267.camel@riker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Bonesio <bones@secretlab.ca>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 20, 2009 at 04:29:11PM -0700, John Bonesio wrote:

> AC97 link. The AC97 driver also calls warm_reset() after the cold reset
> is complete. Earlier the warm_reset() call was added in the AC97
> cold_reset() routine to attempt to solve this bug, but it appears to not
> completely solve the issue. After the reset the wm9712 driver attempts

No, the warm reset is an unrelated change.  The warm reset is there
because the WM9712 can be strapped to not start up the AC97 link at
startup.

> 2. Perhaps the cold_reset is not necessary and the warm_reset is all
> that is needed

No, AC97 cold and warm resets do different things.  A cold reset
restores the device to power on state while a warm reset will restart
the AC97 link if it was not already running without changing any
register settings in the device.  A warm reset cannot substitute for a
cold reset.

[Buggy GPIOs]
> might contain uninitialized values on power up. Should I still consider
> this as a potential problem, or is this pretty much a non-issue?

Depends how much you trust your AC97 controller.

> would go away. So instead I increased the length of time in the udelay()
> call right before the call to warm_reset(). I've empirically found that
> delaying 1ms (udelay(50) -> udelay(1000)) seems to avoid the problem.
> I'm not sure why this delay is necessary, or if it makes sense for the
> hardware to need this much time to come out of the cold reset.

I'm not sure which delay you're talking about here (I'm guessing that
it's one of those in the PSC driver?) but this does sound entirely
plausible - if it resolves the issue could you produce a patch, please?
I'd suggest changing to use msleep() instead of udeley() since delay
will busy wait while sleep won't.

Thanks for your work on this.
