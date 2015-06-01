From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v7 1/4] ASoC: arizona: Export functions to
	control subsystem DVFS
Date: Mon,  1 Jun 2015 14:04:48 +0100
Message-ID: <1433163891-10084-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D961B2604A4
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 15:06:52 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The WM5102 and WM8997 codecs have an internal dynamic clock booster.
When this booster is active, the DCVDD voltage must be increased.
If all the currently active audio paths can run with the root SYSCLK
we can disable the booster, allowing us to turn down DCVDD voltage
to save power.

Previously this was being done by having the booster enable bit set
as a side-effect of the LDO1 regulator driver, which is unexpected
behaviour of a regulator and not compatible with using an external
regulator.

This patch exports functions to handle the booster enable and
DCVDD voltage, with each relevant subsystem flagging whether it can
currently run without the booster. Note that these subsystems are
stateless and none of them are nestable, so there's no need for
reference counting, we only need a simple boolean for each subsystem
of whether their current condition could require the booster or will
allow us to turn the codec down to lower operating power.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |  127 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/arizona.h |   13 +++++
 sound/soc/codecs/wm5102.c  |   12 +++--
 sound/soc/codecs/wm8997.c  |   11 +++-
 4 files changed, 156 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index eff4b4d..69965ae 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -851,6 +851,133 @@ int arizona_hp_ev(struct snd_soc_dapm_widget *w,
 }
 EXPORT_SYMBOL_GPL(arizona_hp_ev);
 
+static int arizona_dvfs_enable(struct snd_soc_codec *codec)
+{
+	const struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
+	int ret;
+
+	ret = regulator_set_voltage(arizona->dcvdd, 1800000, 1800000);
+	if (ret) {
+		dev_err(codec->dev, "Failed to boost DCVDD: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(arizona->regmap,
+				 ARIZONA_DYNAMIC_FREQUENCY_SCALING_1,
+				 ARIZONA_SUBSYS_MAX_FREQ,
+				 ARIZONA_SUBSYS_MAX_FREQ);
+	if (ret) {
+		dev_err(codec->dev, "Failed to enable subsys max: %d\n", ret);
+		regulator_set_voltage(arizona->dcvdd, 1200000, 1800000);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int arizona_dvfs_disable(struct snd_soc_codec *codec)
+{
+	const struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
+	int ret;
+
+	ret = regmap_update_bits(arizona->regmap,
+				 ARIZONA_DYNAMIC_FREQUENCY_SCALING_1,
+				 ARIZONA_SUBSYS_MAX_FREQ, 0);
+	if (ret) {
+		dev_err(codec->dev, "Failed to disable subsys max: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_set_voltage(arizona->dcvdd, 1200000, 1800000);
+	if (ret) {
+		dev_err(codec->dev, "Failed to unboost DCVDD: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int arizona_dvfs_up(struct snd_soc_codec *codec, unsigned int flags)
+{
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+
+	mutex_lock(&priv->dvfs_lock);
+
+	if (!priv->dvfs_cached && !priv->dvfs_reqs) {
+		ret = arizona_dvfs_enable(codec);
+		if (ret)
+			goto err;
+	}
+
+	priv->dvfs_reqs |= flags;
+err:
+	mutex_unlock(&priv->dvfs_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(arizona_dvfs_up);
+
+int arizona_dvfs_down(struct snd_soc_codec *codec, unsigned int flags)
+{
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	unsigned int old_reqs = priv->dvfs_reqs;
+	int ret = 0;
+
+	mutex_lock(&priv->dvfs_lock);
+
+	priv->dvfs_reqs &= ~flags;
+
+	if (!priv->dvfs_cached && old_reqs && !priv->dvfs_reqs)
+		ret = arizona_dvfs_disable(codec);
+
+	mutex_unlock(&priv->dvfs_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(arizona_dvfs_down);
+
+int arizona_dvfs_sysclk_ev(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+
+	mutex_lock(&priv->dvfs_lock);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (priv->dvfs_reqs)
+			ret = arizona_dvfs_enable(codec);
+
+		priv->dvfs_cached = false;
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		/* We must ensure DVFS is disabled before the codec goes into
+		 * suspend so that we are never in an illegal state of DVFS
+		 * enabled without enough DCVDD
+		 */
+		priv->dvfs_cached = true;
+
+		if (priv->dvfs_reqs)
+			ret = arizona_dvfs_disable(codec);
+		break;
+	default:
+		break;
+	}
+
+	mutex_unlock(&priv->dvfs_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(arizona_dvfs_sysclk_ev);
+
+void arizona_init_dvfs(struct arizona_priv *priv)
+{
+	mutex_init(&priv->dvfs_lock);
+}
+EXPORT_SYMBOL_GPL(arizona_init_dvfs);
+
 static unsigned int arizona_sysclk_48k_rates[] = {
 	6144000,
 	12288000,
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 11ff899..e82ca21 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -60,6 +60,9 @@
 #define ARIZONA_MAX_DAI  6
 #define ARIZONA_MAX_ADSP 4
 
+#define ARIZONA_DVFS_SR1_RQ	0x001
+#define ARIZONA_DVFS_ADSP1_RQ	0x100
+
 struct arizona;
 struct wm_adsp;
 
@@ -84,6 +87,10 @@ struct arizona_priv {
 
 	unsigned int spk_ena:2;
 	unsigned int spk_ena_pending:1;
+
+	unsigned int dvfs_reqs;
+	struct mutex dvfs_lock;
+	bool dvfs_cached;
 };
 
 #define ARIZONA_NUM_MIXER_INPUTS 103
@@ -245,6 +252,12 @@ struct arizona_fll {
 	char clock_ok_name[ARIZONA_FLL_NAME_LEN];
 };
 
+extern int arizona_dvfs_up(struct snd_soc_codec *codec, unsigned int flags);
+extern int arizona_dvfs_down(struct snd_soc_codec *codec, unsigned int flags);
+extern int arizona_dvfs_sysclk_ev(struct snd_soc_dapm_widget *w,
+				  struct snd_kcontrol *kcontrol, int event);
+extern void arizona_init_dvfs(struct arizona_priv *priv);
+
 extern int arizona_init_fll(struct arizona *arizona, int id, int base,
 			    int lock_irq, int ok_irq, struct arizona_fll *fll);
 extern int arizona_set_fll_refclk(struct arizona_fll *fll, int source,
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 0c6d1bc..b73e3a3 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -605,12 +605,13 @@ static int wm5102_sysclk_ev(struct snd_soc_dapm_widget *w,
 				regmap_write_async(regmap, patch[i].reg,
 						   patch[i].def);
 		break;
-
-	default:
+	case SND_SOC_DAPM_PRE_PMD:
 		break;
+	default:
+		return 0;
 	}
 
-	return 0;
+	return arizona_dvfs_sysclk_ev(w, kcontrol, event);
 }
 
 static int wm5102_out_comp_coeff_get(struct snd_kcontrol *kcontrol,
@@ -1036,7 +1037,8 @@ static const struct snd_kcontrol_new wm5102_aec_loopback_mux =
 
 static const struct snd_soc_dapm_widget wm5102_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("SYSCLK", ARIZONA_SYSTEM_CLOCK_1, ARIZONA_SYSCLK_ENA_SHIFT,
-		    0, wm5102_sysclk_ev, SND_SOC_DAPM_POST_PMU),
+		    0, wm5102_sysclk_ev,
+		    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 SND_SOC_DAPM_SUPPLY("ASYNCCLK", ARIZONA_ASYNC_CLOCK_1,
 		    ARIZONA_ASYNC_CLK_ENA_SHIFT, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("OPCLK", ARIZONA_OUTPUT_SYSTEM_CLOCK,
@@ -1909,6 +1911,8 @@ static int wm5102_probe(struct platform_device *pdev)
 	wm5102->core.arizona = arizona;
 	wm5102->core.num_inputs = 6;
 
+	arizona_init_dvfs(&wm5102->core);
+
 	wm5102->core.adsp[0].part = "wm5102";
 	wm5102->core.adsp[0].num = 1;
 	wm5102->core.adsp[0].type = WMFW_ADSP2;
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index a4d1177..2a129dc 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -106,11 +106,13 @@ static int wm8997_sysclk_ev(struct snd_soc_dapm_widget *w,
 				regmap_write_async(regmap, patch[i].reg,
 						   patch[i].def);
 		break;
-	default:
+	case SND_SOC_DAPM_PRE_PMD:
 		break;
+	default:
+		return 0;
 	}
 
-	return 0;
+	return arizona_dvfs_sysclk_ev(w, kcontrol, event);
 }
 
 static const char *wm8997_osr_text[] = {
@@ -409,7 +411,8 @@ static const struct snd_kcontrol_new wm8997_aec_loopback_mux =
 
 static const struct snd_soc_dapm_widget wm8997_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("SYSCLK", ARIZONA_SYSTEM_CLOCK_1, ARIZONA_SYSCLK_ENA_SHIFT,
-		    0, wm8997_sysclk_ev, SND_SOC_DAPM_POST_PMU),
+		    0, wm8997_sysclk_ev,
+		    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 SND_SOC_DAPM_SUPPLY("ASYNCCLK", ARIZONA_ASYNC_CLOCK_1,
 		    ARIZONA_ASYNC_CLK_ENA_SHIFT, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("OPCLK", ARIZONA_OUTPUT_SYSTEM_CLOCK,
@@ -1126,6 +1129,8 @@ static int wm8997_probe(struct platform_device *pdev)
 	wm8997->core.arizona = arizona;
 	wm8997->core.num_inputs = 4;
 
+	arizona_init_dvfs(&wm8997->core);
+
 	for (i = 0; i < ARRAY_SIZE(wm8997->fll); i++)
 		wm8997->fll[i].vco_mult = 1;
 
-- 
1.7.2.5
