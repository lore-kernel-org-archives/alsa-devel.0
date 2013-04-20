From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/8] ASoC: generic-dmaengine-pcm: Add support
	for half-duplex
Date: Sat, 20 Apr 2013 19:29:00 +0200
Message-ID: <1366478947-9377-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-081.synserver.de (smtp-out-086.synserver.de
 [212.40.185.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B30C265177
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 19:29:58 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Some platforms which are half-duplex share the same DMA channel between the
playback and capture stream. Add support for this to the generic dmaengine PCM
driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/dmaengine_pcm.h         |  5 ++++
 sound/soc/soc-generic-dmaengine-pcm.c | 43 ++++++++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index b1d1150..f11c35c 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -91,6 +91,11 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
  * bytes that are still left to transfer.
  */
 #define SND_DMAENGINE_PCM_FLAG_NO_RESIDUE BIT(2)
+/*
+ * The PCM is half duplex and the DMA channel is shared between capture and
+ * playback.
+ */
+#define SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX BIT(3)
 
 /**
  * struct snd_dmaengine_pcm_config - Configuration data for dmaengine based PCM
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index ae0c37e..5fd5ed4 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -29,7 +29,7 @@ struct dmaengine_pcm {
 	struct dma_chan *chan[SNDRV_PCM_STREAM_CAPTURE + 1];
 	const struct snd_dmaengine_pcm_config *config;
 	struct snd_soc_platform platform;
-	bool compat;
+	unsigned int flags;
 };
 
 static struct dmaengine_pcm *soc_platform_to_pcm(struct snd_soc_platform *p)
@@ -128,6 +128,9 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
 {
 	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
 
+	if ((pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX) && pcm->chan[0])
+		return pcm->chan[0];
+
 	if (pcm->config->compat_request_channel)
 		return pcm->config->compat_request_channel(rtd, substream);
 
@@ -148,7 +151,7 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		if (!substream)
 			continue;
 
-		if (!pcm->chan[i] && pcm->compat) {
+		if (!pcm->chan[i] && (pcm->flags & SND_DMAENGINE_PCM_FLAG_COMPAT)) {
 			pcm->chan[i] = dmaengine_pcm_compat_request_channel(rtd,
 				substream);
 		}
@@ -215,6 +218,25 @@ static const char * const dmaengine_pcm_dma_channel_names[] = {
 	[SNDRV_PCM_STREAM_CAPTURE] = "rx",
 };
 
+static void dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
+	struct device_node *of_node)
+{
+	unsigned int i;
+
+	if ((pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_DT) || !of_node)
+		return;
+
+	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX) {
+		pcm->chan[0] = of_dma_request_slave_channel(of_node, "tx_rx");
+		pcm->chan[1] = pcm->chan[0];
+	} else {
+		for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
+			pcm->chan[i] = of_dma_request_slave_channel(of_node,
+					dmaengine_pcm_dma_channel_names[i]);
+		}
+	}
+}
+
 /**
  * snd_dmaengine_pcm_register - Register a dmaengine based PCM device
  * @dev: The parent device for the PCM device
@@ -225,23 +247,15 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	const struct snd_dmaengine_pcm_config *config, unsigned int flags)
 {
 	struct dmaengine_pcm *pcm;
-	unsigned int i;
 
 	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
 	if (!pcm)
 		return -ENOMEM;
 
 	pcm->config = config;
+	pcm->flags = flags;
 
-	if (flags & SND_DMAENGINE_PCM_FLAG_COMPAT)
-		pcm->compat = true;
-
-	if (!(flags & SND_DMAENGINE_PCM_FLAG_NO_DT) && dev->of_node) {
-		for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
-			pcm->chan[i] = of_dma_request_slave_channel(dev->of_node,
-					dmaengine_pcm_dma_channel_names[i]);
-		}
-	}
+	dmaengine_pcm_request_chan_of(pcm, dev->of_node);
 
 	if (flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
 		return snd_soc_add_platform(dev, &pcm->platform,
@@ -272,8 +286,11 @@ void snd_dmaengine_pcm_unregister(struct device *dev)
 	pcm = soc_platform_to_pcm(platform);
 
 	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
-		if (pcm->chan[i])
+		if (pcm->chan[i]) {
 			dma_release_channel(pcm->chan[i]);
+			if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
+				break;
+		}
 	}
 
 	snd_soc_remove_platform(platform);
-- 
1.8.0
