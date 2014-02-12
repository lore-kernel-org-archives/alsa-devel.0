From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Add a mfld prefix to Intel SST
	drivers.
Date: Wed, 12 Feb 2014 13:42:50 +0000
Message-ID: <1392212570.2346.9.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 78741264FEB
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 14:43:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, alsa-devel <alsa-devel@alsa-project.org>, Benson Leung <bleung@google.com>
List-Id: alsa-devel@alsa-project.org

Resent with correct email for Mark.

In order to differentiate the different Intel SST audio core drivers we
need to rename the current drivers with a mfld prefix. This also includes
renaming in the Makefile and Kconfig

Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/Kconfig                                 | 4 ++--
 sound/soc/intel/Makefile                                | 4 ++--
 sound/soc/intel/{sst_dsp.h => sst-mfld-dsp.h}           | 8 ++++----
 sound/soc/intel/{sst_platform.c => sst-mfld-platform.c} | 8 ++++----
 sound/soc/intel/{sst_platform.h => sst-mfld-platform.h} | 4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)
 rename sound/soc/intel/{sst_dsp.h => sst-mfld-dsp.h} (96%)
 rename sound/soc/intel/{sst_platform.c => sst-mfld-platform.c} (99%)
 rename sound/soc/intel/{sst_platform.h => sst-mfld-platform.h} (97%)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 61c10bf..4d9d0a5 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -2,12 +2,12 @@ config SND_MFLD_MACHINE
 	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
 	depends on INTEL_SCU_IPC
 	select SND_SOC_SN95031
-	select SND_SST_PLATFORM
+	select SND_SST_MFLD_PLATFORM
 	help
           This adds support for ASoC machine driver for Intel(R) MID Medfield platform
           used as alsa device in audio substem in Intel(R) MID devices
           Say Y if you have such a device
           If unsure select "N".
 
-config SND_SST_PLATFORM
+config SND_SST_MFLD_PLATFORM
 	tristate
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 6398833..eb899fc 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -1,5 +1,5 @@
-snd-soc-sst-platform-objs := sst_platform.o
+snd-soc-sst-mfld-platform-objs := sst-mfld-platform.o
 snd-soc-mfld-machine-objs := mfld_machine.o
 
-obj-$(CONFIG_SND_SST_PLATFORM) += snd-soc-sst-platform.o
+obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += snd-soc-sst-mfld-platform.o
 obj-$(CONFIG_SND_MFLD_MACHINE) += snd-soc-mfld-machine.o
diff --git a/sound/soc/intel/sst_dsp.h b/sound/soc/intel/sst-mfld-dsp.h
similarity index 96%
rename from sound/soc/intel/sst_dsp.h
rename to sound/soc/intel/sst-mfld-dsp.h
index 0fce1de..3b63edc 100644
--- a/sound/soc/intel/sst_dsp.h
+++ b/sound/soc/intel/sst-mfld-dsp.h
@@ -1,7 +1,7 @@
-#ifndef __SST_DSP_H__
-#define __SST_DSP_H__
+#ifndef __SST_MFLD_DSP_H__
+#define __SST_MFLD_DSP_H__
 /*
- *  sst_dsp.h - Intel SST Driver for audio engine
+ *  sst_mfld_dsp.h - Intel SST Driver for audio engine
  *
  *  Copyright (C) 2008-12 Intel Corporation
  *  Authors:	Vinod Koul <vinod.koul@linux.intel.com>
@@ -131,4 +131,4 @@ struct snd_sst_params {
 	struct snd_sst_alloc_params_ext aparams;
 };
 
-#endif /* __SST_DSP_H__ */
+#endif /* __SST_MFLD_DSP_H__ */
diff --git a/sound/soc/intel/sst_platform.c b/sound/soc/intel/sst-mfld-platform.c
similarity index 99%
rename from sound/soc/intel/sst_platform.c
rename to sound/soc/intel/sst-mfld-platform.c
index f465a81..840306c 100644
--- a/sound/soc/intel/sst_platform.c
+++ b/sound/soc/intel/sst-mfld-platform.c
@@ -1,5 +1,5 @@
 /*
- *  sst_platform.c - Intel MID Platform driver
+ *  sst_mfld_platform.c - Intel MID Platform driver
  *
  *  Copyright (C) 2010-2013 Intel Corp
  *  Author: Vinod Koul <vinod.koul@intel.com>
@@ -33,7 +33,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/compress_driver.h>
-#include "sst_platform.h"
+#include "sst-mfld-platform.h"
 
 static struct sst_device *sst;
 static DEFINE_MUTEX(sst_lock);
@@ -709,7 +709,7 @@ static int sst_platform_remove(struct platform_device *pdev)
 
 static struct platform_driver sst_platform_driver = {
 	.driver		= {
-		.name		= "sst-platform",
+		.name		= "sst-mfld-platform",
 		.owner		= THIS_MODULE,
 	},
 	.probe		= sst_platform_probe,
@@ -722,4 +722,4 @@ MODULE_DESCRIPTION("ASoC Intel(R) MID Platform driver");
 MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
 MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:sst-platform");
+MODULE_ALIAS("platform:sst-mfld-platform");
diff --git a/sound/soc/intel/sst_platform.h b/sound/soc/intel/sst-mfld-platform.h
similarity index 97%
rename from sound/soc/intel/sst_platform.h
rename to sound/soc/intel/sst-mfld-platform.h
index bee64fb..0c4e2dd 100644
--- a/sound/soc/intel/sst_platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -1,5 +1,5 @@
 /*
- *  sst_platform.h - Intel MID Platform driver header file
+ *  sst_mfld_platform.h - Intel MID Platform driver header file
  *
  *  Copyright (C) 2010 Intel Corp
  *  Author: Vinod Koul <vinod.koul@intel.com>
@@ -27,7 +27,7 @@
 #ifndef __SST_PLATFORMDRV_H__
 #define __SST_PLATFORMDRV_H__
 
-#include "sst_dsp.h"
+#include "sst-mfld-dsp.h"
 
 #define SST_MONO		1
 #define SST_STEREO		2
-- 
1.8.3.2
