From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: sound: Document jz4740-codec
	bindings" to the asoc tree
Date: Thu,  7 Feb 2019 15:22:39 +0000 (GMT)
Message-ID: <20190207152239.D68FC1127EFA@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E4E942679F0
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2019 16:22:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   dt-bindings: sound: Document jz4740-codec bindings

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

>From 7c536bade37f11833ea358fbb84aca045b157fa4 Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Thu, 7 Feb 2019 10:31:38 -0300
Subject: [PATCH] dt-bindings: sound: Document jz4740-codec bindings

Add documentation about how to probe the jz4740-codec driver from
devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/ingenic,jz4740-codec.txt   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt b/Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt
new file mode 100644
index 000000000000..1ffcade87e7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt
@@ -0,0 +1,20 @@
+Ingenic JZ4740 codec controller
+
+Required properties:
+- compatible : "ingenic,jz4740-codec"
+- reg : codec registers location and length
+- clocks : phandle to the AIC clock.
+- clock-names: must be set to "aic".
+- #sound-dai-cells: Must be set to 0.
+
+Example:
+
+codec: audio-codec@10020080 {
+	compatible = "ingenic,jz4740-codec";
+	reg = <0x10020080 0x8>;
+
+	#sound-dai-cells = <0>;
+
+	clocks = <&cgu JZ4740_CLK_AIC>;
+	clock-names = "aic";
+};
-- 
2.20.1
