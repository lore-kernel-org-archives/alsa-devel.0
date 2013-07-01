From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 4/4] ARM: mxs: saif0 is the clock provider to
	sgtl5000
Date: Mon, 1 Jul 2013 16:16:11 +0800
Message-ID: <1372666571-17276-5-git-send-email-shawn.guo@linaro.org>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id A870C265074
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2013 10:16:21 +0200 (CEST)
In-Reply-To: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, marex@denx.de, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

These systems all use saif0 as the mclock provider to codec sgtl5000.
Reflect that in device tree source, so that sgtl5000 can find the clock
by calling clk_get().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-apx4devkit.dts |    2 +-
 arch/arm/boot/dts/imx28-evk.dts        |    2 +-
 arch/arm/boot/dts/imx28-m28evk.dts     |    2 +-
 arch/arm/boot/dts/imx28.dtsi           |    1 +
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index 43bf3c7..0e7fed4 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -147,7 +147,7 @@
 					reg = <0x0a>;
 					VDDA-supply = <&reg_3p3v>;
 					VDDIO-supply = <&reg_3p3v>;
-
+					clocks = <&saif0>;
 				};
 
 				pcf8563: rtc@51 {
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 3637bf3..dccb223 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -193,7 +193,7 @@
 					reg = <0x0a>;
 					VDDA-supply = <&reg_3p3v>;
 					VDDIO-supply = <&reg_3p3v>;
-
+					clocks = <&saif0>;
 				};
 
 				at24@51 {
diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index 880df2f..44d9da5 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -184,7 +184,7 @@
 					reg = <0x0a>;
 					VDDA-supply = <&reg_3p3v>;
 					VDDIO-supply = <&reg_3p3v>;
-
+					clocks = <&saif0>;
 				};
 
 				eeprom: eeprom@51 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 6a8acb0..9524a05 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -837,6 +837,7 @@
 				compatible = "fsl,imx28-saif";
 				reg = <0x80042000 0x2000>;
 				interrupts = <59 80>;
+				#clock-cells = <0>;
 				clocks = <&clks 53>;
 				dmas = <&dma_apbx 4>;
 				dma-names = "rx-tx";
-- 
1.7.9.5
