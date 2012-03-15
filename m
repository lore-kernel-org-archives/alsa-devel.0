From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: omap-mcbsp: Remove unused FRAME
	dma_op_mode
Date: Thu, 15 Mar 2012 12:37:14 +0200
Message-ID: <1331807834-25675-3-git-send-email-peter.ujfalusi@ti.com>
References: <1331807834-25675-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 175E01045D3
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 11:37:29 +0100 (CET)
Received: by lahl5 with SMTP id l5so2497031lah.29
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 03:37:27 -0700 (PDT)
In-Reply-To: <1331807834-25675-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The frame dma_op_mode has never been used, and it is just creating
confusion for users/developers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/mcbsp.c      |    2 +-
 sound/soc/omap/mcbsp.h      |    1 -
 sound/soc/omap/omap-mcbsp.c |    1 -
 3 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index e5f4444..ec6832c 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -754,7 +754,7 @@ THRESHOLD_PROP_BUILDER(max_tx_thres);
 THRESHOLD_PROP_BUILDER(max_rx_thres);
 
 static const char *dma_op_modes[] = {
-	"element", "threshold", "frame",
+	"element", "threshold",
 };
 
 static ssize_t dma_op_mode_show(struct device *dev,
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index a944fcc..179a822 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -217,7 +217,6 @@ enum {
 /********************** McBSP DMA operating modes **************************/
 #define MCBSP_DMA_MODE_ELEMENT		0
 #define MCBSP_DMA_MODE_THRESHOLD	1
-#define MCBSP_DMA_MODE_FRAME		2
 
 /********************** McBSP WAKEUPEN bit definitions *********************/
 #define RSYNCERREN		BIT(0)
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 418dc3c..27144a6 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -245,7 +245,6 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	}
 	if (mcbsp->pdata->buffer_size) {
 		dma_data->set_threshold = omap_mcbsp_set_threshold;
-		/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
 		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD) {
 			int period_words, max_thrsh;
 
-- 
1.7.8.5
