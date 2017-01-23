From: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 6/7] ASoC: add bindings for STM32 DFSDM driver
Date: Mon, 23 Jan 2017 17:32:24 +0100
Message-ID: <1485189145-29576-7-git-send-email-arnaud.pouliquen@st.com>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485189145-29576-1-git-send-email-arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch adds documentation of device tree bindings for the
STM32 DFSDM ASoC driver.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
---
 .../devicetree/bindings/sound/st,sm32-adfsdm.txt   | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,sm32-adfsdm.txt

diff --git a/Documentation/devicetree/bindings/sound/st,sm32-adfsdm.txt b/Documentation/devicetree/bindings/sound/st,sm32-adfsdm.txt
new file mode 100644
index 0000000..a1d27b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,sm32-adfsdm.txt
@@ -0,0 +1,84 @@
+STMicroelectronics STM32 ADFSDM ASoC DAI device driver.
+
+STM32 ADFSDM ASoC is a sigma delta audio interface for digital microphone.
+It has to be declared in device-tree as a subnode of the DFSDM mfd node.
+
+It offers possibility to record several mono microphones, with an option to
+synchronize all microphones on a main one (that must be piped to filter 0)
+Audio interface can be exposed through the generic ASoC simple card.
+
+2 Dmics can be connected on one SPI interface instance n.
+Convention is that the DMIC that strobes data on rising edge is connected to the
+corresponding DFSDM channel n; while the Dmic that strobes data on falling edge
+is connected to the channel n-1. Simple card property "bitclock-inversion = <1>"
+is used to specify that microphone strobes data on falling edge.
+
+SPI interface allows to be scheduled by an external SPI clock. To use it
+simple card properties "bitclock-master = <&codec>" and "system-clock-frequency"
+have to be defined in dai-link node.
+
+Required properties:
+- compatible: 	Must be "st,stm32-dfsdm-audio",
+- reg:		Specifies the DFSDM filter instance.
+- interrupts: 	DFSDM filter instance interrupt line.
+- dma:		DMA controller phandle and DMA request line associated to the
+		filter instance ( specified by the field "reg")
+- dma-names: 	must be "rx"
+
+- st,input-id:		Id of the SPI/Manchester interface used.
+- st,dai-filter-order:  SinC filter order from 0 to 5.
+			0: FastSinC
+			[1-5]: order 1 to 5.
+			For audio purpose it is recommended to use order 3 to 5.
+
+Optional properties:
+ - st,dai0-synchronized: Set to 1 to synchronize DAI with DFSDM instance 0.
+
+Exemple of a card with 2 Dmics synchronized and connected on SPI interface 1.
+
+	dfsdm: dfsdm@4400D000 {
+		dai_dfsdm0: dfsdm-audio@0 {
+			compatible = "st,stm32-dfsdm-audio";
+			#sound-dai-cells = <0>;
+			reg = <0>;
+			dmas = <&dmamux1 101 0x400 0x00>;
+			dma-names = "rx";
+			st,input-id = <0>;
+			st,dai-filter-order = <5>;
+		};
+		dai_dfsdm1: dfsdm-audio@1 {
+			compatible = "st,stm32-dfsdm-audio";
+			#sound-dai-cells = <0>;
+			reg = <0>;
+			dmas = <&dmamux1 102 0x400 0x00>;
+			dma-names = "rx";
+			st,input-id = <0>;
+			st,dai0-synchronized = <1>;
+			st,dai-filter-order = <5>;
+		};
+	};
+	sound_dfsdm_pdm {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "dfsdm_pdm";
+		status = "okay";
+
+		dfsdm0_mic0: simple-audio-card,dai-link@0 {
+			format = "pdm";
+			cpu {
+				sound-dai = <&dai_dfsdm0>;
+			};
+			dmic0_codec: codec {
+				sound-dai = <&dmic0>;
+			};
+		};
+		dfsdm0_mic1: simple-audio-card,dai-link@1 {
+			format = "pdm";
+			bitclock-inversion = <1>;
+			cpu {
+				sound-dai = <&dai_dfsdm1>;
+			};
+			codec {
+				sound-dai = <&dmic1>;
+			};
+		};
+	};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
