From: Chris Rankin <rankincj@yahoo.com>
Subject: [PATCH] First updates to SoundScape driver
Date: Tue, 24 Sep 2002 23:33:23 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209242233.g8OMXOYF004032@wittsend.radionet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: perex@perex.cz, tiwia@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

OK, here's the first attempt to resolve some of those FIXMEs:

- Remove dependency on OSS emulation (trivial)
- Use udelay() in busy-waiting loops, remove HZ references
- Fix breakage in MIDI mixer control
- Minor whitespace issues

I have compiled the driver (hand-patching the Makefiles to get the correct sub-modules built), installed it, successfully uploaded the firmware, and then played MIDI files and WAV files through the SoundScape.

For the record:

snd-pcm-oss            36548   0  (autoclean)
snd-mixer-oss          10240   0  (autoclean) [snd-pcm-oss]
snd-seq-midi            3232   0  (autoclean)
snd-seq-midi-event      3144   0  (autoclean) [snd-seq-midi]
snd-seq                34668   0  (autoclean) [snd-seq-midi snd-seq-midi-event]
snd-sscape              6304   0  (autoclean)
snd-cs4231-lib         13248   0  (autoclean) [snd-sscape]
snd-pcm                54880   0  (autoclean) [snd-pcm-oss snd-cs4231-lib]
snd-timer               9696   0  (autoclean) [snd-seq snd-cs4231-lib snd-pcm]
snd-hwdep               3360   0  (autoclean) [snd-sscape]
snd-mpu401-uart         2704   0  (autoclean) [snd-sscape]
snd-rawmidi            11968   0  (autoclean) [snd-seq-midi snd-mpu401-uart]
snd-seq-device          3744   0  (autoclean) [snd-seq-midi snd-seq snd-rawmidi]snd                    23816   0  (autoclean) [snd-pcm-oss snd-mixer-oss snd-seq-midi snd-seq-midi-event snd-seq snd-sscape snd-cs4231-lib snd-pcm snd-timer snd-hwdep snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3620   5  (autoclean) [snd]

Chris


Index: sscape.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/isa/sscape.c,v
retrieving revision 1.2
diff -u -u -r1.2 sscape.c
--- sscape.c	24 Sep 2002 06:30:16 -0000	1.2
+++ sscape.c	24 Sep 2002 22:23:07 -0000
@@ -7,7 +7,6 @@
  *
  *   FIXME (deadlock for alsa-kernel):
  *     - use ISA PnP scheme used by all ALSA ISA drivers
- *     - remove CONFIG_SND_OSSEMUL dependency
  *     - add non-MODULE build option
  *
  *
@@ -28,6 +27,7 @@
 
 #include <sound/driver.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <linux/isapnp.h>
 #include <linux/spinlock.h>
 #include <asm/dma.h>
@@ -42,10 +42,6 @@
 #define chip_t cs4231_t
 
 
-#ifndef CONFIG_SND_OSSEMUL
-#  error Need ALSA configuration!
-#endif
-
 EXPORT_NO_SYMBOLS;
 
 MODULE_AUTHOR("Chris Rankin");
@@ -262,8 +258,10 @@
 {
 	int data;
 
-	while (((data = host_read_unsafe(io_base)) < 0) && (timeout != 0))
+	while (((data = host_read_unsafe(io_base)) < 0) && (timeout != 0)) {
+		udelay(100);
 		--timeout;
+	} /* while */
 
 	return data;
 }
@@ -292,8 +290,10 @@
 {
 	int err;
 
-	while (!(err = host_write_unsafe(io_base, data)) && (timeout != 0))
+	while (!(err = host_write_unsafe(io_base, data)) && (timeout != 0)) {
+		udelay(100);
 		--timeout;
+	} /* while */
 
 	return err;
 }
@@ -369,8 +369,10 @@
  */
 static int sscape_wait_dma_unsafe(unsigned io_base, enum GA_REG reg, unsigned timeout)
 {
-	while (!(sscape_read_unsafe(io_base, reg) & 0x01) && (timeout != 0))
+	while (!(sscape_read_unsafe(io_base, reg) & 0x01) && (timeout != 0)) {
+		udelay(100);
 		--timeout;
+	} /* while */
 
 	return (sscape_read_unsafe(io_base, reg) & 0x01);
 }
@@ -397,7 +399,7 @@
 			return 1;
 
 		--timeout;
-	}			/* while */
+	} /* while */
 
 	return 0;
 }
@@ -424,7 +426,7 @@
 			return 1;
 
 		--timeout;
-	}			/* while */
+	} /* while */
 
 	return 0;
 }
