From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: [PATCH] 1/5 Clean up Linux 2.6.4-rc1 sound/core/Makefile
Date: Mon, 1 Mar 2004 14:42:31 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040301144231.D24955@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

- Add SND_TIMER, SND_PCM, SND_HWDEP and SND_RAWMIDI configuration symbols.
  These symbols select which modules in sound/core get built, building
  snd-timer, snd-pcm, snd-hwdep and snd-rawmidi respectively.

- Add reverse dependencies ("select") to select these symbols for core
  components where necessary.

- Hide SND_OSSEMUL - we can select this when SND_MIXER_OSS, SND_PCM_OSS
  or SND_SEQUENCER_OSS are selected automatically.

- Tweak Makefile to use these new symbols to build these modules.

- Since we now build appropriate modules for core components according
  to the new configuration symbols, (eg, snd-timer if SND_SEQUENCER is
  selected) we can delete these duplications.

I'm going to explicitly mention SND_RTCTIMER here, since it appeared to
have some complex handling in the makefile.  As the Kconfig definition
for this symbol stands, SND_RTCTIMER can only be selected to 'm' if
RTC is 'm' or 'y', and 'y' if RTC is 'y'.  This means that the ifeq and
subst in the makefile isn't gaining us anything, so we might as well
do away with it.

--- orig/sound/core/Kconfig	Sat Jun 14 22:35:04 2003
+++ linux/sound/core/Kconfig	Mon Mar  1 09:37:44 2004
@@ -3,9 +3,23 @@ config SND_BIT32_EMUL
 	tristate "Emulation for 32-bit applications"
 	depends on SND && (SPARC64 || PPC64 || X86_64 && IA32_EMULATION)
 
+config SND_TIMER
+	tristate
+
+config SND_PCM
+	tristate
+	select SND_TIMER
+
+config SND_HWDEP
+	tristate
+
+config SND_RAWMIDI
+	tristate
+
 config SND_SEQUENCER
 	tristate "Sequencer support"
 	depends on SND
+	select SND_TIMER
	help
	  Say 'Y' or 'M' to enable MIDI sequencer and router support. This feature
	  allows routing and enqueing MIDI events. Events can be processed at given
@@ -20,26 +34,27 @@ config SND_SEQ_DUMMY
 	  immediately.
 
 config SND_OSSEMUL
-	bool "OSS API emulation"
-	depends on SND
-	help
-	  Say 'Y' to enable OSS (Open Sound System) API emulation code.
+	bool
 
 config SND_MIXER_OSS
 	tristate "OSS Mixer API"
-	depends on SND_OSSEMUL && SND
+	depends on SND
+	select SND_OSSEMUL
 	help
 	  Say 'Y' or 'M' to enable mixer OSS API emulation (/dev/mixer*).
 
 config SND_PCM_OSS
 	tristate "OSS PCM (digital audio) API"
-	depends on SND_OSSEMUL && SND
+	depends on SND
+	select SND_OSSEMUL
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to enable digital audio (PCM) OSS API emulation (/dev/dsp*).
 
 config SND_SEQUENCER_OSS
 	bool "OSS Sequencer API"
-	depends on SND_OSSEMUL && SND_SEQUENCER
+	depends on SND_SEQUENCER
+	select SND_OSSEMUL
 	help
 	  Say 'Y' to enable OSS sequencer emulation (both /dev/sequencer and
 	  /dev/music interfaces).
@@ -47,6 +62,7 @@ config SND_SEQUENCER_OSS
 config SND_RTCTIMER
 	tristate "RTC Timer support"
 	depends on SND && RTC
+	select SND_TIMER
 	help
 	  Say 'Y' or 'M' to enable RTC timer support for ALSA. ALSA code uses RTC
 	  timer as precise timing source and maps the RTC timer to the ALSA's timer
--- orig/sound/core/Makefile	Sun Feb 29 22:53:00 2004
+++ linux/sound/core/Makefile	Mon Mar  1 09:39:48 2004
@@ -26,15 +26,14 @@ ifeq ($(subst m,y,$(CONFIG_RTC)),y)
 snd-hwdep-objs    := hwdep.o
 
 obj-$(CONFIG_SND) += snd.o
-ifeq ($(subst m,y,$(CONFIG_RTC)),y)
-  obj-$(CONFIG_SND_RTCTIMER) += snd-timer.o
-  obj-$(CONFIG_SND_RTCTIMER) += snd-rtctimer.o
-endif
-obj-$(CONFIG_SND_HWDEP) += snd-hwdep.o
+obj-$(CONFIG_SND_HWDEP)		+= snd-hwdep.o
+obj-$(CONFIG_SND_TIMER)		+= snd-timer.o
+obj-$(CONFIG_SND_RTCTIMER)	+= snd-rtctimer.o
+obj-$(CONFIG_SND_PCM)		+= snd-pcm.o snd-page-alloc.o
+obj-$(CONFIG_SND_RAWMIDI)	+= snd-rawmidi.o
 
-obj-$(CONFIG_SND_MIXER_OSS) += oss/
-obj-$(CONFIG_SND_PCM_OSS) += snd-pcm.o snd-timer.o snd-page-alloc.o oss/
-obj-$(CONFIG_SND_SEQUENCER) += snd-timer.o seq/
+obj-$(CONFIG_SND_OSSEMUL)	+= oss/
+obj-$(CONFIG_SND_SEQUENCER)	+= seq/
 obj-$(CONFIG_SND_BIT32_EMUL) += ioctl32/
 
 # Toplevel Module Dependency


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
