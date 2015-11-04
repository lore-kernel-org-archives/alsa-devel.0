From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: move CMD related operation to
	cmd.c" to the asoc tree
Date: Wed, 04 Nov 2015 14:53:16 +0000
Message-ID: <E1ZtzR6-00030A-SV@finisterre>
References: <87fv0mw45h.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 567C42657FF
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:53:27 +0100 (CET)
In-Reply-To: <87fv0mw45h.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: move CMD related operation to cmd.c

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

>From dbfa05de25625f9569f23c9caee1eace4b5bbe67 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 4 Nov 2015 08:43:33 +0000
Subject: [PATCH] ASoC: rsnd: move CMD related operation to cmd.c

8cca6e11c1 ("ASoC: rsnd: use mod base common method on CMD")
added cmd.c. Let's move CMD related operation to cmd.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/cmd.c | 20 ++++++++++++++++++++
 sound/soc/sh/rcar/dvc.c | 24 +-----------------------
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
index 731d74b..47ef47c 100644
--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -81,14 +81,34 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 
 	rsnd_mod_write(mod, CMD_ROUTE_SLCT, data);
 
+	rsnd_adg_set_cmd_timsel_gen2(mod, io);
+
+	return 0;
+}
+
+static int rsnd_cmd_start(struct rsnd_mod *mod,
+			  struct rsnd_dai_stream *io,
+			  struct rsnd_priv *priv)
+{
 	rsnd_mod_write(mod, CMD_CTRL, 0x10);
 
 	return 0;
 }
 
+static int rsnd_cmd_stop(struct rsnd_mod *mod,
+			 struct rsnd_dai_stream *io,
+			 struct rsnd_priv *priv)
+{
+	rsnd_mod_write(mod, CMD_CTRL, 0);
+
+	return 0;
+}
+
 static struct rsnd_mod_ops rsnd_cmd_ops = {
 	.name	= CMD_NAME,
 	.init	= rsnd_cmd_init,
+	.start	= rsnd_cmd_start,
+	.stop	= rsnd_cmd_stop,
 };
 
 int rsnd_cmd_attach(struct rsnd_dai_stream *io, int id)
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index d207000..651c057 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -171,7 +171,7 @@ static int rsnd_dvc_init(struct rsnd_mod *mod,
 	/* ch0/ch1 Volume */
 	rsnd_dvc_volume_update(io, mod);
 
-	rsnd_adg_set_cmd_timsel_gen2(mod, io);
+	rsnd_dvc_initialize_unlock(mod);
 
 	return 0;
 }
@@ -185,26 +185,6 @@ static int rsnd_dvc_quit(struct rsnd_mod *mod,
 	return 0;
 }
 
-static int rsnd_dvc_start(struct rsnd_mod *mod,
-			  struct rsnd_dai_stream *io,
-			  struct rsnd_priv *priv)
-{
-	rsnd_dvc_initialize_unlock(mod);
-
-	rsnd_mod_write(mod, CMD_CTRL, 0x10);
-
-	return 0;
-}
-
-static int rsnd_dvc_stop(struct rsnd_mod *mod,
-			 struct rsnd_dai_stream *io,
-			 struct rsnd_priv *priv)
-{
-	rsnd_mod_write(mod, CMD_CTRL, 0);
-
-	return 0;
-}
-
 static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 			    struct rsnd_dai_stream *io,
 			    struct snd_soc_pcm_runtime *rtd)
@@ -278,8 +258,6 @@ static struct rsnd_mod_ops rsnd_dvc_ops = {
 	.remove		= rsnd_dvc_remove_,
 	.init		= rsnd_dvc_init,
 	.quit		= rsnd_dvc_quit,
-	.start		= rsnd_dvc_start,
-	.stop		= rsnd_dvc_stop,
 	.pcm_new	= rsnd_dvc_pcm_new,
 };
 
-- 
2.6.1
