From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: emu10k1: Use workqueue instead of
	kthread for emu1010 fw polling
Date: Tue, 15 Nov 2016 08:24:09 +0100
Message-ID: <20161115072409.29531-4-tiwai@suse.de>
References: <20161115072409.29531-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EA74266FF3
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 08:24:20 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C31EEACEC
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 07:24:19 +0000 (UTC)
In-Reply-To: <20161115072409.29531-1-tiwai@suse.de>
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

This patch is a cleanup of EMU1010 dock probing code in emu10k1 driver
to use work instead of kthread in a loop.  The work is lighter and
easier to control than kthread, in general.

Instead of a loop with the explicit sleep, we do simply
delayed-schedule the work.  At suspend/resume callbacks, the work is
canceled and restarted, respectively.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/emu10k1.h          |   3 +-
 sound/pci/emu10k1/emu10k1.c      |   9 +++
 sound/pci/emu10k1/emu10k1_main.c | 132 +++++++++++++++++----------------------
 3 files changed, 67 insertions(+), 77 deletions(-)

diff --git a/include/sound/emu10k1.h b/include/sound/emu10k1.h
index 5bd134651f5e..4f42affe777c 100644
--- a/include/sound/emu10k1.h
+++ b/include/sound/emu10k1.h
@@ -1688,7 +1688,8 @@ struct snd_emu1010 {
 	unsigned int internal_clock; /* 44100 or 48000 */
 	unsigned int optical_in; /* 0:SPDIF, 1:ADAT */
 	unsigned int optical_out; /* 0:SPDIF, 1:ADAT */
-	struct task_struct *firmware_thread;
+	struct delayed_work firmware_work;
+	u32 last_reg;
 };
 
 struct snd_emu10k1 {
diff --git a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
index 4733b68c9eb0..6a0e49ac5273 100644
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -194,6 +194,9 @@ static int snd_card_emu10k1_probe(struct pci_dev *pci,
 	if ((err = snd_card_register(card)) < 0)
 		goto error;
 
+	if (emu->card_capabilities->emu_model)
+		schedule_delayed_work(&emu->emu1010.firmware_work, 0);
+
 	pci_set_drvdata(pci, card);
 	dev++;
 	return 0;
@@ -219,6 +222,8 @@ static int snd_emu10k1_suspend(struct device *dev)
 
 	emu->suspend = 1;
 
+	cancel_delayed_work_sync(&emu->emu1010.firmware_work);
+
 	snd_pcm_suspend_all(emu->pcm);
 	snd_pcm_suspend_all(emu->pcm_mic);
 	snd_pcm_suspend_all(emu->pcm_efx);
@@ -252,6 +257,10 @@ static int snd_emu10k1_resume(struct device *dev)
 	emu->suspend = 0;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+
+	if (emu->card_capabilities->emu_model)
+		schedule_delayed_work(&emu->emu1010.firmware_work, 0);
+
 	return 0;
 }
 
diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 03d793f3b058..ccf4415a1c7b 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -32,7 +32,6 @@
  */
 
 #include <linux/sched.h>
-#include <linux/kthread.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -742,73 +741,70 @@ static int snd_emu1010_load_firmware(struct snd_emu10k1 *emu, int dock,
 	return snd_emu1010_load_firmware_entry(emu, *fw);
 }
 
-static int emu1010_firmware_thread(void *data)
+static void emu1010_firmware_work(struct work_struct *work)
 {
-	struct snd_emu10k1 *emu = data;
+	struct snd_emu10k1 *emu;
 	u32 tmp, tmp2, reg;
-	u32 last_reg = 0;
 	int err;
 
-	for (;;) {
-		/* Delay to allow Audio Dock to settle */
-		msleep_interruptible(1000);
-		if (kthread_should_stop())
-			break;
+	emu = container_of(work, struct snd_emu10k1,
+			   emu1010.firmware_work.work);
+	if (emu->card->shutdown)
+		return;
 #ifdef CONFIG_PM_SLEEP
-		if (emu->suspend)
-			continue;
+	if (emu->suspend)
+		return;
 #endif
-		snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &tmp); /* IRQ Status */
-		snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg); /* OPTIONS: Which cards are attached to the EMU */
-		if (reg & EMU_HANA_OPTION_DOCK_OFFLINE) {
-			/* Audio Dock attached */
-			/* Return to Audio Dock programming mode */
-			dev_info(emu->card->dev,
-				 "emu1010: Loading Audio Dock Firmware\n");
-			snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, EMU_HANA_FPGA_CONFIG_AUDIODOCK);
-			err = snd_emu1010_load_firmware(emu, 1, &emu->dock_fw);
-			if (err < 0)
-				continue;
-
-			snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, 0);
-			snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &tmp);
+	snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &tmp); /* IRQ Status */
+	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg); /* OPTIONS: Which cards are attached to the EMU */
+	if (reg & EMU_HANA_OPTION_DOCK_OFFLINE) {
+		/* Audio Dock attached */
+		/* Return to Audio Dock programming mode */
+		dev_info(emu->card->dev,
+			 "emu1010: Loading Audio Dock Firmware\n");
+		snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG,
+				       EMU_HANA_FPGA_CONFIG_AUDIODOCK);
+		err = snd_emu1010_load_firmware(emu, 1, &emu->dock_fw);
+		if (err < 0)
+			goto next;
+
+		snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, 0);
+		snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &tmp);
+		dev_info(emu->card->dev,
+			 "emu1010: EMU_HANA+DOCK_IRQ_STATUS = 0x%x\n", tmp);
+		/* ID, should read & 0x7f = 0x55 when FPGA programmed. */
+		snd_emu1010_fpga_read(emu, EMU_HANA_ID, &tmp);
+		dev_info(emu->card->dev,
+			 "emu1010: EMU_HANA+DOCK_ID = 0x%x\n", tmp);
+		if ((tmp & 0x1f) != 0x15) {
+			/* FPGA failed to be programmed */
 			dev_info(emu->card->dev,
-				 "emu1010: EMU_HANA+DOCK_IRQ_STATUS = 0x%x\n",
+				 "emu1010: Loading Audio Dock Firmware file failed, reg = 0x%x\n",
 				 tmp);
-			/* ID, should read & 0x7f = 0x55 when FPGA programmed. */
-			snd_emu1010_fpga_read(emu, EMU_HANA_ID, &tmp);
-			dev_info(emu->card->dev,
-				 "emu1010: EMU_HANA+DOCK_ID = 0x%x\n", tmp);
-			if ((tmp & 0x1f) != 0x15) {
-				/* FPGA failed to be programmed */
-				dev_info(emu->card->dev,
-					 "emu1010: Loading Audio Dock Firmware file failed, reg = 0x%x\n",
-					 tmp);
-				continue;
-			}
-			dev_info(emu->card->dev,
-				 "emu1010: Audio Dock Firmware loaded\n");
-			snd_emu1010_fpga_read(emu, EMU_DOCK_MAJOR_REV, &tmp);
-			snd_emu1010_fpga_read(emu, EMU_DOCK_MINOR_REV, &tmp2);
-			dev_info(emu->card->dev, "Audio Dock ver: %u.%u\n",
-				   tmp, tmp2);
-			/* Sync clocking between 1010 and Dock */
-			/* Allow DLL to settle */
-			msleep(10);
-			/* Unmute all. Default is muted after a firmware load */
-			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
-		} else if (!reg && last_reg) {
-			/* Audio Dock removed */
-			dev_info(emu->card->dev,
-				 "emu1010: Audio Dock detached\n");
-			/* Unmute all */
-			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
+			goto next;
 		}
