From: Winter Wang <wente.wang-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: modify sgtl5000 property to support non-ssi cpu-dai
Date: Mon, 29 Aug 2016 18:51:55 +0800
Message-ID: <1472467915-21317-3-git-send-email-wente.wang@nxp.com>
References: <1472467915-21317-1-git-send-email-wente.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472467915-21317-1-git-send-email-wente.wang-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

modify "ssi-controller" to "cpu-dai" as sgtl5000 can be attached
to non-ssi cpu-dai

Signed-off-by: Winter Wang <wente.wang-3arQi8VN3Tc@public.gmane.org>
---
 arch/arm/boot/dts/imx25-pdk.dts              | 2 +-
 arch/arm/boot/dts/imx51-babbage.dts          | 2 +-
 arch/arm/boot/dts/imx53-m53evk.dts           | 2 +-
 arch/arm/boot/dts/imx53-mba53.dts            | 2 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi      | 2 +-
 arch/arm/boot/dts/imx53-tx53.dtsi            | 2 +-
 arch/arm/boot/dts/imx53-voipac-bsb.dts       | 2 +-
 arch/arm/boot/dts/imx6dl-riotboard.dts       | 2 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi          | 2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts         | 2 +-
 arch/arm/boot/dts/imx6q-h100.dts             | 2 +-
 arch/arm/boot/dts/imx6q-icore-rqs.dts        | 2 +-
 arch/arm/boot/dts/imx6q-tbs2910.dts          | 2 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi        | 2 +-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi       | 2 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi        | 2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi        | 2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi        | 2 +-
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi  | 2 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi     | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi    | 2 +-
 arch/arm/boot/dts/imx6qdl-rex.dtsi           | 2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi     | 2 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi           | 2 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi     | 2 +-
 26 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 7029210..544200d 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -67,7 +67,7 @@
 		compatible = "fsl,imx25-pdk-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "imx25-pdk-sgtl5000";
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index f097b4f..39d59d3 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -144,7 +144,7 @@
 		compatible = "fsl,imx51-babbage-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "imx51-babbage-sgtl5000";
-		ssi-controller = <&ssi2>;
+		cpu-dai = <&ssi2>;
 		audio-codec = <&sgtl5000>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index dcee1e0f..78cc07d 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -99,7 +99,7 @@
 		compatible = "fsl,imx53-m53evk-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "imx53-m53evk-sgtl5000";
-		ssi-controller = <&ssi2>;
+		cpu-dai = <&ssi2>;
 		audio-codec = <&sgtl5000>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index 2e44d2a..572d86a 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -71,7 +71,7 @@
 		compatible = "tq,imx53-mba53-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "imx53-mba53-sgtl5000";
-		ssi-controller = <&ssi2>;
+		cpu-dai = <&ssi2>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index c05e7cf..17be7a1 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -119,7 +119,7 @@
 		compatible = "fsl,imx53-qsb-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "imx53-qsb-sgtl5000";
