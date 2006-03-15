From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_hwsync
Date: Wed, 15 Mar 2006 13:13:25 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0603151309030.20193@tm8103.perex-int.cz>
References: <7fe205990603150406i5e61842fh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 72F231FD
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2006 13:13:26 +0100 (MET)
In-Reply-To: <7fe205990603150406i5e61842fh@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joe Hsu <nagual.hsu@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

yOn Wed, 15 Mar 2006, Joe Hsu wrote:

> Hi all:
>     Sometimes, snd_pcm_hwsync would return -32 (-EPIPE).
> I can't see why. After snd_pcm_hwsync failed, snd_pcm_avail_update
> would return a much bigger positive value than pcm_hw_bufsize.
> 
>     Can any one tell me why? and how to avoid such questions?

-EPIPE means xrun (over or underrun - new data exceed the ring buffer 
or an application does not put new data in time)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
