From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't call free_irq() on Parent SSI" to the asoc tree
Date: Fri, 19 May 2017 18:03:33 +0100
Message-ID: <E1dBlJN-0003b0-AZ@debutante>
References: <87d1b9y3sk.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87d1b9y3sk.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: don't call free_irq() on Parent SSI

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

>From 1f8754d4daea5f257370a52a30fcb22798c54516 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 16 May 2017 01:48:24 +0000
Subject: [PATCH] ASoC: rsnd: don't call free_irq() on Parent SSI

If SSI uses shared pin, some SSI will be used as parent SSI.
Then, normal SSI's remove and Parent SSI's remove
(these are same SSI) will be called when unbind or remove timing.
In this case, free_irq() will be called twice.
This patch solve this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index e43277a5068c..c224695c1484 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -709,6 +709,11 @@ static int rsnd_ssi_dma_remove(struct rsnd_mod *mod,
 			       struct rsnd_priv *priv)
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
+	struct rsnd_mod *ssi_parent_mod = rsnd_io_to_mod_ssip(io);
+
+	/* Do nothing for SSI parent mod */
+	if (ssi_parent_mod == mod)
+		return 0;
 
 	/* PIO will request IRQ again */
 	free_irq(ssi->irq, mod);
-- 
2.11.0
