From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/17] ASoC: dmaengine_pcm: Add support for
	compat platforms
Date: Mon, 15 Apr 2013 19:19:51 +0200
Message-ID: <1366046404-8759-5-git-send-email-lars@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-031.synserver.de (smtp-out-037.synserver.de
 [212.40.185.37])
 by alsa0.perex.cz (Postfix) with ESMTP id CFCAA26523B
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 19:21:13 +0200 (CEST)
In-Reply-To: <1366046404-8759-1-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Add support for platforms which don't use devicetree yet or have to optionally
support a non-devicetree way to request the DMA channel. The patch adds the
compat_request_channel and compat_filter_fn callbacks to the
snd_dmaengine_pcm_config struct. If the compat_request_channel is implemented it
will be used to request the DMA channel. If not dma_request_channel with
compat_filter_fn as the filter function will be used to request the channel.

The patch also exports the snd_dmaengine_pcm_request_chan() function, since
compat platforms will want to use it to request their DMA channel.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/dmaengine_pcm.h         | 29 +++++++++++++++++++++++++++++
 sound/soc/soc-dmaengine-pcm.c         | 14 ++++++++++++--
 sound/soc/soc-generic-dmaengine-pcm.c | 32 +++++++++++++++++++++++++++-----
 3 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index e0bf24e..1a7897a 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -16,6 +16,7 @@
 #define __SOUND_DMAENGINE_PCM_H__
 
 #include <sound/pcm.h>
+#include <sound/soc.h>
 #include <linux/dmaengine.h>
 
 /**
@@ -46,6 +47,8 @@ int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
 	dma_filter_fn filter_fn, void *filter_data);
 int snd_dmaengine_pcm_close_release_chan(struct snd_pcm_substream *substream);
 
+struct dma_chan *snd_dmaengine_pcm_request_channel(dma_filter_fn filter_fn,
+	void *filter_data);
 struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream);
 
 /**
@@ -72,17 +75,43 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
 	const struct snd_dmaengine_dai_dma_data *dma_data,
 	struct dma_slave_config *config);
 
+
+/*
+ * Try to request the DMA channel using compat_request_channel or
+ * compat_filter_fn if it couldn't be requested through devicetree.
+ */
+#define SND_DMAENGINE_PCM_FLAG_COMPAT BIT(0)
+/*
+ * Don't try to request the DMA channels through devicetree. This flag only
+ * makes sense if SND_DMAENGINE_PCM_FLAG_COMPAT is set as well.
+ */
+#define SND_DMAENGINE_PCM_FLAG_NO_DT BIT(1)
+
 /**
  * struct snd_dmaengine_pcm_config - Configuration data for dmaengine based PCM
  * @prepare_slave_config: Callback used to fill in the DMA slave_config for a
  *   PCM substream. Will be called from the PCM drivers hwparams callback.
+ * @compat_request_channel: Callback to request a DMA channel for platforms
+ *   which do not use devicetree.
+ * @compat_filter_fn: Will be used as the filter function when requesting a
+ *  channel for platforms which do not use devicetree. The filter parameter
+ *  will be the DAI's DMA data.
  * @pcm_hardware: snd_pcm_hardware struct to be used for the PCM.
  * @prealloc_buffer_size: Size of the preallocated audio buffer.
+ *
+ * Note: If both compat_request_channel and compat_filter_fn are set
+ * compat_request_channel will be used to request the channel and
+ * compat_filter_fn will be ignored. Otherwise the channel will be requested
+ * using dma_request_channel with compat_filter_fn as the filter function.
  */
 struct snd_dmaengine_pcm_config {
 	int (*prepare_slave_config)(struct snd_pcm_substream *substream,
 			struct snd_pcm_hw_params *params,
 			struct dma_slave_config *slave_config);
+	struct dma_chan *(*compat_request_channel)(
+			struct snd_soc_pcm_runtime *rtd,
+			struct snd_pcm_substream *substream);
+	dma_filter_fn compat_filter_fn;
 
 	const struct snd_pcm_hardware *pcm_hardware;
 	unsigned int prealloc_buffer_size;
diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index b0420a7..aa924d9 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -254,7 +254,16 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_pointer);
 
