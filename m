From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/48] ALSA: atiixp-modem: Use standard printk
	helpers
Date: Wed, 26 Feb 2014 16:53:08 +0100
Message-ID: <1393430030-26704-7-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C63CA265784
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:53 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4A95075028
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 15:53:53 +0000 (UTC)
In-Reply-To: <1393430030-26704-1-git-send-email-tiwai@suse.de>
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

Convert with dev_err() and co from snd_printk(), etc.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/atiixp_modem.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index 2b3244a85cf8..b9dc96c5d21e 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -400,7 +400,7 @@ static int snd_atiixp_acquire_codec(struct atiixp_modem *chip)
 
 	while (atiixp_read(chip, PHYS_OUT_ADDR) & ATI_REG_PHYS_OUT_ADDR_EN) {
 		if (! timeout--) {
-			snd_printk(KERN_WARNING "atiixp-modem: codec acquire timeout\n");
+			dev_warn(chip->card->dev, "codec acquire timeout\n");
 			return -EBUSY;
 		}
 		udelay(1);
@@ -433,7 +433,7 @@ static unsigned short snd_atiixp_codec_read(struct atiixp_modem *chip,
 	} while (--timeout);
 	/* time out may happen during reset */
 	if (reg < 0x7c)
-		snd_printk(KERN_WARNING "atiixp-modem: codec read timeout (reg %x)\n", reg);
+		dev_warn(chip->card->dev, "codec read timeout (reg %x)\n", reg);
 	return 0xffff;
 }
 
@@ -499,7 +499,7 @@ static int snd_atiixp_aclink_reset(struct atiixp_modem *chip)
 		msleep(1);
 		atiixp_update(chip, CMD, ATI_REG_CMD_AC_RESET, ATI_REG_CMD_AC_RESET);
 		if (!--timeout) {
-			snd_printk(KERN_ERR "atiixp-modem: codec reset timeout\n");
+			dev_err(chip->card->dev, "codec reset timeout\n");
 			break;
 		}
 	}
@@ -553,7 +553,7 @@ static int snd_atiixp_codec_detect(struct atiixp_modem *chip)
 	atiixp_write(chip, IER, 0); /* disable irqs */
 
 	if ((chip->codec_not_ready_bits & ALL_CODEC_NOT_READY) == ALL_CODEC_NOT_READY) {
-		snd_printk(KERN_ERR "atiixp-modem: no codec detected!\n");
+		dev_err(chip->card->dev, "no codec detected!\n");
 		return -ENXIO;
 	}
 	return 0;
@@ -624,7 +624,7 @@ static snd_pcm_uframes_t snd_atiixp_pcm_pointer(struct snd_pcm_substream *substr
 			continue;
 		return bytes_to_frames(runtime, curptr);
 	}
-	snd_printd("atiixp-modem: invalid DMA pointer read 0x%x (buf=%x)\n",
+	dev_dbg(chip->card->dev, "invalid DMA pointer read 0x%x (buf=%x)\n",
 		   readl(chip->remap_addr + dma->ops->dt_cur), dma->buf_addr);
 	return 0;
 }
@@ -637,7 +637,7 @@ static void snd_atiixp_xrun_dma(struct atiixp_modem *chip,
 {
 	if (! dma->substream || ! dma->running)
 		return;
-	snd_printdd("atiixp-modem: XRUN detected (DMA %d)\n", dma->ops->type);
+	dev_dbg(chip->card->dev, "XRUN detected (DMA %d)\n", dma->ops->type);
 	snd_pcm_stream_lock(dma->substream);
 	snd_pcm_stop(dma->substream, SNDRV_PCM_STATE_XRUN);
 	snd_pcm_stream_unlock(dma->substream);
@@ -1098,14 +1098,15 @@ static int snd_atiixp_mixer_new(struct atiixp_modem *chip, int clock)
 		ac97.scaps = AC97_SCAP_SKIP_AUDIO | AC97_SCAP_POWER_SAVE;
 		if ((err = snd_ac97_mixer(pbus, &ac97, &chip->ac97[i])) < 0) {
 			chip->ac97[i] = NULL; /* to be sure */
-			snd_printdd("atiixp-modem: codec %d not available for modem\n", i);
+			dev_dbg(chip->card->dev,
+				"codec %d not available for modem\n", i);
 			continue;
 		}
 		codec_count++;
 	}
 
 	if (! codec_count) {
-		snd_printk(KERN_ERR "atiixp-modem: no codec available\n");
+		dev_err(chip->card->dev, "no codec available\n");
 		return -ENODEV;
 	}
 
@@ -1150,8 +1151,7 @@ static int snd_atiixp_resume(struct device *dev)
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
-		printk(KERN_ERR "atiixp-modem: pci_enable_device failed, "
-		       "disabling device\n");
+		dev_err(dev, "pci_enable_device failed, disabling device\n");
 		snd_card_disconnect(card);
 		return -EIO;
 	}
@@ -1262,14 +1262,14 @@ static int snd_atiixp_create(struct snd_card *card,
 	chip->addr = pci_resource_start(pci, 0);
 	chip->remap_addr = pci_ioremap_bar(pci, 0);
 	if (chip->remap_addr == NULL) {
-		snd_printk(KERN_ERR "AC'97 space ioremap problem\n");
+		dev_err(card->dev, "AC'97 space ioremap problem\n");
 		snd_atiixp_free(chip);
 		return -EIO;
 	}
 
 	if (request_irq(pci->irq, snd_atiixp_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
-		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 		snd_atiixp_free(chip);
 		return -EBUSY;
 	}
-- 
1.9.0
