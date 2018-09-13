From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: intel8x0m: Register irq handler after
	register initializations
Date: Thu, 13 Sep 2018 07:58:11 +0200
Message-ID: <20180913055811.18274-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 18EC026779A
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 07:58:14 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 1CD06AA71
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 05:58:14 +0000 (UTC)
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

The interrupt handler has to be acquired after the other resource
initialization when allocated with IRQF_SHARED.  Otherwise it's
triggered before the resource gets ready, and may lead to unpleasant
behavior.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/intel8x0m.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 943a726b1c1b..c84629190cba 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -1171,16 +1171,6 @@ static int snd_intel8x0m_create(struct snd_card *card,
 	}
 
  port_inited:
-	if (request_irq(pci->irq, snd_intel8x0m_interrupt, IRQF_SHARED,
-			KBUILD_MODNAME, chip)) {
-		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_intel8x0m_free(chip);
-		return -EBUSY;
-	}
-	chip->irq = pci->irq;
-	pci_set_master(pci);
-	synchronize_irq(chip->irq);
-
 	/* initialize offsets */
 	chip->bdbars_count = 2;
 	tbl = intel_regs;
@@ -1224,11 +1214,21 @@ static int snd_intel8x0m_create(struct snd_card *card,
 	chip->int_sta_reg = ICH_REG_GLOB_STA;
 	chip->int_sta_mask = int_sta_masks;
 
+	pci_set_master(pci);
+
 	if ((err = snd_intel8x0m_chip_init(chip, 1)) < 0) {
 		snd_intel8x0m_free(chip);
 		return err;
 	}
 
+	if (request_irq(pci->irq, snd_intel8x0m_interrupt, IRQF_SHARED,
+			KBUILD_MODNAME, chip)) {
+		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
+		snd_intel8x0m_free(chip);
+		return -EBUSY;
+	}
+	chip->irq = pci->irq;
+
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
 		snd_intel8x0m_free(chip);
 		return err;
-- 
2.18.0
