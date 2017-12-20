From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup ADG register mask" to the
	asoc tree
Date: Wed, 20 Dec 2017 10:50:08 +0000
Message-ID: <E1eRbwu-0007IB-Tc@debutante>
References: <87r2rq6io9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 513F82677C7
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 11:50:15 +0100 (CET)
In-Reply-To: <87r2rq6io9.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fixup ADG register mask

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

>From d5aa24825da5711f8cb829f873160ddf1a29b19c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Dec 2017 06:11:59 +0000
Subject: [PATCH] ASoC: rsnd: fixup ADG register mask

BRGCKR should use 0x80770000, instead of 0x80FF0000.

R-Car Gen2 xxx_TIMSEL should use 0x0F1F,
R-Car Gen3 xxx_TIMSEL should use 0x1F1F.
Here, Gen3 doesn't support AVD, thus, both case can use 0x0F1F.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 8ddb08714faa..4672688cac32 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -222,7 +222,7 @@ int rsnd_adg_set_cmd_timsel_gen2(struct rsnd_mod *cmd_mod,
 				   NULL, &val, NULL);
 
 	val  = val	<< shift;
-	mask = 0xffff	<< shift;
+	mask = 0x0f1f	<< shift;
 
 	rsnd_mod_bset(adg_mod, CMDOUT_TIMSEL, mask, val);
 
@@ -250,7 +250,7 @@ int rsnd_adg_set_src_timesel_gen2(struct rsnd_mod *src_mod,
 
 	in   = in	<< shift;
 	out  = out	<< shift;
-	mask = 0xffff	<< shift;
+	mask = 0x0f1f	<< shift;
 
 	switch (id / 2) {
 	case 0:
@@ -380,7 +380,7 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
 			ckr = 0x80000000;
 	}
 
-	rsnd_mod_bset(adg_mod, BRGCKR, 0x80FF0000, adg->ckr | ckr);
+	rsnd_mod_bset(adg_mod, BRGCKR, 0x80770000, adg->ckr | ckr);
 	rsnd_mod_write(adg_mod, BRRA,  adg->rbga);
 	rsnd_mod_write(adg_mod, BRRB,  adg->rbgb);
 
-- 
2.15.1