@@ -479,7 +481,7 @@
 		size -= len;
 		snd_dma_program(s->chip->dma1, dma.addr, len, DMA_MODE_WRITE);
 		sscape_start_dma_unsafe(s->io_base, GA_DMAA_REG);
-		if (!sscape_wait_dma_unsafe(s->io_base, GA_DMAA_REG, 5000 * HZ)) {
+		if (!sscape_wait_dma_unsafe(s->io_base, GA_DMAA_REG, 5000)) {
 			/*
 			 * Don't forget to release this spinlock we're holding ...
 			 */
@@ -489,7 +491,7 @@
 			ret = -EAGAIN;
 			goto _release_dma;
 		}
-	}			/* while */
+	} /* while */
 
 	set_host_mode_unsafe(s->io_base);
 
@@ -505,10 +507,10 @@
 	 * give it 5 seconds (max) ...
 	 */
 	ret = 0;
-	if (!obp_startup_ack(s, 5 * HZ)) {
+	if (!obp_startup_ack(s, 5)) {
 		printk(KERN_ERR "sscape: No response from on-board processor after upload\n");
 		ret = -EAGAIN;
-	} else if (!host_startup_ack(s, 5 * HZ)) {
+	} else if (!host_startup_ack(s, 5)) {
 		printk(KERN_ERR "sscape: SoundScape failed to initialise\n");
 		ret = -EAGAIN;
 	}
@@ -542,7 +544,7 @@
 
 	spin_lock_irqsave(&sscape->lock, flags);
 	if (ret == 0) {
-		data = host_read_ctrl_unsafe(sscape->io_base, 100 * HZ);
+		data = host_read_ctrl_unsafe(sscape->io_base, 100);
 	}
 	set_midi_mode_unsafe(sscape->io_base);
 	spin_unlock_irqrestore(&sscape->lock, flags);
@@ -707,8 +709,8 @@
 	spin_lock_irqsave(&s->lock, flags);
 	set_host_mode_unsafe(s->io_base);
 
-	if (host_write_ctrl_unsafe(s->io_base, CMD_GET_MIDI_VOL, 100 * HZ)) {
-		uctl->value.integer.value[0] = host_read_ctrl_unsafe(s->io_base, 100 * HZ);
+	if (host_write_ctrl_unsafe(s->io_base, CMD_GET_MIDI_VOL, 100)) {
+		uctl->value.integer.value[0] = host_read_ctrl_unsafe(s->io_base, 100);
 	}
 
 	set_midi_mode_unsafe(s->io_base);
@@ -739,13 +741,13 @@
 	 * and then perform another volume-related command. Perhaps the
 	 * first command is an "open" and the second command is a "close"?
 	 */
-	if (s->midi_vol != ((unsigned char) uctl->value.integer. value[0] & 127)) {
+	if (s->midi_vol == ((unsigned char) uctl->value.integer. value[0] & 127)) {
 		change = 0;
 		goto __skip_change;
 	}
-	change = (host_write_ctrl_unsafe(s->io_base, CMD_SET_MIDI_VOL, 100 * HZ)
-		  && host_write_ctrl_unsafe(s->io_base, ((unsigned char) uctl->value.integer. value[0]) & 127, 100 * HZ)
-		  && host_write_ctrl_unsafe(s->io_base, CMD_XXX_MIDI_VOL, 100 * HZ));
+	change = (host_write_ctrl_unsafe(s->io_base, CMD_SET_MIDI_VOL, 100)
+	          && host_write_ctrl_unsafe(s->io_base, ((unsigned char) uctl->value.integer. value[0]) & 127, 100)
+	          && host_write_ctrl_unsafe(s->io_base, CMD_XXX_MIDI_VOL, 100));
       __skip_change:
 
 	/*
@@ -1209,9 +1211,9 @@
 	 * Initialize mixer
 	 */
 	sscape->midi_vol = 0;
-	host_write_ctrl_unsafe(sscape->io_base, CMD_SET_MIDI_VOL, 100 * HZ);
-	host_write_ctrl_unsafe(sscape->io_base, 0, 100 * HZ);
-	host_write_ctrl_unsafe(sscape->io_base, CMD_XXX_MIDI_VOL, 100 * HZ);
+	host_write_ctrl_unsafe(sscape->io_base, CMD_SET_MIDI_VOL, 100);
+	host_write_ctrl_unsafe(sscape->io_base, 0, 100);
+	host_write_ctrl_unsafe(sscape->io_base, CMD_XXX_MIDI_VOL, 100);
 
 
 	/*
@@ -1300,7 +1302,7 @@
 	while ((i < ARRAY_SIZE(sscape_card)) && sscape_card[i]) {
 		snd_card_free(sscape_card[i]);
 		++i;
-	}			/* while */
+	} /* while */
 }
 
 module_init(sscape_init);


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
