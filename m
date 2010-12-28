From: " Koul, Vinod" <vinod.koul@intel.com>
Subject: [RFC 4/4] ASoC SST: Add makefiles and kconfigs changes
Date: Tue, 28 Dec 2010 17:41:55 +0530
Message-ID: <1293538315-31950-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 4845D1038CA
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 13:10:34 +0100 (CET)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This patch adds the makefile and kconfig changes for mid asoc driver which are introduced in 3 preceeding patches

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/Kconfig          |    1 +
 sound/soc/Makefile         |    1 +
 sound/soc/codecs/Kconfig   |    5 ++++-
 sound/soc/codecs/Makefile  |    3 +++
 sound/soc/mid-x86/Kconfig  |   20 ++++++++++++++++++++
 sound/soc/mid-x86/Makefile |    9 +++++++++
 6 files changed, 38 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/mid-x86/Kconfig
 create mode 100644 sound/soc/mid-x86/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index a3efc52..0e966a6 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -55,6 +55,7 @@ source "sound/soc/samsung/Kconfig"
 source "sound/soc/s6000/Kconfig"
 source "sound/soc/sh/Kconfig"
 source "sound/soc/txx9/Kconfig"
+source "sound/soc/mid-x86/Kconfig"
 
 # Supported codecs
 source "sound/soc/codecs/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index ce913bf..92d7551 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= s6000/
 obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= txx9/
+obj-$(CONFIG_SND_SOC)	+= mid-x86/
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 054191e..2a12bcc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -84,7 +84,8 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM9705 if SND_SOC_AC97_BUS
 	select SND_SOC_WM9712 if SND_SOC_AC97_BUS
 	select SND_SOC_WM9713 if SND_SOC_AC97_BUS
-        help
+        select SND_SOC_MSIC if INTEL_SCU_IPC
+	help
           Normally ASoC codec drivers are only built if a machine driver which
           uses them is also built since they are only usable with a machine
           driver.  Selecting this option will allow these drivers to be built
@@ -321,6 +322,8 @@ config SND_SOC_WM9712
 
 config SND_SOC_WM9713
 	tristate
+config SND_SOC_MSIC
+	tristate
 
 # Amp
 config SND_SOC_MAX9877
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 6a1e17b..07cedc0 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -1,3 +1,4 @@
+EXTRA_CFLAGS += -DDEBUG
 snd-soc-88pm860x-objs := 88pm860x-codec.o
 snd-soc-ac97-objs := ac97.o
 snd-soc-ad1836-objs := ad1836.o
@@ -69,6 +70,7 @@ snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o
 snd-soc-wm-hubs-objs := wm_hubs.o
 snd-soc-jz4740-codec-objs := jz4740.o
+snd-soc-msic-objs := msic.o
 
 # Amp
 snd-soc-max9877-objs := max9877.o
@@ -147,6 +149,7 @@ obj-$(CONFIG_SND_SOC_WM9705)	+= snd-soc-wm9705.o
 obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
 obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
 obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
+obj-$(CONFIG_SND_SOC_MSIC) +=snd-soc-msic.o
 
 # Amp
 obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
diff --git a/sound/soc/mid-x86/Kconfig b/sound/soc/mid-x86/Kconfig
new file mode 100644
index 0000000..a61e53d
--- /dev/null
+++ b/sound/soc/mid-x86/Kconfig
@@ -0,0 +1,20 @@
+#config SND_MID_PLATFORM
+#	tristate "SoC Platform Audio driver for Intel MID chips"
+#	default y
+#	help
+#	  Say Y if you want to add support for SoC platform driver for Intel MID
+
+
+config SND_MID_PLATFORM
+	tristate
+	depends on SND_INTEL_SST
+
+config SND_MID_MACHINE
+	tristate "SOC Machine Audio driver for Intel MID chips"
+	select SND_SOC_MSIC
+	select SND_MID_PLATFORM
+	default n
+	help
+	  Say Y if you want to add support for SoC machine driver for Intel MID
+
+
diff --git a/sound/soc/mid-x86/Makefile b/sound/soc/mid-x86/Makefile
new file mode 100644
index 0000000..206c63e
--- /dev/null
+++ b/sound/soc/mid-x86/Makefile
@@ -0,0 +1,9 @@
+EXTRA_CFLAGS += -DDEBUG
+
+# MID Platform Support
+snd-soc-mid-platform-objs := mid_platform.o mid_platform_pvt.o
+# MID Machine Support
+snd-soc-mid-machine-objs := mid_machine.o mid_machine_pvt.o
+
+obj-$(CONFIG_SND_MID_PLATFORM) += snd-soc-mid-platform.o
+obj-$(CONFIG_SND_MID_MACHINE) += snd-soc-mid-machine.o
-- 
1.7.2.3
