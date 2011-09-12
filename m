From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: ASoC audio fabric OF bindings RFC. was: Re: ASoC
 MPC5xxx PSC AC97 audio driver
Date: Mon, 12 Sep 2011 13:48:50 -0600
Message-ID: <20110912194850.GC23345@ponder.secretlab.ca>
References: <20110908184441.GD16989@siel.b> <20110909082844.3dbf0e72@archvile>
	<20110909120216.263eeb54@archvile>
	<20110909163714.GA4302@sirena.org.uk>
	<20110912083158.29d9e1fe@archvile>
	<20110912110950.GD2953@opensource.wolfsonmicro.com>
	<20110912145507.4ac0d56f@archvile>
	<20110912131924.GB5887@opensource.wolfsonmicro.com>
	<20110912155905.35cda85b@archvile>
	<20110912145214.GC5887@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F6012435C
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 21:48:56 +0200 (CEST)
Received: by yxk8 with SMTP id 8so486545yxk.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2011 12:48:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110912145214.GC5887@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, David Jander <david.jander@protonic.nl>, devicetree-discuss@lists.ozlabs.org, torbenh <torbenh@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 12, 2011 at 03:52:14PM +0100, Mark Brown wrote:
> On Mon, Sep 12, 2011 at 03:59:05PM +0200, David Jander wrote:
> > Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > > Note the "dynamic" bit - the configuration changes at runtime.
> > > Describing the hardware for something like a modern smartphone isn't
> > > particularly useful due to the flexibility, there are too many different
> > > ways of configuring the system and we need code to acutally take those
> > > decision.
> 
> > Ok, but you could still describe the hardwired part of it (Audio muxes,
> > codecs, busses and physical interfaces). Isn't that what OF is all about?
> > In our case, its just a simple AC97 codec connected to a simple AC97 bus.
> > Sounds like total overkill having to write a "fabric driver" for this....
> > while there are already quite a few that are all 99% the same!
> 
> I'm not sure I understand what you are talking about.  As I've already
> said at least once having a *machine* driver which covers multiple
> machines is absolutely OK.  We already have several such drivers in
> kernel.

Yes, a machine driver is quite a sane way to manage the huge range of
variability of a machine's audio complex.  If it turns out that an SoC
only ever has one machine driver that handles all possible
configurations, it still isn't really more complex.  If, however, the
permutations are sufficiently different to warrant separate driver
then the groundwork is already established to support it sanely.

BTW, this isn't a question about "what OF is all about".  It makes
perfect sense in the OF context to have a node describing how multiple
devices are aggregated into a single logically composite device.

Do a machine driver.  It's the right thing to do.

g.
