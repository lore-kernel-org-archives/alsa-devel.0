From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: apq8016-sbc: Add support to multi codec." to the asoc tree
Date: Mon, 24 Oct 2016 19:04:08 +0100
Message-ID: <E1byjbU-0001Gw-Gi@debutante>
References: <1473339896-9409-5-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1473339896-9409-5-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, mark.rutland@arm.com, devicetree@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: apq8016-sbc: Add support to multi codec.

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

>From 09065f8b44a3e2a742565368b89b5848387eaf38 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 20 Oct 2016 15:20:48 +0100
Subject: [PATCH] ASoC: qcom: apq8016-sbc: Add support to multi codec.

This patch adds support to multi codec, as the msm8916 codec is now
split into two codecs, Analog and Digital.

Also update the bindings and example to show that the card supports
multicodec.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt |  4 ++--
 sound/soc/qcom/apq8016_sbc.c                                 | 11 +++--------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
index 72c192801a69..6a4aadc4ce06 100644
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
index 07f91e918b23..d084d7468299 100644
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
2.8.1
