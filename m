From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [RFC] merging splited driver back
Date: Wed, 21 Aug 2002 11:53:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208202012410.12251-100000@pnote.perex-int.cz>
References: <s5hr8gtsw70.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr8gtsw70.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Thierry Vignaud <tvignaud@mandrakesoft.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Aug 2002, Takashi Iwai wrote:

> Hi,
> 
> At Mon, 19 Aug 2002 22:29:12 +0200,
> Thierry Vignaud wrote:
> > 
> > snd-ens1370 and 1371're just the same driver which compilation is
> > altered by preprocessors directives.
> > 
> > snd-via8232 came from via686 and some common code can still be seen.
> > 
> > it would be nice if the alsa team can make a unified snd-ens137[01]
> > driver and a snd-via-common sub module used by snd-via{686,8232}.
> 
> both jobs would be relatively easy.
> in fact, integration of ens137x was already done experimentally on my
> tree, and the change for via driver should be also small.
> 
> but the decision is different.
> 
> pro:
>   - merging via drivers will make the maintenance and bug-hunt easier.
>     merging ens137x drivers makes no difference, because it's already
>     in a source.
> 
> con:
>   - merging two drivers to a unified driver will increase the size.
>   - we may put the common stuff into lowlevel module.  but the
>     lowlevel module cannot be marked as __devinit, although this
>     doesn't matter for modules anyway.
> 
> 
> basically i vote for this action, but i'd like to hear the opinion
> from other people in this regard.

I don't like very much to merging of ENS1370 and ENS1371, because 
different codecs are used (snd-ak4531-codec and snd-ac97-codec). Sure, 
there is common code (MIDI UART, most of PCM routines), but I think that 
the final difference (separate module with common code) will be 
negligible, but we may do it.

VIA code may be merged.

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
