From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [PATCH 1/2] ASoC: mediatek: sub dai use list_head
Date: Fri, 29 Jun 2018 20:29:44 +0800
Message-ID: <1530275385-11422-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FFD02675C8
 for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2018 14:29:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

use list_head for sub_dais,
since original sub_dais array is sparsely occupied

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
---
 .../soc/mediatek/common/mtk-afe-platform-driver.c  | 64 ++++++++--------------
 sound/soc/mediatek/common/mtk-base-afe.h           |  6 +-
 2 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index 0061858..3a5bde6 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -15,20 +15,12 @@
 
 int mtk_afe_combine_sub_dai(struct mtk_base_afe *afe)
 {
-	struct snd_soc_dai_driver *sub_dai_drivers;
+	struct mtk_base_afe_dai *dai;
 	size_t num_dai_drivers = 0, dai_idx = 0;
-	int i;
-
-	if (!afe->sub_dais) {
-		dev_err(afe->dev, "%s(), sub_dais == NULL\n", __func__);
-		return -EINVAL;
-	}
 
 	/* calcualte total dai driver size */
-	for (i = 0; i < afe->num_sub_dais; i++) {
-		if (afe->sub_dais[i].dai_drivers &&
-		    afe->sub_dais[i].num_dai_drivers != 0)
-			num_dai_drivers += afe->sub_dais[i].num_dai_drivers;
+	list_for_each_entry(dai, &afe->sub_dais, list) {
+		num_dai_drivers += dai->num_dai_drivers;
 	}
 
 	dev_info(afe->dev, "%s(), num of dai %zd\n", __func__, num_dai_drivers);
@@ -42,47 +34,39 @@ int mtk_afe_combine_sub_dai(struct mtk_base_afe *afe)
 	if (!afe->dai_drivers)
 		return -ENOMEM;
 
-	for (i = 0; i < afe->num_sub_dais; i++) {
-		if (afe->sub_dais[i].dai_drivers &&
-		    afe->sub_dais[i].num_dai_drivers != 0) {
-			sub_dai_drivers = afe->sub_dais[i].dai_drivers;
-			/* dai driver */
-			memcpy(&afe->dai_drivers[dai_idx],
-			       sub_dai_drivers,
-			       afe->sub_dais[i].num_dai_drivers *
-			       sizeof(struct snd_soc_dai_driver));
-			dai_idx += afe->sub_dais[i].num_dai_drivers;
-		}
+	list_for_each_entry(dai, &afe->sub_dais, list) {
+		/* dai driver */
+		memcpy(&afe->dai_drivers[dai_idx],
+		       dai->dai_drivers,
+		       dai->num_dai_drivers *
+		       sizeof(struct snd_soc_dai_driver));
+		dai_idx += dai->num_dai_drivers;
 	}
-
 	return 0;
 }
 
 int mtk_afe_add_sub_dai_control(struct snd_soc_component *component)
 {
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
-	int i;
+	struct mtk_base_afe_dai *dai;
 
-	if (!afe->sub_dais) {
-		dev_err(afe->dev, "%s(), sub_dais == NULL\n", __func__);
-		return -EINVAL;
-	}
-
-	for (i = 0; i < afe->num_sub_dais; i++) {
-		if (afe->sub_dais[i].controls)
+	list_for_each_entry(dai, &afe->sub_dais, list) {
+		if (dai->controls)
 			snd_soc_add_component_controls(component,
-				afe->sub_dais[i].controls,
-				afe->sub_dais[i].num_controls);
+						       dai->controls,
+						       dai->num_controls);
 
-		if (afe->sub_dais[i].dapm_widgets)
+		if (dai->dapm_widgets)
 			snd_soc_dapm_new_controls(&component->dapm,
-				afe->sub_dais[i].dapm_widgets,
-				afe->sub_dais[i].num_dapm_widgets);
-
-		if (afe->sub_dais[i].dapm_routes)
+						  dai->dapm_widgets,
+						  dai->num_dapm_widgets);
+	}
+	/* add routes after all widgets are added */
+	list_for_each_entry(dai, &afe->sub_dais, list) {
+		if (dai->dapm_routes)
 			snd_soc_dapm_add_routes(&component->dapm,
-				afe->sub_dais[i].dapm_routes,
-				afe->sub_dais[i].num_dapm_routes);
+						dai->dapm_routes,
+						dai->num_dapm_routes);
 	}
 
 	snd_soc_dapm_new_widgets(component->dapm.card);
diff --git a/sound/soc/mediatek/common/mtk-base-afe.h b/sound/soc/mediatek/common/mtk-base-afe.h
index bcf562f0..bd8d5e0 100644
--- a/sound/soc/mediatek/common/mtk-base-afe.h
+++ b/sound/soc/mediatek/common/mtk-base-afe.h
@@ -46,6 +46,7 @@ struct mtk_base_irq_data {
 };
 
 struct device;
+struct list_head;
 struct mtk_base_afe_memif;
 struct mtk_base_afe_irq;
 struct mtk_base_afe_dai;
@@ -72,8 +73,7 @@ struct mtk_base_afe {
 	struct mtk_base_afe_irq *irqs;
 	int irqs_size;
 
-	struct mtk_base_afe_dai *sub_dais;
-	int num_sub_dais;
+	struct list_head sub_dais;
 	struct snd_soc_dai_driver *dai_drivers;
 	unsigned int num_dai_drivers;
 
@@ -110,6 +110,8 @@ struct mtk_base_afe_dai {
 	unsigned int num_dapm_widgets;
 	const struct snd_soc_dapm_route *dapm_routes;
 	unsigned int num_dapm_routes;
+
+	struct list_head list;
 };
 
 #endif
-- 
1.9.1
