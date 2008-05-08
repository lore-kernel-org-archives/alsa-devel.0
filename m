From: Stas Sergeev <stsp@aknet.ru>
Subject: [patch] snd-pcsp: relax dependancy on CONFIG_INPUT
Date: Thu, 08 May 2008 21:31:57 +0400
Message-ID: <4823390D.8010000@aknet.ru>
References: <482316B8.5080200@aknet.ru> <s5h4p98yfof.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060608060607060409070903"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id B312E24788
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 19:31:59 +0200 (CEST)
In-Reply-To: <s5h4p98yfof.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060608060607060409070903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello.

The attached patch makes an input
driver part of snd-pcsp optional.

Would it be possible to apply that?

--------------060608060607060409070903
Content-Type: text/x-patch;
 name="pcsp_inp.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcsp_inp.diff"

# HG changeset patch
# User Stas Sergeev <stsp@users.sourceforge.net>
# Date 1210267204 -14400
# Node ID 5c3c0b965df21ac55112f907be0786dfa90b9dc6
# Parent  25a20d46d89a57c89e911452171af7e4cdcc8464
snd-pcsp: relax dependancy on CONFIG_INPUT by adding CONFIG_SND_PCSP_INPUT

Signed-off-by: Stas Sergeev <stsp@aknet.ru>

diff -r 25a20d46d89a -r 5c3c0b965df2 drivers/Kconfig
--- a/drivers/Kconfig	Mon May 05 14:16:12 2008 +0200
+++ b/drivers/Kconfig	Thu May 08 21:20:04 2008 +0400
@@ -5,16 +5,14 @@ menu "Generic devices"
 
 
 config SND_PCSP
-	tristate "Internal PC speaker support"
+	tristate "PC-Speaker support"
 	depends on X86_PC && HIGH_RES_TIMERS
-	depends on INPUT
 	depends on SND
 	select SND_PCM
 	help
 	  If you don't have a sound card in your computer, you can include a
 	  driver for the PC speaker which allows it to act like a primitive
 	  sound card.
-	  This driver also replaces the pcspkr driver for beeps.
 
 	  You can compile this as a module which will be called snd-pcsp.
 
@@ -23,6 +21,17 @@ config SND_PCSP
 	  in your PC instead of the real speaker.
 
 	  It should not hurt to say Y or M here in all other cases.
+
+config SND_PCSP_INPUT
+	bool "PC-Speaker input events (beeps) support"
+	depends on INPUT
+	depends on SND_PCSP
+	default y
+	help
+	  This option enables the PC-Speaker system beeps.
+	  This is an alternative to the pcspkr input driver (INPUT_PCSPKR).
+	  It provides the ability to enable/disable the system
+	  beeps with the sound mixer.
 
 config SND_MPU401_UART
         tristate
diff -r 25a20d46d89a -r 5c3c0b965df2 drivers/pcsp/Makefile
--- a/drivers/pcsp/Makefile	Mon May 05 14:16:12 2008 +0200
+++ b/drivers/pcsp/Makefile	Thu May 08 21:20:04 2008 +0400
@@ -1,2 +1,3 @@ snd-pcsp-objs := pcsp.o pcsp_lib.o pcsp_
-snd-pcsp-objs := pcsp.o pcsp_lib.o pcsp_mixer.o pcsp_input.o
+snd-pcsp-y := pcsp.o pcsp_lib.o pcsp_mixer.o
+snd-pcsp-$(CONFIG_SND_PCSP_INPUT) += pcsp_input.o
 obj-$(CONFIG_SND_PCSP) += snd-pcsp.o
diff -r 25a20d46d89a -r 5c3c0b965df2 drivers/pcsp/pcsp.c
--- a/drivers/pcsp/pcsp.c	Mon May 05 14:16:12 2008 +0200
+++ b/drivers/pcsp/pcsp.c	Thu May 08 21:20:04 2008 +0400
@@ -188,10 +188,12 @@ static int __devexit pcsp_remove(struct 
 
 static void pcsp_stop_beep(struct snd_pcsp *chip)
 {
+#ifdef CONFIG_SND_PCSP_INPUT
 	spin_lock_irq(&chip->substream_lock);
 	if (!chip->playback_substream)
 		pcspkr_stop_sound();
 	spin_unlock_irq(&chip->substream_lock);
+#endif	/* CONFIG_SND_PCSP_INPUT */
 }
 
 #ifdef CONFIG_PM
diff -r 25a20d46d89a -r 5c3c0b965df2 drivers/pcsp/pcsp_input.h
--- a/drivers/pcsp/pcsp_input.h	Mon May 05 14:16:12 2008 +0200
+++ b/drivers/pcsp/pcsp_input.h	Thu May 08 21:20:04 2008 +0400
@@ -7,8 +7,15 @@
 #ifndef __PCSP_INPUT_H__
 #define __PCSP_INPUT_H__
 
+#ifdef CONFIG_SND_PCSP_INPUT
 int __devinit pcspkr_input_init(struct input_dev **rdev, struct device *dev);
 int pcspkr_input_remove(struct input_dev *dev);
 void pcspkr_stop_sound(void);
+#else
+static inline int pcspkr_input_init(struct input_dev **rdev,
+	struct device *dev) { return 0; }
+static inline int pcspkr_input_remove(struct input_dev *dev) { return 0; }
+static inline void pcspkr_stop_sound(void) { }
+#endif	/* CONFIG_SND_PCSP_INPUT */
 
 #endif
diff -r 25a20d46d89a -r 5c3c0b965df2 drivers/pcsp/pcsp_mixer.c
--- a/drivers/pcsp/pcsp_mixer.c	Mon May 05 14:16:12 2008 +0200
+++ b/drivers/pcsp/pcsp_mixer.c	Thu May 08 21:20:04 2008 +0400
@@ -78,6 +78,7 @@ static int pcsp_treble_put(struct snd_kc
 	return changed;
 }
 
+#ifdef CONFIG_SND_PCSP_INPUT
 static int pcsp_pcspkr_info(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_info *uinfo)
 {
@@ -108,6 +109,7 @@ static int pcsp_pcspkr_put(struct snd_kc
 	}
 	return changed;
 }
+#endif	/* CONFIG_SND_PCSP_INPUT */
 
 #define PCSP_MIXER_CONTROL(ctl_type, ctl_name) \
 { \
@@ -121,7 +123,9 @@ static struct snd_kcontrol_new __devinit
 static struct snd_kcontrol_new __devinitdata snd_pcsp_controls[] = {
 	PCSP_MIXER_CONTROL(enable, "Master Playback Switch"),
 	PCSP_MIXER_CONTROL(treble, "BaseFRQ Playback Volume"),
+#ifdef CONFIG_SND_PCSP_INPUT
 	PCSP_MIXER_CONTROL(pcspkr, "PC Speaker Playback Switch"),
+#endif	/* CONFIG_SND_PCSP_INPUT */
 };
 
 int __devinit snd_pcsp_new_mixer(struct snd_pcsp *chip)

--------------060608060607060409070903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060608060607060409070903--
