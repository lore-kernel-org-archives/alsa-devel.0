From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 4/6] ASoC: qcom: apq8016-sbc: add support to routing via DT
Date: Tue,  6 Sep 2016 10:57:43 +0100
Message-ID: <1473155865-13361-5-git-send-email-srinivas.kandagatla@linaro.org>
References: <1473155865-13361-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1473155865-13361-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, tiwai@suse.com, devicetree@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds support to allow audio routing via Device Tree.
This is mostly used to specify MICBIAS and other power supplies
relation.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,apq8016-sbc.txt | 30 ++++++++++++++++++++++
 sound/soc/qcom/apq8016_sbc.c                       |  9 +++++++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
index 4812936..d9d8635 100644
--- a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
@@ -16,6 +16,24 @@ Required properties:
 				* "spkr-iomux"
 - qcom,model		: Name of the sound card.
 
+- qcom,audio-routing	: A list of the connections between audio components.
+			  Each entry is a pair of strings, the first being the
+			  connection's sink, the second being the connection's
+			  source. Valid names could be power supplies, MicBias
+			  of msm8x16_wcd codec and the jacks on the board:
+
+			  Power supplies:
+			  * MIC BIAS External1
+			  * MIC BIAS External2
+			  * MIC BIAS Internal1
+			  * MIC BIAS Internal2
+
+			  Board connectors:
+			  * Headset Mic
+			  * Secondary Mic",
+			  * DMIC
+			  * Ext Spk
+
 Dai-link subnode properties and subnodes:
 
 Required dai-link subnodes:
@@ -37,6 +55,18 @@ sound: sound {
 	reg-names = "mic-iomux", "spkr-iomux";
 	qcom,model = "DB410c";
 
+	qcom,audio-routing =
+		"MIC BIAS External1", "Handset Mic",
+		"MIC BIAS Internal2", "Headset Mic",
+		"MIC BIAS External1", "Secondary Mic",
+		"AMIC1", "MIC BIAS External1",
+		"AMIC2", "MIC BIAS Internal2",
+		"AMIC3", "MIC BIAS External1",
+		"DMIC1", "MIC BIAS Internal1",
+		"MIC BIAS Internal1", "Digital Mic1",
+		"DMIC2", "MIC BIAS Internal1",
+		"MIC BIAS Internal1", "Digital Mic2";
+
 	/* I2S - Internal codec */
 	internal-dai-link@0 {
 		cpu { /* PRIMARY */
diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index 5c3ccf3..07f91e9 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -85,6 +85,15 @@ static struct apq8016_sbc_data *apq8016_sbc_parse_of(struct snd_soc_card *card)
 		return ERR_PTR(ret);
 	}
 
+	/* DAPM routes */
+	if (of_property_read_bool(node, "qcom,audio-routing")) {
+		ret = snd_soc_of_parse_audio_routing(card,
+					"qcom,audio-routing");
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+
 	/* Populate links */
 	num_links = of_get_child_count(node);
 
-- 
2.7.4
