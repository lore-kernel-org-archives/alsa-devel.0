From: Jaroslaw Sobierski <fycio@gucio.com>
Subject: Re: Re: dmix plugin
Date: Mon, 17 Feb 2003 05:12:43 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045487563.3e50dfcb26321@webmail3.namezero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: abramo.bagnara@libero.it
Cc: perex@suse.cz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Abramo Bagnara wrote:
>If we'd need to use an intermediate buffer and a mixing thread, the dmix
>approach lose our interest.
>
>A solution might be to have a shared parallel sw ring buffer where to
>store the exact value:
>
>        xadd(sw, *src);
>	do {
>		v = *sw;
>		if (v > 0x7fff)
>			s = 0x7fff;
>		else if (v < -0x8000)
>			s = -0x8000;
>		else
>	     		s = v;
>		*hw = v;
>	} while (unlikely(v != *sw));
>	
>This should solve also the atomicity update.

Very true, and it is consistent with what
Jaroslav Kysela wrote:
> My point was that all processes operates simultaneously and independently.  
> So if one process updates area in the "sum" ring buffer, then it MUST
> transfer changed area (with saturation) to the DMA buffer. So there is no 
> "once saturation" as you think. Anyway, the current implementation uses 
> also saturation for all clients (processes) so the only drawback is the 
> additional access to the "sum" ring buffer memory area.

So it seems like a good compromise to solve all our problems :-). 

Still, don't we already *have* a feeding thread for the sound card? I mean
it doesn't just grab the memory buffer all by itself whenever it wants?
Excuse my ignorance on this topic I'm only just starting with ALSA, and I
did not have the time yet to go through the entire source code ;-).
I remember when I was writing a driver for an mpeg2 decoder card that I
had to create 2 threads, one for feeding video and one for audio. The
FIFO level was checked either by polling or via interrupt handlers but
I still had control over what and when is transferred. I could let the
card pull the data via DMA using bus mastering but I still new what 
and from where will be sent...
Does the problem lie in the fact that it is actually a plugin and has
no control of the transfer? Maybe it would be worth considering a callback
for the plugin from the main alsa module to infrom it that a new piece
of the DMA buffer must be "prepared" whatever that could mean for a
particular plugin. Anyway, just a thought.

--------------
Fycio (J.Sobierski)
 fycio@gucio.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
