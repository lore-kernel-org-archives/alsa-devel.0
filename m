From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: remove unneeded static set .owner field
	in platform_driver" to the asoc tree
Date: Thu, 13 Sep 2018 12:39:42 +0100 (BST)
Message-ID: <20180913113942.273AF1121CA5@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9587E26789F
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 13:39:44 +0200 (CEST)
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
To: zhong jiang <zhongjiang@huawei.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: remove unneeded static set .owner field in platform_driver

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

>From e1e38ea14ea3294546e6350d05a1376197a73589 Mon Sep 17 00:00:00 2001
From: zhong jiang <zhongjiang@huawei.com>
Date: Wed, 12 Sep 2018 11:41:49 +0800
Subject: [PATCH] ASoC: remove unneeded static set .owner field in
 platform_driver

platform_driver_register will set the .owner field. So it is safe
to remove the redundant assignment.

The issue is detected with the help of Coccinelle.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-wm8960.c | 1 -
 sound/soc/mediatek/mt6797/mt6797-mt6351.c | 1 -
 sound/soc/rockchip/rk3288_hdmi_analog.c   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-wm8960.c b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
index 89f34efd9747..e5d49e6e2f99 100644
--- a/sound/soc/mediatek/mt2701/mt2701-wm8960.c
+++ b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
@@ -150,7 +150,6 @@ static const struct of_device_id mt2701_wm8960_machine_dt_match[] = {
 static struct platform_driver mt2701_wm8960_machine = {
 	.driver = {
 		.name = "mt2701-wm8960",
-		.owner = THIS_MODULE,
 #ifdef CONFIG_OF
 		.of_match_table = mt2701_wm8960_machine_dt_match,
 #endif
diff --git a/sound/soc/mediatek/mt6797/mt6797-mt6351.c b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
index b1558c57b9ca..6e578e830e42 100644
--- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
+++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
@@ -205,7 +205,6 @@ static const struct of_device_id mt6797_mt6351_dt_match[] = {
 static struct platform_driver mt6797_mt6351_driver = {
 	.driver = {
 		.name = "mt6797-mt6351",
-		.owner = THIS_MODULE,
 #ifdef CONFIG_OF
 		.of_match_table = mt6797_mt6351_dt_match,
 #endif
diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
index 929b3fe289b0..a472d5eb2950 100644
--- a/sound/soc/rockchip/rk3288_hdmi_analog.c
+++ b/sound/soc/rockchip/rk3288_hdmi_analog.c
@@ -286,7 +286,6 @@ static struct platform_driver rockchip_sound_driver = {
 	.probe = snd_rk_mc_probe,
 	.driver = {
 		.name = DRV_NAME,
-		.owner = THIS_MODULE,
 		.pm = &snd_soc_pm_ops,
 		.of_match_table = rockchip_sound_of_match,
 	},
-- 
2.19.0.rc2
