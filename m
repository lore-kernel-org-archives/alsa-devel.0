From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: merge
	snd_soc_initialize_card_lists()" to the asoc tree
Date: Wed, 21 Aug 2019 13:15:32 +0100 (BST)
Message-ID: <20190821121532.7DBB027430D6@ypsilon.sirena.org.uk>
References: <877e781ldq.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f99.google.com (mail-wr1-f99.google.com
 [209.85.221.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93125F8036A
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2019 14:15:33 +0200 (CEST)
Received: by mail-wr1-f99.google.com with SMTP id p17so1796576wrf.11
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2019 05:15:33 -0700 (PDT)
In-Reply-To: <877e781ldq.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Sridharan@sirena.co.uk, Ranjani <ranjani.sridharan@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: merge snd_soc_initialize_card_lists()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b03bfaec1d52123d5d941488f71e06964535e471 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 20 Aug 2019 14:04:54 +0900
Subject: [PATCH] ASoC: soc-core: merge snd_soc_initialize_card_lists()

snd_soc_initialize_card_lists() is doing card related
INIT_LIST_HEAD(), but, it is already doing at
snd_soc_register_card(). We don't need to do it separately.
This patch merges these.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/877e781ldq.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 10 ----------
 sound/soc/soc-core.c | 13 ++++++++-----
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5c841c2ee814..f264c6509f00 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1220,16 +1220,6 @@ static inline void *snd_soc_card_get_drvdata(struct snd_soc_card *card)
 	return card->drvdata;
 }
 
-static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
-{
-	INIT_LIST_HEAD(&card->widgets);
-	INIT_LIST_HEAD(&card->paths);
-	INIT_LIST_HEAD(&card->dapm_list);
-	INIT_LIST_HEAD(&card->aux_comp_list);
-	INIT_LIST_HEAD(&card->component_dev_list);
-	INIT_LIST_HEAD(&card->list);
-}
-
 static inline bool snd_soc_volsw_is_stereo(struct soc_mixer_control *mc)
 {
 	if (mc->reg == mc->rreg && mc->shift == mc->rshift)
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b3f820fb53e6..d428491d51a7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2370,15 +2370,18 @@ int snd_soc_register_card(struct snd_soc_card *card)
 
 	dev_set_drvdata(card->dev, card);
 
-	snd_soc_initialize_card_lists(card);
-
+	INIT_LIST_HEAD(&card->widgets);
+	INIT_LIST_HEAD(&card->paths);
+	INIT_LIST_HEAD(&card->dapm_list);
+	INIT_LIST_HEAD(&card->aux_comp_list);
+	INIT_LIST_HEAD(&card->component_dev_list);
+	INIT_LIST_HEAD(&card->list);
 	INIT_LIST_HEAD(&card->dai_link_list);
-
 	INIT_LIST_HEAD(&card->rtd_list);
-	card->num_rtd = 0;
-
 	INIT_LIST_HEAD(&card->dapm_dirty);
 	INIT_LIST_HEAD(&card->dobj_list);
+
+	card->num_rtd = 0;
 	card->instantiated = 0;
 	mutex_init(&card->mutex);
 	mutex_init(&card->dapm_mutex);
-- 
2.20.1
