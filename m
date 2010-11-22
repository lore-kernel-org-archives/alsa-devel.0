From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCHv4 06/18] ASoC: Samsung: Rename AC97 driver
Date: Mon, 22 Nov 2010 15:36:03 +0900
Message-ID: <1290407763-29190-1-git-send-email-jassisinghbrar@gmail.com>
References: <1290407690-28917-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 998D0103882
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

Rename Samsung AC97 driver
	s3c-ac97.[c/h] -> ac97.[c/h]

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Makefile               |    4 ++--
 sound/soc/s3c24xx/{s3c-ac97.c => ac97.c} |   16 ++++++++--------
 sound/soc/s3c24xx/{s3c-ac97.h => ac97.h} |    8 ++++----
 sound/soc/s3c24xx/ln2440sbc_alc650.c     |    2 +-
 sound/soc/s3c24xx/smdk2443_wm9710.c      |    2 +-
 sound/soc/s3c24xx/smdk_wm9713.c          |    2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)
 rename sound/soc/s3c24xx/{s3c-ac97.c => ac97.c} (97%)
 rename sound/soc/s3c24xx/{s3c-ac97.h => ac97.h} (73%)

diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index 20aac45..551a63d 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -3,7 +3,7 @@ snd-soc-s3c24xx-objs := dma.o
 snd-soc-s3c24xx-i2s-objs := s3c24xx-i2s.o
 snd-soc-s3c2412-i2s-objs := s3c2412-i2s.o
 snd-soc-s3c64xx-i2s-objs := s3c64xx-i2s.o
-snd-soc-s3c-ac97-objs := s3c-ac97.o
+snd-soc-ac97-objs := ac97.o
 snd-soc-s3c64xx-i2s-v4-objs := s3c64xx-i2s-v4.o
 snd-soc-s3c-i2s-v2-objs := s3c-i2s-v2.o
 snd-soc-s3c-pcm-objs := s3c-pcm.o
@@ -11,7 +11,7 @@ snd-soc-samsung-spdif-objs := spdif.o
 
 obj-$(CONFIG_SND_S3C24XX_SOC) += snd-soc-s3c24xx.o
 obj-$(CONFIG_SND_S3C24XX_SOC_I2S) += snd-soc-s3c24xx-i2s.o
-obj-$(CONFIG_SND_S3C_SOC_AC97) += snd-soc-s3c-ac97.o
+obj-$(CONFIG_SND_S3C_SOC_AC97) += snd-soc-ac97.o
 obj-$(CONFIG_SND_S3C2412_SOC_I2S) += snd-soc-s3c2412-i2s.o
 obj-$(CONFIG_SND_S3C64XX_SOC_I2S) += snd-soc-s3c64xx-i2s.o
 obj-$(CONFIG_SND_S3C64XX_SOC_I2S_V4) += snd-soc-s3c64xx-i2s-v4.o
