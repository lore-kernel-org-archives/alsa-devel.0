From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: wm9712: Microphone doesn't work,
	"Capture Volume"	inverted
Date: Tue, 1 May 2012 23:25:31 +0100
Message-ID: <20120501222528.GA32443@opensource.wolfsonmicro.com>
References: <20120426112726.GF3207@opensource.wolfsonmicro.com>
	<1335448142.20000.40.camel@mars>
	<20120426172010.GP3207@opensource.wolfsonmicro.com>
	<1335474693.3628.26.camel@lovely>
	<20120426213745.GA18260@opensource.wolfsonmicro.com>
	<20120430192258.GA15188@local>
	<20120430214332.GA4414@opensource.wolfsonmicro.com>
	<20120430234458.GB15188@local>
	<20120501171207.GC4089@opensource.wolfsonmicro.com>
	<20120501200755.GF15188@local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D19D104386
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2012 00:25:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120501200755.GF15188@local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Hans J. Koch" <hjk@hansjkoch.de>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 01, 2012 at 10:07:57PM +0200, Hans J. Koch wrote:
> On Tue, May 01, 2012 at 06:12:07PM +0100, Mark Brown wrote:

> > The driver knows exactly which registers are volatile

> Then this is the first complex chip I've ever seen where the datasheet covers

That's...  horrifying, really.  The WM9712 really isn't at all complex
by modern standards for that matter, but the idea that it's common to
have devices with documented registers that might spontaneously change
in normal operation doesn't seem at all clever.  What happens if the
configuration that was set was important?

> all corner cases. And what about things like dirty supply voltages or EMI?

If you've got that sort of problem with supply quality or EMI there's
obviously a very serious system issue to contend with, one that
typically requires highly aggressive action to resolve - you're starting
to get into games like having to constantly poll the device and restart
it if you detect that it fell over which isn't pleasant and most likely
means you've already hit serious user visible consequences.  Things like
device initialisation will need to be redone, for example.  I can only
think of one driver that takes such measures, and it's actually relying
on restore from register cache for part of the recovery :)

That said, many devices will get a moderate degree of robustness against
this through power saving - the closer the device can get to cold during
idle the better from this point of view, and in many cases it's possible
to completely power down the device when idle.  A common idiom is to
take the device down to cold when idle then dump the setup changes that
don't need sequencing into the device from cache before doing the bits
that need sequencing, especially where many of the register settings can
be mapped direictly into userspace.

Indeed I'm not sure a cache isn't a bad plan for detecting this sort of
thing; if you find the cache values diverging from the physical values
for non-volatile registers you know something's up.

> Just to save a few clock cycles every now and then you happily accept the
> risk of the driver simply stop working after an unusual event, without
> any chances of recovery.

For the sort of devices we're talking about here it's way more than a
few clock cycles that are involved, you're talking about fairly slow
and at times congested buses like I2C here.  Never mind what happens
when someone decides to use a bigbanged controller, which is more common
than one might dream of.  Obviously if you're on a bus with trivial I/O
costs the tradeoffs vary but for the sort of buses we're talking about
it's much easier to see a win.

Indeed with many older devices readback just isn't physically supported
in the first place so if you want to do any kind of readback based thing
you're going to have to cache in some way.  This was true for the
majority of devices at the time WM9712 was new.

> Sound is not my usual playing ground, but at least I learned now why the
> sound system on my desktop refuses to work after a few days uptime...

I don't actually think desktop drivers bother with this much, though 
ICBW.  They relatively infrequently use the slow buses.  I'd suggest
reporting the issue, anyway - it's probably more constructive.

> Fortunately, most other subsystems would never accept such code for mainline.

This is actually a standard feature of the regmap API that drivers can
use if they want, there's a bunch of device classes where it can offer a
useful win (those that typically have slow control interfaces and not so
mnay volatile registers).
