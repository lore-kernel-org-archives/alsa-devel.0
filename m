From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V3 03/10] ASoC: qcom: Document LPASS CPU bindings
Date: Wed, 24 Dec 2014 08:42:03 -0800
Message-ID: <1419439330-2303-4-git-send-email-kwestfie@codeaurora.org>
References: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add documentation to the sound directory of the
device-tree bindings for the IPQ806x LPASS CPU DAI
driver.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 .../bindings/sound/qcom,lpass-cpu-mi2s.txt         | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu-mi2s.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu-mi2s.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu-mi2s.txt
new file mode 100644
index 0000000000000000000000000000000000000000..b411adffb8ce8759ba70334e30b597206735b25f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu-mi2s.txt
@@ -0,0 +1,42 @@
+* Qualcomm Technologies IPQ806x LPASS DAI
+
+This node models the Qualcomm Technologies IPQ806x LPASS MI2S DAI port.
+
+Required properties:
+- compatible: "qcom,lpass-cpu-mi2s"
+- clocks		: A list of clock specifiers for the audio interface
+				* AHBIX bus clock
+				* MI2S OSR clock
+				* MI2S Bit clock
+- clock-names		: A list of audio interface clock names
+				* ahbix_clk
+				* mi2s_osr_clk
+				* mi2s_bit_clk
+- ahbix-frequency	: Specifies AHBIX bus clock frequency
+- interrupts		: Phandle to the LPASS audio interface interrupt
+- interrupt-names	: The name of the LPASS audio interface interrupt
+				* lpass-lpaif-irq
+- pinctrl-names	: A list of names indicating the state of the MI2S pins
+				* default
+				* idle
+- pinctrl-0		: The default state of the MI2S pins
+- pinctrl-1		: The idle state of the MI2S pins
+- reg			: Address space for the LPASS audio interface registers
+- reg-names		: The name of the LPASS audio interface register address space
+				* lpass-lpaif-mem
+
+Example:
+
+lpass-cpu-mi2s {
+	compatible = "qcom,lpass-cpu-mi2s";
+	clocks = <&lcc AHBIX_CLK>, <&lcc MI2S_OSR_CLK>, <&lcc MI2S_BIT_CLK>;
+	clock-names = "ahbix_clk", "mi2s_osr_clk", "mi2s_bit_clk";
+	ahbix-clkfrq = <300000>;
+	interrupts = <0 85 1>;
+	interrupt-names = "lpass-lpaif-irq";
+	pinctrl-names = "default", "idle";
+	pinctrl-0 = <&mi2s_default>;
+	pinctrl-1 = <&mi2s_idle>;
+	reg = <0x28100000 0x10000>;
+	reg-names = "lpass-lpaif-mem";
+};
-- 
1.8.2.1
