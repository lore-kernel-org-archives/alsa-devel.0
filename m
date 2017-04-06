From: olivier moysan <olivier.moysan@st.com>
Subject: [PATCH 1/2] dt-bindings: Document STM32 I2S bindings
Date: Thu, 6 Apr 2017 17:40:35 +0200
Message-ID: <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 8F61F26680F
 for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2017 17:40:43 +0200 (CEST)
In-Reply-To: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Add documentation of device tree bindings for STM32 SPI/I2S.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 .../devicetree/bindings/sound/st,stm32h7-i2s.txt   | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32h7-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/st,stm32h7-i2s.txt b/Documentation/devicetree/bindings/sound/st,stm32h7-i2s.txt
new file mode 100644
index 0000000..b99467a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,stm32h7-i2s.txt
@@ -0,0 +1,71 @@
+STMicroelectronics STM32 SPI/I2S Controller
+
+The SPI/I2S block supports I2S/PCM protocols when configured on I2S mode.
+Only some SPI instances support I2S.
+
+Required properties:
+  - compatible: Must be "st,stm32h7-i2s"
+  - #sound-dai-cells: Must be 1. (one parameter)
+    This parameter allows to specify CPU DAI index in soundcard CPU dai link.
+	index 0: playback DAI
+	index 1: capture DAI
+	index 2: full duplex DAI
+  - reg: Offset and length of the device's register set.
+  - interrupts: Must contain the interrupt line id.
+  - clocks: Must contain phandle and clock specifier pairs for each entry
+	in clock-names.
+  - clock-names: Must contain "i2sclk", "pclk", "x8k" and "x11k".
+	"i2sclk": clock which feeds the internal clock generator
+	"pclk": clock which feeds the peripheral bus interface
+	"x8k": I2S parent clock for sampling rates multiple of 8kHz.
+	"x11k": I2S parent clock for sampling rates multiple of 11.025kHz.
+  - dmas: DMA specifiers for tx and rx dma.
+    See Documentation/devicetree/bindings/dma/stm32-dma.txt.
+  - dma-names: Identifier for each DMA request line. Must be "tx" and "rx".
+  - pinctrl-names: should contain only value "default"
+  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
+
+Optional properties:
+  - resets: Reference to a reset controller asserting the reset controller
+
+Example:
+sound_card {
+	compatible = "audio-graph-card";
+	dais = <&i2s2_port 0>;
+};
+
+i2s2: audio-controller@40003800 {
+	compatible = "st,stm32h7-i2s";
+	#sound-dai-cells = <1>;
+	reg = <0x40003800 0x400>;
+	interrupts = <36>;
+	clocks = <&rcc PCLK1>, <&rcc SPI2_CK>, <&rcc PLL1_Q>, <&rcc PLL2_P>;
+	clock-names = "pclk", "i2sclk",  "x8k", "x11k";
+	dmas = <&dmamux2 2 39 0x400 0x1>,
+		       <&dmamux2 3 40 0x400 0x1>;
+	dma-names = "rx", "tx";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2s2>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2s2_port: port@0 {
+			reg = <0>;
+			cpu_endpoint: endpoint {
+				remote-endpoint = <&codec_endpoint>;
+				audio-graph-card,format = "i2s";
+				audio-graph-card,bitclock-master = <&codec_endpoint>;
+				audio-graph-card,frame-master = <&codec_endpoint>;
+			};
+		};
+};
+
+audio-codec {
+		codec_port: port {
+			codec_endpoint: endpoint {
+				remote-endpoint = <&cpu_endpoint>;
+		};
+	};
+};
-- 
1.9.1
