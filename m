From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Add gating for clock when used for direct MCLK" to the asoc tree
Date: Mon, 24 Oct 2016 19:04:41 +0100
Message-ID: <E1byjc1-0001Wd-D4@debutante>
References: <1472831568-466-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472831568-466-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Mark Brown <broonie@kernel.org>, lee.jones@linaro.orgbroonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.coms.nawrocki@samsung.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Add gating for clock when used for direct MCLK

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

>From 7a4413d0dc964eecbed8dcb0e0d0b6e0aa9051f1 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Fri, 21 Oct 2016 14:15:57 +0100
Subject: [PATCH] ASoC: arizona: Add gating for clock when used for direct MCLK

Whilst ultimately we would like to move all the clocking over to the
clock framework, as an intermediate step to get people going for now
gating the source clocks for SYSCLK/ASYNCCLK when they are configured
to come directly from an MCLK pin.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 40 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/arizona.h |  2 ++
 sound/soc/codecs/cs47l24.c |  6 ++++--
 sound/soc/codecs/wm5102.c  |  9 +++++++--
 sound/soc/codecs/wm5110.c  | 10 +++++++---
 sound/soc/codecs/wm8997.c  |  9 +++++++--
 sound/soc/codecs/wm8998.c  |  6 ++++--
 7 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 846ca079845f..10be50ae2f76 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1233,6 +1233,46 @@ static int arizona_set_opclk(struct snd_soc_codec *codec, unsigned int clk,
 	return -EINVAL;
 }
 
