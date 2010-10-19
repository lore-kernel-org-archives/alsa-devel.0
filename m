From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 19/25] ASoC: GONI: Move to use new I2S driver
Date: Tue, 19 Oct 2010 16:08:06 +0900
Message-ID: <1287472086-31016-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 55496103944
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 09:17:48 +0200 (CEST)
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

Modify the goni_wm8994.c to use new i2s controller driver.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Kconfig       |    2 +-
 sound/soc/s3c24xx/goni_wm8994.c |   10 ++--------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index e7fad53..f12e7c8 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -150,7 +150,7 @@ config SND_S3C64XX_SOC_SMARTQ
 config SND_SOC_GONI_AQUILA_WM8994
 	tristate "SoC I2S Audio support for AQUILA/GONI - WM8994"
 	depends on SND_S3C24XX_SOC && (MACH_GONI || MACH_AQUILA)
-	select SND_S3C64XX_SOC_I2S_V4
+	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8994
 	help
 	  Say Y if you want to add support for SoC audio on goni or aquila
diff --git a/sound/soc/s3c24xx/goni_wm8994.c b/sound/soc/s3c24xx/goni_wm8994.c
index 201056c..dcaf7c3 100644
--- a/sound/soc/s3c24xx/goni_wm8994.c
+++ b/sound/soc/s3c24xx/goni_wm8994.c
@@ -26,7 +26,7 @@
 #include <linux/mfd/wm8994/registers.h>
 #include "../codecs/wm8994.h"
 #include "dma.h"
-#include "s3c64xx-i2s.h"
+#include "i2s.h"
 
 #define MACHINE_NAME	0
 #define CPU_VOICE_DAI	1
@@ -163,12 +163,6 @@ static int goni_hifi_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	/* set the cpu system clock */
-	ret = snd_soc_dai_set_sysclk(cpu_dai, S3C64XX_CLKSRC_PCLK,
-			0, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
 	/* set codec DAI configuration */
 	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
 			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
@@ -249,7 +243,7 @@ static struct snd_soc_dai_link goni_dai[] = {
 {
 	.name = "WM8994",
 	.stream_name = "WM8994 HiFi",
-	.cpu_dai_name = "s3c64xx-i2s-v4",
+	.cpu_dai_name = "samsung-i2s.0",
 	.codec_dai_name = "wm8994-hifi",
 	.platform_name = "samsung-audio",
 	.codec_name = "wm8994-codec.0-0x1a",
-- 
1.6.2.5
