From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/6] ASoC: davinci-mcasp: Assign the dma_data
	earlier in dai_probe callback
Date: Tue, 1 Apr 2014 15:55:07 +0300
Message-ID: <1396356912-30466-2-git-send-email-peter.ujfalusi@ti.com>
References: <1396356912-30466-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 99D072652C2
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 14:55:22 +0200 (CEST)
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

Set up the playback_dma_data/capture_dma_data for the dai at probe
time since the generic dmaengine PCM stack needs to have access to
this information early.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 01d224c4992b..5a83fac15089 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -752,22 +752,7 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
-				 struct snd_soc_dai *dai)
-{
-	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
-
-	if (mcasp->version == MCASP_VERSION_4)
-		snd_soc_dai_set_dma_data(dai, substream,
-					&mcasp->dma_data[substream->stream]);
-	else
-		snd_soc_dai_set_dma_data(dai, substream, mcasp->dma_params);
-
-	return 0;
-}
-
 static const struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
-	.startup	= davinci_mcasp_startup,
 	.trigger	= davinci_mcasp_trigger,
 	.hw_params	= davinci_mcasp_hw_params,
 	.set_fmt	= davinci_mcasp_set_dai_fmt,
@@ -775,6 +760,25 @@ static const struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
 	.set_sysclk	= davinci_mcasp_set_sysclk,
 };
 
+static int davinci_mcasp_dai_probe(struct snd_soc_dai *dai)
+{
+	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
+
+	if (mcasp->version == MCASP_VERSION_4) {
+		/* Using dmaengine PCM */
+		dai->playback_dma_data =
+				&mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
+		dai->capture_dma_data =
+				&mcasp->dma_data[SNDRV_PCM_STREAM_CAPTURE];
+	} else {
+		/* Using davinci-pcm */
+		dai->playback_dma_data = mcasp->dma_params;
+		dai->capture_dma_data = mcasp->dma_params;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int davinci_mcasp_suspend(struct snd_soc_dai *dai)
 {
@@ -828,6 +832,7 @@ static int davinci_mcasp_resume(struct snd_soc_dai *dai)
 static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 	{
 		.name		= "davinci-mcasp.0",
+		.probe		= davinci_mcasp_dai_probe,
 		.suspend	= davinci_mcasp_suspend,
 		.resume		= davinci_mcasp_resume,
 		.playback	= {
@@ -847,6 +852,7 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 	},
 	{
 		.name		= "davinci-mcasp.1",
+		.probe		= davinci_mcasp_dai_probe,
 		.playback 	= {
 			.channels_min	= 1,
 			.channels_max	= 384,
-- 
1.9.1