-
-		last_reg = reg;
+		dev_info(emu->card->dev,
+			 "emu1010: Audio Dock Firmware loaded\n");
+		snd_emu1010_fpga_read(emu, EMU_DOCK_MAJOR_REV, &tmp);
+		snd_emu1010_fpga_read(emu, EMU_DOCK_MINOR_REV, &tmp2);
+		dev_info(emu->card->dev, "Audio Dock ver: %u.%u\n", tmp, tmp2);
+		/* Sync clocking between 1010 and Dock */
+		/* Allow DLL to settle */
+		msleep(10);
+		/* Unmute all. Default is muted after a firmware load */
+		snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
+	} else if (!reg && emu->emu1010.last_reg) {
+		/* Audio Dock removed */
+		dev_info(emu->card->dev, "emu1010: Audio Dock detached\n");
+		/* Unmute all */
+		snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
 	}
-	dev_info(emu->card->dev, "emu1010: firmware thread stopping\n");
-	return 0;
+
+ next:
+	emu->emu1010.last_reg = reg;
+	if (!emu->card->shutdown)
+		schedule_delayed_work(&emu->emu1010.firmware_work,
+				      msecs_to_jiffies(1000));
 }
 
 /*
@@ -1114,22 +1110,6 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
 	snd_emu1010_fpga_read(emu, EMU_HANA_SPDIF_MODE, &tmp);
 	snd_emu1010_fpga_write(emu, EMU_HANA_SPDIF_MODE, 0x10); /* SPDIF Format spdif  (or 0x11 for aes/ebu) */
 
-	/* Start Micro/Audio Dock firmware loader thread */
-	if (!emu->emu1010.firmware_thread) {
-		emu->emu1010.firmware_thread =
-			kthread_create(emu1010_firmware_thread, emu,
-				       "emu1010_firmware");
-		if (IS_ERR(emu->emu1010.firmware_thread)) {
-			err = PTR_ERR(emu->emu1010.firmware_thread);
-			emu->emu1010.firmware_thread = NULL;
-			dev_info(emu->card->dev,
-					"emu1010: Creating thread failed\n");
-			return err;
-		}
-
-		wake_up_process(emu->emu1010.firmware_thread);
-	}
-
 #if 0
 	snd_emu1010_fpga_link_dst_src_write(emu,
 		EMU_DST_HAMOA_DAC_LEFT1, EMU_SRC_ALICE_EMU32B + 2); /* ALICE2 bus 0xa2 */
@@ -1287,8 +1267,7 @@ static int snd_emu10k1_free(struct snd_emu10k1 *emu)
 		/* Disable 48Volt power to Audio Dock */
 		snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_PWR, 0);
 	}
-	if (emu->emu1010.firmware_thread)
-		kthread_stop(emu->emu1010.firmware_thread);
+	cancel_delayed_work_sync(&emu->emu1010.firmware_work);
 	release_firmware(emu->firmware);
 	release_firmware(emu->dock_fw);
 	if (emu->irq >= 0)
@@ -1830,6 +1809,7 @@ int snd_emu10k1_create(struct snd_card *card,
 	emu->irq = -1;
 	emu->synth = NULL;
 	emu->get_synth_voice = NULL;
+	INIT_DELAYED_WORK(&emu->emu1010.firmware_work, emu1010_firmware_work);
 	/* read revision & serial */
 	emu->revision = pci->revision;
 	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &emu->serial);
-- 
2.10.2
