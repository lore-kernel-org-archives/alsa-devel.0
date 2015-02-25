From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V6 03/10] ASoC: qcom: Document Storm bindings
Date: Tue, 24 Feb 2015 22:39:38 -0800
Message-ID: <1424846385-23700-4-git-send-email-kwestfie@codeaurora.org>
References: <1424846385-23700-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424846385-23700-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
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
index 0000000000000000000000000000000000000000..2a308e9c4cd3f9550c0b7078200a14a787f02858
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
+- compatible	: "google,storm"
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
+	compatible = "google,storm";
+	qcom,model = "ipq806x-storm";
+	cpu = <&lpass_cpu>;
+	codec = <&max98357a>;
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
