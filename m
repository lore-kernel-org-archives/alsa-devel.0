From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/7] ASoC: Move standard kcontrol helpers to
	the component level
Date: Sat, 19 Apr 2014 10:43:59 +0200
Message-ID: <1397897042-20092-5-git-send-email-lars@metafoo.de>
References: <1397897042-20092-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-073.synserver.de (smtp-out-120.synserver.de
 [212.40.185.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 49883261A89
 for <alsa-devel@alsa-project.org>; Sat, 19 Apr 2014 10:44:13 +0200 (CEST)
In-Reply-To: <1397897042-20092-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Sven Brandau <brandau@gmx.de>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

After moving the IO layer inside ASoC to the component level we can now easily
move the standard control helpers to the component level as well. This allows to
reuse the same standard helper control implementations for other components.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  20 ++++-
 sound/soc/soc-core.c | 221 ++++++++++++++++++++++++++++++++-------------------
 2 files changed, 156 insertions(+), 85 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4d12797..7138774 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1250,6 +1250,22 @@ static inline bool snd_soc_codec_is_active(struct snd_soc_codec *codec)
 }
 
 /**
+ * snd_soc_kcontrol_component() - Returns the component that registered the
+ *  control
+ * @kcontrol: The control for which to get the component
+ *
+ * Note: This function will work correctly if the control has been registered
+ * for a component. Either with snd_soc_add_codec_controls() or
+ * snd_soc_add_platform_controls() or via  table based setup for either a
+ * CODEC, a platform or component driver. Otherwise the behavior is undefined.
+ */
+static inline struct snd_soc_component *snd_soc_kcontrol_component(
+	struct snd_kcontrol *kcontrol)
+{
+	return snd_kcontrol_chip(kcontrol);
+}
+
+/**
  * snd_soc_kcontrol_codec() - Returns the CODEC that registered the control
  * @kcontrol: The control for which to get the CODEC
  *
@@ -1260,7 +1276,7 @@ static inline bool snd_soc_codec_is_active(struct snd_soc_codec *codec)
 static inline struct snd_soc_codec *snd_soc_kcontrol_codec(
 	struct snd_kcontrol *kcontrol)
 {
-	return snd_kcontrol_chip(kcontrol);
+	return snd_soc_component_to_codec(snd_soc_kcontrol_component(kcontrol));
 }
 
 /**
@@ -1274,7 +1290,7 @@ static inline struct snd_soc_codec *snd_soc_kcontrol_codec(
 static inline struct snd_soc_platform *snd_soc_kcontrol_platform(
 	struct snd_kcontrol *kcontrol)
 {
-	return snd_kcontrol_chip(kcontrol);
+	return snd_soc_component_to_platform(snd_soc_kcontrol_component(kcontrol));
 }
 
 int snd_soc_util_init(void);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fd3c324..de2d293 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2353,7 +2353,7 @@ int snd_soc_add_codec_controls(struct snd_soc_codec *codec,
 	struct snd_card *card = codec->card->snd_card;
 
 	return snd_soc_add_controls(card, codec->dev, controls, num_controls,
-			codec->name_prefix, codec);
+			codec->name_prefix, &codec->component);
 }
 EXPORT_SYMBOL_GPL(snd_soc_add_codec_controls);
 
@@ -2373,7 +2373,7 @@ int snd_soc_add_platform_controls(struct snd_soc_platform *platform,
 	struct snd_card *card = platform->card->snd_card;
 
 	return snd_soc_add_controls(card, platform->dev, controls, num_controls,
-			NULL, platform);
+			NULL, &platform->component);
 }
 EXPORT_SYMBOL_GPL(snd_soc_add_platform_controls);
 
@@ -2457,12 +2457,15 @@ EXPORT_SYMBOL_GPL(snd_soc_info_enum_double);
 int snd_soc_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val, item;
 	unsigned int reg_val;
+	int ret;
 
-	reg_val = snd_soc_read(codec, e->reg);
+	ret = snd_soc_component_read(component, e->reg, &reg_val);
+	if (ret)
+		return ret;
 	val = (reg_val >> e->shift_l) & e->mask;
 	item = snd_soc_enum_val_to_item(e, val);
 	ucontrol->value.enumerated.item[0] = item;
@@ -2488,7 +2491,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_enum_double);
 int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int *item = ucontrol->value.enumerated.item;
 	unsigned int val;
@@ -2505,38 +2508,48 @@ int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 		mask |= e->mask << e->shift_r;
 	}
 
-	return snd_soc_update_bits_locked(codec, e->reg, mask, val);
+	return snd_soc_component_update_bits(component, e->reg, mask, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_enum_double);
 
 /**
  * snd_soc_read_signed - Read a codec register and interprete as signed value
- * @codec: codec
+ * @component: component
  * @reg: Register to read
  * @mask: Mask to use after shifting the register value
  * @shift: Right shift of register value
  * @sign_bit: Bit that describes if a number is negative or not.
+ * @signed_val: Pointer to where the read value should be stored
  *
  * This functions reads a codec register. The register value is shifted right
  * by 'shift' bits and masked with the given 'mask'. Afterwards it translates
  * the given registervalue into a signed integer if sign_bit is non-zero.
  *
- * Returns the register value as signed int.
+ * Returns 0 on sucess, otherwise an error value
  */
-static int snd_soc_read_signed(struct snd_soc_codec *codec, unsigned int reg,
-		unsigned int mask, unsigned int shift, unsigned int sign_bit)
+static int snd_soc_read_signed(struct snd_soc_component *component,
+	unsigned int reg, unsigned int mask, unsigned int shift,
+	unsigned int sign_bit, int *signed_val)
 {
 	int ret;
 	unsigned int val;
 
-	val = (snd_soc_read(codec, reg) >> shift) & mask;
+	ret = snd_soc_component_read(component, reg, &val);
+	if (ret < 0)
+		return ret;
+
+	val = (val >> shift) & mask;
 
-	if (!sign_bit)
-		return val;
+	if (!sign_bit) {
+		*signed_val = val;
+		return 0;
+	}
 
 	/* non-negative number */
-	if (!(val & BIT(sign_bit)))
-		return val;
+	if (!(val & BIT(sign_bit))) {
+		*signed_val = val;
+		return 0;
+	}
 
 	ret = val;
 
@@ -2548,7 +2561,9 @@ static int snd_soc_read_signed(struct snd_soc_codec *codec, unsigned int reg,
 	 */
 	ret |= ~((int)(BIT(sign_bit) - 1));
 
-	return ret;
+	*signed_val = ret;
+
+	return 0;
 }
 
 /**
@@ -2597,9 +2612,9 @@ EXPORT_SYMBOL_GPL(snd_soc_info_volsw);
 int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
 	unsigned int shift = mc->shift;
@@ -2609,25 +2624,32 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	int sign_bit = mc->sign_bit;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
+	int val;
+	int ret;
 
 	if (sign_bit)
 		mask = BIT(sign_bit + 1) - 1;
 
-	ucontrol->value.integer.value[0] = snd_soc_read_signed(codec, reg, mask,
-			shift, sign_bit) - min;
+	ret = snd_soc_read_signed(component, reg, mask, shift, sign_bit, &val);
+	if (ret)
+		return ret;
+
+	ucontrol->value.integer.value[0] = val - min;
 	if (invert)
 		ucontrol->value.integer.value[0] =
 			max - ucontrol->value.integer.value[0];
 
 	if (snd_soc_volsw_is_stereo(mc)) {
 		if (reg == reg2)
-			ucontrol->value.integer.value[1] =
-				snd_soc_read_signed(codec, reg, mask, rshift,
-						sign_bit) - min;
+			ret = snd_soc_read_signed(component, reg, mask, rshift,
+				sign_bit, &val);
 		else
-			ucontrol->value.integer.value[1] =
-				snd_soc_read_signed(codec, reg2, mask, shift,
-						sign_bit) - min;
+			ret = snd_soc_read_signed(component, reg2, mask, shift,
+				sign_bit, &val);
+		if (ret)
+			return ret;
+
+		ucontrol->value.integer.value[1] = val - min;
 		if (invert)
 			ucontrol->value.integer.value[1] =
 				max - ucontrol->value.integer.value[1];
@@ -2650,9 +2672,9 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw);
 int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
 	unsigned int shift = mc->shift;
@@ -2687,12 +2709,13 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 			type_2r = true;
 		}
 	}
-	err = snd_soc_update_bits_locked(codec, reg, val_mask, val);
+	err = snd_soc_component_update_bits(component, reg, val_mask, val);
 	if (err < 0)
 		return err;
 
 	if (type_2r)
-		err = snd_soc_update_bits_locked(codec, reg2, val_mask, val2);
+		err = snd_soc_component_update_bits(component, reg2, val_mask,
+			val2);
 
 	return err;
 }
@@ -2711,10 +2734,9 @@ EXPORT_SYMBOL_GPL(snd_soc_put_volsw);
 int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 	    (struct soc_mixer_control *)kcontrol->private_value;
-
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
 	unsigned int shift = mc->shift;
@@ -2722,13 +2744,23 @@ int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
 	int max = mc->max;
 	int min = mc->min;
 	int mask = (1 << (fls(min + max) - 1)) - 1;
+	unsigned int val;
+	int ret;
 
-	ucontrol->value.integer.value[0] =
-	    ((snd_soc_read(codec, reg) >> shift) - min) & mask;
+	ret = snd_soc_component_read(component, reg, &val);
+	if (ret < 0)
+		return ret;
 
-	if (snd_soc_volsw_is_stereo(mc))
-		ucontrol->value.integer.value[1] =
-			((snd_soc_read(codec, reg2) >> rshift) - min) & mask;
+	ucontrol->value.integer.value[0] = ((val >> shift) - min) & mask;
+
+	if (snd_soc_volsw_is_stereo(mc)) {
+		ret = snd_soc_component_read(component, reg2, &val);
+		if (ret < 0)
+			return ret;
+
+		val = ((val >> rshift) - min) & mask;
+		ucontrol->value.integer.value[1] = val;
+	}
 
 	return 0;
 }
@@ -2746,7 +2778,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw_sx);
 int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 	    (struct soc_mixer_control *)kcontrol->private_value;
 
@@ -2764,7 +2796,7 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	val = (ucontrol->value.integer.value[0] + min) & mask;
 	val = val << shift;
 
-	err = snd_soc_update_bits_locked(codec, reg, val_mask, val);
+	err = snd_soc_component_update_bits(component, reg, val_mask, val);
 	if (err < 0)
 		return err;
 
@@ -2773,10 +2805,10 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 		val2 = (ucontrol->value.integer.value[1] + min) & mask;
 		val2 = val2 << rshift;
 
-		if (snd_soc_update_bits_locked(codec, reg2, val_mask, val2))
-			return err;
+		err = snd_soc_component_update_bits(component, reg2, val_mask,
+			val2);
 	}
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_sx);
 
@@ -2823,10 +2855,15 @@ int snd_soc_get_volsw_s8(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = mc->reg;
+	unsigned int val;
 	int min = mc->min;
-	int val = snd_soc_read(codec, reg);
+	int ret;
+
+	ret = snd_soc_component_read(component, reg, &val);
+	if (ret)
+		return ret;
 
 	ucontrol->value.integer.value[0] =
 		((signed char)(val & 0xff))-min;
@@ -2850,7 +2887,7 @@ int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = mc->reg;
 	int min = mc->min;
 	unsigned int val;
@@ -2858,7 +2895,7 @@ int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
 	val = (ucontrol->value.integer.value[0]+min) & 0xff;
 	val |= ((ucontrol->value.integer.value[1]+min) & 0xff) << 8;
 
-	return snd_soc_update_bits_locked(codec, reg, 0xffff, val);
+	return snd_soc_component_update_bits(component, reg, 0xffff, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_s8);
 
@@ -2907,7 +2944,7 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = mc->reg;
 	unsigned int rreg = mc->rreg;
 	unsigned int shift = mc->shift;
@@ -2924,7 +2961,7 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 	val_mask = mask << shift;
 	val = val << shift;
 
-	ret = snd_soc_update_bits_locked(codec, reg, val_mask, val);
+	ret = snd_soc_component_update_bits(component, reg, val_mask, val);
 	if (ret < 0)
 		return ret;
 
@@ -2935,7 +2972,8 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 		val_mask = mask << shift;
 		val = val << shift;
 
-		ret = snd_soc_update_bits_locked(codec, rreg, val_mask, val);
+		ret = snd_soc_component_update_bits(component, rreg, val_mask,
+			val);
 	}
 
 	return ret;
@@ -2954,9 +2992,9 @@ EXPORT_SYMBOL_GPL(snd_soc_put_volsw_range);
 int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = mc->reg;
 	unsigned int rreg = mc->rreg;
 	unsigned int shift = mc->shift;
@@ -2964,9 +3002,14 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
 	int max = mc->max;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
+	unsigned int val;
+	int ret;
 
-	ucontrol->value.integer.value[0] =
-		(snd_soc_read(codec, reg) >> shift) & mask;
+	ret = snd_soc_component_read(component, reg, &val);
+	if (ret)
+		return ret;
+
+	ucontrol->value.integer.value[0] = (val >> shift) & mask;
 	if (invert)
 		ucontrol->value.integer.value[0] =
 			max - ucontrol->value.integer.value[0];
@@ -2974,8 +3017,11 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
 		ucontrol->value.integer.value[0] - min;
 
 	if (snd_soc_volsw_is_stereo(mc)) {
-		ucontrol->value.integer.value[1] =
-			(snd_soc_read(codec, rreg) >> shift) & mask;
+		ret = snd_soc_component_read(component, rreg, &val);
+		if (ret)
+			return ret;
+
+		ucontrol->value.integer.value[1] = (val >> shift) & mask;
 		if (invert)
 			ucontrol->value.integer.value[1] =
 				max - ucontrol->value.integer.value[1];
@@ -3029,11 +3075,11 @@ EXPORT_SYMBOL_GPL(snd_soc_limit_volume);
 int snd_soc_bytes_info(struct snd_kcontrol *kcontrol,
 		       struct snd_ctl_elem_info *uinfo)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_bytes *params = (void *)kcontrol->private_value;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
-	uinfo->count = params->num_regs * codec->component.val_bytes;
+	uinfo->count = params->num_regs * component->val_bytes;
 
 	return 0;
 }
@@ -3042,20 +3088,20 @@ EXPORT_SYMBOL_GPL(snd_soc_bytes_info);
 int snd_soc_bytes_get(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol)
 {
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_bytes *params = (void *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	int ret;
 
-	if (codec->component.regmap)
-		ret = regmap_raw_read(codec->component.regmap, params->base,
+	if (component->regmap)
+		ret = regmap_raw_read(component->regmap, params->base,
 				      ucontrol->value.bytes.data,
-				      params->num_regs * codec->component.val_bytes);
+				      params->num_regs * component->val_bytes);
 	else
 		ret = -EINVAL;
 
 	/* Hide any masked bytes to ensure consistent data reporting */
 	if (ret == 0 && params->mask) {
-		switch (codec->component.val_bytes) {
+		switch (component->val_bytes) {
 		case 1:
 			ucontrol->value.bytes.data[0] &= ~params->mask;
 			break;
@@ -3079,16 +3125,16 @@ EXPORT_SYMBOL_GPL(snd_soc_bytes_get);
 int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol)
 {
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_bytes *params = (void *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	int ret, len;
 	unsigned int val, mask;
 	void *data;
 
-	if (!codec->component.regmap)
+	if (!component->regmap)
 		return -EINVAL;
 
-	len = params->num_regs * codec->component.val_bytes;
+	len = params->num_regs * component->val_bytes;
 
 	data = kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL | GFP_DMA);
 	if (!data)
@@ -3100,27 +3146,27 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 	 * copy.
 	 */
 	if (params->mask) {
-		ret = regmap_read(codec->component.regmap, params->base, &val);
+		ret = regmap_read(component->regmap, params->base, &val);
 		if (ret != 0)
 			goto out;
 
 		val &= params->mask;
 
-		switch (codec->component.val_bytes) {
+		switch (component->val_bytes) {
 		case 1:
 			((u8 *)data)[0] &= ~params->mask;
 			((u8 *)data)[0] |= val;
 			break;
 		case 2:
 			mask = ~params->mask;
-			ret = regmap_parse_val(codec->component.regmap,
+			ret = regmap_parse_val(component->regmap,
 							&mask, &mask);
 			if (ret != 0)
 				goto out;
 
 			((u16 *)data)[0] &= mask;
 
-			ret = regmap_parse_val(codec->component.regmap,
+			ret = regmap_parse_val(component->regmap,
 							&val, &val);
 			if (ret != 0)
 				goto out;
@@ -3129,14 +3175,14 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 			break;
 		case 4:
 			mask = ~params->mask;
-			ret = regmap_parse_val(codec->component.regmap,
+			ret = regmap_parse_val(component->regmap,
 							&mask, &mask);
 			if (ret != 0)
 				goto out;
 
 			((u32 *)data)[0] &= mask;
 
-			ret = regmap_parse_val(codec->component.regmap,
+			ret = regmap_parse_val(component->regmap,
 							&val, &val);
 			if (ret != 0)
 				goto out;
@@ -3149,7 +3195,7 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 		}
 	}
 
-	ret = regmap_raw_write(codec->component.regmap, params->base,
+	ret = regmap_raw_write(component->regmap, params->base,
 			       data, len);
 
 out:
@@ -3200,24 +3246,27 @@ EXPORT_SYMBOL_GPL(snd_soc_info_xr_sx);
 int snd_soc_get_xr_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mreg_control *mc =
 		(struct soc_mreg_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int regbase = mc->regbase;
 	unsigned int regcount = mc->regcount;
-	unsigned int regwshift = codec->component.val_bytes * BITS_PER_BYTE;
+	unsigned int regwshift = component->val_bytes * BITS_PER_BYTE;
 	unsigned int regwmask = (1<<regwshift)-1;
 	unsigned int invert = mc->invert;
 	unsigned long mask = (1UL<<mc->nbits)-1;
 	long min = mc->min;
 	long max = mc->max;
 	long val = 0;
-	unsigned long regval;
+	unsigned int regval;
 	unsigned int i;
+	int ret;
 
 	for (i = 0; i < regcount; i++) {
-		regval = snd_soc_read(codec, regbase+i) & regwmask;
-		val |= regval << (regwshift*(regcount-i-1));
+		ret = snd_soc_component_read(component, regbase+i, &regval);
+		if (ret)
+			return ret;
+		val |= (regval & regwmask) << (regwshift*(regcount-i-1));
 	}
 	val &= mask;
 	if (min < 0 && val > max)
@@ -3246,12 +3295,12 @@ EXPORT_SYMBOL_GPL(snd_soc_get_xr_sx);
 int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mreg_control *mc =
 		(struct soc_mreg_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int regbase = mc->regbase;
 	unsigned int regcount = mc->regcount;
-	unsigned int regwshift = codec->component.val_bytes * BITS_PER_BYTE;
+	unsigned int regwshift = component->val_bytes * BITS_PER_BYTE;
 	unsigned int regwmask = (1<<regwshift)-1;
 	unsigned int invert = mc->invert;
 	unsigned long mask = (1UL<<mc->nbits)-1;
@@ -3266,7 +3315,7 @@ int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
 	for (i = 0; i < regcount; i++) {
 		regval = (val >> (regwshift*(regcount-i-1))) & regwmask;
 		regmask = (mask >> (regwshift*(regcount-i-1))) & regwmask;
-		err = snd_soc_update_bits_locked(codec, regbase+i,
+		err = snd_soc_component_update_bits(component, regbase+i,
 				regmask, regval);
 		if (err < 0)
 			return err;
@@ -3288,14 +3337,21 @@ EXPORT_SYMBOL_GPL(snd_soc_put_xr_sx);
 int snd_soc_get_strobe(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = mc->reg;
 	unsigned int shift = mc->shift;
 	unsigned int mask = 1 << shift;
 	unsigned int invert = mc->invert != 0;
-	unsigned int val = snd_soc_read(codec, reg) & mask;
+	unsigned int val;
+	int ret;
+
+	ret = snd_soc_component_read(component, reg, &val);
+	if (ret)
+		return ret;
+
+	val &= mask;
 
 	if (shift != 0 && val != 0)
 		val = val >> shift;
@@ -3318,9 +3374,9 @@ EXPORT_SYMBOL_GPL(snd_soc_get_strobe);
 int snd_soc_put_strobe(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = mc->reg;
 	unsigned int shift = mc->shift;
 	unsigned int mask = 1 << shift;
@@ -3330,12 +3386,11 @@ int snd_soc_put_strobe(struct snd_kcontrol *kcontrol,
 	unsigned int val2 = (strobe ^ invert) ? 0 : mask;
 	int err;
 
-	err = snd_soc_update_bits_locked(codec, reg, mask, val1);
+	err = snd_soc_component_update_bits(component, reg, mask, val1);
 	if (err < 0)
 		return err;
 
-	err = snd_soc_update_bits_locked(codec, reg, mask, val2);
-	return err;
+	return snd_soc_component_update_bits(component, reg, mask, val2);
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_strobe);
 
-- 
1.8.0
