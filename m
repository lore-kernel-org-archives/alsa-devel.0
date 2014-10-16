From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 7/7] ASoC: Intel: sst: Add makefile and
	kconfig changes
Date: Thu, 16 Oct 2014 20:00:19 +0530
Message-ID: <1413469819-18775-8-git-send-email-vinod.koul@intel.com>
References: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B3D926510A
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 17:09:02 +0200 (CEST)
In-Reply-To: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig      |    4 ++++
 sound/soc/intel/Makefile     |    3 +++
 sound/soc/intel/sst/Makefile |    3 +++
 3 files changed, 10 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/intel/sst/Makefile

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index f5b4a9c..c719438 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -3,6 +3,7 @@ config SND_MFLD_MACHINE
 	depends on INTEL_SCU_IPC
 	select SND_SOC_SN95031
 	select SND_SST_MFLD_PLATFORM
+	select SND_SST_IPC
 	help
           This adds support for ASoC machine driver for Intel(R) MID Medfield platform
           used as alsa device in audio substem in Intel(R) MID devices
@@ -12,6 +13,9 @@ config SND_MFLD_MACHINE
 config SND_SST_MFLD_PLATFORM
 	tristate
 
+config SND_SST_IPC
+	tristate
+
 config SND_SOC_INTEL_SST
 	tristate "ASoC support for Intel(R) Smart Sound Technology"
 	select SND_SOC_INTEL_SST_ACPI if ACPI
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index f841786..9ab43be 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -31,3 +31,6 @@ obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
+
+# DSP driver
+obj-$(CONFIG_SND_SST_IPC) += sst/
diff --git a/sound/soc/intel/sst/Makefile b/sound/soc/intel/sst/Makefile
new file mode 100644
index 0000000..4d0e79b
--- /dev/null
+++ b/sound/soc/intel/sst/Makefile
@@ -0,0 +1,3 @@
+snd-intel-sst-objs := sst.o sst_ipc.o sst_stream.o sst_drv_interface.o sst_loader.o sst_pvt.o
+
+obj-$(CONFIG_SND_SST_IPC) += snd-intel-sst.o
-- 
1.7.0.4
