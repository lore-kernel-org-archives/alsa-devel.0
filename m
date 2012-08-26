From: =?ks_c_5601-1987?B?udq787z2?= <sangsu4u.park@samsung.com>
Subject: ASoC: SAMSUNG: Change Kconfig to support all EXYNOSs
Date: Sun, 26 Aug 2012 17:04:37 +0900
Message-ID: <003001cd8361$7016a110$5043e330$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: lrg@ti.com, broonie@opensource.wolfsonmicro.com, sbkim73@samsung.com, ben-linux@fluff.org, kgene.kim@samsung.com
List-Id: alsa-devel@alsa-project.org

All EXYNOSs use SND_SOC_SAMSUNG configuration.
This patch change Kconfig to support all EXYNOSs like EXYNOS4 and EXYNOS5.

Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
---
 sound/soc/samsung/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index f17dd25..9e64ae6 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,6 +1,6 @@
 config SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
-	depends on ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5P64X0 ||
ARCH_EXYNOS4
+	depends on ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5P64X0 ||
ARCH_EXYNOS
 	select S3C64XX_DMA if ARCH_S3C64XX
 	select S3C2410_DMA if ARCH_S3C24XX
 	help
-- 
1.7.1
