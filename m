From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 2/5] ASoC: ep93xx: remove custom DMA alloc
	compat function
Date: Mon,  9 Dec 2013 13:24:13 -0700
Message-ID: <1386620656-18391-3-git-send-email-swarren@wwwdotorg.org>
References: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id B7B7A2650C4
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 21:24:35 +0100 (CET)
In-Reply-To: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

ep93xx_compat_request_channel() is almost identical to
dmaengine_pcm_compat_request_channel(), with the exception that the
latter:

a) Assumes that the DAI DMA data is a struct snd_dmaengine_dai_dma_data
   pointer rather than some custom type.

b) dma_data->filter_data rather than dma_data should be passed to
   snd_dmaengine_pcm_request_channel() as the filter data.

Make minor changes to the ep93xx DAI drivers so that those two conditions
are met. This allows removal of the custom .compat_request_channel().

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/cirrus/ep93xx-ac97.c | 16 ++++++++++++----
 sound/soc/cirrus/ep93xx-i2s.c  | 14 ++++++++++++--
 sound/soc/cirrus/ep93xx-pcm.c  | 13 -------------
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index e45f0fd2f6b8..f434b6ebb1d6 100644
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ b/sound/soc/cirrus/ep93xx-ac97.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 
 #include <sound/core.h>
+#include <sound/dmaengine_pcm.h>
 #include <sound/ac97_codec.h>
 #include <sound/soc.h>
 
@@ -97,6 +98,8 @@ struct ep93xx_ac97_info {
 	struct device		*dev;
 	void __iomem		*regs;
 	struct completion	done;
+	struct snd_dmaengine_dai_dma_data dma_params_rx;
+	struct snd_dmaengine_dai_dma_data dma_params_tx;
 };
 
 /* currently ALSA only supports a single AC97 device */
@@ -317,8 +320,13 @@ static int ep93xx_ac97_trigger(struct snd_pcm_substream *substream,
 
 static int ep93xx_ac97_dai_probe(struct snd_soc_dai *dai)
 {
-	dai->playback_dma_data = &ep93xx_ac97_pcm_out;
-	dai->capture_dma_data = &ep93xx_ac97_pcm_in;
+	struct ep93xx_ac97_info *info = snd_soc_dai_get_drvdata(dai);
+
+	info->dma_params_tx.filter_data = &ep93xx_ac97_pcm_out;
+	info->dma_params_rx.filter_data = &ep93xx_ac97_pcm_in;
+
+	dai->playback_dma_data = &info->dma_params_tx;
+	dai->capture_dma_data = &info->dma_params_rx;
 
 	return 0;
 }
@@ -396,8 +404,8 @@ static int ep93xx_ac97_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
-	err = ep93xx_pcm_platform_register(&pdev->dev);
-	if (err)
+	ret = ep93xx_pcm_platform_register(&pdev->dev);
+	if (ret)
 		goto fail_unregister;
 
 	return 0;
diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index cc43ed2dbca5..d21a359f4011 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 
 #include <sound/core.h>
+#include <sound/dmaengine_pcm.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/initval.h>
@@ -63,6 +64,8 @@ struct ep93xx_i2s_info {
 	struct clk			*sclk;
 	struct clk			*lrclk;
 	void __iomem			*regs;
+	struct snd_dmaengine_dai_dma_data dma_params_rx;
+	struct snd_dmaengine_dai_dma_data dma_params_tx;
 };
 
 static struct ep93xx_dma_data ep93xx_i2s_dma_data[] = {
@@ -142,8 +145,15 @@ static void ep93xx_i2s_disable(struct ep93xx_i2s_info *info, int stream)
 
 static int ep93xx_i2s_dai_probe(struct snd_soc_dai *dai)
 {
-	dai->playback_dma_data = &ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_PLAYBACK];
-	dai->capture_dma_data = &ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_CAPTURE];
+	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
+
+	info->dma_params_tx.filter_data =
+		&ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_PLAYBACK];
+	info->dma_params_rx.filter_data =
+		&ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_CAPTURE];
+
+	dai->playback_dma_data = &info->dma_params_tx;
+	dai->capture_dma_data = &info->dma_params_rx;
 
 	return 0;
 }
diff --git a/sound/soc/cirrus/ep93xx-pcm.c b/sound/soc/cirrus/ep93xx-pcm.c
index 144278aa65f9..856862932fdf 100644
--- a/sound/soc/cirrus/ep93xx-pcm.c
+++ b/sound/soc/cirrus/ep93xx-pcm.c
@@ -59,22 +59,9 @@ static bool ep93xx_pcm_dma_filter(struct dma_chan *chan, void *filter_param)
 	return false;
 }
 
-static struct dma_chan *ep93xx_compat_request_channel(
-	struct snd_soc_pcm_runtime *rtd,
-	struct snd_pcm_substream *substream)
-{
-	struct snd_dmaengine_dai_dma_data *dma_data;
-
-	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
-	return snd_dmaengine_pcm_request_channel(ep93xx_pcm_dma_filter,
-						 dma_data);
-}
-
 static const struct snd_dmaengine_pcm_config ep93xx_dmaengine_pcm_config = {
 	.pcm_hardware = &ep93xx_pcm_hardware,
 	.compat_filter_fn = ep93xx_pcm_dma_filter,
-	.compat_request_channel = ep93xx_compat_request_channel,
 	.prealloc_buffer_size = 131072,
 };
 
-- 
1.8.1.5
