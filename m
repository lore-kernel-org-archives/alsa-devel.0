From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 2/2] ASoC: qcom: defer probe if platform dai is not registered
Date: Mon, 24 Dec 2018 14:32:13 +0530
Message-ID: <1545642133-16120-3-git-send-email-rohitkr@codeaurora.org>
References: <1545642133-16120-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545642133-16120-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, asishb@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org
Cc: Ajit Pandey <ajitp@codeaurora.org>, Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Ajit Pandey <ajitp@codeaurora.org>

Platform DAI component probe is not called if it is not
present in component list during sound card registration.
Check if component is registered for platform dai before
soundcard registration.

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 4715527..9e98458 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -11,6 +11,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	struct device_node *codec = NULL;
 	struct device_node *platform = NULL;
 	struct device_node *cpu = NULL;
+	struct snd_soc_component *component = NULL;
 	struct device *dev = card->dev;
 	struct snd_soc_dai_link *link;
 	struct of_phandle_args args;
@@ -75,6 +76,14 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 				goto err;
 			}
 
+			component = snd_soc_of_lookup_component
+						(link->platform_of_node);
+			if (!component) {
+				ret = -EPROBE_DEFER;
+				dev_err(card->dev, "platform DAI not registered\n");
+				goto err;
+			}
+
 			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
 			if (ret < 0) {
 				dev_err(card->dev, "codec dai not found\n");
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
