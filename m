From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tegra: Fix unused variable 'spdif'
	warning" to the asoc tree
Date: Tue, 25 Aug 2015 10:36:27 +0100
Message-ID: <E1ZUAeZ-0006Di-A1@debutante>
References: <1440295633.12294.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 94359260438
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 11:36:39 +0200 (CEST)
In-Reply-To: <1440295633.12294.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tegra: Fix unused variable 'spdif' warning

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

>From 5e9a3fcfa2ca10e3ff76938fe9a12515ffa41003 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 23 Aug 2015 10:07:13 +0800
Subject: [PATCH] ASoC: tegra: Fix unused variable 'spdif' warning

Fix below build warning:
  CC [M]  sound/soc/tegra/tegra20_spdif.o
sound/soc/tegra/tegra20_spdif.c: In function 'tegra20_spdif_platform_remove':
sound/soc/tegra/tegra20_spdif.c:361:24: warning: unused variable 'spdif' [-Wunused-variable]

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Vaishali Thakkar <vthakkar1994@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra20_spdif.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 66237bc44033..0809b1ec1171 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -358,8 +358,6 @@ err_pm_disable:
 
 static int tegra20_spdif_platform_remove(struct platform_device *pdev)
 {
-	struct tegra20_spdif *spdif = dev_get_drvdata(&pdev->dev);
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra20_spdif_runtime_suspend(&pdev->dev);
-- 
2.5.0
