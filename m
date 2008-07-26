From: "Peter Dolding" <oiaohm@gmail.com>
Subject: Re: Alsa-devel Digest, Vol 17, Issue 128
Date: Sat, 26 Jul 2008 22:48:14 +1000
Message-ID: <e7d8f83e0807260548j4892fb2cga6149a6d3c8e4f13@mail.gmail.com>
References: <mailman.1.1217066401.19372.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 056B824350
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jul 2008 14:48:15 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so2773221rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 26 Jul 2008 05:48:14 -0700 (PDT)
In-Reply-To: <mailman.1.1217066401.19372.alsa-devel@alsa-project.org>
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

> Peter,
>
> Two assumptions you make are problematic:
>
> 1. You assume that one FOSS project can "kill" another. This is false.
> For a project to continue existing, the only thing it needs is people
> working on the code to maintain it so that it works in the
> ever-changing environment around it (the compiler, the kernel, core
> libraries, etc.)
>
To be correct a FOSS project can kill another buy taking its
developers.   Its way simpler than you could think.

If ALSA has all the features of PulseAudio including its interfacing
API's why will you add PulseAudio.  This is exactly how PulseAudio is
killing off ESD.   So in time not a single person is going to use ESD
other than threw PulseAudio.

Now PulseAudio killing Alsa is a lot harder and equally possible.   So
its a shark in the water.

> 2. You assume that by creating synergy and prominence of a single
> piece of software, that no one will try to write a competing piece of
> software. This is false. You absolutely cannot stop people from
> releasing alternative choices that have merits which draw users to
> them. There is no such thing as "de-fragmenting" the FOSS space. You
> can't make it simpler; you can only make it more complex. The number
> of FOSS projects of any given category grows infinitely with time,
> regardless of how good existing solutions are. This is true at every
> level of the software stack, but some categories have more
> alternatives than others.
>
> Sound traditionally happens to have a large amount of
> actively-maintained, moderately-popular alternatives to the point of
> being annoying, but there is no remedy that will make the others
> irrelevant. As long as there is some moderately-popular application
> being shipped with distributions that uses XYZ sound API / sound
> server, XYZ will have a user base. This leads to the unfortunate fact
> that, as far as I know, there does not currently exist _any_
> arrangement of nested sound servers and APIs that will:
>
> 1. Work for _every_ existing sound-using application (i.e. nobody
> crashes, few or no drop-outs, no assertions or incompatibilities or
> limitations, etc.)
> 2. Permit concurrent access to the soundcard by multiple applications
> at the same time
> 3. Allow all the features of every API to work at the same time
>
Missed the worst avoid lag  2 sound servers like dmix and pulse
operating on top of each other equals lag.  Goal has to be to get to 1
sound server only.

Remember ALSA name clearly.  Advanced Linux Sound Architecture

This is a Architecture single API s not a Architecture.  If all the
needed features to run ESD Pulse and so on there API can be directly
wrapped down to ALSA removing the need for sound servers other than
ALSA's.   Those API's just become part of the Architecture and can be
deprecated out of existence over time.  We also get broader ideas and
more developers focused in a single place.  Its a simple case why
install pulse if its features already work.

Note Pulseaudio is defragmenting.   The more API's it supports the
more it gets threw its central path.  Less important those engines
until they are no longer maintained and dead.   Why are you going to
put something else functional than Pulse on a system.

This method of defragmentation has happened many times over.  It works.

Its a myth that FOSS projects have to keep on growing in numbers in
any give category.  If that was so we would have a extra clone to ALSA
by now.   To be correct if we don't watch it we will.

Its only a matter of time before pulse guys just want to go straight
past the alsa-lib so they get faster interfacing with hardware.
Question is how long.

Note its imposable to get nested sound server to work perfectly.   But
its more than possible to get a single sound server to do all the jobs
of all the other sound servers so giving perfect API coverage.

The issue is we have to reduce to 1 sound server.   Many wrapping
api's.  Its less than 10 API's total.   Not many sound servers
providing single api's.

Only way is for 1 sound server to have all the features of all the
other sound servers.   Perfectively with direct calls to hardware.

Alsa fits the direct calls to hardware bit.   Features and wrappers a
little behind.  First project to 100 percent coverage wins.

Having a single sound server also reduces travel to hardware down.
You don't have to go sound server to sound server to get to hardware.

Only way forward is to end the peace.   Every project targeting to be
last 1 standing.  Even doing merges with each other to be last 1
standing.

Peter Dolding
