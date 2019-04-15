From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Document r8a77470 bindings" to
	the asoc tree
Date: Mon, 15 Apr 2019 09:53:30 +0100 (BST)
Message-ID: <20190415085330.7C14B1127A64@debutante.sirena.org.uk>
References: <1554969262-15028-17-git-send-email-cv-dong@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C493CF80CAB
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2019 10:53:36 +0200 (CEST)
In-Reply-To: <1554969262-15028-17-git-send-email-cv-dong@jinso.co.jp>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: cv-dong@jinso.co.jp, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, geert+renesas@glider.be, yoshihiro.shimoda.uh@renesas.com, biju.das@bp.renesas.com, linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>, na-hoan@jinso.co.jp, horms+renesas@verge.net.au, h-inayoshi@jinso.co.jp, nv-dung@jinso.co.jp
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Document r8a77470 bindings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From d1d58766908aad18b1f967fc107702959da84f2b Mon Sep 17 00:00:00 2001
From: Cao Van Dong <cv-dong@jinso.co.jp>
Date: Thu, 11 Apr 2019 16:54:18 +0900
Subject: [PATCH] ASoC: rsnd: Document r8a77470 bindings

Document SoC specific bindings for R-Car RZ/G1C(r8a77470) SoC.

Signed-off-by: Cao Van Dong <cv-dong@jinso.co.jp>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index b34afa66fb00..5c52182f7dcf 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -266,6 +266,7 @@ Required properties:
 				    - "renesas,rcar_sound-r8a7743" (RZ/G1M)
 				    - "renesas,rcar_sound-r8a7744" (RZ/G1N)
 				    - "renesas,rcar_sound-r8a7745" (RZ/G1E)
+				    - "renesas,rcar_sound-r8a77470" (RZ/G1C)
 				    - "renesas,rcar_sound-r8a774a1" (RZ/G2M)
 				    - "renesas,rcar_sound-r8a774c0" (RZ/G2E)
 				    - "renesas,rcar_sound-r8a7778" (R-Car M1A)
-- 
2.20.1
