From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/8] ASoC: tegra: Use common DAI DMA data struct
Date: Wed,  3 Apr 2013 11:06:03 +0200
Message-ID: <1364979965-15776-2-git-send-email-lars@metafoo.de>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-217.synserver.de (smtp-out-217.synserver.de
 [212.40.185.217])
 by alsa0.perex.cz (Postfix) with ESMTP id A105626532E
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 10:06:52 +0200 (CEST)
In-Reply-To: <1364979965-15776-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Use the common DAI DMA data struct for tegra, this allows us to use the common
helper function to configure the DMA slave config based on the DAI DMA data.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/tegra/tegra20_ac97.c  | 13 +++++++------
 sound/soc/tegra/tegra20_ac97.h  |  4 ++--
 sound/soc/tegra/tegra20_i2s.c   | 13 +++++++------
 sound/soc/tegra/tegra20_i2s.h   |  4 ++--
 sound/soc/tegra/tegra20_spdif.c |  7 ++++---
 sound/soc/tegra/tegra20_spdif.h |  4 ++--
 sound/soc/tegra/tegra30_ahub.c  |  8 ++++----
 sound/soc/tegra/tegra30_ahub.h  |  8 ++++----
 sound/soc/tegra/tegra30_i2s.c   | 13 +++++++------
 sound/soc/tegra/tegra30_i2s.h   |  4 ++--
 sound/soc/tegra/tegra_pcm.c     | 16 +++-------------
 sound/soc/tegra/tegra_pcm.h     |  7 -------
 12 files changed, 44 insertions(+), 57 deletions(-)

diff --git a/sound/soc/tegra/tegra20_ac97.c b/sound/soc/tegra/tegra20_ac97.c
index b5cee92..2f70ea7 100644
--- a/sound/soc/tegra/tegra20_ac97.c
+++ b/sound/soc/tegra/tegra20_ac97.c
@@ -35,6 +35,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
 
 #include "tegra_asoc_utils.h"
 #include "tegra20_ac97.h"
@@ -393,14 +394,14 @@ static int tegra20_ac97_platform_probe(struct platform_device *pdev)
 	}
 
 	ac97->capture_dma_data.addr = mem->start + TEGRA20_AC97_FIFO_RX1;
-	ac97->capture_dma_data.wrap = 4;
-	ac97->capture_dma_data.width = 32;
-	ac97->capture_dma_data.req_sel = of_dma[1];
+	ac97->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	ac97->capture_dma_data.maxburst = 4;
+	ac97->capture_dma_data.slave_id = of_dma[1];
 
 	ac97->playback_dma_data.addr = mem->start + TEGRA20_AC97_FIFO_TX1;
-	ac97->playback_dma_data.wrap = 4;
-	ac97->playback_dma_data.width = 32;
-	ac97->playback_dma_data.req_sel = of_dma[1];
+	ac97->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	ac97->capture_dma_data.maxburst = 4;
+	ac97->capture_dma_data.slave_id = of_dma[0];
 
 	ret = snd_soc_register_component(&pdev->dev, &tegra20_ac97_component,
 					 &tegra20_ac97_dai, 1);
diff --git a/sound/soc/tegra/tegra20_ac97.h b/sound/soc/tegra/tegra20_ac97.h
index dddc682..4acb3aa 100644
--- a/sound/soc/tegra/tegra20_ac97.h
+++ b/sound/soc/tegra/tegra20_ac97.h
@@ -85,8 +85,8 @@
 
 struct tegra20_ac97 {
 	struct clk *clk_ac97;
-	struct tegra_pcm_dma_params capture_dma_data;
-	struct tegra_pcm_dma_params playback_dma_data;
+	struct snd_dmaengine_dai_dma_data capture_dma_data;
+	struct snd_dmaengine_dai_dma_data playback_dma_data;
 	struct regmap *regmap;
 	int reset_gpio;
 	int sync_gpio;
diff --git a/sound/soc/tegra/tegra20_i2s.c b/sound/soc/tegra/tegra20_i2s.c
index 8b1ceb8..52af7f6 100644
--- a/sound/soc/tegra/tegra20_i2s.c
+++ b/sound/soc/tegra/tegra20_i2s.c
@@ -41,6 +41,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
 
 #include "tegra20_i2s.h"
 
@@ -407,14 +408,14 @@ static int tegra20_i2s_platform_probe(struct platform_device *pdev)
 	}
 
 	i2s->capture_dma_data.addr = mem->start + TEGRA20_I2S_FIFO2;
-	i2s->capture_dma_data.wrap = 4;
-	i2s->capture_dma_data.width = 32;
-	i2s->capture_dma_data.req_sel = dma_ch;
+	i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	i2s->capture_dma_data.maxburst = 4;
+	i2s->capture_dma_data.slave_id = dma_ch;
 
 	i2s->playback_dma_data.addr = mem->start + TEGRA20_I2S_FIFO1;
