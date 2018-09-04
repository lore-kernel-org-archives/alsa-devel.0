From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 13/13] ASoC: apq8096: add headset JACK support
Date: Tue,  4 Sep 2018 11:25:00 +0100
Message-ID: <20180904102500.30318-14-srinivas.kandagatla@linaro.org>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8096.c | 53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index db07e9b62daf..78b245261477 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -5,14 +5,21 @@
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
 #include <sound/soc.h>
+#include <sound/jack.h>
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
+#include <uapi/linux/input-event-codes.h>
 #include "common.h"
 
 #define SLIM_MAX_TX_PORTS 16
 #define SLIM_MAX_RX_PORTS 16
 #define WCD9335_DEFAULT_MCLK_RATE	9600000
 
+struct apq8096_card_data {
+	struct snd_soc_jack jack;
+	bool jack_setup;
+};
+
 static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				      struct snd_pcm_hw_params *params)
 {
@@ -65,6 +72,7 @@ static struct snd_soc_ops apq8096_ops = {
 static int apq8096_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct apq8096_card_data *data = snd_soc_card_get_drvdata(rtd->card);
 
 	/*
 	 * Codec SLIMBUS configuration
@@ -77,6 +85,8 @@ static int apq8096_init(struct snd_soc_pcm_runtime *rtd)
 	unsigned int tx_ch[SLIM_MAX_TX_PORTS] = {128, 129, 130, 131, 132, 133,
 					    134, 135, 136, 137, 138, 139,
 					    140, 141, 142, 143};
+	struct snd_soc_card *card = rtd->card;
+	int rval;
 
 	snd_soc_dai_set_channel_map(codec_dai, ARRAY_SIZE(tx_ch),
 					tx_ch, ARRAY_SIZE(rx_ch), rx_ch);
@@ -84,6 +94,38 @@ static int apq8096_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dai_set_sysclk(codec_dai, 0, WCD9335_DEFAULT_MCLK_RATE,
 				SNDRV_PCM_STREAM_PLAYBACK);
 
+	if (!data->jack_setup) {
+		struct snd_jack *jack;
+
+		rval = snd_soc_card_jack_new(card, "Headset Jack",
+					     SND_JACK_HEADSET |
+					     SND_JACK_HEADPHONE |
+					     SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					     SND_JACK_BTN_2 | SND_JACK_BTN_3 |
+					     SND_JACK_BTN_4,
+					     &data->jack, NULL, 0);
+
+		if (rval < 0) {
+			dev_err(card->dev, "Unable to add Headphone Jack\n");
+			return rval;
+		}
+
+		jack = data->jack.jack;
+
+		snd_jack_set_key(jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+		snd_jack_set_key(jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+		snd_jack_set_key(jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+		snd_jack_set_key(jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+		data->jack_setup = true;
+	}
+
+	rval = snd_soc_component_set_jack(codec_dai->component,
+					 &data->jack, NULL);
+	if (rval != 0 && rval != -ENOTSUPP) {
+		dev_warn(card->dev, "Failed to set jack: %d\n", rval);
+		return rval;
+	}
+
 	return 0;
 }
 
@@ -104,6 +146,7 @@ static void apq8096_add_be_ops(struct snd_soc_card *card)
 
 static int apq8096_platform_probe(struct platform_device *pdev)
 {
+	struct apq8096_card_data *data;
 	struct snd_soc_card *card;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -112,8 +155,15 @@ static int apq8096_platform_probe(struct platform_device *pdev)
 	if (!card)
 		return -ENOMEM;
 
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		kfree(card);
+		return -ENOMEM;
+	}
+
 	card->dev = dev;
 	dev_set_drvdata(dev, card);
+	snd_soc_card_set_drvdata(card, data);
 	ret = qcom_snd_parse_of(card);
 	if (ret) {
 		dev_err(dev, "Error parsing OF data\n");
@@ -131,16 +181,19 @@ static int apq8096_platform_probe(struct platform_device *pdev)
 	kfree(card->dai_link);
 err:
 	kfree(card);
+	kfree(data);
 	return ret;
 }
 
 static int apq8096_platform_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = dev_get_drvdata(&pdev->dev);
+	struct apq8096_card_data *data = snd_soc_card_get_drvdata(card);
 
 	snd_soc_unregister_card(card);
 	kfree(card->dai_link);
 	kfree(card);
+	kfree(data);
 
 	return 0;
 }
-- 
2.18.0
