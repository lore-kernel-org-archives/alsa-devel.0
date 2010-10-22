From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 04/24] ASoC: Samsung: Rename ASoC DMA driver
Date: Fri, 22 Oct 2010 17:34:33 +0900
Message-ID: <1287736473-11995-1-git-send-email-jassisinghbrar@gmail.com>
References: <1287736238-11846-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id A63F5103B0E
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 10:43:10 +0200 (CEST)
In-Reply-To: <1287736238-11846-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Rename Samsung ASoC DMA driver
	s3c-dma.[c/h] -> dma.[c/h]

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Makefile                     |    2 +-
 sound/soc/s3c24xx/{s3c-dma.c => dma.c}         |    6 +++---
 sound/soc/s3c24xx/{s3c-dma.h => dma.h}         |    2 +-
 sound/soc/s3c24xx/goni_wm8994.c                |    2 +-
 sound/soc/s3c24xx/jive_wm8750.c                |    2 +-
 sound/soc/s3c24xx/ln2440sbc_alc650.c           |    2 +-
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c       |    2 +-
 sound/soc/s3c24xx/neo1973_wm8753.c             |    2 +-
 sound/soc/s3c24xx/rx1950_uda1380.c             |    2 +-
 sound/soc/s3c24xx/s3c-ac97.c                   |    2 +-
 sound/soc/s3c24xx/s3c-i2s-v2.c                 |    2 +-
 sound/soc/s3c24xx/s3c-pcm.c                    |    2 +-
 sound/soc/s3c24xx/s3c2412-i2s.c                |    2 +-
 sound/soc/s3c24xx/s3c24xx-i2s.c                |    2 +-
 sound/soc/s3c24xx/s3c24xx_simtec.c             |    2 +-
 sound/soc/s3c24xx/s3c24xx_simtec_hermes.c      |    2 +-
 sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c |    2 +-
 sound/soc/s3c24xx/s3c24xx_uda134x.c            |    2 +-
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c             |    2 +-
 sound/soc/s3c24xx/s3c64xx-i2s.c                |    2 +-
 sound/soc/s3c24xx/smartq_wm8987.c              |    2 +-
 sound/soc/s3c24xx/smdk2443_wm9710.c            |    2 +-
 sound/soc/s3c24xx/smdk64xx_wm8580.c            |    2 +-
 sound/soc/s3c24xx/smdk_spdif.c                 |    2 +-
 sound/soc/s3c24xx/smdk_wm9713.c                |    2 +-
 sound/soc/s3c24xx/spdif.c                      |    2 +-
 26 files changed, 28 insertions(+), 28 deletions(-)
 rename sound/soc/s3c24xx/{s3c-dma.c => dma.c} (99%)
 rename sound/soc/s3c24xx/{s3c-dma.h => dma.h} (97%)

diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index 4e232f1..20aac45 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -1,5 +1,5 @@
 # S3c24XX Platform Support
-snd-soc-s3c24xx-objs := s3c-dma.o
+snd-soc-s3c24xx-objs := dma.o
 snd-soc-s3c24xx-i2s-objs := s3c24xx-i2s.o
 snd-soc-s3c2412-i2s-objs := s3c2412-i2s.o
 snd-soc-s3c64xx-i2s-objs := s3c64xx-i2s.o
