From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 29/48] ALSA: cs5535audio: Use standard printk
	helpers
Date: Wed, 26 Feb 2014 16:53:31 +0100
Message-ID: <1393430030-26704-30-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4201F2657C6
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:54 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D1A487503C
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
 sound/pci/cs5535audio/cs5535audio.c      | 26 +++++++++++++++-----------
 sound/pci/cs5535audio/cs5535audio_olpc.c |  7 ++++---
 sound/pci/cs5535audio/cs5535audio_pcm.c  |  6 +++---
 sound/pci/cs5535audio/cs5535audio_pm.c   |  7 +++----
 4 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/sound/pci/cs5535audio/cs5535audio.c b/sound/pci/cs5535audio/cs5535audio.c
index 051b3e28e341..edcbbda5c488 100644
--- a/sound/pci/cs5535audio/cs5535audio.c
+++ b/sound/pci/cs5535audio/cs5535audio.c
@@ -84,7 +84,8 @@ static void wait_till_cmd_acked(struct cs5535audio *cs5535au, unsigned long time
 		udelay(1);
 	} while (--timeout);
 	if (!timeout)
-		snd_printk(KERN_ERR "Failure writing to cs5535 codec\n");
+		dev_err(cs5535au->card->dev,
+			"Failure writing to cs5535 codec\n");
 }
 
 static unsigned short snd_cs5535audio_codec_read(struct cs5535audio *cs5535au,
@@ -109,8 +110,9 @@ static unsigned short snd_cs5535audio_codec_read(struct cs5535audio *cs5535au,
 		udelay(1);
 	} while (--timeout);
 	if (!timeout)
-		snd_printk(KERN_ERR "Failure reading codec reg 0x%x,"
-					"Last value=0x%x\n", reg, val);
+		dev_err(cs5535au->card->dev,
+			"Failure reading codec reg 0x%x, Last value=0x%x\n",
+			reg, val);
 
 	return (unsigned short) val;
 }
@@ -168,7 +170,7 @@ static int snd_cs5535audio_mixer(struct cs5535audio *cs5535au)
 	olpc_prequirks(card, &ac97);
 
 	if ((err = snd_ac97_mixer(pbus, &ac97, &cs5535au->ac97)) < 0) {
-		snd_printk(KERN_ERR "mixer failed\n");
+		dev_err(card->dev, "mixer failed\n");
 		return err;
 	}
 
@@ -176,7 +178,7 @@ static int snd_cs5535audio_mixer(struct cs5535audio *cs5535au)
 
 	err = olpc_quirks(card, cs5535au->ac97);
 	if (err < 0) {
-		snd_printk(KERN_ERR "olpc quirks failed\n");
+		dev_err(card->dev, "olpc quirks failed\n");
 		return err;
 	}
 
@@ -194,8 +196,9 @@ static void process_bm0_irq(struct cs5535audio *cs5535au)
 		dma = cs5535au->playback_substream->runtime->private_data;
 		snd_pcm_period_elapsed(cs5535au->playback_substream);
 	} else {
-		snd_printk(KERN_ERR "unexpected bm0 irq src, bm_stat=%x\n",
-					bm_stat);
+		dev_err(cs5535au->card->dev,
+			"unexpected bm0 irq src, bm_stat=%x\n",
+			bm_stat);
 	}
 }
 
@@ -241,8 +244,9 @@ static irqreturn_t snd_cs5535audio_interrupt(int irq, void *dev_id)
 				process_bm1_irq(cs5535au);
 				break;
 			default:
-				snd_printk(KERN_ERR "Unexpected irq src: "
-						"0x%x\n", acc_irq_stat);
+				dev_err(cs5535au->card->dev,
+					"Unexpected irq src: 0x%x\n",
+					acc_irq_stat);
 				break;
 			}
 		}
@@ -287,7 +291,7 @@ static int snd_cs5535audio_create(struct snd_card *card,
 
 	if (pci_set_dma_mask(pci, DMA_BIT_MASK(32)) < 0 ||
 	    pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(32)) < 0) {
-		printk(KERN_WARNING "unable to get 32bit dma\n");
+		dev_warn(card->dev, "unable to get 32bit dma\n");
 		err = -ENXIO;
 		goto pcifail;
 	}
