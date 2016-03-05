From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add rsnd_runtime_channel_xxx()"
	to the asoc tree
Date: Sat, 05 Mar 2016 21:24:48 +0900
Message-ID: <E1acBGK-0003G2-Nb@finisterre>
References: <87ziup5oer.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 61E5F260831
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:24:55 +0100 (CET)
In-Reply-To: <87ziup5oer.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: add rsnd_runtime_channel_xxx()

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

>From eed76bb811cd143119b4bdeca88606685222e687 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 25 Feb 2016 05:54:58 +0000
Subject: [PATCH] ASoC: rsnd: add rsnd_runtime_channel_xxx()

Current SSI is supporting Normal SSI/Multi mode SSI/TDM mode SSI
and its behavior is based on input channels.
This input channel might be converted by CTU,
and SSI needs to be Multi SSI mode / TDM SSI mode if 6ch input

EX) 6ch input, CTU for 2ch, playback

 6ch    6ch    2ch    2ch    2ch     2ch
 -> SRC -> CTU -> MIX -> DVC -> SSIU -> SSI

EX) 6ch input, no CTU, Multi SSI, playback

 6ch    6ch    6ch    6ch    6ch     2ch
 -> SRC -> CTU -> MIX -> DVC -> SSIU -> SSI0/SSI1/SSI2

Current driver is using rsnd_get_adinr_chan() / rsnd_get_slot_width()
for this purpose, but it is complicated enough without meaning.
This patch adds new rsnd_runtime_channel_xxx() which is caring
CTU/Multi SSI.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 69 +++++++++++++++++++++++++++++-------------------
 sound/soc/sh/rcar/ctu.c  |  2 +-
 sound/soc/sh/rcar/dvc.c  |  2 +-
 sound/soc/sh/rcar/mix.c  |  2 +-
 sound/soc/sh/rcar/rsnd.h |  8 ++++--
 sound/soc/sh/rcar/src.c  |  2 +-
 sound/soc/sh/rcar/ssi.c  | 15 +++++------
 sound/soc/sh/rcar/ssiu.c |  6 +++--
 8 files changed, 62 insertions(+), 44 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 3a3dc2ff18c9..3351a701c60e 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -224,13 +224,36 @@ int rsnd_get_slot_num(struct rsnd_dai_stream *io)
 	return rdai->slots_num;
 }
 
-int rsnd_get_slot_width(struct rsnd_dai_stream *io)
+int rsnd_runtime_channel_original(struct rsnd_dai_stream *io)
 {
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-	int chan = runtime->channels;
 
-	/* Multi channel Mode */
-	if (rsnd_ssi_multi_slaves_runtime(io))
+	return runtime->channels;
+}
+
+int rsnd_runtime_channel_after_ctu(struct rsnd_dai_stream *io)
+{
+	int chan = rsnd_runtime_channel_original(io);
+	struct rsnd_mod *ctu_mod = rsnd_io_to_mod_ctu(io);
+
+	if (ctu_mod) {
+		u32 converted_chan = rsnd_ctu_converted_channel(ctu_mod);
+
+		if (converted_chan)
+			return converted_chan;
+	}
+
+	return chan;
+}
+
+int rsnd_runtime_channel_for_ssi(struct rsnd_dai_stream *io)
+{
+	int chan = rsnd_io_is_play(io) ?
+		rsnd_runtime_channel_after_ctu(io) :
+		rsnd_runtime_channel_original(io);
+
+	/* Use Multi SSI */
+	if (rsnd_runtime_is_ssi_multi(io))
 		chan /= rsnd_get_slot_num(io);
 
 	/* TDM Extend Mode needs 8ch */
@@ -240,6 +263,21 @@ int rsnd_get_slot_width(struct rsnd_dai_stream *io)
 	return chan;
 }
 
+int rsnd_runtime_is_ssi_multi(struct rsnd_dai_stream *io)
+{
+	int slots = rsnd_get_slot_num(io);
+	int chan = rsnd_io_is_play(io) ?
+		rsnd_runtime_channel_after_ctu(io) :
+		rsnd_runtime_channel_original(io);
+
+	return (chan >= 6) && (slots > 1);
+}
+
+int rsnd_runtime_is_ssi_tdm(struct rsnd_dai_stream *io)
+{
+	return rsnd_runtime_channel_for_ssi(io) >= 6;
+}
+
 /*
  *	ADINR function
  */
@@ -261,29 +299,6 @@ u32 rsnd_get_adinr_bit(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	return 0;
 }
 
