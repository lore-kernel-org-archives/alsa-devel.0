From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Memory corruption in ASoC
Date: Thu, 18 Mar 2010 17:07:45 +0000
Message-ID: <20100318170745.GC6142@rakim.wolfsonmicro.main>
References: <20100318161755.GJ30801@buzzloop.caiaq.de>
	<20100318164305.GB6142@rakim.wolfsonmicro.main>
	<20100318164853.GK30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 22A6F2436F
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 18:07:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100318164853.GK30801@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 18, 2010 at 05:48:53PM +0100, Daniel Mack wrote:
> On Thu, Mar 18, 2010 at 04:43:06PM +0000, Mark Brown wrote:

> > It should really be per-substream, yes.

> Do you want me to fix this or are you working on this already?

I'm all in favour of approaches that involve me doing less work :)
Though watch out for a mail from Liam shortly...

> I know there are some pxa-ssp related things pending which will also
> cause merge conflicts - which tree should thing apply to currently?

ASoC.  I guess 2.6.35 - this is going to be an invasive fix and people
can backport if they actually notice.

> > It's relatively hard to trigger problems on a lot of platform since the
> > DAI data pointer is often only really used at stream setup, meaning that
> > triggering a problem requires that a system not only does simultaneous
> > playback and capture but also has overlapping startup of the two.

> Well, how would you initialize them in a non-overlapping way? The
> example I sent does the setup fairly straight-forward, doesn't it?

You are doing non-overlapping initialisation, overlapping would be if
you were doing the two open() calls followed by two set_params() calls
rather than doing each stream in turn.

> I'd say any full-duplex system is affected.

There's a race on any system using the DAI dma_data, but your program
either won't trigger it or will trigger it in a way that's not so
obvious on quite a few systems.

You're not overlapping the startup of the two streams so your program
will run OK if the drivers only use the pointer during setup - the
program will only trigger a problem if the pointer is also used in the
teardown path.  Many systems will also be saved by the fact that they
use static data rather than dynamically allocated so they'll end up
operating on the wrong DMA stream but this probably won't have any user
noticable problems if both streams are being shut down, the DMA
controller will just be stalled waiting for the port instead of properly
stopped.
