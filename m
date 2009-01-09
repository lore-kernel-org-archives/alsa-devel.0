From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 1/2] Add initial support of Mitac mioa701
	device SoC.
Date: Fri, 09 Jan 2009 13:43:38 +0100
Message-ID: <87priwsl8l.fsf@free.fr>
References: <1231440146-6669-1-git-send-email-robert.jarzmik@free.fr>
	<1231440146-6669-2-git-send-email-robert.jarzmik@free.fr>
	<20090108203324.GB29183@sirena.org.uk> <87iqopbj7r.fsf@free.fr>
	<20090109010233.GB29867@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C8C3103855
	for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2009 13:43:45 +0100 (CET)
In-Reply-To: <20090109010233.GB29867@sirena.org.uk> (Mark Brown's message of
	"Fri\, 9 Jan 2009 01\:02\:34 +0000")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@sirena.org.uk> writes:

> On Thu, Jan 08, 2009 at 10:07:04PM +0100, Robert Jarzmik wrote:
>> Mark Brown <broonie@sirena.org.uk> writes:
>
>> Wish for 2 patches instead of that one, one for core support and one for
>> scenarii ? As this patch has already been reviewed and include into your tree,
>> I had hopped I shouldn't inject any more work that what had already be done ...
>
> Exactly the same sort of scrutiny is being applied to the v2 core as it
> moves into mainline - it's being broken up into smaller patches and
> merged gradually too, often in not quite the same form as it went into
> the out of tree branch.
So be it.

> Also note that there's a two stage thing I'm saying here: as well as
> "should we do scenarios at all?" there's also the question of how it's
> implemented.  This is a generic problem and most of your implementation
> looks like it's not so far away from something that could be used by
> other boards too so it deserves to be hoisted out into something that
> those other systems can use, rather than having people reinvent the
> wheel or cut'n'paste.
>
> Right now my feeling is that we probably want to do at least some
> scenario stuff in kernel space and that what's sensible for a given
> machine will depend on both the capabilities of the machine (having both
> GSM and WiFi causes the number of use cases to get much larger, for
> example) and if there's hardware restrictions that need to be enforced
> (like not being able to use both speaker and headphones at the same
> time, which is fairly common but easily enforced without scenarios as
> such).
Would it be accepted a generic API in sound/soc/soc-scenario.c, which more or
less the same construction as with mio_mixes_t, get_scenario and set_scenario,
and a possible callback before and after scenario changes ?

I could propose an API if it is agreed that the API will be eventually accepted,
after technical discussion in this ML.

>
> If the system is overheating that's something that it's worth
> preventing in kernel space.  Do you know what they did to make that
> happen - is it a case of enabling more outputs than can comfortably be
> driven, for example?
IIRC, the guy was playing music on the amplified speaker which is connected to
HPL and OUT3 on the wm9713. He tried to increase the volume, but instead of
touching HPL+OUT3, he changed SPKL+SPKR.
>
> The idea is not to replace ALSA for regular applications but rather to
> provide an adjunct to it which a central management process can use to
> do setup depending on the current system state.  There is no desire at
> all to replace ALSA, only to configure it.
>
> At the minute the majority of deployments seem to use alsactl and state
> files managed by a central daemon to do this job - though obviously
> a dedicated scenario API could just be dropped into that daemon.
Agreed. That wouldn't provide overheat protection of course.

And then, if we had to go that way, why not provide a generic pxa2xx-ac97 +
wm9713 codec couple, without board code, drop board code, and let the sound
daemon handle the problems. Personnaly, with my experience on smartphones, I
feel very reluctant to it. I think sound on a phone is a critical enough issue
to be handled in kernel space.

>> >> +#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
>
> Yeah, I know - it was pretty strongly NACKed so I'd be shocked if it
> ever went in.
You're right, it was NACKed. I don't remember the "strongly", would you please
provide me your source. From what I read, there was bickering about the naming, and
the fact that the macro was generating 2 arguments which could be confusing
(which is neither specified in Documentation/CodingStyle nor wrong, as a macro
is _not_ a function, and does not need to represent a lvalue, but that's another
debate we could talk about another time ...)
>
>> arch/arm/mach-pxa/generic.h, which is not easily reachable, hence the
>> definition.
>
> #include <mach/generic.h>? (not tested at all)
Wouldn't that point to arch/arm/mach-pxa/include/mach instead of
arch/arm/mach-pxa ?

>> Moreover, if you look at that file, you'll see the definition is the same, and I
>> think it is perfectly correct.
>
> Given the strong NACKs, though...  I do believe it's OK but it'd be
> better to just include the PXA file (the driver is board-specific after
> all).
So do I, if there was a simple way.

>
>> >> +		memset(mname, 0, 44);
>> >> +		strncpy(mname, mixes[pos].mixname, 43);
>
>> > It's bikesheding but strcpy plus termination would do the job, wouldn't
>> > it?
>
>> I don't get that ...
>
> The memset() is mostly redundant and the above should be equivalent to
> strncpy() plus an assignment to make sure the string is terminated.
Ah, you mean a strlcpy(). OK, will do.

> <nitpick>mixers and muxes</nitpick>
Mixers is more "frogish", isn't it ? :)
>
> Is the phone using the I2S interface for digital audio out from the GSM
> chipset by any chance?  Some comments at the head of the driver
> describing the wiring might be useful.
No, AC97 drivers the wm9713. The analog phone signal comes from GSM chip in
(MonoIn, PCBeep) and are driver to (HPL, HPR) on headset for example. There is
no digital signal, only analog routing.

The comment are all in mixes_gsm_call_headset. You have the full path. I can
move them in the header if you wish, or try some ascii art of the wm9713
connection on the mioa701 board.
>
>> has changed. I don't quite understand what you mean by "active bypass path" so I
>> will make the test myself.
>
> A bypass path is a path through the codec which doesn't use any DACs and
> ADCs but is analogue only.
Ah, exactly my case. I wonder why dapm can't "guess" that path ... The pins are
activated, the audio pathes are known ... Can I take some debug info that could
help to understand the problem ?

Cheers

--
Robert
