From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: PCM API update
Date: Sat, 12 Oct 2002 12:10:58 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210121208550.1975-100000@pnote.perex-int.cz>
References: <3DA7F15B.A8E89CB4@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA29676
	for <alsa-devel@alsa-project.org>; Sat, 12 Oct 2002 12:12:18 +0200
In-Reply-To: <3DA7F15B.A8E89CB4@libero.it>
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
> > 
> > In this case, I propose to change snd_pcm_avail() to snd_pcm_hwsync()
> > function with description: "synchronize r/w pointers with hardware".
> > Really, after some thinking, the return value from snd_pcm_avail() cannot
> > be used for nothing serious. I simply don't like that delay() functions
> > do more arithmetic than necessary. Overdesign has been criticized in this
> > list, too.
> 
> Let examine kernel level: snd_pcm_{plaback,capture}_delay do a
> snd_pcm_update_hw_ptr and a snd_pcm_{playback_hw,capture}_avail (that's
> only a wrap safe difference).
> 
> Are you sure you want to add another ioctl and another API function in
> all the PCM classes just to avoid a subtraction?

You've already noted that delay() expression might be more complex, so the 
code path eats more CPU than needed for sync operation.

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
