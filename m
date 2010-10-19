From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 25/25] ASoC: Samsung: Rename from s3c24xx to
	samsung
Date: Tue, 19 Oct 2010 17:16:03 +0900
Message-ID: <1287476163-32639-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 8EA13103869
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 10:22:26 +0200 (CEST)
In-Reply-To: <1P85Z9-0007a6-27>
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

Finally, move the 's3c24xx' directory to 'samsung'

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/Kconfig                                  |    2 +-
 sound/soc/Makefile                                 |    2 +-
 sound/soc/{s3c24xx => samsung}/Kconfig             |    0
 sound/soc/{s3c24xx => samsung}/Makefile            |    0
 sound/soc/{s3c24xx => samsung}/ac97.c              |    2 +-
 sound/soc/{s3c24xx => samsung}/ac97.h              |    2 +-
 sound/soc/{s3c24xx => samsung}/dma.c               |    0
 sound/soc/{s3c24xx => samsung}/dma.h               |    0
 sound/soc/{s3c24xx => samsung}/goni_wm8994.c       |    0
 sound/soc/{s3c24xx => samsung}/i2s.c               |    2 +-
 sound/soc/{s3c24xx => samsung}/i2s.h               |    2 +-
 sound/soc/{s3c24xx => samsung}/jive_wm8750.c       |    2 +-
 sound/soc/{s3c24xx => samsung}/lm4857.h            |    0
 sound/soc/{s3c24xx => samsung}/ln2440sbc_alc650.c  |    0
 .../{s3c24xx => samsung}/neo1973_gta02_wm8753.c    |    0
 sound/soc/{s3c24xx => samsung}/neo1973_wm8753.c    |    0
 sound/soc/{s3c24xx => samsung}/pcm.c               |    2 +-
 sound/soc/{s3c24xx => samsung}/pcm.h               |    2 +-
 sound/soc/{s3c24xx => samsung}/regs-i2s-v2.h       |    0
 sound/soc/{s3c24xx => samsung}/rx1950_uda1380.c    |    0
 sound/soc/{s3c24xx => samsung}/s3c-i2s-v2.c        |    2 +-
 sound/soc/{s3c24xx => samsung}/s3c-i2s-v2.h        |    2 +-
 sound/soc/{s3c24xx => samsung}/s3c2412-i2s.c       |    2 +-
 sound/soc/{s3c24xx => samsung}/s3c2412-i2s.h       |    2 +-
 sound/soc/{s3c24xx => samsung}/s3c24xx-i2s.c       |    0
 sound/soc/{s3c24xx => samsung}/s3c24xx-i2s.h       |    0
 sound/soc/{s3c24xx => samsung}/s3c24xx_simtec.c    |    2 +-
 sound/soc/{s3c24xx => samsung}/s3c24xx_simtec.h    |    2 +-
 .../{s3c24xx => samsung}/s3c24xx_simtec_hermes.c   |    2 +-
 .../s3c24xx_simtec_tlv320aic23.c                   |    2 +-
 sound/soc/{s3c24xx => samsung}/s3c24xx_uda134x.c   |    0
 sound/soc/{s3c24xx => samsung}/smartq_wm8987.c     |    2 +-
 sound/soc/{s3c24xx => samsung}/smdk2443_wm9710.c   |    0
 sound/soc/{s3c24xx => samsung}/smdk_spdif.c        |    0
 sound/soc/{s3c24xx => samsung}/smdk_wm8580.c       |    0
 sound/soc/{s3c24xx => samsung}/smdk_wm9713.c       |    0
 sound/soc/{s3c24xx => samsung}/spdif.c             |    2 +-
 sound/soc/{s3c24xx => samsung}/spdif.h             |    2 +-
 38 files changed, 20 insertions(+), 20 deletions(-)
 rename sound/soc/{s3c24xx => samsung}/Kconfig (100%)
 rename sound/soc/{s3c24xx => samsung}/Makefile (100%)
 rename sound/soc/{s3c24xx => samsung}/ac97.c (99%)
 rename sound/soc/{s3c24xx => samsung}/ac97.h (95%)
 rename sound/soc/{s3c24xx => samsung}/dma.c (100%)
 rename sound/soc/{s3c24xx => samsung}/dma.h (100%)
 rename sound/soc/{s3c24xx => samsung}/goni_wm8994.c (100%)
 rename sound/soc/{s3c24xx => samsung}/i2s.c (99%)
 rename sound/soc/{s3c24xx => samsung}/i2s.h (96%)
 rename sound/soc/{s3c24xx => samsung}/jive_wm8750.c (99%)
 rename sound/soc/{s3c24xx => samsung}/lm4857.h (100%)
 rename sound/soc/{s3c24xx => samsung}/ln2440sbc_alc650.c (100%)
 rename sound/soc/{s3c24xx => samsung}/neo1973_gta02_wm8753.c (100%)
 rename sound/soc/{s3c24xx => samsung}/neo1973_wm8753.c (100%)
 rename sound/soc/{s3c24xx => samsung}/pcm.c (99%)
 rename sound/soc/{s3c24xx => samsung}/pcm.h (99%)
 rename sound/soc/{s3c24xx => samsung}/regs-i2s-v2.h (100%)
 rename sound/soc/{s3c24xx => samsung}/rx1950_uda1380.c (100%)
 rename sound/soc/{s3c24xx => samsung}/s3c-i2s-v2.c (99%)
 rename sound/soc/{s3c24xx => samsung}/s3c-i2s-v2.h (98%)
 rename sound/soc/{s3c24xx => samsung}/s3c2412-i2s.c (99%)
 rename sound/soc/{s3c24xx => samsung}/s3c2412-i2s.h (95%)
 rename sound/soc/{s3c24xx => samsung}/s3c24xx-i2s.c (100%)
 rename sound/soc/{s3c24xx => samsung}/s3c24xx-i2s.h (100%)
 rename sound/soc/{s3c24xx => samsung}/s3c24xx_simtec.c (99%)
 rename sound/soc/{s3c24xx => samsung}/s3c24xx_simtec.h (94%)
 rename sound/soc/{s3c24xx => samsung}/s3c24xx_simtec_hermes.c (98%)
 rename sound/soc/{s3c24xx => samsung}/s3c24xx_simtec_tlv320aic23.c (98%)
 rename sound/soc/{s3c24xx => samsung}/s3c24xx_uda134x.c (100%)
 rename sound/soc/{s3c24xx => samsung}/smartq_wm8987.c (99%)
 rename sound/soc/{s3c24xx => samsung}/smdk2443_wm9710.c (100%)
 rename sound/soc/{s3c24xx => samsung}/smdk_spdif.c (100%)
 rename sound/soc/{s3c24xx => samsung}/smdk_wm8580.c (100%)
 rename sound/soc/{s3c24xx => samsung}/smdk_wm9713.c (100%)
 rename sound/soc/{s3c24xx => samsung}/spdif.c (99%)
 rename sound/soc/{s3c24xx => samsung}/spdif.h (94%)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 3e598e7..2722b19 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -36,7 +36,7 @@ source "sound/soc/nuc900/Kconfig"
 source "sound/soc/omap/Kconfig"
 source "sound/soc/kirkwood/Kconfig"
 source "sound/soc/pxa/Kconfig"
