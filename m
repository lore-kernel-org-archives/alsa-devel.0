From: "Sean McNamara" <smcnam@gmail.com>
Subject: Re: alsa-lib has anyone ever looked at taking it cross
	platform?
Date: Fri, 25 Jul 2008 21:43:14 -0700
Message-ID: <74eb1fe20807252143v671f71cj278eeee331f4b677@mail.gmail.com>
References: <e7d8f83e0807251956x302275c7kad90f73c07f70288@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by alsa0.perex.cz (Postfix) with ESMTP id 8120B1037F4
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jul 2008 06:43:15 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so743196and.80
	for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2008 21:43:14 -0700 (PDT)
In-Reply-To: <e7d8f83e0807251956x302275c7kad90f73c07f70288@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Peter,

Two assumptions you make are problematic:

1. You assume that one FOSS project can "kill" another. This is false.
For a project to continue existing, the only thing it needs is people
working on the code to maintain it so that it works in the
ever-changing environment around it (the compiler, the kernel, core
libraries, etc.)

To a lesser extent projects also need users to stay alive; but a
project like ALSA or PulseAudio has very little say in whether a
distribution wants to adopt them. Distributions have the choice of
what software they want to use; software projects do not get to tell
distributors what software to use.

Unlike the proprietary software market, Free Software projects are
unaffected by users making choices about their software. ALSA does not
make any money by people using or not using it. There is no concept of
"sales" or "losses".

2. You assume that by creating synergy and prominence of a single
piece of software, that no one will try to write a competing piece of
software. This is false. You absolutely cannot stop people from
releasing alternative choices that have merits which draw users to
them. There is no such thing as "de-fragmenting" the FOSS space. You
can't make it simpler; you can only make it more complex. The number
of FOSS projects of any given category grows infinitely with time,
regardless of how good existing solutions are. This is true at every
level of the software stack, but some categories have more
alternatives than others.

Sound traditionally happens to have a large amount of
actively-maintained, moderately-popular alternatives to the point of
being annoying, but there is no remedy that will make the others
irrelevant. As long as there is some moderately-popular application
being shipped with distributions that uses XYZ sound API / sound
server, XYZ will have a user base. This leads to the unfortunate fact
that, as far as I know, there does not currently exist _any_
arrangement of nested sound servers and APIs that will:

1. Work for _every_ existing sound-using application (i.e. nobody
crashes, few or no drop-outs, no assertions or incompatibilities or
limitations, etc.)
2. Permit concurrent access to the soundcard by multiple applications
at the same time
3. Allow all the features of every API to work at the same time

Satisfying all three of the conditions is in theory possible, and it
is the only *true* way to provide a desktop user experience for audio
on Linux that rivals the "100% of the time, it just works" situation
on Windows and Mac.

The solution is not to be anti-social and try to defeat or snuff out
other FOSS projects. API unification/uniformity is not even a
theoretical possibility, much less an actual one. The solution is to
make your solution _interoperable_. In this arena I would say that
currently PulseAudio is by its very nature more interoperable than
ALSA. But even with its built-in ESD protocol compatibility, its
ability to use JACK as a backend, padsp for OSS compat, and the pulse
plugin for ALSA, there are still a lot of applications that rely on
edge cases of the aforementioned APIs... this leads to these
interoperability layers being frequently incompatible with XYZ
untested application.

My main recommendation in this discussion is to stop looking for a
monolithic, single-API sound solution on Linux; you won't find one.
The main reason is because people are going to use whatever sound API
they damn well choose in their spiffy new application. Instead, I
recommend that you submit patches, as I have, to improve the
interoperability of one API to the next. If we had the proper amount
of interest and careful attention to interoperability components
(ALSA<->pulse plugin, padsp, and so on) then desktop users would have
to ask themselves this quite-different question when determining what
"primary" sound server to adopt:

"How many different sound APIs can I support at once using solution
XYZ? [Because supporting just one will only let me use, at most, 50%
of the applications out there.]"

-Sean

