From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: fix spelling in devicetree binding document" to the asoc tree
Date: Fri, 20 Jul 2018 13:20:01 +0100
Message-ID: <E1fgUO9-0006FG-HW@debutante>
References: <20180720075302.21079-1-marcel@ziswiler.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720075302.21079-1-marcel@ziswiler.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: fix spelling in devicetree binding document

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

>From 486c16f2b5d1eb12339fb7a020961ea1c40e619f Mon Sep 17 00:00:00 2001
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Date: Fri, 20 Jul 2018 09:53:02 +0200
Subject: [PATCH] ASoC: sgtl5000: fix spelling in devicetree binding document

This fixes a spelling mistake.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/sgtl5000.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 0f214457476f..9c58f724396a 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -17,7 +17,7 @@ Optional properties:
 
 - VDDD-supply : the regulator provider of VDDD
 
-- micbias-resistor-k-ohms : the bias resistor to be used in kOmhs
+- micbias-resistor-k-ohms : the bias resistor to be used in kOhms
 	The resistor can take values of 2k, 4k or 8k.
 	If set to 0 it will be off.
 	If this node is not mentioned or if the value is unknown, then
-- 
2.18.0
