From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/8] ALSA: emu10k1: cache emu1010 firmware
Date: Thu, 22 Nov 2012 17:54:59 +0100
Message-ID: <1353603300-3217-8-git-send-email-tiwai@suse.de>
References: <1353603300-3217-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 539F326159D
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 17:55:09 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 208B7A5202
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 17:55:09 +0100 (CET)
In-Reply-To: <1353603300-3217-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Instead of calling request_firmware() at each time, keep the obtained
firmware internally and reuse it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/emu10k1.h          |  3 ++
 sound/pci/emu10k1/emu10k1_main.c | 88 ++++++++++++++++------------------------
 2 files changed, 39 insertions(+), 52 deletions(-)

diff --git a/include/sound/emu10k1.h b/include/sound/emu10k1.h
index 3707288..9dc94b5 100644
--- a/include/sound/emu10k1.h
+++ b/include/sound/emu10k1.h
@@ -32,6 +32,7 @@
 #include <sound/timer.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
+#include <linux/firmware.h>
 
 #include <asm/io.h>
 #include <uapi/sound/emu10k1.h>
@@ -1785,6 +1786,8 @@ struct snd_emu10k1 {
 	unsigned int efx_voices_mask[2];
 	unsigned int next_free_voice;
 
+	const struct firmware *firmware;
+
 #ifdef CONFIG_PM_SLEEP
 	unsigned int *saved_ptr;
 	unsigned int *saved_gpr;
diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index c21adb6..1dfb94d 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -657,22 +657,17 @@ static int snd_emu10k1_cardbus_init(struct snd_emu10k1 *emu)
 	return 0;
 }
 
-static int snd_emu1010_load_firmware(struct snd_emu10k1 *emu, const char *filename)
+static int snd_emu1010_load_firmware(struct snd_emu10k1 *emu)
 {
-	int err;
 	int n, i;
 	int reg;
 	int value;
 	unsigned int write_post;
 	unsigned long flags;
-	const struct firmware *fw_entry;
+	const struct firmware *fw_entry = emu->firmware;
 
-	err = request_firmware(&fw_entry, filename, &emu->pci->dev);
-	if (err != 0) {
-		snd_printk(KERN_ERR "firmware: %s not found. Err = %d\n", filename, err);
-		return err;
-	}
-	snd_printk(KERN_INFO "firmware size = 0x%zx\n", fw_entry->size);
+	if (!fw_entry)
+		return -EIO;
 
 	/* The FPGA is a Xilinx Spartan IIE XC2S50E */
 	/* GPIO7 -> FPGA PGMN
@@ -705,7 +700,6 @@ static int snd_emu1010_load_firmware(struct snd_emu10k1 *emu, const char *filena
 	write_post = inl(emu->port + A_IOCFG);
 	spin_unlock_irqrestore(&emu->emu_lock, flags);
 
-	release_firmware(fw_entry);
 	return 0;
 }
 
@@ -727,22 +721,9 @@ static int emu1010_firmware_thread(void *data)
 			/* Return to Audio Dock programming mode */
 			snd_printk(KERN_INFO "emu1010: Loading Audio Dock Firmware\n");
 			snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, EMU_HANA_FPGA_CONFIG_AUDIODOCK);
-			if (emu->card_capabilities->emu_model ==
-			    EMU_MODEL_EMU1010) {
-				err = snd_emu1010_load_firmware(emu, DOCK_FILENAME);
-				if (err != 0)
-					continue;
-			} else if (emu->card_capabilities->emu_model ==
-				   EMU_MODEL_EMU1010B) {
-				err = snd_emu1010_load_firmware(emu, MICRO_DOCK_FILENAME);
-				if (err != 0)
-					continue;
-			} else if (emu->card_capabilities->emu_model ==
-				   EMU_MODEL_EMU1616) {
-				err = snd_emu1010_load_firmware(emu, MICRO_DOCK_FILENAME);
-				if (err != 0)
-					continue;
-			}
+			err = snd_emu1010_load_firmware(emu);
+			if (err != 0)
+				continue;
 
 			snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, 0);
 			snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &reg);
@@ -807,7 +788,6 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
 	unsigned int i;
 	u32 tmp, tmp2, reg;
 	int err;
-	const char *filename = NULL;
 
 	snd_printk(KERN_INFO "emu1010: Special config.\n");
 	/* AC97 2.1, Any 16Meg of 4Gig address, Auto-Mute, EMU32 Slave,
@@ -849,31 +829,33 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
 		return -ENODEV;
 	}
 	snd_printk(KERN_INFO "emu1010: EMU_HANA_ID = 0x%x\n", reg);
-	switch (emu->card_capabilities->emu_model) {
-	case EMU_MODEL_EMU1010:
-		filename = HANA_FILENAME;
-		break;
-	case EMU_MODEL_EMU1010B:
-		filename = EMU1010B_FILENAME;
-		break;
-	case EMU_MODEL_EMU1616:
-		filename = EMU1010_NOTEBOOK_FILENAME;
-		break;
-	case EMU_MODEL_EMU0404:
-		filename = EMU0404_FILENAME;
-		break;
-	default:
-		filename = NULL;
-		return -ENODEV;
-		break;
-	}
-	snd_printk(KERN_INFO "emu1010: filename %s testing\n", filename);
-	err = snd_emu1010_load_firmware(emu, filename);
-	if (err != 0) {
-		snd_printk(
-			KERN_INFO "emu1010: Loading Firmware file %s failed\n",
-			filename);
-		return err;
+
+	if (!emu->firmware) {
+		const char *filename;
+		switch (emu->card_capabilities->emu_model) {
+		case EMU_MODEL_EMU1010:
+			filename = HANA_FILENAME;
+			break;
+		case EMU_MODEL_EMU1010B:
+			filename = EMU1010B_FILENAME;
+			break;
+		case EMU_MODEL_EMU1616:
+			filename = EMU1010_NOTEBOOK_FILENAME;
+			break;
+		case EMU_MODEL_EMU0404:
+			filename = EMU0404_FILENAME;
+			break;
+		default:
+			return -ENODEV;
+		}
+
+		err = request_firmware(&emu->firmware, filename, &emu->pci->dev);
+		if (err != 0) {
+			snd_printk(KERN_ERR "emu1010: firmware: %s not found. Err = %d\n", filename, err);
+			return err;
+		}
+		snd_printk(KERN_INFO "emu1010: firmware file = %s, size = 0x%zx\n",
+			   filename, emu->firmware->size);
 	}
 
 	/* ID, should read & 0x7f = 0x55 when FPGA programmed. */
@@ -1259,6 +1241,8 @@ static int snd_emu10k1_free(struct snd_emu10k1 *emu)
 	}
 	if (emu->emu1010.firmware_thread)
 		kthread_stop(emu->emu1010.firmware_thread);
+	if (emu->firmware)
+		release_firmware(emu->firmware);
 	if (emu->irq >= 0)
 		free_irq(emu->irq, emu);
 	/* remove reserved page */
-- 
1.8.0
