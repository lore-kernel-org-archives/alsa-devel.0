From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 10/13] ASoC: dt-bindings: Add WCD9335 MBHC specific properties
Date: Tue,  4 Sep 2018 11:24:57 +0100
Message-ID: <20180904102500.30318-11-srinivas.kandagatla@linaro.org>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch add new bindings required to support MBHC
(Multi Button Headset Control) block in the codec.
This block is used for jack insert/removal detection,
headset type detection and 8 button press/release events.

All these properties are very much specific to board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,wcd9335.txt           | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
index 5d6ea66a863f..4d56c3ca9fa8 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
@@ -55,6 +55,26 @@ Required properties with SLIMbus Interface:
 	Value type: <string>
 	Definition: Must contain "mclk", "mclk2" and "slimbus" strings.
 
+- qcom,mbhc-vthreshold:
+	Usage: Optional, only required if headset button support required.
+	Value type: <u32 array>
+	Definition: Must contain an array of 8 threshold voltages in mV for
+		 8 buttons detection on headset.
+
+- qcom,hphl-jack-type-normally-open:
+	Usage: Optional, only required if headset button support required.
+	Value type: <boolean>
+	Definition: present if hphl pin on jack is a NO (Normally Open).
+		If not specified, then its assumed that hphl pin on jack
+		is NC (Normally Closed).
+
+- qcom,gnd-jack-type-normally-open:
+	Usage: Optional, only required if headset button support required.
+	Value type: <boolean>
+	Definition: present if gnd pin on jack is NO (Normally Open).
+		 If not specified, then its assumed that gnd pin on
+		 jack is NC  (Normally Closed).
+
 - vdd-buck-supply:
 	Usage: required
 	Value type: <phandle>
-- 
2.18.0
