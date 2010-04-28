From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Wed, 28 Apr 2010 14:00:37 +0100
Message-ID: <20100428130037.GF31400@opensource.wolfsonmicro.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<4BD74D0C.40303@freescale.com>
	<20100427205924.GC15083@opensource.wolfsonmicro.com>
	<1272428729.24542.70.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 400EC10382B
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Apr 2010 15:00:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1272428729.24542.70.camel@pasglop>
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
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 28, 2010 at 02:25:29PM +1000, Benjamin Herrenschmidt wrote:

> I'd stay stick to the basics and move incrementally up until it stops
> making sense:

>  - First, the basics: nodes for actual physical devices. i2c codecs on
> their i2c busses, DMA controllers, etc...

This is already supported by the ASoC core and has been for about a year
or so, it just needs the device drivers to make use of it.  IIRC the
drivers relevant to PowerPC are pretty much doing so already, but I
didn't actually check.

>  - From there, see what simple properties are better off being put in
> those respective nodes because they represent common enough variants of
> functionality or simply because they are specific attributes of a given
> device that aren't too concerned by the way things are interconnected.

This one is just a case of writing boiler plate for the existing
platform data devices have to convert that from device tree into the
existing formats.  It's not a monumentally edifying task, but I don't
think we really need to worry about it here.

>  - Provide at least one identifier (either in a "sound" virtual device,
> or just use the board's own "compatible" property) to have a .c file to
> put everything together.

This has been the big sticking point so far.  It has been difficult to
get people to accept this idea at all, the idea that there may be more
to the machine specific setup than can be readily expressed in static
data and might even vary dynamically at runtime is what seems to upset
people.  I've been told on a number of occasions that instantiating 
machine specific code that's not part of a specific chip is very
difficult and would cause the device tree to be horribly buggy.

What you're suggesting here is exactly what is supposed to happen from
an ASoC point of view.

> The whole thing is a matter of common sense and a bit of taste :-)

The impression that has been created in the past is that there are
inflexible device tree rules which can't be varied.
