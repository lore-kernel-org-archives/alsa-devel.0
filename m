From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 6/7] ASoc: Add ability to build sti drivers
Date: Tue, 14 Apr 2015 15:35:30 +0200
Message-ID: <1429018531-29025-7-git-send-email-arnaud.pouliquen@st.com>
References: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6100A260554
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 15:37:27 +0200 (CEST)
In-Reply-To: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Define the platform and codec drivers, and how to build them.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/Kconfig      |  1 +
 sound/soc/Makefile     |  1 +
 sound/soc/sti/Kconfig  | 11 +++++++++++
 sound/soc/sti/Makefile |  5 +++++
 4 files changed, 18 insertions(+)
 create mode 100644 sound/soc/sti/Kconfig
 create mode 100644 sound/soc/sti/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 3ba52da..791f2a6 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -53,6 +53,7 @@ source "sound/soc/samsung/Kconfig"
 source "sound/soc/sh/Kconfig"
 source "sound/soc/sirf/Kconfig"
 source "sound/soc/spear/Kconfig"
+source "sound/soc/sti/Kconfig"
 source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
 source "sound/soc/ux500/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 974ba70..30b2d6d 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= sirf/
 obj-$(CONFIG_SND_SOC)	+= spear/
+obj-$(CONFIG_SND_SOC)	+= sti/
 obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
 obj-$(CONFIG_SND_SOC)	+= ux500/
diff --git a/sound/soc/sti/Kconfig b/sound/soc/sti/Kconfig
new file mode 100644
index 0000000..c29e219
--- /dev/null
+++ b/sound/soc/sti/Kconfig
@@ -0,0 +1,11 @@
+#
+# STM SoC audio configuration
+#
+menuconfig SND_SOC_STI
+	tristate "SoC Audio support for STI System-On-Chip"
+	depends on SND_SOC
+	depends on ARCH_STI
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	help
+		Say Y if you want to enable ASoC-support for
+		any of the STI platforms (e.g. STIH416).
diff --git a/sound/soc/sti/Makefile b/sound/soc/sti/Makefile
new file mode 100644
index 0000000..de38cce
--- /dev/null
+++ b/sound/soc/sti/Makefile
@@ -0,0 +1,5 @@
+# STI platform support
+snd-soc-sti-objs := sti_platform.o uniperif_player.o uniperif_reader.o
+
+obj-$(CONFIG_SND_SOC_STI) += snd-soc-sti.o
+
-- 
1.9.1
