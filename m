From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH 4/4] ASoC: SAMSUNG: Clean-up header includes
Date: Fri,  7 Jan 2011 13:57:42 +0900
Message-ID: <1294376262-18364-1-git-send-email-sw.youn@samsung.com>
References: <1294375429-16729-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id B560B2463F
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 06:21:07 +0100 (CET)
In-Reply-To: <1294375429-16729-1-git-send-email-sw.youn@samsung.com>
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
Cc: Seungwhan Youn <sw.youn@samsung.com>, broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch remove including unnecessary/duplicated headers which relative
with Samsung SoCs.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/samsung/ac97.c                       |    8 +++-----
 sound/soc/samsung/dma.c                        |   12 +++---------
 sound/soc/samsung/goni_wm8994.c                |   10 +---------
 sound/soc/samsung/h1940_uda1380.c              |   11 +----------
 sound/soc/samsung/i2s.c                        |    7 +++----
 sound/soc/samsung/jive_wm8750.c                |   11 -----------
 sound/soc/samsung/ln2440sbc_alc650.c           |    6 ------
 sound/soc/samsung/neo1973_gta02_wm8753.c       |   15 ++-------------
 sound/soc/samsung/pcm.c                        |   15 +++------------
 sound/soc/samsung/rx1950_uda1380.c             |   14 +-------------
 sound/soc/samsung/s3c-i2s-v2.c                 |    7 +++----
 sound/soc/samsung/s3c2412-i2s.c                |   16 +++-------------
 sound/soc/samsung/s3c24xx-i2s.c                |   18 +++---------------
 sound/soc/samsung/s3c24xx_simtec.c             |   12 ++----------
 sound/soc/samsung/s3c24xx_simtec_hermes.c      |   10 ----------
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c |   12 ------------
 sound/soc/samsung/s3c24xx_uda134x.c            |   12 ++----------
 sound/soc/samsung/smartq_wm8987.c              |    9 +--------
 sound/soc/samsung/smdk2443_wm9710.c            |    6 ------
 sound/soc/samsung/smdk_spdif.c                 |    9 ++-------
 sound/soc/samsung/smdk_wm8580.c                |    7 +------
 sound/soc/samsung/smdk_wm9713.c                |    4 ----
 sound/soc/samsung/spdif.c                      |    7 +++----
 23 files changed, 37 insertions(+), 201 deletions(-)

diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 1e84ee0..18528d8 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -12,16 +12,14 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/init.h>
-#include <linux/module.h>
+#include <sound/soc.h>
+
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
 
-#include <sound/soc.h>
-
-#include <plat/regs-ac97.h>
 #include <mach/dma.h>
+#include <plat/regs-ac97.h>
 #include <plat/audio.h>
 
 #include "dma.h"
diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index c2cdb45..c80c070 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -14,18 +14,12 @@
  *  option) any later version.
  */
 
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-
 #include <asm/dma.h>
 #include <mach/hardware.h>
 #include <mach/dma.h>
diff --git a/sound/soc/samsung/goni_wm8994.c b/sound/soc/samsung/goni_wm8994.c
index 34dd9ef..f6b3a3c 100644
--- a/sound/soc/samsung/goni_wm8994.c
+++ b/sound/soc/samsung/goni_wm8994.c
@@ -11,21 +11,13 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
+
 #include <asm/mach-types.h>
 #include <mach/gpio.h>
-#include <mach/regs-clock.h>
 
-#include <linux/mfd/wm8994/core.h>
-#include <linux/mfd/wm8994/registers.h>
 #include "../codecs/wm8994.h"
-#include "dma.h"
-#include "i2s.h"
 
 #define MACHINE_NAME	0
 #define CPU_VOICE_DAI	1
diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
index c45f7ce..5653e6d 100644
--- a/sound/soc/samsung/h1940_uda1380.c
+++ b/sound/soc/samsung/h1940_uda1380.c
@@ -13,25 +13,16 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/platform_device.h>
-#include <linux/i2c.h>
-#include <linux/gpio.h>
 
 #include <sound/soc.h>
-#include <sound/uda1380.h>
 #include <sound/jack.h>
 
+#include <linux/gpio.h>
 #include <plat/regs-iis.h>
-
 #include <mach/h1940-latch.h>
-
 #include <asm/mach-types.h>
 
-#include "dma.h"
 #include "s3c24xx-i2s.h"
