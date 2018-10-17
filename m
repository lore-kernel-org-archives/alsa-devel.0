From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-binding: Add bindings for Allwinner
	A64 codec's analog path controls" to the asoc tree
Date: Wed, 17 Oct 2018 12:50:44 +0100 (BST)
Message-ID: <20181017115044.C27A111224C4@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 969182675AB
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2018 13:50:45 +0200 (CEST)
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
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt-binding: Add bindings for Allwinner A64 codec's analog path controls

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

>From af2c06c41970eb0110a03696fd7f8f07854719db Mon Sep 17 00:00:00 2001
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Wed, 17 Oct 2018 00:38:08 -0700
Subject: [PATCH] ASoC: dt-binding: Add bindings for Allwinner A64 codec's
 analog path controls

The internal codec on Allwinner A64 is split into 2 parts. The
analog path controls are routed through an embedded custom register
bus accessed through the PRCM block just as on A23/A33/H3.

Add a binding for this hardware.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/sun50i-codec-analog.txt           | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt

diff --git a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
new file mode 100644
index 000000000000..4f8ad0e04d20
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
@@ -0,0 +1,12 @@
+* Allwinner A64 Codec Analog Controls
+
+Required properties:
+- compatible: must be one of the following compatibles:
+		- "allwinner,sun50i-a64-codec-analog"
+- reg: must contain the registers location and length
+
+Example:
+	codec_analog: codec-analog@1f015c0 {
+		compatible = "allwinner,sun50i-a64-codec-analog";
+		reg = <0x01f015c0 0x4>;
+	};
-- 
2.19.0.rc2
