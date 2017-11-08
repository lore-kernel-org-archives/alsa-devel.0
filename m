From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l56: Fix reset GPIO name in example
	DT binding" to the asoc tree
Date: Wed, 08 Nov 2017 21:43:45 +0000
Message-ID: <E1eCY8P-0006Ug-BS@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C1AA267705
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:43:48 +0100 (CET)
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
To: "Andrew F. Davis" <afd@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l56: Fix reset GPIO name in example DT binding

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

>From 8adc430603d67e76a0f8491df21654f691acda62 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Wed, 8 Nov 2017 15:24:59 -0600
Subject: [PATCH] ASoC: cs42l56: Fix reset GPIO name in example DT binding

The binding states the reset GPIO property shall be named
"cirrus,gpio-nreset" and this is what the driver looks for,
but the example uses "gpio-reset". Fix this here.

Fixes: 3bb40619aca8 ("ASoC: cs42l56: bindings: sound: Add bindings for CS42L56 CODEC")

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/cs42l56.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/cs42l56.txt b/Documentation/devicetree/bindings/sound/cs42l56.txt
index 4feb0eb27ea4..4ba520a28ae8 100644
--- a/Documentation/devicetree/bindings/sound/cs42l56.txt
+++ b/Documentation/devicetree/bindings/sound/cs42l56.txt
@@ -55,7 +55,7 @@ Example:
 codec: codec@4b {
 	compatible = "cirrus,cs42l56";
 	reg = <0x4b>;
-	gpio-reset = <&gpio 10 0>;
+	cirrus,gpio-nreset = <&gpio 10 0>;
 	cirrus,chgfreq-divisor = <0x05>;
 	cirrus.ain1_ref_cfg;
 	cirrus,micbias-lvl = <5>;
-- 
2.15.0
