From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mt6797: sub dai use list_head" to the
	asoc tree
Date: Fri, 29 Jun 2018 13:32:06 +0100
Message-ID: <E1fYsZK-0005dE-GX@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 55035267A38
 for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2018 14:32:11 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mt6797: sub dai use list_head

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

>From c1d9b4196ba6b311bd48a9320cd46aa125e0b034 Mon Sep 17 00:00:00 2001
From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Date: Fri, 29 Jun 2018 20:29:45 +0800
Subject: [PATCH] ASoC: mt6797: sub dai use list_head

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt6797/mt6797-afe-common.h |  1 +
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c    | 65 +++++++++++++------
 sound/soc/mediatek/mt6797/mt6797-dai-adda.c   | 20 ++++--
 .../soc/mediatek/mt6797/mt6797-dai-hostless.c | 16 +++--
 sound/soc/mediatek/mt6797/mt6797-dai-pcm.c    | 19 ++++--
 5 files changed, 81 insertions(+), 40 deletions(-)

diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-common.h b/sound/soc/mediatek/mt6797/mt6797-afe-common.h
index 22eb7b455cf1..4eac9977b2b0 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-common.h
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-common.h
@@ -10,6 +10,7 @@
 #define _MT_6797_AFE_COMMON_H_
 
 #include <sound/soc.h>
+#include <linux/list.h>
 #include <linux/regmap.h>
 #include "../common/mtk-base-afe.h"
 
diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
index 6c5dd9fc9976..192f4d7b37b6 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -733,6 +733,34 @@ static const struct snd_soc_component_driver mt6797_afe_component = {
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
index ad083265ce94..0ac6409c6d61 100644
--- a/sound/soc/mediatek/mt6797/mt6797-dai-adda.c
+++ b/sound/soc/mediatek/mt6797/mt6797-dai-adda.c
@@ -383,14 +383,20 @@ static struct snd_soc_dai_driver mtk_dai_adda_driver[] = {
 
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
index 4cf985b15a11..ed23e6a53b08 100644
--- a/sound/soc/mediatek/mt6797/mt6797-dai-hostless.c
+++ b/sound/soc/mediatek/mt6797/mt6797-dai-hostless.c
@@ -100,13 +100,19 @@ static struct snd_soc_dai_driver mtk_dai_hostless_driver[] = {
 
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
index 16d5b5067204..3136f0bc7827 100644
--- a/sound/soc/mediatek/mt6797/mt6797-dai-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-dai-pcm.c
@@ -298,15 +298,20 @@ static struct snd_soc_dai_driver mtk_dai_pcm_driver[] = {
 
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
2.18.0.rc2
