From: Carolyn and Eric Hathaway <hathaway@uplink.net>
Subject: aureal driver compile problem and patch
Date: Thu, 30 Oct 2003 22:12:57 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FA1D339.1020507@uplink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

(I already attempted to send this message to the list once before I 
subscribed, but it never showed up in the archives.  My apologies if 
this ends up being a duplicate post. -ELH)

Hello,

I'm running RedHat 7.3 with all updates applied (including RedHat's 
kernel version 2.4.20-20.7), with a generic OEM Aureal Vortex soundcard 
(au8820 chip).  On this system, I compiled ALSA driver 0.9.8 with the 
following options:

     [eric@duster alsa-driver-0.9.8]$ ./configure --with-isapnp=no 
--with-sequencer=yes --with-oss=yes --with-cards=au8820

Performing a 'make; make install' ends with a message saying that there 
are unresolved symbols in module snd-au8820.o.  Digging a bit deeper, we 
can find which symbols are unresolved:

     [root@duster alsa-driver-0.9.8]# depmod -ae
     depmod: *** Unresolved symbols in 
/lib/modules/2.4.20-20.7/kernel/sound/pci/au88x0/snd-au8820.o
     depmod:     snd_mpu401_uart_new_Ra9ec76fd
     depmod:     snd_mpu401_uart_interrupt_Rff6d4aa3
     depmod:     snd_ac97_mixer_Rdd7e1738

By comparing the ALSA driver 0.9.8 source tree to the CVS repository at 
the OpenVortex web site where the vortex driver was developed, I found 
that there were some missing lines in several Makefiles in the ALSA 
tree.  In the OpenVortex CVS repository, these lines appear in Makefiles 
under alsa-kernel/ but my understanding is that a driver shouldn't touch 
these files until it is included in alsa-kernel/, so I added the lines 
to the corresponding Makefiles outside of alsa-kernel/.  I'm not 100% 
sure if all the dependencies I've added are necessary--I just blindly 
copied lines from the OpenVortex CVS.  Someone with a better 
understanding of the driver can double-check me.

After making these modifications (see patch below), the vortex driver 
compiled with no unresolved symbols on my system, and is working great. 
  Thanks to ALSA and the OpenVortex guys for getting my soundcard 
working without having to use the old binary-only Aureal driver.

-Eric Hathaway

--------------- BEGIN PATCH -----------------------
diff -ur alsa-driver-0.9.8/acore/Makefile
alsa-driver-0.9.8-patched/acore/Makefile
--- alsa-driver-0.9.8/acore/Makefile    Tue Sep 16 06:14:03 2003
+++ alsa-driver-0.9.8-patched/acore/Makefile    Tue Oct 21 22:21:12 2003
@@ -10,6 +10,9 @@
obj-$(CONFIG_SND_SERIALMIDI) += snd-rawmidi.o snd.o
obj-$(CONFIG_SND_MSND_PINNACLE) += snd-pcm.o snd-timer.o 
snd-page-alloc.o snd.o snd-rawmidi.o
obj-$(CONFIG_SND_USB_US428) += snd-pcm.o snd-timer.o snd-page-alloc.o 
snd.o snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_AU8810) += snd-pcm.o snd-timer.o snd-page-alloc.o 
snd.o snd-rawmidi.o
+obj-$(CONFIG_SND_AU8820) += snd-pcm.o snd-timer.o snd-page-alloc.o 
snd.o snd-rawmidi.o
+obj-$(CONFIG_SND_AU8830) += snd-pcm.o snd-timer.o snd-page-alloc.o 
snd.o snd-rawmidi.o

export-objs := sound.o pcm.o pcm_lib.o rawmidi.o timer.o hwdep.o memalloc.o

diff -ur alsa-driver-0.9.8/acore/seq/Makefile
alsa-driver-0.9.8-patched/acore/seq/Makefile
--- alsa-driver-0.9.8/acore/seq/Makefile        Mon Jun  2 09:03:38 2003
+++ alsa-driver-0.9.8-patched/acore/seq/Makefile        Tue Oct 21 
22:21:20 2003@@ -7,6 +7,9 @@

obj-$(CONFIG_SND_SERIALMIDI) += snd-seq-midi.o snd-seq.o 
snd-seq-device.o snd-seq-midi-event.o
obj-$(CONFIG_SND_MSND_PINNACLE) += snd-seq-midi.o snd-seq.o 
snd-seq-device.o snd-seq-midi-event.o
+obj-$(CONFIG_SND_AU8810) += snd-seq-midi.o snd-seq.o snd-seq-device.o 
snd-seq-midi-event.o snd-seq-instr.o
+obj-$(CONFIG_SND_AU8820) += snd-seq-midi.o snd-seq.o snd-seq-device.o 
snd-seq-midi-event.o snd-seq-instr.o
+obj-$(CONFIG_SND_AU8830) += snd-seq-midi.o snd-seq.o snd-seq-device.o 
snd-seq-midi-event.o snd-seq-instr.o

export-objs  := seq_device.o seq.o seq_instr.o seq_midi_emul.o \
                seq_midi_event.o seq_virmidi.o
diff -ur alsa-driver-0.9.8/drivers/mpu401/Makefile
alsa-driver-0.9.8-patched/drivers/mpu401/Makefile
--- alsa-driver-0.9.8/drivers/mpu401/Makefile   Mon Jun  2 09:03:39 2003
+++ alsa-driver-0.9.8-patched/drivers/mpu401/Makefile   Tue Oct 21 
22:21:36 2003@@ -3,6 +3,10 @@
include $(TOPDIR)/toplevel.config
include $(TOPDIR)/Makefile.conf

+obj-$(CONFIG_SND_AU8810) += snd-mpu401-uart.o
+obj-$(CONFIG_SND_AU8820) += snd-mpu401-uart.o
+obj-$(CONFIG_SND_AU8830) += snd-mpu401-uart.o
+
export-objs  := mpu401_uart.o

TOPDIR = $(MAINSRCDIR)
diff -ur alsa-driver-0.9.8/pci/ac97/Makefile
alsa-driver-0.9.8-patched/pci/ac97/Makefile
--- alsa-driver-0.9.8/pci/ac97/Makefile Sun Feb  9 13:35:57 2003
+++ alsa-driver-0.9.8-patched/pci/ac97/Makefile Tue Oct 21 22:21:49 2003 
@@ -3,6 +3,10 @@
include $(TOPDIR)/toplevel.config
include $(TOPDIR)/Makefile.conf

+obj-$(CONFIG_SND_AU8810) += snd-ac97-codec.o
+obj-$(CONFIG_SND_AU8820) += snd-ac97-codec.o
+obj-$(CONFIG_SND_AU8830) += snd-ac97-codec.o
+
export-objs  := ac97_codec.o ak4531_codec.o

TOPDIR = $(MAINSRCDIR)
--------------- END PATCH -----------------------




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
