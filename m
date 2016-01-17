From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH v2] ALSA: at73c213: manage SSC clock
Date: Sun, 17 Jan 2016 22:31:02 +0000
Message-ID: <1453069862-27884-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E54F260449
 for <alsa-devel@alsa-project.org>; Sun, 17 Jan 2016 23:31:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Since commit 49af54ff0fc7 ("misc: atmel-ssc: prepare clock only when
request") the SSC driver expects clients to manage the SSC clock.
This updates the at73c213 driver to enable the SSC clock whenever it is
needed.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
Changes:
- enable the ssc clock only when it is required
---
 sound/spi/at73c213.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index 39522367897c..fac7e6eb9529 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -221,6 +221,8 @@ static int snd_at73c213_pcm_open(struct snd_pcm_substream *substream)
 	runtime->hw = snd_at73c213_playback_hw;
 	chip->substream = substream;
 
+	clk_enable(chip->ssc->clk);
+
 	return 0;
 }
 
@@ -228,6 +230,7 @@ static int snd_at73c213_pcm_close(struct snd_pcm_substream *substream)
 {
 	struct snd_at73c213 *chip = snd_pcm_substream_chip(substream);
 	chip->substream = NULL;
+	clk_disable(chip->ssc->clk);
 	return 0;
 }
 
@@ -897,6 +900,8 @@ static int snd_at73c213_dev_init(struct snd_card *card,
 	chip->card = card;
 	chip->irq = -1;
 
+	clk_enable(chip->ssc->clk);
+
 	retval = request_irq(irq, snd_at73c213_interrupt, 0, "at73c213", chip);
 	if (retval) {
 		dev_dbg(&chip->spi->dev, "unable to request irq %d\n", irq);
@@ -935,6 +940,8 @@ out_irq:
 	free_irq(chip->irq, chip);
 	chip->irq = -1;
 out:
+	clk_disable(chip->ssc->clk);
+
 	return retval;
 }
 
@@ -1012,7 +1019,9 @@ static int snd_at73c213_remove(struct spi_device *spi)
 	int retval;
 
 	/* Stop playback. */
+	clk_enable(chip->ssc->clk);
 	ssc_writel(chip->ssc->regs, CR, SSC_BIT(CR_TXDIS));
+	clk_disable(chip->ssc->clk);
 
 	/* Mute sound. */
 	retval = snd_at73c213_write_reg(chip, DAC_LMPG, 0x3f);
@@ -1080,6 +1089,7 @@ static int snd_at73c213_suspend(struct device *dev)
 	struct snd_at73c213 *chip = card->private_data;
 
 	ssc_writel(chip->ssc->regs, CR, SSC_BIT(CR_TXDIS));
+	clk_disable(chip->ssc->clk);
 	clk_disable(chip->board->dac_clk);
 
 	return 0;
@@ -1091,6 +1101,7 @@ static int snd_at73c213_resume(struct device *dev)
 	struct snd_at73c213 *chip = card->private_data;
 
 	clk_enable(chip->board->dac_clk);
+	clk_enable(chip->ssc->clk);
 	ssc_writel(chip->ssc->regs, CR, SSC_BIT(CR_TXEN));
 
 	return 0;
-- 
2.7.0