+int arizona_clk_ev(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
+	unsigned int val;
+	int clk_idx;
+	int ret;
+
+	ret = regmap_read(arizona->regmap, w->reg, &val);
+	if (ret) {
+		dev_err(codec->dev, "Failed to check clock source: %d\n", ret);
+		return ret;
+	}
+
+	val = (val & ARIZONA_SYSCLK_SRC_MASK) >> ARIZONA_SYSCLK_SRC_SHIFT;
+
+	switch (val) {
+	case ARIZONA_CLK_SRC_MCLK1:
+		clk_idx = ARIZONA_MCLK1;
+		break;
+	case ARIZONA_CLK_SRC_MCLK2:
+		clk_idx = ARIZONA_MCLK2;
+		break;
+	default:
+		return 0;
+	}
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		return clk_prepare_enable(arizona->mclk[clk_idx]);
+	case SND_SOC_DAPM_POST_PMD:
+		clk_disable_unprepare(arizona->mclk[clk_idx]);
+		return 0;
+	default:
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(arizona_clk_ev);
+
 int arizona_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 		       int source, unsigned int freq, int dir)
 {
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 850aa338ba29..9d0997bec870 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -273,6 +273,8 @@ extern int arizona_eq_coeff_put(struct snd_kcontrol *kcontrol,
 extern int arizona_lhpf_coeff_put(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol);
 
+extern int arizona_clk_ev(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *kcontrol, int event);
 extern int arizona_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 			      int source, unsigned int freq, int dir);
 
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 5b22564f037c..7df6a6769038 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -335,9 +335,11 @@ static const struct snd_kcontrol_new cs47l24_aec_loopback_mux =
 
 static const struct snd_soc_dapm_widget cs47l24_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("SYSCLK", ARIZONA_SYSTEM_CLOCK_1,
-		    ARIZONA_SYSCLK_ENA_SHIFT, 0, NULL, 0),
+		    ARIZONA_SYSCLK_ENA_SHIFT, 0, arizona_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_SUPPLY("ASYNCCLK", ARIZONA_ASYNC_CLOCK_1,
-		    ARIZONA_ASYNC_CLK_ENA_SHIFT, 0, NULL, 0),
+		    ARIZONA_ASYNC_CLK_ENA_SHIFT, 0, arizona_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_SUPPLY("OPCLK", ARIZONA_OUTPUT_SYSTEM_CLOCK,
 		    ARIZONA_OPCLK_ENA_SHIFT, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("ASYNCOPCLK", ARIZONA_OUTPUT_ASYNC_CLOCK,
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 93876c6d48ee..bb3de5b3d816 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -607,6 +607,9 @@ static int wm5102_sysclk_ev(struct snd_soc_dapm_widget *w,
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
 		break;
+	case SND_SOC_DAPM_PRE_PMU:
+	case SND_SOC_DAPM_POST_PMD:
+		return arizona_clk_ev(w, kcontrol, event);
 	default:
 		return 0;
 	}
@@ -1077,9 +1080,11 @@ static const struct snd_kcontrol_new wm5102_aec_loopback_mux =
 static const struct snd_soc_dapm_widget wm5102_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("SYSCLK", ARIZONA_SYSTEM_CLOCK_1, ARIZONA_SYSCLK_ENA_SHIFT,
 		    0, wm5102_sysclk_ev,
-		    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+		    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD |
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_SUPPLY("ASYNCCLK", ARIZONA_ASYNC_CLOCK_1,
-		    ARIZONA_ASYNC_CLK_ENA_SHIFT, 0, NULL, 0),
+		    ARIZONA_ASYNC_CLK_ENA_SHIFT, 0, arizona_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_SUPPLY("OPCLK", ARIZONA_OUTPUT_SYSTEM_CLOCK,
 		    ARIZONA_OPCLK_ENA_SHIFT, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("ASYNCOPCLK", ARIZONA_OUTPUT_ASYNC_CLOCK,
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 06bae3b23fce..407dc4a43b07 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -183,7 +183,9 @@ static int wm5110_sysclk_ev(struct snd_soc_dapm_widget *w,
 				regmap_write_async(regmap, patch[i].reg,
 						   patch[i].def);
 		break;
-
+	case SND_SOC_DAPM_PRE_PMU:
+	case SND_SOC_DAPM_POST_PMD:
+		return arizona_clk_ev(w, kcontrol, event);
 	default:
 		break;
 	}
@@ -1073,9 +1075,11 @@ static const struct snd_kcontrol_new wm5110_output_anc_src[] = {
 
 static const struct snd_soc_dapm_widget wm5110_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("SYSCLK", ARIZONA_SYSTEM_CLOCK_1, ARIZONA_SYSCLK_ENA_SHIFT,
-		    0, wm5110_sysclk_ev, SND_SOC_DAPM_POST_PMU),
+		    0, wm5110_sysclk_ev, SND_SOC_DAPM_POST_PMU |
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_SUPPLY("ASYNCCLK", ARIZONA_ASYNC_CLOCK_1,
-		    ARIZONA_ASYNC_CLK_ENA_SHIFT, 0, NULL, 0),
+		    ARIZONA_ASYNC_CLK_ENA_SHIFT, 0, arizona_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_SUPPLY("OPCLK", ARIZONA_OUTPUT_SYSTEM_CLOCK,
 		    ARIZONA_OPCLK_ENA_SHIFT, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("ASYNCOPCLK", ARIZONA_OUTPUT_ASYNC_CLOCK,
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 2f2821b3382f..f5f5d4352670 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -108,6 +108,9 @@ static int wm8997_sysclk_ev(struct snd_soc_dapm_widget *w,
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
 		break;
+	case SND_SOC_DAPM_PRE_PMU:
+	case SND_SOC_DAPM_POST_PMD:
+		return arizona_clk_ev(w, kcontrol, event);
 	default:
 		return 0;
 	}
@@ -408,9 +411,11 @@ static const struct snd_kcontrol_new wm8997_aec_loopback_mux =
 static const struct snd_soc_dapm_widget wm8997_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("SYSCLK", ARIZONA_SYSTEM_CLOCK_1, ARIZONA_SYSCLK_ENA_SHIFT,
 		    0, wm8997_sysclk_ev,
-		    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+		    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD |
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_SUPPLY("ASYNCCLK", ARIZONA_ASYNC_CLOCK_1,
-		    ARIZONA_ASYNC_CLK_ENA_SHIFT, 0, NULL, 0),
+		    ARIZONA_ASYNC_CLK_ENA_SHIFT, 0, arizona_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_SUPPLY("OPCLK", ARIZONA_OUTPUT_SYSTEM_CLOCK,
 		    ARIZONA_OPCLK_ENA_SHIFT, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("ASYNCOPCLK", ARIZONA_OUTPUT_ASYNC_CLOCK,
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index bcc2e1060a6c..3eaa3615b82e 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -541,9 +541,11 @@ static const struct snd_kcontrol_new wm8998_aec_loopback_mux[] = {
 
 static const struct snd_soc_dapm_widget wm8998_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("SYSCLK", ARIZONA_SYSTEM_CLOCK_1,
-		    ARIZONA_SYSCLK_ENA_SHIFT, 0, NULL, 0),
+		    ARIZONA_SYSCLK_ENA_SHIFT, 0, arizona_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_SUPPLY("ASYNCCLK", ARIZONA_ASYNC_CLOCK_1,
-		    ARIZONA_ASYNC_CLK_ENA_SHIFT, 0, NULL, 0),
+		    ARIZONA_ASYNC_CLK_ENA_SHIFT, 0, arizona_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_SUPPLY("OPCLK", ARIZONA_OUTPUT_SYSTEM_CLOCK,
 		    ARIZONA_OPCLK_ENA_SHIFT, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("ASYNCOPCLK", ARIZONA_OUTPUT_ASYNC_CLOCK,
-- 
2.8.1
