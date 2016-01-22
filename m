From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: each mod has status again for
	CTU/MUX support" to the asoc tree
Date: Fri, 22 Jan 2016 18:26:44 +0000
Message-ID: <E1aMgQ0-00047f-0u@debutante>
References: <87egdb4rzc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DF27326065F
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:48 +0100 (CET)
In-Reply-To: <87egdb4rzc.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: each mod has status again for CTU/MUX support

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

>From 5ba17b42e1755c3c5cfe96370cfd47f34d01f62c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jan 2016 01:58:07 +0000
Subject: [PATCH] ASoC: rsnd: each mod has status again for CTU/MUX support

SSI will be used as normal SSI or as clock parent SSI. Therefor,
rsnd driver wants to control SSI and parent SSI separately. Otherwise it
can't use Playback/Capture in the same time.
And it has been done by c2dc47d5cf("ASoC: rsnd: rsnd_dai_stream has each
mod's status insted of rsnd_mod") before.

OTOH, rsnd driver doesn't want to control CTU/MUX/DVC/SSIU/SSI in
separately. Otherwise, these will be re-initialized during playing if
MUX merges 2 sounds.
Because of these picky reasons, this patch re-defines status on each mod,
and add new parent_ssi_status on rsnd_dai_stream.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c  |  2 +-
 sound/soc/sh/rcar/cmd.c  |  3 ++-
 sound/soc/sh/rcar/core.c | 21 ++++++++++++++++-----
 sound/soc/sh/rcar/ctu.c  |  2 +-
 sound/soc/sh/rcar/dma.c  |  2 +-
 sound/soc/sh/rcar/dvc.c  |  2 +-
 sound/soc/sh/rcar/mix.c  |  2 +-
 sound/soc/sh/rcar/rsnd.h | 21 ++++++++++++++++-----
 sound/soc/sh/rcar/src.c  |  3 ++-
 sound/soc/sh/rcar/ssi.c  | 37 ++++++++++++++++++++++++++++++++++++-
 sound/soc/sh/rcar/ssiu.c |  3 ++-
 11 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 19f5509f908d..d74e1ccc0f8f 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -519,7 +519,7 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 	}
 
 	rsnd_mod_init(priv, &adg->mod, &adg_ops,
-		      NULL, 0, 0);
+		      NULL, NULL, 0, 0);
 
 	rsnd_adg_get_clkin(priv, adg);
 	rsnd_adg_get_clkout(priv, adg);
diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
index 4b2d50d9a686..abb5eaac854a 100644
--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -157,7 +157,8 @@ int rsnd_cmd_probe(struct rsnd_priv *priv)
 
 	for_each_rsnd_cmd(cmd, priv, i) {
 		ret = rsnd_mod_init(priv, rsnd_mod_get(cmd),
-				    &rsnd_cmd_ops, NULL, RSND_MOD_CMD, i);
+				    &rsnd_cmd_ops, NULL,
+				    rsnd_mod_get_status, RSND_MOD_CMD, i);
 		if (ret)
 			return ret;
 	}
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index ed0918967def..b460d714d088 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -138,12 +138,22 @@ struct dma_chan *rsnd_mod_dma_req(struct rsnd_dai_stream *io,
 	return mod->ops->dma_req(io, mod);
 }
 
+u32 *rsnd_mod_get_status(struct rsnd_dai_stream *io,
+			 struct rsnd_mod *mod,
+			 enum rsnd_mod_type type)
+{
+	return &mod->status;
+}
+
 int rsnd_mod_init(struct rsnd_priv *priv,
 		  struct rsnd_mod *mod,
-		   struct rsnd_mod_ops *ops,
-		   struct clk *clk,
-		   enum rsnd_mod_type type,
-		   int id)
+		  struct rsnd_mod_ops *ops,
+		  struct clk *clk,
+		  u32* (*get_status)(struct rsnd_dai_stream *io,
+				     struct rsnd_mod *mod,
+				     enum rsnd_mod_type type),
+		  enum rsnd_mod_type type,
+		  int id)
 {
 	int ret = clk_prepare(clk);
 
@@ -155,6 +165,7 @@ int rsnd_mod_init(struct rsnd_priv *priv,
 	mod->type	= type;
 	mod->clk	= clk;
 	mod->priv	= priv;
+	mod->get_status	= get_status;
 
 	return ret;
 }
@@ -325,7 +336,7 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);		\
 	struct rsnd_mod *mod = (io)->mod[idx];			\
 	struct device *dev = rsnd_priv_to_dev(priv);		\
