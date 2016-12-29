From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] Revert "ASoC: core: replace aux_comp_list to component_dev_list"
Date: Thu, 29 Dec 2016 17:46:54 +0300
Message-ID: <1483022814-28741-1-git-send-email-nikita.yoush@cogentembedded.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: Chris Healy <cphealy@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Nikita Yushchenko <nikita.yoush@cogentembedded.com>
List-Id: alsa-devel@alsa-project.org

This reverts commit 1a653aa44725668590b36bbe2d7fe4736a69f055 ("ASoC:
core: replace aux_comp_list to component_dev_list").

That commit tries to remove card->aux_comp_list, using flagged entries
in card->component_dev_list instead.

However, components are added to card->component_dev_list in
soc_probe_component(). Before that commit, it traversed
card->aux_comp_list and found aux devices added by soc_bind_aux_dev().
After that commit, it traverses card->component_dev_list and finds no
aux devices, because soc_probe_component() was not yet called for them.

Thus all aux devices are lost and any setup that needs them no longer
works.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 include/sound/soc.h  |  4 +++-
 sound/soc/soc-core.c | 17 +++++------------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2b502f6cc6d0..8172a512632a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -809,10 +809,10 @@ struct snd_soc_component {
 
 	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
 	unsigned int registered_as_component:1;
-	unsigned int auxiliary:1; /* for auxiliary component of the card */
 	unsigned int suspended:1; /* is in suspend PM state */
 
 	struct list_head list;
+	struct list_head list_aux; /* for auxiliary component of the card */
 	struct list_head card_list;
 
 	struct snd_soc_dai_driver *dai_drv;
@@ -1152,6 +1152,7 @@ struct snd_soc_card {
 	 */
 	struct snd_soc_aux_dev *aux_dev;
 	int num_aux_devs;
+	struct list_head aux_comp_list;
 
 	const struct snd_kcontrol_new *controls;
 	int num_controls;
@@ -1547,6 +1548,7 @@ static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
 	INIT_LIST_HEAD(&card->widgets);
 	INIT_LIST_HEAD(&card->paths);
 	INIT_LIST_HEAD(&card->dapm_list);
+	INIT_LIST_HEAD(&card->aux_comp_list);
 	INIT_LIST_HEAD(&card->component_dev_list);
 }
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f1901bb1466e..15657a65e4ca 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1747,8 +1747,7 @@ static int soc_bind_aux_dev(struct snd_soc_card *card, int num)
 	}
 
 	component->init = aux_dev->init;
-	component->auxiliary = 1;
-
+	list_add(&component->list_aux, &card->aux_comp_list);
 	return 0;
 
 err_defer:
@@ -1764,10 +1763,7 @@ static int soc_probe_aux_devices(struct snd_soc_card *card)
 
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 		order++) {
-		list_for_each_entry(comp, &card->component_dev_list, card_list) {
-			if (!comp->auxiliary)
-				continue;
-
+		list_for_each_entry(comp, &card->aux_comp_list, list_aux) {
 			if (comp->driver->probe_order == order) {
 				ret = soc_probe_component(card,	comp);
 				if (ret < 0) {
@@ -1791,14 +1787,11 @@ static void soc_remove_aux_devices(struct snd_soc_card *card)
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 		order++) {
 		list_for_each_entry_safe(comp, _comp,
-			&card->component_dev_list, card_list) {
-
-			if (!comp->auxiliary)
-				continue;
-
+			&card->aux_comp_list, list_aux) {
 			if (comp->driver->remove_order == order) {
 				soc_remove_component(comp);
-				comp->auxiliary = 0;
+				/* remove it from the card's aux_comp_list */
+				list_del(&comp->list_aux);
 			}
 		}
 	}
-- 
2.1.4
