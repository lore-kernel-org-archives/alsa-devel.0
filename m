From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: clkout-lr-asynchronous is AUDIO_CLKOUT related property" to the asoc tree
Date: Wed, 17 May 2017 10:52:15 +0100
Message-ID: <E1dAvct-0006pp-Ik@debutante>
References: <87r2zqj35o.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87r2zqj35o.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: clkout-lr-asynchronous is AUDIO_CLKOUT related property

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

>From 9654f5eba994c8732bfdb4c3b81bc5e18d25e970 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 May 2017 01:58:56 +0000
Subject: [PATCH] ASoC: rsnd: clkout-lr-asynchronous is AUDIO_CLKOUT related
 property

clkout-lr-asynchronous is AUDIO_CLKOUT related property, thus, it
should be handled by rsnd_adg_get_clkout().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 66203d107a11..cb4eab0e24ce 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -480,6 +480,9 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 	if (req_rate[0] % 48000 == 0)
 		adg->flags = AUDIO_OUT_48;
 
+	if (of_get_property(np, "clkout-lr-asynchronous", NULL))
+		adg->flags = LRCLK_ASYNC;
+
 	/*
 	 * This driver is assuming that AUDIO_CLKA/AUDIO_CLKB/AUDIO_CLKC
 	 * have 44.1kHz or 48kHz base clocks for now.
@@ -578,7 +581,6 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 {
 	struct rsnd_adg *adg;
 	struct device *dev = rsnd_priv_to_dev(priv);
-	struct device_node *np = dev->of_node;
 	int ret;
 
 	adg = devm_kzalloc(dev, sizeof(*adg), GFP_KERNEL);
@@ -595,9 +597,6 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 	rsnd_adg_get_clkin(priv, adg);
 	rsnd_adg_get_clkout(priv, adg);
 
-	if (of_get_property(np, "clkout-lr-asynchronous", NULL))
-		adg->flags = LRCLK_ASYNC;
-
 	priv->adg = adg;
 
 	rsnd_adg_clk_enable(priv);
-- 
2.11.0
