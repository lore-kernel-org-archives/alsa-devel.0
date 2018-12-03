From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-bindings: use a generic node name for rt5631" to the asoc tree
Date: Mon,  3 Dec 2018 12:07:11 +0000 (GMT)
Message-ID: <20181203120711.92D33440080@finisterre.ee.mobilebroadband>
References: <20181203114728.636936-1-lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203114728.636936-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt-bindings: use a generic node name for rt5631

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

>From 1286f930a0d7447748b398564d14e84ea5dfe890 Mon Sep 17 00:00:00 2001
From: Lubomir Rintel <lkundrak@v3.sk>
Date: Mon, 3 Dec 2018 12:47:28 +0100
Subject: [PATCH] ASoC: dt-bindings: use a generic node name for rt5631

The example should follow the practice or using a generic node name
instead of the precise programming model, as recommended by the DTSpec.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5631.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5631.txt b/Documentation/devicetree/bindings/sound/rt5631.txt
index 92b986ca337b..56bc85232c49 100644
--- a/Documentation/devicetree/bindings/sound/rt5631.txt
+++ b/Documentation/devicetree/bindings/sound/rt5631.txt
@@ -35,14 +35,14 @@ Pins on the device (for linking into audio routes):
 
 Example:
 
-alc5631: alc5631@1a {
+alc5631: audio-codec@1a {
 	compatible = "realtek,alc5631";
 	reg = <0x1a>;
 };
 
 or
 
-rt5631: rt5631@1a {
+rt5631: audio-codec@1a {
 	compatible = "realtek,rt5631";
 	reg = <0x1a>;
 };
-- 
2.20.0.rc1
