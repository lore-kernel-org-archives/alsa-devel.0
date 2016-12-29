From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: Fix binding and probing of auxiliary
	components
Date: Thu, 29 Dec 2016 14:11:21 +0100
Message-ID: <1483017081-22605-1-git-send-email-s.nawrocki@samsung.com>
References: <CGME20161229131145epcas1p26f296b842521fba67815d43cbe7562ba@epcas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BF7F266E52
 for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2016 14:21:54 +0100 (CET)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0OIY01TZO7BM4Z00@mailout2.samsung.com> for
 alsa-devel@alsa-project.org; Thu, 29 Dec 2016 22:11:46 +0900 (KST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, lars@metafoo.de, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Currently binding of auxiliary devices doesn't work as in
soc_bind_aux_dev() function a bound component is not being added
to any list and in soc_probe_aux_devices() we are trying to walk
the component_dev_list list to probe auxiliary components but
at that time this list doesn't contain any auxiliary components
since they are being added to the card only in soc_probe_component().

This patch adds a list to the card where are stored bound but not
probed auxiliary devices, so that all aux devices can be probed.

Fixes: 1a653aa44725 "ASoC: core: replace aux_comp_list to component_dev_list"
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---

I'm not sure if this is a correct approach, without this patch
the amplifier component doesn't get bound to the card
on the TM2 board.
---
 include/sound/soc.h  |  3 +++
 sound/soc/soc-core.c | 10 +++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2b502f6..b86168a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -813,6 +813,7 @@ struct snd_soc_component {
 	unsigned int suspended:1; /* is in suspend PM state */

 	struct list_head list;
+	struct list_head card_aux_list; /* for auxiliary bound components */
 	struct list_head card_list;

 	struct snd_soc_dai_driver *dai_drv;
@@ -1152,6 +1153,7 @@ struct snd_soc_card {
 	 */
 	struct snd_soc_aux_dev *aux_dev;
 	int num_aux_devs;
+	struct list_head aux_comp_list;

 	const struct snd_kcontrol_new *controls;
 	int num_controls;
@@ -1547,6 +1549,7 @@ static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
 	INIT_LIST_HEAD(&card->widgets);
 	INIT_LIST_HEAD(&card->paths);
 	INIT_LIST_HEAD(&card->dapm_list);
+	INIT_LIST_HEAD(&card->aux_comp_list);
 	INIT_LIST_HEAD(&card->component_dev_list);
 }

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f1901bb..baa1afa 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1748,6 +1748,7 @@ static int soc_bind_aux_dev(struct snd_soc_card *card, int num)

 	component->init = aux_dev->init;
 	component->auxiliary = 1;
+	list_add(&component->card_aux_list, &card->aux_comp_list);

 	return 0;

@@ -1758,16 +1759,14 @@ static int soc_bind_aux_dev(struct snd_soc_card *card, int num)

 static int soc_probe_aux_devices(struct snd_soc_card *card)
 {
-	struct snd_soc_component *comp;
+	struct snd_soc_component *comp, *tmp;
 	int order;
 	int ret;

 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 		order++) {
-		list_for_each_entry(comp, &card->component_dev_list, card_list) {
-			if (!comp->auxiliary)
-				continue;
-
+		list_for_each_entry_safe(comp, tmp, &card->aux_comp_list,
+					 card_aux_list) {
 			if (comp->driver->probe_order == order) {
 				ret = soc_probe_component(card,	comp);
 				if (ret < 0) {
@@ -1776,6 +1775,7 @@ static int soc_probe_aux_devices(struct snd_soc_card *card)
 						comp->name, ret);
 					return ret;
 				}
+				list_del(&comp->card_aux_list);
 			}
 		}
 	}
--
1.9.1
