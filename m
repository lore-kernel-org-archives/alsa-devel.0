From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCHv4 16/18] ASoC: SMDK_WM8580: Enable for SMDKC100
Date: Mon, 22 Nov 2010 15:37:19 +0900
Message-ID: <1290407839-29559-1-git-send-email-jassisinghbrar@gmail.com>
References: <1290407690-28917-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B81F10387B
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

Enable the ASoC Machine driver to run on SMDKC100 as well.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pc100/mach-smdkc100.c |    2 +
 sound/soc/s3c24xx/Kconfig             |    2 +-
 sound/soc/s3c24xx/smdk_wm8580.c       |   73 +++++++++++++++++++++++---------
 3 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 18b405d..dd192a2 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -96,6 +96,7 @@ static struct s3c2410_uartcfg smdkc100_uartcfgs[] __initdata = {
 
 /* I2C0 */
 static struct i2c_board_info i2c_devs0[] __initdata = {
+	{I2C_BOARD_INFO("wm8580", 0x1b),},
 };
 
 /* I2C1 */
@@ -190,6 +191,7 @@ static struct platform_device *smdkc100_devices[] __initdata = {
 	&s3c_device_ts,
 	&s3c_device_wdt,
 	&smdkc100_lcd_powerdev,
+	&samsung_asoc_dma,
 	&s5pc100_device_iis0,
 	&samsung_device_keypad,
 	&s5pc100_device_ac97,
diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 396f678..4989fad 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -62,7 +62,7 @@ config SND_S3C24XX_SOC_JIVE_WM8750
 
 config SND_SOC_SMDK_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK"
-	depends on SND_S3C24XX_SOC && MACH_SMDK6410
+	depends on SND_S3C24XX_SOC && (MACH_SMDK6410 || MACH_SMDKC100)
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
 	help
diff --git a/sound/soc/s3c24xx/smdk_wm8580.c b/sound/soc/s3c24xx/smdk_wm8580.c
index 4176252..9061268 100644
--- a/sound/soc/s3c24xx/smdk_wm8580.c
+++ b/sound/soc/s3c24xx/smdk_wm8580.c
@@ -18,6 +18,8 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
+#include <asm/mach-types.h>
+
 #include "../codecs/wm8580.h"
 #include "dma.h"
 #include "i2s.h"
@@ -201,33 +203,49 @@ static int smdk_wm8580_init_paifrx(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+enum {
+	PRI_PLAYBACK = 0,
+	PRI_CAPTURE,
+	SEC_PLAYBACK,
+};
+
 static struct snd_soc_dai_link smdk_dai[] = {
-{ /* Primary Playback i/f */
-	.name = "WM8580 PAIF RX",
-	.stream_name = "Playback",
-	.cpu_dai_name = "samsung-i2s.2",
-	.codec_dai_name = "wm8580-hifi-playback",
-	.platform_name = "samsung-audio",
-	.codec_name = "wm8580-codec.0-001b",
-	.init = smdk_wm8580_init_paifrx,
-	.ops = &smdk_ops,
-},
-{ /* Primary Capture i/f */
-	.name = "WM8580 PAIF TX",
-	.stream_name = "Capture",
-	.cpu_dai_name = "samsung-i2s.2",
-	.codec_dai_name = "wm8580-hifi-capture",
-	.platform_name = "samsung-audio",
-	.codec_name = "wm8580-codec.0-001b",
-	.init = smdk_wm8580_init_paiftx,
-	.ops = &smdk_ops,
-},
+	[PRI_PLAYBACK] = { /* Primary Playback i/f */
+		.name = "WM8580 PAIF RX",
+		.stream_name = "Playback",
+		.cpu_dai_name = "samsung-i2s.2",
+		.codec_dai_name = "wm8580-hifi-playback",
+		.platform_name = "samsung-audio",
+		.codec_name = "wm8580-codec.0-001b",
+		.init = smdk_wm8580_init_paifrx,
+		.ops = &smdk_ops,
+	},
+	[PRI_CAPTURE] = { /* Primary Capture i/f */
+		.name = "WM8580 PAIF TX",
+		.stream_name = "Capture",
+		.cpu_dai_name = "samsung-i2s.2",
+		.codec_dai_name = "wm8580-hifi-capture",
+		.platform_name = "samsung-audio",
+		.codec_name = "wm8580-codec.0-001b",
+		.init = smdk_wm8580_init_paiftx,
+		.ops = &smdk_ops,
+	},
+	[SEC_PLAYBACK] = { /* Sec_Fifo Playback i/f */
+		.name = "Sec_FIFO TX",
+		.stream_name = "Playback",
+		.cpu_dai_name = "samsung-i2s.x",
+		.codec_dai_name = "wm8580-hifi-playback",
+		.platform_name = "samsung-audio",
+		.codec_name = "wm8580-codec.0-001b",
+		.init = smdk_wm8580_init_paifrx,
+		.ops = &smdk_ops,
+	},
 };
 
 static struct snd_soc_card smdk = {
 	.name = "SMDK-I2S",
 	.dai_link = smdk_dai,
-	.num_links = ARRAY_SIZE(smdk_dai),
+	.num_links = 2,
 };
 
 static struct platform_device *smdk_snd_device;
@@ -235,6 +253,19 @@ static struct platform_device *smdk_snd_device;
 static int __init smdk_audio_init(void)
 {
 	int ret;
+	char *str;
+
+	if (machine_is_smdkc100()) {
+		smdk.num_links = 3;
+		/* S5PC100 has I2S0 as v5 */
+		str = (char *)smdk_dai[PRI_PLAYBACK].cpu_dai_name;
+		str[strlen(str) - 1] = '0';
+		str = (char *)smdk_dai[PRI_CAPTURE].cpu_dai_name;
+		str[strlen(str) - 1] = '0';
+		/* Secondary is at offset SAMSUNG_I2S_SECOFF from Primary */
+		str = (char *)smdk_dai[SEC_PLAYBACK].cpu_dai_name;
+		str[strlen(str) - 1] = '0' + SAMSUNG_I2S_SECOFF;
+	}
 
 	smdk_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!smdk_snd_device)
-- 
1.6.2.5
