From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add rsnd_parse_connect_common()
	and remove complex macro" to the asoc tree
Date: Fri, 18 Dec 2015 12:15:22 +0000
Message-ID: <E1a9twQ-000639-NG@debutante>
References: <871taliy1x.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EE6F82657C9
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:29 +0100 (CET)
In-Reply-To: <871taliy1x.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: add rsnd_parse_connect_common() and remove complex macro

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

>From 89b66174eca6609020cc3d1ef32df7956fd16b34 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Dec 2015 02:58:14 +0000
Subject: [PATCH] ASoC: rsnd: add rsnd_parse_connect_common() and remove
 complex macro

Current rsnd driver is using complex macro to parse DAI connection.
This patch adds new rsnd_parse_connect_common() and replace current
macro to it.
This is prepare for multi channel support

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 57 +++++++++++++++++++++++++++++-------------------
 sound/soc/sh/rcar/rsnd.h | 25 +++++++++++++++++++++
 2 files changed, 59 insertions(+), 23 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 528041eff704..7781cef634d4 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -609,17 +609,44 @@ static const struct snd_soc_dai_ops rsnd_soc_dai_ops = {
 	.set_tdm_slot	= rsnd_soc_set_dai_tdm_slot,
 };
 
+void rsnd_parse_connect_common(struct rsnd_dai *rdai,
+		struct rsnd_mod* (*mod_get)(struct rsnd_priv *priv, int id),
+		struct device_node *node,
+		struct device_node *playback,
+		struct device_node *capture)
+{
+	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
+	struct device_node *np;
+	struct rsnd_mod *mod;
+	int i;
+
+	if (!node)
+		return;
+
+	i = 0;
+	for_each_child_of_node(node, np) {
+		mod = mod_get(priv, i);
+		if (np == playback)
+			rsnd_dai_connect(mod, &rdai->playback, mod->type);
+		if (np == capture)
+			rsnd_dai_connect(mod, &rdai->capture, mod->type);
+		i++;
+	}
+
+	of_node_put(node);
+}
+
 static int rsnd_dai_probe(struct rsnd_priv *priv)
 {
 	struct device_node *dai_node;
-	struct device_node *dai_np, *np, *node;
+	struct device_node *dai_np;
 	struct device_node *playback, *capture;
 	struct rsnd_dai_stream *io_playback;
 	struct rsnd_dai_stream *io_capture;
 	struct snd_soc_dai_driver *rdrv, *drv;
 	struct rsnd_dai *rdai;
 	struct device *dev = rsnd_priv_to_dev(priv);
-	int nr, dai_i, io_i, np_i;
+	int nr, dai_i, io_i;
 	int ret;
 
 	dai_node = rsnd_dai_of_node(priv);
@@ -676,22 +703,6 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 		rdai->capture.rdai		= rdai;
 		rsnd_set_slot(rdai, 2, 1); /* default */
 
-#define mod_parse(name)							\
-node = rsnd_##name##_of_node(priv);					\
-if (node) {								\
-	struct rsnd_mod *mod;						\
-	np_i = 0;							\
-	for_each_child_of_node(node, np) {				\
-		mod = rsnd_##name##_mod_get(priv, np_i);		\
-		if (np == playback)					\
-			rsnd_dai_connect(mod, io_playback, mod->type);	\
-		if (np == capture)					\
-			rsnd_dai_connect(mod, io_capture, mod->type);	\
-		np_i++;							\
-	}								\
-	of_node_put(node);						\
-}
-
 		for (io_i = 0;; io_i++) {
 			playback = of_parse_phandle(dai_np, "playback", io_i);
 			capture  = of_parse_phandle(dai_np, "capture", io_i);
@@ -699,11 +710,11 @@ if (node) {								\
 			if (!playback && !capture)
 				break;
 
-			mod_parse(ssi);
-			mod_parse(src);
-			mod_parse(ctu);
-			mod_parse(mix);
-			mod_parse(dvc);
+			rsnd_parse_connect_ssi(rdai, playback, capture);
+			rsnd_parse_connect_src(rdai, playback, capture);
+			rsnd_parse_connect_ctu(rdai, playback, capture);
+			rsnd_parse_connect_mix(rdai, playback, capture);
+			rsnd_parse_connect_dvc(rdai, playback, capture);
 
 			of_node_put(playback);
 			of_node_put(capture);
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index c9aef234d002..f803e140e733 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -292,6 +292,11 @@ struct dma_chan *rsnd_mod_dma_req(struct rsnd_dai_stream *io,
 void rsnd_mod_interrupt(struct rsnd_mod *mod,
 			void (*callback)(struct rsnd_mod *mod,
 					 struct rsnd_dai_stream *io));
+void rsnd_parse_connect_common(struct rsnd_dai *rdai,
+		struct rsnd_mod* (*mod_get)(struct rsnd_priv *priv, int id),
+		struct device_node *node,
+		struct device_node *playback,
+		struct device_node *capture);
 
 void rsnd_set_slot(struct rsnd_dai *rdai,
 		   int slots, int slots_total);
@@ -544,6 +549,10 @@ int __rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod);
 
 #define rsnd_ssi_of_node(priv)						\
 	of_get_child_by_name(rsnd_priv_to_dev(priv)->of_node, "rcar_sound,ssi")
+#define rsnd_parse_connect_ssi(rdai, playback, capture)			\
+	rsnd_parse_connect_common(rdai, rsnd_ssi_mod_get,		\
+				  rsnd_ssi_of_node(rsnd_rdai_to_priv(rdai)), \
+				  playback, capture)
 
 /*
  *	R-Car SSIU
@@ -564,6 +573,10 @@ unsigned int rsnd_src_get_ssi_rate(struct rsnd_priv *priv,
 				   struct snd_pcm_runtime *runtime);
 #define rsnd_src_of_node(priv)						\
 	of_get_child_by_name(rsnd_priv_to_dev(priv)->of_node, "rcar_sound,src")
+#define rsnd_parse_connect_src(rdai, playback, capture)			\
+	rsnd_parse_connect_common(rdai, rsnd_src_mod_get,		\
+				  rsnd_src_of_node(rsnd_rdai_to_priv(rdai)), \
+						   playback, capture)
 
 /*
  *	R-Car CTU
@@ -573,6 +586,10 @@ void rsnd_ctu_remove(struct rsnd_priv *priv);
 struct rsnd_mod *rsnd_ctu_mod_get(struct rsnd_priv *priv, int id);
 #define rsnd_ctu_of_node(priv)						\
 	of_get_child_by_name(rsnd_priv_to_dev(priv)->of_node, "rcar_sound,ctu")
+#define rsnd_parse_connect_ctu(rdai, playback, capture)			\
+	rsnd_parse_connect_common(rdai, rsnd_ctu_mod_get,		\
+				  rsnd_ctu_of_node(rsnd_rdai_to_priv(rdai)), \
+						   playback, capture)
 
 /*
  *	R-Car MIX
@@ -582,6 +599,10 @@ void rsnd_mix_remove(struct rsnd_priv *priv);
 struct rsnd_mod *rsnd_mix_mod_get(struct rsnd_priv *priv, int id);
 #define rsnd_mix_of_node(priv)						\
 	of_get_child_by_name(rsnd_priv_to_dev(priv)->of_node, "rcar_sound,mix")
+#define rsnd_parse_connect_mix(rdai, playback, capture)			\
+	rsnd_parse_connect_common(rdai, rsnd_mix_mod_get,		\
+				  rsnd_mix_of_node(rsnd_rdai_to_priv(rdai)), \
+						   playback, capture)
 
 /*
  *	R-Car DVC
@@ -591,6 +612,10 @@ void rsnd_dvc_remove(struct rsnd_priv *priv);
 struct rsnd_mod *rsnd_dvc_mod_get(struct rsnd_priv *priv, int id);
 #define rsnd_dvc_of_node(priv)						\
 	of_get_child_by_name(rsnd_priv_to_dev(priv)->of_node, "rcar_sound,dvc")
+#define rsnd_parse_connect_dvc(rdai, playback, capture)			\
+	rsnd_parse_connect_common(rdai, rsnd_dvc_mod_get,		\
+				  rsnd_dvc_of_node(rsnd_rdai_to_priv(rdai)), \
+						   playback, capture)
 
 /*
  *	R-Car CMD
-- 
2.6.2
