From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: problems: flushing during snd_pcm_wait()
Date: Fri, 11 Oct 2002 15:00:43 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210111458330.1244-100000@pnote.perex-int.cz>
References: <3DA6C91B.6030502@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DA6C91B.6030502@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 11 Oct 2002, James Courtier-Dutton wrote:

> Takashi Iwai wrote:
> 
> >At Fri, 11 Oct 2002 01:25:19 +1000,
> >James Courtier-Dutton wrote:
> >  
> >
> >>Hello
> >>I have an application that has many different threads.
> >>The sound card's PCM buffer is full during playback, and one thread is 
> >>currently in snd_pcm_wait() waiting for enough space to appear in the 
> >>buffer before doing the next snd_pcm_write().
> >>A different thread wants to flush the buffer. There are two types of 
> >>flush: -
> >>1) Immeadiately empty the buffer.
> >>    
> >>
> >
> >snd_pcm_drop() ?
> >
> >  
> >
> >>2) Stop accepting snd_pcm_write() commands until the current buffer has 
> >>drained.
> >>    
> >>
> >
> >snd_pcm_drain() ?
> >
> >
> >Takashi
> >
> >  
> >
> Thankyou, I will use snd_pcm_drop(), but as a side note, what actually 
> does "snd_pcm_reset()" do.
> Just resetting delay to 0 does not make much sense to me.

It drops all samples in the ring buffer (thus reseting delay to 0). Note 
that everybody are welcome to improve the current documentation 
(preferably with patches).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
