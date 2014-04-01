From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 5/6] ASoC: davinic-mcasp: Adopt the AFIFO/DMA
	configuration to the stream (dynamic depth)
Date: Tue, 1 Apr 2014 15:55:11 +0300
Message-ID: <1396356912-30466-6-git-send-email-peter.ujfalusi@ti.com>
References: <1396356912-30466-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id F36FE2652C2
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 14:55:31 +0200 (CEST)
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

Configure the AFIFO numevt parameter based on the requested tx/rx_numevt,
active serializers and period size in words.
In this way McASP can adopt it's (and the DMA) configuration runtime and
can pick the most optimal setup which satisfy the parameters.
This way we do not need to place any constraint on the stream itself,
allowing application greater freedom on how they want to set up ALSA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index dd6910b289dd..9e877044a00a 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -458,7 +458,7 @@ static int davinci_config_channel_size(struct davinci_mcasp *mcasp,
 }
 
 static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
-				    int channels)
+				 int period_words, int channels)
 {
 	struct davinci_pcm_dma_params *dma_params = &mcasp->dma_params[stream];
 	struct snd_dmaengine_dai_dma_data *dma_data = &mcasp->dma_data[stream];
@@ -467,7 +467,7 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 	u8 rx_ser = 0;
 	u8 slots = mcasp->tdm_slots;
 	u8 max_active_serializers = (channels + slots - 1) / slots;
-	u8 active_serializers, numevt;
+	int active_serializers, numevt, n;
 	u32 reg;
 	/* Default configuration */
 	if (mcasp->version != MCASP_VERSION_4)
@@ -518,7 +518,6 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 		return -EINVAL;
 	}
 
-
 	/* AFIFO is not in use */
 	if (!numevt) {
 		/* Configure the burst size for platform drivers */
@@ -527,11 +526,26 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 		return 0;
 	}
 
-	if (numevt * active_serializers > MCASP_MAX_AFIFO_DEPTH)
+	if (period_words % active_serializers) {
+		dev_err(mcasp->dev, "Invalid combination of period words and "
+			"active serializers: %d, %d\n", period_words,
+			active_serializers);
+		return -EINVAL;
+	}
+
+	/*
+	 * Calculate the optimal AFIFO depth for platform side:
+	 * The number of words for numevt need to be in steps of active
+	 * serializers.
+	 */
+	n = numevt % active_serializers;
+	if (n)
+		numevt += (active_serializers - n);
+	while (period_words % numevt && numevt > 0)
+		numevt -= active_serializers;
+	if (numevt <= 0)
 		numevt = active_serializers;
 
-	/* Configure the AFIFO */
-	numevt *= active_serializers;
 	mcasp_mod_bits(mcasp, reg, active_serializers, NUMDMA_MASK);
 	mcasp_mod_bits(mcasp, reg, NUMEVT(numevt), NUMEVT_MASK);
 
@@ -656,6 +670,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 					&mcasp->dma_params[substream->stream];
 	int word_length;
 	int channels = params_channels(params);
+	int period_size = params_period_size(params);
 	int ret;
 
 	/* If mcasp is BCLK master we need to set BCLK divider */
@@ -669,7 +684,8 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 			cpu_dai, 1, mcasp->sysclk_freq / bclk_freq);
 	}
 
-	ret = mcasp_common_hw_param(mcasp, substream->stream, channels);
+	ret = mcasp_common_hw_param(mcasp, substream->stream,
+				    period_size * channels, channels);
 	if (ret)
 		return ret;
 
-- 
1.9.1
