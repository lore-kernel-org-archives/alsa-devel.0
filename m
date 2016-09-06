From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: qcom: apq8016-sbc: add support to routing via DT" to the asoc tree
Date: Tue, 06 Sep 2016 12:29:21 +0100
Message-ID: <E1bhEZ7-0003yT-Cb@finisterre>
References: <1473155865-13361-5-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473155865-13361-5-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: apq8016-sbc: add support to routing via DT

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 05f9033f74798aa27569ad7866b952ff51f83c26 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Date: Tue, 6 Sep 2016 10:57:43 +0100
Subject: [PATCH] ASoC: qcom: apq8016-sbc: add support to routing via DT

This patch adds support to allow audio routing via Device Tree.
This is mostly used to specify MICBIAS and other power supplies
relation.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/sound/qcom,apq8016-sbc.txt | 30 ++++++++++++++++++++++
 sound/soc/qcom/apq8016_sbc.c                       |  9 +++++++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
index 48129368d4d9..d9d8635ff94c 100644
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
index 5c3ccf3f8fdf..07f91e918b23 100644
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
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
