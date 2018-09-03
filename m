From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add support for 16/24 bit slot
	widths" to the asoc tree
Date: Mon,  3 Sep 2018 14:46:32 +0100 (BST)
Message-ID: <20180903134632.7335611227AE@debutante.sirena.org.uk>
References: <87a7ozf4np.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 22ED726789B
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 15:46:32 +0200 (CEST)
In-Reply-To: <87a7ozf4np.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Jiada Wang <jiada_wang@mentor.com>, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add support for 16/24 bit slot widths

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From fb2815f44a9eb341ed8990263855a266960a5135 Mon Sep 17 00:00:00 2001
From: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Date: Mon, 3 Sep 2018 07:05:42 +0000
Subject: [PATCH] ASoC: rsnd: add support for 16/24 bit slot widths

The slot width (system word length) was fixed at 32 bits.
This patch allows also setting it to 16 or 24 bits.

Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
[Kuninori: tidyup for upstream]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 32 ++++++++++++++++++------
 sound/soc/sh/rcar/rsnd.h |  8 +++++-
 sound/soc/sh/rcar/ssi.c  | 54 +++++++++++++++++++++++++++++-----------
 3 files changed, 72 insertions(+), 22 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index ab7e317bbed8..ce0a3a61c441 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -540,6 +540,14 @@ int rsnd_rdai_ssi_lane_ctrl(struct rsnd_dai *rdai,
 	return rdai->ssi_lane;
 }
 
