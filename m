From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Tue, 27 Apr 2010 20:09:15 +1000
Message-ID: <1272362955.24542.24.camel@pasglop>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa0.perex.cz (Postfix) with ESMTP id EADAC248AF
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 12:09:22 +0200 (CEST)
In-Reply-To: <20100427095440.GA15492@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-04-27 at 10:54 +0100, Mark Brown wrote:
> I'd just like to add that I *really* want to see you guys come to some
> sort of firm and documented conclusion about the way to handle
> situations like this.  Some variant of this seems to come up every
> single time anyone tries to do anything to do with audio on a system
> using the device tree and it's getting really repetitive.  What would be
> really useful for audio at this point would be if we could get some sort
> of decision about how to represent this stuff which we can point people
> at so that work on systems using the device tree can be done without
> having to deal with the device tree layout discussions that frequently
> seem to be involved. 

Agreed. Just seeing how Apple fucked it up so many times, it's not a
simple problem :-)

The device-tree allows to express all of these relationship but we
should be able to come up with a reasonably "standard" way to do so to
avoid every SoC or platform doing it it's "own" way.

I think the main deal is to decide who gets to be the "master" node
which contains the various properties doing the linkage. My gut feeling
is that it could be the main transport, ie, the i2s or ac97, but people
with more experience dealing with that stuff might have other ideas.

Keep in mind that it's perfectly kosher to create nodes for "virtual"
devices. IE. We could imagine a node for the "sound subsystem" that
doesn't actually correspond to any physical device but contain the
necessary properties that binds everything together. You could even have
multiple of these if you have separate set of sound HW that aren't
directly dependant.

I don't have bandwidth to contribute much in this discussion right now,
at least not to lead it, so I'm happy to let others do so, but I'm happy
to provide feedback from my own experience as proposals are made.

Cheers,
Ben.
