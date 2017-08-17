From: srinivas.kandagatla@linaro.org
Subject: [PATCH v4 3/3] ASoC: qcom: apq8016-sbc: Add support to Headset JACK
Date: Thu, 17 Aug 2017 10:02:11 +0200
Message-ID: <20170817080211.11453-4-srinivas.kandagatla@linaro.org>
References: <20170817080211.11453-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170817080211.11453-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: damien.riegel@savoirfairelinux.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to Headset JACK, also provides board specific
vref ranges for mbhc buttons to be detected.

This headset supports both 3 pole and 4 pole headset type and 5 buttons.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8016_sbc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index f07aa1e1cdfe..e6e632aa0fab 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -21,12 +21,16 @@
 #include <linux/platform_device.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/jack.h>
 #include <sound/soc.h>
+#include <uapi/linux/input-event-codes.h>
 #include <dt-bindings/sound/apq8016-lpass.h>
 
 struct apq8016_sbc_data {
 	void __iomem *mic_iomux;
 	void __iomem *spkr_iomux;
+	struct snd_soc_jack jack;
+	bool jack_setup;
 	struct snd_soc_dai_link dai_link[];	/* dynamically allocated */
 };
 
@@ -70,6 +74,31 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 
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
+		pdata->jack_setup = true;
+	}
+
 	for (i = 0 ; i < dai_link->num_codecs; i++) {
 		struct snd_soc_dai *dai = rtd->codec_dais[i];
 
@@ -81,6 +110,11 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 			dev_warn(card->dev, "Failed to set mclk: %d\n", rval);
 			return rval;
 		}
+		rval = snd_soc_codec_set_jack(codec, &pdata->jack, NULL);
+		if (rval != 0 && rval != -ENOTSUPP) {
+			dev_warn(card->dev, "Failed to set jack: %d\n", rval);
+			return rval;
+		}
 	}
 
 	return 0;
-- 
2.11.0
