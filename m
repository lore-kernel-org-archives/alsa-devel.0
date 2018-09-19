From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH] ASoC: q6afe: dt-bindings: Update input range for qcom,sd-lines
Date: Wed, 19 Sep 2018 11:41:21 +0530
Message-ID: <1537337481-2123-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Input to qcom,sd-lines should be between 0 and 3 instead of
1 to 4 as 0 corresponds to BIT(0) which is MI2S_SD0 line.
Bit 1 to 3 corresponds to SD1 to SD3 lines respectively.
Updated documentation for the same.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 Documentation/devicetree/bindings/sound/qcom,q6afe.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
index a817940..d74888b 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -49,7 +49,7 @@ configuration of each dai. Must contain the following properties.
 	Usage: required for mi2s interface
 	Value type: <prop-encoded-array>
 	Definition: Must be list of serial data lines used by this dai.
-	should be one or more of the 1-4 sd lines.
+	should be one or more of the 0-3 sd lines.
 
  - qcom,tdm-sync-mode:
 	Usage: required for tdm interface
@@ -137,42 +137,42 @@ q6afe@4 {
 
 		prim-mi2s-rx@16 {
 			reg = <16>;
-			qcom,sd-lines = <1 3>;
+			qcom,sd-lines = <0 2>;
 		};
 
 		prim-mi2s-tx@17 {
 			reg = <17>;
-			qcom,sd-lines = <2>;
+			qcom,sd-lines = <1>;
 		};
 
 		sec-mi2s-rx@18 {
 			reg = <18>;
-			qcom,sd-lines = <1 4>;
+			qcom,sd-lines = <0 3>;
 		};
 
 		sec-mi2s-tx@19 {
 			reg = <19>;
-			qcom,sd-lines = <2>;
+			qcom,sd-lines = <1>;
 		};
 
 		tert-mi2s-rx@20 {
 			reg = <20>;
-			qcom,sd-lines = <2 4>;
+			qcom,sd-lines = <1 3>;
 		};
 
 		tert-mi2s-tx@21 {
 			reg = <21>;
-			qcom,sd-lines = <1>;
+			qcom,sd-lines = <0>;
 		};
 
 		quat-mi2s-rx@22 {
 			reg = <22>;
-			qcom,sd-lines = <1>;
+			qcom,sd-lines = <0>;
 		};
 
 		quat-mi2s-tx@23 {
 			reg = <23>;
-			qcom,sd-lines = <2>;
+			qcom,sd-lines = <1>;
 		};
 	};
 };
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
