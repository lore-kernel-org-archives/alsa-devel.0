From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH 5/5] ASoC: Intel: create atom folder and move
	atom platform files in
Date: Thu, 12 Mar 2015 22:32:00 +0800
Message-ID: <1426170720-8260-6-git-send-email-yang.jie@intel.com>
References: <1426170720-8260-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1070A26585C
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 15:30:01 +0100 (CET)
In-Reply-To: <1426170720-8260-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, vinod.koul@intel.com, mengdong.lin@intel.com, jarkko.nikula@intel.com, yao.jin@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Restructure the sound/soc/intel/ directory: create atom folder, and move
sst atom platform files here.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/Makefile                                | 11 +----------
 sound/soc/intel/atom/Makefile                           |  7 +++++++
 sound/soc/intel/{ => atom}/sst-atom-controls.c          |  0
 sound/soc/intel/{ => atom}/sst-atom-controls.h          |  0
 sound/soc/intel/{ => atom}/sst-mfld-dsp.h               |  0
 sound/soc/intel/{ => atom}/sst-mfld-platform-compress.c |  0
 sound/soc/intel/{ => atom}/sst-mfld-platform-pcm.c      |  0
 sound/soc/intel/{ => atom}/sst-mfld-platform.h          |  0
 sound/soc/intel/{ => atom}/sst/Makefile                 |  0
 sound/soc/intel/{ => atom}/sst/sst.c                    |  0
 sound/soc/intel/{ => atom}/sst/sst.h                    |  0
 sound/soc/intel/{ => atom}/sst/sst_acpi.c               |  0
 sound/soc/intel/{ => atom}/sst/sst_drv_interface.c      |  0
 sound/soc/intel/{ => atom}/sst/sst_ipc.c                |  0
 sound/soc/intel/{ => atom}/sst/sst_loader.c             |  0
 sound/soc/intel/{ => atom}/sst/sst_pci.c                |  0
 sound/soc/intel/{ => atom}/sst/sst_pvt.c                |  0
 sound/soc/intel/{ => atom}/sst/sst_stream.c             |  0
 18 files changed, 8 insertions(+), 10 deletions(-)
 create mode 100644 sound/soc/intel/atom/Makefile
 rename sound/soc/intel/{ => atom}/sst-atom-controls.c (100%)
 rename sound/soc/intel/{ => atom}/sst-atom-controls.h (100%)
 rename sound/soc/intel/{ => atom}/sst-mfld-dsp.h (100%)
 rename sound/soc/intel/{ => atom}/sst-mfld-platform-compress.c (100%)
 rename sound/soc/intel/{ => atom}/sst-mfld-platform-pcm.c (100%)
 rename sound/soc/intel/{ => atom}/sst-mfld-platform.h (100%)
 rename sound/soc/intel/{ => atom}/sst/Makefile (100%)
 rename sound/soc/intel/{ => atom}/sst/sst.c (100%)
 rename sound/soc/intel/{ => atom}/sst/sst.h (100%)
 rename sound/soc/intel/{ => atom}/sst/sst_acpi.c (100%)
 rename sound/soc/intel/{ => atom}/sst/sst_drv_interface.c (100%)
 rename sound/soc/intel/{ => atom}/sst/sst_ipc.c (100%)
 rename sound/soc/intel/{ => atom}/sst/sst_loader.c (100%)
 rename sound/soc/intel/{ => atom}/sst/sst_pci.c (100%)
 rename sound/soc/intel/{ => atom}/sst/sst_pvt.c (100%)
 rename sound/soc/intel/{ => atom}/sst/sst_stream.c (100%)

diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 62de82a..cd9aee9 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -1,19 +1,10 @@
 # Core support
 obj-$(CONFIG_SND_SOC_INTEL_SST) += common/
 
-snd-soc-sst-mfld-platform-objs := sst-mfld-platform-pcm.o \
-	sst-mfld-platform-compress.o sst-atom-controls.o
-snd-soc-mfld-machine-objs := mfld_machine.o
-
-obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += snd-soc-sst-mfld-platform.o
-obj-$(CONFIG_SND_MFLD_MACHINE) += snd-soc-mfld-machine.o
-
 # Platform Support
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += haswell/
 obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += baytrail/
+obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += atom/
 
 # Machine support
 obj-$(CONFIG_SND_SOC_INTEL_SST) += boards/
-
-# DSP driver
-obj-$(CONFIG_SND_SST_IPC) += sst/
diff --git a/sound/soc/intel/atom/Makefile b/sound/soc/intel/atom/Makefile
new file mode 100644
index 0000000..ce8074f
--- /dev/null
+++ b/sound/soc/intel/atom/Makefile
@@ -0,0 +1,7 @@
+snd-soc-sst-mfld-platform-objs := sst-mfld-platform-pcm.o \
+	        sst-mfld-platform-compress.o sst-atom-controls.o
+
+obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += snd-soc-sst-mfld-platform.o
+
+# DSP driver
+obj-$(CONFIG_SND_SST_IPC) += sst/
diff --git a/sound/soc/intel/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
similarity index 100%
rename from sound/soc/intel/sst-atom-controls.c
rename to sound/soc/intel/atom/sst-atom-controls.c
diff --git a/sound/soc/intel/sst-atom-controls.h b/sound/soc/intel/atom/sst-atom-controls.h
similarity index 100%
rename from sound/soc/intel/sst-atom-controls.h
rename to sound/soc/intel/atom/sst-atom-controls.h
diff --git a/sound/soc/intel/sst-mfld-dsp.h b/sound/soc/intel/atom/sst-mfld-dsp.h
similarity index 100%
rename from sound/soc/intel/sst-mfld-dsp.h
rename to sound/soc/intel/atom/sst-mfld-dsp.h
diff --git a/sound/soc/intel/sst-mfld-platform-compress.c b/sound/soc/intel/atom/sst-mfld-platform-compress.c
similarity index 100%
rename from sound/soc/intel/sst-mfld-platform-compress.c
rename to sound/soc/intel/atom/sst-mfld-platform-compress.c
diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
similarity index 100%
rename from sound/soc/intel/sst-mfld-platform-pcm.c
rename to sound/soc/intel/atom/sst-mfld-platform-pcm.c
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/atom/sst-mfld-platform.h
similarity index 100%
rename from sound/soc/intel/sst-mfld-platform.h
rename to sound/soc/intel/atom/sst-mfld-platform.h
diff --git a/sound/soc/intel/sst/Makefile b/sound/soc/intel/atom/sst/Makefile
similarity index 100%
rename from sound/soc/intel/sst/Makefile
rename to sound/soc/intel/atom/sst/Makefile
diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
similarity index 100%
rename from sound/soc/intel/sst/sst.c
rename to sound/soc/intel/atom/sst/sst.c
diff --git a/sound/soc/intel/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
similarity index 100%
rename from sound/soc/intel/sst/sst.h
rename to sound/soc/intel/atom/sst/sst.h
diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
similarity index 100%
rename from sound/soc/intel/sst/sst_acpi.c
rename to sound/soc/intel/atom/sst/sst_acpi.c
diff --git a/sound/soc/intel/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
similarity index 100%
rename from sound/soc/intel/sst/sst_drv_interface.c
rename to sound/soc/intel/atom/sst/sst_drv_interface.c
diff --git a/sound/soc/intel/sst/sst_ipc.c b/sound/soc/intel/atom/sst/sst_ipc.c
similarity index 100%
rename from sound/soc/intel/sst/sst_ipc.c
rename to sound/soc/intel/atom/sst/sst_ipc.c
diff --git a/sound/soc/intel/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
similarity index 100%
rename from sound/soc/intel/sst/sst_loader.c
rename to sound/soc/intel/atom/sst/sst_loader.c
diff --git a/sound/soc/intel/sst/sst_pci.c b/sound/soc/intel/atom/sst/sst_pci.c
similarity index 100%
rename from sound/soc/intel/sst/sst_pci.c
rename to sound/soc/intel/atom/sst/sst_pci.c
diff --git a/sound/soc/intel/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
similarity index 100%
rename from sound/soc/intel/sst/sst_pvt.c
rename to sound/soc/intel/atom/sst/sst_pvt.c
diff --git a/sound/soc/intel/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
similarity index 100%
rename from sound/soc/intel/sst/sst_stream.c
rename to sound/soc/intel/atom/sst/sst_stream.c
-- 
1.9.1
