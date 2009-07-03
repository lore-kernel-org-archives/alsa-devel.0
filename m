From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] [RFC 13/13] Intel SST Driver Config changes &
	makefile
Date: Fri,  3 Jul 2009 11:54:58 +0530
Message-ID: <1246602298-11479-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 94B5D1038CD
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 08:15:56 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds the makefiles and Kconfig changes for both SST and MAD drivers

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>

	modified:   sound/pci/Kconfig
	modified:   sound/pci/Makefile
	new file:   sound/pci/sst/Makefile
---
 sound/pci/Kconfig      |   45 +++++++++++++++++++++++++++++++++++++++++++++
 sound/pci/Makefile     |    4 +++-
 sound/pci/sst/Makefile |    9 +++++++++
 3 files changed, 57 insertions(+), 1 deletions(-)
 create mode 100644 sound/pci/sst/Makefile

diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 748f6b7..6901393 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -9,6 +9,51 @@ menuconfig SND_PCI
 
 if SND_PCI
 
+config SND_INTEL_SST
+	bool "MRST SST DRIVER"
+	depends on X86 && LNW_IPC
+	default y
+	help
+	  Say Y here to include support
+
+config SST_OSPM_SUPPORT
+	bool "MRST SST DRIVER SUPPORT for OSPM"
+	depends on SND_INTEL_SST && MSTWN_POWER_MGMT
+	default n
+	help
+	   Say Y here to include support in SST driver for OSPM
+
+config SST_IPC_NOT_INCLUDED
+	bool "IPC NOT INCLUDED"
+	depends on SND_INTEL_SST
+	default y
+	help
+	   Say Y here to include workaround in LPE driver for removing
+	   IPC Driver calls
+
+config SST_DBG_PRINT
+	bool "MRST SST DRIVER DEBUG PRINTS"
+	depends on SND_INTEL_SST
+	default n
+	help
+	   Say Y here to include debug prints for SST driver
+
+config SND_INTELMID
+	bool "MRST SOUND CARD DRIVER"
+	depends on SND_INTEL_SST && SPI_MRST
+	default y
+	select SND_MIXER_OSS
+	select SND_PCM_OSS
+	help
+	  Say Y here to include support
+
+config MID_DBG_PRINT
+	bool "MRST MID DRIVER DEBUG PRINTS"
+	depends on SND_INTELMID
+	default n
+	help
+	   Say Y here to include debug prints for MAD driver
+
 config SND_AD1889
 	tristate "Analog Devices AD1889"
 	select SND_AC97_CODEC
diff --git a/sound/pci/Makefile b/sound/pci/Makefile
index ecfc609..0aea1bc 100644
--- a/sound/pci/Makefile
+++ b/sound/pci/Makefile
@@ -77,4 +77,6 @@ obj-$(CONFIG_SND) += \
 	rme9652/ \
 	trident/ \
 	ymfpci/ \
-	vx222/
+	vx222/ \
+	sst/
+
diff --git a/sound/pci/sst/Makefile b/sound/pci/sst/Makefile
new file mode 100644
index 0000000..e87dae5
--- /dev/null
+++ b/sound/pci/sst/Makefile
@@ -0,0 +1,9 @@
+#
+# Makefile for Intel MID Audio drivers
+#
+EXTRA_CFLAGS=-g
+snd-intel-sst-objs := intel_sst.o intel_sst_ipc.o intel_sst_stream.o intel_sst_interface.o
+snd-intelmid-objs := intelmid.o intelmid_v0_control.o intelmid_v1_control.o intelmid_v2_control.o
+# Toplevel Module Dependency
+obj-$(CONFIG_SND_INTEL_SST) += snd-intel-sst.o
+obj-$(CONFIG_SND_INTELMID) += snd-intelmid.o
-- 
1.5.4.5
