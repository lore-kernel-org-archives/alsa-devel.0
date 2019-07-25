From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 31/40] soundwire: intel: move shutdown() callback and don't export symbol
Date: Thu, 25 Jul 2019 18:40:23 -0500
Message-ID: <20190725234032.21152-32-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

All DAI callbacks are in intel.c except for shutdown. Move and remove
export symbol

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 14 --------------
 drivers/soundwire/cadence_master.h |  2 --
 drivers/soundwire/intel.c          | 17 +++++++++++++++--
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index dede55072191..4a189e487830 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1381,19 +1381,5 @@ int sdw_cdns_alloc_stream(struct sdw_cdns *cdns,
 }
 EXPORT_SYMBOL(sdw_cdns_alloc_stream);
 
-void sdw_cdns_shutdown(struct snd_pcm_substream *substream,
-		       struct snd_soc_dai *dai)
-{
-	struct sdw_cdns_dma_data *dma;
-
-	dma = snd_soc_dai_get_dma_data(dai, substream);
-	if (!dma)
-		return;
-
-	snd_soc_dai_set_dma_data(dai, substream, NULL);
-	kfree(dma);
-}
-EXPORT_SYMBOL(sdw_cdns_shutdown);
-
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Cadence Soundwire Library");
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index d375bbfead18..de97bc22acb7 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -177,8 +177,6 @@ int sdw_cdns_alloc_stream(struct sdw_cdns *cdns,
 void sdw_cdns_config_stream(struct sdw_cdns *cdns, struct sdw_cdns_port *port,
 			    u32 ch, u32 dir, struct sdw_cdns_pdi *pdi);
 
-void sdw_cdns_shutdown(struct snd_pcm_substream *substream,
-		       struct snd_soc_dai *dai);
 int sdw_cdns_pcm_set_stream(struct snd_soc_dai *dai,
 			    void *stream, int direction);
 int sdw_cdns_pdm_set_stream(struct snd_soc_dai *dai,
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 5947fa8e840b..c40ab443e723 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -772,6 +772,19 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	return ret;
 }
 
+void intel_shutdown(struct snd_pcm_substream *substream,
+		    struct snd_soc_dai *dai)
+{
+	struct sdw_cdns_dma_data *dma;
+
+	dma = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dma)
+		return;
+
+	snd_soc_dai_set_dma_data(dai, substream, NULL);
+	kfree(dma);
+}
+
 static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
 				    void *stream, int direction)
 {
@@ -787,14 +800,14 @@ static int intel_pdm_set_sdw_stream(struct snd_soc_dai *dai,
 static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 	.hw_params = intel_hw_params,
 	.hw_free = intel_hw_free,
-	.shutdown = sdw_cdns_shutdown,
+	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pcm_set_sdw_stream,
 };
 
 static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
 	.hw_params = intel_hw_params,
 	.hw_free = intel_hw_free,
-	.shutdown = sdw_cdns_shutdown,
+	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pdm_set_sdw_stream,
 };
 
-- 
2.20.1
