From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 4/5] ASoC: qcom: apq8016-sbc: Add support to multi codec.
Date: Thu, 20 Oct 2016 15:20:48 +0100
Message-ID: <1476973249-14547-5-git-send-email-srinivas.kandagatla@linaro.org>
References: <1476973249-14547-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1476973249-14547-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, tiwai@suse.com, devicetree@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

This patch adds support to multi codec, as the msm8916 codec is now
split into two codecs, Analog and Digital.

Also update the bindings and example to show that the card supports
multicodec.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt |  4 ++--
 sound/soc/qcom/apq8016_sbc.c                                 | 11 +++--------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
index 72c1928..6a4aadc 100644
--- a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
@@ -44,7 +44,7 @@ Required dai-link subnodes:
 Required CPU/CODEC subnodes properties:
 
 -link-name		: Name of the dai link.
--sound-dai		: phandle and port of CPU/CODEC
+-sound-dai		: phandle/s and port of CPU/CODEC
 
 Example:
 
@@ -72,7 +72,7 @@ sound: sound {
 			sound-dai = <&lpass MI2S_PRIMARY>;
 		};
 		codec {
-			sound-dai = <&wcd_codec 0>;
+			sound-dai = <&lpass_codec 0>, <&wcd_codec 0>;
 		};
 	};
 
diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index 07f91e9..d084d74 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -123,20 +123,15 @@ static struct apq8016_sbc_data *apq8016_sbc_parse_of(struct snd_soc_card *card)
 			return ERR_PTR(-EINVAL);
 		}
 
-		link->codec_of_node = of_parse_phandle(codec, "sound-dai", 0);
-		if (!link->codec_of_node) {
-			dev_err(card->dev, "error getting codec phandle\n");
-			return ERR_PTR(-EINVAL);
-		}
-
 		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
 		if (ret) {
 			dev_err(card->dev, "error getting cpu dai name\n");
 			return ERR_PTR(ret);
 		}
 
-		ret = snd_soc_of_get_dai_name(codec, &link->codec_dai_name);
-		if (ret) {
+		ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
+
+		if (ret < 0) {
 			dev_err(card->dev, "error getting codec dai name\n");
 			return ERR_PTR(ret);
 		}
-- 
2.9.2
