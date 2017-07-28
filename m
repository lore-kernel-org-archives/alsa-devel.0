From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: merge snd_pcm_ops::open and snd_soc_dai_ops::startup" to the asoc tree
Date: Fri, 28 Jul 2017 11:17:52 +0100
Message-ID: <E1db2LA-0003lC-8Y@debutante>
References: <87h8z0g2de.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87h8z0g2de.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: merge snd_pcm_ops::open and snd_soc_dai_ops::startup

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

>From 3c9736aa1ab59e64ebc33b140b000f90c8f9de46 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 27 Jul 2017 01:32:06 +0000
Subject: [PATCH] ASoC: rsnd: merge snd_pcm_ops::open and
 snd_soc_dai_ops::startup

Current rsnd driver has snd_pcm_ops::open and snd_soc_dai_ops::startup,
but, these are called from soc_pcm_open in same time.
This patch merge these into rsnd_soc_dai_startup()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 80 +++++++++++++++++++-----------------------------
 1 file changed, 31 insertions(+), 49 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index acafb838b7b7..c34562388cfa 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -844,12 +844,28 @@ static int rsnd_soc_hw_rule_channels(struct snd_pcm_hw_params *params,
 				ir, &ic);
 }
 
-static void rsnd_soc_hw_constraint(struct snd_pcm_runtime *runtime,
-				   struct snd_soc_dai *dai)
+static struct snd_pcm_hardware rsnd_pcm_hardware = {
+	.info =		SNDRV_PCM_INFO_INTERLEAVED	|
+			SNDRV_PCM_INFO_MMAP		|
+			SNDRV_PCM_INFO_MMAP_VALID,
+	.buffer_bytes_max	= 64 * 1024,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 8192,
+	.periods_min		= 1,
+	.periods_max		= 32,
+	.fifo_size		= 256,
+};
+
+static int rsnd_soc_dai_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
 {
 	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
+	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
+	struct rsnd_dai_stream *io = rsnd_rdai_to_io(rdai, substream);
 	struct snd_pcm_hw_constraint_list *constraint = &rdai->constraint;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned int max_channels = rsnd_rdai_channels_get(rdai);
+	int ret;
 	int i;
 
 	/*
@@ -866,34 +882,26 @@ static void rsnd_soc_hw_constraint(struct snd_pcm_runtime *runtime,
 		constraint->count = i + 1;
 	}
 
+	snd_soc_set_runtime_hwparams(substream, &rsnd_pcm_hardware);
+
 	snd_pcm_hw_constraint_list(runtime, 0,
 				   SNDRV_PCM_HW_PARAM_CHANNELS, constraint);
 
+	snd_pcm_hw_constraint_integer(runtime,
+				      SNDRV_PCM_HW_PARAM_PERIODS);
+
 	/*
 	 * Sampling Rate / Channel Limitation
 	 * It depends on Clock Master Mode
 	 */
-	if (!rsnd_rdai_is_clk_master(rdai))
-		return;
-
-	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-			    rsnd_soc_hw_rule_rate, dai,
-			    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
-	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-			    rsnd_soc_hw_rule_channels, dai,
-			    SNDRV_PCM_HW_PARAM_RATE, -1);
-}
-
-static int rsnd_soc_dai_startup(struct snd_pcm_substream *substream,
-				struct snd_soc_dai *dai)
-{
-	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
-	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
-	struct rsnd_dai_stream *io = rsnd_rdai_to_io(rdai, substream);
-	int ret;
-
-	/* rsnd_io_to_runtime() is not yet enabled here */
-	rsnd_soc_hw_constraint(substream->runtime, dai);
+	if (rsnd_rdai_is_clk_master(rdai)) {
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				    rsnd_soc_hw_rule_rate, dai,
+				    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				    rsnd_soc_hw_rule_channels, dai,
+				    SNDRV_PCM_HW_PARAM_RATE, -1);
+	}
 
 	/*
 	 * call rsnd_dai_call without spinlock
@@ -1105,31 +1113,6 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 /*
  *		pcm ops
  */
-static struct snd_pcm_hardware rsnd_pcm_hardware = {
-	.info =		SNDRV_PCM_INFO_INTERLEAVED	|
-			SNDRV_PCM_INFO_MMAP		|
-			SNDRV_PCM_INFO_MMAP_VALID,
-	.buffer_bytes_max	= 64 * 1024,
-	.period_bytes_min	= 32,
-	.period_bytes_max	= 8192,
-	.periods_min		= 1,
-	.periods_max		= 32,
-	.fifo_size		= 256,
-};
-
-static int rsnd_pcm_open(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int ret = 0;
-
-	snd_soc_set_runtime_hwparams(substream, &rsnd_pcm_hardware);
-
-	ret = snd_pcm_hw_constraint_integer(runtime,
-					    SNDRV_PCM_HW_PARAM_PERIODS);
-
-	return ret;
-}
-
 static int rsnd_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *hw_params)
 {
@@ -1159,7 +1142,6 @@ static snd_pcm_uframes_t rsnd_pointer(struct snd_pcm_substream *substream)
 }
 
 static struct snd_pcm_ops rsnd_pcm_ops = {
-	.open		= rsnd_pcm_open,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= rsnd_hw_params,
 	.hw_free	= snd_pcm_lib_free_pages,
-- 
2.13.2
