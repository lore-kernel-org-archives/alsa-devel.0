From: Maruthi Srinivas Bayyavarapu
        <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: [PATCH 1/3] dt-bindings: ASoC: xlnx,audio-formatter: Document audio formatter bindings
Date: Wed, 19 Dec 2018 22:49:07 +0530
Message-ID: <1545239949-112845-2-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
References: <1545239949-112845-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545239949-112845-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vishal Sagar <vsagar@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Added documentation for audio formatter IP core DT bindings.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 .../bindings/sound/xlnx,audio-formatter.txt        | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt

diff --git a/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
new file mode 100644
index 0000000..cbc93c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
@@ -0,0 +1,29 @@
+Device-Tree bindings for Xilinx PL audio formatter
+
+The IP core supports DMA, data formatting(AES<->PCM conversion)
+of audio samples.
+
+Required properties:
+ - compatible: "xlnx,audio-formatter-1.0"
+ - interrupt-names: Names specified to list of interrupts in same
+		    order mentioned under "interrupts".
+		    List of supported interrupt names are:
+		    "irq_mm2s" : interrupt from MM2S block
+		    "irq_s2mm" : interrupt from S2MM block
+ - interrupts-parent: Phandle for interrupt controller.
+ - interrupts: List of Interrupt numbers.
+ - reg: Base address and size of the IP core instance.
+ - clock-names: List of input clocks.
+   Required elements: "s_axi_lite_aclk", "aud_mclk"
+ - clocks: Input clock specifier. Refer to common clock bindings.
+
+Example:
+	audio_ss_0_audio_formatter_0: audio_formatter@80010000 {
+		compatible = "xlnx,audio-formatter-1.0";
+		interrupt-names = "irq_mm2s", "irq_s2mm";
+		interrupt-parent = <&gic>;
+		interrupts = <0 104 4>, <0 105 4>;
+		reg = <0x0 0x80010000 0x0 0x1000>;
+		clock-names = "s_axi_lite_aclk", "aud_mclk";
+		clocks = <&clk 71>, <&clk_wiz_1 0>;
+	};
-- 
2.7.4
