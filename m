From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove unused num_dai_links"
	to the asoc tree
Date: Tue, 11 Sep 2018 19:22:05 +0100 (BST)
Message-ID: <20180911182205.EFE581121B1F@debutante.sirena.org.uk>
References: <87va7c4jcm.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F117267846
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2018 20:22:07 +0200 (CEST)
In-Reply-To: <87va7c4jcm.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: remove unused num_dai_links

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 4f1b327e65a9516a46ea491ce72a5161be176af8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 11 Sep 2018 06:59:01 +0000
Subject: [PATCH] ASoC: soc-core: remove unused num_dai_links

ALSA SoC is counting card->dai_link_list user,
but no-one is using it.
Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 1 -
 sound/soc/soc-core.c | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 821bf99992b8..e17a7ae9a155 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1060,7 +1060,6 @@ struct snd_soc_card {
 	struct snd_soc_dai_link *dai_link;  /* predefined links only */
 	int num_links;  /* predefined links only */
 	struct list_head dai_link_list; /* all links */
-	int num_dai_links;
 
 	struct list_head rtd_list;
 	int num_rtd;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index dde9b70b58b5..7e18937c2214 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1013,7 +1013,6 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 				link->name);
 
 		list_del(&link->list);
-		card->num_dai_links--;
 	}
 }
 
@@ -1182,7 +1181,6 @@ int snd_soc_add_dai_link(struct snd_soc_card *card,
 		card->add_dai_link(card, dai_link);
 
 	list_add_tail(&dai_link->list, &card->dai_link_list);
-	card->num_dai_links++;
 
 	return 0;
 }
@@ -1220,7 +1218,6 @@ void snd_soc_remove_dai_link(struct snd_soc_card *card,
 	list_for_each_entry_safe(link, _link, &card->dai_link_list, list) {
 		if (link == dai_link) {
 			list_del(&link->list);
-			card->num_dai_links--;
 			return;
 		}
 	}
@@ -2712,7 +2709,6 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	snd_soc_initialize_card_lists(card);
 
 	INIT_LIST_HEAD(&card->dai_link_list);
-	card->num_dai_links = 0;
 
 	INIT_LIST_HEAD(&card->rtd_list);
 	card->num_rtd = 0;
-- 
2.19.0.rc2
