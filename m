From: Katsuhiro Suzuki <suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: [PATCH v2 9/9] arm64: dts: uniphier: add compress audio out for UniPhier LD11/LD20
Date: Fri, 19 Jan 2018 18:25:36 +0900
Message-ID: <20180119092536.22501-10-suzuki.katsuhiro@socionext.com>
References: <20180119092536.22501-1-suzuki.katsuhiro@socionext.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180119092536.22501-1-suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: Masami Hiramatsu <masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Katsuhiro Suzuki <suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds compress audio node for S/PDIF on UniPhier LD11/20
global boards. And adds settings of AIO for it.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
---
 .../boot/dts/socionext/uniphier-ld11-global.dts    | 30 +++++++++++++++++++++-
 .../boot/dts/socionext/uniphier-ld20-global.dts    | 30 +++++++++++++++++++++-
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index ca09251a3eab..51cb717e5e56 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -48,7 +48,8 @@
 			dais = <&i2s_port2
 				&i2s_port3
 				&i2s_port4
-				&spdif_port0>;
+				&spdif_port0
+				&comp_spdif_port0>;
 		};
 
 		spdif-out {
@@ -61,6 +62,17 @@
 				};
 			};
 		};
+
+		comp-spdif-out {
+			compatible = "linux,spdif-dit";
+			#sound-dai-cells = <0>;
+
+			port@0 {
+				comp_spdif_tx: endpoint {
+					remote-endpoint = <&comp_spdif_hiecout1>;
+				};
+			};
+		};
 	};
 };
 
@@ -149,6 +161,22 @@
 			remote-endpoint = <&spdif_tx>;
 		};
 	};
+
+	src_port0: port@6 {
+		i2s_epcmout2: endpoint {
+		};
+	};
+
+	src_port1: port@7 {
+		i2s_epcmout3: endpoint {
+		};
+	};
+
+	comp_spdif_port0: port@8 {
+		comp_spdif_hiecout1: endpoint {
+			remote-endpoint = <&comp_spdif_tx>;
+		};
+	};
 };
 
 &evea {
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index 0728832ce552..0bda5c1382bc 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -48,7 +48,8 @@
 			dais = <&i2s_port2
 				&i2s_port3
 				&i2s_port4
-				&spdif_port0>;
+				&spdif_port0
+				&comp_spdif_port0>;
 		};
 
 		spdif-out {
@@ -61,6 +62,17 @@
 				};
 			};
 		};
+
+		comp-spdif-out {
+			compatible = "linux,spdif-dit";
+			#sound-dai-cells = <0>;
+
+			port@0 {
+				comp_spdif_tx: endpoint {
+					remote-endpoint = <&comp_spdif_hiecout1>;
+				};
+			};
+		};
 	};
 };
 
@@ -131,6 +143,22 @@
 			remote-endpoint = <&spdif_tx>;
 		};
 	};
+
+	src_port0: port@6 {
+		i2s_epcmout2: endpoint {
+		};
+	};
+
+	src_port1: port@7 {
+		i2s_epcmout3: endpoint {
+		};
+	};
+
+	comp_spdif_port0: port@8 {
+		comp_spdif_hiecout1: endpoint {
+			remote-endpoint = <&comp_spdif_tx>;
+		};
+	};
 };
 
 &evea {
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
