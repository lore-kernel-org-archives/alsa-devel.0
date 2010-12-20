From: Jassi@alsa-project.org, "Brar <jassisinghbrar"@gmail.com
Subject: [PATCH 09/10] ASoC: SMDKV310: Enable AC97 device
Date: Mon, 20 Dec 2010 11:05:56 +0900
Message-ID: <1292810756-30192-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292810667-29773-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 83CE0245AF
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 03:27:06 +0100 (CET)
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

Enable AC97 audio device on SMDKV310/C210.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/samsung/Kconfig       |    4 ++--
 sound/soc/samsung/smdk_wm9713.c |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 472951d..9cedf34 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,6 +1,6 @@
 config ASOC_SAMSUNG
 	tristate "ASoC support for Samsung"
-	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5P64X0 || ARCH_S5P6442
+	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5P64X0 || ARCH_S5P6442 || ARCH_S5PV310
 	select S3C64XX_DMA if ARCH_S3C64XX
 	select S3C2410_DMA if ARCH_S3C2410
 	help
@@ -134,7 +134,7 @@ config ASOC_SAMSUNG_RX1950_UDA1380
 
 config ASOC_SAMSUNG_SMDK_WM9713
 	tristate "SoC AC97 Audio support for SMDK with WM9713"
-	depends on ASOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110)
+	depends on ASOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110 || MACH_SMDKV310 || MACH_SMDKC210)
 	select SND_SOC_WM9713
 	select SND_SAMSUNG_AC97
 	help
diff --git a/sound/soc/samsung/smdk_wm9713.c b/sound/soc/samsung/smdk_wm9713.c
index 238cb3a..ae5fed6 100644
--- a/sound/soc/samsung/smdk_wm9713.c
+++ b/sound/soc/samsung/smdk_wm9713.c
@@ -27,6 +27,7 @@ static struct snd_soc_card smdk;
  *   SMDKC100: Set CFG6 1-3 On, CFG7 1   On
  *   SMDKC110: Set CFGB10 1-2 Off, CFGB12 1-3 On
  *   SMDKV210: Set CFGB10 1-2 Off, CFGB12 1-3 On
+ *   SMDKV310: Set CFG2 1-2 Off, CFG4 All On, CFG7 All Off, CFG8 1-On
  */
 
 /*
-- 
1.6.2.5
