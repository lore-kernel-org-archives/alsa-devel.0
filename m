From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v3 2/5] ASoC: Intel: create haswell folder and
	move haswell platform files in
Date: Thu,  2 Apr 2015 15:37:01 +0800
Message-ID: <1427960224-3528-3-git-send-email-yang.jie@intel.com>
References: <1427960224-3528-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B6E9261685
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

Restructure the sound/soc/intel/ directory: create haswell folder, and
move haswell platform files here.

Signed-off-by: Jie Yang <yang.jie@intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/Makefile                        | 4 +---
 sound/soc/intel/haswell/Makefile                | 4 ++++
 sound/soc/intel/{ => haswell}/sst-haswell-dsp.c | 6 +++---
 sound/soc/intel/{ => haswell}/sst-haswell-ipc.c | 4 ++--
 sound/soc/intel/{ => haswell}/sst-haswell-ipc.h | 0
 sound/soc/intel/{ => haswell}/sst-haswell-pcm.c | 6 +++---
 6 files changed, 13 insertions(+), 11 deletions(-)
 create mode 100644 sound/soc/intel/haswell/Makefile
 rename sound/soc/intel/{ => haswell}/sst-haswell-dsp.c (99%)
 rename sound/soc/intel/{ => haswell}/sst-haswell-ipc.c (99%)
 rename sound/soc/intel/{ => haswell}/sst-haswell-ipc.h (100%)
 rename sound/soc/intel/{ => haswell}/sst-haswell-pcm.c (99%)

diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 28de8cd..eb3efce 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -9,12 +9,10 @@ obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += snd-soc-sst-mfld-platform.o
 obj-$(CONFIG_SND_MFLD_MACHINE) += snd-soc-mfld-machine.o
 
 # Platform Support
-snd-soc-sst-haswell-pcm-objs := \
-	sst-haswell-ipc.o sst-haswell-pcm.o sst-haswell-dsp.o
+obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += haswell/
 snd-soc-sst-baytrail-pcm-objs := \
 	sst-baytrail-ipc.o sst-baytrail-pcm.o sst-baytrail-dsp.o
 
-obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += snd-soc-sst-haswell-pcm.o
 obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += snd-soc-sst-baytrail-pcm.o
 
 # Machine support
diff --git a/sound/soc/intel/haswell/Makefile b/sound/soc/intel/haswell/Makefile
new file mode 100644
index 0000000..9c17231
--- /dev/null
+++ b/sound/soc/intel/haswell/Makefile
@@ -0,0 +1,4 @@
+snd-soc-sst-haswell-pcm-objs := \
+	        sst-haswell-ipc.o sst-haswell-pcm.o sst-haswell-dsp.o
+
+obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += snd-soc-sst-haswell-pcm.o
diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/haswell/sst-haswell-dsp.c
similarity index 99%
rename from sound/soc/intel/sst-haswell-dsp.c
rename to sound/soc/intel/haswell/sst-haswell-dsp.c
index b3e957d..7f94920 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/haswell/sst-haswell-dsp.c
@@ -28,9 +28,9 @@
 #include <linux/firmware.h>
 #include <linux/pm_runtime.h>
 
-#include "sst-dsp.h"
-#include "sst-dsp-priv.h"
-#include "sst-haswell-ipc.h"
+#include "../common/sst-dsp.h"
+#include "../common/sst-dsp-priv.h"
+#include "../haswell/sst-haswell-ipc.h"
 
 #include <trace/events/hswadsp.h>
 
diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
similarity index 99%
rename from sound/soc/intel/sst-haswell-ipc.c
rename to sound/soc/intel/haswell/sst-haswell-ipc.c
index 20b629a..28667d8 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -34,8 +34,8 @@
 #include <sound/asound.h>
 
 #include "sst-haswell-ipc.h"
-#include "sst-dsp.h"
-#include "sst-dsp-priv.h"
+#include "../common/sst-dsp.h"
+#include "../common/sst-dsp-priv.h"
 
 /* Global Message - Generic */
 #define IPC_GLB_TYPE_SHIFT	24
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/haswell/sst-haswell-ipc.h
similarity index 100%
rename from sound/soc/intel/sst-haswell-ipc.h
rename to sound/soc/intel/haswell/sst-haswell-ipc.h
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
similarity index 99%
rename from sound/soc/intel/sst-haswell-pcm.c
rename to sound/soc/intel/haswell/sst-haswell-pcm.c
index 31ffc0f..157b3a6 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -29,9 +29,9 @@
 #include <sound/tlv.h>
 #include <sound/compress_driver.h>
 
-#include "sst-haswell-ipc.h"
-#include "sst-dsp-priv.h"
-#include "sst-dsp.h"
+#include "../haswell/sst-haswell-ipc.h"
+#include "../common/sst-dsp-priv.h"
+#include "../common/sst-dsp.h"
 
 #define HSW_PCM_COUNT		6
 #define HSW_VOLUME_MAX		0x7FFFFFFF	/* 0dB */
-- 
1.9.1