-	u32 *status = (io)->mod_status + idx;			\
+	u32 *status = mod->get_status(io, mod, idx);			\
 	u32 mask = 0xF << __rsnd_mod_shift_##func;			\
 	u8 val  = (*status >> __rsnd_mod_shift_##func) & 0xF;		\
 	u8 add  = ((val + __rsnd_mod_add_##func) & 0xF);		\
diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index d53a225d19e9..109930a20401 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -129,7 +129,7 @@ int rsnd_ctu_probe(struct rsnd_priv *priv)
 		}
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(ctu), &rsnd_ctu_ops,
-				    clk, RSND_MOD_CTU, i);
+				    clk, rsnd_mod_get_status, RSND_MOD_CTU, i);
 		if (ret)
 			goto rsnd_ctu_probe_done;
 
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 418e6fdd06a3..d1cb3c177572 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -681,7 +681,7 @@ struct rsnd_mod *rsnd_dma_attach(struct rsnd_dai_stream *io,
 	dma_mod = rsnd_mod_get(dma);
 
 	ret = rsnd_mod_init(priv, dma_mod,
-			    ops, NULL, type, dma_id);
+			    ops, NULL, rsnd_mod_get_status, type, dma_id);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index d45ffe496397..302c193f674d 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -373,7 +373,7 @@ int rsnd_dvc_probe(struct rsnd_priv *priv)
 		}
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(dvc), &rsnd_dvc_ops,
-			      clk, RSND_MOD_DVC, i);
+				    clk, rsnd_mod_get_status, RSND_MOD_DVC, i);
 		if (ret)
 			goto rsnd_dvc_probe_done;
 
diff --git a/sound/soc/sh/rcar/mix.c b/sound/soc/sh/rcar/mix.c
index 65542b6a89e9..e0e337ad4206 100644
--- a/sound/soc/sh/rcar/mix.c
+++ b/sound/soc/sh/rcar/mix.c
@@ -172,7 +172,7 @@ int rsnd_mix_probe(struct rsnd_priv *priv)
 		}
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(mix), &rsnd_mix_ops,
-				    clk, RSND_MOD_MIX, i);
+				    clk, rsnd_mod_get_status, RSND_MOD_MIX, i);
 		if (ret)
 			goto rsnd_mix_probe_done;
 
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index c7b2ba0daf2a..28602607cf5e 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -233,6 +233,10 @@ struct rsnd_mod {
 	struct rsnd_mod_ops *ops;
 	struct rsnd_priv *priv;
 	struct clk *clk;
+	u32 *(*get_status)(struct rsnd_dai_stream *io,
+			   struct rsnd_mod *mod,
+			   enum rsnd_mod_type type);
+	u32 status;
 };
 /*
  * status
@@ -286,10 +290,13 @@ struct rsnd_mod {
 
 int rsnd_mod_init(struct rsnd_priv *priv,
 		  struct rsnd_mod *mod,
-		   struct rsnd_mod_ops *ops,
-		   struct clk *clk,
-		   enum rsnd_mod_type type,
-		   int id);
+		  struct rsnd_mod_ops *ops,
+		  struct clk *clk,
+		  u32* (*get_status)(struct rsnd_dai_stream *io,
+				     struct rsnd_mod *mod,
+				     enum rsnd_mod_type type),
+		  enum rsnd_mod_type type,
+		  int id);
 void rsnd_mod_quit(struct rsnd_mod *mod);
 char *rsnd_mod_name(struct rsnd_mod *mod);
 struct dma_chan *rsnd_mod_dma_req(struct rsnd_dai_stream *io,
@@ -297,6 +304,10 @@ struct dma_chan *rsnd_mod_dma_req(struct rsnd_dai_stream *io,
 void rsnd_mod_interrupt(struct rsnd_mod *mod,
 			void (*callback)(struct rsnd_mod *mod,
 					 struct rsnd_dai_stream *io));
+u32 *rsnd_mod_get_status(struct rsnd_dai_stream *io,
+			 struct rsnd_mod *mod,
+			 enum rsnd_mod_type type);
+
 void rsnd_parse_connect_common(struct rsnd_dai *rdai,
 		struct rsnd_mod* (*mod_get)(struct rsnd_priv *priv, int id),
 		struct device_node *node,
@@ -319,7 +330,7 @@ struct rsnd_dai_stream {
 	struct rsnd_mod *mod[RSND_MOD_MAX];
 	struct rsnd_dai_path_info *info; /* rcar_snd.h */
 	struct rsnd_dai *rdai;
