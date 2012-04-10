From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V2 3/3] ASoC: tegra: add Kconfig and Makefile
	support for Tegra30
Date: Tue, 10 Apr 2012 16:32:01 -0600
Message-ID: <1334097121-18897-3-git-send-email-swarren@wwwdotorg.org>
References: <1334097121-18897-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DBCB3104028
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Apr 2012 00:32:14 +0200 (CEST)
In-Reply-To: <1334097121-18897-1-git-send-email-swarren@wwwdotorg.org>
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

This adds Kconfig options for the Tegra30 AHUB and I2S controller, and
updates the Tegra+WM8903 machine driver Kconfig to select those.

Includes a squashed bugfix from Sumit Bhattacharya <sumitb@nvidia.com>

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Drop Kconfig short descriptions from Tegra30 AHUB and I2S variables;
they don't need to be user-visible, since they're selected by ASoC
machine drivers.
---
 sound/soc/tegra/Kconfig  |   18 ++++++++++++++++++
 sound/soc/tegra/Makefile |    4 ++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index d70fe94..5331c61 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -31,6 +31,23 @@ config SND_SOC_TEGRA20_SPDIF
 	  You will also need to select the individual machine drivers to support
 	  below.
 
+config SND_SOC_TEGRA30_AHUB
+	tristate
+	depends on SND_SOC_TEGRA && ARCH_TEGRA_3x_SOC
+	help
+	  Say Y or M if you want to add support for the Tegra20 AHUB module.
+	  You will also need to select the individual machine drivers to
+	  support below.
+
+config SND_SOC_TEGRA30_I2S
+	tristate
+	depends on SND_SOC_TEGRA && ARCH_TEGRA_3x_SOC
+	select SND_SOC_TEGRA30_AHUB
+	help
+	  Say Y or M if you want to add support for codecs attached to the
+	  Tegra30 I2S interface. You will also need to select the individual
+	  machine drivers to support below.
+
 config MACH_HAS_SND_SOC_TEGRA_WM8903
 	bool
 	help
@@ -43,6 +60,7 @@ config SND_SOC_TEGRA_WM8903
 	depends on SND_SOC_TEGRA && I2C
 	depends on MACH_HAS_SND_SOC_TEGRA_WM8903
 	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
+	select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC
 	select SND_SOC_WM8903
 	help
 	  Say Y or M here if you want to add support for SoC audio on Tegra
diff --git a/sound/soc/tegra/Makefile b/sound/soc/tegra/Makefile
index 4726b90..98704b4 100644
--- a/sound/soc/tegra/Makefile
+++ b/sound/soc/tegra/Makefile
@@ -4,12 +4,16 @@ snd-soc-tegra-utils-objs += tegra_asoc_utils.o
 snd-soc-tegra20-das-objs := tegra20_das.o
 snd-soc-tegra20-i2s-objs := tegra20_i2s.o
 snd-soc-tegra20-spdif-objs := tegra20_spdif.o
+snd-soc-tegra30-ahub-objs := tegra30_ahub.o
+snd-soc-tegra30-i2s-objs := tegra30_i2s.o
 
 obj-$(CONFIG_SND_SOC_TEGRA) += snd-soc-tegra-pcm.o
 obj-$(CONFIG_SND_SOC_TEGRA) += snd-soc-tegra-utils.o
 obj-$(CONFIG_SND_SOC_TEGRA20_DAS) += snd-soc-tegra20-das.o
 obj-$(CONFIG_SND_SOC_TEGRA20_I2S) += snd-soc-tegra20-i2s.o
 obj-$(CONFIG_SND_SOC_TEGRA20_SPDIF) += snd-soc-tegra20-spdif.o
+obj-$(CONFIG_SND_SOC_TEGRA30_AHUB) += snd-soc-tegra30-ahub.o
+obj-$(CONFIG_SND_SOC_TEGRA30_I2S) += snd-soc-tegra30-i2s.o
 
 # Tegra machine Support
 snd-soc-tegra-wm8903-objs := tegra_wm8903.o
-- 
1.7.0.4
