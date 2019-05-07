From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH 2/3] ASoC: mediatek: mt6358: save output volume
	for mixer controls
Date: Tue,  7 May 2019 18:12:19 +0800
Message-ID: <20190507101220.182466-3-tzungbi@google.com>
References: <20190507101220.182466-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com
 [IPv6:2607:f8b0:4864:20::a4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8BA5DF89724
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 12:13:01 +0200 (CEST)
Received: by mail-vk1-xa4a.google.com with SMTP id r14so7177739vkd.18
 for <alsa-devel@alsa-project.org>; Tue, 07 May 2019 03:13:01 -0700 (PDT)
In-Reply-To: <20190507101220.182466-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, tiwai@suse.com
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

Output volume settings from mixer controls would be lost.

Imagine that "Headphone Volume" has set to -10dB via amixer:
- in mtk_hp_enable()
  - hp_store_gain() saves the volume setting -10dB from regmap_read()
    to ana_gain[AUDIO_ANALOG_VOLUME_HPOUTL]
  - headset_volume_ramp() ramps up from -10dB to -10dB
- in mtk_hp_disable()
  - headset_volume_ramp() ramps down from -10dB to -40dB

Next time in mtk_hp_enable(), hp_store_gain() would save -40dB but
not -10dB.  As a result, headset_volume_ramp() would ramp from -10dB to
-40dB (which is mute).

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/codecs/mt6358.c | 91 ++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/mt6358.c b/sound/soc/codecs/mt6358.c
index 96547ae50a5d..44edbda8afcc 100644
--- a/sound/soc/codecs/mt6358.c
+++ b/sound/soc/codecs/mt6358.c
@@ -320,32 +320,6 @@ enum {
 #define DL_GAIN_N_40DB_REG (DL_GAIN_N_40DB << 7 | DL_GAIN_N_40DB)
 #define DL_GAIN_REG_MASK 0x0f9f
 
-static void lo_store_gain(struct mt6358_priv *priv)
-{
-	unsigned int reg;
-	unsigned int gain_l, gain_r;
-
-	regmap_read(priv->regmap, MT6358_ZCD_CON1, &reg);
-	gain_l = (reg >> RG_AUDLOLGAIN_SFT) & RG_AUDLOLGAIN_MASK;
-	gain_r = (reg >> RG_AUDLORGAIN_SFT) & RG_AUDLORGAIN_MASK;
-
-	priv->ana_gain[AUDIO_ANALOG_VOLUME_LINEOUTL] = gain_l;
-	priv->ana_gain[AUDIO_ANALOG_VOLUME_LINEOUTR] = gain_r;
-}
-
-static void hp_store_gain(struct mt6358_priv *priv)
-{
-	unsigned int reg;
-	unsigned int gain_l, gain_r;
-
-	regmap_read(priv->regmap, MT6358_ZCD_CON2, &reg);
-	gain_l = (reg >> RG_AUDHPLGAIN_SFT) & RG_AUDHPLGAIN_MASK;
-	gain_r = (reg >> RG_AUDHPRGAIN_SFT) & RG_AUDHPRGAIN_MASK;
-
-	priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTL] = gain_l;
-	priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTR] = gain_r;
-}
-
 static void hp_zcd_disable(struct mt6358_priv *priv)
 {
 	regmap_write(priv->regmap, MT6358_ZCD_CON0, 0x0000);
@@ -439,20 +413,62 @@ static void headset_volume_ramp(struct mt6358_priv *priv, int from, int to)
 	}
 }
 