-		ssi-controller = <&ssi2>;
+		cpu-dai = <&ssi2>;
 		audio-codec = <&sgtl5000>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 57e75f1..a74f3e6 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -126,7 +126,7 @@
 	sound {
 		compatible = "karo,tx53-audio-sgtl5000", "fsl,imx-audio-sgtl5000";
 		model = "tx53-audio-sgtl5000";
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&sgtl5000>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx53-voipac-bsb.dts b/arch/arm/boot/dts/imx53-voipac-bsb.dts
index fc51b87..565a896 100644
--- a/arch/arm/boot/dts/imx53-voipac-bsb.dts
+++ b/arch/arm/boot/dts/imx53-voipac-bsb.dts
@@ -17,7 +17,7 @@
 		compatible = "fsl,imx53-voipac-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "imx53-voipac-sgtl5000";
-		ssi-controller = <&ssi2>;
+		cpu-dai = <&ssi2>;
 		audio-codec = <&sgtl5000>;
 		audio-routing =
 			"Headphone Jack", "HP_OUT";
diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index 2becd7c..a74c49c 100644
--- a/arch/arm/boot/dts/imx6dl-riotboard.dts
+++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
@@ -73,7 +73,7 @@
 	sound {
 		compatible = "fsl,imx-audio-sgtl5000";
 		model = "imx6-riotboard-sgtl5000";
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index cf3fd31..d9fd32e 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -82,7 +82,7 @@
 		compatible = "fsl,imx6q-ba16-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "imx6q-ba16-sgtl5000";
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&sgtl5000>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 0511137..39d1f1cb 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -120,7 +120,7 @@
 		compatible = "fsl,imx6q-ventana-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "sgtl5000-audio";
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx6q-h100.dts b/arch/arm/boot/dts/imx6q-h100.dts
index 65e66f9..0a6f209 100644
--- a/arch/arm/boot/dts/imx6q-h100.dts
+++ b/arch/arm/boot/dts/imx6q-h100.dts
@@ -155,7 +155,7 @@
 			"Headphone Jack", "HP_OUT";
 		mux-ext-port = <5>;
 		mux-int-port = <1>;
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6q-icore-rqs.dts b/arch/arm/boot/dts/imx6q-icore-rqs.dts
index 0053188..d34ee88 100644
--- a/arch/arm/boot/dts/imx6q-icore-rqs.dts
+++ b/arch/arm/boot/dts/imx6q-icore-rqs.dts
@@ -51,7 +51,7 @@
 	sound {
 		compatible = "fsl,imx-audio-sgtl5000";
 		model = "imx-audio-sgtl5000";
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
index d7c8ccb..65a26fe 100644
--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -122,7 +122,7 @@
 		model = "On-board Codec";
 		mux-ext-port = <3>;
 		mux-int-port = <1>;
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 	};
 
 	sound-spdif {
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 315e033f..05fdfdf 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -131,7 +131,7 @@
 	sound {
 		compatible = "fsl,imx-audio-sgtl5000";
 		model = "imx6q-apalis-sgtl5000";
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"LINE_IN", "Line In Jack",
diff --git a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
index edbce22..b69759d 100644
--- a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
@@ -143,7 +143,7 @@
 		compatible = "fsl,imx6-armadeus-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "imx6-armadeus-sgtl5000";
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 7191b84..ba43462f 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -128,7 +128,7 @@
 		compatible = "fsl,imx6q-ventana-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "sgtl5000-audio";
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 40d06b0..67c0a5c 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -129,7 +129,7 @@
 		compatible = "fsl,imx6q-ventana-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "sgtl5000-audio";
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index d6dbe2a..9f2cdc7 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -119,7 +119,7 @@
 		compatible = "fsl,imx6q-ventana-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "sgtl5000-audio";
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index d6c2358..8d88453 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -97,7 +97,7 @@
 		model = "On-board Codec";
 		mux-ext-port = <5>;
 		mux-int-port = <1>;
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 	};
 
 	sound-spdif {
diff --git a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
index cfd50ea..890fd82 100644
--- a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
@@ -193,7 +193,7 @@
 		compatible = "fsl,imx6dl-nit6xlite-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "imx6dl-nit6xlite-sgtl5000";
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index 9677bf3..93317b6 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -321,7 +321,7 @@
 		model = "imx6q-nitrogen6_max-sgtl5000";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_sgtl5000>;
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 97d9c33..9bd2a4f 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -157,7 +157,7 @@
 		compatible = "fsl,imx6q-nitrogen6x-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "imx6q-nitrogen6x-sgtl5000";
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi b/arch/arm/boot/dts/imx6qdl-rex.dtsi
index cacf593..fb93ce8 100644
--- a/arch/arm/boot/dts/imx6qdl-rex.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-rex.dtsi
@@ -71,7 +71,7 @@
 		compatible = "fsl,imx6-rex-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "imx6-rex-sgtl5000";
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index f65fdfc..422f89a49 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -143,7 +143,7 @@
 		compatible = "fsl,imx6q-sabrelite-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "imx6q-sabrelite-sgtl5000";
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index ac9529f..91d851a 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -189,7 +189,7 @@
 		model = "sgtl5000-audio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_audmux>;
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&sgtl5000>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index 3ffe00c..d823acc 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -40,7 +40,7 @@
 		compatible = "fsl,imx6-wandboard-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "imx6-wandboard-sgtl5000";
-		ssi-controller = <&ssi1>;
+		cpu-dai = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
