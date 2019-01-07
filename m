From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: ASoC: xlnx,
	audio-formatter: Document audio formatter bindings" to the asoc tree
Date: Mon,  7 Jan 2019 12:31:30 +0000 (GMT)
Message-ID: <20190107123130.14F311127490@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D566B267D28
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 13:31:30 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   dt-bindings: ASoC: xlnx, audio-formatter: Document audio formatter bindings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e3e12ec09a18ad779b637f4a006a908cb6045aa7 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Date: Fri, 21 Dec 2018 14:27:27 +0530
Subject: [PATCH] dt-bindings: ASoC: xlnx, audio-formatter: Document audio
 formatter bindings

Added documentation for audio formatter IP core DT bindings.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/xlnx,audio-formatter.txt   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt

diff --git a/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
new file mode 100644
index 000000000000..cbc93c8f4963
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
2.20.1
