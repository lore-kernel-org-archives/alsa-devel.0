From: Ted <ted@nowtsfree.freeserve.co.uk>
Subject: unresolved symbols in snd-gus-synth & snd-page-alloc on linux-2.2.27
Date: Thu, 23 Jun 2005 02:23:40 +0100
Message-ID: <20050623012340.508C148DF@marimba.home.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello,

Problem 1) I get unresolved symbols in the snd-gus-synth module of
alsa-driver-1.0.9rc3 when building for the interwave pnp card using

$ ./configure --prefix=/usr --with-debug=detect --with-isapnp=yes \
		--with-sequencer=yes --with-cards=interwave

# depmod -e
depmod: *** Unresolved symbols in /lib/modules/2.2.27-pre2/misc/snd-gus-synth.o
depmod:		snd_midi_channel_free_set
depmod:		snd_midi_channel_alloc_set
#

This is because the snd-seq-midi-emul is ommitted from the build.
A fix that appears to correct this is to add its dependancy to the file

	alsa-kernel/core/seq/Makefile

# diff alsa-kernel/core/seq/Makefile.Orig alsa-kernel/core/seq/Makefile
41c41
< obj-$(call sequencer,$(CONFIG_SND_GUS_SYNTH)) += snd-seq-instr.o
---
> obj-$(call sequencer,$(CONFIG_SND_GUS_SYNTH)) += snd-seq-instr.o snd-seq-midi-emul.o
#



Problem 2) Following that fix, the snd-ainstr-simple module also fails
to load because its initialisation is incorrect:

# insmod snd-ainstr-simple
Using /lib/modules/2.2.27-pre2/misc/snd-ainstr-simple.o
/lib/modules/2.2.27-pre2/misc/snd-ainstr-simple.o: init_module:
	Invalid argument Hint: insmod errors can be caused by incorrect \
	module parameters, including invalid IO or IRQ parameters

Not sure how to fix this, it looks like incomplete "work in progress".
See
	alsa-kernel/core/seq/instr/ainstr_simple.c




Problem 3) The cvsexport 2005-06-17 also has unresolved symbols in the
snd-page-alloc module on linux-2.2.27:

# depmod -e
depmod: *** Unresolved symbols in /lib/modules/2.2.27-pre2/misc/snd-gus-synth.o
depmod:         snd_midi_channel_free_set
depmod:         snd_midi_channel_alloc_set
depmod: *** Unresolved symbols in /lib/modules/2.2.27-pre2/misc/snd-page-alloc.o
depmod:         strsep
depmod:         simple_strtol
depmod:         memparse
#

These symbols are not defined in linux-2.2.27 and need adding to
alsa-driver/include/compat_22.h.

Thankyou,

Ted.
-- 
Ted <ted@nowtsfree.freeserve.co.uk>
   http://www.nowtsfree.freeserve.co.uk


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
