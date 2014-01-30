From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/3] ASoC: davinci-mcasp: Consolidate
	pm_runtime_get/put() use in the driver
Date: Thu, 30 Jan 2014 15:21:30 +0200
Message-ID: <1391088092-4157-2-git-send-email-peter.ujfalusi@ti.com>
References: <1391088092-4157-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id ABBCD265460
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 14:21:39 +0100 (CET)
In-Reply-To: <1391088092-4157-1-git-send-email-peter.ujfalusi@ti.com>
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

The use of pm_runtime in trigger() callback is not correct and it will lead
to unbalanced power.usage_count.
The only place which might need to call pm_runtime is the set_fmt callback.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 48079dbad767..be79dba789fb 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -263,7 +263,9 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 					 unsigned int fmt)
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(cpu_dai);
+	int ret = 0;
 
+	pm_runtime_get_sync(mcasp->dev);
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_B:
 	case SND_SOC_DAIFMT_AC97:
@@ -317,7 +319,8 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		break;
 
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -354,10 +357,12 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		break;
 
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	}
-
-	return 0;
+out:
+	pm_runtime_put_sync(mcasp->dev);
+	return ret;
 }
 
 static int davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
@@ -675,19 +680,9 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		ret = pm_runtime_get_sync(mcasp->dev);
-		if (IS_ERR_VALUE(ret))
-			dev_err(mcasp->dev, "pm_runtime_get_sync() failed\n");
 		davinci_mcasp_start(mcasp, substream->stream);
 		break;
-
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		davinci_mcasp_stop(mcasp, substream->stream);
-		ret = pm_runtime_put_sync(mcasp->dev);
-		if (IS_ERR_VALUE(ret))
-			dev_err(mcasp->dev, "pm_runtime_put_sync() failed\n");
-		break;
-
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		davinci_mcasp_stop(mcasp, substream->stream);
-- 
1.8.5.3
