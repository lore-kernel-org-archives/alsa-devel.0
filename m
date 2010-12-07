From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix snd_soc_instantiate_card error path
Date: Tue, 07 Dec 2010 17:06:02 +0800
Message-ID: <1291712762.4776.11.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>From 0443551476ee6fabe45a0fbc7460dca8e0f6a965 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@gmail.com>
Date: Tue, 7 Dec 2010 16:12:29 +0800
Subject: [PATCH] ASoC: Fix snd_soc_instantiate_card error path

Properly free the resources in the case of snd_card_register failure
and soc_register_ac97_dai_link failure.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---

This patch is against linux-next tree.

In the case of soc_register_ac97_dai_link failure,
I think we need below fix for Linus's tree:
Add 
while (--i >= 0)
	soc_unregister_ac97_dai_link(&card->rtd[i]);
just before goto probe_dai_err;
Should I also send a patch against Linus's tree?

Regards,
Axel

 sound/soc/soc-core.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 392d336..b4c8c38 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1839,18 +1839,20 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	ret = snd_card_register(card->snd_card);
 	if (ret < 0) {
 		printk(KERN_ERR "asoc: failed to register soundcard for %s\n", card->name);
-		goto probe_dai_err;
+		goto probe_aux_dev_err;
 	}
 
 #ifdef CONFIG_SND_SOC_AC97_BUS
 	/* register any AC97 codecs */
 	for (i = 0; i < card->num_rtd; i++) {
-			ret = soc_register_ac97_dai_link(&card->rtd[i]);
-			if (ret < 0) {
-				printk(KERN_ERR "asoc: failed to register AC97 %s\n", card->name);
-				goto probe_dai_err;
-			}
+		ret = soc_register_ac97_dai_link(&card->rtd[i]);
+		if (ret < 0) {
+			printk(KERN_ERR "asoc: failed to register AC97 %s\n", card->name);
+			while (--i >= 0)
+				soc_unregister_ac97_dai_link(&card->rtd[i]);
+			goto probe_aux_dev_err;
 		}
+	}
 #endif
 
 	card->instantiated = 1;
-- 
1.7.2
