From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: tegra: Fix unused variable 'spdif'
	warning
Date: Sun, 23 Aug 2015 10:07:13 +0800
Message-ID: <1440295633.12294.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 56D50260469
 for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2015 04:07:20 +0200 (CEST)
Received: by pacgr6 with SMTP id gr6so3808979pac.0
 for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2015 19:07:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Vaishali Thakkar <vthakkar1994@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Fix below build warning:
  CC [M]  sound/soc/tegra/tegra20_spdif.o
sound/soc/tegra/tegra20_spdif.c: In function 'tegra20_spdif_platform_remove':
sound/soc/tegra/tegra20_spdif.c:361:24: warning: unused variable 'spdif' [-Wunused-variable]

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/tegra/tegra20_spdif.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 66237bc..0809b1e 100644
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
2.1.0
