From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCHv4 07/18] ASoC: Samsung: Rename PCM driver
Date: Mon, 22 Nov 2010 15:36:44 +0900
Message-ID: <1290407804-29268-1-git-send-email-jassisinghbrar@gmail.com>
References: <1290407690-28917-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id A482A103886
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 07:51:02 +0100 (CET)
In-Reply-To: <1290407690-28917-1-git-send-email-jassisinghbrar@gmail.com>
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
Cc: kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Rename Samsung PCM Controller driver
	s3c-pcm.[c/h] -> pcm.[c/h]

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Makefile             |    4 ++--
 sound/soc/s3c24xx/{s3c-pcm.c => pcm.c} |    4 ++--
 sound/soc/s3c24xx/{s3c-pcm.h => pcm.h} |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename sound/soc/s3c24xx/{s3c-pcm.c => pcm.c} (99%)
 rename sound/soc/s3c24xx/{s3c-pcm.h => pcm.h} (99%)

diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index 551a63d..93de2a0 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -6,8 +6,8 @@ snd-soc-s3c64xx-i2s-objs := s3c64xx-i2s.o
 snd-soc-ac97-objs := ac97.o
 snd-soc-s3c64xx-i2s-v4-objs := s3c64xx-i2s-v4.o
 snd-soc-s3c-i2s-v2-objs := s3c-i2s-v2.o
-snd-soc-s3c-pcm-objs := s3c-pcm.o
 snd-soc-samsung-spdif-objs := spdif.o
+snd-soc-pcm-objs := pcm.o
 
 obj-$(CONFIG_SND_S3C24XX_SOC) += snd-soc-s3c24xx.o
 obj-$(CONFIG_SND_S3C24XX_SOC_I2S) += snd-soc-s3c24xx-i2s.o
@@ -16,8 +16,8 @@ obj-$(CONFIG_SND_S3C2412_SOC_I2S) += snd-soc-s3c2412-i2s.o
 obj-$(CONFIG_SND_S3C64XX_SOC_I2S) += snd-soc-s3c64xx-i2s.o
 obj-$(CONFIG_SND_S3C64XX_SOC_I2S_V4) += snd-soc-s3c64xx-i2s-v4.o
 obj-$(CONFIG_SND_S3C_I2SV2_SOC) += snd-soc-s3c-i2s-v2.o
-obj-$(CONFIG_SND_S3C_SOC_PCM) += snd-soc-s3c-pcm.o
 obj-$(CONFIG_SND_S5P_SOC_SPDIF) += snd-soc-samsung-spdif.o
+obj-$(CONFIG_SND_S3C_SOC_PCM) += snd-soc-pcm.o
 
 # S3C24XX Machine Support
 snd-soc-jive-wm8750-objs := jive_wm8750.o
diff --git a/sound/soc/s3c24xx/s3c-pcm.c b/sound/soc/s3c24xx/pcm.c
similarity index 99%
rename from sound/soc/s3c24xx/s3c-pcm.c
rename to sound/soc/s3c24xx/pcm.c
index e111d23..4d0f6e4 100644
--- a/sound/soc/s3c24xx/s3c-pcm.c
+++ b/sound/soc/s3c24xx/pcm.c
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/s3c-pcm.c
+/* sound/soc/s3c24xx/pcm.c
  *
  * ALSA SoC Audio Layer - S3C PCM-Controller driver
  *
@@ -30,7 +30,7 @@
 #include <plat/dma.h>
 
 #include "dma.h"
-#include "s3c-pcm.h"
+#include "pcm.h"
 
 static struct s3c2410_dma_client s3c_pcm_dma_client_out = {
 	.name		= "PCM Stereo out"
diff --git a/sound/soc/s3c24xx/s3c-pcm.h b/sound/soc/s3c24xx/pcm.h
similarity index 99%
rename from sound/soc/s3c24xx/s3c-pcm.h
rename to sound/soc/s3c24xx/pcm.h
index f60baa1..3775216 100644
--- a/sound/soc/s3c24xx/s3c-pcm.h
+++ b/sound/soc/s3c24xx/pcm.h
@@ -1,4 +1,4 @@
-/*  sound/soc/s3c24xx/s3c-pcm.h
+/*  sound/soc/s3c24xx/pcm.h
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
1.6.2.5
