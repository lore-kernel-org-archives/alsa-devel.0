From: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v1 1/3] ASoC: zx-96p22: add documentation for zte's aud96p22  controller
Date: Wed, 15 Feb 2017 18:55:08 +0800
Message-ID: <1487156110-12840-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, nh6z-fFIq/eER6g8@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org, petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org, yesanishhere-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, xie.baoyou-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, chen.chaokai-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, wang.qiang01-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch adds dt-binding documentation for zte's aud96p22 controller.

Signed-off-by: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/sound/zte,zx-96p22.txt     | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-96p22.txt

diff --git a/Documentation/devicetree/bindings/sound/zte,zx-96p22.txt b/Documentation/devicetree/bindings/sound/zte,zx-96p22.txt
new file mode 100644
index 0000000..4184566
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/zte,zx-96p22.txt
@@ -0,0 +1,24 @@
+ZTE zx96p22 controller
+
+Required properties:
+ - compatible : Must be "zte,zx-aud96p22"
+ - #sound-dai-cells: Should be 0
+ - reg : Offset of I2C register for zx96p22
+
+Example:
+
+	audio_i2c0: audio_i2c0@1486000 {
+		compatible = "zte,zx296718-i2c";
+		reg = <0x01486000 0x1000>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&audiocrm AUDIO_I2C0_WCLK>;
+		clock-frequency = <1600000>;
+		status = "ok";
+		inner_codec: aud96p22@22 {
+			compatible = "zte,zx-aud96p22";
+			#sound-dai-cells = <0>;
+			reg = <0x22>;
+		};
+	};
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
