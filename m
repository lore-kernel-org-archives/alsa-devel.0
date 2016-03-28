From: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 3/3 v2] arc: axs10x: Add support for Designware I2S on DT
Date: Mon, 28 Mar 2016 15:36:11 +0100
Message-ID: <02e216b1c928bd939c81067346d2807fd38bf1a5.1459174494.git.joabreu@synopsys.com>
References: <cover.1459174494.git.joabreu@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1459174494.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
In-Reply-To: <cover.1459174494.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
References: <cover.1459174494.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: airlied-cv59FeDIM0c@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, nariman-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, Maruthi.Bayyavarapu-5C7GfCeVMHo@public.gmane.org, buyitian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, yitian.bu-sf4bEIuTEZ8/jFmSBShxMA@public.gmane.org, Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Synopsys Designware ARC SDP boards support HDMI audio
output using the ADV7511 HDMI transmitter.

This patchs enables audio output using Designware I2S
driver, ALSA SoC simple audio card and ADV7511 codec.

Signed-off-by: Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
---

Changes v1 -> v2:
* This change was introduced in v2.

 arch/arc/boot/dts/axs10x_mb.dtsi | 49 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/arch/arc/boot/dts/axs10x_mb.dtsi b/arch/arc/boot/dts/axs10x_mb.dtsi
index ab5d570..fc26ede 100644
--- a/arch/arc/boot/dts/axs10x_mb.dtsi
+++ b/arch/arc/boot/dts/axs10x_mb.dtsi
@@ -138,12 +138,23 @@
 			interrupts = <14>;
 		};
 
-		i2c@0x1e000 {
-			compatible = "snps,designware-i2c";
+		i2s: i2s@1e000 {
+			compatible = "snps,designware-i2s";
 			reg = <0x1e000 0x100>;
-			clock-frequency = <400000>;
-			clocks = <&i2cclk>;
 			interrupts = <15>;
+			#sound-dai-cells = <0>;
+		};
+
+		sound {
+			compatible = "simple-audio-card";
+			simple-audio-card,name = "AXS10X HDMI Audio";
+			simple-audio-card,format = "i2s";
+			simple-audio-card,cpu {
+				sound-dai = <&i2s>;
+			};
+			simple-audio-card,codec {
+				sound-dai = <&adv7511>;
+			};
 		};
 
 		i2c@0x1f000 {
@@ -155,6 +166,36 @@
 			clocks = <&i2cclk>;
 			interrupts = <16>;
 
+			adv7511: adv7511@39 {
+				compatible = "adi,adv7511";
+				reg = <0x39>;
+				interrupts = <23>;
+				adi,input-depth = <8>;
+				adi,input-colorspace = "rgb";
+				adi,input-clock = "1x";
+				adi,clock-delay = <0x03>;
+				#sound-dai-cells = <0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					/* RGB/YUV input */
+					port@0 {
+						reg = <0>;
+						adv7511_input: endpoint {
+						};
+					};
+
+					/* HDMI output */
+					port@1 {
+						reg = <1>;
+						adv7511_output: endpoint {
+						};
+					};
+				};
+			};
+
 			eeprom@0x54{
 				compatible = "24c01";
 				reg = <0x54>;
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
