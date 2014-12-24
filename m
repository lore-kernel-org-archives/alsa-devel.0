From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V3 02/10] ASoC: qcom: Document MAX98357A bindings
Date: Wed, 24 Dec 2014 08:42:02 -0800
Message-ID: <1419439330-2303-3-git-send-email-kwestfie@codeaurora.org>
References: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add documentation to the sound directory of the
device-tree bindings for the Maxim MAX98357A audio
codec driver.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 Documentation/devicetree/bindings/sound/max98357a.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98357a.txt

diff --git a/Documentation/devicetree/bindings/sound/max98357a.txt b/Documentation/devicetree/bindings/sound/max98357a.txt
new file mode 100644
index 0000000000000000000000000000000000000000..718e9578d42d522db15fc41a42a96eca327ac641
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/max98357a.txt
@@ -0,0 +1,14 @@
+Maxim MAX98357A audio DAC
+
+This node models the Maxim MAX98357A DAC as a codec DAI.
+
+Required properties:
+- compatible  : "maxim,max98357a"
+- sdmode-gpios: Phandle to the GPIO specifier for the GPIO -> DAC SDMODE pin
+
+Example:
+
+max98357a {
+	compatible = "maxim,max98357a";
+	sdmode-gpios = <&qcom_pinmux 25 0>;
+};
-- 
1.8.2.1
