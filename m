From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] Add initial support of Mitac mioa701
	device SoC.
Date: Fri, 9 Jan 2009 16:28:00 +0000
Message-ID: <20090109162759.GD25751@sirena.org.uk>
References: <1231440146-6669-1-git-send-email-robert.jarzmik@free.fr>
	<1231440146-6669-2-git-send-email-robert.jarzmik@free.fr>
	<20090108203324.GB29183@sirena.org.uk> <87iqopbj7r.fsf@free.fr>
	<20090109010233.GB29867@sirena.org.uk> <87priwsl8l.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A9BAE103805
	for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2009 17:28:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87priwsl8l.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 09, 2009 at 01:43:38PM +0100, Robert Jarzmik wrote:

> Would it be accepted a generic API in sound/soc/soc-scenario.c, which more or
> less the same construction as with mio_mixes_t, get_scenario and set_scenario,
> and a possible callback before and after scenario changes ?

> I could propose an API if it is agreed that the API will be eventually accepted,
> after technical discussion in this ML.

Yes, I think that's a good approach.  Perhaps if you sketch out the
interface before delving into the actual implementation?

> > If the system is overheating that's something that it's worth
> > preventing in kernel space.  Do you know what they did to make that
> > happen - is it a case of enabling more outputs than can comfortably be
> > driven, for example?

> IIRC, the guy was playing music on the amplified speaker which is connected to
> HPL and OUT3 on the wm9713. He tried to increase the volume, but instead of
> touching HPL+OUT3, he changed SPKL+SPKR.

So the two speakers can't safely be run simultaneously, then?

Actually, looking at your driver are there any pins that are not
connected and never touched by the scenario stuff?  By default pins will
be enabled unless otherwise stated.

> And then, if we had to go that way, why not provide a generic pxa2xx-ac97 +
> wm9713 codec couple, without board code, drop board code, and let the sound
> daemon handle the problems. Personnaly, with my experience on smartphones, I

That's a perfectly sensible approach if there are classes of system
which are generic enough to make the code reuse meanigful - if they just
slightly different sets of pins marked as not connected, for example.
There are some examples already, such as the spitz machine which handles
three different platforms with two options for a GPIO.  At a certain
point there will be enough special cases or something fiddly enough to
make it worth splitting off to make multiple machine drivers.

For really straightfoward systems then the standard ALSA AC97 driver may
be all people need.

> feel very reluctant to it. I think sound on a phone is a critical enough issue
> to be handled in kernel space.

The sound also has to agree with things like the GSM chipset and what
the user is trying to do.

> >> >> +#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)

> You're right, it was NACKed. I don't remember the "strongly", would you please
> provide me your source. From what I read, there was bickering about the naming, and

Google isn't turning up anything particularly strong so I guess I'm
misremembering.

> >> arch/arm/mach-pxa/generic.h, which is not easily reachable, hence the
> >> definition.

> > #include <mach/generic.h>? (not tested at all)

> Wouldn't that point to arch/arm/mach-pxa/include/mach instead of
> arch/arm/mach-pxa ?

Yes, it would - misread what you wrote there.

> > <nitpick>mixers and muxes</nitpick>

> Mixers is more "frogish", isn't it ? :)

You had "muxers".

> The comment are all in mixes_gsm_call_headset. You have the full path. I can
> move them in the header if you wish, or try some ascii art of the wm9713
> connection on the mioa701 board.

What you've got is fine, it's just that that wouldn't cover non-DAPM
things like a connection to the voice PCM (that should appear in the
DAIs).

> Ah, exactly my case. I wonder why dapm can't "guess" that path ... The pins are
> activated, the audio pathes are known ... Can I take some debug info that could
> help to understand the problem ?

#define DEBUG at the top of soc-dapm.c - it'll be *very* verbose about
the power decisions it's making.
