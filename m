From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 7/7] ASoC: tegra: Kconfig and Makefile
Date: Fri,  7 Jan 2011 22:36:17 -0700
Message-ID: <1294464977-25814-8-git-send-email-swarren@nvidia.com>
References: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9935C1039A0
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2011 06:36:41 +0100 (CET)
In-Reply-To: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/Kconfig        |    1 +
 sound/soc/Makefile       |    1 +
 sound/soc/tegra/Kconfig  |   27 +++++++++++++++++++++++++++
 sound/soc/tegra/Makefile |   14 ++++++++++++++
 4 files changed, 43 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/tegra/Kconfig
 create mode 100644 sound/soc/tegra/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index a3efc52..2cdbdad 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -54,6 +54,7 @@ source "sound/soc/pxa/Kconfig"
 source "sound/soc/samsung/Kconfig"
 source "sound/soc/s6000/Kconfig"
 source "sound/soc/sh/Kconfig"
+source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
 
 # Supported codecs
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index ce913bf..3141c4d 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -17,4 +17,5 @@ obj-$(CONFIG_SND_SOC)	+= pxa/
 obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= s6000/
 obj-$(CONFIG_SND_SOC)	+= sh/
+obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
new file mode 100644
index 0000000..5514f1c
--- /dev/null
+++ b/sound/soc/tegra/Kconfig
@@ -0,0 +1,27 @@
+config SND_TEGRA_SOC
+	tristate "SoC Audio for the Tegra System-on-Chip"
+	depends on ARCH_TEGRA && TEGRA_SYSTEM_DMA
+	default m
+	help
+	  Say Y or M here if you want support for SoC audio on Tegra.
+
+config SND_TEGRA_SOC_I2S
+	tristate
+	depends on SND_TEGRA_SOC
+	depends on !TEGRA_I2S_AUDIO
+	default m
+	help
+	  Say Y or M if you want to add support for codecs attached to the
+	  Tegra I2S interface. You will also need to select the individual
+	  machine drivers to support below.
+
+config SND_TEGRA_SOC_HARMONY
+	tristate "SoC Audio support for Tegra Harmony reference board"
+	depends on SND_TEGRA_SOC && MACH_HARMONY && I2C
+	default m
+	select SND_TEGRA_SOC_I2S
+	select SND_SOC_WM8903
+	help
+	  Say Y or M here if you want to add support for SoC audio on the
+	  Tegra Harmony reference board.
+
diff --git a/sound/soc/tegra/Makefile b/sound/soc/tegra/Makefile
new file mode 100644
index 0000000..dfd2ab9
--- /dev/null
+++ b/sound/soc/tegra/Makefile
@@ -0,0 +1,14 @@
+# Tegra platform Support
+snd-soc-tegra-das-objs := tegra_das.o
+snd-soc-tegra-pcm-objs := tegra_pcm.o
+snd-soc-tegra-i2s-objs := tegra_i2s.o
+
+obj-$(CONFIG_SND_TEGRA_SOC) += snd-soc-tegra-das.o
+obj-$(CONFIG_SND_TEGRA_SOC) += snd-soc-tegra-pcm.o
+obj-$(CONFIG_SND_TEGRA_SOC_I2S) += snd-soc-tegra-i2s.o
+
+# Tegra machine Support
+snd-soc-tegra-harmony-objs := harmony.o
+snd-soc-tegra-harmony-objs += tegra_asoc_utils.o
+
+obj-$(CONFIG_SND_TEGRA_SOC_HARMONY) += snd-soc-tegra-harmony.o
-- 
1.7.0.4
