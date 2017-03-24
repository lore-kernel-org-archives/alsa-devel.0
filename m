From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: remove pointless auxiliary from snd_soc_component" to the asoc tree
Date: Fri, 24 Mar 2017 19:16:40 +0000
Message-ID: <E1crUhU-00068l-0z@debutante>
References: <87o9xcp6zi.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87o9xcp6zi.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: remove pointless auxiliary from snd_soc_component

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

>From 991454e17070eaf5286a666d9e896fd6fb332c72 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 24 Mar 2017 00:13:00 +0000
Subject: [PATCH] ASoC: core: remove pointless auxiliary from snd_soc_component

commit 1a653aa44725 ("ASoC: core: replace aux_comp_list to ...")
tried to replace aux_comp_list to component_dev_list,
but it failed because of binding timing. Thus, Sylwester fixuped it by
commit d2e3a1358c37 ("ASoC: Fix binding and probing of auxiliary...").

One of main purpose of commit 1a653aa44725 ("ASoC: core: replace...")
was remove replaceable list (= list_aux) from snd_soc_component by using
new "auxiliary" flags (but it failed).
Because of this background, current code has reborned card_aux_list
(= same as original list_aux), and almost pointless "auxiliary" flags.

Let's remove pointless "auxiliary" flags by this patch
This means, it is same as revert both
commit 1a653aa44725 ("ASoC: core: replace aux_comp_list to ...") and
commit d2e3a1358c37 ("ASoC: Fix binding and probing of auxiliary...").

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  1 -
 sound/soc/soc-core.c | 15 +++++----------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index cdfb55f7aede..ee838b0d5db8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -812,7 +812,6 @@ struct snd_soc_component {
 
 	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
 	unsigned int registered_as_component:1;
-	unsigned int auxiliary:1; /* for auxiliary component of the card */
 	unsigned int suspended:1; /* is in suspend PM state */
 
 	struct list_head list;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d29fbc7195a0..a6f840beacb0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1776,7 +1776,6 @@ static int soc_bind_aux_dev(struct snd_soc_card *card, int num)
 	}
 
 	component->init = aux_dev->init;
-	component->auxiliary = 1;
 	list_add(&component->card_aux_list, &card->aux_comp_list);
 
 	return 0;
@@ -1788,14 +1787,13 @@ static int soc_bind_aux_dev(struct snd_soc_card *card, int num)
 
 static int soc_probe_aux_devices(struct snd_soc_card *card)
 {
-	struct snd_soc_component *comp, *tmp;
+	struct snd_soc_component *comp;
 	int order;
 	int ret;
 
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 		order++) {
-		list_for_each_entry_safe(comp, tmp, &card->aux_comp_list,
-					 card_aux_list) {
+		list_for_each_entry(comp, &card->aux_comp_list, card_aux_list) {
 			if (comp->driver->probe_order == order) {
 				ret = soc_probe_component(card,	comp);
 				if (ret < 0) {
@@ -1804,7 +1802,6 @@ static int soc_probe_aux_devices(struct snd_soc_card *card)
 						comp->name, ret);
 					return ret;
 				}
-				list_del(&comp->card_aux_list);
 			}
 		}
 	}
@@ -1820,14 +1817,12 @@ static void soc_remove_aux_devices(struct snd_soc_card *card)
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 		order++) {
 		list_for_each_entry_safe(comp, _comp,
-			&card->component_dev_list, card_list) {
-
-			if (!comp->auxiliary)
-				continue;
+			&card->aux_comp_list, card_aux_list) {
 
 			if (comp->driver->remove_order == order) {
 				soc_remove_component(comp);
-				comp->auxiliary = 0;
+				/* remove it from the card's aux_comp_list */
+				list_del(&comp->card_aux_list);
 			}
 		}
 	}
-- 
2.11.0
