From: Richard Zhao <richard.zhao@linaro.org>
Subject: [PATCH v2 3/9] ARM: dts: imx6q-sabrelite: add 2p5v and 3p3v regulators
Date: Thu, 2 Feb 2012 10:12:02 +0800
Message-ID: <1328148728-32258-4-git-send-email-richard.zhao@linaro.org>
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
 arch/arm/boot/dts/imx6q-sabrelite.dts |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 08d920d..cdc2ad6 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -46,4 +46,24 @@
 			};
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_2p5v: 2p5v {
+			compatible = "regulator-fixed";
+			regulator-name = "2P5V";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+			regulator-always-on;
+		};
+
+		reg_3p3v: 3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
 };
-- 
1.7.5.4


