From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Add r8a774c0 support" to the asoc tree
Date: Fri, 14 Dec 2018 12:37:24 +0000 (GMT)
Message-ID: <20181214123724.938B911258A1@debutante.sirena.org.uk>
References: <1544732406-6408-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544732406-6408-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.orgMark Brown <broonie@kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Add r8a774c0 support

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

>From ae38d267417291db40de7439f2b0b690ab615f0e Mon Sep 17 00:00:00 2001
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Date: Thu, 13 Dec 2018 20:20:06 +0000
Subject: [PATCH] ASoC: rsnd: Add r8a774c0 support

Document RZ/G2E (R8A774C0) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 4d19d2bd6286..648d43e1b1e9 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -267,6 +267,7 @@ Required properties:
 				    - "renesas,rcar_sound-r8a7744" (RZ/G1N)
 				    - "renesas,rcar_sound-r8a7745" (RZ/G1E)
 				    - "renesas,rcar_sound-r8a774a1" (RZ/G2M)
+				    - "renesas,rcar_sound-r8a774c0" (RZ/G2E)
 				    - "renesas,rcar_sound-r8a7778" (R-Car M1A)
 				    - "renesas,rcar_sound-r8a7779" (R-Car H1)
 				    - "renesas,rcar_sound-r8a7790" (R-Car H2)
-- 
2.19.0.rc2
