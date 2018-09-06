From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't use %p for dev_dbg()" to
	the asoc tree
Date: Thu,  6 Sep 2018 11:44:14 +0100 (BST)
Message-ID: <20180906104414.E64D21122A1F@debutante.sirena.org.uk>
References: <87worz9v0o.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A98D26779A
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 12:44:15 +0200 (CEST)
In-Reply-To: <87worz9v0o.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: don't use %p for dev_dbg()

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

>From dabdbe3ae0cb9a67872fa4ac80ffdef61391f645 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Sep 2018 03:22:01 +0000
Subject: [PATCH] ASoC: rsnd: don't use %p for dev_dbg()

rsnd driver sometimes want to know which address is used when debugging.
But it will indicate "(____ptrval____)" if it used "%p" on dev_dbg().
Let's use "%pa" or "%px" for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 4 ++--
 sound/soc/sh/rcar/dma.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 3a3064dda57f..b100c44ec3a3 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -577,7 +577,7 @@ static void rsnd_adg_clk_dbg_info(struct rsnd_priv *priv, struct rsnd_adg *adg)
 	int i;
 
 	for_each_rsnd_clk(clk, adg, i)
-		dev_dbg(dev, "%s    : %p : %ld\n",
+		dev_dbg(dev, "%s    : %pa : %ld\n",
 			clk_name[i], clk, clk_get_rate(clk));
 
 	dev_dbg(dev, "BRGCKR = 0x%08x, BRRA/BRRB = 0x%x/0x%x\n",
@@ -590,7 +590,7 @@ static void rsnd_adg_clk_dbg_info(struct rsnd_priv *priv, struct rsnd_adg *adg)
 	 * by BRGCKR::BRGCKR_31
 	 */
 	for_each_rsnd_clkout(clk, adg, i)
-		dev_dbg(dev, "clkout %d : %p : %ld\n", i,
+		dev_dbg(dev, "clkout %d : %pa : %ld\n", i,
 			clk, clk_get_rate(clk));
 }
 #else
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index f99c1ab3b0bd..c19342d18998 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -393,7 +393,7 @@ static void rsnd_dmapp_write(struct rsnd_dma *dma, u32 data, u32 reg)
 	struct rsnd_dma_ctrl *dmac = rsnd_priv_to_dmac(priv);
 	struct device *dev = rsnd_priv_to_dev(priv);
 
-	dev_dbg(dev, "w %p : %08x\n", rsnd_dmapp_addr(dmac, dma, reg), data);
+	dev_dbg(dev, "w 0x%px : %08x\n", rsnd_dmapp_addr(dmac, dma, reg), data);
 
 	iowrite32(data, rsnd_dmapp_addr(dmac, dma, reg));
 }
-- 
2.19.0.rc1
