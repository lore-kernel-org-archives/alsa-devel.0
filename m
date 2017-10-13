From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: more clear ADG clock debug info"
	to the asoc tree
Date: Fri, 13 Oct 2017 18:22:34 +0100
Message-ID: <E1e33fO-0002Pr-Jy@debutante>
References: <87h8v3vbgo.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B1DC266E90
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 19:22:38 +0200 (CEST)
In-Reply-To: <87h8v3vbgo.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: more clear ADG clock debug info

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

>From 6cba3fa98cdd045e020f096bb8888225d3906895 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 13 Oct 2017 06:03:06 +0000
Subject: [PATCH] ASoC: rsnd: more clear ADG clock debug info

ADG inputs clock from CLK{A,B,C,I} and outputs clock from
CLKOUT{0,1,2,3} which is selected by BRG{A,B}.
Now, ADG is assuming BRGA is for 44100Hz related clocks,
BRGB is for 48000Hz related clocks.

Clock related debug is very difficult/confusable.
This patch cleanups clock related debug info.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 59 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 1921307780de..8ddb08714faa 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -57,6 +57,13 @@ struct rsnd_adg {
 	     i++)
 #define rsnd_priv_to_adg(priv) ((struct rsnd_adg *)(priv)->adg)
 
+static const char * const clk_name[] = {
+	[CLKA]	= "clk_a",
+	[CLKB]	= "clk_b",
+	[CLKC]	= "clk_c",
+	[CLKI]	= "clk_i",
+};
+
 static u32 rsnd_adg_calculate_rbgx(unsigned long div)
 {
 	int i, ratio;
@@ -279,6 +286,7 @@ static void rsnd_adg_set_ssi_clk(struct rsnd_mod *ssi_mod, u32 val)
 	struct rsnd_priv *priv = rsnd_mod_to_priv(ssi_mod);
 	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
 	struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
+	struct device *dev = rsnd_priv_to_dev(priv);
 	int id = rsnd_mod_id(ssi_mod);
 	int shift = (id % 4) * 8;
 	u32 mask = 0xFF << shift;
@@ -305,12 +313,13 @@ static void rsnd_adg_set_ssi_clk(struct rsnd_mod *ssi_mod, u32 val)
 		rsnd_mod_bset(adg_mod, AUDIO_CLK_SEL2, mask, val);
 		break;
 	}
+
+	dev_dbg(dev, "AUDIO_CLK_SEL is 0x%x\n", val);
 }
 
 int rsnd_adg_clk_query(struct rsnd_priv *priv, unsigned int rate)
 {
 	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
-	struct device *dev = rsnd_priv_to_dev(priv);
 	struct clk *clk;
 	int i;
 	int sel_table[] = {
@@ -320,8 +329,6 @@ int rsnd_adg_clk_query(struct rsnd_priv *priv, unsigned int rate)
 		[CLKI] = 0x0,
 	};
 
-	dev_dbg(dev, "request clock = %d\n", rate);
-
 	/*
 	 * find suitable clock from
 	 * AUDIO_CLKA/AUDIO_CLKB/AUDIO_CLKC/AUDIO_CLKI.
@@ -377,9 +384,10 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
 	rsnd_mod_write(adg_mod, BRRA,  adg->rbga);
 	rsnd_mod_write(adg_mod, BRRB,  adg->rbgb);
 
-	dev_dbg(dev, "ADG: %s[%d] selects 0x%x for %d\n",
-		rsnd_mod_name(ssi_mod), rsnd_mod_id(ssi_mod),
-		data, rate);
+	dev_dbg(dev, "CLKOUT is based on BRG%c (= %dHz)\n",
+		(ckr) ? 'B' : 'A',
+		(ckr) ?	adg->rbgb_rate_for_48khz :
+			adg->rbga_rate_for_441khz);
 
 	return 0;
 }
@@ -408,21 +416,12 @@ static void rsnd_adg_get_clkin(struct rsnd_priv *priv,
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct clk *clk;
-	static const char * const clk_name[] = {
-		[CLKA]	= "clk_a",
-		[CLKB]	= "clk_b",
-		[CLKC]	= "clk_c",
-		[CLKI]	= "clk_i",
-	};
 	int i;
 
 	for (i = 0; i < CLKMAX; i++) {
 		clk = devm_clk_get(dev, clk_name[i]);
 		adg->clk[i] = IS_ERR(clk) ? NULL : clk;
 	}
-
-	for_each_rsnd_clk(clk, adg, i)
-		dev_dbg(dev, "clk %d : %p : %ld\n", i, clk, clk_get_rate(clk));
 }
 
 static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
@@ -571,12 +570,35 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 	adg->ckr = ckr;
 	adg->rbga = rbga;
 	adg->rbgb = rbgb;
+}
+
+#ifdef DEBUG
+static void rsnd_adg_clk_dbg_info(struct rsnd_priv *priv, struct rsnd_adg *adg)
+{
+	struct device *dev = rsnd_priv_to_dev(priv);
+	struct clk *clk;
+	int i;
+
+	for_each_rsnd_clk(clk, adg, i)
+		dev_dbg(dev, "%s    : %p : %ld\n",
+			clk_name[i], clk, clk_get_rate(clk));
 
-	for_each_rsnd_clkout(clk, adg, i)
-		dev_dbg(dev, "clkout %d : %p : %ld\n", i, clk, clk_get_rate(clk));
 	dev_dbg(dev, "BRGCKR = 0x%08x, BRRA/BRRB = 0x%x/0x%x\n",
-		ckr, rbga, rbgb);
+		adg->ckr, adg->rbga, adg->rbgb);
+	dev_dbg(dev, "BRGA (for 44100 base) = %d\n", adg->rbga_rate_for_441khz);
+	dev_dbg(dev, "BRGB (for 48000 base) = %d\n", adg->rbgb_rate_for_48khz);
+
+	/*
+	 * Actual CLKOUT will be exchanged in rsnd_adg_ssi_clk_try_start()
+	 * by BRGCKR::BRGCKR_31
+	 */
+	for_each_rsnd_clkout(clk, adg, i)
+		dev_dbg(dev, "clkout %d : %p : %ld\n", i,
+			clk, clk_get_rate(clk));
 }
+#else
+#define rsnd_adg_clk_dbg_info(priv, adg)
+#endif
 
 int rsnd_adg_probe(struct rsnd_priv *priv)
 {
@@ -595,6 +617,7 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 
 	rsnd_adg_get_clkin(priv, adg);
 	rsnd_adg_get_clkout(priv, adg);
+	rsnd_adg_clk_dbg_info(priv, adg);
 
 	priv->adg = adg;
 
-- 
2.14.1
