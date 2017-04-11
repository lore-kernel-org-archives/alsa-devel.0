From: olivier moysan <olivier.moysan@st.com>
Subject: [PATCH v4 1/2] ASoC: stm32: add bindings for SAI
Date: Tue, 11 Apr 2017 17:47:25 +0200
Message-ID: <1491925646-29113-2-git-send-email-olivier.moysan@st.com>
References: <1491925646-29113-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 3C29C2666E1
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 17:47:32 +0200 (CEST)
In-Reply-To: <1491925646-29113-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

This patch adds documentation of device tree bindings for the
STM32 SAI ASoC driver.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 .../devicetree/bindings/sound/st,stm32-sai.txt     | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
new file mode 100644
index 0000000..c59a3d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -0,0 +1,89 @@
+STMicroelectronics STM32 Serial Audio Interface (SAI).
+
+The SAI interface (Serial Audio Interface) offers a wide set of audio protocols
+as I2S standards, LSB or MSB-justified, PCM/DSP, TDM, and AC'97.
+The SAI contains two independent audio sub-blocks. Each sub-block has
+its own clock generator and I/O lines controller.
+
+Required properties:
+  - compatible: Should be "st,stm32f4-sai"
+  - reg: Base address and size of SAI common register set.
+  - clocks: Must contain phandle and clock specifier pairs for each entry
+	in clock-names.
+  - clock-names: Must contain "x8k" and "x11k"
+	"x8k": SAI parent clock for sampling rates multiple of 8kHz.
+	"x11k": SAI parent clock for sampling rates multiple of 11.025kHz.
+  - interrupts: cpu DAI interrupt line shared by SAI sub-blocks
+
+Optional properties:
+  - resets: Reference to a reset controller asserting the SAI
+
+SAI subnodes:
+Two subnodes corresponding to SAI sub-block instances A et B can be defined.
+Subnode can be omitted for unsused sub-block.
+
+SAI subnodes required properties:
+  - compatible: Should be "st,stm32-sai-sub-a" or "st,stm32-sai-sub-b"
+	for SAI sub-block A or B respectively.
+  - reg: Base address and size of SAI sub-block register set.
+  - clocks: Must contain one phandle and clock specifier pair
+	for sai_ck which feeds the internal clock generator.
+  - clock-names: Must contain "sai_ck".
+  - dmas: see Documentation/devicetree/bindings/dma/stm32-dma.txt
+  - dma-names: identifier string for each DMA request line
+	"tx": if sai sub-block is configured as playback DAI
+	"rx": if sai sub-block is configured as capture DAI
+  - pinctrl-names: should contain only value "default"
+  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
+
+Example:
+sound_card {
+	compatible = "audio-graph-card";
+	dais = <&sai1b_port>;
+};
+
+sai1: sai1@40015800 {
+	compatible = "st,stm32f4-sai";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+	reg = <0x40015800 0x4>;
+	clocks = <&rcc 1 CLK_SAIQ_PDIV>, <&rcc 1 CLK_I2SQ_PDIV>;
+	clock-names = "x8k", "x11k";
+	interrupts = <87>;
+
+	sai1b: audio-controller@40015824 {
+		#sound-dai-cells = <0>;
+		compatible = "st,stm32-sai-sub-b";
+		reg = <0x40015824 0x1C>;
+		clocks = <&rcc 1 CLK_SAI2>;
+		clock-names = "sai_ck";
+		dmas = <&dma2 5 0 0x400 0x0>;
+		dma-names = "tx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sai1b>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sai1b_port: port@0 {
+				reg = <0>;
+				cpu_endpoint: endpoint {
+					remote-endpoint = <&codec_endpoint>;
+					audio-graph-card,format = "i2s";
+					audio-graph-card,bitclock-master = <&codec_endpoint>;
+					audio-graph-card,frame-master = <&codec_endpoint>;
+				};
+			};
+		};
+	};
+};
+
+audio-codec {
+	codec_port: port {
+		codec_endpoint: endpoint {
+			remote-endpoint = <&cpu_endpoint>;
+		};
+	};
+};
-- 
1.9.1
