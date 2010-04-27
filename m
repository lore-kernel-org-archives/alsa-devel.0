From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Tue, 27 Apr 2010 11:41:40 +0100
Message-ID: <20100427104139.GA17091@rakim.wolfsonmicro.main>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 593CD1037F2
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 12:41:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1272362955.24542.24.camel@pasglop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 27, 2010 at 08:09:15PM +1000, Benjamin Herrenschmidt wrote:

> I think the main deal is to decide who gets to be the "master" node
> which contains the various properties doing the linkage. My gut feeling
> is that it could be the main transport, ie, the i2s or ac97, but people
> with more experience dealing with that stuff might have other ideas.

You're not going to find a single master transport node on more complex
systems - some systems have multiple audio interfaces to the CPU (to
allow use of hardware mixing, for example), and in systems with things
like offboard DSPs or basebands it's not always clear that the CPU Linux
is running on is in charge of anything.

> Keep in mind that it's perfectly kosher to create nodes for "virtual"
> devices. IE. We could imagine a node for the "sound subsystem" that
> doesn't actually correspond to any physical device but contain the
> necessary properties that binds everything together. You could even have
> multiple of these if you have separate set of sound HW that aren't
> directly dependant.

In terms of where to shove any data this is sort of the solution I
favour, it's pretty much exactly what's implemented on other platforms
at the moment and it seems to adequately represent the physical board
(it's not a million miles away from what Timur has here).

The main problem is that trying to define a language which can represent
the needs of modern mobile audio subsystems just doesn't seem worth the
effort.  The clocking arrangements for modern mobile audio subsystems
aren't trivial, are normally highly device and system specific, and when
you add on more exotic things like sharing the bit and frame clocks
between multiple audio interfaces it gets even more involved.
