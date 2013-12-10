From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V2 2/2] ASoC: ep93xx: remove custom DMA alloc
	compat function
Date: Tue, 10 Dec 2013 12:34:46 -0700
Message-ID: <1386704086-28624-2-git-send-email-swarren@wwwdotorg.org>
References: <1386704086-28624-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id B2107265304
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 20:34:58 +0100 (CET)
In-Reply-To: <1386704086-28624-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Ryan Mallon <rmallon@gmail.com>
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

Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Rebased on a merge of topic/ep93xx and topic/dma
---
 sound/soc/cirrus/ep93xx-ac97.c | 12 ++++++++++--
 sound/soc/cirrus/ep93xx-i2s.c  | 14 ++++++++++++--
 sound/soc/cirrus/ep93xx-pcm.c  | 13 -------------
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index cc5583da5380..f30dadf85b99 100644
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
diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 167728a73da2..943145f9d1b6 100644
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
index 198c5405f2ce..ca6698d75736 100644
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