diff --git a/sound/soc/s3c24xx/s3c-dma.c b/sound/soc/s3c24xx/dma.c
similarity index 99%
rename from sound/soc/s3c24xx/s3c-dma.c
rename to sound/soc/s3c24xx/dma.c
index 0c1cd6c..b4c7c85 100644
--- a/sound/soc/s3c24xx/s3c-dma.c
+++ b/sound/soc/s3c24xx/dma.c
@@ -1,5 +1,5 @@
 /*
- * s3c-dma.c  --  ALSA Soc Audio Layer
+ * dma.c  --  ALSA Soc Audio Layer
  *
  * (c) 2006 Wolfson Microelectronics PLC.
  * Graeme Gregory graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
@@ -30,7 +30,7 @@
 #include <mach/hardware.h>
 #include <mach/dma.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 
 static const struct snd_pcm_hardware s3c_dma_hardware = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED |
@@ -454,7 +454,7 @@ static int s3c_dma_new(struct snd_card *card,
 		if (ret)
 			goto out;
 	}
- out:
+out:
 	return ret;
 }
 
diff --git a/sound/soc/s3c24xx/s3c-dma.h b/sound/soc/s3c24xx/dma.h
similarity index 97%
rename from sound/soc/s3c24xx/s3c-dma.h
rename to sound/soc/s3c24xx/dma.h
index 748c07d..f8cd2b4 100644
--- a/sound/soc/s3c24xx/s3c-dma.h
+++ b/sound/soc/s3c24xx/dma.h
@@ -1,5 +1,5 @@
 /*
- *  s3c-dma.h --
+ *  dma.h --
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
diff --git a/sound/soc/s3c24xx/goni_wm8994.c b/sound/soc/s3c24xx/goni_wm8994.c
index c568f69..201056c 100644
--- a/sound/soc/s3c24xx/goni_wm8994.c
+++ b/sound/soc/s3c24xx/goni_wm8994.c
@@ -25,7 +25,7 @@
 #include <linux/mfd/wm8994/core.h>
 #include <linux/mfd/wm8994/registers.h>
 #include "../codecs/wm8994.h"
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c64xx-i2s.h"
 
 #define MACHINE_NAME	0
diff --git a/sound/soc/s3c24xx/jive_wm8750.c b/sound/soc/s3c24xx/jive_wm8750.c
index 7a6b0fa..4e1b8ac 100644
--- a/sound/soc/s3c24xx/jive_wm8750.c
+++ b/sound/soc/s3c24xx/jive_wm8750.c
@@ -25,7 +25,7 @@
 
 #include <asm/mach-types.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c2412-i2s.h"
 
 #include "../codecs/wm8750.h"
diff --git a/sound/soc/s3c24xx/ln2440sbc_alc650.c b/sound/soc/s3c24xx/ln2440sbc_alc650.c
index 6b7bb38..36e7e85 100644
--- a/sound/soc/s3c24xx/ln2440sbc_alc650.c
+++ b/sound/soc/s3c24xx/ln2440sbc_alc650.c
@@ -23,7 +23,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c-ac97.h"
 
 static struct snd_soc_card ln2440sbc;
diff --git a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
index a9a4bbb..c4b2013 100644
--- a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
@@ -32,7 +32,7 @@
 #include <asm/io.h>
 #include <mach/gta02.h>
 #include "../codecs/wm8753.h"
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c24xx-i2s.h"
 
 static struct snd_soc_card neo1973_gta02;
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index d5e4148..96dda57 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -36,7 +36,7 @@
 
 #include "../codecs/wm8753.h"
 #include "lm4857.h"
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c24xx-i2s.h"
 
 /* define the scenarios */
diff --git a/sound/soc/s3c24xx/rx1950_uda1380.c b/sound/soc/s3c24xx/rx1950_uda1380.c
index 99bb86e..07197ee 100644
--- a/sound/soc/s3c24xx/rx1950_uda1380.c
+++ b/sound/soc/s3c24xx/rx1950_uda1380.c
@@ -35,7 +35,7 @@
 
 #include <asm/mach-types.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c24xx-i2s.h"
 #include "../codecs/uda1380.h"
 
diff --git a/sound/soc/s3c24xx/s3c-ac97.c b/sound/soc/s3c24xx/s3c-ac97.c
index f891eb7..408f9c9 100644
--- a/sound/soc/s3c24xx/s3c-ac97.c
+++ b/sound/soc/s3c24xx/s3c-ac97.c
@@ -24,7 +24,7 @@
 #include <mach/dma.h>
 #include <plat/audio.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c-ac97.h"
 
 #define AC_CMD_ADDR(x) (x << 16)
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index b3866d5..c471431 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -28,7 +28,7 @@
 
 #include "regs-i2s-v2.h"
 #include "s3c-i2s-v2.h"
-#include "s3c-dma.h"
+#include "dma.h"
 
 #undef S3C_IIS_V2_SUPPORTED
 
