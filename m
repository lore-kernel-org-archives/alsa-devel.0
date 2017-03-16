From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2] ASoC: rt286: fix headphone click/crack
	noise on Dell XPS 9343 I2S mode
Date: Thu, 16 Mar 2017 16:39:51 +0800
Message-ID: <20170316083951.11247-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 3991B267107
 for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2017 09:40:05 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

HDA mode fixed the issue by these two commits:

'9476d369d7b3 ALSA: hda - Mute headphone pin on suspend on XPS13 9333'
'3e1b0c4a9d56 ALSA: hda - Fix click noise at start on Dell XPS13'

Apply the same workarounds to rt286 can solve the issue.

When jack is plugged, it rapidly generates I2C interrupts, which
triggers rt286_irq() and rt286_jack_detect(), which produces the click
noise.
alc_fixup_dell_xps13() in patch_realtek.c sets up a pin that can stop
the frantic interrupts, hence avoids the click noise.

When rt286 is under powersaving state, play a sound with headphone or
plug a headphone in will produce a loud crack sound.
Set AMP_OUT_MUTE before power events can make the noise less noticeable.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=112611
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1313434
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/soc/codecs/rt286.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 9c365a7f758d..ec4caef045e9 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -36,6 +36,9 @@
 #define RT286_VENDOR_ID 0x10ec0286
 #define RT288_VENDOR_ID 0x10ec0288
 
+#define AMP_OUT_MUTE    0xb080
+#define AMP_OUT_UNMUTE  0xb000
+
 struct rt286_priv {
 	struct reg_default *index_cache;
 	int index_cache_size;
@@ -47,6 +50,7 @@ struct rt286_priv {
 	struct delayed_work jack_detect_work;
 	int sys_clk;
 	int clk_id;
+	bool is_dell_dino;
 };
 
 static const struct reg_default rt286_index_def[] = {
@@ -472,6 +476,32 @@ static int rt286_set_dmic1_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+/* Power event function to workaround headphone crack noise */
+static int rt286_hp_power_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
+
+	if (!rt286->is_dell_dino)
+		return 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMD:
+	case SND_SOC_DAPM_POST_PMD:
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO, AMP_OUT_MUTE);
+		break;
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO, AMP_OUT_UNMUTE);
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static int rt286_ldo2_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event)
 {
@@ -578,7 +608,9 @@ static const struct snd_soc_dapm_widget rt286_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("HPO Mux", SND_SOC_NOPM, 0, 0, &rt286_hpo_mux),
 
 	SND_SOC_DAPM_SUPPLY("HP Power", RT286_SET_PIN_HPO,
-		RT286_SET_PIN_SFT, 0, NULL, 0),
+		RT286_SET_PIN_SFT, 0, rt286_hp_power_event,
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
 	/* Output Mixer */
 	SND_SOC_DAPM_MIXER("Front", RT286_SET_POWER(RT286_DAC_OUT1), 0, 1,
@@ -1175,8 +1207,10 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	if (pdata)
 		rt286->pdata = *pdata;
 
+	rt286->is_dell_dino = dmi_check_system(dmi_dell_dino) ? true : false;
+
 	if (dmi_check_system(force_combo_jack_table) ||
-		dmi_check_system(dmi_dell_dino))
+		rt286->is_dell_dino)
 		rt286->pdata.cbj_en = true;
 
 	regmap_write(rt286->regmap, RT286_SET_AUDIO_POWER, AC_PWRST_D3);
@@ -1192,6 +1226,11 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 		regmap_update_bits(rt286->regmap,
 					RT286_CBJ_CTRL1, 0xf000, 0xb000);
 	} else {
+		/* Fix headphone click noise */
+		if (rt286->is_dell_dino)
+			regmap_write(rt286->regmap,
+					RT286_MIC1_DET_CTRL, 0x0020);
+
 		regmap_update_bits(rt286->regmap,
 					RT286_CBJ_CTRL1, 0xf000, 0x5000);
 	}
@@ -1215,7 +1254,7 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(rt286->regmap, RT286_DEPOP_CTRL3, 0xf777, 0x4737);
 	regmap_update_bits(rt286->regmap, RT286_DEPOP_CTRL4, 0x00ff, 0x003f);
 
-	if (dmi_check_system(dmi_dell_dino)) {
+	if (rt286->is_dell_dino) {
 		regmap_update_bits(rt286->regmap,
 			RT286_SET_GPIO_MASK, 0x40, 0x40);
 		regmap_update_bits(rt286->regmap,
@@ -1224,6 +1263,9 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 			RT286_SET_GPIO_DATA, 0x40, 0x40);
 		regmap_update_bits(rt286->regmap,
 			RT286_GPIO_CTRL, 0xc, 0x8);
+		/* Workaound headphone crack noise when probing */
+		regmap_write(rt286->regmap, RT286_SET_AMP_GAIN_HPO,
+				AMP_OUT_MUTE);
 	}
 
 	if (rt286->i2c->irq) {
-- 
2.12.0
