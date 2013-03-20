From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/3] ASoC: omap-mcpdm: Fix for full duplex
	audio use case
Date: Wed, 20 Mar 2013 10:47:13 +0100
Message-ID: <1363772834-29820-3-git-send-email-peter.ujfalusi@ti.com>
References: <1363772834-29820-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 14FC92616FC
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2013 10:47:22 +0100 (CET)
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

Due to HW limitation within OMAP McPDM IP uplink and downlink need to be
started at the same time. This causes issues when we have two streams
running, for example:
arecord | aplay

In this case the playback stream would have no channels enabled since at the
capture start we are not aware that a playback is going to start.

The workaround is to configure the other direction to stereo when the first
stream is started. When the second stream is coming we check the new stream's
number of channels against the pre-configured channels. If it does not match
we stop and restart McPDM to update the configuration. This might result a
small pop. If the coming stream is a match we do nothing in the McPDM driver.

This workaround can handle most use cases without the need to restart McPDM.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 6e19f44..cd0e2ec 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -63,6 +63,9 @@ struct omap_mcpdm {
 
 	/* McPDM dn offsets for rx1, and 2 channels */
 	u32 dn_rx_offset;
+
+	/* McPDM needs to be restarted due to runtime reconfiguration */
+	bool restart;
 };
 
 /*
@@ -149,7 +152,7 @@ static void omap_mcpdm_start(struct omap_mcpdm *mcpdm)
 static void omap_mcpdm_stop(struct omap_mcpdm *mcpdm)
 {
 	u32 ctrl = omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
-	u32 link_mask = mcpdm->config[0].link_mask | mcpdm->config[1].link_mask;
+	u32 link_mask = MCPDM_PDM_DN_MASK | MCPDM_PDM_UP_MASK;
 
 	ctrl |= (MCPDM_SW_DN_RST | MCPDM_SW_UP_RST);
 	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
@@ -287,6 +290,8 @@ static void omap_mcpdm_dai_shutdown(struct snd_pcm_substream *substream,
 		if (omap_mcpdm_active(mcpdm)) {
 			omap_mcpdm_stop(mcpdm);
 			omap_mcpdm_close_streams(mcpdm);
+			mcpdm->config[0].link_mask = 0;
+			mcpdm->config[1].link_mask = 0;
 		}
 	}
 
@@ -334,11 +339,26 @@ static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
 	/* Configure McPDM channels, and DMA packet size */
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		link_mask <<= 3;
+
+		/* If capture is not running assume a stereo stream to come */
+		if (!mcpdm->config[!stream].link_mask)
+			mcpdm->config[!stream].link_mask = 0x3;
+
 		dma_data->packet_size =
 				(MCPDM_DN_THRES_MAX - threshold) * channels;
 	} else {
+		/* If playback is not running assume a stereo stream to come */
+		if (!mcpdm->config[!stream].link_mask)
+			mcpdm->config[!stream].link_mask = (0x3 << 3);
+
 		dma_data->packet_size = threshold * channels;
 	}
+
+	/* Check if we need to restart McPDM with this stream */
+	if (mcpdm->config[stream].link_mask &&
+	    mcpdm->config[stream].link_mask != link_mask)
+		mcpdm->restart = true;
+
 	mcpdm->config[stream].link_mask = link_mask;
 
 	return 0;
@@ -352,6 +372,11 @@ static int omap_mcpdm_prepare(struct snd_pcm_substream *substream,
 	if (!omap_mcpdm_active(mcpdm)) {
 		omap_mcpdm_start(mcpdm);
 		omap_mcpdm_reg_dump(mcpdm);
+	} else if (mcpdm->restart) {
+		omap_mcpdm_stop(mcpdm);
+		omap_mcpdm_start(mcpdm);
+		mcpdm->restart = false;
+		omap_mcpdm_reg_dump(mcpdm);
 	}
 
 	return 0;
-- 
1.8.1.5
