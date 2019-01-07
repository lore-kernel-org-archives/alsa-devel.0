From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: ASoC: xlnx,
 spdif: Document spdif bindings" to the asoc tree
Date: Mon,  7 Jan 2019 18:57:47 +0000 (GMT)
Message-ID: <20190107185747.6B9541127491@debutante.sirena.org.uk>
References: <1546538993-55473-2-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1546538993-55473-2-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, Michal Simek <michal.simek@xilinx.com>, Vishal Sagar <vsagar@xilinx.com>
List-Id: alsa-devel@alsa-project.org

The patch

   dt-bindings: ASoC: xlnx, spdif: Document spdif bindings

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

>From 2f00f7715e624d04e25d9cb8bb0f53884d3bcb59 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Date: Thu, 3 Jan 2019 23:39:51 +0530
Subject: [PATCH] dt-bindings: ASoC: xlnx, spdif: Document spdif bindings

Added documentation for SPDIF IP DT bindings.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/xlnx,spdif.txt  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/xlnx,spdif.txt b/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
new file mode 100644
index 000000000000..15c2d64d247c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
@@ -0,0 +1,28 @@
+Device-Tree bindings for Xilinx SPDIF IP
+
+The IP supports playback and capture of SPDIF audio
+
+Required properties:
+ - compatible: "xlnx,spdif-2.0"
+ - clock-names: List of input clocks.
+   Required elements: "s_axi_aclk", "aud_clk_i"
+ - clocks: Input clock specifier. Refer to common clock bindings.
+ - reg: Base address and address length of the IP core instance.
+ - interrupts-parent: Phandle for interrupt controller.
+ - interrupts: List of Interrupt numbers.
+ - xlnx,spdif-mode: 0 :- receiver mode
+		    1 :- transmitter mode
+ - xlnx,aud_clk_i: input audio clock value.
+
+Example:
+	spdif_0: spdif@80010000 {
+		clock-names = "aud_clk_i", "s_axi_aclk";
+		clocks = <&misc_clk_0>, <&clk 71>;
+		compatible = "xlnx,spdif-2.0";
+		interrupt-names = "spdif_interrupt";
+		interrupt-parent = <&gic>;
+		interrupts = <0 91 4>;
+		reg = <0x0 0x80010000 0x0 0x10000>;
+		xlnx,spdif-mode = <1>;
+		xlnx,aud_clk_i = <49152913>;
+	};
-- 
2.20.1
