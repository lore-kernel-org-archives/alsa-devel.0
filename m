From: Padmavathi Venna <padma.v@samsung.com>
Subject: [PATCH 3/4] ARM: dts: Correct the /include entry on exynos5420 dtsi
 file
Date: Wed, 10 Jul 2013 17:41:52 +0530
Message-ID: <1373458313-18970-4-git-send-email-padma.v@samsung.com>
References: <1373458313-18970-1-git-send-email-padma.v@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1373458313-18970-1-git-send-email-padma.v@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, padma.v@samsung.com, padma.kvr@gmail.com
Cc: sbkim73@samsung.com, broonie@kernel.org, kgene.kim@samsung.com, mturquette@linaro.org, dianders@chromium.org, abrestic@chromium.org
List-Id: alsa-devel@alsa-project.org

This patch corrects the /include to #include on exynos5420

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 8c54c4b..da55160 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -14,7 +14,7 @@
  */
 
 #include "exynos5.dtsi"
-/include/ "exynos5420-pinctrl.dtsi"
+#include "exynos5420-pinctrl.dtsi"
 / {
 	compatible = "samsung,exynos5420";
 
-- 
1.7.4.4
