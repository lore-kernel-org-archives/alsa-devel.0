From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v2 1/4] ALSA: oxygen: Change SPI
	writing/waiting logic
Date: Thu, 21 Nov 2013 19:22:38 +0400
Message-ID: <20131121192238.211b13da@v1ron-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.mail.ru (smtp2.mail.ru [94.100.176.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D43E260786
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 16:22:48 +0100 (CET)
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

Move waiting logic into separate function, wait after triggering the transaction (not before), increase the wait timeout, error handling. Should not affect other card models.

Signed-off-by: Roman I. Volkov <v1ron@mail.ru>
---
diff -uprN linux-3.12/sound/pci/oxygen/oxygen.h linux-3.12-my/sound/pci/oxygen/oxygen.h
--- linux-3.12/sound/pci/oxygen/oxygen.h	2013-11-04 03:41:51.000000000 +0400
+++ linux-3.12-my/sound/pci/oxygen/oxygen.h	2013-11-20 22:20:44.000000000 +0400
@@ -198,7 +198,7 @@ void oxygen_write_ac97(struct oxygen *ch
 void oxygen_write_ac97_masked(struct oxygen *chip, unsigned int codec,
 			      unsigned int index, u16 data, u16 mask);
 
-void oxygen_write_spi(struct oxygen *chip, u8 control, unsigned int data);
+int oxygen_write_spi(struct oxygen *chip, u8 control, unsigned int data);
 void oxygen_write_i2c(struct oxygen *chip, u8 device, u8 map, u8 data);
 
 void oxygen_reset_uart(struct oxygen *chip);
diff -uprN linux-3.12/sound/pci/oxygen/oxygen_io.c linux-3.12-my/sound/pci/oxygen/oxygen_io.c
--- linux-3.12/sound/pci/oxygen/oxygen_io.c	2013-11-04 03:41:51.000000000 +0400
+++ linux-3.12-my/sound/pci/oxygen/oxygen_io.c	2013-11-20 15:34:14.000000000 +0400
@@ -194,23 +194,34 @@ void oxygen_write_ac97_masked(struct oxy
 }
 EXPORT_SYMBOL(oxygen_write_ac97_masked);
 
-void oxygen_write_spi(struct oxygen *chip, u8 control, unsigned int data)
+static int oxygen_wait_spi(struct oxygen *chip)
 {
-	unsigned int count;
+	/* Higher interval to be sure - 400 microseconds */
+	unsigned int count = 100;
 
-	/* should not need more than 30.72 us (24 * 1.28 us) */
-	count = 10;
-	while ((oxygen_read8(chip, OXYGEN_SPI_CONTROL) & OXYGEN_SPI_BUSY)
-	       && count > 0) {
+	for (;;) {
+		if ((oxygen_read8(chip, OXYGEN_SPI_CONTROL) &
+						OXYGEN_SPI_BUSY) == 0)
+			break;
+		if (count == 0) {
+			snd_printk(KERN_ERR "oxygen: spi wait timeout\n");
+			return -EIO;
+		}
 		udelay(4);
-		--count;
+		count--;
 	}
+	return 0;
+}
 
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
 
-- 
Kind regards,
Roman Volkov,
v1ron@mail.ru
