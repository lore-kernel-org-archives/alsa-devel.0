From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rcar: clear DE bit only in PDMACHCR when it stops" to the asoc tree
Date: Wed, 15 Mar 2017 18:13:15 +0000
Message-ID: <E1coDQB-0002Aq-QS@debutante>
References: <87tw6wd7bq.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87tw6wd7bq.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rcar: clear DE bit only in PDMACHCR when it stops

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

>From 62a10498afb27370ec6018e9d802b74850fd8d9a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 14 Mar 2017 09:34:49 +0900
Subject: [PATCH] ASoC: rcar: clear DE bit only in PDMACHCR when it stops

R-Car datasheet indicates "Clear DE in PDMACHCR" for transfer stop,
but current code clears all bits in PDMACHCR.
Because of this, DE bit might never been cleared,
and it causes CMD overflow. This patch fixes this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 1f405c833867..c2e199b4fcf4 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -454,6 +454,20 @@ static u32 rsnd_dmapp_read(struct rsnd_dma *dma, u32 reg)
 	return ioread32(rsnd_dmapp_addr(dmac, dma, reg));
 }
 
+static void rsnd_dmapp_bset(struct rsnd_dma *dma, u32 data, u32 mask, u32 reg)
+{
+	struct rsnd_mod *mod = rsnd_mod_get(dma);
+	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct rsnd_dma_ctrl *dmac = rsnd_priv_to_dmac(priv);
+	volatile void __iomem *addr = rsnd_dmapp_addr(dmac, dma, reg);
+	u32 val = ioread32(addr);
+
+	val &= ~mask;
+	val |= (data & mask);
+
+	iowrite32(val, addr);
+}
+
 static int rsnd_dmapp_stop(struct rsnd_mod *mod,
 			   struct rsnd_dai_stream *io,
 			   struct rsnd_priv *priv)
@@ -461,10 +475,10 @@ static int rsnd_dmapp_stop(struct rsnd_mod *mod,
 	struct rsnd_dma *dma = rsnd_mod_to_dma(mod);
 	int i;
 
-	rsnd_dmapp_write(dma, 0, PDMACHCR);
+	rsnd_dmapp_bset(dma, 0,  PDMACHCR_DE, PDMACHCR);
 
 	for (i = 0; i < 1024; i++) {
-		if (0 == rsnd_dmapp_read(dma, PDMACHCR))
+		if (0 == (rsnd_dmapp_read(dma, PDMACHCR) & PDMACHCR_DE))
 			return 0;
 		udelay(1);
 	}
-- 
2.11.0
