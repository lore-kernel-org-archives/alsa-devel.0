From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: replace aux_comp_list to
	component_dev_list" to the asoc tree
Date: Thu, 01 Dec 2016 21:46:07 +0000
Message-ID: <E1cCZB9-0007da-A5@debutante>
References: <87vaw6399u.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 15588266539
 for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2016 22:46:15 +0100 (CET)
In-Reply-To: <87vaw6399u.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: replace aux_comp_list to component_dev_list

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 1a653aa44725668590b36bbe2d7fe4736a69f055 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 30 Nov 2016 06:22:55 +0000
Subject: [PATCH] ASoC: core: replace aux_comp_list to component_dev_list

Now, Card has component_dev_list, we can replace aux_comp_list
to component_dev_list with new auxiliary flags

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  4 +---
 sound/soc/soc-core.c | 17 ++++++++++++-----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b5544e2287b8..0bd57b77d010 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -807,9 +807,9 @@ struct snd_soc_component {
 
 	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
 	unsigned int registered_as_component:1;
+	unsigned int auxiliary:1; /* for auxiliary component of the card */
 
 	struct list_head list;
-	struct list_head list_aux; /* for auxiliary component of the card */
 	struct list_head card_list;
 
 	struct snd_soc_dai_driver *dai_drv;
@@ -1148,7 +1148,6 @@ struct snd_soc_card {
 	 */
 	struct snd_soc_aux_dev *aux_dev;
 	int num_aux_devs;
-	struct list_head aux_comp_list;
 
 	const struct snd_kcontrol_new *controls;
 	int num_controls;
@@ -1543,7 +1542,6 @@ static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
 	INIT_LIST_HEAD(&card->widgets);
 	INIT_LIST_HEAD(&card->paths);
 	INIT_LIST_HEAD(&card->dapm_list);
-	INIT_LIST_HEAD(&card->aux_comp_list);
 	INIT_LIST_HEAD(&card->component_dev_list);
 }
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d204bb772f00..ba8e000faaf1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1710,7 +1710,8 @@ static int soc_bind_aux_dev(struct snd_soc_card *card, int num)
 	}
 
 	component->init = aux_dev->init;
-	list_add(&component->list_aux, &card->aux_comp_list);
+	component->auxiliary = 1;
+
 	return 0;
 
 err_defer:
@@ -1726,7 +1727,10 @@ static int soc_probe_aux_devices(struct snd_soc_card *card)
 
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 		order++) {
-		list_for_each_entry(comp, &card->aux_comp_list, list_aux) {
+		list_for_each_entry(comp, &card->component_dev_list, card_list) {
+			if (!comp->auxiliary)
+				continue;
+
 			if (comp->driver->probe_order == order) {
 				ret = soc_probe_component(card,	comp);
 				if (ret < 0) {
@@ -1750,11 +1754,14 @@ static void soc_remove_aux_devices(struct snd_soc_card *card)
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 		order++) {
 		list_for_each_entry_safe(comp, _comp,
-			&card->aux_comp_list, list_aux) {
+			&card->component_dev_list, card_list) {
+
+			if (!comp->auxiliary)
+				continue;
+
 			if (comp->driver->remove_order == order) {
 				soc_remove_component(comp);
-				/* remove it from the card's aux_comp_list */
-				list_del(&comp->list_aux);
+				comp->auxiliary = 0;
 			}
 		}
 	}
-- 
2.10.2
