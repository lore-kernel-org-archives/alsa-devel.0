From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: trident driver bug
Date: Wed, 19 Mar 2003 21:20:05 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303192117070.1351-100000@pnote.perex-int.cz>
References: <20030319201849.GA14297@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030319201849.GA14297@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Mar 2003, Martin Langer wrote:

> On Wed, Mar 19, 2003 at 01:10:02PM -0500, Paul Davis wrote:
> > there still appears to be a bug in the trident driver. i have been
> > running jack with a period size of 1024, and it works fine. when i
> > change that to 4096 frames, the kernel does a hard oops, with the oops
> > occuring in enable_hlt(). the rest of the trace doesn't make much
> > sense, and i cannot feed it to ksymoops because the machine locks
> > hard.  what can i do to make it eas(y|ier) to debug?
> > 
> 
> ... just having a short view to the sourcecode, I saw that the maxbuffer for
> playback is bigger than the rest (spdif, capture,..). Maybe this is a bug,
> but I don't have either the hardware nor the documentation for the trident.
> So it's possible that I'm totally wrong here...
> 
> ... it's just an idea to change that buffersize to the smaller buffersize 
> like capture/spdif (128*1024) instead of original size (256*1024).

Trident's NX playback hardware supports the 256kB ring buffer. It seems 
like some weird bug in the DMA allocation routines.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
