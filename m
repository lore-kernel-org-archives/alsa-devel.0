From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2] ASoC: wm5110: Add additional analogue input
	enable for early revs
Date: Thu, 17 Sep 2015 10:45:24 +0100
Message-ID: <1442483124-9890-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 15AAF265289
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 12:08:59 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Earlier revisions of the wm5110/8280 silicon require a slightly more
complex procedure to enable analogue inputs. This patch adds this into
the driver.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Changes since v2:
 - Added a comment to explain why we need to hold the DAPM lock
   when setting the PGA volume for the inputs

Thanks,
Charles

 sound/soc/codecs/wm5110.c |  187 +++++++++++++++++++++++++++++++++++++++------
 1 files changed, 163 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 9756578..c04c0bc 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -38,6 +38,12 @@
 struct wm5110_priv {
 	struct arizona_priv core;
 	struct arizona_fll fll[2];
+
+	unsigned int in_value;
+	int in_pre_pending;
+	int in_post_pending;
+
+	unsigned int in_pga_cache[6];
 };
 
 static const struct wm_adsp_region wm5110_dsp1_regions[] = {
@@ -428,6 +434,127 @@ err:
 	return ret;
 }
 
+static int wm5110_in_pga_get(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_card *card = dapm->card;
+	int ret;
+
+	/*
+	 * PGA Volume is also used as part of the enable sequence, so
+	 * usage of it should be avoided whilst that is running.
+	 */
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+
+	ret = snd_soc_get_volsw_range(kcontrol, ucontrol);
+
+	mutex_unlock(&card->dapm_mutex);
+
+	return ret;
+}
+
+static int wm5110_in_pga_put(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_card *card = dapm->card;
+	int ret;
+
+	/*
+	 * PGA Volume is also used as part of the enable sequence, so
+	 * usage of it should be avoided whilst that is running.
+	 */
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+
+	ret = snd_soc_put_volsw_range(kcontrol, ucontrol);
+
+	mutex_unlock(&card->dapm_mutex);
+
+	return ret;
+}
+
+static int wm5110_in_analog_ev(struct snd_soc_dapm_widget *w,
+			       struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct wm5110_priv *wm5110 = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
+	unsigned int reg, mask;
+	struct reg_sequence analog_seq[] = {
+		{ 0x80, 0x3 },
+		{ 0x35d, 0 },
+		{ 0x80, 0x0 },
+	};
+
+	reg = ARIZONA_IN1L_CONTROL + ((w->shift ^ 0x1) * 4);
+	mask = ARIZONA_IN1L_PGA_VOL_MASK;
+
+	switch (event) {
+	case SND_SOC_DAPM_WILL_PMU:
+		wm5110->in_value |= 0x3 << ((w->shift ^ 0x1) * 2);
+		wm5110->in_pre_pending++;
+		wm5110->in_post_pending++;
+		return 0;
+	case SND_SOC_DAPM_PRE_PMU:
+		wm5110->in_pga_cache[w->shift] = snd_soc_read(codec, reg);
+
+		snd_soc_update_bits(codec, reg, mask,
+				    0x40 << ARIZONA_IN1L_PGA_VOL_SHIFT);
+
+		wm5110->in_pre_pending--;
+		if (wm5110->in_pre_pending == 0) {
+			analog_seq[1].def = wm5110->in_value;
+			regmap_multi_reg_write_bypassed(arizona->regmap,
+							analog_seq,
+							ARRAY_SIZE(analog_seq));
+
+			msleep(55);
+
+			wm5110->in_value = 0;
+		}
+
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_update_bits(codec, reg, mask,
+				    wm5110->in_pga_cache[w->shift]);
+
+		wm5110->in_post_pending--;
+		if (wm5110->in_post_pending == 0)
+			regmap_multi_reg_write_bypassed(arizona->regmap,
+							analog_seq,
+							ARRAY_SIZE(analog_seq));
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int wm5110_in_ev(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
+
+	switch (arizona->rev) {
+	case 0 ... 4:
+		if (arizona_input_analog(codec, w->shift))
+			wm5110_in_analog_ev(w, kcontrol, event);
+
+		break;
+	default:
+		break;
+	}
+
+	return arizona_in_ev(w, kcontrol, event);
+}
+
 static DECLARE_TLV_DB_SCALE(ana_tlv, 0, 100, 0);
 static DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 static DECLARE_TLV_DB_SCALE(digital_tlv, -6400, 50, 0);
@@ -454,18 +581,24 @@ SOC_ENUM("IN2 OSR", arizona_in_dmic_osr[1]),
 SOC_ENUM("IN3 OSR", arizona_in_dmic_osr[2]),
 SOC_ENUM("IN4 OSR", arizona_in_dmic_osr[3]),
 
-SOC_SINGLE_RANGE_TLV("IN1L Volume", ARIZONA_IN1L_CONTROL,
-		     ARIZONA_IN1L_PGA_VOL_SHIFT, 0x40, 0x5f, 0, ana_tlv),
-SOC_SINGLE_RANGE_TLV("IN1R Volume", ARIZONA_IN1R_CONTROL,
-		     ARIZONA_IN1R_PGA_VOL_SHIFT, 0x40, 0x5f, 0, ana_tlv),
-SOC_SINGLE_RANGE_TLV("IN2L Volume", ARIZONA_IN2L_CONTROL,
-		     ARIZONA_IN2L_PGA_VOL_SHIFT, 0x40, 0x5f, 0, ana_tlv),
-SOC_SINGLE_RANGE_TLV("IN2R Volume", ARIZONA_IN2R_CONTROL,
-		     ARIZONA_IN2R_PGA_VOL_SHIFT, 0x40, 0x5f, 0, ana_tlv),
-SOC_SINGLE_RANGE_TLV("IN3L Volume", ARIZONA_IN3L_CONTROL,
-		     ARIZONA_IN3L_PGA_VOL_SHIFT, 0x40, 0x5f, 0, ana_tlv),
-SOC_SINGLE_RANGE_TLV("IN3R Volume", ARIZONA_IN3R_CONTROL,
-		     ARIZONA_IN3R_PGA_VOL_SHIFT, 0x40, 0x5f, 0, ana_tlv),
+SOC_SINGLE_RANGE_EXT_TLV("IN1L Volume", ARIZONA_IN1L_CONTROL,
+			 ARIZONA_IN1L_PGA_VOL_SHIFT, 0x40, 0x5f, 0,
+			 wm5110_in_pga_get, wm5110_in_pga_put, ana_tlv),
+SOC_SINGLE_RANGE_EXT_TLV("IN1R Volume", ARIZONA_IN1R_CONTROL,
+			 ARIZONA_IN1R_PGA_VOL_SHIFT, 0x40, 0x5f, 0,
+			 wm5110_in_pga_get, wm5110_in_pga_put, ana_tlv),
+SOC_SINGLE_RANGE_EXT_TLV("IN2L Volume", ARIZONA_IN2L_CONTROL,
+			 ARIZONA_IN2L_PGA_VOL_SHIFT, 0x40, 0x5f, 0,
+			 wm5110_in_pga_get, wm5110_in_pga_put, ana_tlv),
+SOC_SINGLE_RANGE_EXT_TLV("IN2R Volume", ARIZONA_IN2R_CONTROL,
+			 ARIZONA_IN2R_PGA_VOL_SHIFT, 0x40, 0x5f, 0,
+			 wm5110_in_pga_get, wm5110_in_pga_put, ana_tlv),
+SOC_SINGLE_RANGE_EXT_TLV("IN3L Volume", ARIZONA_IN3L_CONTROL,
+			 ARIZONA_IN3L_PGA_VOL_SHIFT, 0x40, 0x5f, 0,
+			 wm5110_in_pga_get, wm5110_in_pga_put, ana_tlv),
+SOC_SINGLE_RANGE_EXT_TLV("IN3R Volume", ARIZONA_IN3R_CONTROL,
+			 ARIZONA_IN3R_PGA_VOL_SHIFT, 0x40, 0x5f, 0,
+			 wm5110_in_pga_get, wm5110_in_pga_put, ana_tlv),
 
 SOC_ENUM("IN HPF Cutoff Frequency", arizona_in_hpf_cut_enum),
 
@@ -896,29 +1029,35 @@ SND_SOC_DAPM_OUTPUT("DRC1 Signal Activity"),
 SND_SOC_DAPM_OUTPUT("DRC2 Signal Activity"),
 
 SND_SOC_DAPM_PGA_E("IN1L PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN1L_ENA_SHIFT,
-		   0, NULL, 0, arizona_in_ev,
+		   0, NULL, 0, wm5110_in_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
-		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		   SND_SOC_DAPM_WILL_PMU),
 SND_SOC_DAPM_PGA_E("IN1R PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN1R_ENA_SHIFT,
-		   0, NULL, 0, arizona_in_ev,
+		   0, NULL, 0, wm5110_in_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
-		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		   SND_SOC_DAPM_WILL_PMU),
 SND_SOC_DAPM_PGA_E("IN2L PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN2L_ENA_SHIFT,
-		   0, NULL, 0, arizona_in_ev,
+		   0, NULL, 0, wm5110_in_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
-		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		   SND_SOC_DAPM_WILL_PMU),
 SND_SOC_DAPM_PGA_E("IN2R PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN2R_ENA_SHIFT,
-		   0, NULL, 0, arizona_in_ev,
+		   0, NULL, 0, wm5110_in_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
-		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		   SND_SOC_DAPM_WILL_PMU),
 SND_SOC_DAPM_PGA_E("IN3L PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN3L_ENA_SHIFT,
-		   0, NULL, 0, arizona_in_ev,
+		   0, NULL, 0, wm5110_in_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
-		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		   SND_SOC_DAPM_WILL_PMU),
 SND_SOC_DAPM_PGA_E("IN3R PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN3R_ENA_SHIFT,
-		   0, NULL, 0, arizona_in_ev,
+		   0, NULL, 0, wm5110_in_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
-		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		   SND_SOC_DAPM_WILL_PMU),
 SND_SOC_DAPM_PGA_E("IN4L PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN4L_ENA_SHIFT,
 		   0, NULL, 0, arizona_in_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
-- 
1.7.2.5
