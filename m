From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: ti: davinci-mcasp: Correct
	slot_width posed constraint
Date: Fri, 26 Jul 2019 09:42:43 +0300
Message-ID: <20190726064244.3762-2-peter.ujfalusi@ti.com>
References: <20190726064244.3762-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F4111F800E8
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2019 08:42:50 +0200 (CEST)
In-Reply-To: <20190726064244.3762-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, tiwai@suse.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

The slot_width is a property for the bus while the constraint for
SNDRV_PCM_HW_PARAM_SAMPLE_BITS is for the in memory format.

Applying slot_width constraint to sample_bits works most of the time, but
it will blacklist valid formats in some cases.

With slot_width 24 we can support S24_3LE and S24_LE formats as they both
look the same on the bus, but a a 24 constraint on sample_bits would not
allow S24_LE as it is stored in 32bits in memory.

Implement a simple hw_rule function to allow all formats which require less
or equal number of bits on the bus as slot_width (if configured).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/davinci-mcasp.c | 43 ++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 7c2081b63a60..87ae19329e71 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -1264,6 +1264,28 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int davinci_mcasp_hw_rule_slot_width(struct snd_pcm_hw_params *params,
+					    struct snd_pcm_hw_rule *rule)
+{
+	struct davinci_mcasp_ruledata *rd = rule->private;
+	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
+	struct snd_mask nfmt;
+	int i, slot_width;
+
+	snd_mask_none(&nfmt);
+	slot_width = rd->mcasp->slot_width;
+
+	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
+		if (snd_mask_test(fmt, i)) {
+			if (snd_pcm_format_width(i) <= slot_width) {
+				snd_mask_set(&nfmt, i);
+			}
+		}
+	}
+
+	return snd_mask_refine(fmt, &nfmt);
+}
+
 static const unsigned int davinci_mcasp_dai_rates[] = {
 	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000,
 	88200, 96000, 176400, 192000,
@@ -1385,7 +1407,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	struct davinci_mcasp_ruledata *ruledata =
 					&mcasp->ruledata[substream->stream];
 	u32 max_channels = 0;
-	int i, dir;
+	int i, dir, ret;
 	int tdm_slots = mcasp->tdm_slots;
 
 	/* Do not allow more then one stream per direction */
@@ -1414,6 +1436,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 			max_channels++;
 	}
 	ruledata->serializers = max_channels;
+	ruledata->mcasp = mcasp;
 	max_channels *= tdm_slots;
 	/*
 	 * If the already active stream has less channels than the calculated
@@ -1440,20 +1463,22 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 				   0, SNDRV_PCM_HW_PARAM_CHANNELS,
 				   &mcasp->chconstr[substream->stream]);
 
-	if (mcasp->slot_width)
-		snd_pcm_hw_constraint_minmax(substream->runtime,
-					     SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
-					     8, mcasp->slot_width);
+	if (mcasp->slot_width) {
+		/* Only allow formats require <= slot_width bits on the bus */
+		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
+					  SNDRV_PCM_HW_PARAM_FORMAT,
+					  davinci_mcasp_hw_rule_slot_width,
+					  ruledata,
+					  SNDRV_PCM_HW_PARAM_FORMAT, -1);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * If we rely on implicit BCLK divider setting we should
 	 * set constraints based on what we can provide.
 	 */
 	if (mcasp->bclk_master && mcasp->bclk_div == 0 && mcasp->sysclk_freq) {
-		int ret;
-
-		ruledata->mcasp = mcasp;
-
 		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
 					  SNDRV_PCM_HW_PARAM_RATE,
 					  davinci_mcasp_hw_rule_rate,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
