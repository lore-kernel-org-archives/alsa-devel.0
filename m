From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: snd_async_add_pcm_handler() and SND_PCM_ACCESS_MMAP_INTERLEAVED
Date: Thu, 15 May 2003 09:52:12 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19GJ4T-0002dW-00@sc8-sf-list1.sourceforge.net>
References: <s5hwugse5cz.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 15 May 2003 14:55:56 +0200."
             <s5hwugse5cz.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Vollmer <remllov_@gmx.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>IIRC, even ioctl is not allowed officially by POSIX.
>that means, almost all actions of ALSA PCM...

yes, no ioctl. read/write/lseek/pipe/fork are OK. bizarre, eh?

>in practice, they work fine, though :)

until one day, someone does a significant and entirely legal kernel
hack that makes all ioctl syscalls fail when made from signal
handlers ...


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
