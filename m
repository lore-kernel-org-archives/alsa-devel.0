From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Add rule to constrain the
	minimum period size
Date: Fri, 5 Jan 2018 12:18:07 +0200
Message-ID: <20180105101807.7360-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id CD520266CFE
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 11:18:03 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

The minimum period size (in frames) must be not lower than the FIFO size
of McASP and in general too small period size would easily result underrun
in applications as eDMA - the most common DMA servicing McASP have support
for limited number of periods.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

I have tried to use
snd_pcm_hw_constraint_minmax(..., SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 64, 0)

but with that the refining code was not able to find suitable configuration.

Regards,
Peter

 sound/soc/davinci/davinci-mcasp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 51c61a6861af..ba4da45902b8 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1263,6 +1263,20 @@ static int davinci_mcasp_hw_rule_format(struct snd_pcm_hw_params *params,
 	return snd_mask_refine(fmt, &nfmt);
 }
 
+static int davinci_mcasp_hw_rule_min_periodsize(
+		struct snd_pcm_hw_params *params, struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *period_size = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
+	struct snd_interval frames;
+
+	snd_interval_any(&frames);
+	frames.min = 64;
+	frames.integer = 1;
+
+	return snd_interval_refine(period_size, &frames);
+}
+
 static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *cpu_dai)
 {
@@ -1354,6 +1368,11 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 			return ret;
 	}
 
+	snd_pcm_hw_rule_add(substream->runtime, 0,
+			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+			    davinci_mcasp_hw_rule_min_periodsize, NULL,
+			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
+
 	return 0;
 }
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
