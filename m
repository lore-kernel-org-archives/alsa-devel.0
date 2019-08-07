From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't call clk_get_rate() under
	atomic context" to the asoc tree
Date: Wed,  7 Aug 2019 14:30:50 +0100 (BST)
Message-ID: <20190807133050.6E54B274304E@ypsilon.sirena.org.uk>
References: <87v9vb0xkp.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C78E8F805F7
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 15:30:51 +0200 (CEST)
In-Reply-To: <87v9vb0xkp.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, hien.dang.eb@renesas.com, Mark Brown <broonie@kernel.org>, Leon Kong <Leon.KONG@cn.bosch.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: don't call clk_get_rate() under atomic context

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 06e8f5c842f2dbb232897ba967ea7b422745c271 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 6 Aug 2019 12:45:38 +0900
Subject: [PATCH] ASoC: rsnd: don't call clk_get_rate() under atomic context

ADG is using clk_get_rate() under atomic context, thus, we might
have scheduling issue.
To avoid this issue, we need to get/keep clk rate under
non atomic context.

We need to handle ADG as special device at Renesas Sound driver.
>From SW point of view, we want to impletent it as
rsnd_mod_ops :: prepare, but it makes code just complicate.

To avoid complicated code/patch, this patch adds new clk_rate[] array,
and keep clk IN rate when rsnd_adg_clk_enable() was called.

Reported-by: Leon Kong <Leon.KONG@cn.bosch.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Leon Kong <Leon.KONG@cn.bosch.com>
Link: https://lore.kernel.org/r/87v9vb0xkp.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index fce4e050a9b7..b9aacf3d3b29 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -30,6 +30,7 @@ struct rsnd_adg {
 	struct clk *clkout[CLKOUTMAX];
 	struct clk_onecell_data onecell;
 	struct rsnd_mod mod;
+	int clk_rate[CLKMAX];
 	u32 flags;
 	u32 ckr;
 	u32 rbga;
@@ -114,9 +115,9 @@ static void __rsnd_adg_get_timesel_ratio(struct rsnd_priv *priv,
 	unsigned int val, en;
 	unsigned int min, diff;
 	unsigned int sel_rate[] = {
-		clk_get_rate(adg->clk[CLKA]),	/* 0000: CLKA */
-		clk_get_rate(adg->clk[CLKB]),	/* 0001: CLKB */
-		clk_get_rate(adg->clk[CLKC]),	/* 0010: CLKC */
+		adg->clk_rate[CLKA],	/* 0000: CLKA */
+		adg->clk_rate[CLKB],	/* 0001: CLKB */
+		adg->clk_rate[CLKC],	/* 0010: CLKC */
 		adg->rbga_rate_for_441khz,	/* 0011: RBGA */
 		adg->rbgb_rate_for_48khz,	/* 0100: RBGB */
 	};
@@ -302,7 +303,7 @@ int rsnd_adg_clk_query(struct rsnd_priv *priv, unsigned int rate)
 	 * AUDIO_CLKA/AUDIO_CLKB/AUDIO_CLKC/AUDIO_CLKI.
 	 */
 	for_each_rsnd_clk(clk, adg, i) {
-		if (rate == clk_get_rate(clk))
+		if (rate == adg->clk_rate[i])
 			return sel_table[i];
 	}
 
@@ -369,10 +370,18 @@ void rsnd_adg_clk_control(struct rsnd_priv *priv, int enable)
 
 	for_each_rsnd_clk(clk, adg, i) {
 		ret = 0;
-		if (enable)
+		if (enable) {
 			ret = clk_prepare_enable(clk);
-		else
+
+			/*
+			 * We shouldn't use clk_get_rate() under
+			 * atomic context. Let's keep it when
+			 * rsnd_adg_clk_enable() was called
+			 */
+			adg->clk_rate[i] = clk_get_rate(adg->clk[i]);
+		} else {
 			clk_disable_unprepare(clk);
+		}
 
 		if (ret < 0)
 			dev_warn(dev, "can't use clk %d\n", i);
-- 
2.20.1
