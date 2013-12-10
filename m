From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V2 1/2] ASoC: ep93xx: get rid of
	ep93xx-pcm-audio struct device
Date: Tue, 10 Dec 2013 12:34:45 -0700
Message-ID: <1386704086-28624-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 0326D2652EE
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 20:34:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Ryan Mallon <rmallon@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

Modify the ep93xx PCM driver so that it's a utility library that can be
registered on each DAI, rather than a separate struct device. This is
more in line with how many recent DT-converted platforms operate, and
avoids the need for yet another struct device.

Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Rebased on a merge of topic/ep93xx and topic/dma
---
 sound/soc/cirrus/edb93xx.c     |  2 +-
 sound/soc/cirrus/ep93xx-ac97.c |  8 ++++++++
 sound/soc/cirrus/ep93xx-i2s.c  |  8 ++++++++
 sound/soc/cirrus/ep93xx-pcm.c  | 19 +++++--------------
 sound/soc/cirrus/ep93xx-pcm.h  | 22 ++++++++++++++++++++++
 sound/soc/cirrus/simone.c      |  2 +-
 sound/soc/cirrus/snappercl15.c |  2 +-
 7 files changed, 46 insertions(+), 17 deletions(-)
 create mode 100644 sound/soc/cirrus/ep93xx-pcm.h

diff --git a/sound/soc/cirrus/edb93xx.c b/sound/soc/cirrus/edb93xx.c
index c43fb214558a..4f900efc437c 100644
--- a/sound/soc/cirrus/edb93xx.c
+++ b/sound/soc/cirrus/edb93xx.c
@@ -63,7 +63,7 @@ static struct snd_soc_ops edb93xx_ops = {
 static struct snd_soc_dai_link edb93xx_dai = {
 	.name		= "CS4271",
 	.stream_name	= "CS4271 HiFi",
-	.platform_name	= "ep93xx-pcm-audio",
+	.platform_name	= "ep93xx-i2s",
 	.cpu_dai_name	= "ep93xx-i2s",
 	.codec_name	= "spi0.0",
 	.codec_dai_name	= "cs4271-hifi",
diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index efa75b5086a4..cc5583da5380 100644
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ b/sound/soc/cirrus/ep93xx-ac97.c
@@ -24,6 +24,8 @@
 
 #include <linux/platform_data/dma-ep93xx.h>
 
+#include "ep93xx-pcm.h"
+
 /*
  * Per channel (1-4) registers.
  */
@@ -394,8 +396,14 @@ static int ep93xx_ac97_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
+	ret = devm_ep93xx_pcm_platform_register(&pdev->dev);
+	if (ret)
+		goto fail_unregister;
+
 	return 0;
 
+fail_unregister:
+	snd_soc_unregister_component(&pdev->dev);
 fail:
 	ep93xx_ac97_info = NULL;
 	snd_soc_set_ac97_ops(NULL);
diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index a57643d6402f..167728a73da2 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -30,6 +30,8 @@
 #include <mach/ep93xx-regs.h>
 #include <linux/platform_data/dma-ep93xx.h>
 
+#include "ep93xx-pcm.h"
+
 #define EP93XX_I2S_TXCLKCFG		0x00
 #define EP93XX_I2S_RXCLKCFG		0x04
 #define EP93XX_I2S_GLCTRL		0x0C
@@ -405,8 +407,14 @@ static int ep93xx_i2s_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_put_lrclk;
 
+	err = devm_ep93xx_pcm_platform_register(&pdev->dev);
+	if (err)
+		goto fail_unregister;
+
 	return 0;
 
+fail_unregister:
+	snd_soc_unregister_component(&pdev->dev);
 fail_put_lrclk:
 	clk_put(info->lrclk);
 fail_put_sclk:
diff --git a/sound/soc/cirrus/ep93xx-pcm.c b/sound/soc/cirrus/ep93xx-pcm.c
index fdb8b8feb4ed..198c5405f2ce 100644
--- a/sound/soc/cirrus/ep93xx-pcm.c
+++ b/sound/soc/cirrus/ep93xx-pcm.c
@@ -23,6 +23,8 @@
 
 #include <linux/platform_data/dma-ep93xx.h>
 
+#include "ep93xx-pcm.h"
+
 static const struct snd_pcm_hardware ep93xx_pcm_hardware = {
 	.info			= (SNDRV_PCM_INFO_MMAP		|
 				   SNDRV_PCM_INFO_MMAP_VALID	|
@@ -76,27 +78,16 @@ static const struct snd_dmaengine_pcm_config ep93xx_dmaengine_pcm_config = {
 	.prealloc_buffer_size = 131072,
 };
 
-static int ep93xx_soc_platform_probe(struct platform_device *pdev)
+int devm_ep93xx_pcm_platform_register(struct device *dev)
 {
-	return devm_snd_dmaengine_pcm_register(&pdev->dev,
+	return devm_snd_dmaengine_pcm_register(dev,
 		&ep93xx_dmaengine_pcm_config,
 		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
 		SND_DMAENGINE_PCM_FLAG_NO_DT |
 		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
-
-static struct platform_driver ep93xx_pcm_driver = {
-	.driver = {
-			.name = "ep93xx-pcm-audio",
-			.owner = THIS_MODULE,
-	},
-
-	.probe = ep93xx_soc_platform_probe,
-};
-
-module_platform_driver(ep93xx_pcm_driver);
+EXPORT_SYMBOL_GPL(devm_ep93xx_pcm_platform_register);
 
 MODULE_AUTHOR("Ryan Mallon");
 MODULE_DESCRIPTION("EP93xx ALSA PCM interface");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:ep93xx-pcm-audio");
diff --git a/sound/soc/cirrus/ep93xx-pcm.h b/sound/soc/cirrus/ep93xx-pcm.h
new file mode 100644
index 000000000000..b7a12a2fae9c
--- /dev/null
+++ b/sound/soc/cirrus/ep93xx-pcm.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __EP93XX_PCM_H__
+#define __EP93XX_PCM_H__
+
+int devm_ep93xx_pcm_platform_register(struct device *dev);
+
+#endif
diff --git a/sound/soc/cirrus/simone.c b/sound/soc/cirrus/simone.c
index 4d094d00c34a..822a19a89e74 100644
--- a/sound/soc/cirrus/simone.c
+++ b/sound/soc/cirrus/simone.c
@@ -27,7 +27,7 @@ static struct snd_soc_dai_link simone_dai = {
 	.cpu_dai_name	= "ep93xx-ac97",
 	.codec_dai_name	= "ac97-hifi",
 	.codec_name	= "ac97-codec",
-	.platform_name	= "ep93xx-pcm-audio",
+	.platform_name	= "ep93xx-ac97",
 };
 
 static struct snd_soc_card snd_soc_simone = {
diff --git a/sound/soc/cirrus/snappercl15.c b/sound/soc/cirrus/snappercl15.c
index 69041074f2c1..29238a7476dd 100644
--- a/sound/soc/cirrus/snappercl15.c
+++ b/sound/soc/cirrus/snappercl15.c
@@ -83,7 +83,7 @@ static struct snd_soc_dai_link snappercl15_dai = {
 	.cpu_dai_name	= "ep93xx-i2s",
 	.codec_dai_name	= "tlv320aic23-hifi",
 	.codec_name	= "tlv320aic23-codec.0-001a",
-	.platform_name	=  "ep93xx-pcm-audio",
+	.platform_name	= "ep93xx-i2s",
 	.init		= snappercl15_tlv320aic23_init,
 	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
 			  SND_SOC_DAIFMT_CBS_CFS,
-- 
1.8.1.5
