From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/48] ALSA: cs4281: Use standard printk helpers
Date: Wed, 26 Feb 2014 16:53:13 +0100
Message-ID: <1393430030-26704-12-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D09A626579A
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:53 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6872E7502B
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
 sound/pci/cs4281.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index 2bd55177b1ae..43d1f912c641 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -564,7 +564,8 @@ static void snd_cs4281_ac97_write(struct snd_ac97 *ac97,
 			return;
 		}
 	}
-	snd_printk(KERN_ERR "AC'97 write problem, reg = 0x%x, val = 0x%x\n", reg, val);
+	dev_err(chip->card->dev,
+		"AC'97 write problem, reg = 0x%x, val = 0x%x\n", reg, val);
 }
 
 static unsigned short snd_cs4281_ac97_read(struct snd_ac97 *ac97,
@@ -624,7 +625,8 @@ static unsigned short snd_cs4281_ac97_read(struct snd_ac97 *ac97,
 			goto __ok1;
 	}
 
-	snd_printk(KERN_ERR "AC'97 read problem (ACCTL_DCV), reg = 0x%x\n", reg);
+	dev_err(chip->card->dev,
+		"AC'97 read problem (ACCTL_DCV), reg = 0x%x\n", reg);
 	result = 0xffff;
 	goto __end;
 	
@@ -643,7 +645,8 @@ static unsigned short snd_cs4281_ac97_read(struct snd_ac97 *ac97,
 		udelay(10);
 	}
 	
-	snd_printk(KERN_ERR "AC'97 read problem (ACSTS_VSTS), reg = 0x%x\n", reg);
+	dev_err(chip->card->dev,
+		"AC'97 read problem (ACSTS_VSTS), reg = 0x%x\n", reg);
 	result = 0xffff;
 	goto __end;
 
@@ -835,8 +838,9 @@ static snd_pcm_uframes_t snd_cs4281_pointer(struct snd_pcm_substream *substream)
 	struct cs4281 *chip = snd_pcm_substream_chip(substream);
 
 	/*
-	printk(KERN_DEBUG "DCC = 0x%x, buffer_size = 0x%x, jiffies = %li\n",
-	       snd_cs4281_peekBA0(chip, dma->regDCC), runtime->buffer_size,
+	dev_dbg(chip->card->dev,
+		"DCC = 0x%x, buffer_size = 0x%x, jiffies = %li\n",
+		snd_cs4281_peekBA0(chip, dma->regDCC), runtime->buffer_size,
 	       jiffies);
 	*/
 	return runtime->buffer_size -
@@ -1265,7 +1269,8 @@ static int snd_cs4281_create_gameport(struct cs4281 *chip)
 
 	chip->gameport = gp = gameport_allocate_port();
 	if (!gp) {
-		printk(KERN_ERR "cs4281: cannot allocate memory for gameport\n");
+		dev_err(chip->card->dev,
+			"cannot allocate memory for gameport\n");
 		return -ENOMEM;
 	}
 
@@ -1361,7 +1366,7 @@ static int snd_cs4281_create(struct snd_card *card,
 	chip->irq = -1;
 	pci_set_master(pci);
 	if (dual_codec < 0 || dual_codec > 3) {
-		snd_printk(KERN_ERR "invalid dual_codec option %d\n", dual_codec);
+		dev_err(card->dev, "invalid dual_codec option %d\n", dual_codec);
 		dual_codec = 0;
 	}
 	chip->dual_codec = dual_codec;
@@ -1383,7 +1388,7 @@ static int snd_cs4281_create(struct snd_card *card,
 	
 	if (request_irq(pci->irq, snd_cs4281_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
-		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 		snd_cs4281_free(chip);
 		return -ENOMEM;
 	}
@@ -1423,7 +1428,8 @@ static int snd_cs4281_chip_init(struct cs4281 *chip)
 		snd_cs4281_pokeBA0(chip, BA0_CFLR, BA0_CFLR_DEFAULT);
 		tmp = snd_cs4281_peekBA0(chip, BA0_CFLR);
 		if (tmp != BA0_CFLR_DEFAULT) {
-			snd_printk(KERN_ERR "CFLR setup failed (0x%x)\n", tmp);
+			dev_err(chip->card->dev,
+				"CFLR setup failed (0x%x)\n", tmp);
 			return -EIO;
 		}
 	}
@@ -1434,11 +1440,13 @@ static int snd_cs4281_chip_init(struct cs4281 *chip)
 	snd_cs4281_pokeBA0(chip, BA0_CWPR, 0x4281);
 	
 	if ((tmp = snd_cs4281_peekBA0(chip, BA0_SERC1)) != (BA0_SERC1_SO1EN | BA0_SERC1_AC97)) {
-		snd_printk(KERN_ERR "SERC1 AC'97 check failed (0x%x)\n", tmp);
+		dev_err(chip->card->dev,
+			"SERC1 AC'97 check failed (0x%x)\n", tmp);
 		return -EIO;
 	}
 	if ((tmp = snd_cs4281_peekBA0(chip, BA0_SERC2)) != (BA0_SERC2_SI1EN | BA0_SERC2_AC97)) {
-		snd_printk(KERN_ERR "SERC2 AC'97 check failed (0x%x)\n", tmp);
+		dev_err(chip->card->dev,
+			"SERC2 AC'97 check failed (0x%x)\n", tmp);
 		return -EIO;
 	}
 
@@ -1500,7 +1508,7 @@ static int snd_cs4281_chip_init(struct cs4281 *chip)
 		schedule_timeout_uninterruptible(1);
 	} while (time_after_eq(end_time, jiffies));
 
-	snd_printk(KERN_ERR "DLLRDY not seen\n");
+	dev_err(chip->card->dev, "DLLRDY not seen\n");
 	return -EIO;
 
       __ok0:
@@ -1526,7 +1534,9 @@ static int snd_cs4281_chip_init(struct cs4281 *chip)
 		schedule_timeout_uninterruptible(1);
 	} while (time_after_eq(end_time, jiffies));
 
-	snd_printk(KERN_ERR "never read codec ready from AC'97 (0x%x)\n", snd_cs4281_peekBA0(chip, BA0_ACSTS));
+	dev_err(chip->card->dev,
+		"never read codec ready from AC'97 (0x%x)\n",
+		snd_cs4281_peekBA0(chip, BA0_ACSTS));
 	return -EIO;
 
       __ok1:
@@ -1537,7 +1547,8 @@ static int snd_cs4281_chip_init(struct cs4281 *chip)
 				goto __codec2_ok;
 			schedule_timeout_uninterruptible(1);
 		} while (time_after_eq(end_time, jiffies));
-		snd_printk(KERN_INFO "secondary codec doesn't respond. disable it...\n");
+		dev_info(chip->card->dev,
+			 "secondary codec doesn't respond. disable it...\n");
 		chip->dual_codec = 0;
 	__codec2_ok: ;
 	}
@@ -1567,7 +1578,7 @@ static int snd_cs4281_chip_init(struct cs4281 *chip)
 
 	if (--retry_count > 0)
 		goto __retry;
-	snd_printk(KERN_ERR "never read ISV3 and ISV4 from AC'97\n");
+	dev_err(chip->card->dev, "never read ISV3 and ISV4 from AC'97\n");
 	return -EIO;
 
       __ok2:
@@ -2054,8 +2065,7 @@ static int cs4281_resume(struct device *dev)
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
-		printk(KERN_ERR "cs4281: pci_enable_device failed, "
-		       "disabling device\n");
+		dev_err(dev, "pci_enable_device failed, disabling device\n");
 		snd_card_disconnect(card);
 		return -EIO;
 	}
-- 
1.9.0