-static struct dma_chan *dmaengine_pcm_request_channel(dma_filter_fn filter_fn,
+/**
+ * snd_dmaengine_pcm_request_channel - Request channel for the dmaengine PCM
+ * @filter_fn: Filter function used to request the DMA channel
+ * @filter_data: Data passed to the DMA filter function
+ *
+ * Returns NULL or the requested DMA channel.
+ *
+ * This function request a DMA channel for usage with dmaengine PCM.
+ */
+struct dma_chan *snd_dmaengine_pcm_request_channel(dma_filter_fn filter_fn,
 	void *filter_data)
 {
 	dma_cap_mask_t mask;
@@ -265,6 +274,7 @@ static struct dma_chan *dmaengine_pcm_request_channel(dma_filter_fn filter_fn,
 
 	return dma_request_channel(mask, filter_fn, filter_data);
 }
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_request_channel);
 
 /**
  * snd_dmaengine_pcm_open - Open a dmaengine based PCM substream
@@ -320,7 +330,7 @@ int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
 	dma_filter_fn filter_fn, void *filter_data)
 {
 	return snd_dmaengine_pcm_open(substream,
-		    dmaengine_pcm_request_channel(filter_fn, filter_data));
+		    snd_dmaengine_pcm_request_channel(filter_fn, filter_data));
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open_request_chan);
 
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index acfc926..d6e6380 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -29,6 +29,7 @@ struct dmaengine_pcm {
 	struct dma_chan *chan[SNDRV_PCM_STREAM_CAPTURE + 1];
 	const struct snd_dmaengine_pcm_config *config;
 	struct snd_soc_platform platform;
+	bool compat;
 };
 
 static struct dmaengine_pcm *soc_platform_to_pcm(struct snd_soc_platform *p)
@@ -121,6 +122,19 @@ static void dmaengine_pcm_free(struct snd_pcm *pcm)
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
+static struct dma_chan *dmaengine_pcm_compat_request_channel(
+	struct snd_soc_pcm_runtime *rtd,
+	struct snd_pcm_substream *substream)
+{
+	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
+
+	if (pcm->config->compat_request_channel)
+		return pcm->config->compat_request_channel(rtd, substream);
+
+	return snd_dmaengine_pcm_request_channel(pcm->config->compat_filter_fn,
+		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream));
+}
+
 static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
@@ -134,6 +148,11 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		if (!substream)
 			continue;
 
+		if (!pcm->chan[i] && pcm->compat) {
+			pcm->chan[i] = dmaengine_pcm_compat_request_channel(rtd,
+				substream);
+		}
+
 		if (!pcm->chan[i]) {
 			dev_err(rtd->platform->dev,
 				"Missing dma channel for stream: %d\n", i);
@@ -171,6 +190,7 @@ static const struct snd_soc_platform_driver dmaengine_pcm_platform = {
 	.ops		= &dmaengine_pcm_ops,
 	.pcm_new	= dmaengine_pcm_new,
 	.pcm_free	= dmaengine_pcm_free,
+	.probe_order	= SND_SOC_COMP_ORDER_LATE,
 };
 
 static const char * const dmaengine_pcm_dma_channel_names[] = {
@@ -190,18 +210,20 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	struct dmaengine_pcm *pcm;
 	unsigned int i;
 
-	if (!dev->of_node)
-		return -EINVAL;
-
 	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
 	if (!pcm)
 		return -ENOMEM;
 
 	pcm->config = config;
 
-	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
-		pcm->chan[i] = of_dma_request_slave_channel(dev->of_node,
+	if (flags & SND_DMAENGINE_PCM_FLAG_COMPAT)
+		pcm->compat = true;
+
+	if (!(flags & SND_DMAENGINE_PCM_FLAG_NO_DT) && dev->of_node) {
+		for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
+			pcm->chan[i] = of_dma_request_slave_channel(dev->of_node,
 					dmaengine_pcm_dma_channel_names[i]);
+		}
 	}
 
 	return snd_soc_add_platform(dev, &pcm->platform,
-- 
1.8.0
