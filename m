From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: control kctrl items acceptance anytime/runtime" to the asoc tree
Date: Tue, 13 Jun 2017 22:08:13 +0100
Message-ID: <E1dKt2r-0000Ni-3d@debutante>
References: <87shlm3srx.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87shlm3srx.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: control kctrl items acceptance anytime/runtime

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

>From f0b04d8b442757f7bcad2cd07b54f63910253ebc Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 7 Jun 2017 00:11:48 +0000
Subject: [PATCH] ASoC: rsnd: control kctrl items acceptance anytime/runtime

Current SRC/DVC/CTU adds kctrl for each device,
and SRC can adjust its sampling rate during playback,
thus, this feature should be enabled only *during* playback.
This patch controls it more clearly

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 17 +++++++++++++++++
 sound/soc/sh/rcar/ctu.c  |  6 ++++++
 sound/soc/sh/rcar/dvc.c  |  5 +++++
 sound/soc/sh/rcar/rsnd.h | 16 ++++++++++------
 sound/soc/sh/rcar/src.c  |  2 ++
 5 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 1bf261d677b7..0bb99aa70e29 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1065,6 +1065,9 @@ static int rsnd_kctrl_put(struct snd_kcontrol *kctrl,
 	struct rsnd_kctrl_cfg *cfg = kcontrol_to_cfg(kctrl);
 	int i, change = 0;
 
+	if (!cfg->accept(cfg->io))
+		return 0;
+
 	for (i = 0; i < cfg->size; i++) {
 		if (cfg->texts) {
 			change |= (uc->value.enumerated.item[i] != cfg->val[i]);
@@ -1081,6 +1084,18 @@ static int rsnd_kctrl_put(struct snd_kcontrol *kctrl,
 	return change;
 }
 
+int rsnd_kctrl_accept_anytime(struct rsnd_dai_stream *io)
+{
+	return 1;
+}
+
+int rsnd_kctrl_accept_runtime(struct rsnd_dai_stream *io)
+{
+	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+
+	return !!runtime;
+}
+
 struct rsnd_kctrl_cfg *rsnd_kctrl_init_m(struct rsnd_kctrl_cfg_m *cfg)
 {
 	cfg->cfg.val = cfg->val;
@@ -1099,6 +1114,7 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
 		   struct rsnd_dai_stream *io,
 		   struct snd_soc_pcm_runtime *rtd,
 		   const unsigned char *name,
+		   int (*accept)(struct rsnd_dai_stream *io),
 		   void (*update)(struct rsnd_dai_stream *io,
 				  struct rsnd_mod *mod),
 		   struct rsnd_kctrl_cfg *cfg,
@@ -1133,6 +1149,7 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
 	cfg->texts	= texts;
 	cfg->max	= max;
 	cfg->size	= size;
+	cfg->accept	= accept;
 	cfg->update	= update;
 	cfg->card	= card;
 	cfg->kctrl	= kctrl;
diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 9dcc1f9db026..4ba8f2fe7a4c 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -279,12 +279,14 @@ static int rsnd_ctu_pcm_new(struct rsnd_mod *mod,
 
 	/* CTU Pass */
 	ret = rsnd_kctrl_new_m(mod, io, rtd, "CTU Pass",
+			       rsnd_kctrl_accept_anytime,
 			       NULL,
 			       &ctu->pass, RSND_MAX_CHANNELS,
 			       0xC);
 
 	/* ROW0 */
 	ret = rsnd_kctrl_new_m(mod, io, rtd, "CTU SV0",
+			       rsnd_kctrl_accept_anytime,
 			       NULL,
 			       &ctu->sv0, RSND_MAX_CHANNELS,
 			       0x00FFFFFF);
@@ -293,6 +295,7 @@ static int rsnd_ctu_pcm_new(struct rsnd_mod *mod,
 
 	/* ROW1 */
 	ret = rsnd_kctrl_new_m(mod, io, rtd, "CTU SV1",
+			       rsnd_kctrl_accept_anytime,
 			       NULL,
 			       &ctu->sv1, RSND_MAX_CHANNELS,
 			       0x00FFFFFF);
@@ -301,6 +304,7 @@ static int rsnd_ctu_pcm_new(struct rsnd_mod *mod,
 
 	/* ROW2 */
 	ret = rsnd_kctrl_new_m(mod, io, rtd, "CTU SV2",
+			       rsnd_kctrl_accept_anytime,
 			       NULL,
 			       &ctu->sv2, RSND_MAX_CHANNELS,
 			       0x00FFFFFF);
@@ -309,6 +313,7 @@ static int rsnd_ctu_pcm_new(struct rsnd_mod *mod,
 
 	/* ROW3 */
 	ret = rsnd_kctrl_new_m(mod, io, rtd, "CTU SV3",
+			       rsnd_kctrl_accept_anytime,
 			       NULL,
 			       &ctu->sv3, RSND_MAX_CHANNELS,
 			       0x00FFFFFF);
@@ -317,6 +322,7 @@ static int rsnd_ctu_pcm_new(struct rsnd_mod *mod,
 
 	/* Reset */
 	ret = rsnd_kctrl_new_s(mod, io, rtd, "CTU Reset",
+			       rsnd_kctrl_accept_anytime,
 			       rsnd_ctu_value_reset,
 			       &ctu->reset, 1);
 
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 463de8360985..75af6e742328 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -257,6 +257,7 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 	ret = rsnd_kctrl_new_m(mod, io, rtd,
 			is_play ?
 			"DVC Out Playback Volume" : "DVC In Capture Volume",
+			rsnd_kctrl_accept_anytime,
 			rsnd_dvc_volume_update,
 			&dvc->volume, slots,
 			0x00800000 - 1);
@@ -267,6 +268,7 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 	ret = rsnd_kctrl_new_m(mod, io, rtd,
 			is_play ?
 			"DVC Out Mute Switch" : "DVC In Mute Switch",
+			rsnd_kctrl_accept_anytime,
 			rsnd_dvc_volume_update,
 			&dvc->mute,  slots,
 			1);
@@ -277,6 +279,7 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 	ret = rsnd_kctrl_new_s(mod, io, rtd,
 			is_play ?
 			"DVC Out Ramp Switch" : "DVC In Ramp Switch",
+			rsnd_kctrl_accept_anytime,
 			rsnd_dvc_volume_update,
 			&dvc->ren, 1);
 	if (ret < 0)
@@ -285,6 +288,7 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 	ret = rsnd_kctrl_new_e(mod, io, rtd,
 			is_play ?
 			"DVC Out Ramp Up Rate" : "DVC In Ramp Up Rate",
+			rsnd_kctrl_accept_anytime,
 			rsnd_dvc_volume_update,
 			&dvc->rup,
 			dvc_ramp_rate);
@@ -294,6 +298,7 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 	ret = rsnd_kctrl_new_e(mod, io, rtd,
 			is_play ?
 			"DVC Out Ramp Down Rate" : "DVC In Ramp Down Rate",
+			rsnd_kctrl_accept_anytime,
 			rsnd_dvc_volume_update,
 			&dvc->rdown,
 			dvc_ramp_rate);
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 6de5f7ec6464..ac4d50d118d1 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -598,6 +598,7 @@ struct rsnd_kctrl_cfg {
 	unsigned int size;
 	u32 *val;
 	const char * const *texts;
+	int (*accept)(struct rsnd_dai_stream *io);
 	void (*update)(struct rsnd_dai_stream *io, struct rsnd_mod *mod);
 	struct rsnd_dai_stream *io;
 	struct snd_card *card;
@@ -615,12 +616,15 @@ struct rsnd_kctrl_cfg_s {
 	u32 val;
 };
 
+int rsnd_kctrl_accept_anytime(struct rsnd_dai_stream *io);
+int rsnd_kctrl_accept_runtime(struct rsnd_dai_stream *io);
 struct rsnd_kctrl_cfg *rsnd_kctrl_init_m(struct rsnd_kctrl_cfg_m *cfg);
 struct rsnd_kctrl_cfg *rsnd_kctrl_init_s(struct rsnd_kctrl_cfg_s *cfg);
 int rsnd_kctrl_new(struct rsnd_mod *mod,
 		   struct rsnd_dai_stream *io,
 		   struct snd_soc_pcm_runtime *rtd,
 		   const unsigned char *name,
+		   int (*accept)(struct rsnd_dai_stream *io),
 		   void (*update)(struct rsnd_dai_stream *io,
 				  struct rsnd_mod *mod),
 		   struct rsnd_kctrl_cfg *cfg,
@@ -628,16 +632,16 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
 		   int size,
 		   u32 max);
 
-#define rsnd_kctrl_new_m(mod, io, rtd, name, update, cfg, size, max) \
-	rsnd_kctrl_new(mod, io, rtd, name, update, rsnd_kctrl_init_m(cfg), \
+#define rsnd_kctrl_new_m(mod, io, rtd, name, accept, update, cfg, size, max) \
+	rsnd_kctrl_new(mod, io, rtd, name, accept, update, rsnd_kctrl_init_m(cfg), \
 		       NULL, size, max)
 
-#define rsnd_kctrl_new_s(mod, io, rtd, name, update, cfg, max)	\
-	rsnd_kctrl_new(mod, io, rtd, name, update, rsnd_kctrl_init_s(cfg), \
+#define rsnd_kctrl_new_s(mod, io, rtd, name, accept, update, cfg, max)	\
+	rsnd_kctrl_new(mod, io, rtd, name, accept, update, rsnd_kctrl_init_s(cfg), \
 		       NULL, 1, max)
 
-#define rsnd_kctrl_new_e(mod, io, rtd, name, update, cfg, texts)	\
-	rsnd_kctrl_new(mod, io, rtd, name, update, rsnd_kctrl_init_s(cfg), \
+#define rsnd_kctrl_new_e(mod, io, rtd, name, accept, update, cfg, texts)	\
+	rsnd_kctrl_new(mod, io, rtd, name, accept, update, rsnd_kctrl_init_s(cfg), \
 		       texts, 1, ARRAY_SIZE(texts))
 
 /*
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 8dbe9ebcbff1..7aa239e28491 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -497,6 +497,7 @@ static int rsnd_src_pcm_new(struct rsnd_mod *mod,
 			       rsnd_io_is_play(io) ?
 			       "SRC Out Rate Switch" :
 			       "SRC In Rate Switch",
+			       rsnd_kctrl_accept_anytime,
 			       rsnd_src_set_convert_rate,
 			       &src->sen, 1);
 	if (ret < 0)
@@ -506,6 +507,7 @@ static int rsnd_src_pcm_new(struct rsnd_mod *mod,
 			       rsnd_io_is_play(io) ?
 			       "SRC Out Rate" :
 			       "SRC In Rate",
+			       rsnd_kctrl_accept_runtime,
 			       rsnd_src_set_convert_rate,
 			       &src->sync, 192000);
 
-- 
2.11.0
