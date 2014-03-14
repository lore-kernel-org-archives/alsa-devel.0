From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 4/4] ASoC: davinci-mcasp: Assign the
	dma_data earlier in dai_probe callback
Date: Fri, 14 Mar 2014 16:42:48 +0200
Message-ID: <1394808168-32608-5-git-send-email-peter.ujfalusi@ti.com>
References: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C7412654C2
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 15:43:03 +0100 (CET)
In-Reply-To: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, nsekhar@ti.com, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Set up the playback_dma_data/capture_dma_data for the dai at probe
time since the generic dmaengine PCM stack needs to have access to
this information early.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 3ca6e8c4568a..a846288371bf 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -722,12 +722,6 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
 	int afifo_numevt;
 
-	if (mcasp->version == MCASP_VERSION_4)
-		snd_soc_dai_set_dma_data(dai, substream,
-					&mcasp->dma_data[substream->stream]);
-	else
-		snd_soc_dai_set_dma_data(dai, substream, mcasp->dma_params);
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		afifo_numevt = mcasp->txnumevt;
 	else
@@ -755,6 +749,25 @@ static const struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
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
@@ -808,6 +821,7 @@ static int davinci_mcasp_resume(struct snd_soc_dai *dai)
 static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 	{
 		.name		= "davinci-mcasp.0",
+		.probe		= davinci_mcasp_dai_probe,
 		.suspend	= davinci_mcasp_suspend,
 		.resume		= davinci_mcasp_resume,
 		.playback	= {
-- 
1.9.0
