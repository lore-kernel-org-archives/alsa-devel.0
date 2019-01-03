From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: [PATCH 1/3] dt-bindings: ASoC: xlnx,
	spdif: Document spdif bindings
Date: Thu, 3 Jan 2019 23:39:51 +0530
Message-ID: <1546538993-55473-2-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
References: <1546538993-55473-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr780072.outbound.protection.outlook.com [40.107.78.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 18DA9267BC7
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 19:09:57 +0100 (CET)
In-Reply-To: <1546538993-55473-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vishal Sagar <vsagar@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Added documentation for SPDIF IP DT bindings.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 .../devicetree/bindings/sound/xlnx,spdif.txt       | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/xlnx,spdif.txt b/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
new file mode 100644
index 0000000..15c2d64
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
2.7.4
