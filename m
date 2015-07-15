From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2 2/2] ASoC: Drop owner assignment from platform_driver
Date: Wed, 15 Jul 2015 13:21:45 +0900
Message-ID: <1436934105-12700-2-git-send-email-k.kozlowski@samsung.com>
References: <1436934105-12700-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1436934105-12700-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Support Opensource <support.opensource@diasemi.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Peter Rosin <peda@axentia.se>, Matthias Brugger <matthias.bgg@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

platform_driver does not need to set an owner because
platform_driver_register() will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes since v1:
1. None
---
 sound/soc/mediatek/mt8173-max98090.c      | 1 -
 sound/soc/mediatek/mt8173-rt5650-rt5676.c | 1 -
 sound/soc/mediatek/mtk-afe-pcm.c          | 1 -
 3 files changed, 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8173-max98090.c b/sound/soc/mediatek/mt8173-max98090.c
index 2d2536af141f..39e5660a39ac 100644
--- a/sound/soc/mediatek/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173-max98090.c
@@ -202,7 +202,6 @@ MODULE_DEVICE_TABLE(of, mt8173_max98090_dt_match);
 static struct platform_driver mt8173_max98090_driver = {
 	.driver = {
 		   .name = "mt8173-max98090",
-		   .owner = THIS_MODULE,
 		   .of_match_table = mt8173_max98090_dt_match,
 #ifdef CONFIG_PM
 		   .pm = &snd_soc_pm_ops,
diff --git a/sound/soc/mediatek/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
index 6f52eca05e26..b722145a684c 100644
--- a/sound/soc/mediatek/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
@@ -269,7 +269,6 @@ MODULE_DEVICE_TABLE(of, mt8173_rt5650_rt5676_dt_match);
 static struct platform_driver mt8173_rt5650_rt5676_driver = {
 	.driver = {
 		   .name = "mtk-rt5650-rt5676",
-		   .owner = THIS_MODULE,
 		   .of_match_table = mt8173_rt5650_rt5676_dt_match,
 #ifdef CONFIG_PM
 		   .pm = &snd_soc_pm_ops,
diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index 9863da73dfe0..de38d2e8ef91 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -1220,7 +1220,6 @@ static const struct dev_pm_ops mtk_afe_pm_ops = {
 static struct platform_driver mtk_afe_pcm_driver = {
 	.driver = {
 		   .name = "mtk-afe-pcm",
-		   .owner = THIS_MODULE,
 		   .of_match_table = mtk_afe_pcm_dt_match,
 		   .pm = &mtk_afe_pm_ops,
 	},
-- 
1.9.1
