From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC audio fabric OF bindings RFC. was: Re: ASoC
 MPC5xxx PSC AC97 audio driver
Date: Mon, 12 Sep 2011 15:52:14 +0100
Message-ID: <20110912145214.GC5887@opensource.wolfsonmicro.com>
References: <20110908163231.4b721973@archvile> <20110908184441.GD16989@siel.b>
	<20110909082844.3dbf0e72@archvile>
	<20110909120216.263eeb54@archvile>
	<20110909163714.GA4302@sirena.org.uk>
	<20110912083158.29d9e1fe@archvile>
	<20110912110950.GD2953@opensource.wolfsonmicro.com>
	<20110912145507.4ac0d56f@archvile>
	<20110912131924.GB5887@opensource.wolfsonmicro.com>
	<20110912155905.35cda85b@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 60DAD244A2
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 16:52:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110912155905.35cda85b@archvile>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Jander <david.jander@protonic.nl>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, lrg@ti.com, devicetree-discuss@lists.ozlabs.org, torbenh <torbenh@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 12, 2011 at 03:59:05PM +0200, David Jander wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Note the "dynamic" bit - the configuration changes at runtime.
> > Describing the hardware for something like a modern smartphone isn't
> > particularly useful due to the flexibility, there are too many different
> > ways of configuring the system and we need code to acutally take those
> > decision.

> Ok, but you could still describe the hardwired part of it (Audio muxes,
> codecs, busses and physical interfaces). Isn't that what OF is all about?
> In our case, its just a simple AC97 codec connected to a simple AC97 bus.
> Sounds like total overkill having to write a "fabric driver" for this....
> while there are already quite a few that are all 99% the same!

I'm not sure I understand what you are talking about.  As I've already
said at least once having a *machine* driver which covers multiple
machines is absolutely OK.  We already have several such drivers in
kernel.

*Please* look at the existing code and read what I'm saying, and ideally
also read the prior discussions on this topic.  Please also try to avoid
inventing your own techncial terms.  It's enormously repetitive and not
terribly useful to have to go through all this stuff from square one
every single time someone looks at this stuff.

> > > > The plan is to push the device trees out of the kernel into a separate
> > > > repository.

> > > Good idea.... but where should such a repository be hosted?

> > Still an open issue.

> Seems like its hard to find a vendor- and OS-neutral entity to host this?
> OpenBIOS maybe?

More a problem of deciding which of the many available options to
choose.
