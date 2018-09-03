From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove is_play parameter from
	hw_rule function" to the asoc tree
Date: Mon,  3 Sep 2018 14:46:04 +0100 (BST)
Message-ID: <20180903134604.AC4EA11227AE@debutante.sirena.org.uk>
References: <875zznf4lv.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 61E5E2676C6
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 15:46:05 +0200 (CEST)
In-Reply-To: <875zznf4lv.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: remove is_play parameter from hw_rule function

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

>From b735662fa473c0e3618a4d645ce797d31e0c9192 Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Mon, 3 Sep 2018 07:06:50 +0000
Subject: [PATCH] ASoC: rsnd: remove is_play parameter from hw_rule function

Currently rsnd_dai_stream *io is set to either &rdai->playback or
&rdai->capture based on whether it is a playback or capture stream,
in __rsnd_soc_hw_rule_* functions, but this is not necessary,
rsnd_dai_stream *io handler can be get from rule->private.

This patch removes 'is_play' parameter from hw_rule function.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
[Kuninori: tidyup for upstream]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 54 +++++++++-------------------------------
 1 file changed, 12 insertions(+), 42 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index cd0ff1eef463..c66b3dade947 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -819,16 +819,14 @@ static int rsnd_soc_hw_rule(struct rsnd_dai *rdai,
 	return snd_interval_refine(iv, &p);
 }
 
-static int __rsnd_soc_hw_rule_rate(struct snd_pcm_hw_params *params,
-				   struct snd_pcm_hw_rule *rule,
-				   int is_play)
+static int rsnd_soc_hw_rule_rate(struct snd_pcm_hw_params *params,
+				 struct snd_pcm_hw_rule *rule)
 {
 	struct snd_interval *ic_ = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
 	struct snd_interval *ir = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval ic;
-	struct snd_soc_dai *dai = rule->private;
-	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
-	struct rsnd_dai_stream *io = is_play ? &rdai->playback : &rdai->capture;
+	struct rsnd_dai_stream *io = rule->private;
+	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 
 	/*
 	 * possible sampling rate limitation is same as
@@ -844,28 +842,14 @@ static int __rsnd_soc_hw_rule_rate(struct snd_pcm_hw_params *params,
 				&ic, ir);
 }
 
-static int rsnd_soc_hw_rule_rate_playback(struct snd_pcm_hw_params *params,
-				 struct snd_pcm_hw_rule *rule)
-{
-	return __rsnd_soc_hw_rule_rate(params, rule, 1);
-}
-
-static int rsnd_soc_hw_rule_rate_capture(struct snd_pcm_hw_params *params,
-					  struct snd_pcm_hw_rule *rule)
-{
-	return __rsnd_soc_hw_rule_rate(params, rule, 0);
-}
-
-static int __rsnd_soc_hw_rule_channels(struct snd_pcm_hw_params *params,
-				       struct snd_pcm_hw_rule *rule,
-				       int is_play)
+static int rsnd_soc_hw_rule_channels(struct snd_pcm_hw_params *params,
+				     struct snd_pcm_hw_rule *rule)
 {
 	struct snd_interval *ic_ = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
 	struct snd_interval *ir = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval ic;
-	struct snd_soc_dai *dai = rule->private;
-	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
-	struct rsnd_dai_stream *io = is_play ? &rdai->playback : &rdai->capture;
+	struct rsnd_dai_stream *io = rule->private;
+	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 
 	/*
 	 * possible sampling rate limitation is same as
@@ -881,18 +865,6 @@ static int __rsnd_soc_hw_rule_channels(struct snd_pcm_hw_params *params,
 				ir, &ic);
 }
 
-static int rsnd_soc_hw_rule_channels_playback(struct snd_pcm_hw_params *params,
-					      struct snd_pcm_hw_rule *rule)
-{
-	return __rsnd_soc_hw_rule_channels(params, rule, 1);
-}
-
-static int rsnd_soc_hw_rule_channels_capture(struct snd_pcm_hw_params *params,
-					     struct snd_pcm_hw_rule *rule)
-{
-	return __rsnd_soc_hw_rule_channels(params, rule, 0);
-}
-
 static const struct snd_pcm_hardware rsnd_pcm_hardware = {
 	.info =		SNDRV_PCM_INFO_INTERLEAVED	|
 			SNDRV_PCM_INFO_MMAP		|
@@ -949,14 +921,12 @@ static int rsnd_soc_dai_startup(struct snd_pcm_substream *substream,
 		int is_play = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 
 		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				    is_play ? rsnd_soc_hw_rule_rate_playback :
-					      rsnd_soc_hw_rule_rate_capture,
-				    dai,
+				    rsnd_soc_hw_rule_rate,
+				    is_play ? &rdai->playback : &rdai->capture,
 				    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-				    is_play ? rsnd_soc_hw_rule_channels_playback :
-					      rsnd_soc_hw_rule_channels_capture,
-				    dai,
+				    rsnd_soc_hw_rule_channels,
+				    is_play ? &rdai->playback : &rdai->capture,
 				    SNDRV_PCM_HW_PARAM_RATE, -1);
 	}
 
-- 
2.19.0.rc1
