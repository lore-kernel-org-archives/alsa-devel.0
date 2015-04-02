From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v3 5/5] ASoC: Intel: create atom folder and
	move atom platform files in
Date: Thu,  2 Apr 2015 15:37:04 +0800
Message-ID: <1427960224-3528-6-git-send-email-yang.jie@intel.com>
References: <1427960224-3528-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 049892654D8
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 09:34:07 +0200 (CEST)
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

Restructure the sound/soc/intel/ directory: create atom folder, and move
sst atom platform files here.

Signed-off-by: Jie Yang <yang.jie@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
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
 sound/soc/intel/{ => atom}/sst/sst.c                    |  2 +-
 sound/soc/intel/{ => atom}/sst/sst.h                    |  0
 sound/soc/intel/{ => atom}/sst/sst_acpi.c               |  2 +-
 sound/soc/intel/{ => atom}/sst/sst_drv_interface.c      |  2 +-
 sound/soc/intel/{ => atom}/sst/sst_ipc.c                |  2 +-
 sound/soc/intel/{ => atom}/sst/sst_loader.c             |  2 +-
 sound/soc/intel/{ => atom}/sst/sst_pci.c                |  0
 sound/soc/intel/{ => atom}/sst/sst_pvt.c                |  2 +-
 sound/soc/intel/{ => atom}/sst/sst_stream.c             |  2 +-
 sound/soc/intel/boards/bytcr_rt5640.c                   |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c                 |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c                 |  2 +-
 21 files changed, 18 insertions(+), 20 deletions(-)
 create mode 100644 sound/soc/intel/atom/Makefile
 rename sound/soc/intel/{ => atom}/sst-atom-controls.c (100%)
 rename sound/soc/intel/{ => atom}/sst-atom-controls.h (100%)
 rename sound/soc/intel/{ => atom}/sst-mfld-dsp.h (100%)
 rename sound/soc/intel/{ => atom}/sst-mfld-platform-compress.c (100%)
 rename sound/soc/intel/{ => atom}/sst-mfld-platform-pcm.c (100%)
 rename sound/soc/intel/{ => atom}/sst-mfld-platform.h (100%)
 rename sound/soc/intel/{ => atom}/sst/Makefile (100%)
 rename sound/soc/intel/{ => atom}/sst/sst.c (99%)
 rename sound/soc/intel/{ => atom}/sst/sst.h (100%)
 rename sound/soc/intel/{ => atom}/sst/sst_acpi.c (99%)
 rename sound/soc/intel/{ => atom}/sst/sst_drv_interface.c (99%)
 rename sound/soc/intel/{ => atom}/sst/sst_ipc.c (99%)
 rename sound/soc/intel/{ => atom}/sst/sst_loader.c (99%)
 rename sound/soc/intel/{ => atom}/sst/sst_pci.c (100%)
 rename sound/soc/intel/{ => atom}/sst/sst_pvt.c (99%)
 rename sound/soc/intel/{ => atom}/sst/sst_stream.c (99%)

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
similarity index 99%
rename from sound/soc/intel/sst/sst.c
rename to sound/soc/intel/atom/sst/sst.c
index 26b1e31c..96c2e42 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -32,7 +32,7 @@
 #include <asm/platform_sst_audio.h>
 #include "../sst-mfld-platform.h"
 #include "sst.h"
-#include "../common/sst-dsp.h"
+#include "../../common/sst-dsp.h"
 
 MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
 MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
diff --git a/sound/soc/intel/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
similarity index 100%
rename from sound/soc/intel/sst/sst.h
rename to sound/soc/intel/atom/sst/sst.h
diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
similarity index 99%
rename from sound/soc/intel/sst/sst_acpi.c
rename to sound/soc/intel/atom/sst/sst_acpi.c
index b241a4a..05f6930 100644
--- a/sound/soc/intel/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -39,7 +39,7 @@
 #include <acpi/actypes.h>
 #include <acpi/acpi_bus.h>
 #include "../sst-mfld-platform.h"
