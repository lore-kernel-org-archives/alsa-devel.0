From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: arizona: Implement AIF clock
	configuration
Date: Wed,  4 Jul 2012 19:13:44 +0100
Message-ID: <1341425625-17621-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1341425625-17621-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5CD5924502
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 20:13:47 +0200 (CEST)
In-Reply-To: <1341425625-17621-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Allow the user to select which of the system clocks each AIF is referenced
to and constran the DAI to the set of frequencies which can be generated
from that clock.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |  106 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/arizona.h |    9 ++++
 sound/soc/codecs/wm5102.c  |    3 ++
 3 files changed, 118 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 67760b4..8e5246c 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -385,6 +385,29 @@ static const int arizona_48k_bclk_rates[] = {
 	24576000,
 };
 
+static const unsigned int arizona_48k_rates[] = {
+	12000,
+	24000,
+	48000,
+	96000,
+	192000,
+	384000,
+	768000,
+	4000,
+	8000,
+	16000,
+	32000,
+	64000,
+	128000,
+	256000,
+	512000,
+};
+
+static const struct snd_pcm_hw_constraint_list arizona_48k_constraint = {
+	.count	= ARRAY_SIZE(arizona_48k_rates),
+	.list	= arizona_48k_rates,
+};
+
 static const int arizona_44k1_bclk_rates[] = {
 	-1,
 	44100,
@@ -407,6 +430,21 @@ static const int arizona_44k1_bclk_rates[] = {
 	22579200,
 };
 
+static const unsigned int arizona_44k1_rates[] = {
+	11025,
+	22050,
+	44100,
+	88200,
+	176400,
+	352800,
+	705600,
+};
+
+static const struct snd_pcm_hw_constraint_list arizona_44k1_constraint = {
+	.count	= ARRAY_SIZE(arizona_44k1_rates),
+	.list	= arizona_44k1_rates,
+};
+
 static int arizona_sr_vals[] = {
 	0,
 	12000,
@@ -434,6 +472,36 @@ static int arizona_sr_vals[] = {
 	512000,
 };
 
+static int arizona_startup(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona_dai_priv *dai_priv = &priv->dai[dai->id - 1];
+	const struct snd_pcm_hw_constraint_list *constraint;
+	unsigned int base_rate;
+
+	switch (dai_priv->clk) {
+	case ARIZONA_CLK_SYSCLK:
+		base_rate = priv->sysclk;
+		break;
+	case ARIZONA_CLK_ASYNCCLK:
+		base_rate = priv->asyncclk;
+		break;
+	default:
+		return 0;
+	}
+
+	if (base_rate % 8000)
+		constraint = &arizona_44k1_constraint;
+	else
+		constraint = &arizona_48k_constraint;
+
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+					  SNDRV_PCM_HW_PARAM_RATE,
+					  constraint);
+}
+
 static int arizona_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
@@ -501,11 +569,49 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int arizona_dai_set_sysclk(struct snd_soc_dai *dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona_dai_priv *dai_priv = &priv->dai[dai->id - 1];
+
+	switch (clk_id) {
+	case ARIZONA_CLK_SYSCLK:
+	case ARIZONA_CLK_ASYNCCLK:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (clk_id != dai_priv->clk && dai->active) {
+		dev_err(codec->dev, "Can't change clock on active DAI %d\n",
+			dai->id);
+		return -EBUSY;
+	}
+
+	dai_priv->clk = clk_id;
+
+	return 0;
+}
+
 const struct snd_soc_dai_ops arizona_dai_ops = {
+	.startup = arizona_startup,
 	.set_fmt = arizona_set_fmt,
 	.hw_params = arizona_hw_params,
+	.set_sysclk = arizona_dai_set_sysclk,
 };
 
+int arizona_init_dai(struct arizona_priv *priv, int id)
+{
+	struct arizona_dai_priv *dai_priv = &priv->dai[id];
+
+	dai_priv->clk = ARIZONA_CLK_SYSCLK;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arizona_init_dai);
+
 static irqreturn_t arizona_fll_lock(int irq, void *data)
 {
 	struct arizona_fll *fll = data;
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 8c2ca1d..896711e 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -44,12 +44,19 @@
 #define ARIZONA_MIXER_VOL_SHIFT                 1
 #define ARIZONA_MIXER_VOL_WIDTH                 7
 
+#define ARIZONA_MAX_DAI 3
+
 struct arizona;
 
+struct arizona_dai_priv {
+	int clk;
+};
+
 struct arizona_priv {
 	struct arizona *arizona;
 	int sysclk;
 	int asyncclk;
+	struct arizona_dai_priv dai[ARIZONA_MAX_DAI];
 };
 
 #define ARIZONA_NUM_MIXER_INPUTS 55
@@ -146,4 +153,6 @@ extern int arizona_init_fll(struct arizona *arizona, int id, int base,
 extern int arizona_set_fll(struct arizona_fll *fll, int source,
 			   unsigned int Fref, unsigned int Fout);
 
+extern int arizona_init_dai(struct arizona_priv *priv, int dai);
+
 #endif
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index e76c41e..be74a78 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -832,6 +832,9 @@ static int __devinit wm5102_probe(struct platform_device *pdev)
 			 ARIZONA_IRQ_FLL2_LOCK, ARIZONA_IRQ_FLL2_CLOCK_OK,
 			 &wm5102->fll[1]);
 
+	for (i = 0; i < ARRAY_SIZE(wm5102_dai); i++)
+		arizona_init_dai(&wm5102->core, i);
+
 	/* Latch volume update bits */
 	for (i = 0; i < ARRAY_SIZE(wm5102_digital_vu); i++)
 		regmap_update_bits(arizona->regmap, wm5102_digital_vu[i],
-- 
1.7.10
