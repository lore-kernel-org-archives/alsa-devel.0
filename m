From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove all modules when PIO
	fallback" to the asoc tree
Date: Tue, 27 Oct 2015 13:48:52 +0900
Message-ID: <E1ZqwBo-0004rx-KV@finisterre>
References: <87twpe3u4y.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EBB6265512
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 05:49:01 +0100 (CET)
In-Reply-To: <87twpe3u4y.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: remove all modules when PIO fallback

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

>From 2a0eecb9cb73b235561951b6492f666e4e9ebbe1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Oct 2015 08:40:02 +0000
Subject: [PATCH] ASoC: rsnd: remove all modules when PIO fallback

Current Renesas sound is supporting PIO fallback if it can't use DMA.
In such case, it should remove all attached modules, but current driver
is missing about CTU/MIX. Because current implement requests
specific mod for remove.
To avoid same things in future, this patch removes all mods,
and re-connects SSI when PIO fallback case.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index d7d2a59..b6fc0d8 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -590,20 +590,6 @@ static const struct snd_soc_dai_ops rsnd_soc_dai_ops = {
 	ret;							\
 })
 
-#define rsnd_path_remove(priv, io, _type)			\
-{								\
-	struct rsnd_mod *mod;					\
-	int id = -1;						\
-								\
-	if (rsnd_is_enable_path(io, _type)) {			\
-		id = rsnd_info_id(priv, io, _type);		\
-		if (id >= 0) {					\
-			mod = rsnd_##_type##_mod_get(priv, id);	\
-			rsnd_dai_disconnect(mod, io, mod->type);\
-		}						\
-	}							\
-}
-
 void rsnd_path_parse(struct rsnd_priv *priv,
 		     struct rsnd_dai_stream *io)
 {
@@ -1163,6 +1149,9 @@ static int rsnd_rdai_continuance_probe(struct rsnd_priv *priv,
 
 	ret = rsnd_dai_call(probe, io, priv);
 	if (ret == -EAGAIN) {
+		struct rsnd_mod *ssi_mod = rsnd_io_to_mod_ssi(io);
+		int i;
+
 		/*
 		 * Fallback to PIO mode
 		 */
@@ -1177,10 +1166,12 @@ static int rsnd_rdai_continuance_probe(struct rsnd_priv *priv,
 		rsnd_dai_call(remove, io, priv);
 
 		/*
-		 * remove SRC/DVC from DAI,
+		 * remove all mod from io
+		 * and, re connect ssi
 		 */
-		rsnd_path_remove(priv, io, src);
-		rsnd_path_remove(priv, io, dvc);
+		for (i = 0; i < RSND_MOD_MAX; i++)
+			rsnd_dai_disconnect((io)->mod[i], io, i);
+		rsnd_dai_connect(ssi_mod, io, RSND_MOD_SSI);
 
 		/*
 		 * fallback
-- 
2.6.1
