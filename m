From: Florian Bomers <Florian.Bomers@sun.com>
Subject: Re: smix plugin available?
Date: Tue, 26 Nov 2002 11:32:40 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE3CC58.B3759F28@sun.com>
References: <E18GWCQ-0006He-00@sc8-sf-list1.sourceforge.net>
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

Hi Paul,

very interesting discussion.

Paul Davis wrote:
> 
> (...)
> 
> >One of the big reasons this is affecting me is that Java sound will not work
> >unless you have a hardware mixer. My understanding is that the Sun folks seem
> >to think that it is wrong to have to implement many different ways to create
> >sound when the sound library (ALSA) should do it for them - the way it works
> >in Windows/Solaris. I completely agree with them.
> 
> ALSA is *a* sound library. There are lots of things that it doesn't

I would really say: ALSA is *the* sound library (at least on Linux). Isn't it in kernel
2.5+ ?

> contain, and its written around a fairly specific programming
> paradigm. There are those of us (many people on LAD) who believe that
> its too hard to fit a callback-driven model into the existing ALSA
> design, and that its therefore better to implement such a model
> outside of ALSA.
> 
> You see, if all apps are written to use the ALSA API, that's going to
> be great for the purposes you have in mind, but totally awful for
> those of us who want our audio apps to work in a sample synchronous
> way and ignorant of the ultimate routing of their data. Many of us
> don't think that an API based on the open/close/read/write paradigm is
> appropriate for real time streaming media.

I don't know if I get the point right here, but it reads: don't use ALSA. But it's the
only sound library that will be delivered with all distributions in future, so what choice
do mainstream application writers have ? OSS ?

> (...)
> 
> >If there was a way to temporarily disable the smix plugin, or temporarily gain
> >exclusive ownership of the sound device for your purposes would that meet
> >100% of your requirements?
> 
> no, it wouldn't meet any of them. the problem is not exclusive
> access. its the fundamental API model. ALSA (like OSS before it, as
> well as SGI's DMedia APIs) has promoted the open/close/read/write
> model. this is the central problem. ALSA certainly *allows* for a
> callback model (its what allows JACK to work), but there are almost no
> applications that use ALSA in this way. using the o/c/r/w paradigm
> makes sample synchronous execution of multiple applications basically
> impossible, and more importantly it encourages application designers
> to construct programs based on the idea that the program controls when
> to read/write audio data. this doesn't work properly except for
> heavily buffered, single applications. 

So you discourage use of ALSA because it suggests/allows a non-professional programming
paradigm? 

> the APIs that are used to write almost all audio software code in 
> production these days all use a callback model. 

Sorry for questioning this statement. Of course we all don't have any statistical data but
you miss what I see as the majority of applications that use audio devices:

1) games
2) media players
3) GUI sounds (i.e. accessibility)

What point is in comparing the amount of "audio software code" ? Compare the number of
people using the above types of software with the number of people using semi-pro level
audio software.

> porting from the o/c/r/w model to the callback one is
> hard. do you want another generation of apps stuck with this problem?

So you think the solution is to lead developers to the right programming paradigm by not
making o/c/r/w type of APIs available anymore.

Again, I don't see the point. The 99% of Linux users using the above types of programs do
not care about the programming paradigm. They want to hear their apps. Since Linux
distributions enable artsd/esd sound daemons by default, people don't hear applications
that don't support the specific sound daemon. On Windows, we do have the choice and it all
happily coexists. 

My perfect world would look like this:
- ALSA (becoming the default audio HAL on Linux) has the future smix plugin enabled by
default, but only if the soundcard does not provide hardware mixing
- sound daemons can all run at the same time, and they can continue to block the device if
they really think that's a good idea
- apps with higher requirements (low latency, sample synchronization, etc.) will need the
user to stop the daemons and will use ALSA hardware devices hw: directly.

I also see the problem that audio daemons block the soundcard. But that's another story.

> if you want a genuinely portable solution, use PortAudio. it works
> with (but hides) OSS, Windows MME, ASIO, CoreAudio, and several
> others. JACK and ALSA support is present in CVS. it encourages a
> callback model.

The "genuinely" portable solution is Java :) 

Well, my point is that I want mainstream apps work out-of-the box, no matter if they talk
to a daemon, to ALSA or use OSS. For semi-pro audio apps, a little effort to make them use
the full capabilities is necessary anyway, and those people probably won't mind stopping a
sound daemon.

Florian



-- 
Florian Bomers
Java Sound
Java Software/Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
