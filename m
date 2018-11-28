From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2 1/5] ASoC: qcom: sdm845: Add board specific dapm widgets
Date: Wed, 28 Nov 2018 17:00:33 +0800
Message-ID: <20181128090037.257359-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, dgreid@chromium.org, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

Add board specific dapm widgets so these widgets can be used
in the route.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/qcom/sdm845.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 58593db2ab151..95d8d4422dae0 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -212,6 +212,14 @@ static int sdm845_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
+static const struct snd_soc_dapm_widget sdm845_snd_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_SPK("Left Spk", NULL),
+	SND_SOC_DAPM_SPK("Right Spk", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+};
+
 static void sdm845_add_be_ops(struct snd_soc_card *card)
 {
 	struct snd_soc_dai_link *link;
@@ -243,6 +251,8 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 		goto data_alloc_fail;
 	}
 
+	card->dapm_widgets = sdm845_snd_widgets;
+	card->num_dapm_widgets = ARRAY_SIZE(sdm845_snd_widgets);
 	card->dev = dev;
 	dev_set_drvdata(dev, card);
 	ret = qcom_snd_parse_of(card);
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog
