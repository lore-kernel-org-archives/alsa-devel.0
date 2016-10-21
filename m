From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH RESEND 1/2] ASoC: arizona: Add gating for clock
	when used for direct MCLK
Date: Fri, 21 Oct 2016 14:15:57 +0100
Message-ID: <1477055758-11490-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1477055758-11490-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 68BD5267202
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2016 15:15:47 +0200 (CEST)
In-Reply-To: <1477055758-11490-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, s.nawrocki@samsung.com
List-Id: alsa-devel@alsa-project.org

Whilst ultimately we would like to move all the clocking over to the
clock framework, as an intermediate step to get people going for now
gating the source clocks for SYSCLK/ASYNCCLK when they are configured
to come directly from an MCLK pin.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
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
index 846ca07..10be50a 100644
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
index 850aa33..9d0997b 100644
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
index 5b22564..7df6a67 100644
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
index 93876c6..bb3de5b 100644
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
index 06bae3b..407dc4a 100644
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
index 2f2821b..f5f5d43 100644
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
index bcc2e10..3eaa361 100644
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
2.1.4
