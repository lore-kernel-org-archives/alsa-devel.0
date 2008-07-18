From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] PalmTX aSoC sound support
Date: Fri, 18 Jul 2008 15:49:20 +0100
Message-ID: <20080718144920.GB25829@flint.arm.linux.org.uk>
References: <200807042126.29154.marek.vasut@gmail.com>
	<20080714150757.GE25448@sirena.org.uk>
	<s5hd4le13j2.wl%tiwai@suse.de>
	<200807162210.09908.marek.vasut@gmail.com>
	<s5habgg3jwo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 3957F244E1
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 16:49:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5habgg3jwo.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 17, 2008 at 12:05:43PM +0200, Takashi Iwai wrote:
> At Wed, 16 Jul 2008 22:10:09 +0200,
> Marek Vasut wrote:
> > 
> > Dne Wednesday 16 of July 2008 13:17:53 Takashi Iwai napsal(a):
> > > At Mon, 14 Jul 2008 16:07:58 +0100,
> > >
> > > Mark Brown wrote:
> > > > On Mon, Jul 07, 2008 at 05:58:32PM +0200, Takashi Iwai wrote:
> > > > > Doesn't matter much to me, so just let me know to merge via which
> > > > > tree.
> > > >
> > > > Either way it needs another spin of the driver so...
> > >
> > > OK, it's fine to push it to ALSA tree.  But I think it's a bit too
> > > late for 2.6.27...
> > wasnt merge window for .27 opened just a while ago ?
> 
> It doesn't mean to allow us to push any unreviewed/untested patches.
> Trivial or fix patches can go immediately, but a new driver code is a 
> different story.  In general, the new driver codes should be merged to
> the subsystem tree in a few weeks before the merge window.

We can't moan about it not having been exposed though - it first appeared
on July 4th here, and July 5th on alsa-devel.

It has been reviewed by Mark Brown, and you yourself even said "so just
let me know to merge via which tree." which sounds to me like you were
ready to merge it - but just wanted to know _which_ route it was going
to take.

So, to now come back and whinge about it being unreviewed and/or untested
and about patches being submitted before the merge window is a little
silly, don't you think?

Anyway, my present position with my tree is that I'm not merging anything
further into my tree until the remainder of the code queued up previously
has been merged, which will only happen when the SPI tree is eventually
merged (or I get fed up with waiting for that to happen and choose
build time breakage over the correct merge ordering.)

The reason for this is simple - if I push a new tree out, the nice diff
versions for non-git users of my tree will vanish, despite there being
changes still in there, and I don't want a flood of "where's my changes
gone?  they aren't in Linus' tree and they aren't in the diffs."
questions.
