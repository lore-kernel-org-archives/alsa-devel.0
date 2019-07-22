From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 3/3] ASoC: rsnd: call .hw_{params,free} in pair for same stream
Date: Mon, 22 Jul 2019 16:24:03 +0900
Message-ID: <20190722072403.11008-4-jiada_wang@mentor.com>
References: <20190722072403.11008-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722072403.11008-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
Cc: twischer@de.adit-jv.com, jiada_wang@mentor.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Currently usrcnt is {in,de}cremented in .hw_{params,free} callbacks,
but .hw_free may be called multiple times without calling .hw_params.
this causes the usrcnt be decremented wrongly.

This patch allows .hw_{params,free} to be called only in pairs for
the same stream which balances the {in,de}crement of usrcnt.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 sound/soc/sh/rcar/core.c |  6 ++++--
 sound/soc/sh/rcar/rsnd.h | 24 ++++++++++++++++++++++--
 sound/soc/sh/rcar/ssi.c  |  8 ++++++--
 sound/soc/sh/rcar/ssiu.c |  3 ++-
 4 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index bda5b958d0dc..b9330bdadbd3 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -172,7 +172,8 @@ char *rsnd_mod_name(struct rsnd_mod *mod)
 
 u32 *rsnd_mod_get_status(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
-			 enum rsnd_mod_type type)
+			 enum rsnd_mod_type type,
+			 int flag)
 {
 	return &mod->status;
 }
@@ -548,7 +549,8 @@ static int rsnd_status_update(u32 *status,
 	enum rsnd_mod_type *types = rsnd_mod_sequence[is_play];		\
 	for_each_rsnd_mod_arrays(i, mod, io, types, RSND_MOD_MAX) {	\
 		int tmp = 0;						\
-		u32 *status = mod->ops->get_status(mod, io, types[i]);	\
+		u32 *status = mod->ops->get_status(mod, io, types[i],	\
+						__rsnd_mod_flag_##fn);	\
 		int func_call = rsnd_status_update(status,		\
 						__rsnd_mod_shift_##fn,	\
 						__rsnd_mod_add_##fn,	\
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index ea6cbaa9743e..b4e3e9289f8a 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -238,6 +238,7 @@ enum rsnd_reg {
 #define SSI9_BUSIF_DALIGN(i)	(SSI9_BUSIF0_DALIGN + (i))
 #define SSI_SYS_STATUS(i)	(SSI_SYS_STATUS0 + (i))
 
+#define RSND_STATUS_ON_IO	BIT(0)
 
 struct rsnd_priv;
 struct rsnd_mod;
@@ -332,7 +333,8 @@ struct rsnd_mod_ops {
 		       struct snd_pcm_substream *substream);
 	u32 *(*get_status)(struct rsnd_mod *mod,
 			   struct rsnd_dai_stream *io,
-			   enum rsnd_mod_type type);
+			   enum rsnd_mod_type type,
+			   int flag);
 	int (*id)(struct rsnd_mod *mod);
 	int (*id_sub)(struct rsnd_mod *mod);
 	int (*id_cmd)(struct rsnd_mod *mod);
@@ -379,6 +381,22 @@ struct rsnd_mod {
 #define __rsnd_mod_shift_prepare	28 /* always called */
 #define __rsnd_mod_shift_cleanup	28 /* always called */
 
+#define __rsnd_mod_flag_init		0
+#define __rsnd_mod_flag_quit		0
+#define __rsnd_mod_flag_start		0
+#define __rsnd_mod_flag_stop		0
+#define __rsnd_mod_flag_hw_params	RSND_STATUS_ON_IO
+#define __rsnd_mod_flag_hw_free		RSND_STATUS_ON_IO
+#define __rsnd_mod_flag_probe		0
+#define __rsnd_mod_flag_remove		0
+#define __rsnd_mod_flag_irq		0
+#define __rsnd_mod_flag_pcm_new		0
+#define __rsnd_mod_flag_fallback	0
+#define __rsnd_mod_flag_pointer		0
+#define __rsnd_mod_flag_prepare		0
+#define __rsnd_mod_flag_cleanup		0
+#define __rsnd_mod_flag_set_fmt		0
+
 #define __rsnd_mod_add_probe		0
 #define __rsnd_mod_add_remove		0
 #define __rsnd_mod_add_prepare		0
@@ -428,7 +446,8 @@ void rsnd_mod_interrupt(struct rsnd_mod *mod,
 					 struct rsnd_dai_stream *io));
 u32 *rsnd_mod_get_status(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
-			 enum rsnd_mod_type type);
+			 enum rsnd_mod_type type,
+			 int flag);
 int rsnd_mod_id(struct rsnd_mod *mod);
 int rsnd_mod_id_raw(struct rsnd_mod *mod);
 int rsnd_mod_id_sub(struct rsnd_mod *mod);
@@ -496,6 +515,7 @@ struct rsnd_dai_stream {
 	u32 converted_rate;      /* converted sampling rate */
 	int converted_chan;      /* converted channels */
 	u32 parent_ssi_status;
+	u32 status;
 	u32 flags;
 };
 
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index f43937d2c588..89b4029b290b 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -681,7 +681,8 @@ static irqreturn_t rsnd_ssi_interrupt(int irq, void *data)
 
 static u32 *rsnd_ssi_get_status(struct rsnd_mod *mod,
 				struct rsnd_dai_stream *io,
-				enum rsnd_mod_type type)
+				enum rsnd_mod_type type,
+				int flag)
 {
 	/*
 	 * SSIP (= SSI parent) needs to be special, otherwise,
@@ -711,7 +712,10 @@ static u32 *rsnd_ssi_get_status(struct rsnd_mod *mod,
 	if (type == RSND_MOD_SSIP)
 		return &io->parent_ssi_status;
 
-	return rsnd_mod_get_status(mod, io, type);
+	if (flag && RSND_STATUS_ON_IO)
+		return &io->status;
+
+	return rsnd_mod_get_status(mod, io, type, flag);
 }
 
 /*
diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index f35d88211887..45e4cd84fbc4 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -47,7 +47,8 @@ static const int gen3_id[] = { 0, 8, 16, 24, 32, 40, 41, 42, 43, 44 };
 
 static u32 *rsnd_ssiu_get_status(struct rsnd_mod *mod,
 				 struct rsnd_dai_stream *io,
-				 enum rsnd_mod_type type)
+				 enum rsnd_mod_type type,
+				 int flag)
 {
 	struct rsnd_ssiu *ssiu = rsnd_mod_to_ssiu(mod);
 	int busif = rsnd_mod_id_sub(mod);
-- 
2.19.2
