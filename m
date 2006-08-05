From: Giorgio Padrin <giorgio@mandarinlogiq.org>
Subject: [PATCH] uda1380
Date: Sat, 5 Aug 2006 20:10:10 +0200
Message-ID: <200608052010.11033.giorgio@mandarinlogiq.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_D8N1EwHVbkY3LMw"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_D8N1EwHVbkY3LMw
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This is a patch updating the uda1380 code in alsa-driver.

Log: Fix recording, primarily.

Giorgio

--Boundary-00=_D8N1EwHVbkY3LMw
Content-Type: text/x-diff;
  charset="utf-8";
  name="uda1380-20060805.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uda1380-20060805.patch"

diff -up a/i2c/Kconfig b/i2c/Kconfig
--- a/i2c/Kconfig	2006-08-05 17:49:18.000000000 +0200
+++ b/i2c/Kconfig	2006-08-05 18:17:17.000000000 +0200
@@ -1,11 +1,3 @@
-menu "Codecs on the I2C bus"
-	depends on SND && I2C
-
 config SND_UDA1380
-	tristate "Codec Philips UDA1380"
 	depends on SND && I2C
-	help
-	  Support for codec Philips UDA1380 on the I2C bus.
-	  Automatically selected by glue code.
-
-endmenu
\ No newline at end of file
+	tristate
diff -up a/i2c/uda1380.c b/i2c/uda1380.c
--- a/i2c/uda1380.c	2006-08-05 17:48:24.000000000 +0200
+++ b/i2c/uda1380.c	2006-05-05 09:54:28.000000000 +0200
@@ -27,13 +27,14 @@
 
 #include <asm/byteorder.h>
 
-#include "uda1380.h"
+#include <sound/uda1380.h>
 
 /* begin {{ I2C }} */
 
 static struct i2c_driver snd_uda1380_i2c_driver = {
-	.owner          = THIS_MODULE,
-	.name		= "uda1380-i2c"
+	.driver = {
+		.name = "uda1380-i2c"
+	},
 };
 
 static int snd_uda1380_i2c_init(void)
@@ -49,7 +50,7 @@ static void snd_uda1380_i2c_free(void)
 static inline int snd_uda1380_i2c_probe(struct snd_uda1380 *uda)
 {
 	if (uda->i2c_client.adapter == NULL ||
-	    (uda->i2c_client.addr & 0xfc) != 0x18) return -EINVAL;
+	    (uda->i2c_client.addr & 0xfd) != 0x18) return -EINVAL;
 	if (i2c_smbus_xfer(uda->i2c_client.adapter, uda->i2c_client.addr,
 			   0, 0, 0, I2C_SMBUS_QUICK, NULL) < 0)
 		return -ENODEV;
@@ -255,7 +256,7 @@ static int snd_uda1380_actl_reg_elem_int
 					      struct snd_ctl_elem_info *uinfo)
 {
 	struct snd_uda1380_uctl_reg_elem_int *uctl =
-		(struct snd_uda1380_actl_reg_elem_int *) kcontrol->private_value;
+		(struct snd_uda1380_uctl_reg_elem_int *) kcontrol->private_value;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = uctl->is_stereo ? 2 : 1;
@@ -313,7 +314,8 @@ static int snd_uda1380_actl_reg_elem_int
 	}
 
 	snd_uda1380_lock(uda);
-	uda->regs[uctl->reg] = WRITE_MASK(uda->regs[uctl->reg], val, uctl->mask << uctl->shift);
+	uda->regs[uctl->reg] = WRITE_MASK(uda->regs[uctl->reg],
+					  val << uctl->shift, uctl->mask << uctl->shift);
 
 	snd_uda1380_cache_dirty(uda, uctl->reg);
 	snd_uda1380_unlock(uda);
