From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: use __maybe_unused to hide
	st_irq_syscfg_resume" to the asoc tree
Date: Sat, 05 Mar 2016 21:25:10 +0900
Message-ID: <E1acBGg-0003Lu-Oi@finisterre>
References: <1456934350-1389172-15-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 52122266A2C
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:25:16 +0100 (CET)
In-Reply-To: <1456934350-1389172-15-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: use __maybe_unused to hide st_irq_syscfg_resume

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

>From d8fc2198aab117a4bc16ee305caef19c4c7e7f5c Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 2 Mar 2016 16:59:06 +0100
Subject: [PATCH] ASoC: rockchip: use __maybe_unused to hide
 st_irq_syscfg_resume

The rockchip spdif driver uses SIMPLE_DEV_PM_OPS to conditionally
set its power management functions, but we get a warning
about rk_spdif_runtime_resume being unused when CONFIG_PM is not
set:

sound/soc/rockchip/rockchip_spdif.c:67:12: error: 'rk_spdif_runtime_resume' defined but not used [-Werror=unused-function]

This adds a __maybe_unused annotation so the compiler knows
it can silently drop it instead of warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_spdif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 5a806da89f42..274599d4caeb 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -54,7 +54,7 @@ static const struct of_device_id rk_spdif_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rk_spdif_match);
 
-static int rk_spdif_runtime_suspend(struct device *dev)
+static int __maybe_unused rk_spdif_runtime_suspend(struct device *dev)
 {
 	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
 
@@ -64,7 +64,7 @@ static int rk_spdif_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int rk_spdif_runtime_resume(struct device *dev)
+static int __maybe_unused rk_spdif_runtime_resume(struct device *dev)
 {
 	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
 	int ret;
-- 
2.7.0
