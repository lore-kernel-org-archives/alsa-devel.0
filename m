From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Pops at start of song
Date: Thu, 20 Nov 2003 10:07:56 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGGEOKDNAB.mknecht@controlnet.com>
References: <Pine.LNX.4.58.0311201220330.2668@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0311201220330.2668@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav,
   I certainly want you to know that I have always sensed your commitment to
solving these problems and making Alsa better. I also understand that it's
terribly difficult for you to debug these things at a distance with a putz
like me who isn't a developer, and apparently the only person having this
problem.

   Please tell me how specifically what you want in the s/pdif recording.
Would you like me to record the HDSP s/pdif audio output on my Pro Tools box
and see if the noise is there? Easy to do and I'll do it this evening.

   Would having an account and root password on this system help you in any
way? If so, we can arrange that. This is how Thomas and I helped move the
HDSP 9652 driver forward. He programmed. I looked and listened.

   Please remember that this problem does not occur when I use Alsa
applications, which should help us focus in on the cause. It happens only
when using applications that are not specifically Alsa, so I guess that
means they are using OSS. I have tried things like plughw and other stuff in
my .asoundrc file but none of that has helped this problem. (Of course, I do
not understand the .asoundrc file language, so it's probably wrong anyway.)

   In thinking about this problem, I have come to wonder if the problem is
related to the type of A/D-D/A hardware that I have attached to ADAT2, and
which is part of my output signal chain. The Alesis AI-3 is a simple
8-in/8-out unit. It works very well, but it has one particular quirk, if you
will, in that it always wants to run at 48KHz unless it is given a sync
signal via its ADAT input at a different frequency. I run at 44.1K, and my
sense is that the AI-3 is jumping to 48K when this happens. That does not
mean that the HDSP 9652 is also jumping to 48K. Possibly the HDSP 9652 stops
sending a sync signal, or does something else strange.

   The same noise occurs when I simply change sample rates using hdspconf.
For this reason, I started thinking that it was a problem like Steve's since
I imagined that if all zeros were sent to the buffer while the rate was
being changed it might eliminate that problem.

   Or possibly this has to do with the specific way I have things hooked up?

HDSP 9652 is the clock Master
Clocks to slaves are over ADAT

ADAT-1 <======> Pro Tools/Win XP system
ADAT-2 <======> Alesis AI-3 ---> Speakers & headphone amps
ADAT-3 <======> Hammerfall Light/WinME/GigaStudio/Reaktor-or-Linux soft
synths

   Maybe this is an ADAT-2 problem specifically and wouldn't happen if the
Alesis was on ADAT-1?

   Thanks for your help.

Mark

>
> Ok, it's a thing that we would like to eliminate, but when I tried to
> figure what's going on in the past, I wasn't successful. The best
> thing to
> measure if ALSA sends a wrong sample sequence to the output is to use the
> digital I/O (S/PDIF or profi IEC958) for on playback side and capture the
> whole stream on the other side.
>
> It seems to me, that some audio hardware (in the analog path) does not
> have compensation for the big volume change at the start or stop of the
> PCM stream. In this case, the application must do this compensation itself
> to avoid the clicks. It's difficult to do the stream modification in the
> driver.
>
> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
>
>




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
