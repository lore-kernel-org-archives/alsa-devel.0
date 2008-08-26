From: "Sean McNamara" <smcnam@gmail.com>
Subject: Re: The state of Linux audio
Date: Mon, 25 Aug 2008 17:10:55 -0700
Message-ID: <74eb1fe20808251710l318ff30ch8afd436013ca47ff@mail.gmail.com>
References: <f188924b0808240837nfb54b9aq6330d9994df291ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by alsa0.perex.cz (Postfix) with ESMTP id C612E245B7
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 02:10:56 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m28so972515wag.8
	for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2008 17:10:55 -0700 (PDT)
In-Reply-To: <f188924b0808240837nfb54b9aq6330d9994df291ba@mail.gmail.com>
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
To: "Fred ." <eldmannen@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This sounds like a homework question to me ;-)

 That said, there are no "right" answers to these questions which
encapsulate every opinion about this topic. A comprehensive answer
would take many pages -- one could write a book on the different
viewpoints. But here's my personal viewpoint (comments inline).

On Sun, Aug 24, 2008 at 8:37 AM, Fred . <eldmannen@gmail.com> wrote:
> What is the state of audio in Linux?
> How does it compare against other operating systems?
I'm going to answer these two questions at the same time.
Depends on how you define "audio" and "Linux".
(a) If you define audio = "the ability to send/capture PCM data
to/from a sound card and have it playback/capture at low latency", and
Linux = "the Linux kernel", I'd argue that ALSA is the most
featureful, stable, and comprehensive implementation of more audio
drivers than any other platform. Not only does ALSA support virtually
every consumer audio device on the market; it also supports many
high-end pro audio solutions, as well as sound chips for embedded
systems. I'd say that Windows supports the same core consumer audio
devices out of the box, it probably supports all pro audio devices
with third-party drivers, and supports few to no embedded SoC chips.
So in sheer number of chipsets supported out of the box, I think ALSA
takes the cake. In addition, fragmentation at the kernel level is
fairly low; the OSS/Free implementation in the Linux kernel is quickly
fading into bitrot oblivion, and 4-Front Technologies' OSS 4.x is the
only real competitor to ALSA's kernel-level support. The fragmentation
in the kernel is really between two implementations, where one
implementation (ALSA) is what a vast majority of people use, if only
because distributions ship it as the default sound stack. If all
you're interested in is the kernel, I'd argue that you can envision
Linux audio as a thriving, successful, victorious project whose only
kernel-level goals going forward are to maintain the current level of
excellence they've achieved, by supporting new hardware as it comes
down the R&D pipe.

(b) If you define audio more broadly to include userspace support for
audio editing, consistent audio playback, and a worry-free user
experience where applications "just work", and you define Linux as "a
typical distribution of GNU/Linux which includes many FOSS graphical
applications and utilities", the scenario is much uglier. At the user
space level, there are tens of different APIs available which offer
mostly-overlapping feature sets; unfortunately, almost every library
claims one or more compelling features which distinguish it from the
pack.

Due to the strong emphasis on consistency in the large desktop
environment efforts, GNOME and KDE, software belonging under the
umbrella of these projects often behaves well as ALSA applications. In
KDE 4's case, we have Phonon, which eventually gets around to using
ALSA. As Colin said, these projects are quickly moving to also support
native PulseAudio.

When an independent software developer (not associated with GNOME or
KDE) writes a new application making heavy use of audio, they are
almost equally likely to choose among one of a half-dozen leading
competitors offering easy to use or featureful audio programming APIs:
FMOD, OpenAL, libao, libpulse, ALSA, JACK, and so on. While many of
these advertise support for ALSA as a back-end, such implementations
are hit-or-miss as to whether they actually work. Once you start
interposing a plugin library that translates ALSA calls into
PulseAudio calls (a necessary step towards desktop integration and API
interoperability), the chances of correct functionality diminish.
Basically, the more pass-through layers the audio has to run through
before it's sent out your speakers, you have exponentially worse
chances of it actually succeeding (and if it does succeed, the sound
quality and reliability also diminish the more indirection you have).
In this way, the standard UNIX model of employing many small
programs/libraries together in cooperation falls down with audio. It's
just very hard to ensure proper interoperability between different
audio APIs.

A consequence of this fragmentation, coupled with the fact that ALSA
has no "forced" mixing of multiple applications' sound at once, means
that the reliability of sound playback on a user's desktop can be
extraordinarily poor when they have installed more than one or two
audio-playing applications.

If your distribution does not ship any software mixing installed and
ready to use out of the box, which has been the case for every distro
until ca. 2007, then you will automatically run into problems if you
try to play sound from two applications at once. But even if your
distribution has PulseAudio or ALSA's dmix enabled by default, any of
the above mentioned libraries may decide at any time that it doesn't
want to play nicely with other applications, and hog your sound card,
shutting out any other applications indefinitely. This peculiar
limitation is fundamental to ALSA's design and cannot be fixed without
breaking backwards compatibility.

