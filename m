From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Pops at start of song
Date: Thu, 20 Nov 2003 21:02:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031120200243.GB3403@tuba.home>
References: <Pine.LNX.4.58.0311201220330.2668@pnote.perex-int.cz> <NDBBLGIKBJENLAMOLFHGGEOKDNAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <NDBBLGIKBJENLAMOLFHGGEOKDNAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> >
> > Ok, it's a thing that we would like to eliminate, but when I tried to
> > figure what's going on in the past, I wasn't successful. The best
> > thing to
> > measure if ALSA sends a wrong sample sequence to the output is to use the
> > digital I/O (S/PDIF or profi IEC958) for on playback side and capture the
> > whole stream on the other side.
> >
> > It seems to me, that some audio hardware (in the analog path) does not
> > have compensation for the big volume change at the start or stop of the
> > PCM stream. In this case, the application must do this compensation itself
> > to avoid the clicks. It's difficult to do the stream modification in the
> > driver.

just an idea from rme32:

I know this start click from my Digi32. But this card has an register bit
called "mute". Setting it, will switch to digital mute (=zeros) of the
output. The driver set this bit on each playback_prepare and playback_stop
and there's no click anymore:)

I don't have the docs about the hdsp hardware. Perhaps they have no longer
this register bit in the hdsp hardware, but the hdsp driver authors should
know much more about their register bits than I. 

...it's just an idea.

martin


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
