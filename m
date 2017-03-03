From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 08/10] Added DAI Sel Mux and minor updates
Date: Fri, 3 Mar 2017 23:52:46 +0900
Message-ID: <1488552768-14901-9-git-send-email-ryans.lee@maximintegrated.com>
References: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0129.outbound.protection.outlook.com [104.47.34.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 81FFC266B61
 for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2017 15:54:30 +0100 (CET)
In-Reply-To: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, arnd@arndb.de, michael@amarulasolutions.com, oder_chiou@realtek.com, yesanishhere@gmail.com, jacob@teenage.engineering, Damien.Horsley@imgtec.com, bardliao@realtek.com, kuninori.morimoto.gx@renesas.com, petr@barix.com, lars@metafoo.de, nh6z@nh6z.net, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
'DAI Sel Mux' was added.
'max98927_volatile_reg' was added to identify volatile register.

 sound/soc/codecs/max98927.c | 60 +++++++++++++++++++++++++++++++++------------
 sound/soc/codecs/max98927.h |  2 --
 2 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index df2f4ff..6eb745bd 100755
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -446,11 +446,24 @@ static int max98927_dac_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static const char * const max98927_switch_text[] = {
+	"Left", "Right", "LeftRight"};
+
+static const struct soc_enum dai_sel_enum =
+	SOC_ENUM_SINGLE(MAX98927_R0025_PCM_TO_SPK_MONOMIX_A,
+		MAX98927_PCM_TO_SPK_MONOMIX_CFG_SHIFT,
+		3, max98927_switch_text);
+
+static const struct snd_kcontrol_new max98927_dai_controls =
+	SOC_DAPM_ENUM("DAI Sel", dai_sel_enum);
+
 static const struct snd_soc_dapm_widget max98927_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_IN("DAI_OUT", "HiFi Playback", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC_E("Amp Enable", "HiFi Playback", MAX98927_R003A_AMP_EN,
 		0, 0, max98927_dac_event,
 		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MUX("DAI Sel Mux", SND_SOC_NOPM, 0, 0,
+		&max98927_dai_controls),
 	SND_SOC_DAPM_OUTPUT("BE_OUT"),
 };
 
@@ -476,12 +489,14 @@ static int max98927_spk_gain_put(struct snd_kcontrol *kcontrol,
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 	unsigned int sel = ucontrol->value.integer.value[0];
 
-	if (sel < ((1 << MAX98927_Speaker_Gain_Width) - 1)) {
-		regmap_update_bits(max98927->regmap,
-			MAX98927_R003C_SPK_GAIN,
-			MAX98927_SPK_PCM_GAIN_MASK, sel);
-		max98927->spk_gain = sel;
-	}
+	/* 0x7 is reserved */
+	if (sel > 6)
+		return -EINVAL;
+
+	regmap_update_bits(max98927->regmap,
+		MAX98927_R003C_SPK_GAIN,
+		MAX98927_SPK_PCM_GAIN_MASK, sel);
+	max98927->spk_gain = sel;
 	return 0;
 }
 
@@ -538,6 +553,15 @@ static int max98927_amp_vol_get(struct snd_kcontrol *kcontrol,
 		MAX98927_AMP_VOL_SHIFT);
 }
 
+static int max98927_amp_vol_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	return max98927_reg_put(kcontrol, ucontrol,
+		MAX98927_R0036_AMP_VOL_CTRL,
+		MAX98927_AMP_VOL_SEL,
+		MAX98927_AMP_VOL_SHIFT);
+}
+
 static int max98927_amp_dsp_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
@@ -587,14 +611,6 @@ static int max98927_dre_en_get(struct snd_kcontrol *kcontrol,
 		MAX98927_R0039_DRE_CTRL,
 		MAX98927_DRE_CTRL_DRE_EN, 0);
 }
-static int max98927_amp_vol_put(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	return max98927_reg_put(kcontrol, ucontrol,
-		MAX98927_R0036_AMP_VOL_CTRL,
-		MAX98927_AMP_VOL_SEL,
-		7);
-}
 static int max98927_spk_src_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
@@ -646,6 +662,15 @@ static bool max98927_readable_register(struct device *dev, unsigned int reg)
 	case MAX98927_R0100_SOFT_RESET:
 	case MAX98927_R01FF_REV_ID:
 		return true;
+	}
+	return false;
+};
+
+static bool max98927_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX98927_R0001_INT_RAW1 ... MAX98927_R0009_INT_FLAG3:
+		return true;
 	default:
 		return false;
 	}
@@ -711,7 +736,11 @@ static const struct snd_kcontrol_new max98927_snd_controls[] = {
 };
 
 static const struct snd_soc_dapm_route max98927_audio_map[] = {
-	{"BE_OUT", NULL, "Amp Enable"},
+	{"Amp Enable", NULL, "DAI_OUT"},
+	{"DAI Sel Mux", "Left", "Amp Enable"},
+	{"DAI Sel Mux", "Right", "Amp Enable"},
+	{"DAI Sel Mux", "LeftRight", "Amp Enable"},
+	{"BE_OUT", NULL, "DAI Sel Mux"},
 };
 
 static struct snd_soc_dai_driver max98927_dai[] = {
@@ -888,6 +917,7 @@ static const struct regmap_config max98927_regmap = {
 	.reg_defaults     = max98927_reg,
 	.num_reg_defaults = ARRAY_SIZE(max98927_reg),
 	.readable_reg	  = max98927_readable_register,
+	.volatile_reg	  = max98927_volatile_reg,
 	.cache_type       = REGCACHE_RBTREE,
 };
 
diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
index 2de8504..e13e18a 100755
--- a/sound/soc/codecs/max98927.h
+++ b/sound/soc/codecs/max98927.h
@@ -264,6 +264,4 @@ struct max98927_priv {
 	unsigned int master;
 	unsigned int digital_gain;
 };
-#define MAX98927_Speaker_Gain_Width 3
-#define MAX98927_AMP_VOL_LOCATION_SHIFT 7
 #endif
-- 
2.7.4
