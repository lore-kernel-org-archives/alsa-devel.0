From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: enable to use rsnd_dai_connect()
	from each mod" to the asoc tree
Date: Tue, 27 Oct 2015 13:48:54 +0900
Message-ID: <E1ZqwBq-0004sQ-2W@finisterre>
References: <87vb9u3u5j.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B21AC26520E
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 05:49:02 +0100 (CET)
In-Reply-To: <87vb9u3u5j.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: enable to use rsnd_dai_connect() from each mod

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

>From 56a7e69a741e1a0412f685fb95aa9bd6aedd8f6b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Oct 2015 08:39:41 +0000
Subject: [PATCH] ASoC: rsnd: enable to use rsnd_dai_connect() from each mod

Renesas sound needs many devices
(SSI/SSIU/SRC/CTU/MIX/DVC/CMD/AudioDMAC/AudioDMACpp).
SSI/SRC/CTU/MIX/DVC are implemented as module.
SSI parent, SSIU are implemented as part of SSI
CMD is implemented as part of CTU/MIX/DVC
AudioDMAC/AudioDMACpp are implemented as part of SSI/SRC
It is nice sense that these all devices are implemented as mod.

DMAC/SSIU/SSI-parent/CMD will be implemented as module, but these are
not customer controlled module. These should be automatically install
to system. Because of this, rsnd_dai_connect() should be called from
each mod. SSI can be very special, because it will be installed as
SSI-parent / SSI-child. Thus, new rsnd_dai_connect() has type parameter
which should be mod->type except SSI-parent

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 32 +++++++++++++++++---------------
 sound/soc/sh/rcar/rsnd.h |  3 +++
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index deed48ef..d7d2a59 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -332,8 +332,9 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	ret;							\
 })
 
-static int rsnd_dai_connect(struct rsnd_mod *mod,
-			    struct rsnd_dai_stream *io)
+int rsnd_dai_connect(struct rsnd_mod *mod,
+		     struct rsnd_dai_stream *io,
+		     enum rsnd_mod_type type)
 {
 	struct rsnd_priv *priv;
 	struct device *dev;
@@ -344,7 +345,7 @@ static int rsnd_dai_connect(struct rsnd_mod *mod,
 	priv = rsnd_mod_to_priv(mod);
 	dev = rsnd_priv_to_dev(priv);
 
-	io->mod[mod->type] = mod;
+	io->mod[type] = mod;
 
 	dev_dbg(dev, "%s[%d] is connected to io (%s)\n",
 		rsnd_mod_name(mod), rsnd_mod_id(mod),
@@ -354,9 +355,10 @@ static int rsnd_dai_connect(struct rsnd_mod *mod,
 }
 
 static void rsnd_dai_disconnect(struct rsnd_mod *mod,
-				struct rsnd_dai_stream *io)
+				struct rsnd_dai_stream *io,
+				enum rsnd_mod_type type)
 {
-	io->mod[mod->type] = NULL;
+	io->mod[type] = NULL;
 }
 
 struct rsnd_dai *rsnd_rdai_get(struct rsnd_priv *priv, int id)
@@ -572,32 +574,32 @@ static const struct snd_soc_dai_ops rsnd_soc_dai_ops = {
 	.set_fmt	= rsnd_soc_dai_set_fmt,
 };
 
-#define rsnd_path_add(priv, io, type)				\
+#define rsnd_path_add(priv, io, _type)				\
 ({								\
 	struct rsnd_mod *mod;					\
 	int ret = 0;						\
 	int id = -1;						\
 								\
-	if (rsnd_is_enable_path(io, type)) {			\
-		id = rsnd_info_id(priv, io, type);		\
+	if (rsnd_is_enable_path(io, _type)) {			\
+		id = rsnd_info_id(priv, io, _type);		\
 		if (id >= 0) {					\
-			mod = rsnd_##type##_mod_get(priv, id);	\
-			ret = rsnd_dai_connect(mod, io);	\
+			mod = rsnd_##_type##_mod_get(priv, id);	\
+			ret = rsnd_dai_connect(mod, io, mod->type);\
 		}						\
 	}							\
 	ret;							\
 })
 
-#define rsnd_path_remove(priv, io, type)			\
+#define rsnd_path_remove(priv, io, _type)			\
 {								\
 	struct rsnd_mod *mod;					\
 	int id = -1;						\
 								\
-	if (rsnd_is_enable_path(io, type)) {			\
-		id = rsnd_info_id(priv, io, type);		\
+	if (rsnd_is_enable_path(io, _type)) {			\
+		id = rsnd_info_id(priv, io, _type);		\
 		if (id >= 0) {					\
-			mod = rsnd_##type##_mod_get(priv, id);	\
-			rsnd_dai_disconnect(mod, io);		\
+			mod = rsnd_##_type##_mod_get(priv, id);	\
+			rsnd_dai_disconnect(mod, io, mod->type);\
 		}						\
 	}							\
 }
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index dc31f6d..996fa1e 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -380,6 +380,9 @@ struct rsnd_dai *rsnd_rdai_get(struct rsnd_priv *priv, int id);
 bool rsnd_dai_pointer_update(struct rsnd_dai_stream *io, int cnt);
 void rsnd_dai_period_elapsed(struct rsnd_dai_stream *io);
 int rsnd_dai_pointer_offset(struct rsnd_dai_stream *io, int additional);
+int rsnd_dai_connect(struct rsnd_mod *mod,
+		     struct rsnd_dai_stream *io,
+		     enum rsnd_mod_type type);
 
 /*
  *	R-Car Gen1/Gen2
-- 
2.6.1
