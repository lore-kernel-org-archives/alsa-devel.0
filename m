From: Pavel Roskin <proski@gnu.org>
Subject: Re: integration of via668 and via8233 drivers
Date: Thu, 5 Sep 2002 09:33:14 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209050928470.1857-100000@portland.hansa.lan>
References: <s5hheh46d3g.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hheh46d3g.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

> please rebuild the driver with cvscompile script.
> you need to regenerate acinclude.m4 etc.

It was a clean build.  The patch (tested) is attached.  Unfortunately, the 
sound is still helicopter-like, but it's another problem.  Tested on this 
device:

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 
Audio Controller (rev 20)
        Subsystem: Unknown device 5860:11d4
        Flags: medium devsel, IRQ 10
        I/O ports at cc00 [size=256]
        I/O ports at d000 [size=4]
        I/O ports at d400 [size=4]
        Capabilities: [c0] Power Management version 2

====================== cut here ====================
Index: alsa-kernel/core/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/Makefile,v
retrieving revision 1.28
diff -u -r1.28 Makefile
--- alsa-kernel/core/Makefile	26 Aug 2002 16:05:37 -0000	1.28
+++ alsa-kernel/core/Makefile	5 Sep 2002 13:15:06 -0000
@@ -78,8 +78,7 @@
 obj-$(CONFIG_SND_RME32) += snd-pcm.o snd-timer.o snd.o
 obj-$(CONFIG_SND_RME96) += snd-pcm.o snd-timer.o snd.o
 obj-$(CONFIG_SND_SONICVIBES) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_VIA686) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_VIA8233) += snd-pcm.o snd-timer.o snd.o
+obj-$(CONFIG_SND_VIA82XX) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o
 obj-$(CONFIG_SND_ALI5451) += snd.o snd-rawmidi.o snd-timer.o snd-pcm.o
 obj-$(CONFIG_SND_CS46XX) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o
 obj-$(CONFIG_SND_EMU10K1) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
Index: alsa-kernel/core/seq/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/Makefile,v
retrieving revision 1.20
diff -u -r1.20 Makefile
--- alsa-kernel/core/seq/Makefile	26 Aug 2002 16:05:37 -0000	1.20
+++ alsa-kernel/core/seq/Makefile	5 Sep 2002 13:15:06 -0000
@@ -67,7 +67,7 @@
 obj-$(CONFIG_SND_ICE1712) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
 obj-$(CONFIG_SND_INTEL8X0) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
 obj-$(CONFIG_SND_SONICVIBES) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o snd-seq-midi-emul.o snd-seq-instr.o
-obj-$(CONFIG_SND_VIA686) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
+obj-$(CONFIG_SND_VIA82XX) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
 obj-$(CONFIG_SND_ALI5451) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
 obj-$(CONFIG_SND_CS46XX) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
 obj-$(CONFIG_SND_EMU10K1) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o snd-seq-midi-emul.o snd-seq-virmidi.o
Index: alsa-kernel/drivers/mpu401/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/drivers/mpu401/Makefile,v
retrieving revision 1.9
diff -u -r1.9 Makefile
--- alsa-kernel/drivers/mpu401/Makefile	24 Jul 2002 10:41:19 -0000	1.9
+++ alsa-kernel/drivers/mpu401/Makefile	5 Sep 2002 13:15:06 -0000
@@ -35,7 +35,7 @@
 obj-$(CONFIG_SND_ICE1712) += snd-mpu401-uart.o
 obj-$(CONFIG_SND_INTEL8X0) += snd-mpu401-uart.o
 obj-$(CONFIG_SND_SONICVIBES) += snd-mpu401-uart.o
-obj-$(CONFIG_SND_VIA686) += snd-mpu401-uart.o
+obj-$(CONFIG_SND_VIA82XX) += snd-mpu401-uart.o
 obj-$(CONFIG_SND_ALI5451) += snd-mpu401-uart.o
 obj-$(CONFIG_SND_TRIDENT) += snd-mpu401-uart.o
 obj-$(CONFIG_SND_YMFPCI) += snd-mpu401-uart.o
Index: alsa-kernel/pci/ac97/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/Makefile,v
retrieving revision 1.7
diff -u -r1.7 Makefile
--- alsa-kernel/pci/ac97/Makefile	17 Jul 2002 10:56:41 -0000	1.7
+++ alsa-kernel/pci/ac97/Makefile	5 Sep 2002 13:15:06 -0000
@@ -17,8 +17,7 @@
 obj-$(CONFIG_SND_ICE1712) += snd-ac97-codec.o
 obj-$(CONFIG_SND_INTEL8X0) += snd-ac97-codec.o
 obj-$(CONFIG_SND_MAESTRO3) += snd-ac97-codec.o
-obj-$(CONFIG_SND_VIA686) += snd-ac97-codec.o
-obj-$(CONFIG_SND_VIA8233) += snd-ac97-codec.o
+obj-$(CONFIG_SND_VIA82XX) += snd-ac97-codec.o
 obj-$(CONFIG_SND_ALI5451) += snd-ac97-codec.o
 obj-$(CONFIG_SND_CS46XX) += snd-ac97-codec.o
 obj-$(CONFIG_SND_EMU10K1) += snd-ac97-codec.o
====================== cut here ====================

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