-#include "../common/sst-dsp.h"
+#include "../../common/sst-dsp.h"
 #include "sst.h"
 
 struct sst_machines {
diff --git a/sound/soc/intel/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
similarity index 99%
rename from sound/soc/intel/sst/sst_drv_interface.c
rename to sound/soc/intel/atom/sst/sst_drv_interface.c
index 36d68b8..718838b 100644
--- a/sound/soc/intel/sst/sst_drv_interface.c
+++ b/sound/soc/intel/atom/sst/sst_drv_interface.c
@@ -32,7 +32,7 @@
 #include <asm/platform_sst_audio.h>
 #include "../sst-mfld-platform.h"
 #include "sst.h"
-#include "../common/sst-dsp.h"
+#include "../../common/sst-dsp.h"
 
 
 
diff --git a/sound/soc/intel/sst/sst_ipc.c b/sound/soc/intel/atom/sst/sst_ipc.c
similarity index 99%
rename from sound/soc/intel/sst/sst_ipc.c
rename to sound/soc/intel/atom/sst/sst_ipc.c
index 3943ae8..5a27861 100644
--- a/sound/soc/intel/sst/sst_ipc.c
+++ b/sound/soc/intel/atom/sst/sst_ipc.c
@@ -32,7 +32,7 @@
 #include <asm/platform_sst_audio.h>
 #include "../sst-mfld-platform.h"
 #include "sst.h"
-#include "../common/sst-dsp.h"
+#include "../../common/sst-dsp.h"
 
 struct sst_block *sst_create_block(struct intel_sst_drv *ctx,
 					u32 msg_id, u32 drv_id)
diff --git a/sound/soc/intel/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
similarity index 99%
rename from sound/soc/intel/sst/sst_loader.c
rename to sound/soc/intel/atom/sst/sst_loader.c
index 6622e66..3391714 100644
--- a/sound/soc/intel/sst/sst_loader.c
+++ b/sound/soc/intel/atom/sst/sst_loader.c
@@ -37,7 +37,7 @@
 #include <asm/platform_sst_audio.h>
 #include "../sst-mfld-platform.h"
 #include "sst.h"
-#include "../common/sst-dsp.h"
+#include "../../common/sst-dsp.h"
 
 void memcpy32_toio(void __iomem *dst, const void *src, int count)
 {
diff --git a/sound/soc/intel/sst/sst_pci.c b/sound/soc/intel/atom/sst/sst_pci.c
similarity index 100%
rename from sound/soc/intel/sst/sst_pci.c
rename to sound/soc/intel/atom/sst/sst_pci.c
diff --git a/sound/soc/intel/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
similarity index 99%
rename from sound/soc/intel/sst/sst_pvt.c
rename to sound/soc/intel/atom/sst/sst_pvt.c
index 2bb0e9e..3c17844 100644
--- a/sound/soc/intel/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -34,7 +34,7 @@
 #include <asm/platform_sst_audio.h>
 #include "../sst-mfld-platform.h"
 #include "sst.h"
-#include "../common/sst-dsp.h"
+#include "../../common/sst-dsp.h"
 
 int sst_shim_write(void __iomem *addr, int offset, int value)
 {
diff --git a/sound/soc/intel/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
similarity index 99%
rename from sound/soc/intel/sst/sst_stream.c
rename to sound/soc/intel/atom/sst/sst_stream.c
index 7638fca..a74c64c 100644
--- a/sound/soc/intel/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -31,7 +31,7 @@
 #include <asm/platform_sst_audio.h>
 #include "../sst-mfld-platform.h"
 #include "sst.h"
-#include "../common/sst-dsp.h"
+#include "../../common/sst-dsp.h"
 
 int sst_alloc_stream_mrfld(struct intel_sst_drv *sst_drv_ctx, void *params)
 {
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 5c2d8fa..7f55d59 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -27,7 +27,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include "../../codecs/rt5640.h"
-#include "../sst-atom-controls.h"
+#include "../atom/sst-atom-controls.h"
 
 static const struct snd_soc_dapm_widget byt_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 93bb671..20a28b2 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -28,7 +28,7 @@
 #include <sound/soc.h>
 #include <sound/jack.h>
 #include "../../codecs/rt5645.h"
-#include "../sst-atom-controls.h"
+#include "../atom/sst-atom-controls.h"
 
 #define CHT_PLAT_CLK_3_HZ	19200000
 #define CHT_CODEC_DAI	"rt5645-aif1"
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 2cea002..2c9cc5b 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -24,7 +24,7 @@
 #include <sound/soc.h>
 #include <sound/jack.h>
 #include "../../codecs/rt5670.h"
-#include "../sst-atom-controls.h"
+#include "../atom/sst-atom-controls.h"
 
 /* The platform clock #3 outputs 19.2Mhz clock to codec as I2S MCLK */
 #define CHT_PLAT_CLK_3_HZ	19200000
-- 
1.9.1
