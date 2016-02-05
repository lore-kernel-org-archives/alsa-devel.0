From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Add support for
	SNDRV_PCM_RATE_KNOT" to the asoc tree
Date: Fri, 05 Feb 2016 13:35:24 +0000
Message-ID: <E1aRgXk-00013q-Lh@finisterre>
References: <1454603341-28757-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E6282666D6
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 14:36:28 +0100 (CET)
In-Reply-To: <1454603341-28757-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Add support for SNDRV_PCM_RATE_KNOT

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

>From d81221ff9406a3918084bfaed752894e82c5d44b Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 4 Feb 2016 16:29:01 +0000
Subject: [PATCH] ASoC: arizona: Add support for SNDRV_PCM_RATE_KNOT

The Arizona CODECs support several rates that do not have simple defines
in ALSA. This patch adds support for SNDRV_PCM_RATE_KNOT so that users
can open stream at these rates. As part of this we should always set
constraints in arizona_startup, currently we only set the constraints if
we already have a clock to limit rates to that family of sample rates.
This patch updates this to set a constraint of all rates supported by
the chip if we do not already know which family of rates to limit to.
Finally we also reduce the list of rates supported in the constraints to
only include those that are supported on current parts.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 62 ++++++++++++----------------------------------
 sound/soc/codecs/arizona.h |  2 ++
 sound/soc/codecs/cs47l24.c |  2 +-
 sound/soc/codecs/wm5102.c  |  2 +-
 sound/soc/codecs/wm5110.c  |  2 +-
 sound/soc/codecs/wm8997.c  |  2 +-
 sound/soc/codecs/wm8998.c  |  2 +-
 7 files changed, 23 insertions(+), 51 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 33143fe..a32cfb8 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1398,29 +1398,6 @@ static const int arizona_48k_bclk_rates[] = {
 	24576000,
 };
 
-static const unsigned int arizona_48k_rates[] = {
-	12000,
-	24000,
-	48000,
-	96000,
-	192000,
-	384000,
-	768000,
-	4000,
-	8000,
-	16000,
-	32000,
-	64000,
-	128000,
-	256000,
-	512000,
-};
-
-static const struct snd_pcm_hw_constraint_list arizona_48k_constraint = {
-	.count	= ARRAY_SIZE(arizona_48k_rates),
-	.list	= arizona_48k_rates,
-};
-
 static const int arizona_44k1_bclk_rates[] = {
 	-1,
 	44100,
@@ -1443,22 +1420,7 @@ static const int arizona_44k1_bclk_rates[] = {
 	22579200,
 };
 
-static const unsigned int arizona_44k1_rates[] = {
-	11025,
-	22050,
-	44100,
-	88200,
-	176400,
-	352800,
-	705600,
-};
-
-static const struct snd_pcm_hw_constraint_list arizona_44k1_constraint = {
-	.count	= ARRAY_SIZE(arizona_44k1_rates),
-	.list	= arizona_44k1_rates,
-};
-
-static int arizona_sr_vals[] = {
+static const unsigned int arizona_sr_vals[] = {
 	0,
 	12000,
 	24000,
@@ -1485,13 +1447,21 @@ static int arizona_sr_vals[] = {
 	512000,
 };
 
+#define ARIZONA_48K_RATE_MASK	0x0F003E
+#define ARIZONA_44K1_RATE_MASK	0x003E00
+#define ARIZONA_RATE_MASK	(ARIZONA_48K_RATE_MASK | ARIZONA_44K1_RATE_MASK)
+
+static const struct snd_pcm_hw_constraint_list arizona_constraint = {
+	.count	= ARRAY_SIZE(arizona_sr_vals),
+	.list	= arizona_sr_vals,
+};
+
 static int arizona_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct arizona_dai_priv *dai_priv = &priv->dai[dai->id - 1];
-	const struct snd_pcm_hw_constraint_list *constraint;
 	unsigned int base_rate;
 
 	if (!substream->runtime)
@@ -1509,16 +1479,15 @@ static int arizona_startup(struct snd_pcm_substream *substream,
 	}
 
 	if (base_rate == 0)
-		return 0;
-
-	if (base_rate % 8000)
-		constraint = &arizona_44k1_constraint;
+		dai_priv->constraint.mask = ARIZONA_RATE_MASK;
+	else if (base_rate % 8000)
+		dai_priv->constraint.mask = ARIZONA_44K1_RATE_MASK;
 	else
-		constraint = &arizona_48k_constraint;
+		dai_priv->constraint.mask = ARIZONA_48K_RATE_MASK;
 
 	return snd_pcm_hw_constraint_list(substream->runtime, 0,
 					  SNDRV_PCM_HW_PARAM_RATE,
-					  constraint);
+					  &dai_priv->constraint);
 }
 
 static void arizona_wm5102_set_dac_comp(struct snd_soc_codec *codec,
@@ -1911,6 +1880,7 @@ int arizona_init_dai(struct arizona_priv *priv, int id)
 	struct arizona_dai_priv *dai_priv = &priv->dai[id];
 
 	dai_priv->clk = ARIZONA_CLK_SYSCLK;
+	dai_priv->constraint = arizona_constraint;
 
 	return 0;
 }
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 0c64a573..1ea8e4e 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -68,6 +68,8 @@ struct wm_adsp;
 
 struct arizona_dai_priv {
 	int clk;
+
+	struct snd_pcm_hw_constraint_list constraint;
 };
 
 struct arizona_priv {
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index b8d3cd0..576087b 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -923,7 +923,7 @@ static int cs47l24_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	}
 }
 
-#define CS47L24_RATES SNDRV_PCM_RATE_8000_192000
+#define CS47L24_RATES SNDRV_PCM_RATE_KNOT
 
 #define CS47L24_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			 SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index aa1e96a..a8b3e3f 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1738,7 +1738,7 @@ static int wm5102_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	}
 }
 
-#define WM5102_RATES SNDRV_PCM_RATE_8000_192000
+#define WM5102_RATES SNDRV_PCM_RATE_KNOT
 
 #define WM5102_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 92b6a6a..aa47955 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2024,7 +2024,7 @@ static int wm5110_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	}
 }
 
-#define WM5110_RATES SNDRV_PCM_RATE_8000_192000
+#define WM5110_RATES SNDRV_PCM_RATE_KNOT
 
 #define WM5110_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index b4dba3a..52d766e 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -943,7 +943,7 @@ static int wm8997_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	}
 }
 
-#define WM8997_RATES SNDRV_PCM_RATE_8000_192000
+#define WM8997_RATES SNDRV_PCM_RATE_KNOT
 
 #define WM8997_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 7719bc5..0123960 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -1170,7 +1170,7 @@ static const struct snd_soc_dapm_route wm8998_dapm_routes[] = {
 	{ "DRC1 Signal Activity", NULL, "DRC1R" },
 };
 
-#define WM8998_RATES SNDRV_PCM_RATE_8000_192000
+#define WM8998_RATES SNDRV_PCM_RATE_KNOT
 
 #define WM8998_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
-- 
2.6.4
