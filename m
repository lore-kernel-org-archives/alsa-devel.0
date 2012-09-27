From: Padmavathi Venna <padma.v@samsung.com>
Subject: [PATCH V1 2/2] ARM: EXYNOS: Enable platform support for I2S controllers
Date: Thu, 27 Sep 2012 15:56:36 +0530
Message-ID: <1348741596-29451-3-git-send-email-padma.v@samsung.com>
References: <1348741596-29451-1-git-send-email-padma.v@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1348741596-29451-1-git-send-email-padma.v@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: padma.v@samsung.com, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org
Cc: sbkim73@samsung.com, sangsu4u.park@samsung.com, ben-linux@fluff.org, kgene.kim@samsung.com
List-Id: alsa-devel@alsa-project.org

Add AUXDATA entries for i2s controller driver so as to set the device
name for clock lookups

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-exynos/mach-exynos5-dt.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index e707eb1..19e7f9b 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -64,6 +64,12 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 				"exynos-gsc.2", NULL),
 	OF_DEV_AUXDATA("samsung,exynos5-gsc", EXYNOS5_PA_GSC3,
 				"exynos-gsc.3", NULL),
+	OF_DEV_AUXDATA("samsung,samsung-i2s", EXYNOS5_PA_I2S0,
+				"samsung-i2s.0", NULL),
+	OF_DEV_AUXDATA("samsung,samsung-i2s", EXYNOS5_PA_I2S1,
+				"samsung-i2s.1", NULL),
+	OF_DEV_AUXDATA("samsung,samsung-i2s", EXYNOS5_PA_I2S2,
+				"samsung-i2s.2", NULL),
 	{},
 };
 
-- 
1.7.4.4
