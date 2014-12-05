From: Alexander Stein <alexanders83@web.de>
Subject: [PATCH v2 2/2] ALSA: atmel_abdac: Add missing clock
	prepare
Date: Fri,  5 Dec 2014 20:10:07 +0100
Message-ID: <1417806607-8433-2-git-send-email-alexanders83@web.de>
References: <1417806607-8433-1-git-send-email-alexanders83@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id E174D264F37
 for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2014 20:10:19 +0100 (CET)
In-Reply-To: <1417806607-8433-1-git-send-email-alexanders83@web.de>
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

Clocks must be prepared before enabling them. Do this in one step.
Replace clk_enable with clk_prepare_enable and clk_disable with
clk_disable_unprepare.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
Note: This is compile-tested only!

 sound/atmel/abdac.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/atmel/abdac.c b/sound/atmel/abdac.c
index 31061e3..0231405 100644
--- a/sound/atmel/abdac.c
+++ b/sound/atmel/abdac.c
@@ -242,7 +242,7 @@ static int atmel_abdac_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: /* fall through */
 	case SNDRV_PCM_TRIGGER_RESUME: /* fall through */
 	case SNDRV_PCM_TRIGGER_START:
-		clk_enable(dac->sample_clk);
+		clk_prepare_enable(dac->sample_clk);
 		retval = dw_dma_cyclic_start(dac->dma.chan);
 		if (retval)
 			goto out;
@@ -254,7 +254,7 @@ static int atmel_abdac_trigger(struct snd_pcm_substream *substream, int cmd)
 		dw_dma_cyclic_stop(dac->dma.chan);
 		dac_writel(dac, DATA, 0);
 		dac_writel(dac, CTRL, 0);
-		clk_disable(dac->sample_clk);
+		clk_disable_unprepare(dac->sample_clk);
 		break;
 	default:
 		retval = -EINVAL;
@@ -429,7 +429,7 @@ static int atmel_abdac_probe(struct platform_device *pdev)
 		retval = PTR_ERR(sample_clk);
 		goto out_put_pclk;
 	}
-	clk_enable(pclk);
+	clk_prepare_enable(pclk);
 
 	retval = snd_card_new(&pdev->dev, SNDRV_DEFAULT_IDX1,
 			      SNDRV_DEFAULT_STR1, THIS_MODULE,
@@ -528,7 +528,7 @@ out_free_card:
 	snd_card_free(card);
 out_put_sample_clk:
 	clk_put(sample_clk);
-	clk_disable(pclk);
+	clk_disable_unprepare(pclk);
 out_put_pclk:
 	clk_put(pclk);
 	return retval;
@@ -541,8 +541,8 @@ static int atmel_abdac_suspend(struct device *pdev)
 	struct atmel_abdac *dac = card->private_data;
 
 	dw_dma_cyclic_stop(dac->dma.chan);
-	clk_disable(dac->sample_clk);
-	clk_disable(dac->pclk);
+	clk_disable_unprepare(dac->sample_clk);
+	clk_disable_unprepare(dac->pclk);
 
 	return 0;
 }
@@ -552,8 +552,8 @@ static int atmel_abdac_resume(struct device *pdev)
 	struct snd_card *card = dev_get_drvdata(pdev);
 	struct atmel_abdac *dac = card->private_data;
 
-	clk_enable(dac->pclk);
-	clk_enable(dac->sample_clk);
+	clk_prepare_enable(dac->pclk);
+	clk_prepare_enable(dac->sample_clk);
 	if (test_bit(DMA_READY, &dac->flags))
 		dw_dma_cyclic_start(dac->dma.chan);
 
@@ -572,7 +572,7 @@ static int atmel_abdac_remove(struct platform_device *pdev)
 	struct atmel_abdac *dac = get_dac(card);
 
 	clk_put(dac->sample_clk);
-	clk_disable(dac->pclk);
+	clk_disable_unprepare(dac->pclk);
 	clk_put(dac->pclk);
 
 	dma_release_channel(dac->dma.chan);
-- 
2.2.0
