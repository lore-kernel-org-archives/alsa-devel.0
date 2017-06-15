From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add rsnd_soc_hw_rule/constraint()" to the asoc tree
Date: Thu, 15 Jun 2017 18:20:12 +0100
Message-ID: <E1dLYRI-0001aV-CF@debutante>
References: <87h8zim647.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87h8zim647.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add rsnd_soc_hw_rule/constraint()

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

>From 8cc03722403a5153054993388857e4e565dcdfb1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 15 Jun 2017 00:50:19 +0000
Subject: [PATCH] ASoC: rsnd: add rsnd_soc_hw_rule/constraint()

Current Renesas sound driver is assuming that all Sampling rate and
channles are possible to use, but these are depends on inputed clock
and SSI connection situation.
For example, if it is using 1 SSI, enabled TDM mode and has 12288000
input clock, 2ch output can support until 192000Hz, but 6ch output can
support until 64000Hz, 8ch can support 48000Hz.
To control these situation correctly, it needs to support
hw_constraints / refine feature.

To support such feature, this patch adds new
rsnd_soc_hw_rule/constraint() which adds hw rule of Channel and
Sampling Rate.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/sh/rcar/rsnd.h |   1 +
 2 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 9b9e898d0df3..4892c0a4b613 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -723,7 +723,10 @@ static int rsnd_soc_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	struct device *dev = rsnd_priv_to_dev(priv);
 
 	switch (slots) {
+	case 2:
 	case 6:
+	case 8:
+	case 16:
 		/* TDM Extend Mode */
 		rsnd_rdai_channels_set(rdai, slots);
 		rsnd_rdai_ssi_lane_set(rdai, 1);
@@ -736,6 +739,151 @@ static int rsnd_soc_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	return 0;
 }
 
