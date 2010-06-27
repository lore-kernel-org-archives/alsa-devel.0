From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: multi-component - JZ4740: Fix issues of
	the i2s driver in the multi-component branch
Date: Sun, 27 Jun 2010 21:33:57 +0200
Message-ID: <1277667237-15541-1-git-send-email-lars@metafoo.de>
References: <1277639534-5104-16-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-143.synserver.de (smtp-out-143.synserver.de
	[212.40.180.143]) by alsa0.perex.cz (Postfix) with SMTP id 7F66A24462
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 21:34:28 +0200 (CEST)
In-Reply-To: <1277639534-5104-16-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

There were two dai probe callbacks of which only one was used. This patch
merges them.
The dai remove callback was not hooked up to the dai_driver struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/jz4740/jz4740-i2s.c |   83 +++++++++++++++++++---------------------
 1 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 218b20e..b969f22 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -341,11 +341,38 @@ static int jz4740_i2s_resume(struct snd_soc_dai *dai)
 	return 0;
 }
 
-static int jz4740_i2s_probe(struct platform_device *pdev, struct snd_soc_dai *dai)
+static void jz4740_i2c_init_pcm_config(struct jz4740_i2s *i2s)
+{
+	struct jz4740_dma_config *dma_config;
+
+	/* Playback */
+	dma_config = &i2s->pcm_config_playback.dma_config;
+	dma_config->src_width = JZ4740_DMA_WIDTH_32BIT,
+	dma_config->transfer_size = JZ4740_DMA_TRANSFER_SIZE_16BYTE;
+	dma_config->request_type = JZ4740_DMA_TYPE_AIC_TRANSMIT;
+	dma_config->flags = JZ4740_DMA_SRC_AUTOINC;
+	dma_config->mode = JZ4740_DMA_MODE_SINGLE;
+	i2s->pcm_config_playback.fifo_addr = i2s->phys_base + JZ_REG_AIC_FIFO;
+
+	/* Capture */
+	dma_config = &i2s->pcm_config_capture.dma_config;
+	dma_config->dst_width = JZ4740_DMA_WIDTH_32BIT,
+	dma_config->transfer_size = JZ4740_DMA_TRANSFER_SIZE_16BYTE;
+	dma_config->request_type = JZ4740_DMA_TYPE_AIC_RECEIVE;
+	dma_config->flags = JZ4740_DMA_DST_AUTOINC;
+	dma_config->mode = JZ4740_DMA_MODE_SINGLE;
+	i2s->pcm_config_capture.fifo_addr = i2s->phys_base + JZ_REG_AIC_FIFO;
+}
+
+static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	uint32_t conf;
 
+	clk_enable(i2s->clk_aic);
+
+	jz4740_i2c_init_pcm_config(i2s);
+
 	conf = (7 << JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
 		(8 << JZ_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |
 		JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
@@ -358,6 +385,14 @@ static int jz4740_i2s_probe(struct platform_device *pdev, struct snd_soc_dai *da
 	return 0;
 }
 
+static int jz4740_i2s_dai_remove(struct snd_soc_dai *dai)
+{
+	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	clk_disable(i2s->clk_aic);
+	return 0;
+}
+
 static struct snd_soc_dai_ops jz4740_i2s_dai_ops = {
 	.startup = jz4740_i2s_startup,
 	.shutdown = jz4740_i2s_shutdown,
@@ -372,7 +407,8 @@ static struct snd_soc_dai_ops jz4740_i2s_dai_ops = {
 
 struct snd_soc_dai_driver jz4740_i2s_dai = {
 	.name = "jz4740-i2s",
-	.probe = jz4740_i2s_probe,
+	.probe = jz4740_i2s_dai_probe,
+	.remove = jz4740_i2s_dai_remove,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
@@ -392,47 +428,6 @@ struct snd_soc_dai_driver jz4740_i2s_dai = {
 };
 EXPORT_SYMBOL_GPL(jz4740_i2s_dai);
 
-static void __devinit jz4740_i2c_init_pcm_config(struct jz4740_i2s *i2s)
-{
-	struct jz4740_dma_config *dma_config;
-
-	/* Playback */
-	dma_config = &i2s->pcm_config_playback.dma_config;
-	dma_config->src_width = JZ4740_DMA_WIDTH_32BIT,
-	dma_config->transfer_size = JZ4740_DMA_TRANSFER_SIZE_16BYTE;
-	dma_config->request_type = JZ4740_DMA_TYPE_AIC_TRANSMIT;
-	dma_config->flags = JZ4740_DMA_SRC_AUTOINC;
-	dma_config->mode = JZ4740_DMA_MODE_SINGLE;
-	i2s->pcm_config_playback.fifo_addr = i2s->phys_base + JZ_REG_AIC_FIFO;
-
-	/* Capture */
-	dma_config = &i2s->pcm_config_capture.dma_config;
-	dma_config->dst_width = JZ4740_DMA_WIDTH_32BIT,
-	dma_config->transfer_size = JZ4740_DMA_TRANSFER_SIZE_16BYTE;
-	dma_config->request_type = JZ4740_DMA_TYPE_AIC_RECEIVE;
-	dma_config->flags = JZ4740_DMA_DST_AUTOINC;
-	dma_config->mode = JZ4740_DMA_MODE_SINGLE;
-	i2s->pcm_config_capture.fifo_addr = i2s->phys_base + JZ_REG_AIC_FIFO;
-}
-
-static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
-{
-	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-
-	clk_enable(i2s->clk_aic);
-
-	jz4740_i2c_init_pcm_config(i2s);
-	return 0;
-}
-
-static int jz4740_i2s_dai_remove(struct snd_soc_dai *dai)
-{
-	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-
-	clk_disable(i2s->clk_aic);
-	return 0;
-}
-
 static int __devinit jz4740_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct jz4740_i2s *i2s;
@@ -504,7 +499,7 @@ static int __devexit jz4740_i2s_dev_remove(struct platform_device *pdev)
 {
 	struct jz4740_i2s *i2s = platform_get_drvdata(pdev);
 
-	snd_soc_unregister_dai(&pdev->dev, pdev->idi);
+	snd_soc_unregister_dai(&pdev->dev, pdev->id);
 
 	clk_put(i2s->clk_i2s);
 	clk_put(i2s->clk_aic);
-- 
1.5.6.5
