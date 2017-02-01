From: olivier moysan <olivier.moysan@st.com>
Subject: [PATCH 1/2] ASoC: stm32: add bindings for SAI
Date: Wed, 1 Feb 2017 17:16:16 +0100
Message-ID: <1485965777-22302-2-git-send-email-olivier.moysan@st.com>
References: <1485965777-22302-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C31F2674B3
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2017 17:16:39 +0100 (CET)
In-Reply-To: <1485965777-22302-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com
List-Id: alsa-devel@alsa-project.org

This patch adds documentation of device tree bindings for the
STM32 SAI ASoC driver.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 .../devicetree/bindings/sound/st,stm32-sai.txt     | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
new file mode 100644
index 0000000..b3be26d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -0,0 +1,79 @@
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
+  - clock-names: Must contain "clk_x8k" and "clk_x11k"
+	"clk_x8k": SAI parent clock for sampling rates multiple of 8kHz.
+	"clk_x11k": SAI parent clock for sampling rates multiple of 11.025kHz.
+  - interrupts: cpu DAI interrupt line shared by SAI sub-blocks
+
+Note: Each SAI controller should have an alias correctly numbered
+in "aliases" node, to provide explicit name to CPU DAI.
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
+sai1: sai1@40015800 {
+	compatible = "st,stm32f4-sai";
+	reg = <0x40015800 0x400>;
+	clocks = <&rcc 1 CLK_SAIQ_PDIV>, <&rcc 1 CLK_I2SQ_PDIV>;
+	clock-names = "clk_x8k", "clk_x11k";
+	interrupts = <87>;
+	resets = <&rcc 310>;
+
+	sai1b: sai@1 {
+		#sound-dai-cells = <0>;
+		compatible = "st,stm32-sai-sub-b";
+		clocks = <&rcc 1 CLK_SAI2>;
+		clock-names = "sai_ck";
+		dmas = <&dma2 5 0 0x400 0x1>;
+		dma-names = "tx";
+	};
+};
+
+sound {
+	compatible = "simple-audio-card";
+	simple-audio-card,name = "STM32-Sound-Card";
+	status = "okay";
+
+	simple-audio-card,dai-link@0 {
+		format = "i2s";
+		cpu {
+			sound-dai = <&sai1b>;
+		};
+		codec {
+			sound-dai = <&codec>;
+		};
+	};
+};
+
+aliases {
+	sai1 = &sai1;
+};
-- 
1.9.1
