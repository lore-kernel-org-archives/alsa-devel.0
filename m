From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: Pops at start of song
Date: Mon, 24 Nov 2003 19:29:48 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0311241923570.9896@pnote.perex-int.cz>
References: <NDBBLGIKBJENLAMOLFHGCEACDPAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <NDBBLGIKBJENLAMOLFHGCEACDPAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Nov 2003, Mark Knecht wrote:

> >
> > Ok, it's a thing that we would like to eliminate, but when I tried to
> > figure what's going on in the past, I wasn't successful. The best
> > thing to
> > measure if ALSA sends a wrong sample sequence to the output is to use the
> > digital I/O (S/PDIF or profi IEC958) for on playback side and capture the
> > whole stream on the other side.
> >
> 
> Jaroslav,
>    I tried a number of times over the weekend to accomplish this, but it
> turns out it's somewhat harder than I expected. Please tell me if any of
> this is of interest. Again, the HDSP 9652 is the master clock. All the other
> devices receive their clocks via their ADAT connections.
> 
> Master        Slaves via ADAT
> 
> s/pdif <----> Pro Tools (no clock)
> ADAT-1 <----> Pro Tools (clock)
> ADAT-2 <----> Alesis AI-3
> ADAT-3 <----> GigaStudio
> 
> Also, I set up audio connections from the AI-3 to Pro Tools to record the
> pop/glitch noise:
> 
> AI-3 -------> Pro Tools audio input
> 
> At this point I tried a number of things:
> 
> 1) With the Pro Tools PC synced to the HDSP 9652 via ADAT I can start
> recording. However, anytime the problem occurs and the HDSP 9652 momentarily
> changes it's clock frequency, the Pro Tools hardware complains and
> immediately stops recording. This does not capture anything of interest.

Ok, can you force the master rate for HDSP? Then you can simply send some
short (a few seconds) .wav file (or other file) with same rate to selected
channels (maybe via aplay if you have a good configuration in
~/.asoundrc). Then you can compare (maybe via some editor) if the whole
.wav file is in the recorded stream (plus some zero samples at begging and
end of this stream). Or, you can send me your source and recorded files
and I'll compare them for you (only mark which file is master).

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
