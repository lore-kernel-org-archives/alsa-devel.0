From: srinivas.kandagatla@linaro.org
Subject: [PATCH v1 6/6] ASoC: qcom: apq8016-sbc: Add support to Headset JACK
Date: Wed, 26 Jul 2017 02:35:12 +0200
Message-ID: <20170726003512.18965-7-srinivas.kandagatla@linaro.org>
References: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to Headset JACK, also provides board specific
vref ranges for mbhc buttons to be detected.

This headset supports both 3 pole and 5 pole headset type and 5 buttons.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8016_sbc.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index f07aa1e..ccb3620 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -21,12 +21,18 @@
 #include <linux/platform_device.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/jack.h>
 #include <sound/soc.h>
+#include <uapi/linux/input-event-codes.h>
 #include <dt-bindings/sound/apq8016-lpass.h>
+#include "../codecs/msm8916-wcd.h"
 
 struct apq8016_sbc_data {
 	void __iomem *mic_iomux;
 	void __iomem *spkr_iomux;
+	struct snd_soc_jack jack;
+	struct msm8916_wcd_mbhc_data mbhc_data;
+	bool jack_setup;
 	struct snd_soc_dai_link dai_link[];	/* dynamically allocated */
 };
 
@@ -43,6 +49,7 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dai_link *dai_link = rtd->dai_link;
 	struct snd_soc_card *card = rtd->card;
 	struct apq8016_sbc_data *pdata = snd_soc_card_get_drvdata(card);
+	struct msm8916_wcd_mbhc_data *data;
 	int i, rval;
 
 	switch (cpu_dai->id) {
@@ -70,6 +77,45 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 
 	}
 
+	if (!pdata->jack_setup) {
+		struct snd_jack *jack;
+
+		rval = snd_soc_card_jack_new(card, "Headset Jack",
+					     SND_JACK_HEADSET |
+					     SND_JACK_HEADPHONE |
+					     SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					     SND_JACK_BTN_2 | SND_JACK_BTN_3 |
+					     SND_JACK_BTN_4,
+					     &pdata->jack, NULL, 0);
+
+		if (rval < 0) {
+			dev_err(card->dev, "Unable to add Headphone Jack\n");
+			return rval;
+		}
+
+		jack = pdata->jack.jack;
+
+		snd_jack_set_key(jack, SND_JACK_BTN_0, KEY_MEDIA);
+		snd_jack_set_key(jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+		snd_jack_set_key(jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+		snd_jack_set_key(jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+
+		/* board specific vref thresholds in mv */
+		data = &pdata->mbhc_data;
+		data->vref_btn_cs[0] = 75;
+		data->vref_btn_micb[0] = 75;
+		data->vref_btn_cs[1] = 150;
+		data->vref_btn_micb[1] = 150;
+		data->vref_btn_cs[2] = 237;
+		data->vref_btn_micb[2] = 237;
+		data->vref_btn_cs[3] = 450;
+		data->vref_btn_micb[3] = 450;
+		data->vref_btn_cs[4] = 500;
+		data->vref_btn_micb[4] = 500;
+
+		pdata->jack_setup = true;
+	}
+
 	for (i = 0 ; i < dai_link->num_codecs; i++) {
 		struct snd_soc_dai *dai = rtd->codec_dais[i];
 
@@ -81,6 +127,12 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 			dev_warn(card->dev, "Failed to set mclk: %d\n", rval);
 			return rval;
 		}
+		rval = snd_soc_codec_set_jack(codec, &pdata->jack,
+					      &pdata->mbhc_data);
+		if (rval != 0 && rval != -ENOTSUPP) {
+			dev_warn(card->dev, "Failed to set jack: %d\n", rval);
+			return rval;
+		}
 	}
 
 	return 0;
-- 
2.9.3
