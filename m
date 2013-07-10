From: Padmavathi Venna <padma.v@samsung.com>
Subject: [PATCH 4/4] ARM: dts: exynos5420: add audio clock controller
Date: Wed, 10 Jul 2013 17:41:53 +0530
Message-ID: <1373458313-18970-5-git-send-email-padma.v@samsung.com>
References: <1373458313-18970-1-git-send-email-padma.v@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1373458313-18970-1-git-send-email-padma.v@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, padma.v@samsung.com, padma.kvr@gmail.com
Cc: sbkim73@samsung.com, broonie@kernel.org, kgene.kim@samsung.com, mturquette@linaro.org, dianders@chromium.org, abrestic@chromium.org
List-Id: alsa-devel@alsa-project.org

From: Andrew Bresticker <abrestic@chromium.org>

This adds device-tree bindings for the audio subsystem clock controller
on Exynos 5420.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-on: https://gerrit.chromium.org/gerrit/57712
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index da55160..a84f5f1 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -15,6 +15,9 @@
 
 #include "exynos5.dtsi"
 #include "exynos5420-pinctrl.dtsi"
+
+#include <dt-bindings/clk/exynos-audss-clk.h>
+
 / {
 	compatible = "samsung,exynos5420";
 
@@ -65,6 +68,14 @@
 		#clock-cells = <1>;
 	};
 
+	clock_audss: audss-clock-controller@3810000 {
+		compatible = "samsung,exynos5420-audss-clock";
+		reg = <0x03810000 0x0C>;
+		#clock-cells = <1>;
+		clocks = <&clock 148>;
+		clock-names = "sclk_audio";
+	};
+
 	mct@101C0000 {
 		compatible = "samsung,exynos4210-mct";
 		reg = <0x101C0000 0x800>;
-- 
1.7.4.4
