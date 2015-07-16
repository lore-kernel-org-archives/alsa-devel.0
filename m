From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: rename rsnd_path_parse/break()
	into add/remove" to the asoc tree
Date: Thu, 16 Jul 2015 22:30:05 +0100
Message-ID: <E1ZFqjF-0004lb-28@finisterre>
References: <87pp3tvquy.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 89D0A26672E
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:30:10 +0200 (CEST)
In-Reply-To: <87pp3tvquy.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: rename rsnd_path_parse/break() into add/remove

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

>From c8cf15f64f8ddb3169987c2f26df3341b8556296 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:12:52 +0000
Subject: [PATCH] ASoC: rsnd: rename rsnd_path_parse/break() into add/remove

parse/break is a little ambiguous/confusable name for rsnd module path.
Especially for CTU/MIX support. It was renamed to add/remove

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index ff4f15a..93fed50 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -507,7 +507,7 @@ static const struct snd_soc_dai_ops rsnd_soc_dai_ops = {
 	.set_fmt	= rsnd_soc_dai_set_fmt,
 };
 
-#define rsnd_path_parse(priv, io, type)				\
+#define rsnd_path_add(priv, io, type)				\
 ({								\
 	struct rsnd_mod *mod;					\
 	int ret = 0;						\
@@ -523,7 +523,7 @@ static const struct snd_soc_dai_ops rsnd_soc_dai_ops = {
 	ret;							\
 })
 
-#define rsnd_path_break(priv, io, type)				\
+#define rsnd_path_remove(priv, io, type)			\
 {								\
 	struct rsnd_mod *mod;					\
 	int id = -1;						\
@@ -555,17 +555,17 @@ static int rsnd_path_init(struct rsnd_priv *priv,
 	 */
 
 	/* SRC */
-	ret = rsnd_path_parse(priv, io, src);
+	ret = rsnd_path_add(priv, io, src);
 	if (ret < 0)
 		return ret;
 
 	/* SSI */
-	ret = rsnd_path_parse(priv, io, ssi);
+	ret = rsnd_path_add(priv, io, ssi);
 	if (ret < 0)
 		return ret;
 
 	/* DVC */
-	ret = rsnd_path_parse(priv, io, dvc);
+	ret = rsnd_path_add(priv, io, dvc);
 	if (ret < 0)
 		return ret;
 
@@ -1023,8 +1023,8 @@ static int rsnd_rdai_continuance_probe(struct rsnd_priv *priv,
 		/*
 		 * remove SRC/DVC from DAI,
 		 */
-		rsnd_path_break(priv, io, src);
-		rsnd_path_break(priv, io, dvc);
+		rsnd_path_remove(priv, io, src);
+		rsnd_path_remove(priv, io, dvc);
 
 		/*
 		 * fallback
-- 
2.1.4
