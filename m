From: Florian Bomers <Florian.Bomers@sun.com>
Subject: Re: smix plugin available?
Date: Tue, 26 Nov 2002 16:54:02 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE417AA.D0F3F467@sun.com>
References: <E18Goo5-0008Ma-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

That makes sense. I also fully agree that callback-driven APIs are better suited for
audio. On the other hand, nobody would doubt that o/c/r/w apps would not allow low enough
latency for GUI-type apps like EQs (e.g. with buffer sizes of 10-20ms the total latency
isn't so inacceptable).

But that's all getting a bit too far off of the original problem: sound on Linux is not
playing, because another app or daemon blocks the sound device. For that particular
problem, PortAudio is merely a work-around than a solution.

I think such an smix plugin would work like this (please correct if wrong):

1) standard "mainstream" users will use smix. Their software will need to use the
"plughw:" devices in ALSA; smix is enabled by default (OSS programs, ALSA programs, sound
daemons, ...).

2) more professional audio apps use "hw:" devices and fail if the smix plugin is being
used. The user needs to make sure that all software that uses the "plughw:" devices are
terminated and then start the audio app again. 

3) since smix shouldn't be activated for devices with hardware mixing, those users get the
best from both worlds. Needless to say that people who use semi-pro audio software are not
so likely to have only one non-mixing soundcard.

JACK is really in between, but maybe some users would rather use a "crippled" JACK working
on "plughw:" than having no OSS/artsd/etc. sound simultaneously.

Florian

PS: sorry for my ignorance, but I haven't said "CoreAudio" yet, I guess I should learn to
do so...


Paul Davis wrote:
> 
> >> ALSA is *a* sound library. There are lots of things that it doesn't
> >
> >I would really say: ALSA is *the* sound library (at least on Linux). Isn't it
> >in kernel
> >2.5+ ?
> 
> alsa-lib isn't in kernel 2.5, because its not part of the kernel.
> 
> alsa-lib doesn't contain any code to read or write audio files, for
> example. it contains no code to do dithering. it contains no code to
> do audio rate resampling, at least no code that is accessible by a
> regular program.
> 
> >I don't know if I get the point right here, but it reads: don't use
> >ALSA. But it's the only sound library that will be delivered with all
> >distributions in future, so what choice do mainstream application
> >writers have ? OSS ?
> 
> PortAudio would be a much better choice.
> 
> >So you discourage use of ALSA because it suggests/allows a
> >non-professional programming paradigm?
> 
> not just non-professional. the read/write paradigm isn't just
> non-professional, its wrong. its masking a fundamental aspect of the
> hardware. it works for video (which is also, essentially a real time
> streaming media device) because nobody notices anything odd about a
> video screen that doesn't change for a little while (unless they are
> trying to watch a real-time video stream). but any audio device that
> outputs the same data twice around its hardware buffer is immediately
> noticeable by any (non-hearing impaired) user. you can't fake
> this. apps that use large buffers are just getting away with
> pretending; it may work for them, but it doesn't work for most apps. i
> find the lag on the xmms eq controls, for example, quite irritating.
> 
> >> the APIs that are used to write almost all audio software code in
> >> production these days all use a callback model.
> >
> >Sorry for questioning this statement. Of course we all don't have any statisti
> >cal data but
> >you miss what I see as the majority of applications that use audio devices:
> >
> >1) games
> >2) media players
> >3) GUI sounds (i.e. accessibility)
> 
> this is a fair point. i apologize. i have my head so far inside the
> "audio software for musicians" box that i tend to fail to see such
> applications :)
> 
> however, the very fact that the applications developers of such
> programs really don't know much (if anything) about audio programming,
> and probably don't want to know much about it either, suggests that an
> API like ALSA which exposes the full HAL is probably a mistake. again,
> i consider PortAudio a vastly preferable solution.
> 
> i would note in passing that your second class of apps might very well
> be something that needs to be integrated with prosumer/pro apps. the
> division between, say, alsaplayer and gdam (to give two examples from
> the linux world) is hard to find when thinking up reasons why one
> should never be useful as a participant in something like JACK, and
> another one should.
> 
> >> porting from the o/c/r/w model to the callback one is
> >> hard. do you want another generation of apps stuck with this problem?
> >
> >So you think the solution is to lead developers to the right programming parad
> >igm by not making o/c/r/w type of APIs available anymore.
> 
> pretty much, yes.
> 
> >Again, I don't see the point. The 99% of Linux users using the above
> >types of programs do not care about the programming paradigm. They
> >want to hear their apps. Since L inux distributions enable artsd/esd
> >sound daemons by default, people don't hear app lications that don't
> >support the specific sound daemon. On Windows, we do have the choic e
> >and it all happily coexists.
> 
> you're talking about a world in which there is a sharp divide between
> the classes of apps you've listed above and the prosumer/pro apps i
> tend to focus on. i'd rather see linux support audio APIs that
> provide, if not an integrated user environment for all apps (this may
> not be possible), then an integrated and consistent audio API, one
> that recognizes the inherently real-time nature of audio software and
> uses a callback-driven model. can you say "CoreAudio"? :))
> 
> >Well, my point is that I want mainstream apps work out-of-the box, no
> >matter i f they talk to a daemon, to ALSA or use OSS. For semi-pro
> >audio apps, a little effort to m ake them use the full capabilities
> >is necessary anyway, and those people probably won't mind stopping a
> >sound daemon.
> 
> Apple have done the right thing, IMHO. OS X forces developers to
> either (1) deal with a full featured and complex HAL, but in so doing
> lose the ability to interact with other software, which users won't
> like or (2) use the AudioUnits API (callback based) which allows full
> integration. The problem is, as I noted several times before, there is
> nobody in the linux world who can force this on developers.
> 
> --p
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Get the new Palm Tungsten T
> handheld. Power & Color in a compact size!
> http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Florian Bomers
Java Sound
Java Software/Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
