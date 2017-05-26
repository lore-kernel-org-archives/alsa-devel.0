From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup parent_clk_name of AUDIO_CLKOUTx" to the asoc tree
Date: Fri, 26 May 2017 12:41:54 +0100
Message-ID: <E1dEDcw-0000jt-4W@debutante>
References: <8760gos8fq.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <8760gos8fq.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fixup parent_clk_name of AUDIO_CLKOUTx

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

>From e8a3ce1130134046e9da132aa4d043566df8237d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 May 2017 01:44:19 +0000
Subject: [PATCH] ASoC: rsnd: fixup parent_clk_name of AUDIO_CLKOUTx

commit 25165f79adc7 ("ASoC: rsnd: enable clock-frequency for both
44.1kHz/48kHz") supported both 44.1kHz/48kHz for AUDIO_CLKOUTx,
but it didn't care its parent clock name.
This patch fixes it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 66203d107a11..d3b0dc145a56 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -507,7 +507,8 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 				rbga = rbgx;
 				adg->rbga_rate_for_441khz = rate / div;
 				ckr |= brg_table[i] << 20;
-				if (req_441kHz_rate)
+				if (req_441kHz_rate &&
+				    !(adg_mode_flags(adg) & AUDIO_OUT_48))
 					parent_clk_name = __clk_get_name(clk);
 			}
 		}
@@ -522,7 +523,8 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 				rbgb = rbgx;
 				adg->rbgb_rate_for_48khz = rate / div;
 				ckr |= brg_table[i] << 16;
-				if (req_48kHz_rate)
+				if (req_48kHz_rate &&
+				    (adg_mode_flags(adg) & AUDIO_OUT_48))
 					parent_clk_name = __clk_get_name(clk);
 			}
 		}
-- 
2.11.0
