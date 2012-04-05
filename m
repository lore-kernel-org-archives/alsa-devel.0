From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ASoC: tegra: make Tegra20 drivers depend on
	Tegra20 support
Date: Thu,  5 Apr 2012 13:14:52 -0600
Message-ID: <1333653292-21390-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 884941044A9
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 21:14:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

Without this, the Tegra20 drivers can be built into a kernel that's
built only for Tegra30.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This depends on "ASoC: tegra: make Tegra20 drivers depend on Tegra20
support" for context.

 sound/soc/tegra/Kconfig |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index 16632b1..d51945e 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -6,7 +6,7 @@ config SND_SOC_TEGRA
 
 config SND_SOC_TEGRA_DAS
 	tristate
-	depends on SND_SOC_TEGRA
+	depends on SND_SOC_TEGRA && ARCH_TEGRA_2x_SOC
 	help
 	  Say Y or M if you want to add support for the Tegra DAS module.
 	  You will also need to select the individual machine drivers to
@@ -14,7 +14,7 @@ config SND_SOC_TEGRA_DAS
 
 config SND_SOC_TEGRA_I2S
 	tristate
-	depends on SND_SOC_TEGRA
+	depends on SND_SOC_TEGRA && ARCH_TEGRA_2x_SOC
 	select SND_SOC_TEGRA_DAS
 	help
 	  Say Y or M if you want to add support for codecs attached to the
@@ -23,7 +23,7 @@ config SND_SOC_TEGRA_I2S
 
 config SND_SOC_TEGRA_SPDIF
 	tristate
-	depends on SND_SOC_TEGRA
+	depends on SND_SOC_TEGRA && ARCH_TEGRA_2x_SOC
 	default m
 	help
 	  Say Y or M if you want to add support for the SPDIF interface.
@@ -41,7 +41,7 @@ config SND_SOC_TEGRA_WM8903
 	tristate "SoC Audio support for Tegra boards using a WM8903 codec"
 	depends on SND_SOC_TEGRA && I2C
 	depends on MACH_HAS_SND_SOC_TEGRA_WM8903
-	select SND_SOC_TEGRA_I2S
+	select SND_SOC_TEGRA_I2S if ARCH_TEGRA_2x_SOC
 	select SND_SOC_WM8903
 	help
 	  Say Y or M here if you want to add support for SoC audio on Tegra
@@ -51,7 +51,7 @@ config SND_SOC_TEGRA_WM8903
 config SND_SOC_TEGRA_TRIMSLICE
 	tristate "SoC Audio support for TrimSlice board"
 	depends on SND_SOC_TEGRA && MACH_TRIMSLICE && I2C
-	select SND_SOC_TEGRA_I2S
+	select SND_SOC_TEGRA_I2S if ARCH_TEGRA_2x_SOC
 	select SND_SOC_TLV320AIC23
 	help
 	  Say Y or M here if you want to add support for SoC audio on the
@@ -60,7 +60,7 @@ config SND_SOC_TEGRA_TRIMSLICE
 config SND_SOC_TEGRA_ALC5632
 	tristate "SoC Audio support for Tegra boards using an ALC5632 codec"
 	depends on SND_SOC_TEGRA && I2C
-	select SND_SOC_TEGRA_I2S
+	select SND_SOC_TEGRA_I2S if ARCH_TEGRA_2x_SOC
 	select SND_SOC_ALC5632
 	help
 	  Say Y or M here if you want to add support for SoC audio on the
-- 
1.7.0.4
