From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Add device tree support for
	r8a77{79, 93, 94}" to the asoc tree
Date: Mon, 30 Nov 2015 12:25:28 +0000
Message-ID: <E1a3NWK-0003PF-To@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BA6C2612AF
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2015 13:25:40 +0100 (CET)
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
To: Simon Horman <horms+renesas@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Add device tree support for r8a77{79,93,94}

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 4eb404d00f58bbb2d116fdd2563dd45ff0cbdef1 Mon Sep 17 00:00:00 2001
From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 30 Nov 2015 15:02:52 +0900
Subject: [PATCH] ASoC: rsnd: Add device tree support for r8a77{79,93,94}

Simply document new compat strings.
There appears to be no need for a driver updates.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index bbcb3272977d..59cebfbd7b6a 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -7,8 +7,11 @@ Required properties:
 				  "renesas,rcar_sound-gen3" if generation3
 				  Examples with soctypes are:
 				    - "renesas,rcar_sound-r8a7778" (R-Car M1A)
+				    - "renesas,rcar_sound-r8a7779" (R-Car H1)
 				    - "renesas,rcar_sound-r8a7790" (R-Car H2)
 				    - "renesas,rcar_sound-r8a7791" (R-Car M2-W)
+				    - "renesas,rcar_sound-r8a7793" (R-Car M2-N)
+				    - "renesas,rcar_sound-r8a7794" (R-Car E2)
 				    - "renesas,rcar_sound-r8a7795" (R-Car H3)
 - reg				: Should contain the register physical address.
 				  required register is
-- 
2.6.2
