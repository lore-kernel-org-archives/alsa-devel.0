From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Fix ruledata setup in
	davinci_mcasp_startup
Date: Tue, 7 Apr 2015 14:03:53 +0300
Message-ID: <1428404633-25365-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 443D42604BD
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 13:03:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, liam.r.girdwood@linux.intel.com, jsarha@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Passing &mcasp->ruledata[dir] to snd_pcm_hw_rule_add() is not correct since
commit:
7b3d165a2821 ASoC: davinci-mcasp: Index ruledata in drvdata with substream->stream
now sets up the struct based on the substream->stream (0 or 1) while we pass
a pointer which we take with dir (1 or 2). This will lead kernel crash.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 0b6b1b286201..bb4b78eada58 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1128,6 +1128,8 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *cpu_dai)
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(cpu_dai);
+	struct davinci_mcasp_ruledata *ruledata =
+					&mcasp->ruledata[substream->stream];
 	u32 max_channels = 0;
 	int i, dir;
 
@@ -1149,7 +1151,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 		if (mcasp->serial_dir[i] == dir)
 			max_channels++;
 	}
-	mcasp->ruledata[substream->stream].serializers = max_channels;
+	ruledata->serializers = max_channels;
 	max_channels *= mcasp->tdm_slots;
 	/*
 	 * If the already active stream has less channels than the calculated
@@ -1172,12 +1174,12 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	if (mcasp->bclk_master && mcasp->bclk_div == 0 && mcasp->sysclk_freq) {
 		int ret;
 
-		mcasp->ruledata[substream->stream].mcasp = mcasp;
+		ruledata->mcasp = mcasp;
 
 		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
 					  SNDRV_PCM_HW_PARAM_RATE,
 					  davinci_mcasp_hw_rule_rate,
-					  &mcasp->ruledata[dir],
+					  ruledata,
 					  SNDRV_PCM_HW_PARAM_FORMAT,
 					  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 		if (ret)
@@ -1185,7 +1187,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
 					  SNDRV_PCM_HW_PARAM_FORMAT,
 					  davinci_mcasp_hw_rule_format,
-					  &mcasp->ruledata[dir],
+					  ruledata,
 					  SNDRV_PCM_HW_PARAM_RATE,
 					  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 		if (ret)
@@ -1193,7 +1195,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
 					  SNDRV_PCM_HW_PARAM_CHANNELS,
 					  davinci_mcasp_hw_rule_channels,
-					  &mcasp->ruledata[dir],
+					  ruledata,
 					  SNDRV_PCM_HW_PARAM_RATE,
 					  SNDRV_PCM_HW_PARAM_FORMAT, -1);
 		if (ret)
-- 
2.3.5
