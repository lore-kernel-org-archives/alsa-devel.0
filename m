From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Add r8a774a1 support" to the asoc
	tree
Date: Tue, 28 Aug 2018 21:28:56 +0100 (BST)
Message-ID: <20180828202856.DEDB2440078@finisterre.ee.mobilebroadband>
References: <1534869748-26661-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3361F2678C9
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 22:29:00 +0200 (CEST)
In-Reply-To: <1534869748-26661-1-git-send-email-fabrizio.castro@bp.renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms@verge.net.au>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Add r8a774a1 support

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

>From 6fbf9d8e2793b81dd5f8738999163582ce61dba7 Mon Sep 17 00:00:00 2001
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Date: Tue, 21 Aug 2018 17:42:28 +0100
Subject: [PATCH] ASoC: rsnd: Add r8a774a1 support

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 9e764270c36b..8083f0d8f263 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -340,10 +340,11 @@ Required properties:
 - compatible			: "renesas,rcar_sound-<soctype>", fallbacks
 				  "renesas,rcar_sound-gen1" if generation1, and
 				  "renesas,rcar_sound-gen2" if generation2 (or RZ/G1)
-				  "renesas,rcar_sound-gen3" if generation3
+				  "renesas,rcar_sound-gen3" if generation3 (or RZ/G2)
 				  Examples with soctypes are:
 				    - "renesas,rcar_sound-r8a7743" (RZ/G1M)
 				    - "renesas,rcar_sound-r8a7745" (RZ/G1E)
+				    - "renesas,rcar_sound-r8a774a1" (RZ/G2M)
 				    - "renesas,rcar_sound-r8a7778" (R-Car M1A)
 				    - "renesas,rcar_sound-r8a7779" (R-Car H1)
 				    - "renesas,rcar_sound-r8a7790" (R-Car H2)
-- 
2.18.0