@@ -345,8 +347,8 @@ ACTL_REG_ELEM_INT(deemphasis, "De-Emphas
 ACTL_REG_ELEM_INT(tone_ctl_strength, "Tone Control - Strength", 0x12, 14, 0x0003, 0, 0)
 ACTL_REG_ELEM_INT_STEREO(tone_ctl_treble, "Tone Control - Treble", 0x12, 4, 0x0303, 0, 0)
 ACTL_REG_ELEM_INT_STEREO(tone_ctl_bass, "Tone Control - Bass", 0x12, 0, 0x0f0f, 0, 0)
-ACTL_REG_ELEM_INT(mic_gain, "Mic Capture Gain", 0x22, 8, 0x000f, 0, 0)
-ACTL_REG_ELEM_INT_STEREO(line_in_gain, "Line Capture Gain", 0x21, 0, 0x0f0f, 0, 0)
+ACTL_REG_ELEM_INT(mic_gain, "Mic Capture Volume", 0x22, 8, 0x000f, 0, 0)
+ACTL_REG_ELEM_INT_STEREO(line_in_gain, "Line Capture Volume", 0x21, 0, 0x0f0f, 0, 0)
 ACTL_REG_ELEM_INT_STEREO(capture_volume, "Capture Volume", 0x20, 0, 0xffff, 0, 1)
 
 struct snd_uda1380_uctl_bool {
@@ -447,11 +449,9 @@ static int snd_uda1380_uctl_agc_get(stru
 static int snd_uda1380_uctl_agc_set (struct snd_uda1380 *uda, int on)
 {
 	snd_uda1380_lock(uda);
-	uda->regs[0x22] = WRITE_MASK(uda->regs[0x22],
-				     ~on ? R22_SKIP_DCFIL: 0x0000, R22_SKIP_DCFIL);
 	uda->regs[0x23] = WRITE_MASK(uda->regs[0x23],
 				     on ? R23_AGC_EN : 0x0000, R23_AGC_EN);
-	snd_uda1380_cache_dirty_zone(uda, 0x22, 2);
+	snd_uda1380_cache_dirty_zone(uda, 0x23, 1);
 	snd_uda1380_unlock(uda);
 	return 0;
 }
@@ -508,13 +508,12 @@ static int snd_uda1380_uctl_select_captu
 						     R22_SEL_LNA | R22_SEL_MIC);
 			snd_uda1380_hwsync_write(uda, 0x22, 1);
 			uda->regs[0x02] = WRITE_MASK(uda->regs[0x02],
-						     0x0000,
-						     R02_PON_PGAL | R02_PON_PGAR | R02_PON_ADCR);
+						     0x0000, R02_PON_PGAL | R02_PON_PGAR);
 			snd_uda1380_hwsync_write(uda, 0x02, 1);
 		} else {
 			uda->regs[0x02] = WRITE_MASK(uda->regs[0x02],
-						     R02_PON_PGAL | R02_PON_PGAR | R02_PON_ADCR,
-						     R02_PON_PGAL | R02_PON_PGAR | R02_PON_ADCR);
+						     R02_PON_PGAL | R02_PON_PGAR,
+						     R02_PON_PGAL | R02_PON_PGAR);
 			snd_uda1380_hwsync_write(uda, 0x02, 1);
 			uda->regs[0x22] = WRITE_MASK(uda->regs[0x22],
 						     0x0000,
@@ -704,7 +703,7 @@ static int snd_uda1380_playback_off(stru
 	/* power-down */
 	uda->playback_clock_on = 0;
 	uda->regs[0x00] = WRITE_MASK(uda->regs[0x00], 0x0000, R00_EN_DAC | R00_EN_INT);
-	uda->regs[0x02] = WRITE_MASK(uda->regs[0x02], 0x0000, R02_PON_HP |R02_PON_DAC);
+	uda->regs[0x02] = WRITE_MASK(uda->regs[0x02], 0x0000, R02_PON_HP | R02_PON_DAC);
 	snd_uda1380_hwsync_write(uda, 0x00, 3);
 
 	return 0;
@@ -724,13 +723,13 @@ static int snd_uda1380_capture_on(struct
 
 	snd_uda1380_cache_try_flush(uda);
 
-	val = R02_PON_BIAS | R02_PON_ADCL;
-	val |= (uda->regs[0x22] == R22_SEL_MIC) ?
+	val = R02_PON_ADCL | R02_PON_ADCR;
+	val |= (uda->regs[0x22] & R22_SEL_MIC) ?
 	       R02_PON_LNA :
-	       R02_PON_PGAL | R02_PON_PGAR | R02_PON_ADCR;
+	       R02_PON_PGAL | R02_PON_PGAR;
 	uda->regs[0x02] = WRITE_MASK(uda->regs[0x02],
-				     val, R02_PON_BIAS | R02_PON_ADCL | R02_PON_LNA |
-					  R02_PON_PGAL | R02_PON_PGAR | R02_PON_ADCR);
+				     val, R02_PON_ADCL | R02_PON_ADCR |
+					  R02_PON_LNA | R02_PON_PGAL | R02_PON_PGAR);
 	snd_uda1380_hwsync_write(uda, 0x02, 1);
 
 	/* notify input sources */
@@ -751,8 +750,6 @@ static int snd_uda1380_capture_on(struct
 
 static int snd_uda1380_capture_off(struct snd_uda1380 *uda)
 {
-	unsigned int val;
-
 	if (!uda->capture_on) return 0;
 
 	uda->capture_on = 0;
@@ -770,13 +767,10 @@ static int snd_uda1380_capture_off(struc
 
 	/* power-down */
 	uda->capture_clock_on = 0;
-	uda->regs[0x00] = WRITE_MASK(uda->regs[0x00],
-				     0x0000, R00_EN_ADC | R00_EN_DEC);
-	val = 0x0000;
-	val |= uda->playback_on ? R02_PON_BIAS : 0x0000;
+	uda->regs[0x00] = WRITE_MASK(uda->regs[0x00], 0x0000, R00_EN_ADC | R00_EN_DEC);
 	uda->regs[0x02] = WRITE_MASK(uda->regs[0x02],
-				     val, R02_PON_BIAS | R02_PON_ADCL | R02_PON_LNA |
-					  R02_PON_PGAL | R02_PON_PGAR | R02_PON_ADCR);
+				     0x0000, R02_PON_ADCL | R02_PON_ADCR |
+				     R02_PON_LNA | R02_PON_PGAL | R02_PON_PGAR);
 	snd_uda1380_hwsync_write(uda, 0x00, 3);
 
 	return 0;
@@ -822,8 +816,9 @@ static int snd_uda1380_init_regs(struct 
 		uda->regs[0x22] = WRITE_MASK(uda->regs[0x22],
 					     R22_SEL_LNA | R22_SEL_MIC,
 					     R22_SEL_LNA | R22_SEL_MIC);
-		snd_uda1380_hwsync_write(uda, 0x22, 1);
 	}
+	uda->regs[0x22] = WRITE_MASK(uda->regs[0x22], 0x0000, R22_SKIP_DCFIL);
+	snd_uda1380_hwsync_write(uda, 0x22, 1);
 
 	uda->regs[0x00] = WRITE_MASK(uda->regs[0x00],
 				     0x0000, R00_EN_DEC | R00_EN_INT);
diff -up a/include/uda1380.h b/include/uda1380.h
--- a/include/uda1380.h	2006-08-05 17:50:49.000000000 +0200
+++ b/include/uda1380.h	2006-04-14 15:22:17.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * Audio support for Philips UDA1380
+ * Audio support for codec Philips UDA1380
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -8,10 +8,15 @@
  * Copyright (c) 2005 Giorgio Padrin <giorgio@mandarinlogiq.org>
  */
 
+#ifndef __SOUND_UDA1380_H
+#define __SOUND_UDA1380_H
+
 #include <linux/i2c.h>
 
-enum snd_uda1380_capture_source
-	{ SND_UDA1380_CAP_SOURCE_LINE_IN, SND_UDA1380_CAP_SOURCE_MIC };
+enum snd_uda1380_capture_source {
+	SND_UDA1380_CAP_SOURCE_LINE_IN,
+	SND_UDA1380_CAP_SOURCE_MIC
+};
 
 struct snd_uda1380 {
 	struct semaphore sem;
@@ -67,7 +72,7 @@ struct snd_uda1380 {
 int snd_uda1380_activate(struct snd_uda1380 *uda);
 
 void snd_uda1380_deactivate(struct snd_uda1380 *uda);
-int snd_uda1380_add_mixer_controls(struct snd_uda1380 *uda, snd_card_t *card);
+int snd_uda1380_add_mixer_controls(struct snd_uda1380 *uda, struct snd_card *card);
 int snd_uda1380_open_stream(struct snd_uda1380 *uda, int stream);
 int snd_uda1380_close_stream(struct snd_uda1380 *uda, int stream);
 int snd_uda1380_suspend(struct snd_uda1380 *uda, pm_message_t state);
@@ -75,3 +80,5 @@ int snd_uda1380_resume(struct snd_uda138
 
 void snd_uda1380_hp_connected(struct snd_uda1380 *uda, int connected); /* non atomic context */
 void snd_uda1380_hp_detected(struct snd_uda1380 *uda, int detected); /* atomic context */
+
+#endif /* __SOUND_UDA1380_H */

--Boundary-00=_D8N1EwHVbkY3LMw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_D8N1EwHVbkY3LMw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_D8N1EwHVbkY3LMw--
