From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/5] ASoC: qdsp6: q6afe-dai: add SLIM tx AIF_IN dapm
Date: Mon,  6 Aug 2018 11:12:09 +0100
Message-ID: <20180806101209.15167-6-srinivas.kandagatla@linaro.org>
References: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: perex@perex.cz, tiwai@suse.com, vkoul@kernel.org, linux-kernel@vger.kernel.org, rohitkr@codeaurora.org, bgoswami@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add missing AIF_IN dapm for slim tx ports.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 475d193c5e2e..60ff4a2d3577 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1120,6 +1120,13 @@ static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("SLIMBUS_4_RX", "Slimbus4 Playback", 0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SLIMBUS_5_RX", "Slimbus5 Playback", 0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SLIMBUS_6_RX", "Slimbus6 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_0_TX", "Slimbus Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_1_TX", "Slimbus1 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_2_TX", "Slimbus2 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_3_TX", "Slimbus3 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_4_TX", "Slimbus4 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_5_TX", "Slimbus5 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_6_TX", "Slimbus6 Capture", 0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUAT_MI2S_RX", "Quaternary MI2S Playback",
 						0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUAT_MI2S_TX", "Quaternary MI2S Capture",
-- 
2.16.2
