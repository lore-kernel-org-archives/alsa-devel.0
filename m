From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v2 3/5] ASoC: Intel: create boards folder and
	move sst boards files in
Date: Wed,  1 Apr 2015 15:42:21 +0800
Message-ID: <1427874143-26256-4-git-send-email-yang.jie@intel.com>
References: <1427874143-26256-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 747E126057F
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 09:39:28 +0200 (CEST)
In-Reply-To: <1427874143-26256-1-git-send-email-yang.jie@intel.com>
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

Restructure the sound/soc/intel/ directory: create boards folder, and move
sst boards files here.

Signed-off-by: Jie Yang <yang.jie@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/Makefile                                 | 16 +---------------
 sound/soc/intel/boards/Makefile                          | 15 +++++++++++++++
 sound/soc/intel/{ => boards}/broadwell.c                 |  6 +++---
 sound/soc/intel/{ => boards}/byt-max98090.c              |  2 +-
 sound/soc/intel/{ => boards}/byt-rt5640.c                |  4 ++--
 .../intel/{bytcr_dpcm_rt5640.c => boards/bytcr_rt5640.c} |  0
 sound/soc/intel/{ => boards}/cht_bsw_rt5645.c            |  0
 sound/soc/intel/{ => boards}/cht_bsw_rt5672.c            |  0
 sound/soc/intel/{ => boards}/haswell.c                   |  6 +++---
 sound/soc/intel/{ => boards}/mfld_machine.c              |  0
 10 files changed, 25 insertions(+), 24 deletions(-)
 create mode 100644 sound/soc/intel/boards/Makefile
 rename sound/soc/intel/{ => boards}/broadwell.c (98%)
 rename sound/soc/intel/{ => boards}/byt-max98090.c (99%)
 rename sound/soc/intel/{ => boards}/byt-rt5640.c (98%)
 rename sound/soc/intel/{bytcr_dpcm_rt5640.c => boards/bytcr_rt5640.c} (100%)
 rename sound/soc/intel/{ => boards}/cht_bsw_rt5645.c (100%)
 rename sound/soc/intel/{ => boards}/cht_bsw_rt5672.c (100%)
 rename sound/soc/intel/{ => boards}/haswell.c (98%)
 rename sound/soc/intel/{ => boards}/mfld_machine.c (100%)

diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index eb3efce..ac0248f 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -16,21 +16,7 @@ snd-soc-sst-baytrail-pcm-objs := \
 obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += snd-soc-sst-baytrail-pcm.o
 
 # Machine support
-snd-soc-sst-haswell-objs := haswell.o
-snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
-snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
-snd-soc-sst-broadwell-objs := broadwell.o
-snd-soc-sst-bytcr-dpcm-rt5640-objs := bytcr_dpcm_rt5640.o
-snd-soc-sst-cht-bsw-rt5672-objs := cht_bsw_rt5672.o
-snd-soc-sst-cht-bsw-rt5645-objs := cht_bsw_rt5645.o
-
-obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
-obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
-obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
-obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
-obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-dpcm-rt5640.o
-obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH) += snd-soc-sst-cht-bsw-rt5672.o
-obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH) += snd-soc-sst-cht-bsw-rt5645.o
+obj-$(CONFIG_SND_SOC_INTEL_SST) += boards/
 
 # DSP driver
 obj-$(CONFIG_SND_SST_IPC) += sst/
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
new file mode 100644
index 0000000..f8237f0
--- /dev/null
+++ b/sound/soc/intel/boards/Makefile
@@ -0,0 +1,15 @@
+snd-soc-sst-haswell-objs := haswell.o
+snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
+snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
+snd-soc-sst-broadwell-objs := broadwell.o
+snd-soc-sst-bytcr-rt5640-objs := bytcr_rt5640.o
+snd-soc-sst-cht-bsw-rt5672-objs := cht_bsw_rt5672.o
+snd-soc-sst-cht-bsw-rt5645-objs := cht_bsw_rt5645.o
+
+obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
+obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
+obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
+obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
+obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-rt5640.o
+obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH) += snd-soc-sst-cht-bsw-rt5672.o
+obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH) += snd-soc-sst-cht-bsw-rt5645.o
diff --git a/sound/soc/intel/broadwell.c b/sound/soc/intel/boards/broadwell.c
similarity index 98%
rename from sound/soc/intel/broadwell.c
rename to sound/soc/intel/boards/broadwell.c
index 6c75b6b..8bafaf6 100644
--- a/sound/soc/intel/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -22,10 +22,10 @@
 #include <sound/jack.h>
 #include <sound/pcm_params.h>
 
