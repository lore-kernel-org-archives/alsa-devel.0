From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-bindings: update wcd9335 bindings."
	to the asoc tree
Date: Mon, 28 Jan 2019 18:25:07 +0000 (GMT)
Message-ID: <20190128182507.E627E1127D29@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D2785267556
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 19:25:08 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt-bindings: update wcd9335 bindings.

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

>From 262ff68fce8fe388bfa60efc95e394cf0a149563 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 28 Jan 2019 14:27:46 +0000
Subject: [PATCH] ASoC: dt-bindings: update wcd9335 bindings.

This patch updates wcd9335 bindings with recommended properties.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/qcom,wcd9335.txt         | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
index 1d8d49e30af7..5d6ea66a863f 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
@@ -34,12 +34,12 @@ Required properties with SLIMbus Interface:
 	Definition: Interrupt names of WCD INTR1 and INTR2
 	Should be: "intr1", "intr2"
 
-- reset-gpio:
+- reset-gpios:
 	Usage: required
 	Value type: <String Array>
 	Definition: Reset gpio line
 
-- qcom,ifd:
+- slim-ifc-dev:
 	Usage: required
 	Value type: <phandle>
 	Definition: SLIM interface device
@@ -104,13 +104,13 @@ Required properties with SLIMbus Interface:
 	Value type: <u32>
 	Definition: Must be 1
 
-codec@1{
+audio-codec@1{
 	compatible = "slim217,1a0";
 	reg  = <1 0>;
 	interrupts = <&msmgpio 54 IRQ_TYPE_LEVEL_HIGH>;
 	interrupt-names = "intr2"
-	reset-gpio = <&msmgpio 64 0>;
-	qcom,ifd  = <&wc9335_ifd>;
+	reset-gpios = <&msmgpio 64 0>;
+	slim-ifc-dev  = <&wc9335_ifd>;
 	clock-names = "mclk", "native";
 	clocks = <&rpmcc RPM_SMD_DIV_CLK1>,
 		 <&rpmcc RPM_SMD_BB_CLK1>;
-- 
2.20.1