-	u32 mod_status[RSND_MOD_MAX];
+	u32 parent_ssi_status;
 	int byte_pos;
 	int period_pos;
 	int byte_per_period;
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index b438538a0a69..516b0c05451c 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -615,7 +615,8 @@ int rsnd_src_probe(struct rsnd_priv *priv)
 		}
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(src),
-				    &rsnd_src_ops, clk, RSND_MOD_SRC, i);
+				    &rsnd_src_ops, clk, rsnd_mod_get_status,
+				    RSND_MOD_SRC, i);
 		if (ret)
 			goto rsnd_src_probe_done;
 
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index df3ab74adf3e..e68f3a1c9cb4 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -857,6 +857,41 @@ int __rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod)
 	return !!(rsnd_ssi_mode_flags(ssi) & RSND_SSI_CLK_PIN_SHARE);
 }
 
+static u32 *rsnd_ssi_get_status(struct rsnd_dai_stream *io,
+				struct rsnd_mod *mod,
+				enum rsnd_mod_type type)
+{
+	/*
+	 * SSIP (= SSI parent) needs to be special, otherwise,
+	 * 2nd SSI might doesn't start. see also rsnd_mod_call()
+	 *
+	 * We can't include parent SSI status on SSI, because we don't know
+	 * how many SSI requests parent SSI. Thus, it is localed on "io" now.
+	 * ex) trouble case
+	 *	Playback: SSI0
+	 *	Capture : SSI1 (needs SSI0)
+	 *
+	 * 1) start Capture  ->	SSI0/SSI1 are started.
+	 * 2) start Playback ->	SSI0 doesn't work, because it is already
+	 *			marked as "started" on 1)
+	 *
+	 * OTOH, using each mod's status is good for MUX case.
+	 * It doesn't need to start in 2nd start
+	 * ex)
+	 *	IO-0: SRC0 -> CTU1 -+-> MUX -> DVC -> SSIU -> SSI0
+	 *			    |
+	 *	IO-1: SRC1 -> CTU2 -+
+	 *
+	 * 1) start IO-0 ->	start SSI0
+	 * 2) start IO-1 ->	SSI0 doesn't need to start, because it is
+	 *			already started on 1)
+	 */
+	if (type == RSND_MOD_SSIP)
+		return &io->parent_ssi_status;
+
+	return rsnd_mod_get_status(io, mod, type);
+}
+
 int rsnd_ssi_probe(struct rsnd_priv *priv)
 {
 	struct device_node *node;
@@ -919,7 +954,7 @@ int rsnd_ssi_probe(struct rsnd_priv *priv)
 			ops = &rsnd_ssi_dma_ops;
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(ssi), ops, clk,
-				    RSND_MOD_SSI, i);
+				    rsnd_ssi_get_status, RSND_MOD_SSI, i);
 		if (ret)
 			goto rsnd_ssi_probe_done;
 
diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 06d72828e5bc..11e55889b401 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -206,7 +206,8 @@ int rsnd_ssiu_probe(struct rsnd_priv *priv)
 
 	for_each_rsnd_ssiu(ssiu, priv, i) {
 		ret = rsnd_mod_init(priv, rsnd_mod_get(ssiu),
-				    ops, NULL, RSND_MOD_SSIU, i);
+				    ops, NULL, rsnd_mod_get_status,
+				    RSND_MOD_SSIU, i);
 		if (ret)
 			return ret;
 	}
-- 
2.7.0.rc3
