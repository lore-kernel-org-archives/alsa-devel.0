From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: <alsa-dev> RFC for OMAP4 audio driver
Date: Thu, 3 Sep 2009 10:10:12 +0100
Message-ID: <20090903091011.GA10313@rakim.wolfsonmicro.main>
References: <baee637d0909011927m5df3bd58uf7cabfc474f50274@mail.gmail.com>
	<20090902120120.GB4012@sirena.org.uk>
	<67059DBF19D7214F9C66BB0EA91BA90E80FDEDAA@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BE0B9243D3
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 11:10:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E80FDEDAA@dlee04.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, hari n <hnagalla@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 02, 2009 at 08:55:16PM -0500, Lopez Cruz, Misael wrote:

> I'm not familiar with the concept of an audio hub, but is it
> something like a codec that can have 'slave' codecs connected to
> it (like in cascade fashion)?

Not quite.  The idea is that in a system like a phone where you have
multiple sources and sinks for audio (the CPU, bluetooth, GSM, onboard
mics and speaker...) an audio hub provides a central place to route and
mix all the audio signals.  This can be purely analogue, purely digital
or a mix of both - generally for the full thing you need a mix of both.
The OMAP4 ABE is an example of this in the digital domain.

The idea is that it becomes possible to do things like run the audio
subsystem while the rest of the system is powered down (eg, during a
call) and that the CPU doesn't need to spend time on basic audio tasks.

> Do we have any audio hub CODEC already in SoC to use as a
> reference?

The OpenMoko phones are probably the most obvious example of this in
mainline - they have GSM connected to the CODEC via a line input and
bluetooth via a second DAI.

> > This is the sort of issue I'm talking about above which is 
> > helped by explicitly representing all the DAIs in the system. 
> >  With the DAIs visible it should just become a case of 
> > hooking up the links between the devices in the usual ASoC fashion.

> If the ABE is considered as a separate CODEC, then it should have
> its own DAIs for the connection with the processor, even it the
> codec itself resides in the processor. What about the client CODECs?

I beleive this will make life easier with the current design.  Looking
at the system diagrams the CPU core is relating to the ABE as though it
were an external device, and the design that was proposed with a unified
ABE/TWL6030 driver is doing pretty much that.  All I'm really saying
here is that the links between the OMAP4 and the TWL6030 should be
explicitly represented so that if a board design hooks things up
differently for some reason then the drivers can cope.

> They will also have their DAIs which should be connected to the
> physical outputs of ABE (McPDM, McBSP, ...), and that confuses me.
> AFAIK, SoC allows to have multiple CODECs attached to the same
> processor, but not a CODEC connected to the output of another CODEC.

At the minute it's a bit tricky but it's definitely something that ought
to be supported - you may remember the refactoring that was done to
unify the CODEC and CPU DAI structures, this sort of use case was one of
the motivators for that.  Where there's problems the core isn't a fixed
thing, we can change it if required.
