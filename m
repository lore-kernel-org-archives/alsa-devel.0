From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v3 1/5] ASoC: Intel: create common folder and
	move common files in
Date: Thu,  2 Apr 2015 15:37:00 +0800
Message-ID: <1427960224-3528-2-git-send-email-yang.jie@intel.com>
References: <1427960224-3528-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E83E2654BD
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 09:34:03 +0200 (CEST)
In-Reply-To: <1427960224-3528-1-git-send-email-yang.jie@intel.com>
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
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Restructure the sound/soc/intel/ directory: create common folder, and move
sst common files here.

Signed-off-by: Jie Yang <yang.jie@intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/Makefile                    | 6 +-----
 sound/soc/intel/common/Makefile             | 6 ++++++
 sound/soc/intel/{ => common}/sst-acpi.c     | 0
 sound/soc/intel/{ => common}/sst-dsp-priv.h | 0
 sound/soc/intel/{ => common}/sst-dsp.c      | 0
 sound/soc/intel/{ => common}/sst-dsp.h      | 0
 sound/soc/intel/{ => common}/sst-firmware.c | 0
 sound/soc/intel/sst/sst.c                   | 2 +-
 sound/soc/intel/sst/sst_acpi.c              | 2 +-
 sound/soc/intel/sst/sst_drv_interface.c     | 2 +-
 sound/soc/intel/sst/sst_ipc.c               | 2 +-
 sound/soc/intel/sst/sst_loader.c            | 2 +-
 sound/soc/intel/sst/sst_pvt.c               | 2 +-
 sound/soc/intel/sst/sst_stream.c            | 2 +-
 14 files changed, 14 insertions(+), 12 deletions(-)
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
diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index 1a7eeec..26b1e31c 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -32,7 +32,7 @@
 #include <asm/platform_sst_audio.h>
 #include "../sst-mfld-platform.h"
 #include "sst.h"
-#include "../sst-dsp.h"
+#include "../common/sst-dsp.h"
 
 MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
 MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/sst/sst_acpi.c
index b536ddd..b241a4a 100644
--- a/sound/soc/intel/sst/sst_acpi.c
+++ b/sound/soc/intel/sst/sst_acpi.c
@@ -39,7 +39,7 @@
 #include <acpi/actypes.h>
 #include <acpi/acpi_bus.h>
 #include "../sst-mfld-platform.h"
-#include "../sst-dsp.h"
+#include "../common/sst-dsp.h"
 #include "sst.h"
 
 struct sst_machines {
diff --git a/sound/soc/intel/sst/sst_drv_interface.c b/sound/soc/intel/sst/sst_drv_interface.c
index f0e4b99b..36d68b8 100644
--- a/sound/soc/intel/sst/sst_drv_interface.c
+++ b/sound/soc/intel/sst/sst_drv_interface.c
@@ -32,7 +32,7 @@
 #include <asm/platform_sst_audio.h>
 #include "../sst-mfld-platform.h"
 #include "sst.h"
-#include "../sst-dsp.h"
+#include "../common/sst-dsp.h"
 
 
 
diff --git a/sound/soc/intel/sst/sst_ipc.c b/sound/soc/intel/sst/sst_ipc.c
index 484e609..3943ae8 100644
--- a/sound/soc/intel/sst/sst_ipc.c
+++ b/sound/soc/intel/sst/sst_ipc.c
@@ -32,7 +32,7 @@
 #include <asm/platform_sst_audio.h>
 #include "../sst-mfld-platform.h"
 #include "sst.h"
-#include "../sst-dsp.h"
+#include "../common/sst-dsp.h"
 
 struct sst_block *sst_create_block(struct intel_sst_drv *ctx,
 					u32 msg_id, u32 drv_id)
diff --git a/sound/soc/intel/sst/sst_loader.c b/sound/soc/intel/sst/sst_loader.c
index e88907a..6622e66 100644
--- a/sound/soc/intel/sst/sst_loader.c
+++ b/sound/soc/intel/sst/sst_loader.c
@@ -37,7 +37,7 @@
 #include <asm/platform_sst_audio.h>
 #include "../sst-mfld-platform.h"
 #include "sst.h"
-#include "../sst-dsp.h"
+#include "../common/sst-dsp.h"
 
 void memcpy32_toio(void __iomem *dst, const void *src, int count)
 {
diff --git a/sound/soc/intel/sst/sst_pvt.c b/sound/soc/intel/sst/sst_pvt.c
index 4b77208..2bb0e9e 100644
--- a/sound/soc/intel/sst/sst_pvt.c
+++ b/sound/soc/intel/sst/sst_pvt.c
@@ -34,7 +34,7 @@
 #include <asm/platform_sst_audio.h>
 #include "../sst-mfld-platform.h"
 #include "sst.h"
-#include "../sst-dsp.h"
+#include "../common/sst-dsp.h"
 
 int sst_shim_write(void __iomem *addr, int offset, int value)
 {
diff --git a/sound/soc/intel/sst/sst_stream.c b/sound/soc/intel/sst/sst_stream.c
index dae2a41..7638fca 100644
--- a/sound/soc/intel/sst/sst_stream.c
+++ b/sound/soc/intel/sst/sst_stream.c
@@ -31,7 +31,7 @@
 #include <asm/platform_sst_audio.h>
 #include "../sst-mfld-platform.h"
 #include "sst.h"
-#include "../sst-dsp.h"
+#include "../common/sst-dsp.h"
 
 int sst_alloc_stream_mrfld(struct intel_sst_drv *sst_drv_ctx, void *params)
 {
-- 
1.9.1