+static int mt6358_put_volsw(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+			snd_soc_kcontrol_component(kcontrol);
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc =
+			(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int reg;
+	int ret;
+
+	ret = snd_soc_put_volsw(kcontrol, ucontrol);
+	if (ret < 0)
+		return ret;
+
+	switch (mc->reg) {
+	case MT6358_ZCD_CON2:
+		regmap_read(priv->regmap, MT6358_ZCD_CON2, &reg);
+		priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTL] =
+			(reg >> RG_AUDHPLGAIN_SFT) & RG_AUDHPLGAIN_MASK;
+		priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTR] =
+			(reg >> RG_AUDHPRGAIN_SFT) & RG_AUDHPRGAIN_MASK;
+		break;
+	case MT6358_ZCD_CON1:
+		regmap_read(priv->regmap, MT6358_ZCD_CON1, &reg);
+		priv->ana_gain[AUDIO_ANALOG_VOLUME_LINEOUTL] =
+			(reg >> RG_AUDLOLGAIN_SFT) & RG_AUDLOLGAIN_MASK;
+		priv->ana_gain[AUDIO_ANALOG_VOLUME_LINEOUTR] =
+			(reg >> RG_AUDLORGAIN_SFT) & RG_AUDLORGAIN_MASK;
+		break;
+	case MT6358_ZCD_CON3:
+		regmap_read(priv->regmap, MT6358_ZCD_CON3, &reg);
+		priv->ana_gain[AUDIO_ANALOG_VOLUME_HSOUTL] =
+			(reg >> RG_AUDHSGAIN_SFT) & RG_AUDHSGAIN_MASK;
+		priv->ana_gain[AUDIO_ANALOG_VOLUME_HSOUTR] =
+			(reg >> RG_AUDHSGAIN_SFT) & RG_AUDHSGAIN_MASK;
+		break;
+	}
+
+	return ret;
+}
+
 static const DECLARE_TLV_DB_SCALE(playback_tlv, -1000, 100, 0);
 static const DECLARE_TLV_DB_SCALE(pga_tlv, 0, 600, 0);
 
 static const struct snd_kcontrol_new mt6358_snd_controls[] = {
 	/* dl pga gain */
-	SOC_DOUBLE_TLV("Headphone Volume",
-		       MT6358_ZCD_CON2, 0, 7, 0x12, 1,
-		       playback_tlv),
-	SOC_DOUBLE_TLV("Lineout Volume",
-		       MT6358_ZCD_CON1, 0, 7, 0x12, 1,
-		       playback_tlv),
-	SOC_SINGLE_TLV("Handset Volume",
-		       MT6358_ZCD_CON3, 0, 0x12, 1,
-		       playback_tlv),
+	SOC_DOUBLE_EXT_TLV("Headphone Volume",
+			   MT6358_ZCD_CON2, 0, 7, 0x12, 1,
+			   snd_soc_get_volsw, mt6358_put_volsw, playback_tlv),
+	SOC_DOUBLE_EXT_TLV("Lineout Volume",
+			   MT6358_ZCD_CON1, 0, 7, 0x12, 1,
+			   snd_soc_get_volsw, mt6358_put_volsw, playback_tlv),
+	SOC_SINGLE_EXT_TLV("Handset Volume",
+			   MT6358_ZCD_CON3, 0, 0x12, 1,
+			   snd_soc_get_volsw, mt6358_put_volsw, playback_tlv),
 	/* ul pga gain */
 	SOC_DOUBLE_R_TLV("PGA Volume",
 			 MT6358_AUDENC_ANA_CON0, MT6358_AUDENC_ANA_CON1,
@@ -831,8 +847,6 @@ static int mtk_hp_enable(struct mt6358_priv *priv)
 	/* Reduce ESD resistance of AU_REFN */
 	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON2, 0x4000);
 
-	/* save target gain to restore after hardware open complete */
-	hp_store_gain(priv);
 	/* Set HPR/HPL gain as minimum (~ -40dB) */
 	regmap_write(priv->regmap, MT6358_ZCD_CON2, DL_GAIN_N_40DB_REG);
 
@@ -1042,8 +1056,6 @@ static int mtk_hp_spk_enable(struct mt6358_priv *priv)
 	/* Reduce ESD resistance of AU_REFN */
 	regmap_write(priv->regmap, MT6358_AUDDEC_ANA_CON2, 0x4000);
 
-	/* save target gain to restore after hardware open complete */
-	hp_store_gain(priv);
 	/* Set HPR/HPL gain to -10dB */
 	regmap_write(priv->regmap, MT6358_ZCD_CON2, DL_GAIN_N_10DB_REG);
 
@@ -1103,7 +1115,6 @@ static int mtk_hp_spk_enable(struct mt6358_priv *priv)
 	hp_main_output_ramp(priv, true);
 
 	/* Set LO gain as minimum (~ -40dB) */
-	lo_store_gain(priv);
 	regmap_write(priv->regmap, MT6358_ZCD_CON1, DL_GAIN_N_40DB_REG);
 	/* apply volume setting */
 	headset_volume_ramp(priv,
-- 
2.21.0.1020.gf2820cf01a-goog
