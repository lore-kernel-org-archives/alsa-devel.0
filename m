From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: Pops at start of song
Date: Thu, 20 Nov 2003 12:26:45 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0311201220330.2668@pnote.perex-int.cz>
References: <NDBBLGIKBJENLAMOLFHGCEKEDNAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <NDBBLGIKBJENLAMOLFHGCEKEDNAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: derosier@pianodisc.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Nov 2003, Mark Knecht wrote:

> Steve,
>    You're the first person I can remember to report something very similar
> to what I'm dealing with every day. I get a huge loud cracking noise at the
> start of any audio operation that is not vanilla Alsa - i.e. - anything
> accessing OSS I think. In my case I think it's hardware based, but I'm not
> sure. This happens only on my HDSP 9652 system. I have two other systems,
> one using an onboard NForce audio device, and the other using an RME
> Hammerfall Light, that act correctly.
> 
>    With the RME products we have the hdspconf application which shows the
> sync frequency of the card. I normally run at 44.1K, but if I open hdspconf
> and watch the card's frequency, it tells me that the card becomes unlocked
> and changes sample rates when the noise happens. This happens when starting
> any app that uses OSS (I think) like gxine, or xmms, or most games, or
> browsing web pages. It does not happen when starting a native Alsa
> application like alsaplayer.
> 
>    Does this sound at all like what you're experiencing?

Ok, it's a thing that we would like to eliminate, but when I tried to 
figure what's going on in the past, I wasn't successful. The best thing to 
measure if ALSA sends a wrong sample sequence to the output is to use the 
digital I/O (S/PDIF or profi IEC958) for on playback side and capture the 
whole stream on the other side.

It seems to me, that some audio hardware (in the analog path) does not
have compensation for the big volume change at the start or stop of the
PCM stream. In this case, the application must do this compensation itself
to avoid the clicks. It's difficult to do the stream modification in the
driver.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
