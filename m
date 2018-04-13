From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: makes rsnd_cmd_mod_get() static"
	to the asoc tree
Date: Fri, 13 Apr 2018 12:23:39 +0100
Message-ID: <E1f6wnr-00007K-MB@debutante>
References: <87k1tklwr9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EDEF426735C
 for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 13:23:41 +0200 (CEST)
In-Reply-To: <87k1tklwr9.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: makes rsnd_cmd_mod_get() static

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

>From 8c1ddea58b080d33ce4921b45387c146ddb91751 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 6 Apr 2018 05:41:43 +0000
Subject: [PATCH] ASoC: rsnd: makes rsnd_cmd_mod_get() static

rsnd_cmd_mod_get() is used from cmd.c only.
Let's makes it static function

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/cmd.c  | 15 +++++++--------
 sound/soc/sh/rcar/rsnd.h |  1 -
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
index f1d4fb566892..4221937ae79b 100644
--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -125,6 +125,13 @@ static struct rsnd_mod_ops rsnd_cmd_ops = {
 	.stop	= rsnd_cmd_stop,
 };
 
+static struct rsnd_mod *rsnd_cmd_mod_get(struct rsnd_priv *priv, int id)
+{
+	if (WARN_ON(id < 0 || id >= rsnd_cmd_nr(priv)))
+		id = 0;
+
+	return rsnd_mod_get((struct rsnd_cmd *)(priv->cmd) + id);
+}
 int rsnd_cmd_attach(struct rsnd_dai_stream *io, int id)
 {
 	struct rsnd_priv *priv = rsnd_io_to_priv(io);
@@ -133,14 +140,6 @@ int rsnd_cmd_attach(struct rsnd_dai_stream *io, int id)
 	return rsnd_dai_connect(mod, io, mod->type);
 }
 
-struct rsnd_mod *rsnd_cmd_mod_get(struct rsnd_priv *priv, int id)
-{
-	if (WARN_ON(id < 0 || id >= rsnd_cmd_nr(priv)))
-		id = 0;
-
-	return rsnd_mod_get((struct rsnd_cmd *)(priv->cmd) + id);
-}
-
 int rsnd_cmd_probe(struct rsnd_priv *priv)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 172c8d612890..ab4d55548ed1 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -775,7 +775,6 @@ struct rsnd_mod *rsnd_dvc_mod_get(struct rsnd_priv *priv, int id);
 int rsnd_cmd_probe(struct rsnd_priv *priv);
 void rsnd_cmd_remove(struct rsnd_priv *priv);
 int rsnd_cmd_attach(struct rsnd_dai_stream *io, int id);
-struct rsnd_mod *rsnd_cmd_mod_get(struct rsnd_priv *priv, int id);
 
 void rsnd_mod_make_sure(struct rsnd_mod *mod, enum rsnd_mod_type type);
 #ifdef DEBUG
-- 
2.17.0
