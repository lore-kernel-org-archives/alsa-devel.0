From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rcar: call missing of_clk_del_provider() when remove" to the asoc tree
Date: Thu, 30 Mar 2017 22:22:48 +0100
Message-ID: <E1cthWq-00089S-5w@debutante>
References: <87mvc3edvh.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87mvc3edvh.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rcar: call missing of_clk_del_provider() when remove

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

>From b5aac5a9adf667f907c34c520e023bc19f8c226c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 30 Mar 2017 01:49:27 +0000
Subject: [PATCH] ASoC: rcar: call missing of_clk_del_provider() when remove

adg is calling of_clk_add_provider() when probe time,
thus, remove should call of_clk_del_provider(), it doesn't now.
This patch fix this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 56107454bdb3..9665c1fa7216 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -587,5 +587,10 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 
 void rsnd_adg_remove(struct rsnd_priv *priv)
 {
+	struct device *dev = rsnd_priv_to_dev(priv);
+	struct device_node *np = dev->of_node;
+
+	of_clk_del_provider(np);
+
 	rsnd_adg_clk_disable(priv);
 }
-- 
2.11.0
