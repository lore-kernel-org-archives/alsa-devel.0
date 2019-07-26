From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: ti: davinci-mcasp: Support for
	correct symmetric sample bits
Date: Fri, 26 Jul 2019 09:42:44 +0300
Message-ID: <20190726064244.3762-3-peter.ujfalusi@ti.com>
References: <20190726064244.3762-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51DF1F80368
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2019 08:42:51 +0200 (CEST)
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

Implement custom snd_pcm_hw_rule to filter the available formats for the
second stream to make it symmetric and allow only formats which require
the same amount of bits on the bus as the running stream.

A simple constraint is not working correctly because for example:
the first stream is started with S24_LE

If we place 24 as constraint for the SAMPLE_BITS then the second stream
can not use S24_LE as it is physically 32bits.

If we would place 32 as constraint (physical width) then S32_LE would have
been allowed, but S24_3LE is not.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/davinci-mcasp.c | 50 +++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 87ae19329e71..7aa3c32e4a49 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -109,6 +109,7 @@ struct davinci_mcasp {
 
 	/* Used for comstraint setting on the second stream */
 	u32	channels;
+	int	max_format_width;
 	u8	active_serializers[2];
 
 #ifdef CONFIG_GPIOLIB
@@ -766,6 +767,8 @@ static int davinci_config_channel_size(struct davinci_mcasp *mcasp,
 
 	if (mcasp->slot_width)
 		slot_width = mcasp->slot_width;
+	else if (mcasp->max_format_width)
+		slot_width = mcasp->max_format_width;
 	else
 		slot_width = sample_width;
 	/*
@@ -1233,8 +1236,11 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 
 	davinci_config_channel_size(mcasp, word_length);
 
-	if (mcasp->op_mode == DAVINCI_MCASP_IIS_MODE)
+	if (mcasp->op_mode == DAVINCI_MCASP_IIS_MODE) {
 		mcasp->channels = channels;
+		if (!mcasp->max_format_width)
+			mcasp->max_format_width = word_length;
+	}
 
 	return 0;
 }
@@ -1286,6 +1292,28 @@ static int davinci_mcasp_hw_rule_slot_width(struct snd_pcm_hw_params *params,
 	return snd_mask_refine(fmt, &nfmt);
 }
 
+static int davinci_mcasp_hw_rule_format_width(struct snd_pcm_hw_params *params,
+					      struct snd_pcm_hw_rule *rule)
+{
+	struct davinci_mcasp_ruledata *rd = rule->private;
+	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
+	struct snd_mask nfmt;
+	int i, format_width;
+
+	snd_mask_none(&nfmt);
+	format_width = rd->mcasp->max_format_width;
+
+	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
+		if (snd_mask_test(fmt, i)) {
+			if (snd_pcm_format_width(i) == format_width) {
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
@@ -1463,7 +1491,20 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 				   0, SNDRV_PCM_HW_PARAM_CHANNELS,
 				   &mcasp->chconstr[substream->stream]);
 
-	if (mcasp->slot_width) {
+	if (mcasp->max_format_width) {
+		/*
+		 * Only allow formats which require same amount of bits on the
+		 * bus as the currently running stream
+		 */
+		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
+					  SNDRV_PCM_HW_PARAM_FORMAT,
+					  davinci_mcasp_hw_rule_format_width,
+					  ruledata,
+					  SNDRV_PCM_HW_PARAM_FORMAT, -1);
+		if (ret)
+			return ret;
+	}
+	else if (mcasp->slot_width) {
 		/* Only allow formats require <= slot_width bits on the bus */
 		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
 					  SNDRV_PCM_HW_PARAM_FORMAT,
@@ -1514,8 +1555,10 @@ static void davinci_mcasp_shutdown(struct snd_pcm_substream *substream,
 	if (mcasp->op_mode == DAVINCI_MCASP_DIT_MODE)
 		return;
 
-	if (!cpu_dai->active)
+	if (!cpu_dai->active) {
 		mcasp->channels = 0;
+		mcasp->max_format_width = 0;
+	}
 }
 
 static const struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
@@ -1571,7 +1614,6 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 		},
 		.ops 		= &davinci_mcasp_dai_ops,
 
-		.symmetric_samplebits	= 1,
 		.symmetric_rates	= 1,
 	},
 	{
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