PulseAudio is solving many of these problems, including a mandate that
any applications using PulseAudio must allow their audio to be mixed
with other applications. But PulseAudio still sits on top of a fragile
and complicated ALSA userspace, which limits Pulse's ability to do its
job. Here are two issues foremost in my mind pertaining to ALSA
userland, presented at a high level:

1. Most developers, novice or experienced, are unable to correctly
write an ALSA client that cooperates nicely with ALSA plugins such as
ALSA<->Pulse. A huge percentage of existing ALSA clients are
semantically misaligned with any ALSA userspace backend except the
most basic direct hardware access (which, again, lacks any sort of
mixing). This is partly the fault of these developers, and partly the
fault of the API designers for creating something that is capable of
being misused so easily. Application writers should not be given a
choice between using a slower, more compatible code path or a faster,
less compatible code path; Murphy's Law says that most developers will
choose the less compatible path to make their application faster,
giving users no choice to fall back to the more compatible path. And
of course (Murphy's Law again) most users will need the compatibility
mode to get the application's audio output to work at all. I'm
referring to mmap'ed playback for anyone who is familiar with ALSA
internals, but this is merely one example of several.

2. The ALSA plugin interface leaves (too) many things open to the
interpretation of the plugin writer. This is mostly a documentation
issue: syntax of function prototypes means absolutely nothing if those
implementing the APIs do not know what state the program must be in
before and after each function call, what sort of errors must be
thrown, and so on. As a result, it is very difficult to write an ALSA
plugin and proclaim, "There; any sane ALSA client will now be able to
interface seamlessly with my sound server/library through my ALSA
plugin." This is exacerbated by the client-side problems in the
previous point -- there are even fewer sane ALSA clients than there
are sane ALSA plugins :P


>
> Is the Linux audio functionality good or bad?

This question is SO subjective that I think I'll let you infer this
from the rest of my post, rather than trying to address it directly.

> What could be better?

As I said, unification on a core set of components is the most
important step going forward. This has to be a conscious effort made
between audio stack developers (PulseAudio and ALSA's maintainers) and
application authors. On the one hand, the audio stack needs to end its
decade-long streak of uniform mediocrity, and allow for a champion to
arise -- one implementation that gains mass support and recognition.
This should not be done through force or FUD; it should be done
through sheer software quality and excellence. I for one am nominating
PulseAudio for that place, assisted in no small part by ALSA.
Eventually, there might arise two competing solutions at the top, both
of which gain mass acceptance - but this is no worse than the current
GTK/QT split. They consciously interoperate with one another anyway,
which is a hallmark of their excellence.

Basically, I think we are experiencing somewhat of a repeat of the
early X11 days: way back then, it wasn't such an unreasonable thing
for people to hack their own basic window management, widget toolkit,
etc. for their applications. A vast majority agreed upon the fact that
the X server was a viable foundation, but no one agreed upon where to
go from there. Some people (the GTK, CDE, Motif and Qt authors) wanted
to create a framework that others could build upon, discouraging
application writers to directly use X11 calls; other people wanted to
go their own way and directly access X11 through their own
abstractions, or use one of the numerous other abstractions which were
sitting around in mediocrity.

But then a tipping point came, and a vast majority of developers saw
the real value of unifying on a common widget toolkit. After that, we
basically had Motif, GTK, and Qt (in no particular order) arise as
better-than-mediocre champions, and by 2000 it was more or less a
strange thing when an application writer wanted to directly use libX11
for all their drawing operations.

I see the PulseAudio camp saying the same thing to ALSA as the GTK
camp was saying to XFree86 (and now X.Org) a couple of years ago:
(Audio) I hope ALSA will continue to thrive at the kernel level, but
eventually either reinvent itself or disappear out of developers'
minds at the user-space level.
(Graphics) I hope X11 will continue to thrive on the server-side, but
eventually either reinvent itself or disappear out of developers'
minds on the client-side.

> What is planned for the future?

So from my not-so-unbias perspective, I'd say that Linux audio is at
the base of the final peak that we must climb to get Linux audio ready
for prime time. Most of the climb will involve application developers
recognizing the one or two most successful audio projects, and
adopting these instead of continuing the fragmentation. The more we
can get applications to use the best APIs, the better the user
experience will be.

Of course, there will always be multiple champions at the top; this is
necessary in the FOSS world. But when 95% of the applications use only
two or three different well-supported paths, the success rate of audio
interoperability (software mixing, effects, etc.) will be much higher
than it currently is.

HTH,

Sean


> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
