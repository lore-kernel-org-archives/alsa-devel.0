From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/4] ASoC: davinci-mcasp: Harmonize the sub
	hw_params function names
Date: Thu, 30 Jan 2014 15:15:22 +0200
Message-ID: <1391087725-4088-2-git-send-email-peter.ujfalusi@ti.com>
References: <1391087725-4088-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id EF760265460
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 14:15:35 +0100 (CET)
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

Instead of
davinci_hw_common_param - for common, I2S/DIT mode settings
davinci_hw_dit_param - for DIT protocol configuration
davinci_hw_param - for I2S (and compatible protocols)

Use the following names:
mcasp_common_hw_param, mcasp_dit_hw_param and mcasp_i2s_hw_param.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index b7858bfa0295..9ec456aaf80b 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -448,7 +448,7 @@ static int davinci_config_channel_size(struct davinci_mcasp *mcasp,
 	return 0;
 }
 
-static int davinci_hw_common_param(struct davinci_mcasp *mcasp, int stream,
+static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 				    int channels)
 {
 	int i;
@@ -524,7 +524,7 @@ static int davinci_hw_common_param(struct davinci_mcasp *mcasp, int stream,
 	return 0;
 }
 
-static void davinci_hw_param(struct davinci_mcasp *mcasp, int stream)
+static void mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream)
 {
 	int i, active_slots;
 	u32 mask = 0;
@@ -567,7 +567,7 @@ static void davinci_hw_param(struct davinci_mcasp *mcasp, int stream)
 }
 
 /* S/PDIF */
-static void davinci_hw_dit_param(struct davinci_mcasp *mcasp)
+static void mcasp_dit_hw_param(struct davinci_mcasp *mcasp)
 {
 	/* Set the TX format : 24 bit right rotation, 32 bit slot, Pad 0
 	   and LSB first */
@@ -611,7 +611,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 
 	active_serializers = (channels + slots - 1) / slots;
 
-	if (davinci_hw_common_param(mcasp, substream->stream, channels) == -EINVAL)
+	if (mcasp_common_hw_param(mcasp, substream->stream, channels) == -EINVAL)
 		return -EINVAL;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		fifo_level = mcasp->txnumevt * active_serializers;
@@ -619,9 +619,9 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 		fifo_level = mcasp->rxnumevt * active_serializers;
 
 	if (mcasp->op_mode == DAVINCI_MCASP_DIT_MODE)
-		davinci_hw_dit_param(mcasp);
+		mcasp_dit_hw_param(mcasp);
 	else
-		davinci_hw_param(mcasp, substream->stream);
+		mcasp_i2s_hw_param(mcasp, substream->stream);
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_U8:
-- 
1.8.5.3
