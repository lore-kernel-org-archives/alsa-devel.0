From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 4/4] ASoC sst v2: Add makefiles and kconfigs
	changes
Date: Tue,  4 Jan 2011 20:17:04 +0530
Message-ID: <1294152424-8976-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id D2C0710392B
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2011 15:45:41 +0100 (CET)
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

From: Vinod Koul <vinod.koul@intel.com>

This patch adds the makefile and kconfig changes for mid asoc drivers:
platform and machine driver which are introduced in 2 preceeding patches

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/Kconfig          |    1 +
 sound/soc/Makefile         |    1 +
 sound/soc/mid-x86/Kconfig  |   13 +++++++++++++
 sound/soc/mid-x86/Makefile |    7 +++++++
 4 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/mid-x86/Kconfig
 create mode 100644 sound/soc/mid-x86/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index a3efc52..821ab0b 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -50,6 +50,7 @@ source "sound/soc/jz4740/Kconfig"
 source "sound/soc/nuc900/Kconfig"
 source "sound/soc/omap/Kconfig"
 source "sound/soc/kirkwood/Kconfig"
+source "sound/soc/mid-x86/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/samsung/Kconfig"
 source "sound/soc/s6000/Kconfig"
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
index 0000000..e0123a4
--- /dev/null
+++ b/sound/soc/mid-x86/Kconfig
@@ -0,0 +1,13 @@
+config SND_MFLD_MACHINE
+	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
+	select SND_SOC_SN95031
+	select SND_SST_PLATFORM
+	help
+          This adds support for ASoC machine driver for Intel(R) MID Medfield platform
+          used as alsa device in audio substem in Intel(R) MID devices
+          Say Y if you have such a device
+          If unsure select "N".
+
+config SND_SST_PLATFORM
+	tristate
+	depends on SND_INTEL_SST
diff --git a/sound/soc/mid-x86/Makefile b/sound/soc/mid-x86/Makefile
new file mode 100644
index 0000000..a1a9331
--- /dev/null
+++ b/sound/soc/mid-x86/Makefile
@@ -0,0 +1,7 @@
+EXTRA_CFLAGS += -DDEBUG
+
+snd-soc-sst-platform-objs := sst_platform.o
+snd-soc-mfld-machine-objs := mfld_machine.o
+
+obj-$(CONFIG_SND_SST_PLATFORM) += snd-soc-sst-platform.o
+obj-$(CONFIG_SND_MFLD_MACHINE) += snd-soc-mfld-machine.o
-- 
1.7.2.3
