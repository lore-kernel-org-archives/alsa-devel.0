From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Thu, 29 Apr 2010 10:42:56 +1000
Message-ID: <1272501776.24542.131.camel@pasglop>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<4BD74D0C.40303@freescale.com>
	<20100427205924.GC15083@opensource.wolfsonmicro.com>
	<1272428729.24542.70.camel@pasglop>
	<20100428130037.GF31400@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D749103844
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Apr 2010 02:43:01 +0200 (CEST)
In-Reply-To: <20100428130037.GF31400@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-04-28 at 14:00 +0100, Mark Brown wrote:
> > The whole thing is a matter of common sense and a bit of taste :-)
> 
> The impression that has been created in the past is that there are
> inflexible device tree rules which can't be varied.

I'm a bit sad this is how things have been perceived since that's
clearly not the policy I've applied to the powerpc architecture.

Or rather, there are -some- inflexible rules yes, which are to:

 - Have a device-tree :-)

 - Have a /compatible property at the toplevel to identify your board

 - Have the /cpus nodes for representing the CPUs.

That's pretty much the only absolute requirements from a code
perspective.

Now I -do- require people to also have nodes for things like PCI host
bridge, since that allows using a ton of existing code for handling most
aspects of PCI, and I -do- complain if people just hard wire platform
devices everywhere or interrupt numbers without even trying to consider
using the device-tree appropriately.

However, I've always been against the one-bsp-fits-all approach, and
it's always been my clear policy that there should be a per-machine .c
file. I did bend when folks pushed the "simple" platform but with the
understanding that it must contain an -explicit- list of boards it
supports.

You'll also notice that all of my virtual interrupt handling stuff is
such that you -can- use it without device-tree nodes, the DT just makes
it easier. Same goes with PCI devices (only the PHB requires a DT node
at this stage) etc... 

Cheers,
Ben.
