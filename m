From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [PATCH 2/2] ASoC: mt6797: sub dai use list_head
Date: Fri, 29 Jun 2018 20:29:45 +0800
Message-ID: <1530275385-11422-2-git-send-email-kaichieh.chuang@mediatek.com>
References: <1530275385-11422-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 6236A2675FB
 for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2018 14:29:54 +0200 (CEST)
In-Reply-To: <1530275385-11422-1-git-send-email-kaichieh.chuang@mediatek.com>
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

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
---
 sound/soc/mediatek/mt6797/mt6797-afe-common.h   |  1 +
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c      | 65 +++++++++++++++++--------
 sound/soc/mediatek/mt6797/mt6797-dai-adda.c     | 20 +++++---
 sound/soc/mediatek/mt6797/mt6797-dai-hostless.c | 16 ++++--
 sound/soc/mediatek/mt6797/mt6797-dai-pcm.c      | 19 +++++---
 5 files changed, 81 insertions(+), 40 deletions(-)

diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-common.h b/sound/soc/mediatek/mt6797/mt6797-afe-common.h
index 22eb7b4..4eac997 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-common.h
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-common.h
@@ -10,6 +10,7 @@
 #define _MT_6797_AFE_COMMON_H_
 
 #include <sound/soc.h>
+#include <linux/list.h>
 #include <linux/regmap.h>
 #include "../common/mtk-base-afe.h"
 
diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
index 6c5dd9f..192f4d7 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -733,6 +733,34 @@ static int mt6797_afe_component_probe(struct snd_soc_component *component)
 	.probe = mt6797_afe_component_probe,
 };
 
+static int mt6797_dai_memif_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mt6797_memif_dai_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mt6797_memif_dai_driver);
+
+	dai->dapm_widgets = mt6797_memif_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mt6797_memif_widgets);
+	dai->dapm_routes = mt6797_memif_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mt6797_memif_routes);
+	return 0;
+}
+
+typedef int (*dai_register_cb)(struct mtk_base_afe *);
+static const dai_register_cb dai_register_cbs[] = {
+	mt6797_dai_adda_register,
+	mt6797_dai_pcm_register,
+	mt6797_dai_hostless_register,
+	mt6797_dai_memif_register,
+};
+
 static int mt6797_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	struct mtk_base_afe *afe;
@@ -811,29 +839,24 @@ static int mt6797_afe_pcm_dev_probe(struct platform_device *pdev)
 	}
 
 	/* init sub_dais */
-	afe->num_sub_dais = MT6797_DAI_NUM;
-	afe->sub_dais = devm_kcalloc(dev, afe->num_sub_dais,
-				     sizeof(*afe->sub_dais),
-				     GFP_KERNEL);
-	if (!afe->sub_dais)
-		return -ENOMEM;
-
-	mt6797_dai_adda_register(afe);
-	mt6797_dai_pcm_register(afe);
-	mt6797_dai_hostless_register(afe);
-
-	afe->sub_dais[MT6797_MEMIF_DL1].dai_drivers = mt6797_memif_dai_driver;
-	afe->sub_dais[MT6797_MEMIF_DL1].num_dai_drivers =
-		ARRAY_SIZE(mt6797_memif_dai_driver);
-	afe->sub_dais[MT6797_MEMIF_DL1].dapm_widgets = mt6797_memif_widgets;
-	afe->sub_dais[MT6797_MEMIF_DL1].num_dapm_widgets =
-		ARRAY_SIZE(mt6797_memif_widgets);
-	afe->sub_dais[MT6797_MEMIF_DL1].dapm_routes = mt6797_memif_routes;
-	afe->sub_dais[MT6797_MEMIF_DL1].num_dapm_routes =
-		ARRAY_SIZE(mt6797_memif_routes);
+	INIT_LIST_HEAD(&afe->sub_dais);
+
+	for (i = 0; i < ARRAY_SIZE(dai_register_cbs); i++) {
+		ret = dai_register_cbs[i](afe);
+		if (ret) {
+			dev_warn(afe->dev, "dai register i %d fail, ret %d\n",
+				 i, ret);
+			return ret;
+		}
+	}
 
 	/* init dai_driver and component_driver */
-	mtk_afe_combine_sub_dai(afe);
+	ret = mtk_afe_combine_sub_dai(afe);
+	if (ret) {
+		dev_warn(afe->dev, "mtk_afe_combine_sub_dai fail, ret %d\n",
+			 ret);
+		return ret;
+	}
 
 	afe->mtk_afe_hardware = &mt6797_afe_hardware;
 	afe->memif_fs = mt6797_memif_fs;