+static unsigned int rsnd_soc_hw_channels_list[] = {
+	2, 6, 8, 16,
+};
+
+static unsigned int rsnd_soc_hw_rate_list[] = {
+	  8000,
+	 11025,
+	 16000,
+	 22050,
+	 32000,
+	 44100,
+	 48000,
+	 64000,
+	 88200,
+	 96000,
+	176400,
+	192000,
+};
+
+static int rsnd_soc_hw_rule(struct rsnd_priv *priv,
+			    unsigned int *list, int list_num,
+			    struct snd_interval *baseline, struct snd_interval *iv)
+{
+	struct snd_interval p;
+	int rate;
+	int i;
+
+	snd_interval_any(&p);
+	p.min = UINT_MAX;
+	p.max = 0;
+
+	for (i = 0; i < list_num; i++) {
+
+		if (!snd_interval_test(iv, list[i]))
+			continue;
+
+		rate = rsnd_ssi_clk_query(priv,
+					  baseline->min, list[i], NULL);
+		if (rate > 0) {
+			p.min = min(p.min, list[i]);
+			p.max = max(p.max, list[i]);
+		}
+
+		rate = rsnd_ssi_clk_query(priv,
+					  baseline->max, list[i], NULL);
+		if (rate > 0) {
+			p.min = min(p.min, list[i]);
+			p.max = max(p.max, list[i]);
+		}
+	}
+
+	return snd_interval_refine(iv, &p);
+}
+
+static int rsnd_soc_hw_rule_rate(struct snd_pcm_hw_params *params,
+				 struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *ic_ = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval *ir = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval ic;
+	struct snd_soc_dai *dai = rule->private;
+	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
+	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
+
+	/*
+	 * possible sampling rate limitation is same as
+	 * 2ch if it supports multi ssi
+	 */
+	ic = *ic_;
+	if (1 < rsnd_rdai_ssi_lane_get(rdai)) {
+		ic.min = 2;
+		ic.max = 2;
+	}
+
+	return rsnd_soc_hw_rule(priv, rsnd_soc_hw_rate_list,
+				ARRAY_SIZE(rsnd_soc_hw_rate_list),
+				&ic, ir);
+}
+
+
+static int rsnd_soc_hw_rule_channels(struct snd_pcm_hw_params *params,
+				     struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *ic_ = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval *ir = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval ic;
+	struct snd_soc_dai *dai = rule->private;
+	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
+	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
+
+	/*
+	 * possible sampling rate limitation is same as
+	 * 2ch if it supports multi ssi
+	 */
+	ic = *ic_;
+	if (1 < rsnd_rdai_ssi_lane_get(rdai)) {
+		ic.min = 2;
+		ic.max = 2;
+	}
+
+	return rsnd_soc_hw_rule(priv, rsnd_soc_hw_channels_list,
+				ARRAY_SIZE(rsnd_soc_hw_channels_list),
+				ir, &ic);
+}
+
+static void rsnd_soc_hw_constraint(struct snd_pcm_runtime *runtime,
+				   struct snd_soc_dai *dai)
+{
+	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
+	struct snd_pcm_hw_constraint_list *constraint = &rdai->constraint;
+	unsigned int max_channels = rsnd_rdai_channels_get(rdai);
+	int i;
+
+	/*
+	 * Channel Limitation
+	 * It depends on Platform design
+	 */
+	constraint->list	= rsnd_soc_hw_channels_list;
+	constraint->count	= 0;
+	constraint->mask	= 0;
+
+	for (i = 0; i < ARRAY_SIZE(rsnd_soc_hw_channels_list); i++) {
+		if (rsnd_soc_hw_channels_list[i] > max_channels)
+			break;
+		constraint->count = i + 1;
+	}
+
+	snd_pcm_hw_constraint_list(runtime, 0,
+				   SNDRV_PCM_HW_PARAM_CHANNELS, constraint);
+
+	/*
+	 * Sampling Rate / Channel Limitation
+	 * It depends on Clock Master Mode
+	 */
+	if (!rsnd_rdai_is_clk_master(rdai))
+		return;
+
+	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+			    rsnd_soc_hw_rule_rate, dai,
+			    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+			    rsnd_soc_hw_rule_channels, dai,
+			    SNDRV_PCM_HW_PARAM_RATE, -1);
+}
+
 static int rsnd_soc_dai_startup(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
@@ -744,6 +892,9 @@ static int rsnd_soc_dai_startup(struct snd_pcm_substream *substream,
 	struct rsnd_dai_stream *io = rsnd_rdai_to_io(rdai, substream);
 	int ret;
 
+	/* rsnd_io_to_runtime() is not yet enabled here */
+	rsnd_soc_hw_constraint(substream->runtime, dai);
+
 	/*
 	 * call rsnd_dai_call without spinlock
 	 */
@@ -866,7 +1017,7 @@ static void __rsnd_dai_probe(struct rsnd_priv *priv,
 	drv->playback.rates		= RSND_RATES;
 	drv->playback.formats		= RSND_FMTS;
 	drv->playback.channels_min	= 2;
-	drv->playback.channels_max	= 6;
+	drv->playback.channels_max	= 16;
 	drv->playback.stream_name	= rdai->playback.name;
 
 	snprintf(rdai->capture.name, RSND_DAI_NAME_SIZE,
@@ -874,7 +1025,7 @@ static void __rsnd_dai_probe(struct rsnd_priv *priv,
 	drv->capture.rates		= RSND_RATES;
 	drv->capture.formats		= RSND_FMTS;
 	drv->capture.channels_min	= 2;
-	drv->capture.channels_max	= 6;
+	drv->capture.channels_max	= 16;
 	drv->capture.stream_name	= rdai->capture.name;
 
 	rdai->playback.rdai		= rdai;
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 3aa07a07bbcb..9428d4e288dd 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -449,6 +449,7 @@ struct rsnd_dai {
 	struct rsnd_dai_stream playback;
 	struct rsnd_dai_stream capture;
 	struct rsnd_priv *priv;
+	struct snd_pcm_hw_constraint_list constraint;
 
 	int max_channels;	/* 2ch - 16ch */
 	int ssi_lane;		/* 1lane - 4lane */
-- 
2.11.0
