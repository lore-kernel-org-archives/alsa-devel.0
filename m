From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/4] ASoC: davinci-mcasp: Code cleanup in
	davinci_mcasp_hw_params()
Date: Thu, 30 Jan 2014 15:15:25 +0200
Message-ID: <1391087725-4088-5-git-send-email-peter.ujfalusi@ti.com>
References: <1391087725-4088-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C417265496
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 14:15:39 +0100 (CET)
In-Reply-To: <1391087725-4088-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Rearrange the code in the function for readability.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index c1c1ac8945d4..48079dbad767 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -598,23 +598,13 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	u8 fifo_level;
 	u8 slots = mcasp->tdm_slots;
 	u8 active_serializers;
-	int channels;
+	int channels = params_channels(params);
 	int ret;
-	struct snd_interval *pcm_channels = hw_param_interval(params,
-					SNDRV_PCM_HW_PARAM_CHANNELS);
-	channels = pcm_channels->min;
-
-	active_serializers = (channels + slots - 1) / slots;
 
 	ret = mcasp_common_hw_param(mcasp, substream->stream, channels);
 	if (ret)
 		return ret;
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		fifo_level = mcasp->txnumevt * active_serializers;
-	else
-		fifo_level = mcasp->rxnumevt * active_serializers;
-
 	if (mcasp->op_mode == DAVINCI_MCASP_DIT_MODE)
 		ret = mcasp_dit_hw_param(mcasp);
 	else
@@ -655,6 +645,13 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/* Calculate FIFO level */
+	active_serializers = (channels + slots - 1) / slots;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		fifo_level = mcasp->txnumevt * active_serializers;
+	else
+		fifo_level = mcasp->rxnumevt * active_serializers;
+
 	if (mcasp->version == MCASP_VERSION_2 && !fifo_level)
 		dma_params->acnt = 4;
 	else
-- 
1.8.5.3
