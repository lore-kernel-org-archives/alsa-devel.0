From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: ssi: Check runtime channel number
	rather than hw_params" to the asoc tree
Date: Mon,  3 Sep 2018 14:45:45 +0100 (BST)
Message-ID: <20180903134545.354BF11227AE@debutante.sirena.org.uk>
References: <8736urf4ks.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 92BA32678CB
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 15:45:45 +0200 (CEST)
In-Reply-To: <8736urf4ks.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: ssi: Check runtime channel number rather than hw_params

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

>From 599da084e041b877ef89211dcbb4c7bd8380049d Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Mon, 3 Sep 2018 07:07:26 +0000
Subject: [PATCH] ASoC: rsnd: ssi: Check runtime channel number rather than
 hw_params

The number of channel handled by SSI maybe differs from the one set
in hw_params, currently SSI checks hw_params's channel number,
and constrains to use same channel number, when it is being
used by multiple clients.

This patch corrects to check runtime channel number rather
than channel number set in hw_params.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
[kuninori: adjust to upstreaming]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 89cc433e2fc9..3f6dd9f07bc6 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -307,6 +307,11 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 			return -EINVAL;
 		}
 
+		if (ssi->chan != chan) {
+			dev_err(dev, "SSI parent/child should use same chan\n");
+			return -EINVAL;
+		}
+
 		return 0;
 	}
 
@@ -334,6 +339,7 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 			SCKD | SWSD | CKDV(idx);
 	ssi->wsr = CONT;
 	ssi->rate = rate;
+	ssi->chan = chan;
 
 	dev_dbg(dev, "%s[%d] outputs %u Hz\n",
 		rsnd_mod_name(mod),
@@ -359,6 +365,7 @@ static void rsnd_ssi_master_clk_stop(struct rsnd_mod *mod,
 
 	ssi->cr_clk	= 0;
 	ssi->rate	= 0;
+	ssi->chan	= 0;
 
 	rsnd_adg_ssi_clk_stop(mod);
 }
@@ -511,9 +518,7 @@ static int rsnd_ssi_hw_params(struct rsnd_mod *mod,
 			      struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *params)
 {
-	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
-	int chan = params_channels(params);
 	unsigned int fmt_width = snd_pcm_format_width(params_format(params));
 
 	if (fmt_width > rdai->chan_width) {
@@ -524,24 +529,6 @@ static int rsnd_ssi_hw_params(struct rsnd_mod *mod,
 		return -EINVAL;
 	}
 
-	/*
-	 * snd_pcm_ops::hw_params will be called *before*
-	 * snd_soc_dai_ops::trigger. Thus, ssi->usrcnt is 0
-	 * in 1st call.
-	 */
-	if (ssi->usrcnt) {
-		/*
-		 * Already working.
-		 * It will happen if SSI has parent/child connection.
-		 * it is error if child <-> parent SSI uses
-		 * different channels.
-		 */
-		if (ssi->chan != chan)
-			return -EIO;
-	}
-
-	ssi->chan = chan;
-
 	return 0;
 }
 
-- 
2.19.0.rc1
