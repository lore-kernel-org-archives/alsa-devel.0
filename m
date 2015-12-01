From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: dvc enables non-stereo sound" to
	the asoc tree
Date: Tue, 01 Dec 2015 22:59:51 +0000
Message-ID: <E1a3ttn-0006hm-LA@debutante>
References: <87two3swe6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 556F626646A
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:56 +0100 (CET)
In-Reply-To: <87two3swe6.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: dvc enables non-stereo sound

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

>From 42ab9a791bd1fb6ad5a47ad66727dcd66093b1ae Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 30 Nov 2015 08:53:44 +0000
Subject: [PATCH] ASoC: rsnd: dvc enables non-stereo sound

Current DVC is assuming that the sound is always stereo.
This patch makes it more flexible

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c |  6 +++++-
 sound/soc/sh/rcar/dvc.c  | 14 ++++++++++++--
 sound/soc/sh/rcar/gen.c  |  6 ++++++
 sound/soc/sh/rcar/rsnd.h |  9 ++++++++-
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index f990b4cb7192..7d364d7505a1 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -871,10 +871,14 @@ int rsnd_kctrl_new_m(struct rsnd_mod *mod,
 		     void (*update)(struct rsnd_dai_stream *io,
 				    struct rsnd_mod *mod),
 		     struct rsnd_kctrl_cfg_m *_cfg,
+		     int ch_size,
 		     u32 max)
 {
+	if (ch_size > RSND_DVC_CHANNELS)
+		return -EINVAL;
+
 	_cfg->cfg.max	= max;
-	_cfg->cfg.size	= RSND_DVC_CHANNELS;
+	_cfg->cfg.size	= ch_size;
 	_cfg->cfg.val	= _cfg->val;
 	return __rsnd_kctrl_new(mod, io, rtd, name, &_cfg->cfg, update);
 }
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 91c86ee1fecb..66aeea8e0069 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -97,6 +97,12 @@ static void rsnd_dvc_volume_parameter(struct rsnd_dai_stream *io,
 	/* Enable Digital Volume */
 	rsnd_mod_write(mod, DVC_VOL0R, val[0]);
 	rsnd_mod_write(mod, DVC_VOL1R, val[1]);
+	rsnd_mod_write(mod, DVC_VOL2R, val[2]);
+	rsnd_mod_write(mod, DVC_VOL3R, val[3]);
+	rsnd_mod_write(mod, DVC_VOL4R, val[4]);
+	rsnd_mod_write(mod, DVC_VOL5R, val[5]);
+	rsnd_mod_write(mod, DVC_VOL6R, val[6]);
+	rsnd_mod_write(mod, DVC_VOL7R, val[7]);
 }
 
 static void rsnd_dvc_volume_init(struct rsnd_dai_stream *io,
@@ -236,8 +242,10 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 			    struct rsnd_dai_stream *io,
 			    struct snd_soc_pcm_runtime *rtd)
 {
+	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 	struct rsnd_dvc *dvc = rsnd_mod_to_dvc(mod);
 	int is_play = rsnd_io_is_play(io);
+	int slots = rsnd_get_slot_rdai(rdai);
 	int ret;
 
 	/* Volume */
@@ -245,7 +253,8 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 			is_play ?
 			"DVC Out Playback Volume" : "DVC In Capture Volume",
 			rsnd_dvc_volume_update,
-			&dvc->volume, 0x00800000 - 1);
+			&dvc->volume, slots,
+			0x00800000 - 1);
 	if (ret < 0)
 		return ret;
 
@@ -254,7 +263,8 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 			is_play ?
 			"DVC Out Mute Switch" : "DVC In Mute Switch",
 			rsnd_dvc_volume_update,
-			&dvc->mute, 1);
+			&dvc->mute,  slots,
+			1);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 364708c73418..2151aa5e161b 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -277,6 +277,12 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 		RSND_GEN_M_REG(DVC_VRDBR,	0xe20,	0x100),
 		RSND_GEN_M_REG(DVC_VOL0R,	0xe28,	0x100),
 		RSND_GEN_M_REG(DVC_VOL1R,	0xe2c,	0x100),
+		RSND_GEN_M_REG(DVC_VOL2R,	0xe30,	0x100),
+		RSND_GEN_M_REG(DVC_VOL3R,	0xe34,	0x100),
+		RSND_GEN_M_REG(DVC_VOL4R,	0xe38,	0x100),
+		RSND_GEN_M_REG(DVC_VOL5R,	0xe3c,	0x100),
+		RSND_GEN_M_REG(DVC_VOL6R,	0xe40,	0x100),
+		RSND_GEN_M_REG(DVC_VOL7R,	0xe44,	0x100),
 		RSND_GEN_M_REG(DVC_DVUER,	0xe48,	0x100),
 	};
 	const static struct rsnd_regmap_field_conf conf_adg[] = {
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 38fd212ffe5a..2111bf32e789 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -101,6 +101,12 @@ enum rsnd_reg {
 	RSND_REG_DVC_ZCMCR,
 	RSND_REG_DVC_VOL0R,
 	RSND_REG_DVC_VOL1R,
+	RSND_REG_DVC_VOL2R,
+	RSND_REG_DVC_VOL3R,
+	RSND_REG_DVC_VOL4R,
+	RSND_REG_DVC_VOL5R,
+	RSND_REG_DVC_VOL6R,
+	RSND_REG_DVC_VOL7R,
 	RSND_REG_DVC_DVUER,
 	RSND_REG_DVC_VRCTR,		/* Gen2 only */
 	RSND_REG_DVC_VRPDR,		/* Gen2 only */
@@ -476,7 +482,7 @@ struct rsnd_kctrl_cfg {
 	struct snd_kcontrol *kctrl;
 };
 
-#define RSND_DVC_CHANNELS	2
+#define RSND_DVC_CHANNELS	8
 struct rsnd_kctrl_cfg_m {
 	struct rsnd_kctrl_cfg cfg;
 	u32 val[RSND_DVC_CHANNELS];
@@ -497,6 +503,7 @@ int rsnd_kctrl_new_m(struct rsnd_mod *mod,
 		     void (*update)(struct rsnd_dai_stream *io,
 				    struct rsnd_mod *mod),
 		     struct rsnd_kctrl_cfg_m *_cfg,
+		     int ch_size,
 		     u32 max);
 int rsnd_kctrl_new_s(struct rsnd_mod *mod,
 		     struct rsnd_dai_stream *io,
-- 
2.6.2