On Fri, Jul 25, 2008 at 7:56 PM, Peter Dolding <oiaohm@gmail.com> wrote:
>> Peter Dolding wrote:
>>> Pulseaudio and all other Sound Servers since its a extra service adds
>>> a extra point of complete sound failure to the Linux sound stack or
>>> what ever stack they happen to be operating on top of.   It more of a
>>> hack around the limitations of the alsa framework.  ALSA was really
>>> designed to avoid the need of such extras.  The existence of
>>> Pulseaudio is really sign of failure.  Reason Sound Servers existed at
>>> first due to the failures of OSS to provide a multi application sound
>>> support.  ALSA was really designed to do away for the need of sound
>>> servers completely.  Now alsa is failing to provide per application
>>> sound control and a sound server is back for another pass.
>>
>> I really don't see why the existence of sound servers is a failure of
>> ALSA. ALSA does it's job very well by providing the necessary hardware
>> drivers and an interface to them. The kind of things needed by a modern
>> desktop sound system, however, goes way beyond the 1:1 hardware interface.
>>
>> At the most basic level, sound servers can be reduced to just software
>> mixers. The name "sound server" has a very bad reputation that (these
>> days) is not deserved. To say that pulseaudio's existence is a failure
>> of ALSA is doing ALSA a massive disservice. Sure, the software mixing
>> can be done by Alsa's DMIX but DMIX is just a "sound server" anyway, so
>> what specifically makes DMIX better or worse than PA in this regard?
>> Because DMIX is started automatically? Because it's in kernel space?
>> None of these arguments hold up when you get involved at the level of a
>> distribution who packages things together correctly.
>>
>> Pulseaudio is just a name and the kind of things it does are very much
>> different to the core goals of ALSA (with the exception of the obvious
>> overlap between DMIX and PA). The two fit very well together IMO.
>
> Same line OSS used just with a few words changed  Pulseaudio with ESD
> and ALSA with OSS.  You are repeating history and don't even know it.
>>
>> If it makes you feel any better, just call pulseaudio "ALSA Desktop
>> Services". Like I say it's only a name!
>>
> Its a failure renaming failure does not change it.   Over time you get
> more and more competing sound servers.   How long before people of PA
> look at ALSA and go why in hell are we using that nasty thing and just
> go straight around alsa-lib and straight to alsa drivers so we don't
> have the performance bottle neck.   This is exactly what PA is trying
> to do now you will talk straight to us so you must run PA.  One
> everything is talking to PA they can go direct to hardware.   No
> matter if it causes trouble or not.
>
> DMIX is userspace and was alway designed that ALSA could be expanded
> to take on any task.
>
> The difference is 1 sound server.  Total 1.  No more does  OS need.
> ALSA was designed to be Linux's Sound Server and all the other low
> level sound parts.  As soon as you have more you have trouble.  PA is
> a second sound server that just provides a second point for sound
> failure.  Basically PA should not exist.   If alsa was interesting in
> being just hardware only DMIX did not have to be created we could have
> just linked to ESD and other sound servers of the time.
>
> DMIX is a clear sign that ALSA is ment to be far more.   PA is a
> intruder everything PA is ALSA should be as well.
>
> PA is taking the wrong method to fixing the the MIX problem DMIX
> should have been upgraded.
>>
>>> Now if you want to keep on thinking along that line has ALSA got to
>>> the point it should be dumped like OSS has been dumped because of its
>>> limitations?
>>
>> Of course ALSA should not be dumped! ALSA does it's job very well, and
>> PA does it's very well too. I really don't see how you got to that
>> statement from what I said. PA doesn't try and reimplement ALSA, it just
>> implements the higher level audio stack.
>>
>>> alsa-lib to freebsd or somewhere with oss most likely could be done
>>> really quickly since we already have a oss output option.
>>>
>>> Its also like saying the Linux Standard Base is only used by Linux.
>>> Its not its also used by a few non Linux's.   Driver section of ALSA
>>> most likely will always be Linux only.   But the wrapper layer that
>>> hides the hardware from the software really does not have to stay
>>> Linux only.  Alsa is going up to be part of the Linux Standard Base
>>> its about time we all start looking at how it can be made most useful.
>>>  Provide all the features it should and work for stability.
>>
>> I've not programmed much with alsa lib but I do know it's not all that
>> simple. That's there are several other layers on top that exist. There
>> API is complex and powerful but it also open to a lot of abuse. There
>> are many ALSA client apps out there that are poorly written. That's
>> simply because the API is complex and it is easy to make mistakes that
>> do not surface with one setup but do on another. Making apps work nicely
>> with DMIX was a pain and as soon as you remove the hardware aspect of
>> the underlying system (e.g. to replace it with a plugin like bluez or
>> PA) lots of interesting issues come to the fore.
>>
> So it is like xlib.  A wrapper lib that has got too complex for its
> own good. xlib also caused strange failures when connected to
> different brand X11 servers.  xcb was all about simplifying a very
> complex process.
>
> Sound servers are also a way of avoiding have to fix these issues.
> Just like toolkits on X11 have been.
>
> If PA or ESD or any of the other sound servers can provide a simple
> usable API so should ALSA.  Difference in operational complexity is
> 100 percent a error in ALSA.
>
> Of course more complex options can remain.  Existence of sound servers
> is pointing to failures.
>
> I have not got onto the nasty bit of 3d sound not being simple inside
> alsa.   Creative wanted to go straight past ALSA with openal.
> Somehow I think they should have been let destroy alsa completely if
> people here are not prepared to pull head out sand.
>
> Tidy direct hardware interface api is needed.   ALSA-LIB need to be
> feature rich.  It need to go cross platform so developers of PA, liboa
> and others get pulled in here.  Or this will just rot and rot until
> the day comes that ALSA-LIB will have to be dumped because its no
> longer anything more than a processing black hole.
>
> One option if PA is so many time better.   Is to complete save a lot
> of time and completely do way with ALSA-LIB and say to the PA guys
> here write a new direct interface to the drivers.   Because that is
> what will happen in time if this project does not step up.  The
> question is how many years.
>
> It is really a simple selection kill/let ALSA-LIB slowly die off or
> step up be a architecture and take PA and other sound servers on head
> on.  If alsa-lib is not going to step up we might as well save the
> resources and focus them better.
>
> Really we do want all the sound server/driver/basic wrapper developers
> here.   So there are more developer to deal with ALSA glitches.
>
> I think some people here have got way way too friendly with the
> completion.  PA is not a save ALSA camp it is a long term kill bits of
> ALSA camp.
>
> Question is how far do they go before alsa starts protecting itself.
>
> Going cross platform is part of the protection.   No reason to keep
> the sound system of linux segmented any more.   ALSA was always ment
> to kill of the segmentation.  Its currently failing nicely at that
> task.
>
>
> Peter Dolding
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
