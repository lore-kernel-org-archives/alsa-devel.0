From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix resource leak if soc_register_ac97_dai_link
 failed
Date: Tue, 07 Dec 2010 20:56:30 +0800
Message-ID: <1291726590.2760.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Properly free the resources in the case of soc_register_ac97_dai_link failure.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---

This patch is against Linus tree.

Regards,
Axel
 sound/soc/soc-core.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 441285a..d7f80c3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1619,12 +1619,14 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
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
+			goto probe_dai_err;
 		}
+	}
 #endif
 
 	card->instantiated = 1;
-- 
1.7.0.4
