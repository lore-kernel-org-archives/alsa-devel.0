From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [RFC 1/13] Intel SST drivers documentation
Date: Tue, 7 Jul 2009 16:04:48 +0100
Message-ID: <20090707150448.GE14393@rakim.wolfsonmicro.main>
References: <1246604310-12812-1-git-send-email-vinod.koul@intel.com>
	<20090704120954.GA13988@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5BBC2386@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 13BAA2448F
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 17:04:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE5BBC2386@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 07, 2009 at 12:27:42PM +0530, Harsha, Priya wrote:
> >-----Original Message-----
> >From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]

> >refer to?  The reason I ask is that a lot of what's going on here sounds
> >much like the typical embedded hardware supported by the ASoC framework
> >in the kernel in which case I worry that these drivers may run into many
> >of the issues which ASoC solves.

> I shall mail in more details on how the hardware is structured soon.
> Since we posted the patches early in the game for comments, I would need
> to get the right hardware specific information that I can email here.

OK, thanks.

> Vendor is basically one who is providing the sound cards for the
> platform. Each sound card is different and needs to handled differently.
> That's why we have 3 different hardware vendor abstraction files to
> handle them.

Hrm.  I suspect when you say "sound card" you're talking about the
configuration of the external chips and wiring on the system that work
with the Moorestown to provide audio functionality?

> Can you guide on some points/issues that I need to proactively look at
> in my driver that is solved by ASoC?

First a bit of backstory to explain the sort of system ASoC is designed
for:

In general the audio subsystems in embedded devices are constructed from
many different components wired together in a board specific fashion.
Of these the two chips that require most control and that I'll focus on
here are the audio CODEC (which sits at the edge of the digital parts of
the system, containing DACs, ADCs and often also some analogue mixers
and amplifiers) and the part of the CPU which is responsible for DMAing
the data out of memory and transmitting it to the CODEC.

Since these are usually split into separate ICs with standards for the
connections between them people making systems have a great deal of
flexibility about which parts they'll use and how they'll be connected
up.  While many designs will be based on reference designs users with
specific needs will often wish to tweak things, using different parts or
connecting them differently.  One fairly clear example of people doing
this in the kernel is the omap3pandora system - the audio for that is
very much like the standard OMAP3 reference designs using the TWL4030
except they have added in an additional high performance DAC for output.

Prior to ASoC what would normally happen for embedded systems was that
integrated audio drivers which handled all the chips on a particular
system (or sometimes class of system) would be produced.  This lead to a
lot of duplication when, for example, one audio CODEC was used on a lot
of different systems.  It also tended to result in problems merging code
into the standard kernel if people needed small modifications to
existing drivers to support their platforms since often these would
result in lots of ifdefs or custom code.  It's these sorts of problems
that I'm concerned will occur.

There's ASoC documentation in the kernel under Documentation/sound/alsa/soc
including overview.txt which goes into a bit more detail on the specific
problems and how they are solved.

> Is the thought around adding new asound like API for encoded streams?
> So that the driver IOCTLs are called within the APIs? An internal effort
> is being taken in this lines to create a new lib file that exposes
> general APIs for handling encoded streams rather than application using
> IOCTLs directly. Please give your suggestions/ideas around this.

What I'm saying here is more that we should develop a generic interface
for controlling this functionality from user space that isn't specific
to this driver.  Your approach looked like a reasonable starting point
but at the minute the interface presented to applications is entirely
specific to your driver.

> >For simplicity it may be best to arrange the patch series so that you've
> >got a driver without the offloaded decode support and then build the
> >offloaded decode support on top of that.  This should make it easier to
> >review the more standard ALSA functionality and may help get that code
> >in more quickly.

> Thanks for the tip. The way the PCM streams and encoded streams are
> handled in DSP driver (Intel SST driver) are mostly the same. I am
> wondering how I could peal out the encoded interfaces alone. The
> intel_sst_interface.c file has the encoded interfaces exposed as well as

You don't need to submit one patch per file - you could send one patch
which adds the file then a further patch which changes that file.
