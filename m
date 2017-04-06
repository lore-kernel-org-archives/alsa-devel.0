From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: merge rsnd_kctrl_new_m/s/e into rsnd_kctrl_new()" to the asoc tree
Date: Thu, 06 Apr 2017 11:58:22 +0100
Message-ID: <E1cw57O-0004uX-QL@debutante>
References: <87tw623ssy.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87tw623ssy.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: merge rsnd_kctrl_new_m/s/e into rsnd_kctrl_new()

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

>From 32973dcf71ebee8806a6ee552665c5fad6857e16 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Apr 2017 07:25:13 +0000
Subject: [PATCH] ASoC: rsnd: merge rsnd_kctrl_new_m/s/e into rsnd_kctrl_new()

Current rsnd driver is using rsnd_kctrl_new_m/s/e function,
but the differences are very few.
This patch merge these rsnd_kctrl_new_m/s/e into rsnd_kctrl_new

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 96 +++++++++++++++++-------------------------------
 sound/soc/sh/rcar/dvc.c  |  8 ++--
 sound/soc/sh/rcar/rsnd.h | 50 ++++++++++++-------------
 3 files changed, 62 insertions(+), 92 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 35c96e4bbd64..f8eb9d3d1949 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1000,13 +1000,30 @@ static int rsnd_kctrl_put(struct snd_kcontrol *kctrl,
 	return change;
 }
 
-static int __rsnd_kctrl_new(struct rsnd_mod *mod,
-			    struct rsnd_dai_stream *io,
-			    struct snd_soc_pcm_runtime *rtd,
-			    const unsigned char *name,
-			    struct rsnd_kctrl_cfg *cfg,
-			    void (*update)(struct rsnd_dai_stream *io,
-					   struct rsnd_mod *mod))
+struct rsnd_kctrl_cfg *rsnd_kctrl_init_m(struct rsnd_kctrl_cfg_m *cfg)
+{
+	cfg->cfg.val = cfg->val;
+
+	return &cfg->cfg;
+}
+
+struct rsnd_kctrl_cfg *rsnd_kctrl_init_s(struct rsnd_kctrl_cfg_s *cfg)
+{
+	cfg->cfg.val = &cfg->val;
+
+	return &cfg->cfg;
+}
+
+int rsnd_kctrl_new(struct rsnd_mod *mod,
+		   struct rsnd_dai_stream *io,
+		   struct snd_soc_pcm_runtime *rtd,
+		   const unsigned char *name,
+		   void (*update)(struct rsnd_dai_stream *io,
+				  struct rsnd_mod *mod),
+		   struct rsnd_kctrl_cfg *cfg,
+		   const char * const *texts,
+		   int size,
+		   u32 max)
 {
 	struct snd_card *card = rtd->card->snd_card;
 	struct snd_kcontrol *kctrl;
@@ -1021,6 +1038,9 @@ static int __rsnd_kctrl_new(struct rsnd_mod *mod,
 	};
 	int ret;
 
+	if (size > RSND_MAX_CHANNELS)
+		return -EINVAL;
+
 	kctrl = snd_ctl_new1(&knew, mod);
 	if (!kctrl)
 		return -ENOMEM;
@@ -1029,65 +1049,17 @@ static int __rsnd_kctrl_new(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
-	cfg->update = update;
-	cfg->card = card;
-	cfg->kctrl = kctrl;
-	cfg->io = io;
+	cfg->texts	= texts;
+	cfg->max	= max;
+	cfg->size	= size;
+	cfg->update	= update;
+	cfg->card	= card;
+	cfg->kctrl	= kctrl;
+	cfg->io		= io;
 
 	return 0;
 }
 
-int rsnd_kctrl_new_m(struct rsnd_mod *mod,
-		     struct rsnd_dai_stream *io,
-		     struct snd_soc_pcm_runtime *rtd,
-		     const unsigned char *name,
-		     void (*update)(struct rsnd_dai_stream *io,
-				    struct rsnd_mod *mod),
-		     struct rsnd_kctrl_cfg_m *_cfg,
-		     int ch_size,
-		     u32 max)
-{
-	if (ch_size > RSND_MAX_CHANNELS)
-		return -EINVAL;
-
-	_cfg->cfg.max	= max;
-	_cfg->cfg.size	= ch_size;
-	_cfg->cfg.val	= _cfg->val;
-	return __rsnd_kctrl_new(mod, io, rtd, name, &_cfg->cfg, update);
-}
-
-int rsnd_kctrl_new_s(struct rsnd_mod *mod,
-		     struct rsnd_dai_stream *io,
-		     struct snd_soc_pcm_runtime *rtd,
-		     const unsigned char *name,
-		     void (*update)(struct rsnd_dai_stream *io,
-				    struct rsnd_mod *mod),
-		     struct rsnd_kctrl_cfg_s *_cfg,
-		     u32 max)
-{
-	_cfg->cfg.max	= max;
-	_cfg->cfg.size	= 1;
-	_cfg->cfg.val	= &_cfg->val;
-	return __rsnd_kctrl_new(mod, io, rtd, name, &_cfg->cfg, update);
-}
-
-int rsnd_kctrl_new_e(struct rsnd_mod *mod,
-		     struct rsnd_dai_stream *io,
-		     struct snd_soc_pcm_runtime *rtd,
-		     const unsigned char *name,
-		     struct rsnd_kctrl_cfg_s *_cfg,
-		     void (*update)(struct rsnd_dai_stream *io,
-				    struct rsnd_mod *mod),
-		     const char * const *texts,
-		     u32 max)
-{
-	_cfg->cfg.max	= max;
-	_cfg->cfg.size	= 1;
-	_cfg->cfg.val	= &_cfg->val;
-	_cfg->cfg.texts	= texts;
-	return __rsnd_kctrl_new(mod, io, rtd, name, &_cfg->cfg, update);
-}
-
 /*
  *		snd_soc_platform
  */
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 994fdb7d0034..463de8360985 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -285,18 +285,18 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 	ret = rsnd_kctrl_new_e(mod, io, rtd,
 			is_play ?
 			"DVC Out Ramp Up Rate" : "DVC In Ramp Up Rate",
-			&dvc->rup,
 			rsnd_dvc_volume_update,
-			dvc_ramp_rate, ARRAY_SIZE(dvc_ramp_rate));
+			&dvc->rup,
+			dvc_ramp_rate);
 	if (ret < 0)
 		return ret;
 
 	ret = rsnd_kctrl_new_e(mod, io, rtd,
 			is_play ?
 			"DVC Out Ramp Down Rate" : "DVC In Ramp Down Rate",
-			&dvc->rdown,
 			rsnd_dvc_volume_update,
-			dvc_ramp_rate, ARRAY_SIZE(dvc_ramp_rate));
+			&dvc->rdown,
+			dvc_ramp_rate);
 
 	if (ret < 0)
 		return ret;
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 81ef3f18834a..3dc9e06f5943 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -611,32 +611,30 @@ struct rsnd_kctrl_cfg_s {
 	u32 val;
 };
 
