From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup unsigned expression compared with zero: main_rate" to the asoc tree
Date: Wed, 21 Jun 2017 12:16:26 +0100
Message-ID: <E1dNdcY-0004BP-GK@debutante>
References: <87o9toiz2p.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87o9toiz2p.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fixup unsigned expression compared with zero: main_rate

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

>From 947f4eb58d2054b10a1d8146d0ab90b0e7fd3494 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 16 Jun 2017 00:02:59 +0000
Subject: [PATCH] ASoC: rsnd: fixup unsigned expression compared with zero:
 main_rate

This patch fixes this WARNING

sound/soc/sh/rcar/ssi.c:285:5-14: WARNING: Unsigned expression\
	compared with zero: main_rate < 0

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 2 +-
 sound/soc/sh/rcar/rsnd.h | 2 +-
 sound/soc/sh/rcar/ssi.c  | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 4892c0a4b613..409bac331d27 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -763,7 +763,7 @@ static int rsnd_soc_hw_rule(struct rsnd_priv *priv,
 			    struct snd_interval *baseline, struct snd_interval *iv)
 {
 	struct snd_interval p;
-	int rate;
+	unsigned int rate;
 	int i;
 
 	snd_interval_any(&p);
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 9428d4e288dd..99c57611df88 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -680,7 +680,7 @@ int __rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod);
 void rsnd_parse_connect_ssi(struct rsnd_dai *rdai,
 			    struct device_node *playback,
 			    struct device_node *capture);
-int rsnd_ssi_clk_query(struct rsnd_priv *priv,
+unsigned int rsnd_ssi_clk_query(struct rsnd_priv *priv,
 		       int param1, int param2, int *idx);
 
 /*
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index c8956c3484dd..46feddd78ee2 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -208,14 +208,14 @@ u32 rsnd_ssi_multi_slaves_runtime(struct rsnd_dai_stream *io)
 	return 0;
 }
 
-int rsnd_ssi_clk_query(struct rsnd_priv *priv,
+unsigned int rsnd_ssi_clk_query(struct rsnd_priv *priv,
 		       int param1, int param2, int *idx)
 {
 	int ssi_clk_mul_table[] = {
 		1, 2, 4, 8, 16, 6, 12,
 	};
 	int j, ret;
-	int main_rate;
+	unsigned int main_rate;
 
 	for (j = 0; j < ARRAY_SIZE(ssi_clk_mul_table); j++) {
 
@@ -245,7 +245,7 @@ int rsnd_ssi_clk_query(struct rsnd_priv *priv,
 		return main_rate;
 	}
 
-	return -EINVAL;
+	return 0;
 }
 
 static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
@@ -282,7 +282,7 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	}
 
 	main_rate = rsnd_ssi_clk_query(priv, rate, chan, &idx);
-	if (main_rate < 0) {
+	if (!main_rate) {
 		dev_err(dev, "unsupported clock rate\n");
 		return -EIO;
 	}
-- 
2.11.0
