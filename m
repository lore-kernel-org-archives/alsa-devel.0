From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: makes rsnd_ssi_is_dma_mode()
	static" to the asoc tree
Date: Wed, 21 Nov 2018 13:29:52 +0000 (GMT)
Message-ID: <20181121132952.9960C11250AE@debutante.sirena.org.uk>
References: <87k1l6q2h3.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C933267A86
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 14:29:53 +0100 (CET)
In-Reply-To: <87k1l6q2h3.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: makes rsnd_ssi_is_dma_mode() static

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

>From 0ade2ccfb81244d0a271a5f9917f9fccc349b6cf Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Nov 2018 08:15:30 +0000
Subject: [PATCH] ASoC: rsnd: makes rsnd_ssi_is_dma_mode() static

ssi.c only is using rsnd_ssi_is_dma_mode().
Let's move it as static function.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsnd.h | 1 -
 sound/soc/sh/rcar/ssi.c  | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 64c3a3bbcbb9..3c57129af6d1 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -726,7 +726,6 @@ extern const char * const volume_ramp_rate[];
 int rsnd_ssi_probe(struct rsnd_priv *priv);
 void rsnd_ssi_remove(struct rsnd_priv *priv);
 struct rsnd_mod *rsnd_ssi_mod_get(struct rsnd_priv *priv, int id);
-int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod);
 int rsnd_ssi_use_busif(struct rsnd_dai_stream *io);
 u32 rsnd_ssi_multi_slaves_runtime(struct rsnd_dai_stream *io);
 
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 26fc4a5da0e8..1996aea21172 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -117,6 +117,8 @@ struct rsnd_ssi {
 	(rsnd_ssi_run_mods(io) & (1 << rsnd_mod_id(mod)))
 #define rsnd_ssi_can_output_clk(mod) (!__rsnd_ssi_is_pin_sharing(mod))
 
+static int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod);
+
 int rsnd_ssi_use_busif(struct rsnd_dai_stream *io)
 {
 	struct rsnd_mod *mod = rsnd_io_to_mod_ssi(io);
@@ -1003,12 +1005,11 @@ static struct rsnd_mod_ops rsnd_ssi_dma_ops = {
 	.get_status	= rsnd_ssi_get_status,
 };
 
-int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod)
+static int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod)
 {
 	return mod->ops == &rsnd_ssi_dma_ops;
 }
 
-
 /*
  *		ssi mod function
  */
-- 
2.19.0.rc2
