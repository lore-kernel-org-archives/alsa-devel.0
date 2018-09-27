From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Add r8a7744 support" to the asoc
	tree
Date: Thu, 27 Sep 2018 23:39:18 +0100 (BST)
Message-ID: <20180927223918.83F5F440078@finisterre.ee.mobilebroadband>
References: <1538056285-18621-1-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FF602678CD
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2018 00:39:21 +0200 (CEST)
In-Reply-To: <1538056285-18621-1-git-send-email-biju.das@bp.renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Add r8a7744 support

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

>From 765f50d464457c6a397506b3f3dc58dacc227c6d Mon Sep 17 00:00:00 2001
From: Biju Das <biju.das@bp.renesas.com>
Date: Thu, 27 Sep 2018 14:51:25 +0100
Subject: [PATCH] ASoC: rsnd: Add r8a7744 support

Document RZ/G1N (R8A7744) SoC bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index f4688c508be6..d92b705e7917 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -343,6 +343,7 @@ Required properties:
 				  "renesas,rcar_sound-gen3" if generation3 (or RZ/G2)
 				  Examples with soctypes are:
 				    - "renesas,rcar_sound-r8a7743" (RZ/G1M)
+				    - "renesas,rcar_sound-r8a7744" (RZ/G1N)
 				    - "renesas,rcar_sound-r8a7745" (RZ/G1E)
 				    - "renesas,rcar_sound-r8a774a1" (RZ/G2M)
 				    - "renesas,rcar_sound-r8a7778" (R-Car M1A)
-- 
2.19.0