-#include "../codecs/uda1380.h"
 
 static unsigned int rates[] = {
 	11025,
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index d00ac3a..4fa24e0 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -10,15 +10,14 @@
  * published by the Free Software Foundation.
  */
 
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-
 #include <plat/audio.h>
 
 #include "dma.h"
diff --git a/sound/soc/samsung/jive_wm8750.c b/sound/soc/samsung/jive_wm8750.c
index 0880252..3b53ad5 100644
--- a/sound/soc/samsung/jive_wm8750.c
+++ b/sound/soc/samsung/jive_wm8750.c
@@ -11,22 +11,11 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/timer.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
 #include <sound/soc.h>
 
 #include <asm/mach-types.h>
 
-#include "dma.h"
 #include "s3c2412-i2s.h"
-
 #include "../codecs/wm8750.h"
 
 static const struct snd_soc_dapm_route audio_map[] = {
diff --git a/sound/soc/samsung/ln2440sbc_alc650.c b/sound/soc/samsung/ln2440sbc_alc650.c
index 0241429..bd91c19 100644
--- a/sound/soc/samsung/ln2440sbc_alc650.c
+++ b/sound/soc/samsung/ln2440sbc_alc650.c
@@ -16,14 +16,8 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/device.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
 #include <sound/soc.h>
 
-#include "dma.h"
-
 static struct snd_soc_card ln2440sbc;
 
 static struct snd_soc_dai_link ln2440sbc_dai[] = {
diff --git a/sound/soc/samsung/neo1973_gta02_wm8753.c b/sound/soc/samsung/neo1973_gta02_wm8753.c
index 3eec610..3fe16e5 100644
--- a/sound/soc/samsung/neo1973_gta02_wm8753.c
+++ b/sound/soc/samsung/neo1973_gta02_wm8753.c
@@ -13,25 +13,14 @@
  *  option) any later version.
  */
 
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/timer.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
 #include <sound/soc.h>
 
+#include <linux/gpio.h>
 #include <asm/mach-types.h>
-
 #include <plat/regs-iis.h>
-
-#include <mach/regs-clock.h>
-#include <asm/io.h>
 #include <mach/gta02.h>
+
 #include "../codecs/wm8753.h"
-#include "dma.h"
 #include "s3c24xx-i2s.h"
 
 static struct snd_soc_card neo1973_gta02;
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 091db5d..b7562be 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -11,21 +11,12 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/delay.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
 #include <linux/clk.h>
-#include <linux/kernel.h>
-#include <linux/gpio.h>
 #include <linux/io.h>
 
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
-#include <sound/soc.h>
-
 #include <plat/audio.h>
 #include <plat/dma.h>
 
diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index 5a4587e..29b1c6d 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -17,26 +17,14 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/platform_device.h>
-#include <linux/i2c.h>
-#include <linux/gpio.h>
-#include <linux/clk.h>
-
 #include <sound/soc.h>
-#include <sound/uda1380.h>
 #include <sound/jack.h>
 
+#include <linux/gpio.h>
 #include <plat/regs-iis.h>
-
-#include <mach/regs-clock.h>
-
 #include <asm/mach-types.h>
 
-#include "dma.h"
 #include "s3c24xx-i2s.h"
-#include "../codecs/uda1380.h"
 
 static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd);
 static int rx1950_startup(struct snd_pcm_substream *substream);
diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index 094f36e..5f1a2a4 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -16,14 +16,13 @@
  * option) any later version.
  */
 
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-
 #include <mach/dma.h>
 
 #include "regs-i2s-v2.h"
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index 7ea8378..a6977b7 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -16,22 +16,14 @@
  * option) any later version.
  */
 
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/clk.h>
-#include <linux/kernel.h>
 #include <linux/io.h>
 
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
-#include <sound/soc.h>
-#include <mach/hardware.h>
-
 #include <mach/regs-gpio.h>
 #include <mach/dma.h>
 
@@ -39,8 +31,6 @@
 #include "regs-i2s-v2.h"
 #include "s3c2412-i2s.h"
 
-#define S3C2412_I2S_DEBUG 0
-
 static struct s3c2410_dma_client s3c2412_dma_client_out = {
 	.name		= "I2S PCM Stereo out"
 };
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 13e41ed..3b8e3ba 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -14,28 +14,16 @@
  *  option) any later version.
  */
 
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
 #include <linux/delay.h>
 #include <linux/clk.h>
-#include <linux/jiffies.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
 
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
-#include <sound/soc.h>
-
-#include <mach/hardware.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-clock.h>
-
-#include <asm/dma.h>
 #include <mach/dma.h>
-
 #include <plat/regs-iis.h>
 
 #include "dma.h"
diff --git a/sound/soc/samsung/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
index a434032..e8ac932 100644
--- a/sound/soc/samsung/s3c24xx_simtec.c
+++ b/sound/soc/samsung/s3c24xx_simtec.c
@@ -7,20 +7,12 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <linux/clk.h>
-#include <linux/i2c.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
 #include <sound/soc.h>
 
