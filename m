From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: sdm845: Create and setup jack in
	init callback" to the asoc tree
Date: Wed, 28 Nov 2018 16:05:24 +0000 (GMT)
Message-ID: <20181128160524.B60F8112521B@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 82FA4267B01
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 17:05:25 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: sdm845: Create and setup jack in init callback

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 80e733fda42f511b346106351ba7b73d5a8196d4 Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Sat, 24 Nov 2018 19:09:46 +0800
Subject: [PATCH] ASoC: qcom: sdm845: Create and setup jack in init callback

Add a callback for init ops on dai_link to create and setup jack.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 57 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 95d8d4422dae..43c03f8e8cdc 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -8,6 +8,8 @@
 #include <linux/of_device.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/jack.h>
+#include <uapi/linux/input-event-codes.h>
 #include "common.h"
 #include "qdsp6/q6afe.h"
 
@@ -17,6 +19,8 @@
 #define MI2S_BCLK_RATE		1536000
 
 struct sdm845_snd_data {
+	struct snd_soc_jack jack;
+	bool jack_setup;
 	struct snd_soc_card *card;
 	uint32_t pri_mi2s_clk_count;
 	uint32_t sec_mi2s_clk_count;
@@ -100,6 +104,54 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *component;
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
+	struct snd_soc_card *card = rtd->card;
+	struct sdm845_snd_data *pdata = snd_soc_card_get_drvdata(card);
+	int i, rval;
+
+	if (!pdata->jack_setup) {
+		struct snd_jack *jack;
+
+		rval = snd_soc_card_jack_new(card, "Headset Jack",
+				SND_JACK_HEADSET |
+				SND_JACK_HEADPHONE |
+				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+				SND_JACK_BTN_2 | SND_JACK_BTN_3,
+				&pdata->jack, NULL, 0);
+
+		if (rval < 0) {
+			dev_err(card->dev, "Unable to add Headphone Jack\n");
+			return rval;
+		}
+
+		jack = pdata->jack.jack;
+
+		snd_jack_set_key(jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+		snd_jack_set_key(jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+		snd_jack_set_key(jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+		snd_jack_set_key(jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+		pdata->jack_setup = true;
+	}
+
+	for (i = 0 ; i < dai_link->num_codecs; i++) {
+		struct snd_soc_dai *dai = rtd->codec_dais[i];
+
+		component = dai->component;
+		rval = snd_soc_component_set_jack(
+				component, &pdata->jack, NULL);
+		if (rval != 0 && rval != -ENOTSUPP) {
+			dev_warn(card->dev, "Failed to set jack: %d\n", rval);
+			return rval;
+		}
+	}
+
+	return 0;
+}
+
+
 static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 {
 	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
@@ -220,7 +272,7 @@ static const struct snd_soc_dapm_widget sdm845_snd_widgets[] = {
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
 };
 
-static void sdm845_add_be_ops(struct snd_soc_card *card)
+static void sdm845_add_ops(struct snd_soc_card *card)
 {
 	struct snd_soc_dai_link *link;
 	int i;
@@ -230,6 +282,7 @@ static void sdm845_add_be_ops(struct snd_soc_card *card)
 			link->ops = &sdm845_be_ops;
 			link->be_hw_params_fixup = sdm845_be_hw_params_fixup;
 		}
+		link->init = sdm845_dai_init;
 	}
 }
 
@@ -264,7 +317,7 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 	data->card = card;
 	snd_soc_card_set_drvdata(card, data);
 
-	sdm845_add_be_ops(card);
+	sdm845_add_ops(card);
 	ret = snd_soc_register_card(card);
 	if (ret) {
 		dev_err(dev, "Sound card registration failed\n");
-- 
2.19.0.rc2
