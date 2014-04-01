From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 6/6] ASoC: davinci-mcasp: Fine tune and correct
	the DMA burst configuration
Date: Tue, 1 Apr 2014 15:55:12 +0300
Message-ID: <1396356912-30466-7-git-send-email-peter.ujfalusi@ti.com>
References: <1396356912-30466-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DDF9265466
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 14:55:32 +0200 (CEST)
In-Reply-To: <1396356912-30466-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: detheridge@ti.com, alsa-devel@alsa-project.org, nsekhar@ti.com, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

When the AFIFO is not enabled but more than one serializers are used the DMA
need to transfer number of words equal to active serializers when a DMA
request is generated.
When configuring the burst for the DMA avoid using value '1' for the burst
since it is going to enable additional logic in the DMA drivers. Burst '1'
means that the DMA should send/receive one word per DMA requests.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 9e877044a00a..52fc6bbd56bd 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -521,8 +521,19 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 	/* AFIFO is not in use */
 	if (!numevt) {
 		/* Configure the burst size for platform drivers */
-		dma_params->fifo_level = 0;
-		dma_data->maxburst = 0;
+		if (active_serializers > 1) {
+			/*
+			 * If more than one serializers are in use we have one
+			 * DMA request to provide data for all serializers.
+			 * For example if three serializers are enabled the DMA
+			 * need to transfer three words per DMA request.
+			 */
+			dma_params->fifo_level = active_serializers;
+			dma_data->maxburst = active_serializers;
+		} else {
+			dma_params->fifo_level = 0;
+			dma_data->maxburst = 0;
+		}
 		return 0;
 	}
 
@@ -550,6 +561,8 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 	mcasp_mod_bits(mcasp, reg, NUMEVT(numevt), NUMEVT_MASK);
 
 	/* Configure the burst size for platform drivers */
+	if (numevt == 1)
+		numevt = 0;
 	dma_params->fifo_level = numevt;
 	dma_data->maxburst = numevt;
 
-- 
1.9.1
