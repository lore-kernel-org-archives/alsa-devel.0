From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: PCM API update
Date: Sat, 12 Oct 2002 10:54:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210121049560.1975-100000@pnote.perex-int.cz>
References: <3DA73101.7A53993D@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA28688
	for <alsa-devel@alsa-project.org>; Sat, 12 Oct 2002 10:55:30 +0200
In-Reply-To: <3DA73101.7A53993D@libero.it>
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

On Fri, 11 Oct 2002, Abramo Bagnara wrote:

> Jaroslav Kysela wrote:
> > 
> > Hi all,
> > 
> >         these enhancements are in CVS for PCM API:
> > 
> > - added snd_pcm_avail() function - this function returns count of
> >   available frames for write or read operations, the position
> >   is read directly from hardware; the snd_pcm_avail_update() call
> >   is still mandatory before any I/O!!!
> 
> I really don't understand why you've added another ioctl and another
> function to replicate in all PCM classes.
> snd_pcm_delay existence is enough to implement that.
> I'm missing something?

You're completely right, but in my eyes, the avail ioctl looks much better
for kernel space (it's a base value for computing delay, computing avail
from delay needs twice substractions which doesn't look very good).
Unfortunately, delay ioctl was first, and we should keep binary
compatibility for 2.5, so we should leave both ioctls there. In library,
we can remove the delay operation from chains and use avail to compute it 
as well to simplify code.

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
