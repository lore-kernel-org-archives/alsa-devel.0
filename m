From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: has .symmetric_rates if SSIs are
	sharing WS pin" to the asoc tree
Date: Mon, 18 Jun 2018 13:00:30 +0100
Message-ID: <E1fUspi-0000JR-TX@debutante>
References: <87602osghu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 352DE267747
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:00:33 +0200 (CEST)
In-Reply-To: <87602osghu.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: has .symmetric_rates if SSIs are sharing WS pin

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

>From 7cc90a5cadb1733d95d3c2bc147cbcf7843aa585 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2018 05:52:00 +0000
Subject: [PATCH] ASoC: rsnd: has .symmetric_rates if SSIs are sharing WS pin

If SSIs are sharing WS pin, it should has .symmetric_rates.
This patch sets it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 6 ++++++
 sound/soc/sh/rcar/ssi.c  | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index af04d41a4274..6bbdddef426e 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1085,6 +1085,12 @@ static void __rsnd_dai_probe(struct rsnd_priv *priv,
 		of_node_put(capture);
 	}
 
+	if (rsnd_ssi_is_pin_sharing(io_capture) ||
+	    rsnd_ssi_is_pin_sharing(io_playback)) {
+		/* should have symmetric_rates if pin sharing */
+		drv->symmetric_rates = 1;
+	}
+
 	dev_dbg(dev, "%s (%s/%s)\n", rdai->name,
 		rsnd_io_to_mod_ssi(io_playback) ? "play"    : " -- ",
 		rsnd_io_to_mod_ssi(io_capture) ? "capture" : "  --   ");
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 9538f76f8e20..4e605648918b 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -1055,9 +1055,10 @@ struct rsnd_mod *rsnd_ssi_mod_get(struct rsnd_priv *priv, int id)
 
 int __rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod)
 {
-	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
+	if (!mod)
+		return 0;
 
-	return !!(rsnd_flags_has(ssi, RSND_SSI_CLK_PIN_SHARE));
+	return !!(rsnd_flags_has(rsnd_mod_to_ssi(mod), RSND_SSI_CLK_PIN_SHARE));
 }
 
 static u32 *rsnd_ssi_get_status(struct rsnd_dai_stream *io,
-- 
2.17.1
