From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: tidyup for
	card->deferred_resume_work" to the asoc tree
Date: Thu,  8 Aug 2019 21:33:40 +0100 (BST)
Message-ID: <20190808203340.805C52742B42@ypsilon.sirena.org.uk>
References: <877e7paho1.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73D2FF804FF
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 22:33:41 +0200 (CEST)
In-Reply-To: <877e7paho1.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: tidyup for card->deferred_resume_work

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

>From b3da42519c3e6ad977af844d61c31d0e5f874f1c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 7 Aug 2019 10:31:24 +0900
Subject: [PATCH] ASoC: soc-core: tidyup for card->deferred_resume_work

card->deferred_resume_work is used if CONFIG_PM_SLEEP was defined.
but
	1) It is defined even though CONFIG_PM_SLEEP was not defined
	2) random ifdef code is difficult to read.
This patch tidyup these issues.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/877e7paho1.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  5 +++--
 sound/soc/soc-core.c | 14 ++++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6ac6481b4882..85ad971e9432 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1058,8 +1058,6 @@ struct snd_soc_card {
 	int num_of_dapm_routes;
 	bool fully_routed;
 
-	struct work_struct deferred_resume_work;
-
 	/* lists of probed devices belonging to this card */
 	struct list_head component_dev_list;
 	struct list_head list;
@@ -1079,6 +1077,9 @@ struct snd_soc_card {
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_card_root;
+#endif
+#ifdef CONFIG_PM_SLEEP
+	struct work_struct deferred_resume_work;
 #endif
 	u32 pop_time;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6b0042835233..25b26caea4e0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -701,9 +701,18 @@ int snd_soc_resume(struct device *dev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_resume);
+
+static void soc_resume_init(struct snd_soc_card *card)
+{
+	/* deferred resume work */
+	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
+}
 #else
 #define snd_soc_suspend NULL
 #define snd_soc_resume NULL
+static inline void soc_resume_init(struct snd_soc_card *card)
+{
+}
 #endif
 
 static const struct snd_soc_dai_ops null_dai_ops = {
@@ -1984,10 +1993,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 
 	soc_init_card_debugfs(card);
 
-#ifdef CONFIG_PM_SLEEP
-	/* deferred resume work */
-	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
-#endif
+	soc_resume_init(card);
 
 	ret = snd_soc_dapm_new_controls(&card->dapm, card->dapm_widgets,
 					card->num_dapm_widgets);
-- 
2.20.1
