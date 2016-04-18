From: Timur Karaldin <karaldin@mcsplus.ru>
Subject: [PATCH V2 1/2] ASoC: TLV320AIC3x: Adding additional
 functionality for 3106
Date: Mon, 18 Apr 2016 19:28:41 +0300
Message-ID: <57150B39.8000709@mcsplus.ru>
References: <56E69B3F.8090306@mcsplus.ru> <56E6CEE9.5030802@ti.com>
 <56E7FC3C.1030503@mcsplus.ru> <56E802D9.4040501@ti.com>
 <56E834B0.5010808@mcsplus.ru> <56E91FEE.4070604@ti.com>
 <56E934CB.4040209@mcsplus.ru> <56E97A75.7030700@ti.com>
 <56E98F99.2060100@mcsplus.ru> <56EA7833.7080302@ti.com>
 <56F2B48B.9030903@mcsplus.ru> <56FD1EF9.2030408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.mail.ru (smtp1.mail.ru [94.100.179.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B10A2264FF9
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 18:28:43 +0200 (CEST)
In-Reply-To: <56FD1EF9.2030408@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Here is the result.
----------------------------------------------------------------------------
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index d7349bc..3b0fae1 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -89,6 +89,9 @@ struct aic3x_priv {

         /* Selects the micbias voltage */
         enum aic3x_micbias_voltage micbias_vg;
+       unsigned char cached_gain[LINE1L_2_RADC_CTRL -
+                       MIC3LR_2_LADC_CTRL + 1];
+       int bypass;
  };

  static const struct reg_default aic3x_reg[] = {
@@ -134,16 +137,166 @@ static const struct regmap_config aic3x_regmap = {

  #define SOC_DAPM_SINGLE_AIC3X(xname, reg, shift, mask, invert) \
         SOC_SINGLE_EXT(xname, reg, shift, mask, invert, \
-               snd_soc_dapm_get_volsw, snd_soc_dapm_put_volsw_aic3x)
+               snd_soc_dapm_get_volsw_aic3x, snd_soc_dapm_put_volsw_aic3x)
+
+#define SOC_DOUBLE_R_AIC3X_TLV(xname, reg, rreg, shift, mask, invert) \
+       SOC_DOUBLE_R_EXT_TLV(xname, reg, rreg, shift, mask, invert, \
+       snd_soc_get_gain_aic3x, snd_soc_put_gain_aic3x, gain_stage_tlv)
+
+#define SOC_SINGLE_AIC3X_TLV(xname, reg, shift, mask, invert) \
+       SOC_SINGLE_EXT_TLV(xname, reg, shift, mask, invert, \
+       snd_soc_get_gain_aic3x, snd_soc_put_gain_aic3x, gain_stage_tlv)
+
+#define        SOC_SINGLE_EXT_VOL(xname, reg, shift, mask, invert) \
+       SOC_SINGLE_EXT(xname, reg, shift, mask, invert, \
+               snd_soc_get_volsw_uncached, snd_soc_put_volsw)
+
+/*
+ * The headset detect flag, the button press detect flag and the headset
+ * type flag are stored in read only registers, but we could not declare
+ * these regs as volatile because other bits are RW, so we use unchached
+ * get hanler for these regs.
+ */
+static int snd_soc_get_volsw_uncached(struct snd_kcontrol *kcontrol,
+                                     struct snd_ctl_elem_value *ucontrol)
+{
+       int ret;
+       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+       if (aic3x->power)
+               regcache_cache_bypass(aic3x->regmap, true);
+       ret = snd_soc_get_volsw(kcontrol, ucontrol);
+       if (aic3x->power)
+               regcache_cache_bypass(aic3x->regmap, false);
+       return ret;
+}
+
+/*
+ * All input lines have additional volume gain controls. Value 0x0 is 0dB gain
+ * and value 0x8 is -12 dB gain. It's a little bit tricky because value 0xF
+ * means mute. values 0x9-0xE are reserved. If switch is muted we should store
+ * value in cache and should not set up register.
+ */
+static int snd_soc_put_gain_aic3x(struct snd_kcontrol *kcontrol,
+                                 struct snd_ctl_elem_value *ucontrol)
+{
+       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+       struct soc_mixer_control *mc =
+               (struct soc_mixer_control *)kcontrol->private_value;
+       unsigned int reg;
+       unsigned int shift = mc->shift;
+       int max = mc->max;
+       unsigned int mask = (1<<fls(max))-1;
+       unsigned int invert = mc->invert;
+
+       u8 regdata, newval, regval;
+       u8 loop = 0;
+
+       /* We need to cache value. Then we need to test each value on
+        * mute in hw register. If not muted, we should set up new value */
+       reg = mc->reg;
+       newval = (ucontrol->value.integer.value[0] & mask);
+       do {
+               if (invert)
+                       newval = (8 - newval) & mask;
+               /* read, test and update if first reg if needs */
+               regdata = snd_soc_read(codec, reg);
+               regval = (regdata >> shift) & mask;
+
+               if (reg >= MIC3LR_2_LADC_CTRL && reg <= LINE1L_2_RADC_CTRL) {
+                       aic3x->cached_gain[reg-MIC3LR_2_LADC_CTRL]
+                               &= ~(mask<<shift);
+                       aic3x->cached_gain[reg-MIC3LR_2_LADC_CTRL]
+                               |= (newval<<shift);
+               }
+
+               if (regval != 0xf && regval != newval)
+                       snd_soc_update_bits(codec, reg, mask<<shift,
+                                           newval<<shift);
+
+               if (snd_soc_volsw_is_stereo(mc)) {
+                       /* first time loop will be switched to true and
+                       * second time loop will be switched to false, so
+                       *  we could finish loop */
+                       loop = !loop;
+                       if (loop) { /* reinit vars for second loop */
+                               reg = mc->rreg;
+                               newval = (ucontrol->value.integer.value[1]
+                                        & mask);
+                               continue;
+                       }
+               }
+
+       } while (loop);
+       return 0;
+}
+
+/*
+ * All input lines have additional volume gain controls. Value 0x0 is 0dB gain
+ * and value 0x8 is -12 dB gain. It's a little bit tricky because value 0xF
+ * means mute. Values 0x9-0xE are reserved. If switch is muted we should read
+ * value from cache but not from hw register.
+ */
+static int snd_soc_get_gain_aic3x(struct snd_kcontrol *kcontrol,
+                                 struct snd_ctl_elem_value *ucontrol)
+{
+       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+       struct soc_mixer_control *mc =
+               (struct soc_mixer_control *)kcontrol->private_value;
+       unsigned int reg;
+       unsigned int shift = mc->shift;
+       int max = mc->max;
+       unsigned int mask = (1<<fls(max))-1;
+       unsigned int invert = mc->invert;
+
+       u8 regdata, regval;
+       u8 loop = 0;
+
+       reg = mc->reg;
+
+       do {
+               regdata = snd_soc_read(codec, reg);
+               regval = (regdata >> shift) & mask;
+
+               /* check if register is muted then return cached value */
+               if (regval == 0xf) {
+                       if (reg >= MIC3LR_2_LADC_CTRL &&
+                           reg <= LINE1L_2_RADC_CTRL)
+                               regval = (aic3x->cached_gain[reg-
+                                       MIC3LR_2_LADC_CTRL]>>shift) & mask;
+               }
+               if (invert)
+                       regval = (8 - regval) & mask;
+
+               ucontrol->value.integer.value[loop] = regval;
+
+               if (snd_soc_volsw_is_stereo(mc)) {
+                       /* first time loop will be switched to 1 and second time
+                       * loop will be switched to 0, so we could finish loop */
+                       loop = loop ? 0 : 1;
+                       if (loop) { /* reinit vars for second loop */
+                               reg = mc->rreg;
+                               continue;
+                       }
+               }
+
+       } while (loop);
+       return 0;
+}

  /*
- * All input lines are connected when !0xf and disconnected with 0xf bit field,
- * so we have to use specific dapm_put call for input mixer
+ * All input lines are connected when gain is not equal to 0xf and disconnected
+ * in other cases. We have to use the specific dapm_put call for input mixer.
+ * In case of unmute we should set up register's value by cached value.
   */
  static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
                                         struct snd_ctl_elem_value *ucontrol)
  {
         struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
+       struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+
         struct soc_mixer_control *mc =
                 (struct soc_mixer_control *)kcontrol->private_value;
         unsigned int reg = mc->reg;
@@ -151,7 +304,7 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol 
*kcontrol,
         int max = mc->max;
         unsigned int mask = (1 << fls(max)) - 1;
         unsigned int invert = mc->invert;
-       unsigned short val;
+       unsigned int val;
         struct snd_soc_dapm_update update;
         int connect, change;

@@ -166,6 +319,12 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol 
*kcontrol,
         if (invert)
                 val = mask - val;

+       if (!val) {
+               if (reg >= MIC3LR_2_LADC_CTRL && reg <= LINE1L_2_RADC_CTRL)
+                       val = (aic3x->cached_gain[reg
+                               -MIC3LR_2_LADC_CTRL]>>shift) & mask;
+       }
+
         mask <<= shift;
         val <<= shift;

@@ -184,6 +343,32 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol 
*kcontrol,
  }

  /*
+ * Based on standart handler snd_soc_dapm_get_volsw, but changing mask to 0xF
+ */
+static int snd_soc_dapm_get_volsw_aic3x(struct snd_kcontrol *kcontrol,
+                                       struct snd_ctl_elem_value *ucontrol)
+{
+       struct soc_mixer_control *mc =
+               (struct soc_mixer_control *)kcontrol->private_value;
+       int max = mc->max;
+       int ret;
+
+       /* the register contains 4 bits, so we would change max temporally
+       * to read register by original handler, then return max back */
+       mc->max = 15;
+       ret = snd_soc_dapm_get_volsw(kcontrol, ucontrol);
+       mc->max = max;
+
+       /* all gain values (except mute value) after invertion is not equl to 0,
+       * so we need to set 1(on) for all values except 0.
+       * 0 means mute, so we do not need to change it. */
+       if (ucontrol->value.integer.value[0] != 0)
+               ucontrol->value.integer.value[0] = 1;
+
+       return ret;
+}
+
+/*
   * mic bias power on/off share the same register bits with
   * output voltage of mic bias. when power on mic bias, we
   * need reclaim it to voltage value.
@@ -270,6 +455,16 @@ static const struct soc_enum aic3x_agc_decay_enum[] = {
         SOC_ENUM_SINGLE(RAGC_CTRL_A, 0, 4, aic3x_agc_decay),
  };

+static const char * const aic3x_headset_debounce[] = {
+       "16ms", "32ms", "64ms", "128ms", "256ms", "512ms" };
+static const struct soc_enum aic3x_headset_debounce_enum =
+SOC_ENUM_SINGLE(AIC3X_HEADSET_DETECT_CTRL_A, 2, 6, aic3x_headset_debounce);
+
+static const char * const aic3x_button_debounce[] = {
+       "0ms", "8ms", "16ms", "32ms" };
+static const struct soc_enum aic3x_button_debounce_enum =
+SOC_ENUM_SINGLE(AIC3X_HEADSET_DETECT_CTRL_A, 0, 4, aic3x_button_debounce);
+
  /*
   * DAC digital volumes. From -63.5 to 0 dB in 0.5 dB steps
   */
@@ -287,6 +482,9 @@ static DECLARE_TLV_DB_SCALE(adc_tlv, 0, 50, 0);
   */
  static DECLARE_TLV_DB_SCALE(output_stage_tlv, -5900, 50, 1);

+static DECLARE_TLV_DB_SCALE(gain_stage_tlv, -1200, 150, 0);
+
+
  static const struct snd_kcontrol_new aic3x_snd_controls[] = {
         /* Output */
         SOC_DOUBLE_R_TLV("PCM Playback Volume",
@@ -399,6 +597,36 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
         SOC_DOUBLE_R("PGA Capture Switch", LADC_VOL, RADC_VOL, 7, 0x01, 1),

         SOC_ENUM("ADC HPF Cut-off", aic3x_enum[ADC_HPF_ENUM]),
+       /* Additional controls */
+       SOC_DOUBLE_R_AIC3X_TLV("Mic3L Volume",
+                              MIC3LR_2_LADC_CTRL, MIC3LR_2_RADC_CTRL, 4, 8, 1),
+       SOC_DOUBLE_R_AIC3X_TLV("Mic3R Volume",
+                              MIC3LR_2_LADC_CTRL, MIC3LR_2_RADC_CTRL, 0, 8, 1),
+       SOC_DOUBLE_R_AIC3X_TLV("Line1L Volume",
+                              LINE1L_2_LADC_CTRL, LINE1L_2_RADC_CTRL, 3, 8, 1),
+       SOC_DOUBLE_R_AIC3X_TLV("Line1R Volume",
+                              LINE1R_2_LADC_CTRL, LINE1R_2_RADC_CTRL, 3, 8, 1),
+       SOC_SINGLE_AIC3X_TLV("Line2L Volume",
+                            LINE2L_2_LADC_CTRL, 3, 8, 1),
+       SOC_SINGLE_AIC3X_TLV("Line2R Volume",
+                            LINE2R_2_RADC_CTRL, 3, 8, 1),
+       SOC_ENUM("Headset Jack Debounce", aic3x_headset_debounce_enum),
+       SOC_ENUM("Button Press Debounce", aic3x_button_debounce_enum),
+       SOC_SINGLE("Headset Detect Enable",
+                  AIC3X_HEADSET_DETECT_CTRL_A, 7, 1, 0),
+       SOC_SINGLE_EXT_VOL("Headset Detect Type", AIC3X_HEADSET_DETECT_CTRL_A,
+                          AIC3X_HEADSET_DETECT_A_SHIFT,
+                          AIC3X_HEADSET_DETECT_A_MASK, 0),
+       SOC_SINGLE_EXT_VOL("Button Detect Flag", AIC3X_HEADSET_DETECT_CTRL_B,
+                          AIC3X_BUTTON_DETECT_SHIFT,
+                          AIC3X_BUTTON_DETECT_MASK, 0),
+       SOC_SINGLE_EXT_VOL("Headset Detect Flag", AIC3X_HEADSET_DETECT_CTRL_B,
+                          AIC3X_HEADSET_DETECT_B_SHIFT,
+                          AIC3X_HEADSET_DETECT_B_MASK, 0),
+       SOC_SINGLE("High power output Ac-coupled",
+                  AIC3X_HEADSET_DETECT_CTRL_B, 7, 1, 0),
+       SOC_SINGLE("Stereo pseudodifferential output",
+                  AIC3X_HEADSET_DETECT_CTRL_B, 3, 1, 0),
  };

  static const struct snd_kcontrol_new aic3x_mono_controls[] = {
----------------------------------------------------------------------------
P.S. I didn't remove loops because functions will be to big to fit in one screen, 
actually I don't like it.

Cheers,
Tim Karaldin
