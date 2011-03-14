From: Craig Bourne <craigbourne@gmail.com>
Subject: Re: ALSA/pulseaudio problem workaround
Date: Mon, 14 Mar 2011 14:00:22 -0400
Message-ID: <AANLkTi=MXXxkcbA2h=jkJzm4BWm7_4vEwuNoaNDGE-CN@mail.gmail.com>
References: <AANLkTinGB1-Ft0B98_Z9TnFkL+Pqd8VPVKy4bEC57c8n@mail.gmail.com>
	<4D7E2BB0.7080108@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 00287244EB
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 19:00:24 +0100 (CET)
Received: by iym7 with SMTP id 7so5468883iym.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 11:00:23 -0700 (PDT)
In-Reply-To: <4D7E2BB0.7080108@colin.guthr.ie>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

"Have you guessed the riddle yet?" the Hatter said, turning to Alice again.
"No, I give it up," Alice replied. "What's the answer?"

Thank you very much for the feedback. I appreciate it and would appreciate
further suggestions on a more functional approach to dealing with these
issues.

With respect to this advice:

On a typical desktop, audio will work fine as root, provided the root
privileges have been obtained via a graphical login as a normal user and
the "su" command. By virtue of being able to access the X11 root window,
the root user will be able to communicate with the PA daemon of the
running user just fine. It relies on the start-pulseaudio-x11 script
having been run which is the case on a typical login.

As a general rule however, you should not need to do anything as root.
Using root for purposes other than sysadmin is generally discouraged and
unnecessary.

This experience is at variance with your assertions:

*Graphical login as cbourne [an unprivileged user] from a terminal session
su as root*

[root@speedy cbourne]# audacity

(Audacity:20310): GnomeUI-WARNING **: While connecting to session manager:
None of the authentication protocols specified are supported.
**
GLib-GIO:ERROR:gdbusconnection.c:2270:initable_init: assertion failed:
(connection->initialization_error == NULL)
Aborted (core dumped)
[root@speedy cbourne]#

*Graphical login** as cbourne from a normal terminal session *

[cbourne@speedy ~]$ audacity
Cannot connect to server socket err = No such file or directory
Cannot connect to server socket
jack server is not running or cannot be started
Expression 'stream->capture.pcm' failed in
'src/hostapi/alsa/pa_linux_alsa.c', line: 3653
VST_PATH not set, defaulting to
/home/cbourne/vst:/usr/local/lib/vst:/usr/lib/vst

(Audacity:20315): GLib-GObject-WARNING **: gsignal.c:2392: instance
`0xac3e758' has no handler with id `6850'

(Audacity:20315): GLib-GObject-WARNING **: gsignal.c:2392: instance
`0xa64a490' has no handler with id `124'

(Audacity:20315): GLib-GObject-WARNING **: gsignal.c:2392: instance
`0xa932080' has no handler with id `197'

... (more warnings)

[ It should be noted that, despite the error response, audacity produce
audible output only if jack is NOT running-- else, if jack is running,
everything looks normal but there is no sound ]

*Graphical login** in as root ** from a terminal session under that login
*
[root@speedy ~]# audacity
Cannot connect to server socket err = No such file or directory
Cannot connect to server socket
jack server is not running or cannot be started
Expression 'stream->capture.pcm' failed in
'src/hostapi/alsa/pa_linux_alsa.c', line: 3653
VST_PATH not set, defaulting to /root/vst:/usr/local/lib/vst:/usr/lib/vst

(Audacity:20805): GLib-GObject-WARNING **: gsignal.c:2392: instance
`0xabe5758' has no handler with id `6880'

(Audacity:20805): GLib-GObject-WARNING **: gsignal.c:2392: instance
`0xa666490' has no handler with id `124'

(Audacity:20805): GLib-GObject-WARNING **: gsignal.c:2392: instance
`0xa9cc080' has no handler with id `197'

... (more warnings)

[ Here sound is produced by audacity 1) without jack running, 2)  with jack
running using the startup/shutdown scripts 3) with jack running but without
the scripts.  Though I have no metrics to share with you to support this, it
is my repeated observation that procedures 1) and 3) produce far more noise
than does procedure 2) in this testing scenario. ]

I would of course prefer to adhere to current best practice as I attempt to
address these issues rather than flailing about with deprecated and
inappropriate methods. The means of doing this is less clear to me than you
may suppose, and not for want of exploring the material posted on-line
where, e.g.,, the ALSA web site offers what I presume to be current
information along with articles that are, in whole or in part, clearly out
of date. But what is out of date is not always clearly so.

As of Fedora 12 I was able (with some considerable struggle) to get all of
the jack/ALSA and all the applications that use them functioning properly.
With the change to Fedora 14 the struggle started again-- but I was able to
get most of the applications that I had come to rely on working again. With
the latest set of changes in fedora 14 (including many changes in ALSA)
nothing works.

And so 'Tis indeed  brillig, and Craig Bourne at 14/03/11 13:57 continues
gyre and gimble


-- 
Comradely,

