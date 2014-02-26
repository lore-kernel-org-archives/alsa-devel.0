From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/48] ALSA: cs5530: Use standard printk helpers
Date: Wed, 26 Feb 2014 16:53:14 +0100
Message-ID: <1393430030-26704-13-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D7C8826579C
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:53 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6BC9475030
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
 sound/pci/cs5530.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/pci/cs5530.c b/sound/pci/cs5530.c
index 8037e8600a72..b4e0ff6a99a3 100644
--- a/sound/pci/cs5530.c
+++ b/sound/pci/cs5530.c
@@ -160,17 +160,17 @@ static int snd_cs5530_create(struct snd_card *card,
 	sb_base = 0x220 + 0x20 * (map & 3);
 
 	if (map & (1<<2))
-		printk(KERN_INFO "CS5530: XpressAudio at 0x%lx\n", sb_base);
+		dev_info(card->dev, "XpressAudio at 0x%lx\n", sb_base);
 	else {
-		printk(KERN_ERR "Could not find XpressAudio!\n");
+		dev_err(card->dev, "Could not find XpressAudio!\n");
 		snd_cs5530_free(chip);
 		return -ENODEV;
 	}
 
 	if (map & (1<<5))
-		printk(KERN_INFO "CS5530: MPU at 0x300\n");
+		dev_info(card->dev, "MPU at 0x300\n");
 	else if (map & (1<<6))
-		printk(KERN_INFO "CS5530: MPU at 0x330\n");
+		dev_info(card->dev, "MPU at 0x330\n");
 
 	irq = snd_cs5530_mixer_read(sb_base, 0x80) & 0x0F;
 	dma8 = snd_cs5530_mixer_read(sb_base, 0x81);
@@ -182,7 +182,7 @@ static int snd_cs5530_create(struct snd_card *card,
 	else if (dma8 & 0x80)
 		dma16 = 7;
 	else {
-		printk(KERN_ERR "CS5530: No 16bit DMA enabled\n");
+		dev_err(card->dev, "No 16bit DMA enabled\n");
 		snd_cs5530_free(chip);
 		return -ENODEV;
 	}
@@ -194,7 +194,7 @@ static int snd_cs5530_create(struct snd_card *card,
 	else if (dma8 & 0x08)
 		dma8 = 3;
 	else {
-		printk(KERN_ERR "CS5530: No 8bit DMA enabled\n");
+		dev_err(card->dev, "No 8bit DMA enabled\n");
 		snd_cs5530_free(chip);
 		return -ENODEV;
 	}
@@ -208,32 +208,31 @@ static int snd_cs5530_create(struct snd_card *card,
 	else if (irq & 8)
 		irq = 10;
 	else {
-		printk(KERN_ERR "CS5530: SoundBlaster IRQ not set\n");
+		dev_err(card->dev, "SoundBlaster IRQ not set\n");
 		snd_cs5530_free(chip);
 		return -ENODEV;
 	}
 
-	printk(KERN_INFO "CS5530: IRQ: %d DMA8: %d DMA16: %d\n", irq, dma8, 
-									dma16);
+	dev_info(card->dev, "IRQ: %d DMA8: %d DMA16: %d\n", irq, dma8, dma16);
 
 	err = snd_sbdsp_create(card, sb_base, irq, snd_sb16dsp_interrupt, dma8,
 						dma16, SB_HW_CS5530, &chip->sb);
 	if (err < 0) {
-		printk(KERN_ERR "CS5530: Could not create SoundBlaster\n");
+		dev_err(card->dev, "Could not create SoundBlaster\n");
 		snd_cs5530_free(chip);
 		return err;
 	}
 
 	err = snd_sb16dsp_pcm(chip->sb, 0, &chip->sb->pcm);
 	if (err < 0) {
-		printk(KERN_ERR "CS5530: Could not create PCM\n");
+		dev_err(card->dev, "Could not create PCM\n");
 		snd_cs5530_free(chip);
 		return err;
 	}
 
 	err = snd_sbmixer_new(chip->sb);
 	if (err < 0) {
-		printk(KERN_ERR "CS5530: Could not create Mixer\n");
+		dev_err(card->dev, "Could not create Mixer\n");
 		snd_cs5530_free(chip);
 		return err;
 	}
-- 
1.9.0
