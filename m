From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: mfld: allow mfld machine to be
	build
Date: Wed, 15 Nov 2017 16:22:52 +0530
Message-ID: <1510743172-18829-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BB54266E65
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 11:49:41 +0100 (CET)
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Commit b97169da0699: ("ASoC: Intel: create atom folder and move atom
platform files in") missed adding Kconfig and Makefile support for
MFLD machine driver, so add it while alos fixing the relative patch to
codec header

Fixes: b97169da0699: ("ASoC: Intel: create atom folder and move atom platform files in")
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/Makefile       | 2 ++
 sound/soc/intel/boards/mfld_machine.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index a5c5bc5732a2..070cb1afefe1 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -1,3 +1,4 @@
+snd-soc-sst-mfld-objs := mfld_machine.o
 snd-soc-sst-haswell-objs := haswell.o
 snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
 snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
@@ -19,6 +20,7 @@ snd-soc-skl_rt286-objs := skl_rt286.o
 snd-skl_nau88l25_max98357a-objs := skl_nau88l25_max98357a.o
 snd-soc-skl_nau88l25_ssm4567-objs := skl_nau88l25_ssm4567.o
 
+obj-$(CONFIG_SND_MFLD_MACHINE) += snd-soc-sst-mfld.o
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
diff --git a/sound/soc/intel/boards/mfld_machine.c b/sound/soc/intel/boards/mfld_machine.c
index 6f44acfb4aae..c3d80123610e 100644
--- a/sound/soc/intel/boards/mfld_machine.c
+++ b/sound/soc/intel/boards/mfld_machine.c
@@ -33,7 +33,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
-#include "../codecs/sn95031.h"
+#include "../../codecs/sn95031.h"
 
 #define MID_MONO 1
 #define MID_STEREO 2
-- 
2.7.4
