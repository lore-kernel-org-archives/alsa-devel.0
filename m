From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH] ASoC: soc-core: Hold client_mutex around soc_init_dai_link()
Date: Thu, 10 Jan 2019 14:32:41 +0530
Message-ID: <1547110961-23670-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, asishb@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org, vinod.koul@linaro.org
Cc: Rohit kumar <rohitkr@codeaurora.org>, Ajit Pandey <ajitp@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

soc_init_dai_link() calls soc_find_component() which needs
to be within client_mutex lock. Add client_mutex lock around
soc_init_dai_link() in snd_soc_register_card() to avoid
lockdep warning.

Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")
Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
---
 sound/soc/soc-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index eec92f1..0934b36 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1027,6 +1027,7 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 				 struct snd_soc_dai_link *dai_link)
 {
 	struct snd_soc_dai_link_component *platform = dai_link->platform;
+
 	/*
 	 * FIXME
 	 *
@@ -2754,15 +2755,18 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	if (!card->name || !card->dev)
 		return -EINVAL;
 
+	mutex_lock(&client_mutex);
 	for_each_card_prelinks(card, i, link) {
 
 		ret = soc_init_dai_link(card, link);
 		if (ret) {
 			dev_err(card->dev, "ASoC: failed to init link %s\n",
 				link->name);
+			mutex_unlock(&client_mutex);
 			return ret;
 		}
 	}
+	mutex_unlock(&client_mutex);
 
 	dev_set_drvdata(card->dev, card);
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
