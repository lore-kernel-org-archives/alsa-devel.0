From: Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH v2] ASoC: rsnd: Add device tree support for r8a774[35]
Date: Wed, 13 Dec 2017 13:35:58 +0000
Message-ID: <1513172158-60367-1-git-send-email-biju.das@bp.renesas.com>
References: <1513102155-47925-1-git-send-email-biju.das@bp.renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513102155-47925-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, alsa-devel@alsa-project.org, linux-renesas-soc@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>
List-Id: alsa-devel@alsa-project.org

Document r8a774[35] specific compatible strings. The Renesas RZ/G1[ME]
(r8a774[35]) sound modules are identical to the R-Car Gen2 family.
No driver change is needed as the fallback compatible string
"renesas,rcar_sound-gen2" activates the right code in the driver.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
v1-->v2
     Updated the subject line.

 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 085bec3..b3c28bd 100644
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
1.9.1
