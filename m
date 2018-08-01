From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v5 2/4] ASoC: dt-bindings: Update dt binding name for apq8096
Date: Wed,  1 Aug 2018 14:31:07 +0530
Message-ID: <1533114069-16570-3-git-send-email-rohitkr@codeaurora.org>
References: <1533114069-16570-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533114069-16570-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Remove qcom prefix from machine driver dt bindings of
apq8096 SoC.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 Documentation/devicetree/bindings/sound/qcom,apq8096.txt | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
index c7600a9..c814e86 100644
--- a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
@@ -7,7 +7,7 @@ This binding describes the APQ8096 sound card, which uses qdsp for audio.
 	Value type: <stringlist>
 	Definition: must be "qcom,apq8096-sndcard"
 
-- qcom,audio-routing:
+- audio-routing:
 	Usage: Optional
 	Value type: <stringlist>
 	Definition:  A list of the connections between audio components.
@@ -49,6 +49,12 @@ This binding describes the APQ8096 sound card, which uses qdsp for audio.
 			"DMIC1"
 			"DMIC2"
 			"DMIC3"
+
+- model:
+	Usage: required
+	Value type: <stringlist>
+	Definition: The user-visible name of this sound card.
+
 = dailinks
 Each subnode of sndcard represents either a dailink, and subnodes of each
 dailinks would be cpu/codec/platform dais.
@@ -79,11 +85,16 @@ dailinks would be cpu/codec/platform dais.
 	Value type: <phandle with arguments>
 	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
 
+Obsolete:
+	qcom,model: String for soundcard name (Use model instead)
+	qcom,audio-routing: A list of the connections between audio components.
+			    (Use audio-routing instead)
+
 Example:
 
 audio {
 	compatible = "qcom,apq8096-sndcard";
-	qcom,model = "DB820c";
+	model = "DB820c";
 
 	mm1-dai-link {
 		link-name = "MultiMedia1";
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
