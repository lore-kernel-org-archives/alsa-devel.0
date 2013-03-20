From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/3] ASoC: omap-mcpdm: Collect link direction
	configuration under a struct
Date: Wed, 20 Mar 2013 10:47:12 +0100
Message-ID: <1363772834-29820-2-git-send-email-peter.ujfalusi@ti.com>
References: <1363772834-29820-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 18DDD2616F3
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2013 10:47:21 +0100 (CET)
In-Reply-To: <1363772834-29820-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

mcpdm_link_config will collect the link direction related configurations like
channel masks, FIFO threshold.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index ddfcc18..6e19f44 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -45,6 +45,11 @@
 
 #define OMAP44XX_MCPDM_L3_BASE		0x49032000
 
+struct mcpdm_link_config {
+	u32 link_mask; /* channel mask for the direction */
+	u32 threshold; /* FIFO threshold */
+};
+
 struct omap_mcpdm {
 	struct device *dev;
 	unsigned long phys_base;
@@ -53,13 +58,8 @@ struct omap_mcpdm {
 
 	struct mutex mutex;
 
-	/* channel data */
-	u32 dn_channels;
-	u32 up_channels;
-
-	/* McPDM FIFO thresholds */
-	u32 dn_threshold;
-	u32 up_threshold;
+	/* Playback/Capture configuration */
+	struct mcpdm_link_config config[2];
 
 	/* McPDM dn offsets for rx1, and 2 channels */
 	u32 dn_rx_offset;
@@ -130,11 +130,12 @@ static void omap_mcpdm_reg_dump(struct omap_mcpdm *mcpdm) {}
 static void omap_mcpdm_start(struct omap_mcpdm *mcpdm)
 {
 	u32 ctrl = omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
+	u32 link_mask = mcpdm->config[0].link_mask | mcpdm->config[1].link_mask;
 
 	ctrl |= (MCPDM_SW_DN_RST | MCPDM_SW_UP_RST);
 	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
 
-	ctrl |= mcpdm->dn_channels | mcpdm->up_channels;
+	ctrl |= link_mask;
 	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
 
 	ctrl &= ~(MCPDM_SW_DN_RST | MCPDM_SW_UP_RST);
@@ -148,11 +149,12 @@ static void omap_mcpdm_start(struct omap_mcpdm *mcpdm)
 static void omap_mcpdm_stop(struct omap_mcpdm *mcpdm)
 {
 	u32 ctrl = omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
+	u32 link_mask = mcpdm->config[0].link_mask | mcpdm->config[1].link_mask;
 
 	ctrl |= (MCPDM_SW_DN_RST | MCPDM_SW_UP_RST);
 	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
 
-	ctrl &= ~(mcpdm->dn_channels | mcpdm->up_channels);
+	ctrl &= ~(link_mask);
 	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
 
 	ctrl &= ~(MCPDM_SW_DN_RST | MCPDM_SW_UP_RST);
@@ -188,8 +190,10 @@ static void omap_mcpdm_open_streams(struct omap_mcpdm *mcpdm)
 		omap_mcpdm_write(mcpdm, MCPDM_REG_DN_OFFSET, dn_offset);
 	}
 
-	omap_mcpdm_write(mcpdm, MCPDM_REG_FIFO_CTRL_DN, mcpdm->dn_threshold);
-	omap_mcpdm_write(mcpdm, MCPDM_REG_FIFO_CTRL_UP, mcpdm->up_threshold);
+	omap_mcpdm_write(mcpdm, MCPDM_REG_FIFO_CTRL_DN,
+			 mcpdm->config[SNDRV_PCM_STREAM_PLAYBACK].threshold);
+	omap_mcpdm_write(mcpdm, MCPDM_REG_FIFO_CTRL_UP,
+			 mcpdm->config[SNDRV_PCM_STREAM_CAPTURE].threshold);
 
 	omap_mcpdm_write(mcpdm, MCPDM_REG_DMAENABLE_SET,
 			MCPDM_DMA_DN_ENABLE | MCPDM_DMA_UP_ENABLE);
@@ -296,6 +300,7 @@ static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
 	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
 	int stream = substream->stream;
 	struct omap_pcm_dma_data *dma_data;
+	u32 threshold;
 	int channels;
 	int link_mask = 0;
 
@@ -325,15 +330,16 @@ static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
 
 	dma_data = snd_soc_dai_get_dma_data(dai, substream);
 
+	threshold = mcpdm->config[stream].threshold;
 	/* Configure McPDM channels, and DMA packet size */
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		mcpdm->dn_channels = link_mask << 3;
+		link_mask <<= 3;
 		dma_data->packet_size =
-			(MCPDM_DN_THRES_MAX - mcpdm->dn_threshold) * channels;
+				(MCPDM_DN_THRES_MAX - threshold) * channels;
 	} else {
-		mcpdm->up_channels = link_mask << 0;
-		dma_data->packet_size = mcpdm->up_threshold * channels;
+		dma_data->packet_size = threshold * channels;
 	}
+	mcpdm->config[stream].link_mask = link_mask;
 
 	return 0;
 }
@@ -380,8 +386,9 @@ static int omap_mcpdm_probe(struct snd_soc_dai *dai)
 	}
 
 	/* Configure McPDM threshold values */
-	mcpdm->dn_threshold = 2;
-	mcpdm->up_threshold = MCPDM_UP_THRES_MAX - 3;
+	mcpdm->config[SNDRV_PCM_STREAM_PLAYBACK].threshold = 2;
+	mcpdm->config[SNDRV_PCM_STREAM_CAPTURE].threshold =
+							MCPDM_UP_THRES_MAX - 3;
 	return ret;
 }
 
-- 
1.8.1.5
