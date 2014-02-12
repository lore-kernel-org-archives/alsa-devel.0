From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/24] ALSA: atmel: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:25 +0100
Message-ID: <1392201340-27113-10-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DE17D264FF9
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:50 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 81D36AC7C
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:35:50 +0000 (UTC)
In-Reply-To: <1392201340-27113-1-git-send-email-tiwai@suse.de>
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

Also remove superfluous snd_card_set_dev() calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/atmel/abdac.c | 13 ++++---------
 sound/atmel/ac97c.c | 10 +++-------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/sound/atmel/abdac.c b/sound/atmel/abdac.c
index 3519518e25a0..edf2ca72d518 100644
--- a/sound/atmel/abdac.c
+++ b/sound/atmel/abdac.c
@@ -429,8 +429,9 @@ static int atmel_abdac_probe(struct platform_device *pdev)
 	}
 	clk_enable(pclk);
 
-	retval = snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
-			THIS_MODULE, sizeof(struct atmel_abdac), &card);
+	retval = snd_card_new(&pdev->dev, SNDRV_DEFAULT_IDX1,
+			      SNDRV_DEFAULT_STR1, THIS_MODULE,
+			      sizeof(struct atmel_abdac), &card);
 	if (retval) {
 		dev_dbg(&pdev->dev, "could not create sound card device\n");
 		goto out_put_sample_clk;
@@ -467,8 +468,6 @@ static int atmel_abdac_probe(struct platform_device *pdev)
 		goto out_unmap_regs;
 	}
 
-	snd_card_set_dev(card, &pdev->dev);
-
 	if (pdata->dws.dma_dev) {
 		dma_cap_mask_t mask;
 
@@ -492,7 +491,7 @@ static int atmel_abdac_probe(struct platform_device *pdev)
 	if (!pdata->dws.dma_dev || !dac->dma.chan) {
 		dev_dbg(&pdev->dev, "DMA not available\n");
 		retval = -ENODEV;
-		goto out_unset_card_dev;
+		goto out_unmap_regs;
 	}
 
 	strcpy(card->driver, "Atmel ABDAC");
@@ -521,9 +520,6 @@ static int atmel_abdac_probe(struct platform_device *pdev)
 out_release_dma:
 	dma_release_channel(dac->dma.chan);
 	dac->dma.chan = NULL;
-out_unset_card_dev:
-	snd_card_set_dev(card, NULL);
-	free_irq(irq, dac);
 out_unmap_regs:
 	iounmap(dac->regs);
 out_free_card:
@@ -579,7 +575,6 @@ static int atmel_abdac_remove(struct platform_device *pdev)
 
 	dma_release_channel(dac->dma.chan);
 	dac->dma.chan = NULL;
-	snd_card_set_dev(card, NULL);
 	iounmap(dac->regs);
 	free_irq(dac->irq, dac);
 	snd_card_free(card);
diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index c5f0ddd729b3..05ec049c9faf 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -945,8 +945,9 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 	}
 	clk_enable(pclk);
 
-	retval = snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
-			THIS_MODULE, sizeof(struct atmel_ac97c), &card);
+	retval = snd_card_new(&pdev->dev, SNDRV_DEFAULT_IDX1,
+			      SNDRV_DEFAULT_STR1, THIS_MODULE,
+			      sizeof(struct atmel_ac97c), &card);
 	if (retval) {
 		dev_dbg(&pdev->dev, "could not create sound card device\n");
 		goto err_snd_card_new;
@@ -990,8 +991,6 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 		chip->reset_pin = -EINVAL;
 	}
 
-	snd_card_set_dev(card, &pdev->dev);
-
 	atmel_ac97c_reset(chip);
 
 	/* Enable overrun interrupt from codec channel */
@@ -1113,8 +1112,6 @@ err_dma:
 		chip->dma.tx_chan = NULL;
 	}
 err_ac97_bus:
-	snd_card_set_dev(card, NULL);
-
 	if (gpio_is_valid(chip->reset_pin))
 		gpio_free(chip->reset_pin);
 
@@ -1195,7 +1192,6 @@ static int atmel_ac97c_remove(struct platform_device *pdev)
 		chip->dma.tx_chan = NULL;
 	}
 
-	snd_card_set_dev(card, NULL);
 	snd_card_free(card);
 
 	return 0;
-- 
1.8.5.2
