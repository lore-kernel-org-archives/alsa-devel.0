From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7218: Correct IRQ level in DT binding example" to the asoc tree
Date: Mon, 27 Nov 2017 18:52:20 +0000
Message-ID: <E1eJOVw-0006wA-Tl@debutante>
References: <c57eabe7cd6bb5a5466c774725c5150cc33d1ab5.1510930791.git.Adam.Thomson.Opensource@diasemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c57eabe7cd6bb5a5466c774725c5150cc33d1ab5.1510930791.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7218: Correct IRQ level in DT binding example

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

>From b7926c464d6479fc62a4297ca4f48a5da5fb0988 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Fri, 17 Nov 2017 15:09:28 +0000
Subject: [PATCH] ASoC: da7218: Correct IRQ level in DT binding example

Current DT binding documentation shows an example where the IRQ
for the device is chosen to be ACTIVE_HIGH. This is incorrect as
the device only supports ACTIVE_LOW, so this commit fixes that
discrepancy.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/da7218.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/da7218.txt b/Documentation/devicetree/bindings/sound/da7218.txt
index 5ca5a709b6aa..3ab9dfef38d1 100644
--- a/Documentation/devicetree/bindings/sound/da7218.txt
+++ b/Documentation/devicetree/bindings/sound/da7218.txt
@@ -73,7 +73,7 @@ Example:
 		compatible = "dlg,da7218";
 		reg = <0x1a>;
 		interrupt-parent = <&gpio6>;
-		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
 		wakeup-source;
 
 		VDD-supply = <&reg_audio>;
-- 
2.15.0
