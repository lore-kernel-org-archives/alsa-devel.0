From: "Peter Dolding" <oiaohm@gmail.com>
Subject: Re: alsa-lib has anyone ever looked at taking it cross
	platform?
Date: Sat, 26 Jul 2008 12:56:38 +1000
Message-ID: <e7d8f83e0807251956x302275c7kad90f73c07f70288@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 8206C2462E
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jul 2008 04:56:39 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so2713724rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2008 19:56:38 -0700 (PDT)
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
To: gmane@colin.guthr.ie
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Peter Dolding wrote:
>> Pulseaudio and all other Sound Servers since its a extra service adds
>> a extra point of complete sound failure to the Linux sound stack or
>> what ever stack they happen to be operating on top of.   It more of a
>> hack around the limitations of the alsa framework.  ALSA was really
>> designed to avoid the need of such extras.  The existence of
>> Pulseaudio is really sign of failure.  Reason Sound Servers existed at
>> first due to the failures of OSS to provide a multi application sound
>> support.  ALSA was really designed to do away for the need of sound
>> servers completely.  Now alsa is failing to provide per application
>> sound control and a sound server is back for another pass.
>
> I really don't see why the existence of sound servers is a failure of
> ALSA. ALSA does it's job very well by providing the necessary hardware
> drivers and an interface to them. The kind of things needed by a modern
> desktop sound system, however, goes way beyond the 1:1 hardware interface.
>
> At the most basic level, sound servers can be reduced to just software
> mixers. The name "sound server" has a very bad reputation that (these
> days) is not deserved. To say that pulseaudio's existence is a failure
> of ALSA is doing ALSA a massive disservice. Sure, the software mixing
> can be done by Alsa's DMIX but DMIX is just a "sound server" anyway, so
> what specifically makes DMIX better or worse than PA in this regard?
> Because DMIX is started automatically? Because it's in kernel space?
> None of these arguments hold up when you get involved at the level of a
> distribution who packages things together correctly.
>
> Pulseaudio is just a name and the kind of things it does are very much
> different to the core goals of ALSA (with the exception of the obvious
> overlap between DMIX and PA). The two fit very well together IMO.

Same line OSS used just with a few words changed  Pulseaudio with ESD
and ALSA with OSS.  You are repeating history and don't even know it.
>
> If it makes you feel any better, just call pulseaudio "ALSA Desktop
> Services". Like I say it's only a name!
>
Its a failure renaming failure does not change it.   Over time you get
more and more competing sound servers.   How long before people of PA
look at ALSA and go why in hell are we using that nasty thing and just
go straight around alsa-lib and straight to alsa drivers so we don't
have the performance bottle neck.   This is exactly what PA is trying
to do now you will talk straight to us so you must run PA.  One
everything is talking to PA they can go direct to hardware.   No
matter if it causes trouble or not.

DMIX is userspace and was alway designed that ALSA could be expanded
to take on any task.

The difference is 1 sound server.  Total 1.  No more does  OS need.
ALSA was designed to be Linux's Sound Server and all the other low
level sound parts.  As soon as you have more you have trouble.  PA is
a second sound server that just provides a second point for sound
failure.  Basically PA should not exist.   If alsa was interesting in
being just hardware only DMIX did not have to be created we could have
just linked to ESD and other sound servers of the time.

DMIX is a clear sign that ALSA is ment to be far more.   PA is a
intruder everything PA is ALSA should be as well.

PA is taking the wrong method to fixing the the MIX problem DMIX
should have been upgraded.
>
>> Now if you want to keep on thinking along that line has ALSA got to
>> the point it should be dumped like OSS has been dumped because of its
>> limitations?
>
> Of course ALSA should not be dumped! ALSA does it's job very well, and
> PA does it's very well too. I really don't see how you got to that
> statement from what I said. PA doesn't try and reimplement ALSA, it just
> implements the higher level audio stack.
>
>> alsa-lib to freebsd or somewhere with oss most likely could be done
>> really quickly since we already have a oss output option.
>>
>> Its also like saying the Linux Standard Base is only used by Linux.
>> Its not its also used by a few non Linux's.   Driver section of ALSA
>> most likely will always be Linux only.   But the wrapper layer that
>> hides the hardware from the software really does not have to stay
>> Linux only.  Alsa is going up to be part of the Linux Standard Base
>> its about time we all start looking at how it can be made most useful.
>>  Provide all the features it should and work for stability.
>
> I've not programmed much with alsa lib but I do know it's not all that
> simple. That's there are several other layers on top that exist. There
> API is complex and powerful but it also open to a lot of abuse. There
> are many ALSA client apps out there that are poorly written. That's
> simply because the API is complex and it is easy to make mistakes that
> do not surface with one setup but do on another. Making apps work nicely
> with DMIX was a pain and as soon as you remove the hardware aspect of
> the underlying system (e.g. to replace it with a plugin like bluez or
> PA) lots of interesting issues come to the fore.
>
So it is like xlib.  A wrapper lib that has got too complex for its
own good. xlib also caused strange failures when connected to
different brand X11 servers.  xcb was all about simplifying a very
complex process.

Sound servers are also a way of avoiding have to fix these issues.
Just like toolkits on X11 have been.

If PA or ESD or any of the other sound servers can provide a simple
usable API so should ALSA.  Difference in operational complexity is
100 percent a error in ALSA.

Of course more complex options can remain.  Existence of sound servers
is pointing to failures.

I have not got onto the nasty bit of 3d sound not being simple inside
alsa.   Creative wanted to go straight past ALSA with openal.
Somehow I think they should have been let destroy alsa completely if
people here are not prepared to pull head out sand.

Tidy direct hardware interface api is needed.   ALSA-LIB need to be
feature rich.  It need to go cross platform so developers of PA, liboa
and others get pulled in here.  Or this will just rot and rot until
the day comes that ALSA-LIB will have to be dumped because its no
longer anything more than a processing black hole.

One option if PA is so many time better.   Is to complete save a lot
of time and completely do way with ALSA-LIB and say to the PA guys
here write a new direct interface to the drivers.   Because that is
what will happen in time if this project does not step up.  The
question is how many years.

It is really a simple selection kill/let ALSA-LIB slowly die off or
step up be a architecture and take PA and other sound servers on head
on.  If alsa-lib is not going to step up we might as well save the
resources and focus them better.

Really we do want all the sound server/driver/basic wrapper developers
here.   So there are more developer to deal with ALSA glitches.

I think some people here have got way way too friendly with the
completion.  PA is not a save ALSA camp it is a long term kill bits of
ALSA camp.

Question is how far do they go before alsa starts protecting itself.

Going cross platform is part of the protection.   No reason to keep
the sound system of linux segmented any more.   ALSA was always ment
to kill of the segmentation.  Its currently failing nicely at that
task.


Peter Dolding