diff --git a/sound/soc/s3c24xx/s3c-ac97.c b/sound/soc/s3c24xx/ac97.c
similarity index 97%
rename from sound/soc/s3c24xx/s3c-ac97.c
rename to sound/soc/s3c24xx/ac97.c
index 5352cac..4f999d1 100644
--- a/sound/soc/s3c24xx/s3c-ac97.c
+++ b/sound/soc/s3c24xx/ac97.c
@@ -1,4 +1,4 @@
-/* sound/soc/s3c24xx/s3c-ac97.c
+/* sound/soc/s3c24xx/ac97.c
  *
  * ALSA SoC Audio Layer - S3C AC97 Controller driver
  * 	Evolved from s3c2443-ac97.c
@@ -25,7 +25,7 @@
 #include <plat/audio.h>
 
 #include "dma.h"
-#include "s3c-ac97.h"
+#include "ac97.h"
 
 #define AC_CMD_ADDR(x) (x << 16)
 #define AC_CMD_DATA(x) (x & 0xffff)
@@ -122,7 +122,7 @@ static unsigned short s3c_ac97_read(struct snd_ac97 *ac97,
 	data = (stat & 0xffff);
 
 	if (addr != reg)
-		pr_err("s3c-ac97: req addr = %02x, rep addr = %02x\n",
+		pr_err("ac97: req addr = %02x, rep addr = %02x\n",
 			reg, addr);
 
 	mutex_unlock(&s3c_ac97.lock);
@@ -334,7 +334,7 @@ static struct snd_soc_dai_ops s3c_ac97_mic_dai_ops = {
 
 static struct snd_soc_dai_driver s3c_ac97_dai[] = {
 	[S3C_AC97_DAI_PCM] = {
-		.name =	"s3c-ac97",
+		.name =	"samsung-ac97",
 		.ac97_control = 1,
 		.playback = {
 			.stream_name = "AC97 Playback",
@@ -351,7 +351,7 @@ static struct snd_soc_dai_driver s3c_ac97_dai[] = {
 		.ops = &s3c_ac97_dai_ops,
 	},
 	[S3C_AC97_DAI_MIC] = {
-		.name = "s3c-ac97-mic",
+		.name = "samsung-ac97-mic",
 		.ac97_control = 1,
 		.capture = {
 			.stream_name = "AC97 Mic Capture",
@@ -407,7 +407,7 @@ static __devinit int s3c_ac97_probe(struct platform_device *pdev)
 	}
 
 	if (!request_mem_region(mem_res->start,
-				resource_size(mem_res), "s3c-ac97")) {
+				resource_size(mem_res), "ac97")) {
 		dev_err(&pdev->dev, "Unable to request register region\n");
 		return -EBUSY;
 	}
@@ -431,7 +431,7 @@ static __devinit int s3c_ac97_probe(struct platform_device *pdev)
 
 	s3c_ac97.ac97_clk = clk_get(&pdev->dev, "ac97");
 	if (IS_ERR(s3c_ac97.ac97_clk)) {
-		dev_err(&pdev->dev, "s3c-ac97 failed to get ac97_clock\n");
+		dev_err(&pdev->dev, "ac97 failed to get ac97_clock\n");
 		ret = -ENODEV;
 		goto err2;
 	}
@@ -446,7 +446,7 @@ static __devinit int s3c_ac97_probe(struct platform_device *pdev)
 	ret = request_irq(irq_res->start, s3c_ac97_irq,
 					IRQF_DISABLED, "AC97", NULL);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "s3c-ac97: interrupt request failed.\n");
+		dev_err(&pdev->dev, "ac97: interrupt request failed.\n");
 		goto err4;
 	}
 
diff --git a/sound/soc/s3c24xx/s3c-ac97.h b/sound/soc/s3c24xx/ac97.h
similarity index 73%
rename from sound/soc/s3c24xx/s3c-ac97.h
rename to sound/soc/s3c24xx/ac97.h
index 5dcedd0..a8f01b7 100644
--- a/sound/soc/s3c24xx/s3c-ac97.h
+++ b/sound/soc/s3c24xx/ac97.h
@@ -1,11 +1,11 @@
-/* sound/soc/s3c24xx/s3c-ac97.h
+/* sound/soc/s3c24xx/ac97.h
  *
  * ALSA SoC Audio Layer - S3C AC97 Controller driver
- * 	Evolved from s3c2443-ac97.h
+ *	Evolved from s3c2443-ac97.h
  *
  * Copyright (c) 2010 Samsung Electronics Co. Ltd
- * 	Author: Jaswinder Singh <jassi.brar@samsung.com>
- * 	Credits: Graeme Gregory, Sean Choi
+ *	Author: Jaswinder Singh <jassi.brar@samsung.com>
+ *	Credits: Graeme Gregory, Sean Choi
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/sound/soc/s3c24xx/ln2440sbc_alc650.c b/sound/soc/s3c24xx/ln2440sbc_alc650.c
index dda11ac..e507174 100644
--- a/sound/soc/s3c24xx/ln2440sbc_alc650.c
+++ b/sound/soc/s3c24xx/ln2440sbc_alc650.c
@@ -24,7 +24,7 @@
 #include <sound/soc-dapm.h>
 
 #include "dma.h"
-#include "s3c-ac97.h"
+#include "ac97.h"
 
 static struct snd_soc_card ln2440sbc;
 
diff --git a/sound/soc/s3c24xx/smdk2443_wm9710.c b/sound/soc/s3c24xx/smdk2443_wm9710.c
index 0205138..5051699 100644
--- a/sound/soc/s3c24xx/smdk2443_wm9710.c
+++ b/sound/soc/s3c24xx/smdk2443_wm9710.c
@@ -20,7 +20,7 @@
 #include <sound/soc-dapm.h>
 
 #include "dma.h"
-#include "s3c-ac97.h"
+#include "ac97.h"
 
 static struct snd_soc_card smdk2443;
 
diff --git a/sound/soc/s3c24xx/smdk_wm9713.c b/sound/soc/s3c24xx/smdk_wm9713.c
index 56b448d..7ce2430 100644
--- a/sound/soc/s3c24xx/smdk_wm9713.c
+++ b/sound/soc/s3c24xx/smdk_wm9713.c
@@ -16,7 +16,7 @@
 #include <sound/soc.h>
 
 #include "dma.h"
-#include "s3c-ac97.h"
+#include "ac97.h"
 
 static struct snd_soc_card smdk;
 
-- 
1.6.2.5
