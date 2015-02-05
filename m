From: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [Patch V4 03/10] ASoC: qcom: Document LPASS CPU bindings
Date: Thu,  5 Feb 2015 12:53:39 -0800
Message-ID: <1423169626-22166-4-git-send-email-kwestfie@codeaurora.org>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423169626-22166-1-git-send-email-kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: ALSA Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, MSM Mailing List <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Add documentation to the sound directory of the
device-tree bindings for the IPQ806x LPASS CPU DAI
device.

Signed-off-by: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Acked-by: Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 .../devicetree/bindings/sound/qcom,lpass-cpu.txt   | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
new file mode 100644
index 0000000000000000000000000000000000000000..7406ae52aec196f136883eb01afbc6c425bdc465
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
@@ -0,0 +1,66 @@
+* Qualcomm Technologies LPASS CPU DAI
+
+This node models the Qualcomm Technologies LPASS DAI ports.
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
+				* "lpass-lpm"
+
+Optional properties:
+
+- qcom,system-clock-shift		: Add this bool property if the default
+					  frequency of the system clock needs to
+					  be reduced.
+- qcom,system-clock-shift-compare	: A numerical value used to right-shift
+					  the default system clock frequency for
+					  comparison with the target bit clock
+					  frequency.
+- qcom,system-clock-shift-amount	: A numerical value used to right-shift
+					  the default system clock frequency.
+- qcom,alternate-sysclk			: Add this bool property if the default
+					  frequency of the system clock cannot
+					  divide down to the target bit clock
+					  frequency.
+- qcom,alternate-sysclk-bitwidth	: A numerical value representing the
+					  sample bitwidth which requires use of
+					  the alternate system clock frequency.
+- qcom,alternate-sysclk-frequency	: A numerical value representing the new
+					  system clock frequency to use.
+
+Example:
+
+lpass-cpu@28100000 {
+	compatible = "qcom,lpass-cpu";
+	clocks = <&lcc AHBIX_CLK>, <&lcc MI2S_OSR_CLK>, <&lcc MI2S_BIT_CLK>;
+	clock-names = "ahbix-clk", "mi2s-osr-clk", "mi2s-bit-clk";
+	interrupts = <0 85 1>;
+	interrupt-names = "lpass-irq-lpaif";
+	pinctrl-names = "default", "idle";
+	pinctrl-0 = <&mi2s_default>;
+	pinctrl-1 = <&mi2s_idle>;
+	reg = <0x28100000 0x10000>, <0x28400000 0x4000>;
+	reg-names = "lpass-lpaif", "lpass-lpm";
+	qcom,system-clock-shift;
+	qcom,system-clock-shift-compare = <4>;
+	qcom,system-clock-shift-amount = <3>;
+	qcom,alternate-sysclk;
+	qcom,alternate-systclk-bitwidth = <24>;
+	qcom,alternate-systclk-frequency = <4608000>;
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
