From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: snd_async_add_pcm_handler() and SND_PCM_ACCESS_MMAP_INTERLEAVED
Date: Thu, 15 May 2003 10:28:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19GJdF-0003H6-00@sc8-sf-list1.sourceforge.net>
References: <Pine.LNX.4.44.0305151603000.9877-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 15 May 2003 16:05:49 +0200."
             <Pine.LNX.4.44.0305151603000.9877-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Peter Vollmer <remllov_@gmx.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>On Thu, 15 May 2003, Paul Davis wrote:
>
>> >IIRC, even ioctl is not allowed officially by POSIX.
>> >that means, almost all actions of ALSA PCM...
>> 
>> yes, no ioctl. read/write/lseek/pipe/fork are OK. bizarre, eh?
>> 
>> >in practice, they work fine, though :)
>> 
>> until one day, someone does a significant and entirely legal kernel
>> hack that makes all ioctl syscalls fail when made from signal
>> handlers ...
>
>Yes, but we can talk with the driver only using DMA buffer and mmaped ring 
>buffer pointers, so the properly written program does not use ioctls.

i'd love to find a way to make JACK do that. unfortunately, it seems
to need to make a few system calls on returning from poll. unless i'm
just forgetting something, and the calls it makes all resolve to
operations on the mmapped buffer points. 


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
