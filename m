From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: PCM API update
Date: Sat, 12 Oct 2002 11:37:54 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210121134040.1975-100000@pnote.perex-int.cz>
References: <3DA7E79A.B07E264A@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA29241
	for <alsa-devel@alsa-project.org>; Sat, 12 Oct 2002 11:39:05 +0200
In-Reply-To: <3DA7E79A.B07E264A@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 12 Oct 2002, Abramo Bagnara wrote:

> Jaroslav Kysela wrote:
> > 
> > On Fri, 11 Oct 2002, Abramo Bagnara wrote:
> > 
> > > I really don't understand why you've added another ioctl and another
> > > function to replicate in all PCM classes.
> > > snd_pcm_delay existence is enough to implement that.
> > > I'm missing something?
> > 
> > You're completely right, but in my eyes, the avail ioctl looks much better
> > for kernel space (it's a base value for computing delay, computing avail
> > from delay needs twice substractions which doesn't look very good).
> > Unfortunately, delay ioctl was first, and we should keep binary
> > compatibility for 2.5, so we should leave both ioctls there. In library,
> > we can remove the delay operation from chains and use avail to compute it
> > as well to simplify code.
> 
> No, you can't.
> The semantic of snd_pcm_delay is:
> "How many frames are current application read/write pointer far away
> from 'now' (i.e. real world sound)?"
> 
> It's *not* simply equivalent to buffer_size - avail (playback) or avail
> (capture). It's designed to take in account also olatencies introduced
> by other things (network layer, hardware limits, etc.).
> 
> Although I don't understand why you think that snd_pcm_avail is needed
> when we have the right (and safe) snd_pcm_avail_update, it can be
> implemented calling snd_pcm_delay (so to update hw pointer) and then
> computing the avail count using the mmap'ed counters.
> 
> Of course this can't work for chained PCM (and this is why we have
> snd_pcm_avail_update).
> 
> I think you should revert your patch (and to force yourself to believe a
> bit more in peer review before important changes although it seems I'm
> beating a dead horse here).

In this case, I propose to change snd_pcm_avail() to snd_pcm_hwsync() 
function with description: "synchronize r/w pointers with hardware". 
Really, after some thinking, the return value from snd_pcm_avail() cannot 
be used for nothing serious. I simply don't like that delay() functions 
do more arithmetic than necessary. Overdesign has been criticized in this 
list, too.

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
