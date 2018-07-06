From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v3 4/5] ASoC: dt-bindings: Update dt binding
	name for apq8096
Date: Fri,  6 Jul 2018 15:13:14 +0530
Message-ID: <1530870195-13576-5-git-send-email-rohitkr@codeaurora.org>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id B5FAD2676FB
 for <alsa-devel@alsa-project.org>; Fri,  6 Jul 2018 11:43:58 +0200 (CEST)
In-Reply-To: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Remove qcom prefix from machine driver dt bindings of
apq8096 SoC.

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
