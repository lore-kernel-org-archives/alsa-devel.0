From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: PCM API update
Date: Sat, 12 Oct 2002 11:12:58 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA7E79A.B07E264A@libero.it>
References: <Pine.LNX.4.33.0210121049560.1975-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp1.libero.it (smtp1.libero.it [193.70.192.51])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA28936
	for <alsa-devel@alsa-project.org>; Sat, 12 Oct 2002 11:13:39 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> On Fri, 11 Oct 2002, Abramo Bagnara wrote:
> 
> > I really don't understand why you've added another ioctl and another
> > function to replicate in all PCM classes.
> > snd_pcm_delay existence is enough to implement that.
> > I'm missing something?
> 
> You're completely right, but in my eyes, the avail ioctl looks much better
> for kernel space (it's a base value for computing delay, computing avail
> from delay needs twice substractions which doesn't look very good).
> Unfortunately, delay ioctl was first, and we should keep binary
> compatibility for 2.5, so we should leave both ioctls there. In library,
> we can remove the delay operation from chains and use avail to compute it
> as well to simplify code.

No, you can't.
The semantic of snd_pcm_delay is:
"How many frames are current application read/write pointer far away
from 'now' (i.e. real world sound)?"

It's *not* simply equivalent to buffer_size - avail (playback) or avail
(capture). It's designed to take in account also olatencies introduced
by other things (network layer, hardware limits, etc.).

Although I don't understand why you think that snd_pcm_avail is needed
when we have the right (and safe) snd_pcm_avail_update, it can be
implemented calling snd_pcm_delay (so to update hw pointer) and then
computing the avail count using the mmap'ed counters.

Of course this can't work for chained PCM (and this is why we have
snd_pcm_avail_update).

I think you should revert your patch (and to force yourself to believe a
bit more in peer review before important changes although it seems I'm
beating a dead horse here).

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
