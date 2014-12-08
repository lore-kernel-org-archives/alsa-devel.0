From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch v2 02/11] ASoC: qcom: Add device tree binding docs
Date: Mon,  8 Dec 2014 14:01:04 -0800
Message-ID: <1418076073-12623-3-git-send-email-kwestfie@codeaurora.org>
References: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add documentation to the sound directory of the
device-tree bindings for IPQ806x audio drivers.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 .../bindings/sound/qcom,ipq806x-snd-card.txt       | 25 +++++++++++++++++
 .../bindings/sound/qcom,lpass-cpu-dai.txt          | 32 ++++++++++++++++++++++
 .../bindings/sound/qcom,lpass-pcm-mi2s.txt         | 12 ++++++++
 .../bindings/sound/qcom,max98357a-codec.txt        | 23 ++++++++++++++++
 4 files changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,ipq806x-snd-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu-dai.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-pcm-mi2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,max98357a-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,ipq806x-snd-card.txt b/Documentation/devicetree/bindings/sound/qcom,ipq806x-snd-card.txt
new file mode 100644
index 0000000000000000000000000000000000000000..10178737b4bdc6108475f48726bdbf40b6b044b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,ipq806x-snd-card.txt
@@ -0,0 +1,25 @@
+* Qualcomm Technologies IPQ806x SoundCard
+
+This node models the Qualcomm Technologies IPQ806x LPASS Audio SoundCard,
+with a connection between the CPU MI2S DAI and the external DAC.
+
+Required properties:
+- compatible : "qcom,ipq806x-snd-card"
+- qcom,model : The user-visible name of this sound card
+			* <any string is valid>
+- platform   : This is a phandle reference to platform device driver node (for the soundcard dai-link)
+- cpu        : This is a phandle reference to CPU DAI device driver node (for the soundcard dai-link)
+- codec      : This is a phandle reference to codec DAI device driver node (for the soundcard dai-link)
+- codec-dai  : This is a string that names the codec DAI device (for the soundcard dai-link)
+			* max98357a-codec-dai
+
+Example:
+
+sound {
+	compatible = "qcom,ipq806x-snd-card";
+	model = "ipq806x-snd-card";
+	platform = <&lpass_pcm_mi2s>;
+	cpu = <&lpass_cpu_mi2s>;
+	codec = <&max98357a_codec>;
+	codec-dai = "max98357a-codec-dai";
+};
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu-dai.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu-dai.txt
new file mode 100644
index 0000000000000000000000000000000000000000..ee94af49f90aedb0889f1ddf043780a80e585f62
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu-dai.txt
@@ -0,0 +1,32 @@
+* Qualcomm Technologies IPQ806x LPASS DAI
+
+This node models the Qualcomm Technologies IPQ806x LPASS MI2S DAI port.
+
+Required properties:
+- compatible      : "qcom,lpass-cpu-mi2s"
+- reg             : Address space for the LPASS audio interface registers
+- reg-names       : The name of the LPASS audio interface register address space
+			* lpass-lpaif-mem
+- clocks          : A list of clock specifiers for the audio interface
+			* AHBIX bus clock
+			* MI2S OSR clock
+			* MI2S Bit clock
+- clock-names     : A list of audio interface clock names
+			* ahbix_clk
+			* mi2s_osr_clk
+			* mi2s_bit_clk
+- interrupts      : Phandle to the LPASS audio interface interrupt
+- interrupt-names : The name of the LPASS audio interface interrupt
+			* lpass-lpaif-irq
+
+Example:
+
+lpass-cpu-mi2s {
+	compatible = "qcom,lpass-cpu-dai";
+	reg = <0x28100000 0x10000>;
+	reg-names = "lpass-lpaif-mem";
+	clocks = <&lcc AHBIX_CLK>, <&lcc MI2S_OSR_CLK>, <&lcc MI2S_BIT_CLK>;
+	clock-names = "ahbix_clk", "mi2s_osr_clk", "mi2s_bit_clk";
+	interrupts = <0 85 1>;
+	interrupt-names = "lpass-lpaif-irq";
+};
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-pcm-mi2s.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-pcm-mi2s.txt
new file mode 100644
index 0000000000000000000000000000000000000000..09c04b7f37b51076860f1df10114e0a47b921404
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-pcm-mi2s.txt
@@ -0,0 +1,12 @@
+* Qualcomm Technologies IPQ806x PCM audio interface
+
+This node models the Qualcomm Technologies IPQ806x PCM audio interface.
+
+Required properties:
+- compatible : "qcom,lpass-pcm-mi2s"
+
+Example:
+
+lpass-pcm-mi2s {
+	compatible = "qcom,lpass-pcm-mi2s";
+};
diff --git a/Documentation/devicetree/bindings/sound/qcom,max98357a-codec.txt b/Documentation/devicetree/bindings/sound/qcom,max98357a-codec.txt
new file mode 100644
index 0000000000000000000000000000000000000000..14bc14b1049f4138123db8fd17e8926545cbb218
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,max98357a-codec.txt
@@ -0,0 +1,23 @@
+* Maxim MAX98357A DAC
+
+This node models the Maxim MAX98357A DAC as a codec DAI.
+This is for audio on the Qualcomm IPQ806x SOC.
+
+Required properties:
+- compatible    : "qcom,max98357a-codec"
+- dac-gpios     : Phandle to the GPIO specifier for the GPIO -> DAC SDMODE pin
+- pinctrl-names : A list of names indicating the state of the MI2S pins
+			* mi2s-disabled
+			* mi2s-enabled
+- pinctrl-0     : The disabled state of the MI2S pins
+- pinctrl-1     : The enabled state of the MI2S pins
+
+Example:
+
+max98357a-codec {
+	compatible = "qcom,max98357a-codec";
+	dac-gpios = <&qcom_pinmux 25 0>;
+	pinctrl-names = "mi2s-disabled", "mi2s_enabled";
+	pinctrl-0 = <&mi2s_disabled>;
+	pinctrl-1 = <&mi2s_enabled>;
+};
-- 
1.8.2.1
