From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: set SSIWSR setting on
	rsnd_ssi_config_init()" to the asoc tree
Date: Tue, 01 Dec 2015 22:59:53 +0000
Message-ID: <E1a3ttp-0006m9-On@debutante>
References: <87wpszswfd.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EE9D264F07
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:58 +0100 (CET)
In-Reply-To: <87wpszswfd.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: set SSIWSR setting on rsnd_ssi_config_init()

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

>From 08bada26fe8089f908484a3a4580f38e78502ac7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 30 Nov 2015 08:53:04 +0000
Subject: [PATCH] ASoC: rsnd: set SSIWSR setting on rsnd_ssi_config_init()

It will have TDM settings on SSIWSR. Actually, we would like to set
it on rsnd_ssi_config_init(), but we can't. Because SSI might be used
as clock master (It doesn't need to call rsnd_ssi_config_init() when
clock master mode).
This patch adds new ssi->wsr and set it on rsnd_ssi_start().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 31e26bd481cf..d97f365f1b41 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -69,6 +69,7 @@ struct rsnd_ssi {
 	u32 cr_own;
 	u32 cr_clk;
 	u32 cr_mode;
+	u32 wsr;
 	int chan;
 	int rate;
 	int err;
@@ -214,11 +215,10 @@ static int rsnd_ssi_master_clk_start(struct rsnd_ssi *ssi,
 		if (0 == ret) {
 			ssi->cr_clk	= FORCE | SWL_32 |
 				SCKD | SWSD | CKDV(j);
+			ssi->wsr = CONT;
 
 			ssi->rate = rate;
 
-			rsnd_mod_write(mod, SSIWSR, CONT);
-
 			dev_dbg(dev, "%s[%d] outputs %u Hz\n",
 				rsnd_mod_name(mod),
 				rsnd_mod_id(mod), rate);
@@ -421,6 +421,7 @@ static int __rsnd_ssi_start(struct rsnd_mod *mod,
 		EN;
 
 	rsnd_mod_write(mod, SSICR, cr);
+	rsnd_mod_write(mod, SSIWSR, ssi->wsr);
 
 	return 0;
 }
-- 
2.6.2