-	i2s->playback_dma_data.wrap = 4;
-	i2s->playback_dma_data.width = 32;
-	i2s->playback_dma_data.req_sel = dma_ch;
+	i2s->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	i2s->playback_dma_data.maxburst = 4;
+	i2s->playback_dma_data.slave_id = dma_ch;
 
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
diff --git a/sound/soc/tegra/tegra20_i2s.h b/sound/soc/tegra/tegra20_i2s.h
index 7299587..fa6c29c 100644
--- a/sound/soc/tegra/tegra20_i2s.h
+++ b/sound/soc/tegra/tegra20_i2s.h
@@ -155,8 +155,8 @@
 struct tegra20_i2s {
 	struct snd_soc_dai_driver dai;
 	struct clk *clk_i2s;
-	struct tegra_pcm_dma_params capture_dma_data;
-	struct tegra_pcm_dma_params playback_dma_data;
+	struct snd_dmaengine_dai_dma_data capture_dma_data;
+	struct snd_dmaengine_dai_dma_data playback_dma_data;
 	struct regmap *regmap;
 };
 
diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 6fce0be..5eaa12c 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -32,6 +32,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
 
 #include "tegra20_spdif.h"
 
@@ -322,9 +323,9 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 	}
 
 	spdif->playback_dma_data.addr = mem->start + TEGRA20_SPDIF_DATA_OUT;
-	spdif->playback_dma_data.wrap = 4;
-	spdif->playback_dma_data.width = 32;
-	spdif->playback_dma_data.req_sel = dmareq->start;
+	spdif->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	spdif->capture_dma_data.maxburst = 4;
+	spdif->playback_dma_data.slave_id = dmareq->start;
 
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
diff --git a/sound/soc/tegra/tegra20_spdif.h b/sound/soc/tegra/tegra20_spdif.h
index b48d699..85a9aef 100644
--- a/sound/soc/tegra/tegra20_spdif.h
+++ b/sound/soc/tegra/tegra20_spdif.h
@@ -462,8 +462,8 @@
 
 struct tegra20_spdif {
 	struct clk *clk_spdif_out;
-	struct tegra_pcm_dma_params capture_dma_data;
-	struct tegra_pcm_dma_params playback_dma_data;
+	struct snd_dmaengine_dai_dma_data capture_dma_data;
+	struct snd_dmaengine_dai_dma_data playback_dma_data;
 	struct regmap *regmap;
 };
 
diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index 4405c3a..23e592f 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -95,8 +95,8 @@ static int tegra30_ahub_runtime_resume(struct device *dev)
 }
 
 int tegra30_ahub_allocate_rx_fifo(enum tegra30_ahub_rxcif *rxcif,
-				  unsigned long *fiforeg,
-				  unsigned long *reqsel)
+				  dma_addr_t *fiforeg,
+				  unsigned int *reqsel)
 {
 	int channel;
 	u32 reg, val;
@@ -178,8 +178,8 @@ int tegra30_ahub_free_rx_fifo(enum tegra30_ahub_rxcif rxcif)
 EXPORT_SYMBOL_GPL(tegra30_ahub_free_rx_fifo);
 
 int tegra30_ahub_allocate_tx_fifo(enum tegra30_ahub_txcif *txcif,
-				  unsigned long *fiforeg,
-				  unsigned long *reqsel)
+				  dma_addr_t *fiforeg,
+				  unsigned int *reqsel)
 {
 	int channel;
 	u32 reg, val;
diff --git a/sound/soc/tegra/tegra30_ahub.h b/sound/soc/tegra/tegra30_ahub.h
index 7189be9..09766cd 100644
--- a/sound/soc/tegra/tegra30_ahub.h
+++ b/sound/soc/tegra/tegra30_ahub.h
@@ -451,15 +451,15 @@ enum tegra30_ahub_rxcif {
 };
 
 extern int tegra30_ahub_allocate_rx_fifo(enum tegra30_ahub_rxcif *rxcif,
-					 unsigned long *fiforeg,
-					 unsigned long *reqsel);
+					 dma_addr_t *fiforeg,
+					 unsigned int *reqsel);
 extern int tegra30_ahub_enable_rx_fifo(enum tegra30_ahub_rxcif rxcif);
 extern int tegra30_ahub_disable_rx_fifo(enum tegra30_ahub_rxcif rxcif);
 extern int tegra30_ahub_free_rx_fifo(enum tegra30_ahub_rxcif rxcif);
 
 extern int tegra30_ahub_allocate_tx_fifo(enum tegra30_ahub_txcif *txcif,
-					 unsigned long *fiforeg,
-					 unsigned long *reqsel);
+					 dma_addr_t *fiforeg,
+					 unsigned int *reqsel);
 extern int tegra30_ahub_enable_tx_fifo(enum tegra30_ahub_txcif txcif);
 extern int tegra30_ahub_disable_tx_fifo(enum tegra30_ahub_txcif txcif);
 extern int tegra30_ahub_free_tx_fifo(enum tegra30_ahub_txcif txcif);
diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
index f138d8f..31d092d 100644
--- a/sound/soc/tegra/tegra30_i2s.c
+++ b/sound/soc/tegra/tegra30_i2s.c
@@ -38,6 +38,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
 
 #include "tegra30_ahub.h"
 #include "tegra30_i2s.h"
@@ -80,17 +81,17 @@ static int tegra30_i2s_startup(struct snd_pcm_substream *substream,
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		ret = tegra30_ahub_allocate_tx_fifo(&i2s->playback_fifo_cif,
 					&i2s->playback_dma_data.addr,
-					&i2s->playback_dma_data.req_sel);
-		i2s->playback_dma_data.wrap = 4;
-		i2s->playback_dma_data.width = 32;
+					&i2s->playback_dma_data.slave_id);
+		i2s->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		i2s->playback_dma_data.maxburst = 4;
 		tegra30_ahub_set_rx_cif_source(i2s->playback_i2s_cif,
 					       i2s->playback_fifo_cif);
 	} else {
 		ret = tegra30_ahub_allocate_rx_fifo(&i2s->capture_fifo_cif,
 					&i2s->capture_dma_data.addr,
-					&i2s->capture_dma_data.req_sel);
-		i2s->capture_dma_data.wrap = 4;
-		i2s->capture_dma_data.width = 32;
+					&i2s->capture_dma_data.slave_id);
+		i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		i2s->capture_dma_data.maxburst = 4;
 		tegra30_ahub_set_rx_cif_source(i2s->capture_fifo_cif,
 					       i2s->capture_i2s_cif);
 	}
diff --git a/sound/soc/tegra/tegra30_i2s.h b/sound/soc/tegra/tegra30_i2s.h
index a294d94..bea23af 100644
--- a/sound/soc/tegra/tegra30_i2s.h
+++ b/sound/soc/tegra/tegra30_i2s.h
@@ -231,10 +231,10 @@ struct tegra30_i2s {
 	struct clk *clk_i2s;
 	enum tegra30_ahub_txcif capture_i2s_cif;
 	enum tegra30_ahub_rxcif capture_fifo_cif;
-	struct tegra_pcm_dma_params capture_dma_data;
+	struct snd_dmaengine_dai_dma_data capture_dma_data;
 	enum tegra30_ahub_rxcif playback_i2s_cif;
 	enum tegra30_ahub_txcif playback_fifo_cif;
-	struct tegra_pcm_dma_params playback_dma_data;
+	struct snd_dmaengine_dai_dma_data playback_dma_data;
 	struct regmap *regmap;
 };
 
diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index 117cccc..6d1c70c 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -79,12 +79,9 @@ static int tegra_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct device *dev = rtd->platform->dev;
 	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
-	struct tegra_pcm_dma_params *dmap;
 	struct dma_slave_config slave_config;
 	int ret;
 
-	dmap = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
 	ret = snd_hwparams_to_dma_slave_config(substream, params,
 						&slave_config);
 	if (ret) {
@@ -92,16 +89,9 @@ static int tegra_pcm_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		slave_config.dst_addr = dmap->addr;
-		slave_config.dst_maxburst = 4;
-	} else {
-		slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		slave_config.src_addr = dmap->addr;
-		slave_config.src_maxburst = 4;
-	}
-	slave_config.slave_id = dmap->req_sel;
+	snd_dmaengine_pcm_set_config_from_dai_data(substream,
+			snd_soc_dai_get_dma_data(rtd->cpu_dai, substream),
+			&slave_config);
 
 	ret = dmaengine_slave_config(chan, &slave_config);
 	if (ret < 0) {
diff --git a/sound/soc/tegra/tegra_pcm.h b/sound/soc/tegra/tegra_pcm.h
index bc8b46a..68ad901 100644
--- a/sound/soc/tegra/tegra_pcm.h
+++ b/sound/soc/tegra/tegra_pcm.h
@@ -31,13 +31,6 @@
 #ifndef __TEGRA_PCM_H__
 #define __TEGRA_PCM_H__
 
-struct tegra_pcm_dma_params {
-	unsigned long addr;
-	unsigned long wrap;
-	unsigned long width;
-	unsigned long req_sel;
-};
-
 int tegra_pcm_platform_register(struct device *dev);
 void tegra_pcm_platform_unregister(struct device *dev);
 
-- 
1.8.0
