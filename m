From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Implement capture support"
	to the asoc tree
Date: Thu, 03 Nov 2016 10:55:04 -0600
Message-ID: <E1c2LI8-0001gR-TS@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A3A02667E7
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 17:55:26 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-i2s: Implement capture support

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ae73b34f66f629ab1986673e8e069342c09e3168 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 3 Nov 2016 17:27:05 +0100
Subject: [PATCH] ASoC: sun4i-i2s: Implement capture support

The i2s driver was only implementing playback for now. Implement capture to
make sure that's not a limitation anymore.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 52 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 687a8f83dbe5..a7653114e895 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -93,6 +93,7 @@ struct sun4i_i2s {
 	struct clk	*mod_clk;
 	struct regmap	*regmap;
 
+	struct snd_dmaengine_dai_dma_data	capture_dma_data;
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
 };
 
@@ -341,6 +342,27 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
+static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
+{
+	/* Flush RX FIFO */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
+			   SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
+			   SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
+
+	/* Clear RX counter */
+	regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);
+
+	/* Enable RX Block */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+			   SUN4I_I2S_CTRL_RX_EN,
+			   SUN4I_I2S_CTRL_RX_EN);
+
+	/* Enable RX DRQ */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_DMA_INT_CTRL_REG,
+			   SUN4I_I2S_DMA_INT_CTRL_RX_DRQ_EN,
+			   SUN4I_I2S_DMA_INT_CTRL_RX_DRQ_EN);
+}
+
 static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
 {
 	/* Flush TX FIFO */
@@ -362,6 +384,18 @@ static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
 			   SUN4I_I2S_DMA_INT_CTRL_TX_DRQ_EN);
 }
 
+static void sun4i_i2s_stop_capture(struct sun4i_i2s *i2s)
+{
+	/* Disable RX Block */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+			   SUN4I_I2S_CTRL_RX_EN,
+			   0);
+
+	/* Disable RX DRQ */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_DMA_INT_CTRL_REG,
+			   SUN4I_I2S_DMA_INT_CTRL_RX_DRQ_EN,
+			   0);
+}
 
 static void sun4i_i2s_stop_playback(struct sun4i_i2s *i2s)
 {
@@ -388,7 +422,7 @@ static int sun4i_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			sun4i_i2s_start_playback(i2s);
 		else
-			return -EINVAL;
+			sun4i_i2s_start_capture(i2s);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -397,7 +431,7 @@ static int sun4i_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			sun4i_i2s_stop_playback(i2s);
 		else
-			return -EINVAL;
+			sun4i_i2s_stop_capture(i2s);
 		break;
 
 	default:
@@ -459,7 +493,9 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 
-	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data, NULL);
+	snd_soc_dai_init_dma_data(dai,
+				  &i2s->playback_dma_data,
+				  &i2s->capture_dma_data);
 
 	snd_soc_dai_set_drvdata(dai, i2s);
 
@@ -468,6 +504,13 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
@@ -630,6 +673,9 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 	i2s->playback_dma_data.addr = res->start + SUN4I_I2S_FIFO_TX_REG;
 	i2s->playback_dma_data.maxburst = 4;
 
+	i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
+	i2s->capture_dma_data.maxburst = 4;
+
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = sun4i_i2s_runtime_resume(&pdev->dev);
-- 
2.10.1
