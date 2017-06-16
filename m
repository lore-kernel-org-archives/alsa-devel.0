From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4613: add hw_constraint rule for Sampling Rate" to the asoc tree
Date: Fri, 16 Jun 2017 18:50:28 +0100
Message-ID: <E1dLvO8-0005kp-GP@debutante>
References: <87efukiu8d.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87efukiu8d.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4613: add hw_constraint rule for Sampling Rate

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

>From 907cd8809eebccc57a6a3ee9fa87b7602e72df38 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 16 Jun 2017 01:47:34 +0000
Subject: [PATCH] ASoC: ak4613: add hw_constraint rule for Sampling Rate

Current ak4613 accepts all range of Sampling Rate, but it depends on
inputed master clock. This patch adds hw constraint rule for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4613.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index d5beca008dea..a4520a1f849d 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -94,6 +94,8 @@ struct ak4613_interface {
 struct ak4613_priv {
 	struct mutex lock;
 	const struct ak4613_interface *iface;
+	struct snd_pcm_hw_constraint_list constraint;
+	unsigned int sysclk;
 
 	unsigned int fmt;
 	u8 oc;
@@ -252,6 +254,50 @@ static void ak4613_dai_shutdown(struct snd_pcm_substream *substream,
 	mutex_unlock(&priv->lock);
 }
 
+static void ak4613_hw_constraints(struct ak4613_priv *priv,
+				  struct snd_pcm_runtime *runtime)
+{
+	static const unsigned int ak4613_rates[] = {
+		 32000,
+		 44100,
+		 48000,
+		 64000,
+		 88200,
+		 96000,
+		176400,
+		192000,
+	};
+	struct snd_pcm_hw_constraint_list *constraint = &priv->constraint;
+	unsigned int fs;
+	int i;
+
+	constraint->list	= ak4613_rates;
+	constraint->mask	= 0;
+	constraint->count	= 0;
+
+	/*
+	 * Slave Mode
+	 *	Normal: [32kHz, 48kHz] : 256fs,384fs or 512fs
+	 *	Double: [64kHz, 96kHz] : 256fs
+	 *	Quad  : [128kHz,192kHz]: 128fs
+	 *
+	 * Master mode
+	 *	Normal: [32kHz, 48kHz] : 256fs or 512fs
+	 *	Double: [64kHz, 96kHz] : 256fs
+	 *	Quad  : [128kHz,192kHz]: 128fs
+	*/
+	for (i = 0; i < ARRAY_SIZE(ak4613_rates); i++) {
+		/* minimum fs on each range */
+		fs = (ak4613_rates[i] <= 96000) ? 256 : 128;
+
+		if (priv->sysclk >= ak4613_rates[i] * fs)
+			constraint->count = i + 1;
+	}
+
+	snd_pcm_hw_constraint_list(runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE, constraint);
+}
+
 static int ak4613_dai_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
@@ -260,6 +306,19 @@ static int ak4613_dai_startup(struct snd_pcm_substream *substream,
 
 	priv->cnt++;
 
+	ak4613_hw_constraints(priv, substream->runtime);
+
+	return 0;
+}
+
+static int ak4613_dai_set_sysclk(struct snd_soc_dai *codec_dai,
+				 int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct ak4613_priv *priv = snd_soc_codec_get_drvdata(codec);
+
+	priv->sysclk = freq;
+
 	return 0;
 }
 
@@ -411,6 +470,7 @@ static int ak4613_set_bias_level(struct snd_soc_codec *codec,
 static const struct snd_soc_dai_ops ak4613_dai_ops = {
 	.startup	= ak4613_dai_startup,
 	.shutdown	= ak4613_dai_shutdown,
+	.set_sysclk	= ak4613_dai_set_sysclk,
 	.set_fmt	= ak4613_dai_set_fmt,
 	.hw_params	= ak4613_dai_hw_params,
 };
@@ -529,6 +589,7 @@ static int ak4613_i2c_probe(struct i2c_client *i2c,
 
 	priv->iface		= NULL;
 	priv->cnt		= 0;
+	priv->sysclk		= 0;
 
 	mutex_init(&priv->lock);
 
-- 
2.11.0