+#include <linux/gpio.h>
+#include <linux/clk.h>
 #include <plat/audio-simtec.h>
 
-#include "dma.h"
 #include "s3c24xx-i2s.h"
 #include "s3c24xx_simtec.h"
 
diff --git a/sound/soc/samsung/s3c24xx_simtec_hermes.c b/sound/soc/samsung/s3c24xx_simtec_hermes.c
index bb4292e..d7b3e6e 100644
--- a/sound/soc/samsung/s3c24xx_simtec_hermes.c
+++ b/sound/soc/samsung/s3c24xx_simtec_hermes.c
@@ -7,18 +7,8 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/module.h>
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
 #include <sound/soc.h>
 
-#include <plat/audio-simtec.h>
-
-#include "dma.h"
-#include "s3c24xx-i2s.h"
 #include "s3c24xx_simtec.h"
 
 static const struct snd_soc_dapm_widget dapm_widgets[] = {
diff --git a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
index fbba4e3..ff6168f 100644
--- a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
@@ -7,22 +7,10 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/module.h>
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
 #include <sound/soc.h>
 
-#include <plat/audio-simtec.h>
-
-#include "dma.h"
-#include "s3c24xx-i2s.h"
 #include "s3c24xx_simtec.h"
 
-#include "../codecs/tlv320aic23.h"
-
 /* supported machines:
  *
  * Machine	Connections		AMP
diff --git a/sound/soc/samsung/s3c24xx_uda134x.c b/sound/soc/samsung/s3c24xx_uda134x.c
index cdc8ecb..70a7598 100644
--- a/sound/soc/samsung/s3c24xx_uda134x.c
+++ b/sound/soc/samsung/s3c24xx_uda134x.c
@@ -11,22 +11,14 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/module.h>
-#include <linux/clk.h>
-#include <linux/mutex.h>
-#include <linux/gpio.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/s3c24xx_uda134x.h>
-#include <sound/uda134x.h>
 
+#include <linux/clk.h>
+#include <linux/gpio.h>
 #include <plat/regs-iis.h>
 
-#include "dma.h"
 #include "s3c24xx-i2s.h"
-#include "../codecs/uda134x.h"
-
 
 /* #define ENFORCE_RATES 1 */
 /*
diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index 61e2b52..4e5ae41 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -13,20 +13,13 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
 
+#include <linux/gpio.h>
 #include <asm/mach-types.h>
 
-#include "dma.h"
 #include "i2s.h"
-
 #include "../codecs/wm8750.h"
 
 /*
diff --git a/sound/soc/samsung/smdk2443_wm9710.c b/sound/soc/samsung/smdk2443_wm9710.c
index 4bd8c0b..3a0dbfc 100644
--- a/sound/soc/samsung/smdk2443_wm9710.c
+++ b/sound/soc/samsung/smdk2443_wm9710.c
@@ -12,14 +12,8 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/device.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
 #include <sound/soc.h>
 
-#include "dma.h"
-
 static struct snd_soc_card smdk2443;
 
 static struct snd_soc_dai_link smdk2443_dai[] = {
diff --git a/sound/soc/samsung/smdk_spdif.c b/sound/soc/samsung/smdk_spdif.c
index cb2f4d0..5c1f9fb 100644
--- a/sound/soc/samsung/smdk_spdif.c
+++ b/sound/soc/samsung/smdk_spdif.c
@@ -10,15 +10,10 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/clk.h>
-
-#include <plat/devs.h>
-
 #include <sound/soc.h>
 
-#include "dma.h"
+#include <linux/clk.h>
+
 #include "spdif.h"
 
 /* Audio clock settings are belonged to board specific part. Every
diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
index b2cff1a..8aacf23 100644
--- a/sound/soc/samsung/smdk_wm8580.c
+++ b/sound/soc/samsung/smdk_wm8580.c
@@ -10,17 +10,12 @@
  *  option) any later version.
  */
 
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/pcm_params.h>
 
 #include <asm/mach-types.h>
 
 #include "../codecs/wm8580.h"
-#include "dma.h"
 #include "i2s.h"
 
 /*
diff --git a/sound/soc/samsung/smdk_wm9713.c b/sound/soc/samsung/smdk_wm9713.c
index d58d86e..fffe3c1 100644
--- a/sound/soc/samsung/smdk_wm9713.c
+++ b/sound/soc/samsung/smdk_wm9713.c
@@ -11,12 +11,8 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/device.h>
 #include <sound/soc.h>
 
-#include "dma.h"
-
 static struct snd_soc_card smdk;
 
 /*
diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index f081640..94cc716 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -10,13 +10,12 @@
  * published by the Free Software Foundation.
  */
 
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-
 #include <plat/audio.h>
 #include <mach/dma.h>
 
-- 
1.6.2.5
