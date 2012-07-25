From: Padmavathi Venna <padma.v@samsung.com>
Subject: [PATCH 2/2] ARM: EXYNOS: Enable platform support for I2S controllers
Date: Wed, 25 Jul 2012 17:41:25 +0530
Message-ID: <1343218285-30535-3-git-send-email-padma.v@samsung.com>
References: <1343218285-30535-1-git-send-email-padma.v@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1343218285-30535-1-git-send-email-padma.v@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org
Cc: padma.v@samsung.com, rcsekar@samsung.com, sbkim73@samsung.com, sangsu4u.park@samsung.com, ben-linux@fluff.org, kgene.kim@samsung.com, olofj@google.com, thutt@chromium.org, joshi@samsung.com
List-Id: alsa-devel@alsa-project.org

Add AUXDATA entries for i2s controller driver so as to set the device
name for clock lookups

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-exynos/mach-exynos5-dt.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index c334eea..cf5a0f5 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -56,6 +56,12 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA0, "dma-pl330.0", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA1, "dma-pl330.1", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_MDMA1, "dma-pl330.2", NULL),
+	OF_DEV_AUXDATA("samsung,samsung-i2s", EXYNOS_PA_I2S0,
+				"samsung-i2s.0", NULL),
+	OF_DEV_AUXDATA("samsung,samsung-i2s", EXYNOS5_PA_I2S1,
+				"samsung-i2s.1", NULL),
+	OF_DEV_AUXDATA("samsung,samsung-i2s", EXYNOS5_PA_I2S2,
+				"samsung-i2s.2", NULL),
 	{},
 };
 
-- 
1.7.4.4
