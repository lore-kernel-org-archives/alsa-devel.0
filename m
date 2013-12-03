From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V2 3/3] ASoC: dmaengine: add custom DMA config
	to snd_dmaengine_pcm_config
Date: Tue,  3 Dec 2013 14:26:34 -0700
Message-ID: <1386105994-16373-3-git-send-email-swarren@wwwdotorg.org>
References: <1386105994-16373-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id ADAC72652D7
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 22:26:42 +0100 (CET)
In-Reply-To: <1386105994-16373-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

Add fields to struct snd_dmaengine_pcm_config to allow custom:

- DMA channel names.

  This is useful when the default "tx" and "rx" channel names don't
  apply, for example if a HW module supports multiple channels, each
  having different DMA channel names. This is the case with the FIFOs
  in Tegra's AHUB. This new facility can replace
  SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME.

- DMA device

  This allows requesting DMA channels for a device other than the device
  which is registering the "PCM" driver. This is quite unusual, but is
  currently useful on Tegra. In much HW, and in Tegra20, each DAI HW
  module contains its own FIFOs which DMA writes to. However, in Tegra30,
  the DMA FIFOs were split out AHUB HW module, which then routes the data
  through a cross-bar, and into the DAI HW modules. However, the current
  ASoC driver structure does not expose this detail, and acts as if the
  FIFOs are still part of the DAI HW modules. Consequently, the "PCM"
  driver is registered with the DAI HW module, yet the DMA channels must
  be looked up in the AHUB HW module's device tree node. This new config
  field allows that to happen. Eventually, the Tegra drivers will be
  reworked to fully expose the AHUB, and this config field can be
  removed.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
v2:
* Re-ordered patches, so that patch 3/3 in this series could be available
  in the ASoC tree without having to wait for the patches to the DMA tree
  the implement deferred probe during channel allocation.
* dev_warn() in dmaengine_pcm_request_chan_of() if config->dev is set;
  drivers generally shouldn't need this feature, and should be re-
  structured if they do.
---
 include/sound/dmaengine_pcm.h         |  6 ++++++
 sound/soc/soc-generic-dmaengine-pcm.c | 18 ++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 15017311f2e9..87e9d481d7b6 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -114,6 +114,10 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
  * @compat_filter_fn: Will be used as the filter function when requesting a
  *  channel for platforms which do not use devicetree. The filter parameter
  *  will be the DAI's DMA data.
+ * @dma_dev: If set, request DMA channel on this device rather than the DAI
+ *  device.
+ * @chan_names: If set, these custom DMA channel names will be requested at
+ *  registration time.
  * @pcm_hardware: snd_pcm_hardware struct to be used for the PCM.
  * @prealloc_buffer_size: Size of the preallocated audio buffer.
  *
@@ -130,6 +134,8 @@ struct snd_dmaengine_pcm_config {
 			struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_substream *substream);
 	dma_filter_fn compat_filter_fn;
+	struct device *dma_dev;
+	const char *chan_names[SNDRV_PCM_STREAM_LAST + 1];
 
 	const struct snd_pcm_hardware *pcm_hardware;
 	unsigned int prealloc_buffer_size;
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index a66bb03b64cd..ac16259490ee 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -285,7 +285,7 @@ static const char * const dmaengine_pcm_dma_channel_names[] = {
 };
 
 static void dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
-	struct device *dev)
+	struct device *dev, const struct snd_dmaengine_pcm_config *config)
 {
 	unsigned int i;
 	const char *name;
@@ -295,12 +295,26 @@ static void dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
 	    !dev->of_node)
 		return;
 
+	if (config->dma_dev) {
+		/*
+		 * If this warning is seen, it probably means that your Linux
+		 * device structure does not match your HW device structure.
+		 * It would be best to refactor the Linux device structure to
+		 * correctly match the HW structure.
+		 */
+		dev_warn(dev, "DMA channels sourced from device %s",
+			 dev_name(config->dma_dev));
+		dev = config->dma_dev;
+	}
+
 	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE;
 	     i++) {
 		if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
 			name = "rx-tx";
 		else
 			name = dmaengine_pcm_dma_channel_names[i];
+		if (config->chan_names[i])
+			name = config->chan_names[i];
 		pcm->chan[i] = dma_request_slave_channel(dev, name);
 		if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
 			break;
@@ -343,7 +357,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	pcm->config = config;
 	pcm->flags = flags;
 
-	dmaengine_pcm_request_chan_of(pcm, dev);
+	dmaengine_pcm_request_chan_of(pcm, dev, config);
 
 	if (flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
 		ret = snd_soc_add_platform(dev, &pcm->platform,
-- 
1.8.1.5
