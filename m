From: Jassi@alsa-project.org, "Brar <jassisinghbrar"@gmail.com
Subject: [PATCH 06/10] ASoC: SMDK6442: Enable I2S device
Date: Mon, 20 Dec 2010 11:05:52 +0900
Message-ID: <1292810752-30096-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292810667-29773-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A098245B3
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 03:27:07 +0100 (CET)
In-Reply-To: <1292810667-29773-1-git-send-email-jassisinghbrar@gmail.com>
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
Cc: lrg@slimlogic.co.uk, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/samsung/Kconfig       |    4 ++--
 sound/soc/samsung/smdk_wm8580.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index c8aa73e..1e73f70 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,6 +1,6 @@
 config ASOC_SAMSUNG
 	tristate "ASoC support for Samsung"
-	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5P64X0
+	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5P64X0 || ARCH_S5P6442
 	select S3C64XX_DMA if ARCH_S3C64XX
 	select S3C2410_DMA if ARCH_S3C2410
 	help
@@ -62,7 +62,7 @@ config ASOC_SAMSUNG_JIVE_WM8750
 
 config ASOC_SAMSUNG_SMDK_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK"
-	depends on ASOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDK6440 || MACH_SMDK6450)
+	depends on ASOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDK6440 || MACH_SMDK6450 || MACH_SMDK6442)
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
 	help
diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
index e4f3bc8..c149f73 100644
--- a/sound/soc/samsung/smdk_wm8580.c
+++ b/sound/soc/samsung/smdk_wm8580.c
@@ -254,7 +254,7 @@ static int __init smdk_audio_init(void)
 	int ret;
 	char *str;
 
-	if (machine_is_smdkc100()) {
+	if (machine_is_smdkc100() || machine_is_smdk6442()) {
 		smdk.num_links = 3;
 		/* Secondary is at offset SAMSUNG_I2S_SECOFF from Primary */
 		str = (char *)smdk_dai[SEC_PLAYBACK].cpu_dai_name;
-- 
1.6.2.5