diff --git a/sound/soc/s3c24xx/s3c-pcm.c b/sound/soc/s3c24xx/s3c-pcm.c
index 2e020e1..e111d23 100644
--- a/sound/soc/s3c24xx/s3c-pcm.c
+++ b/sound/soc/s3c24xx/s3c-pcm.c
@@ -29,7 +29,7 @@
 #include <plat/audio.h>
 #include <plat/dma.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c-pcm.h"
 
 static struct s3c2410_dma_client s3c_pcm_dma_client_out = {
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index 4a861cf..d953ff4 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -35,7 +35,7 @@
 #include <mach/regs-gpio.h>
 #include <mach/dma.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "regs-i2s-v2.h"
 #include "s3c2412-i2s.h"
 
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index e060daa..13e41ed 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -38,7 +38,7 @@
 
 #include <plat/regs-iis.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c24xx-i2s.h"
 
 static struct s3c2410_dma_client s3c24xx_dma_client_out = {
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec.c b/sound/soc/s3c24xx/s3c24xx_simtec.c
index c4c1114..3f052a5 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec.c
@@ -21,7 +21,7 @@
 
 #include <plat/audio-simtec.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c24xx-i2s.h"
 #include "s3c24xx_simtec.h"
 
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
index 5180c2a..8b246ab 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
@@ -18,7 +18,7 @@
 
 #include <plat/audio-simtec.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c24xx-i2s.h"
 #include "s3c24xx_simtec.h"
 
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
index 7a7bb53..a922e1e 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
@@ -18,7 +18,7 @@
 
 #include <plat/audio-simtec.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c24xx-i2s.h"
 #include "s3c24xx_simtec.h"
 
diff --git a/sound/soc/s3c24xx/s3c24xx_uda134x.c b/sound/soc/s3c24xx/s3c24xx_uda134x.c
index 50d44fa..87eeb46 100644
--- a/sound/soc/s3c24xx/s3c24xx_uda134x.c
+++ b/sound/soc/s3c24xx/s3c24xx_uda134x.c
@@ -24,7 +24,7 @@
 
 #include <plat/regs-iis.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c24xx-i2s.h"
 #include "../codecs/uda134x.h"
 
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
index a962847..46b65d7 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
@@ -21,7 +21,7 @@
 #include <mach/map.h>
 #include <mach/dma.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "regs-i2s-v2.h"
 #include "s3c64xx-i2s.h"
 
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index ae7acb6..0288d4e 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -25,7 +25,7 @@
 #include <mach/map.h>
 #include <mach/dma.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "regs-i2s-v2.h"
 #include "s3c64xx-i2s.h"
 
diff --git a/sound/soc/s3c24xx/smartq_wm8987.c b/sound/soc/s3c24xx/smartq_wm8987.c
index 863631a..1d55312 100644
--- a/sound/soc/s3c24xx/smartq_wm8987.c
+++ b/sound/soc/s3c24xx/smartq_wm8987.c
@@ -24,7 +24,7 @@
 
 #include <asm/mach-types.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c64xx-i2s.h"
 
 #include "../codecs/wm8750.h"
diff --git a/sound/soc/s3c24xx/smdk2443_wm9710.c b/sound/soc/s3c24xx/smdk2443_wm9710.c
index 911bb60..c50d19c 100644
--- a/sound/soc/s3c24xx/smdk2443_wm9710.c
+++ b/sound/soc/s3c24xx/smdk2443_wm9710.c
@@ -19,7 +19,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c-ac97.h"
 
 static struct snd_soc_card smdk2443;
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index 7e75c8d..9ddc964 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -19,7 +19,7 @@
 #include <sound/soc-dapm.h>
 
 #include "../codecs/wm8580.h"
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c64xx-i2s.h"
 
 /*
diff --git a/sound/soc/s3c24xx/smdk_spdif.c b/sound/soc/s3c24xx/smdk_spdif.c
index 082b88d..4fc6a9f 100644
--- a/sound/soc/s3c24xx/smdk_spdif.c
+++ b/sound/soc/s3c24xx/smdk_spdif.c
@@ -18,7 +18,7 @@
 
 #include <sound/soc.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "spdif.h"
 
 /* Audio clock settings are belonged to board specific part. Every
diff --git a/sound/soc/s3c24xx/smdk_wm9713.c b/sound/soc/s3c24xx/smdk_wm9713.c
index ea96a51..80f2aef 100644
--- a/sound/soc/s3c24xx/smdk_wm9713.c
+++ b/sound/soc/s3c24xx/smdk_wm9713.c
@@ -15,7 +15,7 @@
 #include <linux/device.h>
 #include <sound/soc.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c-ac97.h"
 
 static struct snd_soc_card smdk;
diff --git a/sound/soc/s3c24xx/spdif.c b/sound/soc/s3c24xx/spdif.c
index ce554e9..dc85df3 100644
--- a/sound/soc/s3c24xx/spdif.c
+++ b/sound/soc/s3c24xx/spdif.c
@@ -20,7 +20,7 @@
 #include <plat/audio.h>
 #include <mach/dma.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "spdif.h"
 
 /* Registers */
-- 
1.6.2.5
