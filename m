From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] Add initial support of Mitac
	mioa701	device SoC.
Date: Fri, 9 Jan 2009 01:02:34 +0000
Message-ID: <20090109010233.GB29867@sirena.org.uk>
References: <1231440146-6669-1-git-send-email-robert.jarzmik@free.fr>
	<1231440146-6669-2-git-send-email-robert.jarzmik@free.fr>
	<20090108203324.GB29183@sirena.org.uk> <87iqopbj7r.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 52FE51037EB
	for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2009 02:02:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87iqopbj7r.fsf@free.fr>
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

On Thu, Jan 08, 2009 at 10:07:04PM +0100, Robert Jarzmik wrote:
> Mark Brown <broonie@sirena.org.uk> writes:

> > It'd probably be easier to split this up still further, with one patch
> > providing a standard ASoC machine and another adding the scenario stuff
> > after that.

> Wish for 2 patches instead of that one, one for core support and one for
> scenarii ? As this patch has already been reviewed and include into your tree,
> I had hopped I shouldn't inject any more work that what had already be done ...

Exactly the same sort of scrutiny is being applied to the v2 core as it
moves into mainline - it's being broken up into smaller patches and
merged gradually too, often in not quite the same form as it went into
the out of tree branch.

Also note that there's a two stage thing I'm saying here: as well as
"should we do scenarios at all?" there's also the question of how it's
implemented.  This is a generic problem and most of your implementation
looks like it's not so far away from something that could be used by
other boards too so it deserves to be hoisted out into something that
those other systems can use, rather than having people reinvent the
wheel or cut'n'paste.

Right now my feeling is that we probably want to do at least some
scenario stuff in kernel space and that what's sensible for a given
machine will depend on both the capabilities of the machine (having both
GSM and WiFi causes the number of use cases to get much larger, for
example) and if there's hardware restrictions that need to be enforced
(like not being able to use both speaker and headphones at the same
time, which is fairly common but easily enforced without scenarios as
such).

> I'd like to recall what happened to one of the mioa701 users here, when scenarii
> were handled in userspace. The wm9713 chip overheated, and destroyed the battery
> underneath. That was the reason to put that stuff into the kernel :
> protection. This was also already discussed when this was _previously_
> submitted.

If the system is overheating that's something that it's worth
preventing in kernel space.  Do you know what they did to make that
happen - is it a case of enabling more outputs than can comfortably be
driven, for example?

> And I know Liam's API, I tried it. Let me tell you my point of view : the
> mioa701 users have a standard API (alsa) to control the sound of the mioa701. I
> could force them to migrate towards Liam's library. But I can't have a guarantee
> of maintainance over that library. I don't even know if it will be the final
> solution.

The idea is not to replace ALSA for regular applications but rather to
provide an adjunct to it which a central management process can use to
do setup depending on the current system state.  There is no desire at
all to replace ALSA, only to configure it.

At the minute the majority of deployments seem to use alsactl and state
files managed by a central daemon to do this job - though obviously
a dedicated scenario API could just be dropped into that daemon.

> >> +#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)

> > This is also defined somewhere or other in the PXA or ARM architecture

> There was a discussion to include it in kernel.h. ATM, it is defined in

Yeah, I know - it was pretty strongly NACKed so I'd be shocked if it
ever went in.

> arch/arm/mach-pxa/generic.h, which is not easily reachable, hence the
> definition.

#include <mach/generic.h>? (not tested at all)

> Moreover, if you look at that file, you'll see the definition is the same, and I
> think it is perfectly correct.

Given the strong NACKs, though...  I do believe it's OK but it'd be
better to just include the PXA file (the driver is board-specific after
all).

> >> +		memset(mname, 0, 44);
> >> +		strncpy(mname, mixes[pos].mixname, 43);

> > It's bikesheding but strcpy plus termination would do the job, wouldn't
> > it?

> I don't get that ...

The memset() is mostly redundant and the above should be equivalent to
strncpy() plus an assignment to make sure the string is terminated.

> >> +                       kctl->get(kctl, &ucontrol);
> >> +                       ucontrol.value.enumerated.item[0] = mixes[pos].val;
> >> +                       kctl->put(kctl, &ucontrol);
> >> +               }

> > Does an open application (eg, alsamixer) notice these changes without
> > the driver telling it?  snd_ctl_notify() is the API call, IIRC though
> > there's a reasonable chance I am misremembering.  Though if you do mask
> > them from user space it shoudn't matter anyway, I expect.

> It does. At least when I change the mode, all the muxers the drivers touches
> change state. I don't know how, but it works ...

So the UI of interactive applications update immediately?  In that case
it's fine.

<nitpick>mixers and muxes</nitpick>

> >> +static int phone_stream_start(struct snd_soc_codec *codec)
> >> +{
> >> +       snd_soc_dapm_stream_event(codec, "AC97 HiFi",
> >> +                                 SND_SOC_DAPM_STREAM_START);
> >> +       return 0;
> >> +}

> > Hrm.  What are these needed for?  I'd have expected that DAPM would
> > power active bypass paths up without this (I test that case frequently)
> > and this isn't coordinated with what the core is doing at all.

> Without this, in asoc-v2, the dapm is not powering any of the elements in the
> phone audio path without this. Will check in asoc-v1, but I see no reason this

Is the phone using the I2S interface for digital audio out from the GSM
chipset by any chance?  Some comments at the head of the driver
describing the wiring might be useful.

> has changed. I don't quite understand what you mean by "active bypass path" so I
> will make the test myself.

A bypass path is a path through the codec which doesn't use any DACs and
ADCs but is analogue only.
