From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: q6afe: dt-bindings: Update input range for qcom,sd-lines" to the asoc tree
Date: Wed, 19 Sep 2018 18:53:07 +0100 (BST)
Message-ID: <20180919175307.277CC440078@finisterre.ee.mobilebroadband>
References: <1537337481-2123-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537337481-2123-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.combroonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: q6afe: dt-bindings: Update input range for qcom,sd-lines

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3a6818c771671c34b090244c92ab5aea6176d6da Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Wed, 19 Sep 2018 11:41:21 +0530
Subject: [PATCH] ASoC: q6afe: dt-bindings: Update input range for
 qcom,sd-lines

Input to qcom,sd-lines should be between 0 and 3 instead of
1 to 4 as 0 corresponds to BIT(0) which is MI2S_SD0 line.
Bit 1 to 3 corresponds to SD1 to SD3 lines respectively.
Updated documentation for the same.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/qcom,q6afe.txt   | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
index a8179409c194..d74888b9f1bb 100644
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
2.19.0