-source "sound/soc/s3c24xx/Kconfig"
+source "sound/soc/samsung/Kconfig"
 source "sound/soc/s6000/Kconfig"
 source "sound/soc/sh/Kconfig"
 source "sound/soc/txx9/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index eb18344..ce913bf 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_SND_SOC)	+= nuc900/
 obj-$(CONFIG_SND_SOC)	+= omap/
 obj-$(CONFIG_SND_SOC)	+= kirkwood/
 obj-$(CONFIG_SND_SOC)	+= pxa/
-obj-$(CONFIG_SND_SOC)	+= s3c24xx/
+obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= s6000/
 obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= txx9/
diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/samsung/Kconfig
similarity index 100%
rename from sound/soc/s3c24xx/Kconfig
rename to sound/soc/samsung/Kconfig
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/samsung/Makefile
similarity index 100%
rename from sound/soc/s3c24xx/Makefile
rename to sound/soc/samsung/Makefile
diff --git a/sound/soc/s3c24xx/ac97.c b/sound/soc/samsung/ac97.c
similarity index 99%
rename from sound/soc/s3c24xx/ac97.c
rename to sound/soc/samsung/ac97.c
index 4f999d1..4770a95 100644
--- a/sound/soc/s3c24xx/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/ac97.c
+/* sound/soc/samsung/ac97.c
  *
  * ALSA SoC Audio Layer - S3C AC97 Controller driver
  * 	Evolved from s3c2443-ac97.c
diff --git a/sound/soc/s3c24xx/ac97.h b/sound/soc/samsung/ac97.h
similarity index 95%
rename from sound/soc/s3c24xx/ac97.h
rename to sound/soc/samsung/ac97.h
index a8f01b7..0d0e1b5 100644
--- a/sound/soc/s3c24xx/ac97.h
+++ b/sound/soc/samsung/ac97.h
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/ac97.h
+/* sound/soc/samsung/ac97.h
  *
  * ALSA SoC Audio Layer - S3C AC97 Controller driver
  *	Evolved from s3c2443-ac97.h
diff --git a/sound/soc/s3c24xx/dma.c b/sound/soc/samsung/dma.c
similarity index 100%
rename from sound/soc/s3c24xx/dma.c
rename to sound/soc/samsung/dma.c
diff --git a/sound/soc/s3c24xx/dma.h b/sound/soc/samsung/dma.h
similarity index 100%
rename from sound/soc/s3c24xx/dma.h
rename to sound/soc/samsung/dma.h
diff --git a/sound/soc/s3c24xx/goni_wm8994.c b/sound/soc/samsung/goni_wm8994.c
similarity index 100%
rename from sound/soc/s3c24xx/goni_wm8994.c
rename to sound/soc/samsung/goni_wm8994.c
diff --git a/sound/soc/s3c24xx/i2s.c b/sound/soc/samsung/i2s.c
similarity index 99%
rename from sound/soc/s3c24xx/i2s.c
rename to sound/soc/samsung/i2s.c
index 6869f51..d5d8975 100644
--- a/sound/soc/s3c24xx/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/i2s.c
+/* sound/soc/samsung/i2s.c
  *
  * ALSA SoC Audio Layer - Samsung I2S Controller driver
  *
diff --git a/sound/soc/s3c24xx/i2s.h b/sound/soc/samsung/i2s.h
similarity index 96%
rename from sound/soc/s3c24xx/i2s.h
rename to sound/soc/samsung/i2s.h
index 77b7965..73a71cd 100644
--- a/sound/soc/s3c24xx/i2s.h
+++ b/sound/soc/samsung/i2s.h
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/i2s.h
+/* sound/soc/samsung/i2s.h
  *
  * ALSA SoC Audio Layer - Samsung I2S Controller driver
  *
diff --git a/sound/soc/s3c24xx/jive_wm8750.c b/sound/soc/samsung/jive_wm8750.c
similarity index 99%
rename from sound/soc/s3c24xx/jive_wm8750.c
rename to sound/soc/samsung/jive_wm8750.c
index 4e1b8ac..fe1649e 100644
--- a/sound/soc/s3c24xx/jive_wm8750.c
+++ b/sound/soc/samsung/jive_wm8750.c
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/jive_wm8750.c
+/* sound/soc/samsung/jive_wm8750.c
  *
  * Copyright 2007,2008 Simtec Electronics
  *
diff --git a/sound/soc/s3c24xx/lm4857.h b/sound/soc/samsung/lm4857.h
similarity index 100%
rename from sound/soc/s3c24xx/lm4857.h
rename to sound/soc/samsung/lm4857.h
diff --git a/sound/soc/s3c24xx/ln2440sbc_alc650.c b/sound/soc/samsung/ln2440sbc_alc650.c
similarity index 100%
rename from sound/soc/s3c24xx/ln2440sbc_alc650.c
rename to sound/soc/samsung/ln2440sbc_alc650.c
diff --git a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c b/sound/soc/samsung/neo1973_gta02_wm8753.c
similarity index 100%
rename from sound/soc/s3c24xx/neo1973_gta02_wm8753.c
rename to sound/soc/samsung/neo1973_gta02_wm8753.c
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
similarity index 100%
rename from sound/soc/s3c24xx/neo1973_wm8753.c
rename to sound/soc/samsung/neo1973_wm8753.c
diff --git a/sound/soc/s3c24xx/pcm.c b/sound/soc/samsung/pcm.c
similarity index 99%
rename from sound/soc/s3c24xx/pcm.c
rename to sound/soc/samsung/pcm.c
index 4d0f6e4..48d0b75 100644
--- a/sound/soc/s3c24xx/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/pcm.c
+/* sound/soc/samsung/pcm.c
  *
  * ALSA SoC Audio Layer - S3C PCM-Controller driver
  *
diff --git a/sound/soc/s3c24xx/pcm.h b/sound/soc/samsung/pcm.h
similarity index 99%
rename from sound/soc/s3c24xx/pcm.h
rename to sound/soc/samsung/pcm.h
index 3775216..03393dc 100644
--- a/sound/soc/s3c24xx/pcm.h
+++ b/sound/soc/samsung/pcm.h
@@ -1,4 +1,4 @@
-/*  sound/soc/s3c24xx/pcm.h
+/*  sound/soc/samsung/pcm.h
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/sound/soc/s3c24xx/regs-i2s-v2.h b/sound/soc/samsung/regs-i2s-v2.h
similarity index 100%
rename from sound/soc/s3c24xx/regs-i2s-v2.h
rename to sound/soc/samsung/regs-i2s-v2.h
diff --git a/sound/soc/s3c24xx/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
similarity index 100%
rename from sound/soc/s3c24xx/rx1950_uda1380.c
rename to sound/soc/samsung/rx1950_uda1380.c
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
similarity index 99%
rename from sound/soc/s3c24xx/s3c-i2s-v2.c
rename to sound/soc/samsung/s3c-i2s-v2.c
index c471431..094f36e 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/s3c-i2c-v2.c
+/* sound/soc/samsung/s3c-i2c-v2.c
  *
  * ALSA Soc Audio Layer - I2S core for newer Samsung SoCs.
  *
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.h b/sound/soc/samsung/s3c-i2s-v2.h
similarity index 98%
rename from sound/soc/s3c24xx/s3c-i2s-v2.h
rename to sound/soc/samsung/s3c-i2s-v2.h
index d458301..f8297d9 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.h
+++ b/sound/soc/samsung/s3c-i2s-v2.h
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/s3c-i2s-v2.h
+/* sound/soc/samsung/s3c-i2s-v2.h
  *
  * ALSA Soc Audio Layer - S3C_I2SV2 I2S driver
  *
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
similarity index 99%
rename from sound/soc/s3c24xx/s3c2412-i2s.c
rename to sound/soc/samsung/s3c2412-i2s.c
index d953ff4..7ea8378 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/s3c2412-i2s.c
+/* sound/soc/samsung/s3c2412-i2s.c
  *
  * ALSA Soc Audio Layer - S3C2412 I2S driver
  *
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.h b/sound/soc/samsung/s3c2412-i2s.h
similarity index 95%
rename from sound/soc/s3c24xx/s3c2412-i2s.h
rename to sound/soc/samsung/s3c2412-i2s.h
index 01a0471..02ad579 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.h
+++ b/sound/soc/samsung/s3c2412-i2s.h
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/s3c2412-i2s.c
+/* sound/soc/samsung/s3c2412-i2s.c
  *
  * ALSA Soc Audio Layer - S3C2412 I2S driver
  *
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
similarity index 100%
rename from sound/soc/s3c24xx/s3c24xx-i2s.c
rename to sound/soc/samsung/s3c24xx-i2s.c
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.h b/sound/soc/samsung/s3c24xx-i2s.h
similarity index 100%
rename from sound/soc/s3c24xx/s3c24xx-i2s.h
rename to sound/soc/samsung/s3c24xx-i2s.h
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
similarity index 99%
rename from sound/soc/s3c24xx/s3c24xx_simtec.c
rename to sound/soc/samsung/s3c24xx_simtec.c
index 3f052a5..4a1b002 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec.c
+++ b/sound/soc/samsung/s3c24xx_simtec.c
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/s3c24xx_simtec.c
+/* sound/soc/samsung/s3c24xx_simtec.c
  *
  * Copyright 2009 Simtec Electronics
  *
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec.h b/sound/soc/samsung/s3c24xx_simtec.h
similarity index 94%
rename from sound/soc/s3c24xx/s3c24xx_simtec.h
rename to sound/soc/samsung/s3c24xx_simtec.h
index e63d5ff..8270748 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec.h
+++ b/sound/soc/samsung/s3c24xx_simtec.h
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/s3c24xx_simtec.h
+/* sound/soc/samsung/s3c24xx_simtec.h
  *
  * Copyright 2009 Simtec Electronics
  *
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c b/sound/soc/samsung/s3c24xx_simtec_hermes.c
similarity index 98%
rename from sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
rename to sound/soc/samsung/s3c24xx_simtec_hermes.c
index 8b246ab..fec4cac 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
+++ b/sound/soc/samsung/s3c24xx_simtec_hermes.c
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
+/* sound/soc/samsung/s3c24xx_simtec_hermes.c
  *
  * Copyright 2009 Simtec Electronics
  *
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
similarity index 98%
rename from sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
rename to sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
index a922e1e..7915e02 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+/* sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
  *
  * Copyright 2009 Simtec Electronics
  *
diff --git a/sound/soc/s3c24xx/s3c24xx_uda134x.c b/sound/soc/samsung/s3c24xx_uda134x.c
similarity index 100%
rename from sound/soc/s3c24xx/s3c24xx_uda134x.c
rename to sound/soc/samsung/s3c24xx_uda134x.c
diff --git a/sound/soc/s3c24xx/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
similarity index 99%
rename from sound/soc/s3c24xx/smartq_wm8987.c
rename to sound/soc/samsung/smartq_wm8987.c
index 5fcc420..3564e00 100644
--- a/sound/soc/s3c24xx/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/smartq_wm8987.c
+/* sound/soc/samsung/smartq_wm8987.c
  *
  * Copyright 2010 Maurus Cuelenaere <mcuelenaere@gmail.com>
  *
diff --git a/sound/soc/s3c24xx/smdk2443_wm9710.c b/sound/soc/samsung/smdk2443_wm9710.c
similarity index 100%
rename from sound/soc/s3c24xx/smdk2443_wm9710.c
rename to sound/soc/samsung/smdk2443_wm9710.c
diff --git a/sound/soc/s3c24xx/smdk_spdif.c b/sound/soc/samsung/smdk_spdif.c
similarity index 100%
rename from sound/soc/s3c24xx/smdk_spdif.c
rename to sound/soc/samsung/smdk_spdif.c
diff --git a/sound/soc/s3c24xx/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
similarity index 100%
rename from sound/soc/s3c24xx/smdk_wm8580.c
rename to sound/soc/samsung/smdk_wm8580.c
diff --git a/sound/soc/s3c24xx/smdk_wm9713.c b/sound/soc/samsung/smdk_wm9713.c
similarity index 100%
rename from sound/soc/s3c24xx/smdk_wm9713.c
rename to sound/soc/samsung/smdk_wm9713.c
diff --git a/sound/soc/s3c24xx/spdif.c b/sound/soc/samsung/spdif.c
similarity index 99%
rename from sound/soc/s3c24xx/spdif.c
rename to sound/soc/samsung/spdif.c
index dc85df3..f081640 100644
--- a/sound/soc/s3c24xx/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/spdif.c
+/* sound/soc/samsung/spdif.c
  *
  * ALSA SoC Audio Layer - Samsung S/PDIF Controller driver
  *
diff --git a/sound/soc/s3c24xx/spdif.h b/sound/soc/samsung/spdif.h
similarity index 94%
rename from sound/soc/s3c24xx/spdif.h
rename to sound/soc/samsung/spdif.h
index 3ed5559..4f72cb4 100644
--- a/sound/soc/s3c24xx/spdif.h
+++ b/sound/soc/samsung/spdif.h
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/spdif.h
+/* sound/soc/samsung/spdif.h
  *
  * ALSA SoC Audio Layer - Samsung S/PDIF Controller driver
  *
-- 
1.6.2.5
