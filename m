From: Ted <ted@nowtsfree.freeserve.co.uk>
Subject: Re: unresolved symbols in snd-gus-synth & snd-page-alloc on linux-2.2.27
Date: Thu, 30 Jun 2005 03:47:42 +0100
Message-ID: <20050630024742.8DB0848DF@marimba.home.net>
References: <20050623012340.508C148DF@marimba.home.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 23 Jun 2005 02:23:40 BST."
             <20050623012340.508C148DF@marimba.home.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: ted@nowtsfree.freeserve.co.uk
List-Id: alsa-devel@alsa-project.org

Hello, I have made a little progress in this, but am still having
problems loading the snd-ainstr-simple module.


Using yesterday's cvs for alsa-driver and alsa-kernel, I still need to
make the following change in order to build the snd-seq-midi-emul
module (Problem 1 in previous message)

$ diff alsa-kernel/core/seq/Makefile.Orig alsa-kernel/core/seq/Makefile
41c41
< obj-$(call sequencer,$(CONFIG_SND_GUS_SYNTH)) += snd-seq-instr.o
---
> obj-$(call sequencer,$(CONFIG_SND_GUS_SYNTH)) += snd-seq-instr.o snd-seq-midi-emul.o


The unresolved symbols in snd-page-alloc (Problem 3 in my last message)
seem to have been corrected in yesterday's cvs.


I have made a little progress but still not found a fix for Problem 2
in my previous message

> # insmod snd-ainstr-simple
> Using /lib/modules/2.2.27-pre2/misc/snd-ainstr-simple.o
> /lib/modules/2.2.27-pre2/misc/snd-ainstr-simple.o: init_module:
>         Invalid argument Hint: insmod errors can be caused by incorrect \
>         module parameters, including invalid IO or IRQ parameters

When this error occurs, dmesg also reports the following

kernel: init_module: mod->ex_table_* invalid.

Adding print statements to the sourcecode for sys_init_module()
in linux-2.2.27pre, I've found that this failure arises because
mod->ex_table_end == mod + mod->size. whereas the kernel expects
mod->ex_table_end <  mod + mod->size.

See the massive sanity checks in sys_init_module() in linux/kernel/module.c.

I'm using modutils-2.3.17, gcc-2.95.3, ld-2.10, linux-2.2.27pre2 if that
helps. I'm not sure how to make further progress on this. Any help would
much appreciated.

Ted.
-- 
Ted <ted@nowtsfree.freeserve.co.uk>
   http://www.nowtsfree.freeserve.co.uk


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
