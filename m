From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v3 3/3] arm64: dts: uniphier: add compress audio out for UniPhier LD11/LD20
Date: Tue, 13 Feb 2018 22:01:56 +0900
Message-ID: <20180213130156.27827-4-suzuki.katsuhiro@socionext.com>
References: <20180213130156.27827-1-suzuki.katsuhiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180213130156.27827-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: alsa-devel@alsa-project.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org, Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
List-Id: alsa-devel@alsa-project.org

This patch adds compress audio node for S/PDIF on UniPhier LD11/20
global boards. And adds settings of AIO for it.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

---

Changes in v3:
  - Move comp-spdif-out node to root from soc node
  - Use phandle of endpoint directly instead of port node
---
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 18 +++++++++++++++++-
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 18 +++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index f057ee80f38e..875d05b1356e 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -47,7 +47,8 @@
 		dais = <&i2s_port2
 			&i2s_port3
 			&i2s_port4
-			&spdif_port0>;
+			&spdif_port0
+			&comp_spdif_port0>;
 	};
 
 	spdif-out {
@@ -60,6 +61,17 @@
 			};
 		};
 	};
+
+	comp-spdif-out {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+
+		port@0 {
+			comp_spdif_tx: endpoint {
+				remote-endpoint = <&comp_spdif_hiecout1>;
+			};
+		};
+	};
 };
 
 &serial0 {
@@ -118,3 +130,7 @@
 &spdif_hiecout1 {
 	remote-endpoint = <&spdif_tx>;
 };
+
+&comp_spdif_hiecout1 {
+	remote-endpoint = <&comp_spdif_tx>;
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index b2e197bc968c..34537f9dce82 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -47,7 +47,8 @@
 		dais = <&i2s_port2
 			&i2s_port3
 			&i2s_port4
-			&spdif_port0>;
+			&spdif_port0
+			&comp_spdif_port0>;
 	};
 
 	spdif-out {
@@ -60,6 +61,17 @@
 			};
 		};
 	};
+
+	comp-spdif-out {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+
+		port@0 {
+			comp_spdif_tx: endpoint {
+				remote-endpoint = <&comp_spdif_hiecout1>;
+			};
+		};
+	};
 };
 
 &serial0 {
@@ -100,3 +112,7 @@
 &spdif_hiecout1 {
 	remote-endpoint = <&spdif_tx>;
 };
+
+&comp_spdif_hiecout1 {
+	remote-endpoint = <&comp_spdif_tx>;
+};
-- 
2.15.1
