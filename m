From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rcar: ssi: don't set SSICR.CKDV = 000 with SSIWSR.CONT" to the asoc tree
Date: Fri, 24 Mar 2017 19:16:24 +0000
Message-ID: <E1crUhE-000641-Ef@debutante>
References: <87zigenerc.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87zigenerc.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rcar: ssi: don't set SSICR.CKDV = 000 with SSIWSR.CONT

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

>From 6b8530cc056efd4a11b034ca5b1e9f7e9563f553 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 22 Mar 2017 04:02:43 +0000
Subject: [PATCH] ASoC: rcar: ssi: don't set SSICR.CKDV = 000 with SSIWSR.CONT

R-Car Datasheet is indicating "SSICR.CKDV = 000 is invalid when
SSIWSR.WS_MODE = 1 or SSIWSR.CONT = 1".
Current driver will set CONT, thus, we shouldn't use CKDV = 000.
This patch fixup it.

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 411bda2387ad..135c5669f796 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -228,6 +228,15 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	for (j = 0; j < ARRAY_SIZE(ssi_clk_mul_table); j++) {
 
 		/*
+		 * It will set SSIWSR.CONT here, but SSICR.CKDV = 000
+		 * with it is not allowed. (SSIWSR.WS_MODE with
+		 * SSICR.CKDV = 000 is not allowed either).
+		 * Skip it. See SSICR.CKDV
+		 */
+		if (j == 0)
+			continue;
+
+		/*
 		 * this driver is assuming that
 		 * system word is 32bit x chan
 		 * see rsnd_ssi_init()
-- 
2.11.0
