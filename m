From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: sb16 gets wedged when doing overlapped i/o (full
 duplex)
Date: Thu, 5 Dec 2002 18:47:57 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0212051845390.505-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.05.10212051455590.3576-100000@pulsar.kss-loka.si>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.05.10212051455590.3576-100000@pulsar.kss-loka.si>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Uros Bizjak <uros@kss-loka.si>
Cc: "John S. Denker" <jsd@monmouth.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 5 Dec 2002, Uros Bizjak wrote:

> Hello!
> 
> > I tried setting it to Capture.
> > No joy.  ALSA gets wedged just the same as before.
> > 
> > By the way, is this DMA Allocation thingy documented anywhere?????
> 
>   Yes, now it is mentioned in isa/sb/sb16_main.c driver source.
> 
> > I had to do a huge find|grep to figure out what this
> > suggestion was referring to.  Alsamixer knows nothing
> > of this switch.  Amixer knows nothing of this switch.
> > Fortunately alsactl can deal with it.
> 
>   It is not a IFACE_MIXER switch, but IFACE_PCM type switch.
> 
>   From the error message you posted about this bug, it looks that driver
> is trying to call prepare() operator on a substream that is still 
> in SNDRV_PCM_STATE_RUNNING state. Perhaps Jaroslav could tell us if this
> can happen if hardware pointers are not updated anymore (because sb16 DMA
> engine gets stucked somehow). Do you get an XRUN message in
> /var/log/messages?

Prepare can be called with status different than SNDRV_PCM_STATE_OPEN and 
SNDRV_PCM_STATE_RUNNING. You have to call snd_pcm_drop() and 
snd_pcm_drain() in this case. Ten second limit is in write() and read() 
syscalls, so it's possible that the SB DMA engine is somehow screwed.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
