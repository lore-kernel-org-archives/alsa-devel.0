From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: pcm3168a: Implement set_tdm_slot callback
Date: Tue, 4 Jun 2019 14:12:49 +0300
Message-ID: <20190604111249.17893-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23FAAF896CE
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2019 13:12:27 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Initially we only going to care about the slot_width as for example
DSP_A/B needs 32 bclk per slots and to be able to use TDM mode the codec
(and CPU) needs to use DSP_A/B modes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/pcm3168a.c | 60 ++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index e0d5839fe1a7..9eb24ca09793 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -56,6 +56,9 @@ struct pcm3168a_priv {
 	unsigned long sysclk;
 	unsigned int adc_fmt;
 	unsigned int dac_fmt;
+	int tdm_slots;
+	u32 tdm_mask[2];
+	int slot_width;
 };
 
 static const char *const pcm3168a_roll_off[] = { "Sharp", "Slow" };
@@ -387,6 +390,41 @@ static int pcm3168a_set_dai_fmt_adc(struct snd_soc_dai *dai,
 	return pcm3168a_set_dai_fmt(dai, format, false);
 }
 
+static int pcm3168a_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+				 unsigned int rx_mask, int slots,
+				 int slot_width)
+{
+	struct snd_soc_component *component = dai->component;
+	struct pcm3168a_priv *pcm3168a = snd_soc_component_get_drvdata(component);
+
+	if (tx_mask >= (1<<slots) || rx_mask >= (1<<slots)) {
+		dev_err(component->dev,
+			"Bad tdm mask tx: 0x%08x rx: 0x%08x slots %d\n",
+			tx_mask, rx_mask, slots);
+		return -EINVAL;
+	}
+
+	if (slot_width &&
+	    (slot_width != 16 && slot_width != 24 && slot_width != 32 )) {
+		dev_err(component->dev, "Unsupported slot_width %d\n",
+			slot_width);
+		return -EINVAL;
+	}
+
+	pcm3168a->tdm_slots = slots;
+	pcm3168a->tdm_mask[SNDRV_PCM_STREAM_PLAYBACK] = tx_mask;
+	pcm3168a->tdm_mask[SNDRV_PCM_STREAM_CAPTURE] = rx_mask;
+
+	if (pcm3168a->slot_width && pcm3168a->slot_width != slot_width) {
+		dev_err(component->dev, "Not matching slot_width %d vs %d\n",
+			pcm3168a->slot_width, slot_width);
+		return -EINVAL;
+	}
+
+	pcm3168a->slot_width = slot_width;
+	return 0;
+}
+
 static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
@@ -431,22 +469,26 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	min_frame_size = params_width(params) * 2;
+	if (pcm3168a->slot_width)
+		min_frame_size = pcm3168a->slot_width;
+	else
+		min_frame_size = params_width(params);
+
 	switch (min_frame_size) {
-	case 32:
+	case 16:
 		if (master_mode || (fmt != PCM3168A_FMT_RIGHT_J)) {
-			dev_err(component->dev, "32-bit frames are supported only for slave mode using right justified\n");
+			dev_err(component->dev, "16-bit slots are supported only for slave mode using right justified\n");
 			return -EINVAL;
 		}
 		fmt = PCM3168A_FMT_RIGHT_J_16;
 		break;
-	case 48:
+	case 24:
 		if (master_mode || (fmt & PCM3168A_FMT_DSP_MASK)) {
-			dev_err(component->dev, "48-bit frames not supported in master mode, or slave mode using DSP\n");
+			dev_err(component->dev, "24-bit slots not supported in master mode, or slave mode using DSP\n");
 			return -EINVAL;
 		}
 		break;
-	case 64:
+	case 32:
 		break;
 	default:
 		dev_err(component->dev, "unsupported frame size: %d\n", min_frame_size);
@@ -554,14 +596,16 @@ static const struct snd_soc_dai_ops pcm3168a_dac_dai_ops = {
 	.set_fmt	= pcm3168a_set_dai_fmt_dac,
 	.set_sysclk	= pcm3168a_set_dai_sysclk,
 	.hw_params	= pcm3168a_hw_params,
-	.digital_mute	= pcm3168a_digital_mute
+	.digital_mute	= pcm3168a_digital_mute,
+	.set_tdm_slot	= pcm3168a_set_tdm_slot,
 };
 
 static const struct snd_soc_dai_ops pcm3168a_adc_dai_ops = {
 	.startup	= pcm3168a_startup,
 	.set_fmt	= pcm3168a_set_dai_fmt_adc,
 	.set_sysclk	= pcm3168a_set_dai_sysclk,
-	.hw_params	= pcm3168a_hw_params
+	.hw_params	= pcm3168a_hw_params,
+	.set_tdm_slot	= pcm3168a_set_tdm_slot,
 };
 
 static struct snd_soc_dai_driver pcm3168a_dais[] = {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