-int rsnd_kctrl_new_m(struct rsnd_mod *mod,
-		     struct rsnd_dai_stream *io,
-		     struct snd_soc_pcm_runtime *rtd,
-		     const unsigned char *name,
-		     void (*update)(struct rsnd_dai_stream *io,
-				    struct rsnd_mod *mod),
-		     struct rsnd_kctrl_cfg_m *_cfg,
-		     int ch_size,
-		     u32 max);
-int rsnd_kctrl_new_s(struct rsnd_mod *mod,
-		     struct rsnd_dai_stream *io,
-		     struct snd_soc_pcm_runtime *rtd,
-		     const unsigned char *name,
-		     void (*update)(struct rsnd_dai_stream *io,
-				    struct rsnd_mod *mod),
-		     struct rsnd_kctrl_cfg_s *_cfg,
-		     u32 max);
-int rsnd_kctrl_new_e(struct rsnd_mod *mod,
-		     struct rsnd_dai_stream *io,
-		     struct snd_soc_pcm_runtime *rtd,
-		     const unsigned char *name,
-		     struct rsnd_kctrl_cfg_s *_cfg,
-		     void (*update)(struct rsnd_dai_stream *io,
-				    struct rsnd_mod *mod),
-		     const char * const *texts,
-		     u32 max);
+struct rsnd_kctrl_cfg *rsnd_kctrl_init_m(struct rsnd_kctrl_cfg_m *cfg);
+struct rsnd_kctrl_cfg *rsnd_kctrl_init_s(struct rsnd_kctrl_cfg_s *cfg);
+int rsnd_kctrl_new(struct rsnd_mod *mod,
+		   struct rsnd_dai_stream *io,
+		   struct snd_soc_pcm_runtime *rtd,
+		   const unsigned char *name,
+		   void (*update)(struct rsnd_dai_stream *io,
+				  struct rsnd_mod *mod),
+		   struct rsnd_kctrl_cfg *cfg,
+		   const char * const *texts,
+		   int size,
+		   u32 max);
+
+#define rsnd_kctrl_new_m(mod, io, rtd, name, update, cfg, size, max) \
+	rsnd_kctrl_new(mod, io, rtd, name, update, rsnd_kctrl_init_m(cfg), \
+		       NULL, size, max)
+
+#define rsnd_kctrl_new_s(mod, io, rtd, name, update, cfg, max)	\
+	rsnd_kctrl_new(mod, io, rtd, name, update, rsnd_kctrl_init_s(cfg), \
+		       NULL, 1, max)
+
+#define rsnd_kctrl_new_e(mod, io, rtd, name, update, cfg, texts)	\
+	rsnd_kctrl_new(mod, io, rtd, name, update, rsnd_kctrl_init_s(cfg), \
+		       texts, 1, ARRAY_SIZE(texts))
 
 /*
  *	R-Car SSI
-- 
2.11.0
