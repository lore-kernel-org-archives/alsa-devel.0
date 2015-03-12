From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH 1/5] ASoC: Intel: create common folder and move
	common files in
Date: Thu, 12 Mar 2015 22:31:56 +0800
Message-ID: <1426170720-8260-2-git-send-email-yang.jie@intel.com>
References: <1426170720-8260-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0385D265850
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 15:29:55 +0100 (CET)
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

Restructure the sound/soc/intel/ directory: create common folder, and move
sst common files here.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/Makefile                    | 6 +-----
 sound/soc/intel/common/Makefile             | 6 ++++++
 sound/soc/intel/{ => common}/sst-acpi.c     | 0
 sound/soc/intel/{ => common}/sst-dsp-priv.h | 0
 sound/soc/intel/{ => common}/sst-dsp.c      | 0
 sound/soc/intel/{ => common}/sst-dsp.h      | 0
 sound/soc/intel/{ => common}/sst-firmware.c | 0
 7 files changed, 7 insertions(+), 5 deletions(-)
 create mode 100644 sound/soc/intel/common/Makefile
 rename sound/soc/intel/{ => common}/sst-acpi.c (100%)
 rename sound/soc/intel/{ => common}/sst-dsp-priv.h (100%)
 rename sound/soc/intel/{ => common}/sst-dsp.c (100%)
 rename sound/soc/intel/{ => common}/sst-dsp.h (100%)
 rename sound/soc/intel/{ => common}/sst-firmware.c (100%)

diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index a8e53c4..28de8cd 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -1,6 +1,5 @@
 # Core support
-snd-soc-sst-dsp-objs := sst-dsp.o sst-firmware.o
-snd-soc-sst-acpi-objs := sst-acpi.o
+obj-$(CONFIG_SND_SOC_INTEL_SST) += common/
 
 snd-soc-sst-mfld-platform-objs := sst-mfld-platform-pcm.o \
 	sst-mfld-platform-compress.o sst-atom-controls.o
@@ -9,9 +8,6 @@ snd-soc-mfld-machine-objs := mfld_machine.o
 obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += snd-soc-sst-mfld-platform.o
 obj-$(CONFIG_SND_MFLD_MACHINE) += snd-soc-mfld-machine.o
 
-obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o
-obj-$(CONFIG_SND_SOC_INTEL_SST_ACPI) += snd-soc-sst-acpi.o
-
 # Platform Support
 snd-soc-sst-haswell-pcm-objs := \
 	sst-haswell-ipc.o sst-haswell-pcm.o sst-haswell-dsp.o
diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
new file mode 100644
index 0000000..3df0e1c
--- /dev/null
+++ b/sound/soc/intel/common/Makefile
@@ -0,0 +1,6 @@
+snd-soc-sst-dsp-objs := sst-dsp.o sst-firmware.o
+snd-soc-sst-acpi-objs := sst-acpi.o
+
+obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o
+obj-$(CONFIG_SND_SOC_INTEL_SST_ACPI) += snd-soc-sst-acpi.o
+
diff --git a/sound/soc/intel/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
similarity index 100%
rename from sound/soc/intel/sst-acpi.c
rename to sound/soc/intel/common/sst-acpi.c
diff --git a/sound/soc/intel/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
similarity index 100%
rename from sound/soc/intel/sst-dsp-priv.h
rename to sound/soc/intel/common/sst-dsp-priv.h
diff --git a/sound/soc/intel/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
similarity index 100%
rename from sound/soc/intel/sst-dsp.c
rename to sound/soc/intel/common/sst-dsp.c
diff --git a/sound/soc/intel/sst-dsp.h b/sound/soc/intel/common/sst-dsp.h
similarity index 100%
rename from sound/soc/intel/sst-dsp.h
rename to sound/soc/intel/common/sst-dsp.h
diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
similarity index 100%
rename from sound/soc/intel/sst-firmware.c
rename to sound/soc/intel/common/sst-firmware.c
-- 
1.9.1
