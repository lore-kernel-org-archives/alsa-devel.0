From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH] ALSA: at73c213: manage SSC clock
Date: Sat, 16 Jan 2016 18:35:49 +0000
Message-ID: <1452969349-9810-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
 by alsa0.perex.cz (Postfix) with ESMTP id A5BBA2604BE
 for <alsa-devel@alsa-project.org>; Sat, 16 Jan 2016 19:36:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Since commit 49af54ff0fc7 ("misc: atmel-ssc: prepare clock only when
request") the SSC driver expects clients to manage the SSC clock.
Update this driver accordingly.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 sound/spi/at73c213.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index 39522367897c..3b2d0b2be421 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -981,6 +981,8 @@ static int snd_at73c213_probe(struct spi_device *spi)
 		goto out_card;
 	}
 
+	clk_enable(chip->ssc->clk);
+
 	retval = snd_at73c213_dev_init(card, spi);
 	if (retval)
 		goto out_ssc;
@@ -998,6 +1000,7 @@ static int snd_at73c213_probe(struct spi_device *spi)
 	goto out;
 
 out_ssc:
+	clk_disable(chip->ssc->clk);
 	ssc_free(chip->ssc);
 out_card:
 	snd_card_free(card);
@@ -1066,6 +1069,9 @@ out:
 	/* Stop DAC master clock. */
 	clk_disable(chip->board->dac_clk);
 
+	/* Stop SSC clock. */
+	clk_disable(chip->ssc->clk);
+
 	ssc_free(chip->ssc);
 	snd_card_free(card);
 
@@ -1080,6 +1086,7 @@ static int snd_at73c213_suspend(struct device *dev)
 	struct snd_at73c213 *chip = card->private_data;
 
 	ssc_writel(chip->ssc->regs, CR, SSC_BIT(CR_TXDIS));
+	clk_disable(chip->ssc->clk);
 	clk_disable(chip->board->dac_clk);
 
 	return 0;
@@ -1091,6 +1098,7 @@ static int snd_at73c213_resume(struct device *dev)
 	struct snd_at73c213 *chip = card->private_data;
 
 	clk_enable(chip->board->dac_clk);
+	clk_enable(chip->ssc->clk);
 	ssc_writel(chip->ssc->regs, CR, SSC_BIT(CR_TXEN));
 
 	return 0;
-- 
2.7.0
