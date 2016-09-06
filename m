From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 5/6] ASoC: qcom: apq8016-sbc: Add support to multi codec.
Date: Tue,  6 Sep 2016 10:57:44 +0100
Message-ID: <1473155865-13361-6-git-send-email-srinivas.kandagatla@linaro.org>
References: <1473155865-13361-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1473155865-13361-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, tiwai@suse.com, devicetree@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds support to multi codec, as the msm8916 codec is now
split into two codecs, Analog and Digital.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8016_sbc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

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
2.7.4
