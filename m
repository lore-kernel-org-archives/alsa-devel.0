From: Alexander Stein <alexanders83@web.de>
Subject: [PATCH 1/2] ALSA: sound/atmel/ac97c.c: Add missing
	clock prepare
Date: Fri,  5 Dec 2014 15:42:53 +0100
Message-ID: <1417790574-13919-1-git-send-email-alexanders83@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 61D6E2605C2
 for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2014 15:43:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Alexander Stein <alexanders83@web.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

Replace clk_enable with clk_prepare_enable and clk_disable with
clk_disable_unprepare.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
 sound/atmel/ac97c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index b2a3225..ff2f743 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -989,7 +989,7 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev, "no peripheral clock\n");
 		return PTR_ERR(pclk);
 	}
-	clk_enable(pclk);
+	clk_prepare_enable(pclk);
 
 	retval = snd_card_new(&pdev->dev, SNDRV_DEFAULT_IDX1,
 			      SNDRV_DEFAULT_STR1, THIS_MODULE,
@@ -1167,7 +1167,7 @@ err_ioremap:
 err_request_irq:
 	snd_card_free(card);
 err_snd_card_new:
-	clk_disable(pclk);
+	clk_disable_unprepare(pclk);
 	clk_put(pclk);
 	return retval;
 }
@@ -1184,7 +1184,7 @@ static int atmel_ac97c_suspend(struct device *pdev)
 		if (test_bit(DMA_TX_READY, &chip->flags))
 			dw_dma_cyclic_stop(chip->dma.tx_chan);
 	}
-	clk_disable(chip->pclk);
+	clk_disable_unprepare(chip->pclk);
 
 	return 0;
 }
@@ -1194,7 +1194,7 @@ static int atmel_ac97c_resume(struct device *pdev)
 	struct snd_card *card = dev_get_drvdata(pdev);
 	struct atmel_ac97c *chip = card->private_data;
 
-	clk_enable(chip->pclk);
+	clk_prepare_enable(chip->pclk);
 	if (cpu_is_at32ap7000()) {
 		if (test_bit(DMA_RX_READY, &chip->flags))
 			dw_dma_cyclic_start(chip->dma.rx_chan);
@@ -1222,7 +1222,7 @@ static int atmel_ac97c_remove(struct platform_device *pdev)
 	ac97c_writel(chip, COMR, 0);
 	ac97c_writel(chip, MR,   0);
 
-	clk_disable(chip->pclk);
+	clk_disable_unprepare(chip->pclk);
 	clk_put(chip->pclk);
 	iounmap(chip->regs);
 	free_irq(chip->irq, chip);
-- 
2.2.0
