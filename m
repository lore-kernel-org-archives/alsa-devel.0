From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't use normal *mod in adg.c"
	to the asoc tree
Date: Tue, 01 Dec 2015 23:00:04 +0000
Message-ID: <E1a3tu0-0007F9-B4@debutante>
References: <87bnabub6c.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 10E32266176
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 00:00:09 +0100 (CET)
In-Reply-To: <87bnabub6c.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: don't use normal *mod in adg.c

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

>From 94458364304161551906d276f0164efd3dc30576 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 30 Nov 2015 08:49:15 +0000
Subject: [PATCH] ASoC: rsnd: don't use normal *mod in adg.c

adg.c is used from ssi/src/cmd. Thus don't use confusable *mod here.
This patch rename it to ssi_mod/src_mod/cmd_mod

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 448f082ab56d..6d3ef366d536 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -68,8 +68,8 @@ static u32 rsnd_adg_calculate_rbgx(unsigned long div)
 
 static u32 rsnd_adg_ssi_ws_timing_gen2(struct rsnd_dai_stream *io)
 {
-	struct rsnd_mod *mod = rsnd_io_to_mod_ssi(io);
-	int id = rsnd_mod_id(mod);
+	struct rsnd_mod *ssi_mod = rsnd_io_to_mod_ssi(io);
+	int id = rsnd_mod_id(ssi_mod);
 	int ws = id;
 
 	if (rsnd_ssi_is_pin_sharing(io)) {
@@ -90,13 +90,13 @@ static u32 rsnd_adg_ssi_ws_timing_gen2(struct rsnd_dai_stream *io)
 	return (0x6 + ws) << 8;
 }
 
-int rsnd_adg_set_cmd_timsel_gen2(struct rsnd_mod *mod,
+int rsnd_adg_set_cmd_timsel_gen2(struct rsnd_mod *cmd_mod,
 				 struct rsnd_dai_stream *io)
 {
-	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct rsnd_priv *priv = rsnd_mod_to_priv(cmd_mod);
 	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
 	struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
-	int id = rsnd_mod_id(mod);
+	int id = rsnd_mod_id(cmd_mod);
 	int shift = (id % 2) ? 16 : 0;
 	u32 mask, val;
 
@@ -275,20 +275,16 @@ static void rsnd_adg_set_ssi_clk(struct rsnd_mod *ssi_mod, u32 val)
 	}
 }
 
-int rsnd_adg_ssi_clk_stop(struct rsnd_mod *mod)
+int rsnd_adg_ssi_clk_stop(struct rsnd_mod *ssi_mod)
 {
-	/*
-	 * "mod" = "ssi" here.
-	 * we can get "ssi id" from mod
-	 */
-	rsnd_adg_set_ssi_clk(mod, 0);
+	rsnd_adg_set_ssi_clk(ssi_mod, 0);
 
 	return 0;
 }
 
-int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *mod, unsigned int rate)
+int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
 {
-	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct rsnd_priv *priv = rsnd_mod_to_priv(ssi_mod);
 	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct clk *clk;
@@ -332,14 +328,10 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *mod, unsigned int rate)
 
 found_clock:
 
-	/*
-	 * This "mod" = "ssi" here.
-	 * we can get "ssi id" from mod
-	 */
-	rsnd_adg_set_ssi_clk(mod, data);
+	rsnd_adg_set_ssi_clk(ssi_mod, data);
 
 	dev_dbg(dev, "ADG: %s[%d] selects 0x%x for %d\n",
-		rsnd_mod_name(mod), rsnd_mod_id(mod),
+		rsnd_mod_name(ssi_mod), rsnd_mod_id(ssi_mod),
 		data, rate);
 
 	return 0;
-- 
2.6.2
