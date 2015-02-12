From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V5 03/12] ASoC: qcom: Document LPASS CPU bindings
Date: Wed, 11 Feb 2015 18:10:06 -0800
Message-ID: <1423707015-14527-4-git-send-email-kwestfie@codeaurora.org>
References: <1423707015-14527-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1423707015-14527-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add documentation to the sound directory of the
device-tree bindings for the IPQ806x LPASS CPU DAI
device.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,lpass-cpu.txt   | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
new file mode 100644
index 0000000000000000000000000000000000000000..621773d1c64af8f4f9eaceb2f7d2d7ec17c66aeb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
@@ -0,0 +1,38 @@
+* Qualcomm Technologies LPASS CPU DAI
+
+This node models the Qualcomm Technologies Low-Power Audio SubSystem.
+
+Required properties:
+
+- compatible		: "qcom,lpass-cpu"
+- clocks		: Must contain an entry for each entry in clock-names.
+- clock-names		: A list which must include the following entries:
+				* "ahbix-clk"
+				* "mi2s-osr-clk"
+				* "mi2s-bit-clk"
+- interrupts		: Must contain an entry for each entry in
+			  interrupt-names.
+- interrupt-names	: A list which must include the following entries:
+				* "lpass-irq-lpaif"
+- pinctrl-N		: One property must exist for each entry in
+			  pinctrl-names.  See ../pinctrl/pinctrl-bindings.txt
+			  for details of the property values.
+- pinctrl-names		: Must contain a "default" entry.
+- reg			: Must contain an address for each entry in reg-names.
+- reg-names		: A list which must include the following entries:
+				* "lpass-lpaif"
+
+Example:
+
+lpass@28100000 {
+	compatible = "qcom,lpass-cpu";
+	clocks = <&lcc AHBIX_CLK>, <&lcc MI2S_OSR_CLK>, <&lcc MI2S_BIT_CLK>;
+	clock-names = "ahbix-clk", "mi2s-osr-clk", "mi2s-bit-clk";
+	interrupts = <0 85 1>;
+	interrupt-names = "lpass-irq-lpaif";
+	pinctrl-names = "default", "idle";
+	pinctrl-0 = <&mi2s_default>;
+	pinctrl-1 = <&mi2s_idle>;
+	reg = <0x28100000 0x10000>;
+	reg-names = "lpass-lpaif";
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
