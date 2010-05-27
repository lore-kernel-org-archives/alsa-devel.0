From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 1/2] ASOC: S5PC100: Enable AC97 support
Date: Thu, 27 May 2010 12:11:31 +0900
Message-ID: <1274929891-5185-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 88D091039ED
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 09:45:16 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

The S5PC100 has the AC97 controller same as S3C6410.
Simply enable the options to build the drivers for
S5PC100 also.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Kconfig       |    4 ++--
 sound/soc/s3c24xx/smdk_wm9713.c |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 2a7cc22..aa112d3 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -1,6 +1,6 @@
 config SND_S3C24XX_SOC
 	tristate "SoC Audio for the Samsung S3CXXXX chips"
-	depends on ARCH_S3C2410 || ARCH_S3C64XX
+	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5PC100
 	select S3C64XX_DMA if ARCH_S3C64XX
 	help
 	  Say Y or M if you want to add support for codecs attached to
@@ -120,7 +120,7 @@ config SND_S3C24XX_SOC_SIMTEC_HERMES
 
 config SND_SOC_SMDK_WM9713
 	tristate "SoC AC97 Audio support for SMDK with WM9713"
-	depends on SND_S3C24XX_SOC && MACH_SMDK6410
+	depends on SND_S3C24XX_SOC && (MACH_SMDK6410 || MACH_SMDKC100)
 	select SND_SOC_WM9713
 	select SND_S3C_SOC_AC97
 	help
diff --git a/sound/soc/s3c24xx/smdk_wm9713.c b/sound/soc/s3c24xx/smdk_wm9713.c
index 24fd39f..7dd85e5 100644
--- a/sound/soc/s3c24xx/smdk_wm9713.c
+++ b/sound/soc/s3c24xx/smdk_wm9713.c
@@ -25,6 +25,7 @@ static struct snd_soc_card smdk;
  * Default CFG switch settings to use this driver:
  *
  *   SMDK6410: Set CFG1 1-3 On, CFG2 1-4 Off
+ *   SMDKC100: Set CFG6 1-3 On, CFG7 1   On
  */
 
 /*
-- 
1.6.2.5
