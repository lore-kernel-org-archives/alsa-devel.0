From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: q6asm-dai: dt-bindings: Add support to
	compress dais" to the asoc tree
Date: Fri, 14 Dec 2018 12:44:16 +0000 (GMT)
Message-ID: <20181214124416.EB3AB11258A2@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 780CF2678D5
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:44:17 +0100 (CET)
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
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: q6asm-dai: dt-bindings: Add support to compress dais

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

>From ee23cf37fd586769febab95e2fbbbb50da5f9f2d Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 15 Nov 2018 18:13:22 +0000
Subject: [PATCH] ASoC: q6asm-dai: dt-bindings: Add support to compress dais

This patch adds board specific bindings required for dais, In particular
for compressed dais and dai direction.

Board specific setup involves setting up some of dais as compressed dais
and also specify direction of any dai. Some of the dais might only
support capture/playback depending on the board level wiring.

These two new dt properties will allow such flexibilty at board level dts.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/qcom,q6asm.txt  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
index f9c7bd8c1bc0..9f5378c51686 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
@@ -27,6 +27,28 @@ used by the apr service device.
 	Value type: <u32>
 	Definition: Must be 1
 
+== ASM DAI is subnode of "dais" and represent a dai, it includes board specific
+configuration of each dai. Must contain the following properties.
+
+- reg
+	Usage: required
+	Value type: <u32>
+	Definition: Must be dai id
+
+- direction:
+	Usage: Required for Compress offload dais
+	Value type: <u32>
+	Definition: Specifies the direction of the dai stream
+			0 for both tx and rx
+			1 for only tx (Capture/Encode)
+			2 for only rx (Playback/Decode)
+
+- is-compress-dai:
+	Usage: Required for Compress offload dais
+	Value type: <boolean>
+	Definition: present for Compress offload dais
+
+
 = EXAMPLE
 
 q6asm@7 {
@@ -35,5 +57,10 @@ q6asm@7 {
 	q6asmdai: dais {
 		compatible = "qcom,q6asm-dais";
 		#sound-dai-cells = <1>;
+		mm@0 {
+			reg = <0>;
+			direction = <2>;
+			is-compress-dai;
+		};
 	};
 };
-- 
2.19.0.rc2
