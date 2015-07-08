From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm5110: Add special DRE on/off handling
	for the headphone path" to the asoc tree
Date: Wed, 08 Jul 2015 20:23:36 +0100
Message-ID: <E1ZCuwS-0005ss-LE@debutante>
References: <1435838281-15873-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BDE0A26512B
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 21:23:45 +0200 (CEST)
In-Reply-To: <1435838281-15873-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: wm5110: Add special DRE on/off handling for the headphone path

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

>From d1acd31883d78f905a930493ff145ca4a25ad680 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 7 Jul 2015 15:28:14 +0100
Subject: [PATCH] ASoC: wm5110: Add special DRE on/off handling for the
 headphone path

For the best performance the headphone path enable/disable must be
handled specially for the situations of DRE on and DRE off.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5110.c | 285 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 276 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 709fcc6169d8..b5c201b1e454 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -131,6 +131,25 @@ static const struct reg_default wm5110_sysclk_revd_patch[] = {
 	{ 0x33fb, 0xfe00 },
 };
 
+static const struct reg_default wm5110_sysclk_reve_patch[] = {
+	{ 0x3270, 0xE410 },
+	{ 0x3271, 0x3078 },
+	{ 0x3272, 0xE410 },
+	{ 0x3273, 0x3070 },
+	{ 0x3274, 0xE410 },
+	{ 0x3275, 0x3066 },
+	{ 0x3276, 0xE410 },
+	{ 0x3277, 0x3056 },
+	{ 0x327A, 0xE414 },
+	{ 0x327B, 0x3078 },
+	{ 0x327C, 0xE414 },
+	{ 0x327D, 0x3070 },
+	{ 0x327E, 0xE414 },
+	{ 0x327F, 0x3066 },
+	{ 0x3280, 0xE414 },
+	{ 0x3281, 0x3056 },
+};
+
 static int wm5110_sysclk_ev(struct snd_soc_dapm_widget *w,
 			    struct snd_kcontrol *kcontrol, int event)
 {
@@ -146,7 +165,9 @@ static int wm5110_sysclk_ev(struct snd_soc_dapm_widget *w,
 		patch_size = ARRAY_SIZE(wm5110_sysclk_revd_patch);
 		break;
 	default:
-		return 0;
+		patch = wm5110_sysclk_reve_patch;
+		patch_size = ARRAY_SIZE(wm5110_sysclk_reve_patch);
+		break;
 	}
 
 	switch (event) {
@@ -164,6 +185,249 @@ static int wm5110_sysclk_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static const struct reg_default wm5110_no_dre_left_enable[] = {
+	{ 0x3024, 0xE410 },
+	{ 0x3025, 0x0056 },
+	{ 0x301B, 0x0224 },
+	{ 0x301F, 0x4263 },
+	{ 0x3021, 0x5291 },
+	{ 0x3030, 0xE410 },
+	{ 0x3031, 0x3066 },
+	{ 0x3032, 0xE410 },
+	{ 0x3033, 0x3070 },
+	{ 0x3034, 0xE410 },
+	{ 0x3035, 0x3078 },
+	{ 0x3036, 0xE410 },
+	{ 0x3037, 0x3080 },
+	{ 0x3038, 0xE410 },
+	{ 0x3039, 0x3080 },
+};
+
+static const struct reg_default wm5110_dre_left_enable[] = {
+	{ 0x3024, 0x0231 },
+	{ 0x3025, 0x0B00 },
+	{ 0x301B, 0x0227 },
+	{ 0x301F, 0x4266 },
+	{ 0x3021, 0x5294 },
+	{ 0x3030, 0xE231 },
+	{ 0x3031, 0x0266 },
+	{ 0x3032, 0x8231 },
+	{ 0x3033, 0x4B15 },
+	{ 0x3034, 0x8231 },
+	{ 0x3035, 0x0B15 },
+	{ 0x3036, 0xE231 },
+	{ 0x3037, 0x5294 },
+	{ 0x3038, 0x0231 },
+	{ 0x3039, 0x0B00 },
+};
+
+static const struct reg_default wm5110_no_dre_right_enable[] = {
+	{ 0x3074, 0xE414 },
+	{ 0x3075, 0x0056 },
+	{ 0x306B, 0x0224 },
+	{ 0x306F, 0x4263 },
+	{ 0x3071, 0x5291 },
+	{ 0x3080, 0xE414 },
+	{ 0x3081, 0x3066 },
+	{ 0x3082, 0xE414 },
+	{ 0x3083, 0x3070 },
+	{ 0x3084, 0xE414 },
+	{ 0x3085, 0x3078 },
+	{ 0x3086, 0xE414 },
+	{ 0x3087, 0x3080 },
+	{ 0x3088, 0xE414 },
+	{ 0x3089, 0x3080 },
+};
+
+static const struct reg_default wm5110_dre_right_enable[] = {
+	{ 0x3074, 0x0231 },
+	{ 0x3075, 0x0B00 },
+	{ 0x306B, 0x0227 },
+	{ 0x306F, 0x4266 },
+	{ 0x3071, 0x5294 },
+	{ 0x3080, 0xE231 },
+	{ 0x3081, 0x0266 },
+	{ 0x3082, 0x8231 },
+	{ 0x3083, 0x4B17 },
+	{ 0x3084, 0x8231 },
+	{ 0x3085, 0x0B17 },
+	{ 0x3086, 0xE231 },
+	{ 0x3087, 0x5294 },
+	{ 0x3088, 0x0231 },
+	{ 0x3089, 0x0B00 },
+};
+
+static int wm5110_hp_pre_enable(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
+	unsigned int val = snd_soc_read(codec, ARIZONA_DRE_ENABLE);
+	const struct reg_default *wseq;
+	int nregs;
+
+	switch (w->shift) {
+	case ARIZONA_OUT1L_ENA_SHIFT:
+		if (val & ARIZONA_DRE1L_ENA_MASK) {
+			wseq = wm5110_dre_left_enable;
+			nregs = ARRAY_SIZE(wm5110_dre_left_enable);
+		} else {
+			wseq = wm5110_no_dre_left_enable;
+			nregs = ARRAY_SIZE(wm5110_no_dre_left_enable);
+			priv->out_up_delay += 10;
+		}
+		break;
+	case ARIZONA_OUT1R_ENA_SHIFT:
+		if (val & ARIZONA_DRE1R_ENA_MASK) {
+			wseq = wm5110_dre_right_enable;
+			nregs = ARRAY_SIZE(wm5110_dre_right_enable);
+		} else {
+			wseq = wm5110_no_dre_right_enable;
+			nregs = ARRAY_SIZE(wm5110_no_dre_right_enable);
+			priv->out_up_delay += 10;
+		}
+		break;
+	default:
+		return 0;
+	}
+
+	return regmap_multi_reg_write(arizona->regmap, wseq, nregs);
+}
+
+static int wm5110_hp_pre_disable(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	unsigned int val = snd_soc_read(codec, ARIZONA_DRE_ENABLE);
+
+	switch (w->shift) {
+	case ARIZONA_OUT1L_ENA_SHIFT:
+		if (!(val & ARIZONA_DRE1L_ENA_MASK)) {
+			snd_soc_update_bits(codec, ARIZONA_SPARE_TRIGGERS,
+					    ARIZONA_WS_TRG1, ARIZONA_WS_TRG1);
+			snd_soc_update_bits(codec, ARIZONA_SPARE_TRIGGERS,
+					    ARIZONA_WS_TRG1, 0);
+			priv->out_down_delay += 27;
+		}
+		break;
+	case ARIZONA_OUT1R_ENA_SHIFT:
+		if (!(val & ARIZONA_DRE1R_ENA_MASK)) {
+			snd_soc_update_bits(codec, ARIZONA_SPARE_TRIGGERS,
+					    ARIZONA_WS_TRG2, ARIZONA_WS_TRG2);
+			snd_soc_update_bits(codec, ARIZONA_SPARE_TRIGGERS,
+					    ARIZONA_WS_TRG2, 0);
+			priv->out_down_delay += 27;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int wm5110_hp_ev(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+
+	switch (priv->arizona->rev) {
+	case 0 ... 3:
+		break;
+	default:
+		switch (event) {
+		case SND_SOC_DAPM_PRE_PMU:
+			wm5110_hp_pre_enable(w);
+			break;
+		case SND_SOC_DAPM_PRE_PMD:
+			wm5110_hp_pre_disable(w);
+			break;
+		default:
+			break;
+		}
+		break;
+	}
+
+	return arizona_hp_ev(w, kcontrol, event);
+}
+
+static int wm5110_clear_pga_volume(struct arizona *arizona, int output)
+{
+	struct reg_default clear_pga = {
+		ARIZONA_OUTPUT_PATH_CONFIG_1L + output * 4, 0x80
+	};
+	int ret;
+
+	ret = regmap_multi_reg_write_bypassed(arizona->regmap, &clear_pga, 1);
+	if (ret)
+		dev_err(arizona->dev, "Failed to clear PGA (0x%x): %d\n",
+			clear_pga.reg, ret);
+
+	return ret;
+}
+
+static int wm5110_put_dre(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int ena, dre;
+	unsigned int mask = (0x1 << mc->shift) | (0x1 << mc->rshift);
+	unsigned int lnew = (!!ucontrol->value.integer.value[0]) << mc->shift;
+	unsigned int rnew = (!!ucontrol->value.integer.value[1]) << mc->rshift;
+	unsigned int lold, rold;
+	unsigned int lena, rena;
+	int ret;
+
+	snd_soc_dapm_mutex_lock(dapm);
+
+	ret = regmap_read(arizona->regmap, ARIZONA_OUTPUT_ENABLES_1, &ena);
+	if (ret) {
+		dev_err(arizona->dev, "Failed to read output state: %d\n", ret);
+		goto err;
+	}
+	ret = regmap_read(arizona->regmap, ARIZONA_DRE_ENABLE, &dre);
+	if (ret) {
+		dev_err(arizona->dev, "Failed to read DRE state: %d\n", ret);
+		goto err;
+	}
+
+	lold = dre & (1 << mc->shift);
+	rold = dre & (1 << mc->rshift);
+	/* Enables are channel wise swapped from the DRE enables */
+	lena = ena & (1 << mc->rshift);
+	rena = ena & (1 << mc->shift);
+
+	if ((lena && lnew != lold) || (rena && rnew != rold)) {
+		dev_err(arizona->dev, "Can't change DRE on active outputs\n");
+		ret = -EBUSY;
+		goto err;
+	}
+
+	ret = regmap_update_bits(arizona->regmap, ARIZONA_DRE_ENABLE,
+				 mask, lnew | rnew);
+	if (ret) {
+		dev_err(arizona->dev, "Failed to set DRE: %d\n", ret);
+		goto err;
+	}
+
+	/* Force reset of PGA volumes, if turning DRE off */
+	if (!lnew && lold)
+		wm5110_clear_pga_volume(arizona, mc->shift);
+
+	if (!rnew && rold)
+		wm5110_clear_pga_volume(arizona, mc->rshift);
+
+err:
+	snd_soc_dapm_mutex_unlock(dapm);
+
+	return ret;
+}
+
 static DECLARE_TLV_DB_SCALE(ana_tlv, 0, 100, 0);
 static DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 static DECLARE_TLV_DB_SCALE(digital_tlv, -6400, 50, 0);
@@ -409,12 +673,15 @@ SOC_DOUBLE("SPKDAT1 Switch", ARIZONA_PDM_SPK1_CTRL_1, ARIZONA_SPK1L_MUTE_SHIFT,
 SOC_DOUBLE("SPKDAT2 Switch", ARIZONA_PDM_SPK2_CTRL_1, ARIZONA_SPK2L_MUTE_SHIFT,
 	   ARIZONA_SPK2R_MUTE_SHIFT, 1, 1),
 
-SOC_DOUBLE("HPOUT1 DRE Switch", ARIZONA_DRE_ENABLE,
-	   ARIZONA_DRE1L_ENA_SHIFT, ARIZONA_DRE1R_ENA_SHIFT, 1, 0),
-SOC_DOUBLE("HPOUT2 DRE Switch", ARIZONA_DRE_ENABLE,
-	   ARIZONA_DRE2L_ENA_SHIFT, ARIZONA_DRE2R_ENA_SHIFT, 1, 0),
-SOC_DOUBLE("HPOUT3 DRE Switch", ARIZONA_DRE_ENABLE,
-	   ARIZONA_DRE3L_ENA_SHIFT, ARIZONA_DRE3R_ENA_SHIFT, 1, 0),
+SOC_DOUBLE_EXT("HPOUT1 DRE Switch", ARIZONA_DRE_ENABLE,
+	   ARIZONA_DRE1L_ENA_SHIFT, ARIZONA_DRE1R_ENA_SHIFT, 1, 0,
+	   snd_soc_get_volsw, wm5110_put_dre),
+SOC_DOUBLE_EXT("HPOUT2 DRE Switch", ARIZONA_DRE_ENABLE,
+	   ARIZONA_DRE2L_ENA_SHIFT, ARIZONA_DRE2R_ENA_SHIFT, 1, 0,
+	   snd_soc_get_volsw, wm5110_put_dre),
+SOC_DOUBLE_EXT("HPOUT3 DRE Switch", ARIZONA_DRE_ENABLE,
+	   ARIZONA_DRE3L_ENA_SHIFT, ARIZONA_DRE3R_ENA_SHIFT, 1, 0,
+	   snd_soc_get_volsw, wm5110_put_dre),
 
 SOC_ENUM("Output Ramp Up", arizona_out_vi_ramp),
 SOC_ENUM("Output Ramp Down", arizona_out_vd_ramp),
@@ -904,11 +1171,11 @@ SND_SOC_DAPM_AIF_IN("AIF3RX2", NULL, 0,
 		    ARIZONA_AIF3_RX_ENABLES, ARIZONA_AIF3RX2_ENA_SHIFT, 0),
 
 SND_SOC_DAPM_PGA_E("OUT1L", SND_SOC_NOPM,
-		   ARIZONA_OUT1L_ENA_SHIFT, 0, NULL, 0, arizona_hp_ev,
+		   ARIZONA_OUT1L_ENA_SHIFT, 0, NULL, 0, wm5110_hp_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
 		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 SND_SOC_DAPM_PGA_E("OUT1R", SND_SOC_NOPM,
-		   ARIZONA_OUT1R_ENA_SHIFT, 0, NULL, 0, arizona_hp_ev,
+		   ARIZONA_OUT1R_ENA_SHIFT, 0, NULL, 0, wm5110_hp_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
 		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 SND_SOC_DAPM_PGA_E("OUT2L", ARIZONA_OUTPUT_ENABLES_1,
-- 
2.1.4
