From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] ASoC: smd845: remove auto rebinding
Date: Thu,  2 Aug 2018 16:03:37 +0100
Message-ID: <20180802150338.24538-3-srinivas.kandagatla@linaro.org>
References: <20180802150338.24538-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180802150338.24538-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: perex@perex.cz, tiwai@suse.com, vkoul@kernel.org, linux-kernel@vger.kernel.org, rohitkr@codeaurora.org, bgoswami@codeaurora.org, stefan.wahren@i2se.com, guillaume.tucker@collabora.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Remove auto rebinding support, as component framework can deadlock
in few usecases if we are trying to add new/remove component within
a bind/unbind callbacks.

Card rebinding is ASoC core feature so all the previous component
framework stuff in q6dsp remains removed.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sdm845.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index bf4ec4646906..be0cb1122036 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -226,7 +226,6 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	card->dev = dev;
-	card->auto_bind = true;
 	dev_set_drvdata(dev, card);
 	ret = qcom_snd_parse_of(card);
 	if (ret) {
@@ -258,7 +257,6 @@ static int sdm845_snd_platform_remove(struct platform_device *pdev)
 	struct snd_soc_card *card = dev_get_drvdata(&pdev->dev);
 	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
 
-	card->auto_bind = false;
 	snd_soc_unregister_card(card);
 	kfree(card->dai_link);
 	kfree(data);
-- 
2.16.2
