From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: Drop owner assignment from
	platform_driver" to the asoc tree
Date: Wed, 15 Jul 2015 12:55:44 +0100
Message-ID: <E1ZFLHs-0006ea-38@debutante>
References: <1436506231-8980-3-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D3388265C95
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 13:55:54 +0200 (CEST)
In-Reply-To: <1436506231-8980-3-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Koro Chen <koro.chen@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: Drop owner assignment from platform_driver

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

>From 27bc1dd24488ce2a13e5c59aaf6d3202e519e21e Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Fri, 10 Jul 2015 14:30:31 +0900
Subject: [PATCH] ASoC: mediatek: Drop owner assignment from platform_driver

platform_driver does not need to set an owner because
platform_driver_register() will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Koro Chen <koro.chen@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8173-max98090.c      | 1 -
 sound/soc/mediatek/mt8173-rt5650-rt5676.c | 1 -
 sound/soc/mediatek/mtk-afe-pcm.c          | 1 -
 3 files changed, 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8173-max98090.c b/sound/soc/mediatek/mt8173-max98090.c
index 4d44b5803e55..6311f31fa669 100644
--- a/sound/soc/mediatek/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173-max98090.c
@@ -193,7 +193,6 @@ MODULE_DEVICE_TABLE(of, mt8173_max98090_dt_match);
 static struct platform_driver mt8173_max98090_driver = {
 	.driver = {
 		   .name = "mt8173-max98090",
-		   .owner = THIS_MODULE,
 		   .of_match_table = mt8173_max98090_dt_match,
 #ifdef CONFIG_PM
 		   .pm = &snd_soc_pm_ops,
diff --git a/sound/soc/mediatek/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
index 094055323059..4fd7dff15fe7 100644
--- a/sound/soc/mediatek/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
@@ -258,7 +258,6 @@ MODULE_DEVICE_TABLE(of, mt8173_rt5650_rt5676_dt_match);
 static struct platform_driver mt8173_rt5650_rt5676_driver = {
 	.driver = {
 		   .name = "mtk-rt5650-rt5676",
-		   .owner = THIS_MODULE,
 		   .of_match_table = mt8173_rt5650_rt5676_dt_match,
 #ifdef CONFIG_PM
 		   .pm = &snd_soc_pm_ops,
diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index cc228db5fb76..5b74afb59c5c 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -1218,7 +1218,6 @@ static const struct dev_pm_ops mtk_afe_pm_ops = {
 static struct platform_driver mtk_afe_pcm_driver = {
 	.driver = {
 		   .name = "mtk-afe-pcm",
-		   .owner = THIS_MODULE,
 		   .of_match_table = mtk_afe_pcm_dt_match,
 		   .pm = &mtk_afe_pm_ops,
 	},
-- 
2.1.4
