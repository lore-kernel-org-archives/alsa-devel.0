From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: [PATCH] 5/5 Clean up Linux 2.6.4-rc1 sound/core/Makefile
Date: Mon, 1 Mar 2004 14:46:29 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040301144629.H24955@flint.arm.linux.org.uk>
References: <no.id>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040301144545.G24955@flint.arm.linux.org.uk>; from rmk+alsa@arm.linux.org.uk on Mon, Mar 01, 2004 at 02:40:19PM +0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

This is part of a patch series to clean up sound/core/Makefile in Linux
2.6.4-rc1.

- Add SND_TIMER for drivers which use the snd-timer module.
- Remove snd-timer from these drivers entries in sound/core/Makefile,
  removing any sound/core/Makefile entries which are left empty.
- Since the "top level module dependency" lists are now gone, remove
  the comment.
- Also, since we only mention objects once, remove the sorting of obj-m

--- orig/sound/core/Makefile	Mon Mar  1 12:16:54 2004
+++ linux/sound/core/Makefile	Mon Mar  1 12:16:33 2004
@@ -35,11 +35,3 @@ obj-$(CONFIG_SND_SEQUENCER) += snd-timer
 obj-$(CONFIG_SND_OSSEMUL)	+= oss/
 obj-$(CONFIG_SND_SEQUENCER)	+= seq/
 obj-$(CONFIG_SND_BIT32_EMUL) += ioctl32/
-
-# Toplevel Module Dependency
-obj-$(CONFIG_SND_VIRMIDI) += snd-timer.o
-obj-$(CONFIG_SND_SERIAL_U16550) += snd-timer.o
-obj-$(CONFIG_SND_MTPAV) += snd-timer.o
-obj-$(CONFIG_SND_MPU401) += snd-timer.o
-
-obj-m := $(sort $(obj-m))
--- orig/sound/drivers/Kconfig	Mon Mar  1 12:16:52 2004
+++ linux/sound/drivers/Kconfig	Mon Mar  1 12:14:18 2004
@@ -15,6 +15,7 @@ config SND_DUMMY
 config SND_VIRMIDI
 	tristate "Virtual MIDI soundcard"
 	depends on SND_SEQUENCER
+	select SND_TIMER
 	select SND_RAWMIDI
 	help
 	  Say 'Y' or 'M' to include virtual MIDI driver. This driver allows to
@@ -23,6 +24,7 @@ config SND_VIRMIDI
 config SND_MTPAV
 	tristate "MOTU MidiTimePiece AV multiport MIDI"
 	depends on SND
+	select SND_TIMER
 	select SND_RAWMIDI
 	help
 	  Say 'Y' or 'M' to include support for MOTU MidiTimePiece AV multiport
@@ -31,6 +33,7 @@ config SND_MTPAV
 config SND_SERIAL_U16550
 	tristate "UART16550 - MIDI only driver"
 	depends on SND
+	select SND_TIMER
 	select SND_RAWMIDI
 	help
 	  Say 'Y' or 'M' to include support for MIDI serial port driver. It works
@@ -39,6 +42,7 @@ config SND_SERIAL_U16550
 config SND_MPU401
 	tristate "Generic MPU-401 UART driver"
 	depends on SND
+	select SND_TIMER
 	select SND_RAWMIDI
 	help
 	  Say 'Y' or 'M' to include support for MPU401 hardware using UART access.


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
