From: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH v8 12/13] ASoC: add bindings for stm32 DFSDM filter
Date: Mon, 11 Dec 2017 11:18:43 +0100
Message-ID: <1512987524-2901-13-git-send-email-arnaud.pouliquen@st.com>
References: <1512987524-2901-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512987524-2901-1-git-send-email-arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Add bindings that describes audio settings to support
Digital Filter for pulse density modulation(PDM) microphone.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/sound/st,stm32-adfsdm.txt  | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
new file mode 100644
index 0000000..864f5b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
@@ -0,0 +1,63 @@
+STMicroelectronics Audio Digital Filter Sigma Delta modulators(DFSDM)
+
+The DFSDM allows PDM microphones capture through SPI interface. The Audio
+interface is seems as a sub block of the DFSDM device.
+For details on DFSDM bindings refer to ../iio/adc/st,stm32-dfsdm-adc.txt
+
+Required properties:
+  - compatible: "st,stm32h7-dfsdm-dai".
+
+  - #sound-dai-cells : Must be equal to 0
+
+  - io-channels : phandle to iio dfsdm instance node.
+
+Example of a sound card using audio DFSDM node.
+
+	sound_card {
+		compatible = "audio-graph-card";
+
+		dais = <&cpu_port>;
+	};
+
+	dfsdm: dfsdm@40017000 {
+		compatible = "st,stm32h7-dfsdm";
+		reg = <0x40017000 0x400>;
+		clocks = <&rcc DFSDM1_CK>;
+		clock-names = "dfsdm";
+		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dfsdm_adc0: filter@0 {
+			compatible = "st,stm32-dfsdm-dmic";
+			reg = <0>;
+			interrupts = <110>;
+			dmas = <&dmamux1 101 0x400 0x00>;
+			dma-names = "rx";
+			st,adc-channels = <1>;
+			st,adc-channel-names = "dmic0";
+			st,adc-channel-types = "SPI_R";
+			st,adc-channel-clk-src = "CLKOUT";
+			st,filter-order = <5>;
+
+			dfsdm_dai0: dfsdm-dai {
+				compatible = "st,stm32h7-dfsdm-dai";
+				#sound-dai-cells = <0>;
+				io-channels = <&dfsdm_adc0 0>;
+				cpu_port: port {
+				dfsdm_endpoint: endpoint {
+					remote-endpoint = <&dmic0_endpoint>;
+				};
+			};
+		};
+	};
+
+	dmic0: dmic@0 {
+		compatible = "dmic-codec";
+		#sound-dai-cells = <0>;
+		port {
+			dmic0_endpoint: endpoint {
+				remote-endpoint = <&dfsdm_endpoint>;
+			};
+		};
+	};
-- 
2.7.4
