From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: delta-66 bug?
Date: Tue, 11 Mar 2003 18:42:58 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303111842120.1352-100000@pnote.perex-int.cz>
References: <s5hr89e2omz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr89e2omz.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ian <deviant@custard.org>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 11 Mar 2003, Takashi Iwai wrote:

> At Tue, 11 Mar 2003 00:11:43 +0000 (GMT),
> ian wrote:
> > 
> > ah, thank you!
> > i updated to the latest non-cvs packages. things have got a bit better!
> > now if i set the clock to spdif, it stays locked to spdif. so the delta-66
> > driver is doing it's job. but now if i use xmms to play a stream through
> > pcm, the playback is too fast. (spdif sets the card to 48kHz, and xmms is
> > trying to open the pcm device at 44.1kHz). so it would seem there is a
> > problem with the oss layer - namely that it is not resampling the stream
> > from 44.1kHz to 48kHz.
> 
> the driver doesn't check how is the current spdif input rate, and it
> doesn't restrict the possible sample rates for the later open.
> 
> the implementation of clock sync with an external source is still an
> open question.  for example, when the external clock is changed, how
> the driver should handle it...?

It should return an error ASAP.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
