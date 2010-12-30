From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/4] ASoC sst: Add makefiles and kconfigs
	changes
Date: Thu, 30 Dec 2010 16:43:38 +0530
Message-ID: <1293707618-8404-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 9721924401
	for <alsa-devel@alsa-project.org>; Thu, 30 Dec 2010 12:11:50 +0100 (CET)
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
Cc: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds the makefile and kconfig changes for mid asoc driver platform and machine driver which are introduced in 2 preceeding patches

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/Kconfig          |    1 +
 sound/soc/Makefile         |    1 +
 sound/soc/mid-x86/Kconfig  |   13 +++++++++++++
 sound/soc/mid-x86/Makefile |    5 +++++
 4 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/mid-x86/Kconfig
 create mode 100644 sound/soc/mid-x86/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index a3efc52..f28bab4 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -47,6 +47,7 @@ source "sound/soc/ep93xx/Kconfig"
 source "sound/soc/fsl/Kconfig"
 source "sound/soc/imx/Kconfig"
 source "sound/soc/jz4740/Kconfig"
+source "sound/soc/mid-x86/Kconfig"
 source "sound/soc/nuc900/Kconfig"
 source "sound/soc/omap/Kconfig"
 source "sound/soc/kirkwood/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index ce913bf..df83d21 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SND_SOC)	+= ep93xx/
 obj-$(CONFIG_SND_SOC)	+= fsl/
 obj-$(CONFIG_SND_SOC)   += imx/
 obj-$(CONFIG_SND_SOC)	+= jz4740/
+obj-$(CONFIG_SND_SOC)	+= mid-x86/
 obj-$(CONFIG_SND_SOC)	+= nuc900/
 obj-$(CONFIG_SND_SOC)	+= omap/
 obj-$(CONFIG_SND_SOC)	+= kirkwood/
diff --git a/sound/soc/mid-x86/Kconfig b/sound/soc/mid-x86/Kconfig
new file mode 100644
index 0000000..0e2ab32
--- /dev/null
+++ b/sound/soc/mid-x86/Kconfig
@@ -0,0 +1,13 @@
+config SND_MID_MACHINE
+	tristate "SOC Machine Audio driver for Intel MID chips"
+	select SND_SOC_MSIC
+	select SND_MID_PLATFORM
+	help
+          This adds support for ASoC machine driver used as alsa device
+          in audio substem in Intel(R) MID devices
+          Say Y if you have such a device
+          If unsure select "N".
+
+config SND_MID_PLATFORM
+	tristate
+	depends on SND_INTEL_SST
diff --git a/sound/soc/mid-x86/Makefile b/sound/soc/mid-x86/Makefile
new file mode 100644
index 0000000..884241a
--- /dev/null
+++ b/sound/soc/mid-x86/Makefile
@@ -0,0 +1,5 @@
+snd-soc-mid-platform-objs := mid_platform.o mid_platform_lib.o
+snd-soc-mid-machine-objs := mid_machine.o mid_machine_lib.o
+
+obj-$(CONFIG_SND_MID_PLATFORM) += snd-soc-mid-platform.o
+obj-$(CONFIG_SND_MID_MACHINE) += snd-soc-mid-machine.o
-- 
1.7.2.3
