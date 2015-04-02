From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v3 4/5] ASoC: Intel: create baytrail folder and
	move baytrail platform files in
Date: Thu,  2 Apr 2015 15:37:03 +0800
Message-ID: <1427960224-3528-5-git-send-email-yang.jie@intel.com>
References: <1427960224-3528-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 598AB2654C7
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

Restructure the sound/soc/intel/ directory: create baytrail folder, and move
sst baytrail platform files here.

Signed-off-by: Jie Yang <yang.jie@intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/Makefile                          | 5 +----
 sound/soc/intel/baytrail/Makefile                 | 4 ++++
 sound/soc/intel/{ => baytrail}/sst-baytrail-dsp.c | 4 ++--
 sound/soc/intel/{ => baytrail}/sst-baytrail-ipc.c | 4 ++--
 sound/soc/intel/{ => baytrail}/sst-baytrail-ipc.h | 0
 sound/soc/intel/{ => baytrail}/sst-baytrail-pcm.c | 4 ++--
 6 files changed, 11 insertions(+), 10 deletions(-)
 create mode 100644 sound/soc/intel/baytrail/Makefile
 rename sound/soc/intel/{ => baytrail}/sst-baytrail-dsp.c (99%)
 rename sound/soc/intel/{ => baytrail}/sst-baytrail-ipc.c (99%)
 rename sound/soc/intel/{ => baytrail}/sst-baytrail-ipc.h (100%)
 rename sound/soc/intel/{ => baytrail}/sst-baytrail-pcm.c (99%)

diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index ac0248f..62de82a 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -10,10 +10,7 @@ obj-$(CONFIG_SND_MFLD_MACHINE) += snd-soc-mfld-machine.o
 
 # Platform Support
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += haswell/
-snd-soc-sst-baytrail-pcm-objs := \
-	sst-baytrail-ipc.o sst-baytrail-pcm.o sst-baytrail-dsp.o
-
-obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += snd-soc-sst-baytrail-pcm.o
+obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += baytrail/
 
 # Machine support
 obj-$(CONFIG_SND_SOC_INTEL_SST) += boards/
diff --git a/sound/soc/intel/baytrail/Makefile b/sound/soc/intel/baytrail/Makefile
new file mode 100644
index 0000000..488408c
--- /dev/null
+++ b/sound/soc/intel/baytrail/Makefile
@@ -0,0 +1,4 @@
+snd-soc-sst-baytrail-pcm-objs := \
+	        sst-baytrail-ipc.o sst-baytrail-pcm.o sst-baytrail-dsp.o
+
+obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += snd-soc-sst-baytrail-pcm.o
diff --git a/sound/soc/intel/sst-baytrail-dsp.c b/sound/soc/intel/baytrail/sst-baytrail-dsp.c
similarity index 99%
rename from sound/soc/intel/sst-baytrail-dsp.c
rename to sound/soc/intel/baytrail/sst-baytrail-dsp.c
index 5a9e567..01d023c 100644
--- a/sound/soc/intel/sst-baytrail-dsp.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-dsp.c
@@ -22,8 +22,8 @@
 #include <linux/platform_device.h>
 #include <linux/firmware.h>
 
-#include "sst-dsp.h"
-#include "sst-dsp-priv.h"
+#include "../common/sst-dsp.h"
+#include "../common/sst-dsp-priv.h"
 #include "sst-baytrail-ipc.h"
 
 #define SST_BYT_FW_SIGNATURE_SIZE	4
diff --git a/sound/soc/intel/sst-baytrail-ipc.c b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
similarity index 99%
rename from sound/soc/intel/sst-baytrail-ipc.c
rename to sound/soc/intel/baytrail/sst-baytrail-ipc.c
index b4ad98c..aabb9b0 100644
--- a/sound/soc/intel/sst-baytrail-ipc.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
@@ -29,8 +29,8 @@
 #include <asm/div64.h>
 
 #include "sst-baytrail-ipc.h"
-#include "sst-dsp.h"
-#include "sst-dsp-priv.h"
+#include "../common/sst-dsp.h"
+#include "../common/sst-dsp-priv.h"
 
 /* IPC message timeout */
 #define IPC_TIMEOUT_MSECS	300
diff --git a/sound/soc/intel/sst-baytrail-ipc.h b/sound/soc/intel/baytrail/sst-baytrail-ipc.h
similarity index 100%
rename from sound/soc/intel/sst-baytrail-ipc.h
rename to sound/soc/intel/baytrail/sst-baytrail-ipc.h
diff --git a/sound/soc/intel/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
similarity index 99%
rename from sound/soc/intel/sst-baytrail-pcm.c
rename to sound/soc/intel/baytrail/sst-baytrail-pcm.c
index 224c49c..79547be 100644
--- a/sound/soc/intel/sst-baytrail-pcm.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
@@ -20,8 +20,8 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include "sst-baytrail-ipc.h"
-#include "sst-dsp-priv.h"
-#include "sst-dsp.h"
+#include "../common/sst-dsp-priv.h"
+#include "../common/sst-dsp.h"
 
 #define BYT_PCM_COUNT		2
 
-- 
1.9.1
