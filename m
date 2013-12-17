From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv3 7/7] Documentation: Add device tree bindings for Freescale VF610 sound.
Date: Tue, 17 Dec 2013 11:24:44 +0800
Message-ID: <1387250684-23406-8-git-send-email-Li.Xiubo@freescale.com>
References: <1387250684-23406-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1387250684-23406-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, timur@tabi.org, perex@perex.cz
Cc: r64188@freescale.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, linux@arm.linux.org.uk, tiwai@suse.de, grant.likely@linaro.org, fabio.estevam@freescale.com, LW@KARO-electronics.de, oskar@scara.com, shawn.guo@linaro.org, b42378@freescale.com, b18965@freescale.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This adds the Document for Freescale VF610 sound driver under
Documentation/devicetree/bindings/sound/.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 .../bindings/sound/vf610-audio-sgt15000.txt        | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/vf610-audio-sgt15000.txt

diff --git a/Documentation/devicetree/bindings/sound/vf610-audio-sgt15000.txt b/Documentation/devicetree/bindings/sound/vf610-audio-sgt15000.txt
new file mode 100644
index 0000000..76ff838
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/vf610-audio-sgt15000.txt
@@ -0,0 +1,46 @@
+Freescale VF610 audio complex with SGTL5000 codec
+
+Required properties:
+- compatible: "fsl,vf610-sgtl5000"
+- model: The user-visible name of this sound complex.
+- saif-controllers: The phandle list of the SAI controller.
+- audio-codec: The phandle of the SGTL5000 audio codec.
+- audio-routing : A list of the connections between audio components.
+  Each entry is a pair of strings, the first being the connection's sink,
+  the second being the connection's source. Valid names could be power
+  supplies, SGTL5000 pins, and the jacks on the board:
+
+  -- Power supplies:
+     * Mic Bias
+
+  -- Board connectors:
+     * Mic Jack
+     * Line In Jack
+     * Headphone Jack
+     * Line Out Jack
+     * Ext Spk
+
+Example:
+
+sound {
+	compatible = "fsl,vf610-sgtl5000";
+	model = "vf610-sgtl5000";
+	saif-controller = <&sai2>;
+	audio-codec = <&codec>;
+	audio-routing =
+		"MIC_IN", "Mic Jack",
+		"Mic Jack", "Mic Bias",
+		"LINE_IN", "Line In Jack",
+		"Headphone Jack", "HP_OUT",
+		"Ext Spk", "LINE_OUT";
+};
+
+&i2c0 {
+	...
+
+	codec: sgtl5000@0a {
+	       compatible = "fsl,sgtl5000";
+	       reg = <0x0a>;
+	       clocks = <&clks VF610_CLK_SAI2>;
+       };
+};
-- 
1.8.4


