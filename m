From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: use generic rsnd_flags_xxx() macro on ADG" to the asoc tree
Date: Wed, 04 Oct 2017 12:28:26 +0100
Message-ID: <E1dzhqk-0004Ku-Ui@debutante>
References: <87r2uqgyog.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87r2uqgyog.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: use generic rsnd_flags_xxx() macro on ADG

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

>From d0cf7fc948159a3eab9ad2e959cce7f06f2333df Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Sun, 1 Oct 2017 23:48:12 +0000
Subject: [PATCH] ASoC: rsnd: use generic rsnd_flags_xxx() macro on ADG

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index e11ce5036bcf..1921307780de 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -44,7 +44,6 @@ struct rsnd_adg {
 
 #define LRCLK_ASYNC	(1 << 0)
 #define AUDIO_OUT_48	(1 << 1)
-#define adg_mode_flags(adg)	(adg->flags)
 
 #define for_each_rsnd_clk(pos, adg, i)		\
 	for (i = 0;				\
@@ -366,8 +365,8 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
 
 	rsnd_adg_set_ssi_clk(ssi_mod, data);
 
-	if (adg_mode_flags(adg) & LRCLK_ASYNC) {
-		if (adg_mode_flags(adg) & AUDIO_OUT_48)
+	if (rsnd_flags_has(adg, LRCLK_ASYNC)) {
+		if (rsnd_flags_has(adg, AUDIO_OUT_48))
 			ckr = 0x80000000;
 	} else {
 		if (0 == (rate % 8000))
@@ -479,10 +478,10 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 	}
 
 	if (req_rate[0] % 48000 == 0)
-		adg->flags |= AUDIO_OUT_48;
+		rsnd_flags_set(adg, AUDIO_OUT_48);
 
 	if (of_get_property(np, "clkout-lr-asynchronous", NULL))
-		adg->flags |= LRCLK_ASYNC;
+		rsnd_flags_set(adg, LRCLK_ASYNC);
 
 	/*
 	 * This driver is assuming that AUDIO_CLKA/AUDIO_CLKB/AUDIO_CLKC
@@ -512,7 +511,7 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 				adg->rbga_rate_for_441khz = rate / div;
 				ckr |= brg_table[i] << 20;
 				if (req_441kHz_rate &&
-				    !(adg_mode_flags(adg) & AUDIO_OUT_48))
+				    !rsnd_flags_has(adg, AUDIO_OUT_48))
 					parent_clk_name = __clk_get_name(clk);
 			}
 		}
@@ -528,7 +527,7 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 				adg->rbgb_rate_for_48khz = rate / div;
 				ckr |= brg_table[i] << 16;
 				if (req_48kHz_rate &&
-				    (adg_mode_flags(adg) & AUDIO_OUT_48))
+				    rsnd_flags_has(adg, AUDIO_OUT_48))
 					parent_clk_name = __clk_get_name(clk);
 			}
 		}
-- 
2.14.1
