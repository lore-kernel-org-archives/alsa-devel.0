From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dmaengine: Remove unused
	SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag" to the asoc tree
Date: Fri, 15 Feb 2019 18:41:42 +0000 (GMT)
Message-ID: <20190215184142.BADC911286B7@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 950C5266A9D
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 10:20:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dmaengine: Remove unused SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 76d9c68b360f852e784170f10cb431e4713c7d0b Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 14 Feb 2019 16:45:55 +0100
Subject: [PATCH] ASoC: dmaengine: Remove unused
 SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag

There is now no users of this flag so remove it together with
related code.  The chan_name field of snd_dmaengine_dai_dma_data
data structure is not removed as it is still in use by the PXA
platform.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/dmaengine_pcm.h         |  4 ----
 sound/soc/soc-generic-dmaengine-pcm.c | 21 ++++-----------------
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 2c4cfaa135a6..c679f6116580 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -99,10 +99,6 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
  * playback.
  */
 #define SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX BIT(3)
-/*
- * The PCM streams have custom channel names specified.
- */
-#define SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME BIT(4)
 
 /**
  * struct snd_dmaengine_pcm_config - Configuration data for dmaengine based PCM
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 1b44e363c50c..f1ab6285a085 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -265,7 +265,6 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	struct dmaengine_pcm *pcm = soc_component_to_pcm(component);
 	const struct snd_dmaengine_pcm_config *config = pcm->config;
 	struct device *dev = component->dev;
-	struct snd_dmaengine_dai_dma_data *dma_data;
 	struct snd_pcm_substream *substream;
 	size_t prealloc_buffer_size;
 	size_t max_buffer_size;
@@ -285,19 +284,9 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		if (!substream)
 			continue;
 
-		dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
-		if (!pcm->chan[i] &&
-		    ((pcm->flags & SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME) ||
-		     (config && config->chan_names[i]))) {
-			const char *chan_name = dma_data->chan_name;
-
-			if (config && config->chan_names[i])
-				chan_name = config->chan_names[i];
-
+		if (!pcm->chan[i] && config && config->chan_names[i])
 			pcm->chan[i] = dma_request_slave_channel(dev,
-				chan_name);
-		}
+				config->chan_names[i]);
 
 		if (!pcm->chan[i] && (pcm->flags & SND_DMAENGINE_PCM_FLAG_COMPAT)) {
 			pcm->chan[i] = dmaengine_pcm_compat_request_channel(rtd,
@@ -420,10 +409,8 @@ static int dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
 	const char *name;
 	struct dma_chan *chan;
 
-	if ((pcm->flags & (SND_DMAENGINE_PCM_FLAG_NO_DT |
-			   SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME)) ||
-	     (!dev->of_node && !(config && config->dma_dev &&
-				config->dma_dev->of_node)))
+	if ((pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_DT) || (!dev->of_node &&
+	    !(config && config->dma_dev && config->dma_dev->of_node)))
 		return 0;
 
 	if (config && config->dma_dev) {
-- 
2.20.1
