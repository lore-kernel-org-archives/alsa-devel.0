From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Add device tree support for r8a774[35]" to the asoc tree
Date: Wed, 13 Dec 2017 15:46:19 +0000
Message-ID: <E1eP9Eh-0002PT-V8@debutante>
References: <1513102155-47925-1-git-send-email-biju.das@bp.renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513102155-47925-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Chris Paterson <chris.paterson2@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, alsa-devel@alsa-project.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Add device tree support for r8a774[35]

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

>From b0a858a47a7889757dbc9ac9872685955eaa5cc0 Mon Sep 17 00:00:00 2001
From: Biju Das <biju.das@bp.renesas.com>
Date: Tue, 12 Dec 2017 18:09:15 +0000
Subject: [PATCH] ASoC: rsnd: Add device tree support for r8a774[35]

Document r8a774[35] specific compatible strings. The Renesas RZ/G1[ME]
(r8a774[35]) sound modules are identical to the R-Car Gen2 family.
No driver change is needed as the fallback compatible string
"renesas,rcar_sound-gen2" activates the right code in the driver.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 085bec364caf..b3c28bdcc268 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -4,7 +4,7 @@ Renesas R-Car sound
 * Modules
 =============================================
 
-Renesas R-Car sound is constructed from below modules
+Renesas R-Car and RZ/G sound is constructed from below modules
 (for Gen2 or later)
 
  SCU		: Sampling Rate Converter Unit
@@ -334,9 +334,11 @@ Required properties:
 
 - compatible			: "renesas,rcar_sound-<soctype>", fallbacks
 				  "renesas,rcar_sound-gen1" if generation1, and
-				  "renesas,rcar_sound-gen2" if generation2
+				  "renesas,rcar_sound-gen2" if generation2 (or RZ/G1)
 				  "renesas,rcar_sound-gen3" if generation3
 				  Examples with soctypes are:
+				    - "renesas,rcar_sound-r8a7743" (RZ/G1M)
+				    - "renesas,rcar_sound-r8a7745" (RZ/G1E)
 				    - "renesas,rcar_sound-r8a7778" (R-Car M1A)
 				    - "renesas,rcar_sound-r8a7779" (R-Car H1)
 				    - "renesas,rcar_sound-r8a7790" (R-Car H2)
-- 
2.15.1
