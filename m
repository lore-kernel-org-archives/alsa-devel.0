From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Add device tree support for
	r8a77995" to the asoc tree
Date: Wed, 21 Nov 2018 13:30:13 +0000 (GMT)
Message-ID: <20181121133013.8B6A011250AE@debutante.sirena.org.uk>
References: <87zhu31c3r.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 13AEC267A61
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 14:30:14 +0100 (CET)
In-Reply-To: <87zhu31c3r.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, HIROYUKI YOKOYAMA <hiroyuki.yokoyama.vx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Add device tree support for r8a77995

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

>From f6c2d6026afe2f1e611bdec270e1f42af0a42f06 Mon Sep 17 00:00:00 2001
From: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Date: Wed, 21 Nov 2018 01:06:43 +0000
Subject: [PATCH] ASoC: rsnd: Add device tree support for r8a77995

Simply document new compat strings.
There appears to be no need for a driver updates.

Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 453e8ec2ac78..47dc8190f0a7 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -277,6 +277,7 @@ Required properties:
 				    - "renesas,rcar_sound-r8a7796" (R-Car M3-W)
 				    - "renesas,rcar_sound-r8a77965" (R-Car M3-N)
 				    - "renesas,rcar_sound-r8a77990" (R-Car E3)
+				    - "renesas,rcar_sound-r8a77995" (R-Car D3)
 - reg				: Should contain the register physical address.
 				  required register is
 				   SRU/ADG/SSI      if generation1
-- 
2.19.0.rc2
