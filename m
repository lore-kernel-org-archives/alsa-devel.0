From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH 1/2] ASoC: qcom: Change qcom,adsp in LPASS CPU bindings
Date: Fri, 13 Mar 2015 00:54:16 -0700
Message-ID: <1426233257-27532-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kumar Gala <galak@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Change the representation of the audio DSP, in the
LPASS CPU bindings description, from a required
subnode to an optional phandle.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
---
 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
index e7c6e9321863f022ebf0d51b75d7bb83c10b9062..e00732dac9393e95f0530505c9f38127f58980a3 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
@@ -22,13 +22,9 @@ Required properties:
 - reg-names		: A list which must include the following entries:
 				* "lpass-lpaif"
 
-Required subnodes:
+Optional properties:
 
-- qcom,adsp		: Audio DSP sub-node
-
-Optional Audio DSP subnode properties:
-
-- status		: "disabled" indicates the adsp is not available.
+- qcom,adsp		: Phandle for the audio DSP node
 
 Example:
 
@@ -43,7 +39,5 @@ lpass@28100000 {
 	pinctrl-1 = <&mi2s_idle>;
 	reg = <0x28100000 0x10000>;
 	reg-names = "lpass-lpaif";
-	qcom,adsp {
-		status = "disabled";
-	};
+	qcom,adsp = <&adsp>;
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