-u32 rsnd_get_adinr_chan(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
-{
-	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
-	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-	struct device *dev = rsnd_priv_to_dev(priv);
-	u32 chan = runtime->channels;
-
-	switch (chan) {
-	case 1:
-	case 2:
-	case 4:
-	case 6:
-	case 8:
-		break;
-	default:
-		dev_warn(dev, "not supported channel\n");
-		chan = 0;
-		break;
-	}
-
-	return chan;
-}
-
 /*
  *	DALIGN function
  */
diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 784515afefaf..b326966ea407 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -60,7 +60,7 @@ static void rsnd_ctu_value_init(struct rsnd_dai_stream *io,
 {
 	rsnd_mod_write(mod, CTU_CTUIR, 1);
 
-	rsnd_mod_write(mod, CTU_ADINR, rsnd_get_adinr_chan(mod, io));
+	rsnd_mod_write(mod, CTU_ADINR, rsnd_runtime_channel_original(io));
 
 	rsnd_mod_write(mod, CTU_CPMDR, 0);
 	rsnd_mod_write(mod, CTU_SCMDR, 0);
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index d757f1316385..93b11e1c5d7f 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -116,7 +116,7 @@ static void rsnd_dvc_volume_init(struct rsnd_dai_stream *io,
 	u32 vrdbr = 0;
 
 	adinr = rsnd_get_adinr_bit(mod, io) |
-		rsnd_get_adinr_chan(mod, io);
+		rsnd_runtime_channel_after_ctu(io);
 
 	/* Enable Digital Volume, Zero Cross Mute Mode */
 	dvucr |= 0x101;
diff --git a/sound/soc/sh/rcar/mix.c b/sound/soc/sh/rcar/mix.c
index e0e337ad4206..195fc7bb22af 100644
--- a/sound/soc/sh/rcar/mix.c
+++ b/sound/soc/sh/rcar/mix.c
@@ -51,7 +51,7 @@ static void rsnd_mix_volume_init(struct rsnd_dai_stream *io,
 	rsnd_mod_write(mod, MIX_MIXIR, 1);
 
 	/* General Information */
-	rsnd_mod_write(mod, MIX_ADINR, rsnd_get_adinr_chan(mod, io));
+	rsnd_mod_write(mod, MIX_ADINR, rsnd_runtime_channel_after_ctu(io));
 
 	/* volume step */
 	rsnd_mod_write(mod, MIX_MIXMR, 0);
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index bbc89bd1e918..ff53f96e5006 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -193,7 +193,6 @@ void rsnd_force_write(struct rsnd_priv *priv, struct rsnd_mod *mod,
 void rsnd_bset(struct rsnd_priv *priv, struct rsnd_mod *mod, enum rsnd_reg reg,
 		    u32 mask, u32 data);
 u32 rsnd_get_adinr_bit(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
-u32 rsnd_get_adinr_chan(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
 u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
 
 /*
@@ -356,9 +355,14 @@ void rsnd_parse_connect_common(struct rsnd_dai *rdai,
 void rsnd_set_slot(struct rsnd_dai *rdai,
 		   int slots, int slots_total);
 int rsnd_get_slot(struct rsnd_dai_stream *io);
-int rsnd_get_slot_width(struct rsnd_dai_stream *io);
 int rsnd_get_slot_num(struct rsnd_dai_stream *io);
 
+int rsnd_runtime_channel_original(struct rsnd_dai_stream *io);
+int rsnd_runtime_channel_after_ctu(struct rsnd_dai_stream *io);
+int rsnd_runtime_channel_for_ssi(struct rsnd_dai_stream *io);
+int rsnd_runtime_is_ssi_multi(struct rsnd_dai_stream *io);
+int rsnd_runtime_is_ssi_tdm(struct rsnd_dai_stream *io);
+
 /*
  *	R-Car sound DAI
  */
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 03c6314871ff..8e1177aea6b1 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -205,7 +205,7 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	 *	SRC_ADINR
 	 */
 	adinr = rsnd_get_adinr_bit(mod, io) |
-		rsnd_get_adinr_chan(mod, io);
+		rsnd_runtime_channel_original(io);
 
 	/*
 	 *	SRC_IFSCR / SRC_IFSVR
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 0979db8af8f9..540489755367 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -180,11 +180,8 @@ static u32 rsnd_ssi_run_mods(struct rsnd_dai_stream *io)
 
 u32 rsnd_ssi_multi_slaves_runtime(struct rsnd_dai_stream *io)
 {
-	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-	u32 mask = rsnd_ssi_multi_slaves(io);
-
-	if (mask && (runtime->channels >= 6))
-		return mask;
+	if (rsnd_runtime_is_ssi_multi(io))
+		return rsnd_ssi_multi_slaves(io);
 
 	return 0;
 }
@@ -198,7 +195,7 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	struct rsnd_mod *ssi_parent_mod = rsnd_io_to_mod_ssip(io);
-	int slots = rsnd_get_slot_width(io);
+	int chan = rsnd_runtime_channel_for_ssi(io);
 	int j, ret;
 	int ssi_clk_mul_table[] = {
 		1, 2, 4, 8, 16, 6, 12,
@@ -231,10 +228,10 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 
 		/*
 		 * this driver is assuming that
-		 * system word is 32bit x slots
+		 * system word is 32bit x chan
 		 * see rsnd_ssi_init()
 		 */
-		main_rate = rate * 32 * slots * ssi_clk_mul_table[j];
+		main_rate = rate * 32 * chan * ssi_clk_mul_table[j];
 
 		ret = rsnd_adg_ssi_clk_try_start(mod, main_rate);
 		if (0 == ret) {
@@ -289,7 +286,7 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 	u32 wsr;
 	int is_tdm;
 
-	is_tdm = (rsnd_get_slot_width(io) >= 6) ? 1 : 0;
+	is_tdm = rsnd_runtime_is_ssi_tdm(io);
 
 	/*
 	 * always use 32bit system word.
diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 0d964a0a3e31..6f9b388ec5a8 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -105,7 +105,7 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
-	if (rsnd_get_slot_width(io) >= 6) {
+	if (rsnd_runtime_is_ssi_tdm(io)) {
 		/*
 		 * TDM Extend Mode
 		 * see
@@ -117,7 +117,9 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 	if (rsnd_ssi_use_busif(io)) {
 		rsnd_mod_write(mod, SSI_BUSIF_ADINR,
 			       rsnd_get_adinr_bit(mod, io) |
-			       rsnd_get_adinr_chan(mod, io));
+			       (rsnd_io_is_play(io) ?
+				rsnd_runtime_channel_after_ctu(io) :
+				rsnd_runtime_channel_original(io)));
 		rsnd_mod_write(mod, SSI_BUSIF_MODE,  1);
 		rsnd_mod_write(mod, SSI_BUSIF_DALIGN,
 			       rsnd_get_dalign(mod, io));
-- 
2.7.0
