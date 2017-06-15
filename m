From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: rename "slots" related variable" to the asoc tree
Date: Thu, 15 Jun 2017 18:20:30 +0100
Message-ID: <E1dLYRa-0001dX-4w@debutante>
References: <87lgoum65n.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87lgoum65n.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: rename "slots" related variable

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

>From 1ff9593d2f27a48fbeeccd7fc253eed2a7102d16 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 15 Jun 2017 00:49:27 +0000
Subject: [PATCH] ASoC: rsnd: rename "slots" related variable

Current Renesas sound driver has slots and slots_num in
struct rsnd_dai, but these are very un-understandable naming
(It had named from TDM slots).
In this driver, the "slots" means total usable channels, and
"stot_num" means SSI lane number if Multi SSI was used.
To more understandable code, this patch renames "slots" to
"max_channels", and "slots_num" to "ssi_lane", and replaces related
functions name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 53 ++++++++++++++++++++++++------------------------
 sound/soc/sh/rcar/dvc.c  |  7 ++++---
 sound/soc/sh/rcar/rsnd.h | 23 ++++++++++++++-------
 sound/soc/sh/rcar/ssi.c  |  3 ++-
 4 files changed, 49 insertions(+), 37 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 1b536d140e49..9b9e898d0df3 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -203,27 +203,6 @@ int rsnd_io_is_working(struct rsnd_dai_stream *io)
 	return !!io->substream;
 }
 