+int rsnd_rdai_width_ctrl(struct rsnd_dai *rdai, int width)
+{
+	if (width > 0)
+		rdai->chan_width = width;
+
+	return rdai->chan_width;
+}
+
 struct rsnd_dai *rsnd_rdai_get(struct rsnd_priv *priv, int id)
 {
 	if ((id < 0) || (id >= rsnd_rdai_nr(priv)))
@@ -720,6 +728,16 @@ static int rsnd_soc_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
 	struct device *dev = rsnd_priv_to_dev(priv);
 
+	switch (slot_width) {
+	case 16:
+	case 24:
+	case 32:
+		break;
+	default:
+		dev_err(dev, "unsupported slot width value: %d\n", slot_width);
+		return -EINVAL;
+	}
+
 	switch (slots) {
 	case 2:
 	case 6:
@@ -727,6 +745,7 @@ static int rsnd_soc_set_dai_tdm_slot(struct snd_soc_dai *dai,
 		/* TDM Extend Mode */
 		rsnd_rdai_channels_set(rdai, slots);
 		rsnd_rdai_ssi_lane_set(rdai, 1);
+		rsnd_rdai_width_set(rdai, slot_width);
 		break;
 	default:
 		dev_err(dev, "unsupported TDM slots (%d)\n", slots);
@@ -755,7 +774,7 @@ static unsigned int rsnd_soc_hw_rate_list[] = {
 	192000,
 };
 
-static int rsnd_soc_hw_rule(struct rsnd_priv *priv,
+static int rsnd_soc_hw_rule(struct rsnd_dai *rdai,
 			    unsigned int *list, int list_num,
 			    struct snd_interval *baseline, struct snd_interval *iv)
 {
@@ -772,14 +791,14 @@ static int rsnd_soc_hw_rule(struct rsnd_priv *priv,
 		if (!snd_interval_test(iv, list[i]))
 			continue;
 
-		rate = rsnd_ssi_clk_query(priv,
+		rate = rsnd_ssi_clk_query(rdai,
 					  baseline->min, list[i], NULL);
 		if (rate > 0) {
 			p.min = min(p.min, list[i]);
 			p.max = max(p.max, list[i]);
 		}
 
-		rate = rsnd_ssi_clk_query(priv,
+		rate = rsnd_ssi_clk_query(rdai,
 					  baseline->max, list[i], NULL);
 		if (rate > 0) {
 			p.min = min(p.min, list[i]);
@@ -799,7 +818,6 @@ static int __rsnd_soc_hw_rule_rate(struct snd_pcm_hw_params *params,
 	struct snd_interval ic;
 	struct snd_soc_dai *dai = rule->private;
 	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
-	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
 	struct rsnd_dai_stream *io = is_play ? &rdai->playback : &rdai->capture;
 
 	/*
@@ -811,7 +829,7 @@ static int __rsnd_soc_hw_rule_rate(struct snd_pcm_hw_params *params,
 	ic.min =
 	ic.max = rsnd_runtime_channel_for_ssi_with_params(io, params);
 
-	return rsnd_soc_hw_rule(priv, rsnd_soc_hw_rate_list,
+	return rsnd_soc_hw_rule(rdai, rsnd_soc_hw_rate_list,
 				ARRAY_SIZE(rsnd_soc_hw_rate_list),
 				&ic, ir);
 }
@@ -837,7 +855,6 @@ static int __rsnd_soc_hw_rule_channels(struct snd_pcm_hw_params *params,
 	struct snd_interval ic;
 	struct snd_soc_dai *dai = rule->private;
 	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
-	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
 	struct rsnd_dai_stream *io = is_play ? &rdai->playback : &rdai->capture;
 
 	/*
@@ -849,7 +866,7 @@ static int __rsnd_soc_hw_rule_channels(struct snd_pcm_hw_params *params,
 	ic.min =
 	ic.max = rsnd_runtime_channel_for_ssi_with_params(io, params);
 
-	return rsnd_soc_hw_rule(priv, rsnd_soc_hw_channels_list,
+	return rsnd_soc_hw_rule(rdai, rsnd_soc_hw_channels_list,
 				ARRAY_SIZE(rsnd_soc_hw_channels_list),
 				ir, &ic);
 }
@@ -1072,6 +1089,7 @@ static void __rsnd_dai_probe(struct rsnd_priv *priv,
 	rdai->capture.rdai		= rdai;
 	rsnd_rdai_channels_set(rdai, 2); /* default 2ch */
 	rsnd_rdai_ssi_lane_set(rdai, 1); /* default 1lane */
+	rsnd_rdai_width_set(rdai, 32);   /* default 32bit width */
 
 	for (io_i = 0;; io_i++) {
 		playback = of_parse_phandle(dai_np, "playback", io_i);
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 96d93330b1e1..698b08155b06 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -460,6 +460,7 @@ struct rsnd_dai {
 
 	int max_channels;	/* 2ch - 16ch */
 	int ssi_lane;		/* 1lane - 4lane */
+	int chan_width;		/* 16/24/32 bit width */
 
 	unsigned int clk_master:1;
 	unsigned int bit_clk_inv:1;
@@ -493,6 +494,11 @@ int rsnd_rdai_channels_ctrl(struct rsnd_dai *rdai,
 int rsnd_rdai_ssi_lane_ctrl(struct rsnd_dai *rdai,
 			    int ssi_lane);
 
+#define rsnd_rdai_width_set(rdai, width) \
+	rsnd_rdai_width_ctrl(rdai, width)
+#define rsnd_rdai_width_get(rdai) \
+	rsnd_rdai_width_ctrl(rdai, 0)
+int rsnd_rdai_width_ctrl(struct rsnd_dai *rdai, int width);
 void rsnd_dai_period_elapsed(struct rsnd_dai_stream *io);
 int rsnd_dai_connect(struct rsnd_mod *mod,
 		     struct rsnd_dai_stream *io,
@@ -702,7 +708,7 @@ int __rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod);
 void rsnd_parse_connect_ssi(struct rsnd_dai *rdai,
 			    struct device_node *playback,
 			    struct device_node *capture);
-unsigned int rsnd_ssi_clk_query(struct rsnd_priv *priv,
+unsigned int rsnd_ssi_clk_query(struct rsnd_dai *rdai,
 		       int param1, int param2, int *idx);
 
 /*
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 8304e4ec9242..f707f53748bd 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -42,7 +42,13 @@
 #define	DWL_24		(5 << 19)	/* Data Word Length */
 #define	DWL_32		(6 << 19)	/* Data Word Length */
 
+/*
+ * System word length
+ */
+#define	SWL_16		(1 << 16)	/* R/W System Word Length */
+#define	SWL_24		(2 << 16)	/* R/W System Word Length */
 #define	SWL_32		(3 << 16)	/* R/W System Word Length */
+
 #define	SCKD		(1 << 15)	/* Serial Bit Clock Direction */
 #define	SWSD		(1 << 14)	/* Serial WS Direction */
 #define	SCKP		(1 << 13)	/* Serial Bit Clock Polarity */
@@ -220,14 +226,32 @@ u32 rsnd_ssi_multi_slaves_runtime(struct rsnd_dai_stream *io)
 	return 0;
 }
 
-unsigned int rsnd_ssi_clk_query(struct rsnd_priv *priv,
+static u32 rsnd_rdai_width_to_swl(struct rsnd_dai *rdai)
+{
+	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
+	struct device *dev = rsnd_priv_to_dev(priv);
+	int width = rsnd_rdai_width_get(rdai);
+
+	switch (width) {
+	case 32: return SWL_32;
+	case 24: return SWL_24;
+	case 16: return SWL_16;
+	}
+
+	dev_err(dev, "unsupported slot width value: %d\n", width);
+	return 0;
+}
+
+unsigned int rsnd_ssi_clk_query(struct rsnd_dai *rdai,
 		       int param1, int param2, int *idx)
 {
+	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
 	int ssi_clk_mul_table[] = {
 		1, 2, 4, 8, 16, 6, 12,
 	};
 	int j, ret;
 	unsigned int main_rate;
+	int width = rsnd_rdai_width_get(rdai);
 
 	for (j = 0; j < ARRAY_SIZE(ssi_clk_mul_table); j++) {
 
@@ -240,12 +264,7 @@ unsigned int rsnd_ssi_clk_query(struct rsnd_priv *priv,
 		if (j == 0)
 			continue;
 
-		/*
-		 * this driver is assuming that
-		 * system word is 32bit x chan
-		 * see rsnd_ssi_init()
-		 */
-		main_rate = 32 * param1 * param2 * ssi_clk_mul_table[j];
+		main_rate = width * param1 * param2 * ssi_clk_mul_table[j];
 
 		ret = rsnd_adg_clk_query(priv, main_rate);
 		if (ret < 0)
@@ -292,7 +311,7 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 		return 0;
 	}
 
-	main_rate = rsnd_ssi_clk_query(priv, rate, chan, &idx);
+	main_rate = rsnd_ssi_clk_query(rdai, rate, chan, &idx);
 	if (!main_rate) {
 		dev_err(dev, "unsupported clock rate\n");
 		return -EIO;
@@ -312,7 +331,8 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	 * SSICR  : FORCE, SCKD, SWSD
 	 * SSIWSR : CONT
 	 */
-	ssi->cr_clk = FORCE | SWL_32 | SCKD | SWSD | CKDV(idx);
+	ssi->cr_clk = FORCE | rsnd_rdai_width_to_swl(rdai) |
+			SCKD | SWSD | CKDV(idx);
 	ssi->wsr = CONT;
 	ssi->rate = rate;
 
@@ -357,11 +377,7 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 
 	is_tdm = rsnd_runtime_is_ssi_tdm(io);
 
-	/*
-	 * always use 32bit system word.
-	 * see also rsnd_ssi_master_clk_enable()
-	 */
-	cr_own |= FORCE | SWL_32;
+	cr_own |= FORCE | rsnd_rdai_width_to_swl(rdai);
 
 	if (rdai->bit_clk_inv)
 		cr_own |= SCKP;
@@ -494,7 +510,17 @@ static int rsnd_ssi_hw_params(struct rsnd_mod *mod,
 			      struct snd_pcm_hw_params *params)
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
+	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 	int chan = params_channels(params);
+	unsigned int fmt_width = snd_pcm_format_width(params_format(params));
+
+	if (fmt_width > rdai->chan_width) {
+		struct rsnd_priv *priv = rsnd_io_to_priv(io);
+		struct device *dev = rsnd_priv_to_dev(priv);
+
+		dev_err(dev, "invalid combination of slot-width and format-data-width\n");
+		return -EINVAL;
+	}
 
 	/*
 	 * snd_pcm_ops::hw_params will be called *before*
-- 
2.19.0.rc1
