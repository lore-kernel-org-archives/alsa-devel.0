From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [RFC] merging splited driver back
Date: Thu, 22 Aug 2002 20:06:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208221954000.1074-100000@pnote.perex-int.cz>
References: <m2r8gr6mf6.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m2r8gr6mf6.fsf@vador.mandrakesoft.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 22 Aug 2002, Thierry Vignaud wrote:

> Takashi Iwai <tiwai@suse.de> writes:
> 
> > > I don't like very much to merging of ENS1370 and ENS1371, because
> > > different codecs are used (snd-ak4531-codec and snd-ac97-codec).
> >
> > ah, yes, that's not beautiful to have two codec modules for one
> > driver.
> >
> >> Sure, 
> >> there is common code (MIDI UART, most of PCM routines), but I think that 
> >> the final difference (separate module with common code) will be 
> >> negligible, but we may do it.
> >
> > well, then let's leave ens1370/1 as they are.
> 
> this would have enbling to reduce memory usage if one have both 1370
> and 1371 cards,

It's questionable, because every segments are aligned to 4kB on i386 (8kb 
on alphas), so you can reach same memory consumption.

> and/or reduce kernel package size :-)

It's probably only valid reason, but it does not change anything from the 
maintaince view. Anyway, as I wrote, separating code to a common module 
will be accepted. Patches are welcome ;-)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