@@ -312,7 +316,7 @@ static int snd_cs5535audio_create(struct snd_card *card,
 
 	if (request_irq(pci->irq, snd_cs5535audio_interrupt,
 			IRQF_SHARED, KBUILD_MODNAME, cs5535au)) {
-		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 		err = -EBUSY;
 		goto sndfail;
 	}
diff --git a/sound/pci/cs5535audio/cs5535audio_olpc.c b/sound/pci/cs5535audio/cs5535audio_olpc.c
index e6a44507d557..3b0fdaca8dc7 100644
--- a/sound/pci/cs5535audio/cs5535audio_olpc.c
+++ b/sound/pci/cs5535audio/cs5535audio_olpc.c
@@ -36,7 +36,8 @@ void olpc_analog_input(struct snd_ac97 *ac97, int on)
 	err = snd_ac97_update_bits(ac97, AC97_AD_TEST2,
 			1 << AC97_AD_HPFD_SHIFT, on << AC97_AD_HPFD_SHIFT);
 	if (err < 0) {
-		snd_printk(KERN_ERR "setting High Pass Filter - %d\n", err);
+		dev_err(ac97->bus->card->dev,
+			"setting High Pass Filter - %d\n", err);
 		return;
 	}
 
@@ -58,7 +59,7 @@ void olpc_mic_bias(struct snd_ac97 *ac97, int on)
 	err = snd_ac97_update_bits(ac97, AC97_AD_MISC,
 			1 << AC97_AD_VREFD_SHIFT, on << AC97_AD_VREFD_SHIFT);
 	if (err < 0)
-		snd_printk(KERN_ERR "setting MIC Bias - %d\n", err);
+		dev_err(ac97->bus->card->dev, "setting MIC Bias - %d\n", err);
 }
 
 static int olpc_dc_info(struct snd_kcontrol *kctl,
@@ -153,7 +154,7 @@ int olpc_quirks(struct snd_card *card, struct snd_ac97 *ac97)
 		return 0;
 
 	if (gpio_request(OLPC_GPIO_MIC_AC, DRV_NAME)) {
-		printk(KERN_ERR DRV_NAME ": unable to allocate MIC GPIO\n");
+		dev_err(card->dev, "unable to allocate MIC GPIO\n");
 		return -EIO;
 	}
 	gpio_direction_output(OLPC_GPIO_MIC_AC, 0);
diff --git a/sound/pci/cs5535audio/cs5535audio_pcm.c b/sound/pci/cs5535audio/cs5535audio_pcm.c
index 9ab01a7047cf..9c2dc911d8d7 100644
--- a/sound/pci/cs5535audio/cs5535audio_pcm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pcm.c
@@ -317,7 +317,7 @@ static int snd_cs5535audio_trigger(struct snd_pcm_substream *substream, int cmd)
 		dma->ops->disable_dma(cs5535au);
 		break;
 	default:
-		snd_printk(KERN_ERR "unhandled trigger\n");
+		dev_err(cs5535au->card->dev, "unhandled trigger\n");
 		err = -EINVAL;
 		break;
 	}
@@ -335,13 +335,13 @@ static snd_pcm_uframes_t snd_cs5535audio_pcm_pointer(struct snd_pcm_substream
 	dma = substream->runtime->private_data;
 	curdma = dma->ops->read_dma_pntr(cs5535au);
 	if (curdma < dma->buf_addr) {
-		snd_printk(KERN_ERR "curdma=%x < %x bufaddr.\n",
+		dev_err(cs5535au->card->dev, "curdma=%x < %x bufaddr.\n",
 					curdma, dma->buf_addr);
 		return 0;
 	}
 	curdma -= dma->buf_addr;
 	if (curdma >= dma->buf_bytes) {
-		snd_printk(KERN_ERR "diff=%x >= %x buf_bytes.\n",
+		dev_err(cs5535au->card->dev, "diff=%x >= %x buf_bytes.\n",
 					curdma, dma->buf_bytes);
 		return 0;
 	}
diff --git a/sound/pci/cs5535audio/cs5535audio_pm.c b/sound/pci/cs5535audio/cs5535audio_pm.c
index 6c34def5986d..34cc60057d0c 100644
--- a/sound/pci/cs5535audio/cs5535audio_pm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pm.c
@@ -74,7 +74,7 @@ static int snd_cs5535audio_suspend(struct device *dev)
 	snd_cs5535audio_stop_hardware(cs5535au);
 
 	if (pci_save_state(pci)) {
-		printk(KERN_ERR "cs5535audio: pci_save_state failed!\n");
+		dev_err(dev, "pci_save_state failed!\n");
 		return -EIO;
 	}
 	pci_disable_device(pci);
@@ -94,8 +94,7 @@ static int snd_cs5535audio_resume(struct device *dev)
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
-		printk(KERN_ERR "cs5535audio: pci_enable_device failed, "
-		       "disabling device\n");
+		dev_err(dev, "pci_enable_device failed, disabling device\n");
 		snd_card_disconnect(card);
 		return -EIO;
 	}
@@ -113,7 +112,7 @@ static int snd_cs5535audio_resume(struct device *dev)
 	} while (--timeout);
 
 	if (!timeout)
-		snd_printk(KERN_ERR "Failure getting AC Link ready\n");
+		dev_err(cs5535au->card->dev, "Failure getting AC Link ready\n");
 
 	/* set up rate regs, dma. actual initiation is done in trig */
 	for (i = 0; i < NUM_CS5535AUDIO_DMAS; i++) {
-- 
1.9.0
