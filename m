From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-bindings: Update dt binding name for
	apq8096" to the asoc tree
Date: Wed,  1 Aug 2018 12:19:02 +0100 (BST)
Message-ID: <20180801111902.EAA6F1124241@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B5962676E2
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 13:19:03 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt-bindings: Update dt binding name for apq8096

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

>From 0c901e8cea15ba1e318d8f4342f7dc27a80b5978 Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Wed, 1 Aug 2018 14:31:07 +0530
Subject: [PATCH] ASoC: dt-bindings: Update dt binding name for apq8096

Remove qcom prefix from machine driver dt bindings of
apq8096 SoC.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/qcom,apq8096.txt    | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
index aa54e49fc8a2..20bc034f6c01 100644
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
2.18.0