-#include "sst-dsp.h"
-#include "sst-haswell-ipc.h"
+#include "../common/sst-dsp.h"
+#include "../haswell/sst-haswell-ipc.h"
 
-#include "../codecs/rt286.h"
+#include "../../codecs/rt286.h"
 
 static struct snd_soc_jack broadwell_headset;
 /* Headset jack detection DAPM pins */
diff --git a/sound/soc/intel/byt-max98090.c b/sound/soc/intel/boards/byt-max98090.c
similarity index 99%
rename from sound/soc/intel/byt-max98090.c
rename to sound/soc/intel/boards/byt-max98090.c
index d8b1f03..7ab8cc9 100644
--- a/sound/soc/intel/byt-max98090.c
+++ b/sound/soc/intel/boards/byt-max98090.c
@@ -24,7 +24,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
-#include "../codecs/max98090.h"
+#include "../../codecs/max98090.h"
 
 struct byt_max98090_private {
 	struct snd_soc_jack jack;
diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/boards/byt-rt5640.c
similarity index 98%
rename from sound/soc/intel/byt-rt5640.c
rename to sound/soc/intel/boards/byt-rt5640.c
index 354eaad..ae89b9b9 100644
--- a/sound/soc/intel/byt-rt5640.c
+++ b/sound/soc/intel/boards/byt-rt5640.c
@@ -23,9 +23,9 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
-#include "../codecs/rt5640.h"
+#include "../../codecs/rt5640.h"
 
-#include "sst-dsp.h"
+#include "../common/sst-dsp.h"
 
 static const struct snd_soc_dapm_widget byt_rt5640_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
diff --git a/sound/soc/intel/bytcr_dpcm_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
similarity index 100%
rename from sound/soc/intel/bytcr_dpcm_rt5640.c
rename to sound/soc/intel/boards/bytcr_rt5640.c
diff --git a/sound/soc/intel/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
similarity index 100%
rename from sound/soc/intel/cht_bsw_rt5645.c
rename to sound/soc/intel/boards/cht_bsw_rt5645.c
diff --git a/sound/soc/intel/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
similarity index 100%
rename from sound/soc/intel/cht_bsw_rt5672.c
rename to sound/soc/intel/boards/cht_bsw_rt5672.c
diff --git a/sound/soc/intel/haswell.c b/sound/soc/intel/boards/haswell.c
similarity index 98%
rename from sound/soc/intel/haswell.c
rename to sound/soc/intel/boards/haswell.c
index 00fddd3..2255857 100644
--- a/sound/soc/intel/haswell.c
+++ b/sound/soc/intel/boards/haswell.c
@@ -21,10 +21,10 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
-#include "sst-dsp.h"
-#include "sst-haswell-ipc.h"
+#include "../common/sst-dsp.h"
+#include "../haswell/sst-haswell-ipc.h"
 
-#include "../codecs/rt5640.h"
+#include "../../codecs/rt5640.h"
 
 /* Haswell ULT platforms have a Headphone and Mic jack */
 static const struct snd_soc_dapm_widget haswell_widgets[] = {
diff --git a/sound/soc/intel/mfld_machine.c b/sound/soc/intel/boards/mfld_machine.c
similarity index 100%
rename from sound/soc/intel/mfld_machine.c
rename to sound/soc/intel/boards/mfld_machine.c
-- 
1.9.1
