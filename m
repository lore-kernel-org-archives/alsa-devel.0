From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V4 02/10] ASoC: max98357a: Document MAX98357A bindings
Date: Thu,  5 Feb 2015 12:53:38 -0800
Message-ID: <1423169626-22166-3-git-send-email-kwestfie@codeaurora.org>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add documentation to the sound directory of the
device-tree bindings for the Maxim MAX98357A audio
DAC.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 Documentation/devicetree/bindings/sound/max98357a.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98357a.txt

diff --git a/Documentation/devicetree/bindings/sound/max98357a.txt b/Documentation/devicetree/bindings/sound/max98357a.txt
new file mode 100644
index 0000000000000000000000000000000000000000..a7a149a236e55b8372b7cb3622cd6a6c664d4e2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/max98357a.txt
@@ -0,0 +1,14 @@
+Maxim MAX98357A audio DAC
+
+This node models the Maxim MAX98357A DAC.
+
+Required properties:
+- compatible   : "maxim,max98357a"
+- sdmode-gpios : GPIO specifier for the GPIO -> DAC SDMODE pin
+
+Example:
+
+max98357a {
+	compatible = "maxim,max98357a";
+	sdmode-gpios = <&qcom_pinmux 25 0>;
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