Craig Bourne


On Mon, Mar 14, 2011 at 10:52 AM, Colin Guthrie <gmane@colin.guthr.ie>wrote:

> 'Twas brillig, and Craig Bourne at 13/03/11 21:05 did gyre and gimble:
> > Here is a workaround for the problem I described in my email to you
> > yesterday:
> >
> > Background My past experience with ALSA, JACK and many of the Linux audio
> > tools that depend on them is that often some few applications in the
> > tool-chain of a complex task will not work properly (or at all) unless
> > invoked with *root* privileges. One is now frustrated in getting such
> things
> > to work Fedora 14 as they have for the past decade or so in that the most
> > basic tools (e.g., alsactl, QjackCtl) no longer work for root. Indeed,
> audio
> > also does not work for unprivileged users on Fedora 14 either (though
> this
> > evidently fails at a different level and will be taken up in a subsequent
> > communication).
>
> On a typical desktop, audio will work fine as root, provided the root
> privileges have been obtained via a graphical login as a normal user and
> the "su" command. By virtue of being able to access the X11 root window,
> the root user will be able to communicate with the PA daemon of the
> running user just fine. It relies on the start-pulseaudio-x11 script
> having been run which is the case on a typical login.
>
> As a general rule however, you should not need to do anything as root.
> Using root for purposes other than sysadmin is generally discouraged and
> unnecessary.
>
> > Symptoms alsactl fails carping about pulseaudio, audacity can be started
> on
> > its own but no longer wants to cooperate with JACK and ALSA resulting in
> > horribly distorted sound from something horked together in the background
> as
> > a "favor" to the user, QjackCtl runs, produces messages, and blinks its
> cute
> > little meter display but evidently does this off on the sidelines
> reporting
> > 0 XRUNS even as every little jot and tiddle of computation produces a
> > surprising audio result.
> >
> > Strategy Based on my observation that PULSEAUDIO is evidently being
> allowed
> > to interpose itself between the user (even the superuser) and ALSA, and
> > since this user has been kept largely ignorant of the workings of all
> this
> > and does not know the secret handshake, I will attempt to at least
> minimize
> > the damage to audio and regain some measure of control while not
> attempting
> > to disable the PULSEAUDIO/ALSA cabal.
>
> It's really not that complicated. You're making this out to be a big
> deal, but really all you need to do is google a little and/or ask the PA
> community via the mailing list or IRC. You make it sound like we're
> trying to kidnap you in the middle of the night or something. Please
> don't resort to unnecessary hyperbole.
>
> > Workaround
> >
> > Install the following if they are not already on your system:
> >
> >    - avahi
> >    - padevchooser
> >    - pulseaudio-libs-zeroconf
> >    - pulseaudio-module-zeroconf
> >
> > Enable and start the Avahi Daemon
> >
> > Create these two shell scripts (that will be used by QjackCtl), make them
> > executable, and place them in a directory where they will stay to be
> invoked
> > each time QjackCtl is started:
> >
> >
> > PAjack_startup
> >
> > #!/bin/bash
> > # Name:  PAjack_startup
> >
> > pulseaudio -D --system
> > #perhaps more fastidious than the above line is
> > #pulseaudio -D --system --disallow-exit --disallow-module-loading
> > padevchooser&
>
> System wide mode is very much discouraged in a typical setup. Per-user
> operation is the typical setup installed OOTB on most/all linux distros.
>
> Also please note that padevchooser has been obsolete for some years and
> we do not recommend it's use.
>
> > PAjack_shutdown
>
> ...snip...
>
> This typically won't work. Most PA setups are per-user and with
> auto-spawn enabled. You would have to address this situation to cover
> the bases.
>
>
> > This is not a general solution to the ALSA/PULSEAUDIO problems I am
> > experiencing but it is a workaround that at least allows me to have some
> > minimal functionality back from basic audio tools that I have come to
> rely
> > on in my work as a composer.
>
> For the last couple years there has been an agreed protocol for graceful
> handover of the audio device between PA and JACK. This is a DBUS
> protocol and if JACK asks for the audio device, PA happily relinquishes
> control of the device.
>
> This support has been built into jack for a while when build with dbus
> support.
>
> Again, all of this information is public and not hard to find.
>
> I'd advice you simply ask first, before spending hours banging your head
> of a brick wall trying to find hacky solutions.
>
> I'd be happy to discuss this with you and offer you advice, but I'm not
> a JACK expert and do not use it personally. There are other people from
> the PA community who are more involved with JACK stuff however, so I
> would suggest using the pulseaudio-discuss list to make contact and get
> advice.
>
> Col
>
>
>
> --
>
> Colin Guthrie
> gmane(at)colin.guthr.ie
> http://colin.guthr.ie/
>
> Day Job:
>  Tribalogic Limited [http://www.tribalogic.net/]
> Open Source:
>  Mageia Contributor [http://www.mageia.org/]
>  PulseAudio Hacker [http://www.pulseaudio.org/]
>  Trac Hacker [http://trac.edgewall.org/]
>
