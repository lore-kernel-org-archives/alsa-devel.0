From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 13/14] ASoC: qcom: Document apq8016 bindings.
Date: Thu, 30 Apr 2015 18:18:17 +0100
Message-ID: <1430414297-11426-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch updates lpass bindings with apq8016 specific bindings.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
index e00732d..21c6483 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
@@ -4,12 +4,21 @@ This node models the Qualcomm Technologies Low-Power Audio SubSystem (LPASS).
 
 Required properties:
 
-- compatible		: "qcom,lpass-cpu"
+- compatible		: "qcom,lpass-cpu" or "qcom,apq8016-lpass-cpu"
 - clocks		: Must contain an entry for each entry in clock-names.
 - clock-names		: A list which must include the following entries:
 				* "ahbix-clk"
 				* "mi2s-osr-clk"
 				* "mi2s-bit-clk"
+			: required clocks for "qcom,lpass-cpu-apq8016"
+				* "ahbix-clk"
+				* "mi2s-bit-clk0"
+				* "mi2s-bit-clk1"
+				* "mi2s-bit-clk2"
+				* "mi2s-bit-clk3"
+				* "pcnoc-mport-clk"
+				* "pcnoc-sway-clk"
+
 - interrupts		: Must contain an entry for each entry in
 			  interrupt-names.
 - interrupt-names	: A list which must include the following entries:
@@ -22,6 +31,8 @@ Required properties:
 - reg-names		: A list which must include the following entries:
 				* "lpass-lpaif"
 
+
+
 Optional properties:
 
 - qcom,adsp		: Phandle for the audio DSP node
-- 
1.9.1