-void rsnd_set_slot(struct rsnd_dai *rdai,
-		   int slots, int num)
-{
-	rdai->slots	= slots;
-	rdai->slots_num	= num;
-}
-
-int rsnd_get_slot(struct rsnd_dai_stream *io)
-{
-	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
-
-	return rdai->slots;
-}
-
-int rsnd_get_slot_num(struct rsnd_dai_stream *io)
-{
-	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
-
-	return rdai->slots_num;
-}
-
 int rsnd_runtime_channel_original(struct rsnd_dai_stream *io)
 {
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
@@ -248,13 +227,14 @@ int rsnd_runtime_channel_after_ctu(struct rsnd_dai_stream *io)
 
 int rsnd_runtime_channel_for_ssi(struct rsnd_dai_stream *io)
 {
+	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 	int chan = rsnd_io_is_play(io) ?
 		rsnd_runtime_channel_after_ctu(io) :
 		rsnd_runtime_channel_original(io);
 
 	/* Use Multi SSI */
 	if (rsnd_runtime_is_ssi_multi(io))
-		chan /= rsnd_get_slot_num(io);
+		chan /= rsnd_rdai_ssi_lane_get(rdai);
 
 	/* TDM Extend Mode needs 8ch */
 	if (chan == 6)
@@ -265,12 +245,13 @@ int rsnd_runtime_channel_for_ssi(struct rsnd_dai_stream *io)
 
 int rsnd_runtime_is_ssi_multi(struct rsnd_dai_stream *io)
 {
-	int slots = rsnd_get_slot_num(io);
+	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
+	int lane = rsnd_rdai_ssi_lane_get(rdai);
 	int chan = rsnd_io_is_play(io) ?
 		rsnd_runtime_channel_after_ctu(io) :
 		rsnd_runtime_channel_original(io);
 
-	return (chan >= 6) && (slots > 1);
+	return (chan > 2) && (lane > 1);
 }
 
 int rsnd_runtime_is_ssi_tdm(struct rsnd_dai_stream *io)
@@ -549,6 +530,24 @@ static void rsnd_dai_disconnect(struct rsnd_mod *mod,
 	io->mod[type] = NULL;
 }
 
+int rsnd_rdai_channels_ctrl(struct rsnd_dai *rdai,
+			    int max_channels)
+{
+	if (max_channels > 0)
+		rdai->max_channels = max_channels;
+
+	return rdai->max_channels;
+}
+
+int rsnd_rdai_ssi_lane_ctrl(struct rsnd_dai *rdai,
+			    int ssi_lane)
+{
+	if (ssi_lane > 0)
+		rdai->ssi_lane = ssi_lane;
+
+	return rdai->ssi_lane;
+}
+
 struct rsnd_dai *rsnd_rdai_get(struct rsnd_priv *priv, int id)
 {
 	if ((id < 0) || (id >= rsnd_rdai_nr(priv)))
@@ -726,7 +725,8 @@ static int rsnd_soc_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	switch (slots) {
 	case 6:
 		/* TDM Extend Mode */
-		rsnd_set_slot(rdai, slots, 1);
+		rsnd_rdai_channels_set(rdai, slots);
+		rsnd_rdai_ssi_lane_set(rdai, 1);
 		break;
 	default:
 		dev_err(dev, "unsupported TDM slots (%d)\n", slots);
@@ -879,7 +879,8 @@ static void __rsnd_dai_probe(struct rsnd_priv *priv,
 
 	rdai->playback.rdai		= rdai;
 	rdai->capture.rdai		= rdai;
-	rsnd_set_slot(rdai, 2, 1); /* default */
+	rsnd_rdai_channels_set(rdai, 2); /* default 2ch */
+	rsnd_rdai_ssi_lane_set(rdai, 1); /* default 1lane */
 
 	for (io_i = 0;; io_i++) {
 		playback = of_parse_phandle(dai_np, "playback", io_i);
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 75af6e742328..99d2d9459e75 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -249,8 +249,9 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 			    struct snd_soc_pcm_runtime *rtd)
 {
 	struct rsnd_dvc *dvc = rsnd_mod_to_dvc(mod);
+	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 	int is_play = rsnd_io_is_play(io);
-	int slots = rsnd_get_slot(io);
+	int channels = rsnd_rdai_channels_get(rdai);
 	int ret;
 
 	/* Volume */
@@ -259,7 +260,7 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 			"DVC Out Playback Volume" : "DVC In Capture Volume",
 			rsnd_kctrl_accept_anytime,
 			rsnd_dvc_volume_update,
-			&dvc->volume, slots,
+			&dvc->volume, channels,
 			0x00800000 - 1);
 	if (ret < 0)
 		return ret;
@@ -270,7 +271,7 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 			"DVC Out Mute Switch" : "DVC In Mute Switch",
 			rsnd_kctrl_accept_anytime,
 			rsnd_dvc_volume_update,
-			&dvc->mute,  slots,
+			&dvc->mute, channels,
 			1);
 	if (ret < 0)
 		return ret;
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index ac4d50d118d1..47162bdf1abc 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -399,11 +399,6 @@ void rsnd_parse_connect_common(struct rsnd_dai *rdai,
 		struct device_node *playback,
 		struct device_node *capture);
 
-void rsnd_set_slot(struct rsnd_dai *rdai,
-		   int slots, int slots_total);
-int rsnd_get_slot(struct rsnd_dai_stream *io);
-int rsnd_get_slot_num(struct rsnd_dai_stream *io);
-
 int rsnd_runtime_channel_original(struct rsnd_dai_stream *io);
 int rsnd_runtime_channel_after_ctu(struct rsnd_dai_stream *io);
 int rsnd_runtime_channel_for_ssi(struct rsnd_dai_stream *io);
@@ -455,8 +450,8 @@ struct rsnd_dai {
 	struct rsnd_dai_stream capture;
 	struct rsnd_priv *priv;
 
-	int slots;
-	int slots_num;
+	int max_channels;	/* 2ch - 16ch */
+	int ssi_lane;		/* 1lane - 4lane */
 
 	unsigned int clk_master:1;
 	unsigned int bit_clk_inv:1;
@@ -476,6 +471,20 @@ struct rsnd_dai {
 
 struct rsnd_dai *rsnd_rdai_get(struct rsnd_priv *priv, int id);
 
+#define rsnd_rdai_channels_set(rdai, max_channels) \
+	rsnd_rdai_channels_ctrl(rdai, max_channels)
+#define rsnd_rdai_channels_get(rdai) \
+	rsnd_rdai_channels_ctrl(rdai, 0)
+int rsnd_rdai_channels_ctrl(struct rsnd_dai *rdai,
+			    int max_channels);
+
+#define rsnd_rdai_ssi_lane_set(rdai, ssi_lane) \
+	rsnd_rdai_ssi_lane_ctrl(rdai, ssi_lane)
+#define rsnd_rdai_ssi_lane_get(rdai) \
+	rsnd_rdai_ssi_lane_ctrl(rdai, 0)
+int rsnd_rdai_ssi_lane_ctrl(struct rsnd_dai *rdai,
+			    int ssi_lane);
+
 void rsnd_dai_period_elapsed(struct rsnd_dai_stream *io);
 int rsnd_dai_connect(struct rsnd_mod *mod,
 		     struct rsnd_dai_stream *io,
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index f7df3b5e2985..6450095eb547 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -897,7 +897,8 @@ static void rsnd_ssi_connect(struct rsnd_mod *mod,
 		type = types[i];
 		if (!rsnd_io_to_mod(io, type)) {
 			rsnd_dai_connect(mod, io, type);
-			rsnd_set_slot(rdai, 2 * (i + 1), (i + 1));
+			rsnd_rdai_channels_set(rdai, (i + 1) * 2);
+			rsnd_rdai_ssi_lane_set(rdai, (i + 1));
 			return;
 		}
 	}
-- 
2.11.0
