From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Pops at start of song
Date: Mon, 24 Nov 2003 09:43:42 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGCEACDPAB.mknecht@controlnet.com>
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

>
> Ok, it's a thing that we would like to eliminate, but when I tried to
> figure what's going on in the past, I wasn't successful. The best
> thing to
> measure if ALSA sends a wrong sample sequence to the output is to use the
> digital I/O (S/PDIF or profi IEC958) for on playback side and capture the
> whole stream on the other side.
>

Jaroslav,
   I tried a number of times over the weekend to accomplish this, but it
turns out it's somewhat harder than I expected. Please tell me if any of
this is of interest. Again, the HDSP 9652 is the master clock. All the other
devices receive their clocks via their ADAT connections.

Master        Slaves via ADAT

s/pdif <----> Pro Tools (no clock)
ADAT-1 <----> Pro Tools (clock)
ADAT-2 <----> Alesis AI-3
ADAT-3 <----> GigaStudio

Also, I set up audio connections from the AI-3 to Pro Tools to record the
pop/glitch noise:

AI-3 -------> Pro Tools audio input

At this point I tried a number of things:

1) With the Pro Tools PC synced to the HDSP 9652 via ADAT I can start
recording. However, anytime the problem occurs and the HDSP 9652 momentarily
changes it's clock frequency, the Pro Tools hardware complains and
immediately stops recording. This does not capture anything of interest.

2) I can run both the Pro Tools PC and the HDSP 9652 at 44.1KHz, but
unsynced. In this case I can capture digital audio of the problem, but since
the two are unsynced I also get normal clicks and pops that are expected
when you do this. If you think you can get information from this file I'll
send it to you. Possibly, if I sent you all 5 stereo files captured
digitally via ADAT and s/pdif you'd get more info since the problem occurs
on all 10 channels and both cables at the same time.

3) I can run both unsynced again, but I record the audio glitch using the
Pro Tools A/D's. This works fine, but it isn't pure digital information so I
expect that it's not of that much interest.

One thing I noted was that when Pro Tools and the HDSP 9652 run unsynced
there is far more digital noise on ADAT-2, channels 7 & 8 than on the other
6 channels. I can see no reason for this, but it happens.

   If you get a chance to respond today then I'll get you what I can
quickly. I'll be traveling after Tuesday evening California time so nothing
will come for about a week after that.

Thanks for trying to help!

Mark




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
