From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH 2/9] ASoC: qcom: Add device tree binding docs
Date: Wed, 19 Nov 2014 10:52:42 -0800
Message-ID: <1416423169-21865-3-git-send-email-kwestfie@codeaurora.org>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add documentation to the sound directory of the
device-tree bindings for IPQ806x audio drivers.

Change-Id: I7dd08be2a68579675a6916ecb72b943dea0e352b
Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 .../bindings/sound/qcom,ipq806x-snd-card.txt       | 41 ++++++++++++++++++++++
 .../bindings/sound/qcom,lpass-cpu-dai.txt          | 20 +++++++++++
 .../devicetree/bindings/sound/qcom,lpass-lpaif.txt | 21 +++++++++++
 .../bindings/sound/qcom,lpass-pcm-mi2s.txt         | 12 +++++++
 4 files changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,ipq806x-snd-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu-dai.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-lpaif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-pcm-mi2s.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,ipq806x-snd-card.txt b/Documentation/devicetree/bindings/sound/qcom,ipq806x-snd-card.txt
new file mode 100644
index 0000000000000000000000000000000000000000..1187a7f37be3820bbd5bdf4f87ca6d37dcbe1454
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,ipq806x-snd-card.txt
@@ -0,0 +1,41 @@
+* Qualcomm Technologies IPQ806x SoundCard
+
+This node models the Qualcomm Technologies IPQ806x LPASS Audio SoundCard,
+with a connection between the CPU MI2S DAI and the external DAC.
+
+Required properties:
+- compatible        : "qcom,ipq806x-snd-card"
+- qcom,model        : The user-visible name of this sound card
+- pinctrl-0         : The default state of the MI2S pins
+- pinctrl-names     : The name of the default state
+- dac-gpios         : GPIO specifier to the GPIO -> DAC SDMODE pin
+- clocks            : A list of clock specifiers in the following order:
+                        * AHBIX bus clock
+- clock-names       : A list of names in the following order:
+                        * ahbix_clk
+asoc-platform       : This is phandle list containing the references to platform device
+                      nodes that are used as part of the sound card dai-links.
+asoc-platform-names : This property contains list of platform names. The order of
+                      the platform names should match to that of the phandle order
+                      given in "asoc-platform".
+asoc-cpu            : This is phandle list containing the references to cpu dai device nodes
+                      that are used as part of the sound card dai-links.
+asoc-cpu-names      : This property contains list of cpu dai names. The order of the
+                      cpu dai names should match to that of the phandle order given
+                      in "asoc-cpu".
+
+Example:
+
+sound {
+	compatible = "qcom,ipq806x-snd-card";
+	model = "ipq806x-snd-card";
+	pinctrl-0 = <&mi2s_pins>;
+	pinctrl-names = "default";
+	dac-gpios = <&qcom_pinmux 25 0>;
+	clocks = <&lcc AHBIX_CLK>;
+	clock-names = "ahbix_clk";
+	asoc-platform = <&pcm0>;
+	asoc-platform-names = "lpass-pcm-mi2s";
+	asoc-cpu = <&dai_mi2s>;
+	asoc-cpu-names = "lpass-cpu-dai";
+};
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu-dai.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu-dai.txt
new file mode 100644
index 0000000000000000000000000000000000000000..8b700c9727fef9969af810376071d2e390625fac
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu-dai.txt
@@ -0,0 +1,20 @@
+* Qualcomm Technologies IPQ806x LPASS DAI
+
+This node models the Qualcomm Technologies IPQ806x LPASS I2S DAI port.
+
+Required properties:
+- compatible  : "qcom,lpass-cpu-dai"
+- clocks      : A list of clock specifiers in the following order:
+                        * MI2S OSR clock
+                        * MI2S Bit clock
+- clock-names : A list of names in the following order:
+                        * mi2s_osr_clk
+                        * mi2s_bit_clk
+
+Example:
+
+lpass-cpu-dai {
+	compatible = "qcom,lpass-cpu-dai";
+	clocks = <&lcc MI2S_OSR_CLK>, <&lcc MI2S_BIT_CLK>;
+	clock-names = "mi2s_osr_clk", "mi2s_bit_clk";
+};
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-lpaif.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-lpaif.txt
new file mode 100644
index 0000000000000000000000000000000000000000..d4feebb81aa9faebe2352a72e02a21dffc2ab331
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-lpaif.txt
@@ -0,0 +1,21 @@
+* Qualcomm Technologies IPQ806x LPASS driver
+
+This node models the Qualcomm Technologies IPQ806x LPASS Audio driver,
+which controls the various components within the subsystem.
+
+Required properties:
+- compatible      : "qcom,lpass-lpaif"
+- reg             : Address space for the LPASS subsystem registers
+- reg-names       : The name of the LPASS subsystem register address space
+- interrupts      : Phandle to the LPASS interrupt
+- interrupt-names : The names of the LPASS interrupt
+
+Example:
+
+lpass-lpaif"
+	compatible = "qcom,lpass-lpaif";
+	reg = <0x28100000 0x10000>;
+	reg-names = "lpass-lpaif-mem";
+	interrupts = <0 85 1>;
+	interrupt-names = "lpass-lpaif-irq";
+};
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-pcm-mi2s.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-pcm-mi2s.txt
new file mode 100644
index 0000000000000000000000000000000000000000..d2ff501d44f7b7aa790cdadc8ba75c6a8bf37ccd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-pcm-mi2s.txt
@@ -0,0 +1,12 @@
+* Qualcomm Technologies IPQ806x PCM audio interface
+
+This node models the Qualcomm Technologies IPQ806x PCM audio interface.
+
+Required properties:
+- compatible: "qcom,lpass-pcm-mi2s"
+
+Example:
+
+lpass-pcm-mi2s {
+	compatible = "qcom,lpass-pcm-mi2s";
+};
-- 
1.8.2.1
