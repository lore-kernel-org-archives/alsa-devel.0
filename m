From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Add ability to build sti drivers" to
	the asoc tree
Date: Thu, 16 Jul 2015 22:01:23 +0100
Message-ID: <E1ZFqHT-0001iA-T3@finisterre>
References: <1434983473-25092-7-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 696962666EF
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:01:31 +0200 (CEST)
In-Reply-To: <1434983473-25092-7-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add ability to build sti drivers

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

>From 1e6babb417f76bd6d1a4d1d633e5c46435acbfe7 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Thu, 16 Jul 2015 11:36:05 +0200
Subject: [PATCH] ASoC: Add ability to build sti drivers

Define the platform and codec drivers, and how to build them.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/Kconfig      |  1 +
 sound/soc/Makefile     |  1 +
 sound/soc/sti/Kconfig  | 11 +++++++++++
 sound/soc/sti/Makefile |  4 ++++
 4 files changed, 17 insertions(+)
 create mode 100644 sound/soc/sti/Kconfig
 create mode 100644 sound/soc/sti/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 2ae9619..467ee1a 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -54,6 +54,7 @@ source "sound/soc/samsung/Kconfig"
 source "sound/soc/sh/Kconfig"
 source "sound/soc/sirf/Kconfig"
 source "sound/soc/spear/Kconfig"
+source "sound/soc/sti/Kconfig"
 source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
 source "sound/soc/ux500/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index e189903..19fd711 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= sirf/
 obj-$(CONFIG_SND_SOC)	+= spear/
+obj-$(CONFIG_SND_SOC)	+= sti/
 obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
 obj-$(CONFIG_SND_SOC)	+= ux500/
diff --git a/sound/soc/sti/Kconfig b/sound/soc/sti/Kconfig
new file mode 100644
index 0000000..64a6900
--- /dev/null
+++ b/sound/soc/sti/Kconfig
@@ -0,0 +1,11 @@
+#
+# STM SoC audio configuration
+#
+menuconfig SND_SOC_STI
+	tristate "SoC Audio support for STI System-On-Chip"
+	depends on SND_SOC
+	depends on ARCH_STI || COMPILE_TEST
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	help
+		Say Y if you want to enable ASoC-support for
+		any of the STI platforms (e.g. STIH416).
diff --git a/sound/soc/sti/Makefile b/sound/soc/sti/Makefile
new file mode 100644
index 0000000..4b188d2
--- /dev/null
+++ b/sound/soc/sti/Makefile
@@ -0,0 +1,4 @@
+# STI platform support
+snd-soc-sti-objs := sti_uniperif.o uniperif_player.o uniperif_reader.o
+
+obj-$(CONFIG_SND_SOC_STI) += snd-soc-sti.o
-- 
2.1.4
