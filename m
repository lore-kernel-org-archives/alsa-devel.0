From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] ALSA: at73c213: add error handling of clk_enable()
Date: Sat, 13 Feb 2016 00:58:34 +0300
Message-ID: <1455314314-8634-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>, Mans Rullgard <mans@mansr.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: alsa-devel@alsa-project.org

Recent addition of SSC clock management does not check
if clk_enable() succeed.
The patch adds such checks where it is appropriate.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 sound/spi/at73c213.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index fac7e6eb9529..36cfaa316eab 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -221,7 +221,11 @@ static int snd_at73c213_pcm_open(struct snd_pcm_substream *substream)
 	runtime->hw = snd_at73c213_playback_hw;
 	chip->substream = substream;
 
-	clk_enable(chip->ssc->clk);
+	err = clk_enable(chip->ssc->clk);
+	if (err < 0) {
+		chip->substream = NULL;
+		return err;
+	}
 
 	return 0;
 }
@@ -787,7 +791,9 @@ static int snd_at73c213_chip_init(struct snd_at73c213 *chip)
 		goto out;
 
 	/* Enable DAC master clock. */
-	clk_enable(chip->board->dac_clk);
+	retval = clk_enable(chip->board->dac_clk);
+	if (retval)
+		goto out;
 
 	/* Initialize at73c213 on SPI bus. */
 	retval = snd_at73c213_write_reg(chip, DAC_RST, 0x04);
@@ -900,7 +906,9 @@ static int snd_at73c213_dev_init(struct snd_card *card,
 	chip->card = card;
 	chip->irq = -1;
 
-	clk_enable(chip->ssc->clk);
+	retval = clk_enable(chip->ssc->clk);
+	if (retval)
+		return retval;
 
 	retval = request_irq(irq, snd_at73c213_interrupt, 0, "at73c213", chip);
 	if (retval) {
@@ -1099,9 +1107,16 @@ static int snd_at73c213_resume(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct snd_at73c213 *chip = card->private_data;
+	int retval;
 
-	clk_enable(chip->board->dac_clk);
-	clk_enable(chip->ssc->clk);
+	retval = clk_enable(chip->board->dac_clk);
+	if (retval)
+		return retval;
+	retval = clk_enable(chip->ssc->clk);
+	if (retval) {
+		clk_disable(chip->board->dac_clk);
+		return retval;
+	}
 	ssc_writel(chip->ssc->regs, CR, SSC_BIT(CR_TXEN));
 
 	return 0;
-- 
1.9.1
