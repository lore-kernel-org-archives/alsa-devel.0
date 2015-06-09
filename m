From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: qcom: storm: allocate snd_soc_card struct dynamically.
Date: Tue,  9 Jun 2015 14:34:21 +0100
Message-ID: <1433856861-15433-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, kwestfie@codeaurora.org
Cc: Rob Herring <robh+dt@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch moves static allocation of snd_soc_card to dynamic allocation,
the reason to do this is to avoid holding up any dangling pointers
in this static structures. And I see no use for having this struct as static
given that the card->name is also populated dynamically from dt.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/storm.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/soc/qcom/storm.c b/sound/soc/qcom/storm.c
index b8bd296..ee06613 100644
--- a/sound/soc/qcom/storm.c
+++ b/sound/soc/qcom/storm.c
@@ -69,11 +69,6 @@ static struct snd_soc_dai_link storm_dai_link = {
 	.ops		= &storm_soc_ops,
 };
 
-static struct snd_soc_card storm_soc_card = {
-	.name	= "ipq806x-storm",
-	.dev	= NULL,
-};
-
 static int storm_parse_of(struct snd_soc_card *card)
 {
 	struct snd_soc_dai_link *dai_link = card->dai_link;
@@ -99,14 +94,13 @@ static int storm_parse_of(struct snd_soc_card *card)
 
 static int storm_platform_probe(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = &storm_soc_card;
+	struct snd_soc_card *card;
 	int ret;
 
-	if (card->dev) {
-		dev_err(&pdev->dev, "%s() error, existing soundcard\n",
-				__func__);
-		return -ENODEV;
-	}
+	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 
@@ -129,7 +123,6 @@ static int storm_platform_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret == -EPROBE_DEFER) {
-		card->dev = NULL;
 		return ret;
 	} else if (ret) {
 		dev_err(&pdev->dev, "%s() error registering soundcard: %d\n",
-- 
1.9.1
