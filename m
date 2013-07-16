From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoc: tegra: Remove unneeded mach-type.h
	incldues
Date: Tue, 16 Jul 2013 17:30:23 +0100
Message-ID: <1373992223-27236-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CC27D264F8F
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 18:30:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/tegra/tegra_alc5632.c | 2 --
 sound/soc/tegra/tegra_wm8753.c  | 2 --
 sound/soc/tegra/trimslice.c     | 2 --
 3 files changed, 6 deletions(-)

diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
index 48d05d9..c61ea3a 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -13,8 +13,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <asm/mach-types.h>
-
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/sound/soc/tegra/tegra_wm8753.c b/sound/soc/tegra/tegra_wm8753.c
index f87fc53..8e774d1 100644
--- a/sound/soc/tegra/tegra_wm8753.c
+++ b/sound/soc/tegra/tegra_wm8753.c
@@ -28,8 +28,6 @@
  *
  */
 
-#include <asm/mach-types.h>
-
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/sound/soc/tegra/trimslice.c b/sound/soc/tegra/trimslice.c
index 05c68aa..734bfcd 100644
--- a/sound/soc/tegra/trimslice.c
+++ b/sound/soc/tegra/trimslice.c
@@ -24,8 +24,6 @@
  *
  */
 
-#include <asm/mach-types.h>
-
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-- 
1.8.3.2
