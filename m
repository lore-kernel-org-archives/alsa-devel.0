From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-bindings: add regulator property to
	simple amplifier" to the asoc tree
Date: Fri, 23 Nov 2018 14:14:04 +0000 (GMT)
Message-ID: <20181123141404.8D41E440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 367D62678DF
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 15:14:06 +0100 (CET)
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
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt-bindings: add regulator property to simple amplifier

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

>From 8e84de031a11c4240f3654fd4c380542e358f5f6 Mon Sep 17 00:00:00 2001
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Thu, 22 Nov 2018 18:23:20 +0800
Subject: [PATCH] ASoC: dt-bindings: add regulator property to simple amplifier

Amplifier may have associated regulator, so add a property for it.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/simple-amplifier.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-amplifier.txt b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
index 8647edae7af0..7182ac4f1e65 100644
--- a/Documentation/devicetree/bindings/sound/simple-amplifier.txt
+++ b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
@@ -4,9 +4,14 @@ Required properties:
 - compatible : "dioo,dio2125" or "simple-audio-amplifier"
 - enable-gpios : the gpio connected to the enable pin of the simple amplifier
 
+Optional properties:
+- VCC-supply   : power supply for the device, as covered
+                 in Documentation/devicetree/bindings/regulator/regulator.txt
+
 Example:
 
 amp: analog-amplifier {
 	compatible = "simple-audio-amplifier";
+	VCC-supply = <&regulator>;
 	enable-gpios = <&gpio GPIOH_3 0>;
 };
-- 
2.19.1