diff --git a/sound/soc/mediatek/mt6797/mt6797-dai-adda.c b/sound/soc/mediatek/mt6797/mt6797-dai-adda.c
index ad08326..0ac6409 100644
--- a/sound/soc/mediatek/mt6797/mt6797-dai-adda.c
+++ b/sound/soc/mediatek/mt6797/mt6797-dai-adda.c
@@ -383,14 +383,20 @@ static int mtk_dai_adda_hw_params(struct snd_pcm_substream *substream,
 
 int mt6797_dai_adda_register(struct mtk_base_afe *afe)
 {
-	int id = MT6797_DAI_ADDA;
+	struct mtk_base_afe_dai *dai;
 
-	afe->sub_dais[id].dai_drivers = mtk_dai_adda_driver;
-	afe->sub_dais[id].num_dai_drivers = ARRAY_SIZE(mtk_dai_adda_driver);
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
 
-	afe->sub_dais[id].dapm_widgets = mtk_dai_adda_widgets;
-	afe->sub_dais[id].num_dapm_widgets = ARRAY_SIZE(mtk_dai_adda_widgets);
-	afe->sub_dais[id].dapm_routes = mtk_dai_adda_routes;
-	afe->sub_dais[id].num_dapm_routes = ARRAY_SIZE(mtk_dai_adda_routes);
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mtk_dai_adda_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_adda_driver);
+
+	dai->dapm_widgets = mtk_dai_adda_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mtk_dai_adda_widgets);
+	dai->dapm_routes = mtk_dai_adda_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_adda_routes);
 	return 0;
 }
diff --git a/sound/soc/mediatek/mt6797/mt6797-dai-hostless.c b/sound/soc/mediatek/mt6797/mt6797-dai-hostless.c
index 4cf985b..ed23e6a 100644
--- a/sound/soc/mediatek/mt6797/mt6797-dai-hostless.c
+++ b/sound/soc/mediatek/mt6797/mt6797-dai-hostless.c
@@ -100,13 +100,19 @@ static int mtk_dai_hostless_startup(struct snd_pcm_substream *substream,
 
 int mt6797_dai_hostless_register(struct mtk_base_afe *afe)
 {
-	int id = MT6797_DAI_HOSTLESS_LPBK;
+	struct mtk_base_afe_dai *dai;
 
-	afe->sub_dais[id].dai_drivers = mtk_dai_hostless_driver;
-	afe->sub_dais[id].num_dai_drivers = ARRAY_SIZE(mtk_dai_hostless_driver);
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
 
-	afe->sub_dais[id].dapm_routes = mtk_dai_hostless_routes;
-	afe->sub_dais[id].num_dapm_routes = ARRAY_SIZE(mtk_dai_hostless_routes);
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mtk_dai_hostless_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_hostless_driver);
+
+	dai->dapm_routes = mtk_dai_hostless_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_hostless_routes);
 
 	return 0;
 }
diff --git a/sound/soc/mediatek/mt6797/mt6797-dai-pcm.c b/sound/soc/mediatek/mt6797/mt6797-dai-pcm.c
index 16d5b50..3136f0b 100644
--- a/sound/soc/mediatek/mt6797/mt6797-dai-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-dai-pcm.c
@@ -298,15 +298,20 @@ static int mtk_dai_pcm_hw_params(struct snd_pcm_substream *substream,
 
 int mt6797_dai_pcm_register(struct mtk_base_afe *afe)
 {
-	int id = MT6797_DAI_PCM_1;
+	struct mtk_base_afe_dai *dai;
 
-	afe->sub_dais[id].dai_drivers = mtk_dai_pcm_driver;
-	afe->sub_dais[id].num_dai_drivers = ARRAY_SIZE(mtk_dai_pcm_driver);
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
 
-	afe->sub_dais[id].dapm_widgets = mtk_dai_pcm_widgets;
-	afe->sub_dais[id].num_dapm_widgets = ARRAY_SIZE(mtk_dai_pcm_widgets);
-	afe->sub_dais[id].dapm_routes = mtk_dai_pcm_routes;
-	afe->sub_dais[id].num_dapm_routes = ARRAY_SIZE(mtk_dai_pcm_routes);
+	list_add(&dai->list, &afe->sub_dais);
 
+	dai->dai_drivers = mtk_dai_pcm_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_pcm_driver);
+
+	dai->dapm_widgets = mtk_dai_pcm_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mtk_dai_pcm_widgets);
+	dai->dapm_routes = mtk_dai_pcm_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_pcm_routes);
 	return 0;
 }
-- 
1.9.1
