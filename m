From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH] ASoC: qcom: apq8096: set card as device drvdata
Date: Wed,  6 Jun 2018 14:25:24 +0530
Message-ID: <1528275324-4878-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org, rohkumar@qti.qualcomm.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

snd_soc_card is retrieved as device drvdata during unbind().
Set it as drvdata during bind() to avoid memory corruption during
unbind().

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/apq8096.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 561cd42..239b8cb 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -140,6 +140,7 @@ static int apq8096_bind(struct device *dev)
 
 	component_bind_all(dev, card);
 	card->dev = dev;
+	dev_set_drvdata(dev, card);
 	ret = apq8096_sbc_parse_of(card);
 	if (ret) {
 		dev_err(dev, "Error parsing OF data\n");
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
