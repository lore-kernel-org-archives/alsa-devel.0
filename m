From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] ASoC: Remove card's DAI list
Date: Tue,  6 May 2014 09:39:37 +0200
Message-ID: <1399361981-18518-2-git-send-email-lars@metafoo.de>
References: <1399361981-18518-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-016.synserver.de
 [212.40.185.16])
 by alsa0.perex.cz (Postfix) with ESMTP id D0A0C2608D4
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 09:39:50 +0200 (CEST)
In-Reply-To: <1399361981-18518-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

Commit f0fba2ad1 ("ASoC: multi-component - ASoC Multi-Component Support") added
a per card list that keeps track of all the DAIs that have been registered with
the card, but the list has never been used. This patch removes it again.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dai.h | 1 -
 include/sound/soc.h     | 2 --
 sound/soc/soc-core.c    | 5 -----
 3 files changed, 8 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index fad7676..e2c3e45 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -277,7 +277,6 @@ struct snd_soc_dai {
 	struct snd_soc_card *card;
 
 	struct list_head list;
-	struct list_head card_list;
 };
 
 static inline void *snd_soc_dai_get_dma_data(const struct snd_soc_dai *dai,
diff --git a/include/sound/soc.h b/include/sound/soc.h
index c0b65fc..30c068f 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1012,7 +1012,6 @@ struct snd_soc_card {
 	/* lists of probed devices belonging to this card */
 	struct list_head codec_dev_list;
 	struct list_head platform_dev_list;
-	struct list_head dai_dev_list;
 
 	struct list_head widgets;
 	struct list_head paths;
@@ -1194,7 +1193,6 @@ static inline void *snd_soc_pcm_get_drvdata(struct snd_soc_pcm_runtime *rtd)
 
 static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
 {
-	INIT_LIST_HEAD(&card->dai_dev_list);
 	INIT_LIST_HEAD(&card->codec_dev_list);
 	INIT_LIST_HEAD(&card->platform_dev_list);
 	INIT_LIST_HEAD(&card->widgets);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4a381b3..24c1fc2 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1017,7 +1017,6 @@ static void soc_remove_codec_dai(struct snd_soc_dai *codec_dai, int order)
 					codec_dai->name, err);
 		}
 		codec_dai->probed = 0;
-		list_del(&codec_dai->card_list);
 	}
 }
 
@@ -1049,7 +1048,6 @@ static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 					cpu_dai->name, err);
 		}
 		cpu_dai->probed = 0;
-		list_del(&cpu_dai->card_list);
 
 		if (!cpu_dai->codec) {
 			snd_soc_dapm_free(&cpu_dai->dapm);
@@ -1405,7 +1403,6 @@ static int soc_probe_codec_dai(struct snd_soc_card *card,
 
 		/* mark codec_dai as probed and add to card dai list */
 		codec_dai->probed = 1;
-		list_add(&codec_dai->card_list, &card->dai_dev_list);
 	}
 
 	return 0;
@@ -1490,8 +1487,6 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 			}
 		}
 		cpu_dai->probed = 1;
-		/* mark cpu_dai as probed and add to card dai list */
-		list_add(&cpu_dai->card_list, &card->dai_dev_list);
 	}
 
 	/* probe the CODEC DAI */
-- 
1.8.0
