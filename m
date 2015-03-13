From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH V8 1/5] ASoC: qcom: Document Storm bindings
Date: Fri, 13 Mar 2015 01:01:04 -0700
Message-ID: <1426233668-30593-2-git-send-email-kwestfie@codeaurora.org>
References: <1426233668-30593-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426233668-30593-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kumar Gala <galak@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add documentation to the sound directory of the
device-tree bindings for the soundcard of the
Storm board.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 Documentation/devicetree/bindings/sound/storm.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/storm.txt

diff --git a/Documentation/devicetree/bindings/sound/storm.txt b/Documentation/devicetree/bindings/sound/storm.txt
new file mode 100644
index 0000000000000000000000000000000000000000..062a4c185fa9d06d726eccbbcf69a6e566ec0441
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/storm.txt
@@ -0,0 +1,23 @@
+* Sound complex for Storm boards
+
+Models a soundcard for Storm boards with the Qualcomm Technologies IPQ806x SOC
+connected to a MAX98357A DAC via I2S.
+
+Required properties:
+
+- compatible	: "google,storm-audio"
+- cpu		: Phandle of the CPU DAI
+- codec		: Phandle of the codec DAI
+
+Optional properties:
+
+- qcom,model	: The user-visible name of this sound card.
+
+Example:
+
+sound {
+	compatible = "google,storm-audio";
+	qcom,model = "ipq806x-storm";
+	cpu = <&lpass_cpu>;
+	codec = <&max98357a>;
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
