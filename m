From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: crash trace under gdb
Date: Fri, 09 May 2003 13:48:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19EBut-0002ql-00@sc8-sf-list1.sourceforge.net>
References: <3EBBE54F.8020808@libero.it>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 09 May 2003 19:28:47 +0200."
             <3EBBE54F.8020808@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>However it would be nice if Paul help us to track down the source of the 
>bug, or give a test case for someone willing to help and with access to 
>SMP hardware.

i'm happy to help out, but there's very little information available
from the system when it happens. it also turns out (unsuprisingly) not
to require gdb at all: the last time it happened, i started JACK up
and within a few seconds the system was locked.

if there's something i can try (adding printk's, whatever), let me
know. i have both tree in place now, so its not painful to switch back
and forth. 

i also note that as far as i can tell, the dependency of the hdsp
driver on snd-hwdep is still not in place. i had to add:

obj-$(CONFIG_SND_HDSP) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o

to alsa-driver/acore/Makefile for the Apr. 27th version, although i
didn't notice a problem with this for the most recent CVS version. i
grepped for hwdep in the recent tree, and couldn't see where it was
added, but perhaps it was. jaroslav?

--p


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
