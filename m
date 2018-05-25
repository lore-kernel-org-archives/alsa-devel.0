From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: add sub dai to mtk_base_afe"
	to the asoc tree
Date: Fri, 25 May 2018 18:36:39 +0100
Message-ID: <E1fMGdr-00082W-VF@debutante>
References: <1527218274-27699-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B207F26768E
 for <alsa-devel@alsa-project.org>; Fri, 25 May 2018 19:36:46 +0200 (CEST)
In-Reply-To: <1527218274-27699-1-git-send-email-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, wsd_upstream@mediatek.com, garlic.tseng@mediatek.com, broonie@kernel.org, linux-mediatek@lists.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: add sub dai to mtk_base_afe

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

>From 13be427e5df4cea08c2d48017aabe112400e1b2f Mon Sep 17 00:00:00 2001
From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Date: Fri, 25 May 2018 11:48:16 +0800
Subject: [PATCH] ASoC: mediatek: add sub dai to mtk_base_afe

In MediaTek SoC chip we have multiple DAI,
such as I2S, ADDA, PCM, etc.

Organize each DAI in to one sub dai,
with its dai driver, controls, widgets, routes.

add mtk_afe_combine_sub_dai() to combine
dai driver from each DAI.

add mtk_afe_add_sub_dai_control() to register
the control, widget, routes to component.

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../mediatek/common/mtk-afe-platform-driver.c | 78 +++++++++++++++++++
 .../mediatek/common/mtk-afe-platform-driver.h |  5 ++
 sound/soc/mediatek/common/mtk-base-afe.h      | 18 +++++
 3 files changed, 101 insertions(+)

diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index 8966ee138387..c4491883090d 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -13,6 +13,84 @@
 #include "mtk-afe-platform-driver.h"
 #include "mtk-base-afe.h"
 
+int mtk_afe_combine_sub_dai(struct mtk_base_afe *afe)
+{
+	struct snd_soc_dai_driver *sub_dai_drivers;
+	size_t num_dai_drivers = 0, dai_idx = 0;
+	int i;
+
+	if (!afe->sub_dais) {
+		dev_err(afe->dev, "%s(), sub_dais == NULL\n", __func__);
+		return -EINVAL;
+	}
+
+	/* calcualte total dai driver size */
+	for (i = 0; i < afe->num_sub_dais; i++) {
+		if (afe->sub_dais[i].dai_drivers &&
+		    afe->sub_dais[i].num_dai_drivers != 0)
+			num_dai_drivers += afe->sub_dais[i].num_dai_drivers;
+	}
+
+	dev_info(afe->dev, "%s(), num of dai %zd\n", __func__, num_dai_drivers);
+
+	/* combine sub_dais */
+	afe->num_dai_drivers = num_dai_drivers;
+	afe->dai_drivers = devm_kcalloc(afe->dev,
+					num_dai_drivers,
+					sizeof(struct snd_soc_dai_driver),
+					GFP_KERNEL);
+	if (!afe->dai_drivers)
+		return -ENOMEM;
+
+	for (i = 0; i < afe->num_sub_dais; i++) {
+		if (afe->sub_dais[i].dai_drivers &&
+		    afe->sub_dais[i].num_dai_drivers != 0) {
+			sub_dai_drivers = afe->sub_dais[i].dai_drivers;
+			/* dai driver */
+			memcpy(&afe->dai_drivers[dai_idx],
+			       sub_dai_drivers,
+			       afe->sub_dais[i].num_dai_drivers *
+			       sizeof(struct snd_soc_dai_driver));
+			dai_idx += afe->sub_dais[i].num_dai_drivers;
+		}
+	}
+
+	return 0;
+}
+
+int mtk_afe_add_sub_dai_control(struct snd_soc_component *component)
+{
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	int i;
+
+	if (!afe->sub_dais) {
+		dev_err(afe->dev, "%s(), sub_dais == NULL\n", __func__);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < afe->num_sub_dais; i++) {
+		if (afe->sub_dais[i].controls)
+			snd_soc_add_component_controls(component,
+				afe->sub_dais[i].controls,
+				afe->sub_dais[i].num_controls);
+
+		if (afe->sub_dais[i].dapm_widgets)
+			snd_soc_dapm_new_controls(&component->dapm,
+				afe->sub_dais[i].dapm_widgets,
+				afe->sub_dais[i].num_dapm_widgets);
+
+		if (afe->sub_dais[i].dapm_routes)
+			snd_soc_dapm_add_routes(&component->dapm,
+				afe->sub_dais[i].dapm_routes,
+				afe->sub_dais[i].num_dapm_routes);
+	}
+
+	snd_soc_dapm_new_widgets(component->dapm.card);
+
+	return 0;
+
+}
+
 static snd_pcm_uframes_t mtk_afe_pcm_pointer
 			 (struct snd_pcm_substream *substream)
 {
diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.h b/sound/soc/mediatek/common/mtk-afe-platform-driver.h
index 1c81d911cf2a..0c31fa4b6f8c 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.h
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.h
@@ -12,5 +12,10 @@
 #define AFE_PCM_NAME "mtk-afe-pcm"
 extern const struct snd_soc_component_driver mtk_afe_pcm_platform;
 
+struct mtk_base_afe;
+struct snd_soc_component;
+
+int mtk_afe_combine_sub_dai(struct mtk_base_afe *afe);
+int mtk_afe_add_sub_dai_control(struct snd_soc_component *component);
 #endif
 
diff --git a/sound/soc/mediatek/common/mtk-base-afe.h b/sound/soc/mediatek/common/mtk-base-afe.h
index c2c5a6c5751d..bcf562f029b6 100644
--- a/sound/soc/mediatek/common/mtk-base-afe.h
+++ b/sound/soc/mediatek/common/mtk-base-afe.h
@@ -48,6 +48,7 @@ struct mtk_base_irq_data {
 struct device;
 struct mtk_base_afe_memif;
 struct mtk_base_afe_irq;
+struct mtk_base_afe_dai;
 struct regmap;
 struct snd_pcm_substream;
 struct snd_soc_dai;
@@ -71,6 +72,11 @@ struct mtk_base_afe {
 	struct mtk_base_afe_irq *irqs;
 	int irqs_size;
 
+	struct mtk_base_afe_dai *sub_dais;
+	int num_sub_dais;
+	struct snd_soc_dai_driver *dai_drivers;
+	unsigned int num_dai_drivers;
+
 	const struct snd_pcm_hardware *mtk_afe_hardware;
 	int (*memif_fs)(struct snd_pcm_substream *substream,
 			unsigned int rate);
@@ -94,5 +100,17 @@ struct mtk_base_afe_irq {
 	int irq_occupyed;
 };
 
+struct mtk_base_afe_dai {
+	struct snd_soc_dai_driver *dai_drivers;
+	unsigned int num_dai_drivers;
+
+	const struct snd_kcontrol_new *controls;
+	unsigned int num_controls;
+	const struct snd_soc_dapm_widget *dapm_widgets;
+	unsigned int num_dapm_widgets;
+	const struct snd_soc_dapm_route *dapm_routes;
+	unsigned int num_dapm_routes;
+};
+
 #endif
 
-- 
2.17.0
