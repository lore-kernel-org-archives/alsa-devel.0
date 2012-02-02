From: Richard Zhao <richard.zhao@linaro.org>
Subject: [PATCH v2 4/9] ARM: dts: imx6q-sabrelite: add sgtl5000 audio codec
Date: Thu, 2 Feb 2012 10:12:03 +0800
Message-ID: <1328148728-32258-5-git-send-email-richard.zhao@linaro.org>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, eric.miao@linaro.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, linux-doc@vger.kernel.org, Richard Zhao <richard.zhao@linaro.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index cdc2ad6..3a9d32c 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -44,6 +44,18 @@
 			uart2: uart@021e8000 {
 				status = "okay";
 			};
+
+			i2c@021a0000 { /* I2C1 */
+				status = "okay";
+				clock-frequency = <100000>;
+
+				codec: sgtl5000@0a {
+					compatible = "fsl,sgtl5000";
+					reg = <0x0a>;
+					VDDA-supply = <&reg_2p5v>;
+					VDDIO-supply = <&reg_3p3v>;
+				};
+			};
 		};
 	};
 
-- 
1.7.5.4


