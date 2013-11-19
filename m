From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH 1/2] snd-oxygen: Changes for oxygen driver to
 fix the Xonar DG card
Date: Tue, 19 Nov 2013 18:26:17 +0400
Message-ID: <20131119182617.0bbae792@v1ron-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp29.i.mail.ru (smtp29.i.mail.ru [94.100.177.89])
 by alsa0.perex.cz (Postfix) with ESMTP id AB79F2619D5
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 15:26:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch does some preparation of existing Oxygen driver. Some constants added to the header files. To perform the SPI reading, there is a new function to wait when the SPI finishes a transaction. Channel routing must be updated when the user selects the audio output, and there are some extra symbols exported from the snd-oxygen-lib module.

Signed-off-by: Roman I Volkov <v1ron@mail.ru>
---
Should not affect other models of Oxygen driver, but who knows.
diff -uprN linux-3.12/sound/pci/oxygen/cs4245.h linux-3.12-my/sound/pci/oxygen/cs4245.h
--- linux-3.12/sound/pci/oxygen/cs4245.h	2013-11-04 03:41:51.000000000 +0400
+++ linux-3.12-my/sound/pci/oxygen/cs4245.h	2013-11-15 15:46:40.000000000 +0400
@@ -103,5 +103,6 @@
 #define CS4245_ADC_UNDRFL	0x01
 
 
-#define CS4245_SPI_ADDRESS	(0x9e << 16)
-#define CS4245_SPI_WRITE	(0 << 16)
+#define CS4245_SPI_ADDRESS	0x9e
+#define CS4245_SPI_WRITE	0
+#define CS4245_SPI_READ		1
diff -uprN linux-3.12/sound/pci/oxygen/oxygen.h linux-3.12-my/sound/pci/oxygen/oxygen.h
--- linux-3.12/sound/pci/oxygen/oxygen.h	2013-11-04 03:41:51.000000000 +0400
+++ linux-3.12-my/sound/pci/oxygen/oxygen.h	2013-11-15 15:47:38.000000000 +0400
@@ -198,7 +198,8 @@ void oxygen_write_ac97(struct oxygen *ch
 void oxygen_write_ac97_masked(struct oxygen *chip, unsigned int codec,
 			      unsigned int index, u16 data, u16 mask);
 
-void oxygen_write_spi(struct oxygen *chip, u8 control, unsigned int data);
+int oxygen_wait_spi(struct oxygen *chip);
+int oxygen_write_spi(struct oxygen *chip, u8 control, unsigned int data);
 void oxygen_write_i2c(struct oxygen *chip, u8 device, u8 map, u8 data);
 
 void oxygen_reset_uart(struct oxygen *chip);
diff -uprN linux-3.12/sound/pci/oxygen/oxygen_io.c linux-3.12-my/sound/pci/oxygen/oxygen_io.c
--- linux-3.12/sound/pci/oxygen/oxygen_io.c	2013-11-04 03:41:51.000000000 +0400
+++ linux-3.12-my/sound/pci/oxygen/oxygen_io.c	2013-11-19 00:56:12.000000000 +0400
@@ -105,8 +105,8 @@ static int oxygen_ac97_wait(struct oxyge
 	 * Reading the status register also clears the bits, so we have to save
 	 * the read bits in status.
 	 */
-	wait_event_timeout(chip->ac97_waitqueue,
-			   ({ status |= oxygen_read8(chip, OXYGEN_AC97_INTERRUPT_STATUS);
+	wait_event_timeout(chip->ac97_waitqueue, ({ status |= oxygen_read8(chip,
+					OXYGEN_AC97_INTERRUPT_STATUS);
 			      status & mask; }),
 			   msecs_to_jiffies(1) + 1);
 	/*
@@ -194,23 +194,35 @@ void oxygen_write_ac97_masked(struct oxy
 }
 EXPORT_SYMBOL(oxygen_write_ac97_masked);
 
-void oxygen_write_spi(struct oxygen *chip, u8 control, unsigned int data)
+int oxygen_wait_spi(struct oxygen *chip)
 {
-	unsigned int count;
+	/* Higher interval to be sure - 100 microseconds */
+	unsigned int count = 100;
 
-	/* should not need more than 30.72 us (24 * 1.28 us) */
-	count = 10;
-	while ((oxygen_read8(chip, OXYGEN_SPI_CONTROL) & OXYGEN_SPI_BUSY)
-	       && count > 0) {
-		udelay(4);
-		--count;
+	for (;;) {
+		if ((oxygen_read8(chip, OXYGEN_SPI_CONTROL) &
+						OXYGEN_SPI_BUSY) == 0)
+			break;
+		if (count == 0) {
+			snd_printk(KERN_ERR "oxygen: spi wait timeout\n");
+			return -EIO;
+		}
+		udelay(1);
+		count--;
 	}
+	return 0;
+}
+EXPORT_SYMBOL(oxygen_wait_spi);
 
+int oxygen_write_spi(struct oxygen *chip, u8 control, unsigned int data)
+{
 	oxygen_write8(chip, OXYGEN_SPI_DATA1, data);
 	oxygen_write8(chip, OXYGEN_SPI_DATA2, data >> 8);
 	if (control & OXYGEN_SPI_DATA_LENGTH_3)
 		oxygen_write8(chip, OXYGEN_SPI_DATA3, data >> 16);
 	oxygen_write8(chip, OXYGEN_SPI_CONTROL, control);
+
+	return oxygen_wait_spi(chip);
 }
 EXPORT_SYMBOL(oxygen_write_spi);
 
diff -uprN linux-3.12/sound/pci/oxygen/oxygen_mixer.c linux-3.12-my/sound/pci/oxygen/oxygen_mixer.c
--- linux-3.12/sound/pci/oxygen/oxygen_mixer.c	2013-11-04 03:41:51.000000000 +0400
+++ linux-3.12-my/sound/pci/oxygen/oxygen_mixer.c	2013-11-18 14:03:54.000000000 +0400
@@ -190,6 +190,7 @@ void oxygen_update_dac_routing(struct ox
 	if (chip->model.update_center_lfe_mix)
 		chip->model.update_center_lfe_mix(chip, chip->dac_routing > 2);
 }
+EXPORT_SYMBOL(oxygen_update_dac_routing);
 
 static int upmix_put(struct snd_kcontrol *ctl, struct snd_ctl_elem_value *value)
 {
diff -uprN linux-3.12/sound/pci/oxygen/oxygen_regs.h linux-3.12-my/sound/pci/oxygen/oxygen_regs.h
--- linux-3.12/sound/pci/oxygen/oxygen_regs.h	2013-11-04 03:41:51.000000000 +0400
+++ linux-3.12-my/sound/pci/oxygen/oxygen_regs.h	2013-11-18 13:58:11.000000000 +0400
@@ -318,6 +318,7 @@
 #define  OXYGEN_PLAY_MUTE23		0x0002
 #define  OXYGEN_PLAY_MUTE45		0x0004
 #define  OXYGEN_PLAY_MUTE67		0x0008
+#define  OXYGEN_PLAY_MUTE_MASK		0x000f
 #define  OXYGEN_PLAY_MULTICH_MASK	0x0010
 #define  OXYGEN_PLAY_MULTICH_I2S_DAC	0x0000
 #define  OXYGEN_PLAY_MULTICH_AC97	0x0010
