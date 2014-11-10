From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/11] ASoC: ac97: Drop support for setting
	platform data via the CPU DAI
Date: Mon, 10 Nov 2014 22:41:49 +0100
Message-ID: <1415655713-29842-8-git-send-email-lars@metafoo.de>
References: <1415655713-29842-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-111.synserver.de (smtp-out-111.synserver.de
 [212.40.185.111])
 by alsa0.perex.cz (Postfix) with ESMTP id ABD38261987
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 22:49:03 +0100 (CET)
In-Reply-To: <1415655713-29842-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Sangbeom Kim <sbkim73@samsung.com>, patches@opensource.wolfsonmicro.com, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This has no users since commit f0fba2ad1b6b ("ASoC: multi-component - ASoC
Multi-Component Support") which was almost 5 years ago. Given that this runs
after CODEC probe functions have been run it also doesn't seem to be that
useful.

So drop it altogether to make the code simpler.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dai.h |  1 -
 include/sound/soc.h     |  3 ---
 sound/soc/soc-ac97.c    | 12 ------------
 sound/soc/soc-core.c    |  2 --
 4 files changed, 18 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 373d177..fbc55fa 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -241,7 +241,6 @@ struct snd_soc_dai {
 	const char *name;
 	int id;
 	struct device *dev;
-	void *ac97_pdata;	/* platform_data for the ac97 codec */
 
 	/* driver ops */
 	struct snd_soc_dai_driver *driver;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 84cb12c..f12efc3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -508,7 +508,6 @@ int snd_soc_set_ac97_ops_of_reset(struct snd_ac97_bus_ops *ops,
 extern struct snd_ac97_bus_ops *soc_ac97_ops;
 
 int snd_soc_ac97_register_dai_links(struct snd_soc_card *card);
-void snd_soc_ac97_add_pdata(struct snd_soc_pcm_runtime *rtd);
 #else
 
 static inline int snd_soc_ac97_register_dai_links(struct snd_soc_card *card)
@@ -516,8 +515,6 @@ static inline int snd_soc_ac97_register_dai_links(struct snd_soc_card *card)
 	return 0;
 }
 
-static inline void snd_soc_ac97_add_pdata(struct snd_soc_pcm_runtime *rtd) {}
-
 static inline int snd_soc_set_ac97_ops_of_reset(struct snd_ac97_bus_ops *ops,
 	struct platform_device *pdev)
 {
diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index b5d23c9..f2ed77b 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -342,15 +342,3 @@ err:
 		soc_unregister_ac97_dai_link(&card->rtd[i]);
 	return ret;
 }
-
-void snd_soc_ac97_add_pdata(struct snd_soc_pcm_runtime *rtd)
-{
-	unsigned int i;
-
-	/* add platform data for AC97 devices */
-	for (i = 0; i < rtd->num_codecs; i++) {
-		if (rtd->codec_dais[i]->driver->ac97_control)
-			snd_ac97_dev_add_pdata(rtd->codec_dais[i]->codec->ac97,
-					       rtd->cpu_dai->ac97_pdata);
-	}
-}
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 90200d27..7b21be5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1340,8 +1340,6 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 		}
 	}
 
-	snd_soc_ac97_add_pdata(rtd);
-
 	return 0;
 }
 
-- 
1.8.0
