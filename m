From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH 6/6] compress: add makefile and kconfig file
Date: Tue, 22 Nov 2011 14:22:00 +0530
Message-ID: <1321951920-4363-7-git-send-email-vinod.koul@linux.intel.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 82D621039D0
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 09:56:21 +0100 (CET)
In-Reply-To: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/Kconfig                   |    2 ++
 sound/Makefile                  |    3 ++-
 sound/compress_offload/Kconfig  |   17 +++++++++++++++++
 sound/compress_offload/Makefile |    4 ++++
 4 files changed, 25 insertions(+), 1 deletions(-)
 create mode 100644 sound/compress_offload/Kconfig
 create mode 100644 sound/compress_offload/Makefile

diff --git a/sound/Kconfig b/sound/Kconfig
index 1fef141..9b09263 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -93,6 +93,8 @@ source "sound/mips/Kconfig"
 
 source "sound/sh/Kconfig"
 
+source "sound/compress_offload/Kconfig"
+
 # the following will depend on the order of config.
 # here assuming USB is defined before ALSA
 source "sound/usb/Kconfig"
diff --git a/sound/Makefile b/sound/Makefile
index ce9132b..5a54d6c 100644
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -6,7 +6,8 @@ obj-$(CONFIG_SOUND_PRIME) += sound_firmware.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
 obj-$(CONFIG_DMASOUND) += oss/
 obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ sh/ synth/ usb/ \
-	firewire/ sparc/ spi/ parisc/ pcmcia/ mips/ soc/ atmel/
+	firewire/ sparc/ spi/ parisc/ pcmcia/ mips/ soc/ atmel/ \
+	compress_offload/
 obj-$(CONFIG_SND_AOA) += aoa/
 
 # This one must be compilable even if sound is configured out
diff --git a/sound/compress_offload/Kconfig b/sound/compress_offload/Kconfig
new file mode 100644
index 0000000..8e12a66
--- /dev/null
+++ b/sound/compress_offload/Kconfig
@@ -0,0 +1,17 @@
+#
+# compressed offload config
+#
+
+menuconfig SND_COMPRESS_OFFLOAD
+	tristate "ALSA Compressed audio offload support"
+	default n
+	help
+	  If you want support for offloading compressed audio and have such
+	  a hardware, then you should say Y here and also to the DSP driver
+	  of your platform.
+
+if SND_COMPRESS_OFFLOAD
+
+source "sound/compress_offload/mid-x86/Kconfig"
+
+endif #SND_COMPRESS_OFFLOAD
diff --git a/sound/compress_offload/Makefile b/sound/compress_offload/Makefile
new file mode 100644
index 0000000..c1ccecb
--- /dev/null
+++ b/sound/compress_offload/Makefile
@@ -0,0 +1,4 @@
+snd-compress-objs := core.o
+
+obj-$(CONFIG_SND_COMPRESS_OFFLOAD)	+= snd-compress.o
+obj-$(CONFIG_SND_COMPRESS_OFFLOAD)	+= mid-x86/
-- 
1.7.0.4
