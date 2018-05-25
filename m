From: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 3/3] ASoC: mt6797: combine DAI to register component
Date: Fri, 25 May 2018 11:48:18 +0800
Message-ID: <1527220098-9731-3-git-send-email-kaichieh.chuang@mediatek.com>
References: <1527220098-9731-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1527220098-9731-1-git-send-email-kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wsd_upstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 .../soc/mediatek/common/mtk-afe-platform-driver.c  |  6 +--
 .../soc/mediatek/common/mtk-afe-platform-driver.h  |  7 +++
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c         | 53 ++++++++++++++++++----
 3 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index c449188..0061858 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -126,12 +126,12 @@ int mtk_afe_add_sub_dai_control(struct snd_soc_component *component)
 	return bytes_to_frames(substream->runtime, pcm_ptr_bytes);
 }
 
-static const struct snd_pcm_ops mtk_afe_pcm_ops = {
+const struct snd_pcm_ops mtk_afe_pcm_ops = {
 	.ioctl = snd_pcm_lib_ioctl,
 	.pointer = mtk_afe_pcm_pointer,
 };
 
-static int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
+int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	size_t size;
 	struct snd_pcm *pcm = rtd->pcm;
@@ -144,7 +144,7 @@ static int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
 						     size, size);
 }
 
-static void mtk_afe_pcm_free(struct snd_pcm *pcm)
+void mtk_afe_pcm_free(struct snd_pcm *pcm)
 {
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.h b/sound/soc/mediatek/common/mtk-afe-platform-driver.h
index 0c31fa4..88df679 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.h
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.h
@@ -10,10 +10,17 @@
 #define _MTK_AFE_PLATFORM_DRIVER_H_
 
 #define AFE_PCM_NAME "mtk-afe-pcm"
+extern const struct snd_pcm_ops mtk_afe_pcm_ops;
 extern const struct snd_soc_component_driver mtk_afe_pcm_platform;
 
 struct mtk_base_afe;
+struct snd_pcm;
 struct snd_soc_component;
+struct snd_soc_pcm_runtime;
+
+
+int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd);
+void mtk_afe_pcm_free(struct snd_pcm *pcm);
 
 int mtk_afe_combine_sub_dai(struct mtk_base_afe *afe);
 int mtk_afe_add_sub_dai_control(struct snd_soc_component *component);
diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
index c892b7f..1286c6e 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -172,7 +172,7 @@ static int mt6797_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 			 SNDRV_PCM_FMTBIT_S24_LE |\
 			 SNDRV_PCM_FMTBIT_S32_LE)
 
-static struct snd_soc_dai_driver mt6797_afe_pcm_dais[] = {
+static struct snd_soc_dai_driver mt6797_memif_dai_driver[] = {
 	/* FE DAIs: memory intefaces to CPU */
 	{
 		.name = "DL1",
@@ -329,7 +329,7 @@ static int mt6797_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 				    I_ADDA_UL_CH2, 1, 0),
 };
 
-static const struct snd_soc_dapm_widget mt6797_afe_pcm_widgets[] = {
+static const struct snd_soc_dapm_widget mt6797_memif_widgets[] = {
 	/* memif */
 	SND_SOC_DAPM_MIXER("UL1_CH1", SND_SOC_NOPM, 0, 0,
 			   memif_ul1_ch1_mix, ARRAY_SIZE(memif_ul1_ch1_mix)),
@@ -355,7 +355,7 @@ static int mt6797_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 			   ARRAY_SIZE(memif_ul_mono_2_mix)),
 };
 
-static const struct snd_soc_dapm_route mt6797_afe_pcm_routes[] = {
+static const struct snd_soc_dapm_route mt6797_memif_routes[] = {
 	/* capture */
 	{"UL1", NULL, "UL1_CH1"},
 	{"UL1", NULL, "UL1_CH2"},
@@ -383,10 +383,6 @@ static int mt6797_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 
 static const struct snd_soc_component_driver mt6797_afe_pcm_dai_component = {
 	.name = "mt6797-afe-pcm-dai",
-	.dapm_widgets = mt6797_afe_pcm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(mt6797_afe_pcm_widgets),
-	.dapm_routes = mt6797_afe_pcm_routes,
-	.num_dapm_routes = ARRAY_SIZE(mt6797_afe_pcm_routes),
 };
 
 static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
@@ -724,6 +720,19 @@ static int mt6797_afe_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int mt6797_afe_component_probe(struct snd_soc_component *component)
+{
+	return mtk_afe_add_sub_dai_control(component);
+}
+
+static const struct snd_soc_component_driver mt6797_afe_component = {
+	.name = AFE_PCM_NAME,
+	.ops = &mtk_afe_pcm_ops,
+	.pcm_new = mtk_afe_pcm_new,
+	.pcm_free = mtk_afe_pcm_free,
+	.probe = mt6797_afe_component_probe,
+};
+
 static int mt6797_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	struct mtk_base_afe *afe;
@@ -801,6 +810,29 @@ static int mt6797_afe_pcm_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* init sub_dais */
+	afe->num_sub_dais = MT6797_DAI_NUM;
+	afe->sub_dais = devm_kcalloc(dev, afe->num_sub_dais,
+				     sizeof(*afe->sub_dais),
+				     GFP_KERNEL);
+	if (!afe->sub_dais)
+		return -ENOMEM;
+
+	mt6797_dai_adda_register(afe);
+
+	afe->sub_dais[MT6797_MEMIF_DL1].dai_drivers = mt6797_memif_dai_driver;
+	afe->sub_dais[MT6797_MEMIF_DL1].num_dai_drivers =
+		ARRAY_SIZE(mt6797_memif_dai_driver);
+	afe->sub_dais[MT6797_MEMIF_DL1].dapm_widgets = mt6797_memif_widgets;
+	afe->sub_dais[MT6797_MEMIF_DL1].num_dapm_widgets =
+		ARRAY_SIZE(mt6797_memif_widgets);
+	afe->sub_dais[MT6797_MEMIF_DL1].dapm_routes = mt6797_memif_routes;
+	afe->sub_dais[MT6797_MEMIF_DL1].num_dapm_routes =
+		ARRAY_SIZE(mt6797_memif_routes);
+
+	/* init dai_driver and component_driver */
+	mtk_afe_combine_sub_dai(afe);
+
 	afe->mtk_afe_hardware = &mt6797_afe_hardware;
 	afe->memif_fs = mt6797_memif_fs;
 	afe->irq_fs = mt6797_irq_fs;
@@ -815,7 +847,8 @@ static int mt6797_afe_pcm_dev_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	pm_runtime_get_sync(&pdev->dev);
 
-	ret = devm_snd_soc_register_component(dev, &mtk_afe_pcm_platform,
+	/* register component */
+	ret = devm_snd_soc_register_component(dev, &mt6797_afe_component,
 					      NULL, 0);
 	if (ret) {
 		dev_warn(dev, "err_platform\n");
@@ -824,8 +857,8 @@ static int mt6797_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_component(afe->dev,
 				     &mt6797_afe_pcm_dai_component,
-				     mt6797_afe_pcm_dais,
-				     ARRAY_SIZE(mt6797_afe_pcm_dais));
+				     afe->dai_drivers,
+				     afe->num_dai_drivers);
 	if (ret) {
 		dev_warn(dev, "err_dai_component\n");
 		goto err_pm_disable;
-- 
1.9.1
