From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove default settings from Tegra
	Kconfig
Date: Thu, 21 Apr 2011 12:02:52 +0100
Message-ID: <1303383772-15127-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B7FD41038E4
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Apr 2011 13:02:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There needs to be a strong reason for overriding the Kconfig default.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/tegra/Kconfig |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index a759fbe..0f5bd82 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -1,14 +1,12 @@
 config SND_SOC_TEGRA
 	tristate "SoC Audio for the Tegra System-on-Chip"
 	depends on ARCH_TEGRA && TEGRA_SYSTEM_DMA
-	default m
 	help
 	  Say Y or M here if you want support for SoC audio on Tegra.
 
 config SND_SOC_TEGRA_I2S
 	tristate
 	depends on SND_SOC_TEGRA
-	default m
 	help
 	  Say Y or M if you want to add support for codecs attached to the
 	  Tegra I2S interface. You will also need to select the individual
@@ -25,7 +23,6 @@ config SND_SOC_TEGRA_WM8903
 	tristate "SoC Audio support for Tegra boards using a WM8903 codec"
 	depends on SND_SOC_TEGRA && I2C
 	depends on MACH_HAS_SND_SOC_TEGRA_WM8903
-	default m
 	select SND_SOC_TEGRA_I2S
 	select SND_SOC_WM8903
 	help
-- 
1.7.4.1
