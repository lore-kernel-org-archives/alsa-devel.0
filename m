From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rcar: unregister fixed rate on ADG" to the asoc tree
Date: Wed, 02 Aug 2017 18:30:14 +0100
Message-ID: <E1dcxTK-0003nA-0s@debutante>
References: <87k22mp8zh.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87k22mp8zh.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, "Yokoyama (Renesas)" <hiroyuki.yokoyama.vx@renesas.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rcar: unregister fixed rate on ADG

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

>From e3c6de48133ff1355f14a31a74a9027834c0fd65 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 2 Aug 2017 10:26:09 +0000
Subject: [PATCH] ASoC: rcar: unregister fixed rate on ADG

ADG is registering fixed rate clock for audio_clkout, but it had not
been unregister clock when removing.

Salvator-X board is using ak4613 driver now, and it supports
hw_constraints from commit 907cd8809eebc ("ASoC: ak4613: add
hw_constraint rule for Sampling Rate").
And this calculation is using input clk. This ak4613 input clock is
ADG clkout on Salvator-X.

Because ADG had not been unregister clkout when unbinding, it receives
fixed rate clk register error when re-binding.
Thus, ak4613 can't get correct input clock, and hw_constraints will be
failed after re-binding.
This means Salvator-X board can't use sound after unbind/bind.

This patch solves this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 197cb3ec075f..5b5389e5b92b 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -610,6 +610,13 @@ void rsnd_adg_remove(struct rsnd_priv *priv)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct device_node *np = dev->of_node;
+	struct rsnd_adg *adg = priv->adg;
+	struct clk *clk;
+	int i;
+
+	for_each_rsnd_clkout(clk, adg, i)
+		if (adg->clkout[i])
+			clk_unregister_fixed_rate(adg->clkout[i]);
 
 	of_clk_del_provider(np);
 
-- 
2.13.2
