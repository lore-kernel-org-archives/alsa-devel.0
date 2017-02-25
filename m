From: Banu Calin <banucaliniulian@gmail.com>
Subject: [PATCH] soc: atmel: Add line after declaration.
Date: Sat, 25 Feb 2017 12:29:49 +0200
Message-ID: <1488018589-7188-1-git-send-email-banucaliniulian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, banucaliniulian@gmail.com
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: Banu Calin <banucaliniulian@gmail.com>
---
 sound/atmel/ac97c.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 6dad042..4a0a48e 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -95,12 +95,14 @@ struct atmel_ac97c {
 static void atmel_ac97c_dma_playback_period_done(void *arg)
 {
 	struct atmel_ac97c *chip = arg;
+
 	snd_pcm_period_elapsed(chip->playback_substream);
 }
 
 static void atmel_ac97c_dma_capture_period_done(void *arg)
 {
 	struct atmel_ac97c *chip = arg;
+
 	snd_pcm_period_elapsed(chip->capture_substream);
 }
 
@@ -297,6 +299,7 @@ static int atmel_ac97c_capture_hw_params(struct snd_pcm_substream *substream,
 static int atmel_ac97c_playback_hw_free(struct snd_pcm_substream *substream)
 {
 	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
+
 	if (cpu_is_at32ap7000()) {
 		if (test_and_clear_bit(DMA_TX_READY, &chip->flags))
 			dw_dma_cyclic_free(chip->dma.tx_chan);
@@ -307,6 +310,7 @@ static int atmel_ac97c_playback_hw_free(struct snd_pcm_substream *substream)
 static int atmel_ac97c_capture_hw_free(struct snd_pcm_substream *substream)
 {
 	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
+
 	if (cpu_is_at32ap7000()) {
 		if (test_and_clear_bit(DMA_RX_READY, &chip->flags))
 			dw_dma_cyclic_free(chip->dma.rx_chan);
@@ -659,6 +663,7 @@ static irqreturn_t atmel_ac97c_interrupt(int irq, void *dev)
 	if (sr & AC97C_SR_CAEVT) {
 		struct snd_pcm_runtime *runtime;
 		int offset, next_period, block_size;
+
 		dev_dbg(&chip->pdev->dev, "channel A event%s%s%s%s%s%s\n",
 				casr & AC97C_CSR_OVRUN   ? " OVRUN"   : "",
 				casr & AC97C_CSR_RXRDY   ? " RXRDY"   : "",
@@ -804,6 +809,7 @@ static int atmel_ac97c_pcm_new(struct atmel_ac97c *chip)
 static int atmel_ac97c_mixer_new(struct atmel_ac97c *chip)
 {
 	struct snd_ac97_template template;
+
 	memset(&template, 0, sizeof(template));
 	template.private_data = chip;
 	return snd_ac97_mixer(chip->ac97_bus, &template, &chip->ac97);
-- 
2.7.4
