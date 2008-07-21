From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: RFC: reworking ASOC for large registers
Date: Mon, 21 Jul 2008 19:25:21 -0400
Message-ID: <9e4733910807211625l3268a1a9m59d6914fb55593c6@mail.gmail.com>
References: <9e4733910807201847q6d914e58l567a96904679ada8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E3D5244D6
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 01:25:22 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so666292ywk.2
	for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2008 16:25:21 -0700 (PDT)
In-Reply-To: <9e4733910807201847q6d914e58l567a96904679ada8@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Here's what I've done so far, just to give you idea of what is needed.
I'm only half way through the soc core. I'm not able to run my driver
yet to test anything.

-- 
Jon Smirl
jonsmirl@gmail.com


Modufy ASOC to support codecs with large registers,

From: Jon Smirl <jonsmirl@gmail.com>

256 bits or wider, and 64 bit values
---

 include/sound/soc.h  |   71 ++++++++++-------
 sound/soc/soc-core.c |  203 +++++++++++++++++++++++++++-----------------------
 2 files changed, 153 insertions(+), 121 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d3c8c03..fb3f6ef 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -26,53 +26,56 @@
 /*
  * Convenience kcontrol builders
  */
-#define SOC_SINGLE_VALUE(reg, shift, max, invert) ((reg) | ((shift) << 8) |\
-	((shift) << 12) | ((max) << 16) | ((invert) << 24))
-#define SOC_SINGLE_VALUE_EXT(reg, max, invert) ((reg) | ((max) << 16) |\
-	((invert) << 31))
-#define SOC_SINGLE(xname, reg, shift, max, invert) \
+
+ struct mixer_control {
+ 	unsigned int reg, rreg, shift, rshift, max, invert;
+ };
+
+#define SOC_SINGLE(xname, xreg, xshift, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
 	.put = snd_soc_put_volsw, \
-	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
-#define SOC_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
+	.private_value =  (unsigned long)&(struct mixer_control){ \
+		.reg = xreg, .shift = xshift, .max = xmax, .invert = xinvert}}
+#define SOC_SINGLE_TLV(xname, xreg, xshift, xmax, xinvert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
 	.put = snd_soc_put_volsw, \
-	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
-#define SOC_DOUBLE(xname, reg, shift_left, shift_right, max, invert) \
+	.private_value =  (unsigned long)&(struct mixer_control){ \
+		.reg = xreg, .shift = xshift, .max = xmax, .invert = xinvert}}
+#define SOC_DOUBLE(xname, xreg, shift_left, shift_right, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
 	.put = snd_soc_put_volsw, \
-	.private_value = (reg) | ((shift_left) << 8) | \
-		((shift_right) << 12) | ((max) << 16) | ((invert) << 24) }
-#define SOC_DOUBLE_R(xname, reg_left, reg_right, shift, max, invert) \
+	.private_value =  (unsigned long)&(struct mixer_control){ \
+		.reg = xreg, .shift = shift_keft, .rshift = shift_right, .max =
xmax, .invert = xinvert}}
+#define SOC_DOUBLE_R(xname, reg_left, reg_right, xshift, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.info = snd_soc_info_volsw_2r, \
 	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
-	.private_value = (reg_left) | ((shift) << 8)  | \
-		((max) << 12) | ((invert) << 20) | ((reg_right) << 24) }
-#define SOC_DOUBLE_TLV(xname, reg, shift_left, shift_right, max,
invert, tlv_array) \
+	.private_value =  (unsigned long)&(struct mixer_control){ \
+		.reg = reg_left, .rreg = reg_right, .shift = xshift, .max = xmax,
.invert = xinvert}}
+#define SOC_DOUBLE_TLV(xname, xreg, shift_left, shift_right, xmax,
xinvert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
 	.put = snd_soc_put_volsw, \
-	.private_value = (reg) | ((shift_left) << 8) | \
-		((shift_right) << 12) | ((max) << 16) | ((invert) << 24) }
-#define SOC_DOUBLE_R_TLV(xname, reg_left, reg_right, shift, max,
invert, tlv_array) \
+	.private_value =  (unsigned long)&(struct mixer_control){ \
+		.reg = xreg, .shift = shift_left, .rshift = shift_right, .xmax =
max, .invert = xinvert}}
+#define SOC_DOUBLE_R_TLV(xname, reg_left, reg_right, xshift, xmax,
xinvert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw_2r, \
 	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
-	.private_value = (reg_left) | ((shift) << 8)  | \
-		((max) << 12) | ((invert) << 20) | ((reg_right) << 24) }
+	.private_value =  (unsigned long)&(struct mixer_control){ \
+		.reg = reg_left, .rreg = reg_right, .shift = xshift, .max = xmax,
.invert = xinvert}}
 #define SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, xtexts) \
 {	.reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
 	.mask = xmask, .texts = xtexts }
@@ -90,7 +93,8 @@
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
-	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmask, xinvert) }
+	.private_value =  (unsigned long)&(struct mixer_control){ \
+		.reg = xreg, .shift = xshift, .max = xmax, .invert = xinvert}
 #define SOC_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_bool_ext, \
@@ -193,6 +197,14 @@ struct soc_enum;
 struct snd_soc_ac97_ops;
 struct snd_soc_clock_info;

+typedef union {
+	u8 u8;
+	u16 u16;
+	u32 u32;
+	u64 u64;
+} soc_register_t;
+#define SOC_MAX_REG_SIZE 4
+
 typedef int (*hw_write_t)(void *,const char* ,int);
 typedef int (*hw_read_t)(void *,char* ,int);

@@ -208,14 +220,14 @@ int snd_soc_set_runtime_hwparams(struct
snd_pcm_substream *substream,
 	const struct snd_pcm_hardware *hw);

 /* codec IO */
-#define snd_soc_read(codec, reg) codec->read(codec, reg)
-#define snd_soc_write(codec, reg, value) codec->write(codec, reg, value)
+#define snd_soc_read(codec, reg, value, size) codec->read(codec, reg,
value, size)
+#define snd_soc_write(codec, reg, value, size) codec->write(codec,
reg, value, size)

 /* codec register bit access */
-int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
-				unsigned short mask, unsigned short value);
-int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned short reg,
-				unsigned short mask, unsigned short value);
+int snd_soc_update_bits(struct snd_soc_codec *codec, u32 reg,
+				u64 mask, u32 shift, u64 value);
+int snd_soc_test_bits(struct snd_soc_codec *codec, u32 reg,
+				u64 mask, u32 shift, u64 value);

 int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 	struct snd_ac97_bus_ops *ops, int num);
@@ -385,8 +397,9 @@ struct snd_soc_codec {

 	/* codec IO */
 	void *control_data; /* codec control (i2c/3wire) data */
-	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
-	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
+	unsigned int (*read)(struct snd_soc_codec *, u32 reg, u8 *value, u32 size);
+	int (*write)(struct snd_soc_codec *, u32 reg, u8 *value, u32 size);
+	int (*display_register)(struct snd_soc_codec *, u32 reg, char
*buffer, u32 limit);
 	hw_write_t hw_write;
 	hw_read_t hw_read;
 	void *reg_cache;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e148db9..a5bbb21 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -919,7 +919,8 @@ static ssize_t codec_reg_show(struct device *dev,
 {
 	struct snd_soc_device *devdata = dev_get_drvdata(dev);
 	struct snd_soc_codec *codec = devdata->codec;
-	int i, step = 1, count = 0;
+	int reg, step = 1, count = 0, limit;
+	soc_register_t value;

 	if (!codec->reg_cache_size)
 		return 0;
@@ -928,9 +929,15 @@ static ssize_t codec_reg_show(struct device *dev,
 		step = codec->reg_cache_step;

 	count += sprintf(buf, "%s registers\n", codec->name);
-	for(i = 0; i < codec->reg_cache_size; i += step)
-		count += sprintf(buf + count, "%2x: %4x\n", i, codec->read(codec, i));
-
+	for(reg = 0; reg < codec->reg_cache_size; reg += step) {
+		limit = (PAGE_SIZE - count > 0 ? PAGE_SIZE - count > 0 : 0);
+		if (codec->display_register)
+			count += codec->display_register(codec, reg, buf + count, limit);
+		else {
+			codec->read(codec, reg, &value.u8, sizeof value);
+			count += snprintf(buf + count, limit, "%2x: %4x\n", reg, value.u32);
+		}
+	}
 	return count;
 }
 static DEVICE_ATTR(codec_reg, 0444, codec_reg_show, NULL);
@@ -996,21 +1003,35 @@ EXPORT_SYMBOL_GPL(snd_soc_free_ac97_codec);
  *
  * Returns 1 for change else 0.
  */
-int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
-				unsigned short mask, unsigned short value)
+int snd_soc_update_bits(struct snd_soc_codec *codec, u32 reg,
+				u64 mask, u32 shift, u64 new)
 {
-	int change;
-	unsigned short old, new;
+	soc_register_t value[SOC_MAX_REG_SIZE];
+	int change, ret, length;
+	u64 *update;

+	if (shift % 8)
+		return -EINVAL;
+		
 	mutex_lock(&io_mutex);
-	old = snd_soc_read(codec, reg);
-	new = (old & ~mask) | value;
-	change = old != new;
-	if (change)
-		snd_soc_write(codec, reg, new);
-
+	ret = length = snd_soc_read(codec, reg, &value[0].u8, sizeof value);
+	if (ret < 0)
+		goto err;
+		
+	shift >>= 3;
+	update = (u64*)&(&value[0].u8)[shift];
+	
+	change = ((*update & ~mask) != new);
+	if (change) {
+		*update = (*update & ~mask) | new;
+		ret = snd_soc_write(codec, reg, &value[0].u8, length);
+		if (ret < 0)
+			goto err;
+	}
+	ret = change;
+err:
 	mutex_unlock(&io_mutex);
-	return change;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_update_bits);

@@ -1026,19 +1047,28 @@ EXPORT_SYMBOL_GPL(snd_soc_update_bits);
  *
  * Returns 1 for change else 0.
  */
-int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned short reg,
-				unsigned short mask, unsigned short value)
+int snd_soc_test_bits(struct snd_soc_codec *codec, u32 reg,
+				u64 mask, u32 shift, u64 new)
 {
-	int change;
-	unsigned short old, new;
+	soc_register_t value[SOC_MAX_REG_SIZE];
+	int ret, length;
+	u64 *update;

+	if (shift % 8)
+		return -EINVAL;
+		
 	mutex_lock(&io_mutex);
-	old = snd_soc_read(codec, reg);
-	new = (old & ~mask) | value;
-	change = old != new;
+	ret = length = snd_soc_read(codec, reg, &value[0].u8, sizeof value);
+	if (ret < 0)
+		goto err;
+		
+	shift >>= 3;
+	update = (u64*)&(&value[0].u8)[shift];
+	
+	ret = ((*update & ~mask) != new);
+err:
 	mutex_unlock(&io_mutex);
-
-	return change;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_test_bits);

@@ -1277,15 +1307,16 @@ int snd_soc_get_enum_double(struct
snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned short val, bitmask;
+	unsigned short bitmask;
+	soc_register_t value[SOC_MAX_REG_SIZE];

 	for (bitmask = 1; bitmask < e->mask; bitmask <<= 1)
 		;
-	val = snd_soc_read(codec, e->reg);
-	ucontrol->value.enumerated.item[0] = (val >> e->shift_l) & (bitmask - 1);
+	snd_soc_read(codec, e->reg, &value[0].u8, sizeof value);
+	ucontrol->value.enumerated.item[0] = (value[0].u16 >> e->shift_l) &
(bitmask - 1);
 	if (e->shift_l != e->shift_r)
 		ucontrol->value.enumerated.item[1] =
-			(val >> e->shift_r) & (bitmask - 1);
+			(value[0].u16 >> e->shift_r) & (bitmask - 1);

 	return 0;
 }
@@ -1321,7 +1352,7 @@ int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 		mask |= (bitmask - 1) << e->shift_r;
 	}

-	return snd_soc_update_bits(codec, e->reg, mask, val);
+	return snd_soc_update_bits(codec, e->reg, mask, 0, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_enum_double);

@@ -1390,18 +1421,16 @@ EXPORT_SYMBOL_GPL(snd_soc_info_volsw_ext);
 int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo)
 {
-	int max = (kcontrol->private_value >> 16) & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0x0f;
-	int rshift = (kcontrol->private_value >> 12) & 0x0f;
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value;

-	if (max == 1)
+	if (mc->max == 1)
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	else
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;

-	uinfo->count = shift == rshift ? 1 : 2;
+	uinfo->count = mc->shift == mc->rshift ? 1 : 2;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = max;
+	uinfo->value.integer.max = mc->max;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_info_volsw);
@@ -1419,24 +1448,23 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0x0f;
-	int rshift = (kcontrol->private_value >> 12) & 0x0f;
-	int max = (kcontrol->private_value >> 16) & 0xff;
-	int mask = (1 << fls(max)) - 1;
-	int invert = (kcontrol->private_value >> 24) & 0x01;
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value;
+	int mask = (1 << fls(mc->max)) - 1;
+	soc_register_t value[SOC_MAX_REG_SIZE];
+
+	snd_soc_read(codec, mc->reg, &value[0].u8, sizeof value);

 	ucontrol->value.integer.value[0] =
-		(snd_soc_read(codec, reg) >> shift) & mask;
-	if (shift != rshift)
+		(value[0].u16 >> mc->shift) & mask;
+	if (mc->shift != mc->rshift)
 		ucontrol->value.integer.value[1] =
-			(snd_soc_read(codec, reg) >> rshift) & mask;
-	if (invert) {
+			(value[0].u16 >> mc->rshift) & mask;
+	if (mc->invert) {
 		ucontrol->value.integer.value[0] =
-			max - ucontrol->value.integer.value[0];
-		if (shift != rshift)
+			mc->max - ucontrol->value.integer.value[0];
+		if (mc->shift != mc->rshift)
 			ucontrol->value.integer.value[1] =
-				max - ucontrol->value.integer.value[1];
+				mc->max - ucontrol->value.integer.value[1];
 	}

 	return 0;
@@ -1456,27 +1484,23 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0x0f;
-	int rshift = (kcontrol->private_value >> 12) & 0x0f;
-	int max = (kcontrol->private_value >> 16) & 0xff;
-	int mask = (1 << fls(max)) - 1;
-	int invert = (kcontrol->private_value >> 24) & 0x01;
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value;
+	int mask = (1 << fls(mc->max)) - 1;
 	unsigned short val, val2, val_mask;

 	val = (ucontrol->value.integer.value[0] & mask);
-	if (invert)
-		val = max - val;
-	val_mask = mask << shift;
-	val = val << shift;
-	if (shift != rshift) {
+	if (mc->invert)
+		val = mc->max - val;
+	val_mask = mask << mc->shift;
+	val = val << mc->shift;
+	if (mc->shift != mc->rshift) {
 		val2 = (ucontrol->value.integer.value[1] & mask);
-		if (invert)
-			val2 = max - val2;
-		val_mask |= mask << rshift;
-		val |= val2 << rshift;
+		if (mc->invert)
+			val2 = mc->max - val2;
+		val_mask |= mask << mc->rshift;
+		val |= val2 << mc->rshift;
 	}
-	return snd_soc_update_bits(codec, reg, val_mask, val);
+	return snd_soc_update_bits(codec, mc->reg, val_mask, 0, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw);

@@ -1493,16 +1517,16 @@ EXPORT_SYMBOL_GPL(snd_soc_put_volsw);
 int snd_soc_info_volsw_2r(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo)
 {
-	int max = (kcontrol->private_value >> 12) & 0xff;
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value;

-	if (max == 1)
+	if (mc->max == 1)
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	else
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;

 	uinfo->count = 2;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = max;
+	uinfo->value.integer.max = mc->max;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_info_volsw_2r);
@@ -1520,22 +1544,21 @@ int snd_soc_get_volsw_2r(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value & 0xff;
-	int reg2 = (kcontrol->private_value >> 24) & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0x0f;
-	int max = (kcontrol->private_value >> 12) & 0xff;
-	int mask = (1<<fls(max))-1;
-	int invert = (kcontrol->private_value >> 20) & 0x01;
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value;
+	int mask = (1<<fls(mc->max))-1;
+	soc_register_t value[SOC_MAX_REG_SIZE];
+
+	snd_soc_read(codec, mc->reg, &value[0].u8, sizeof value);

 	ucontrol->value.integer.value[0] =
-		(snd_soc_read(codec, reg) >> shift) & mask;
+		(value[0].u16 >> mc->shift) & mask;
 	ucontrol->value.integer.value[1] =
-		(snd_soc_read(codec, reg2) >> shift) & mask;
-	if (invert) {
+		(value[0].u16 >> mc->shift) & mask;
+	if (mc->invert) {
 		ucontrol->value.integer.value[0] =
-			max - ucontrol->value.integer.value[0];
+			mc->max - ucontrol->value.integer.value[0];
 		ucontrol->value.integer.value[1] =
-			max - ucontrol->value.integer.value[1];
+			mc->max - ucontrol->value.integer.value[1];
 	}

 	return 0;
@@ -1555,31 +1578,27 @@ int snd_soc_put_volsw_2r(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value & 0xff;
-	int reg2 = (kcontrol->private_value >> 24) & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0x0f;
-	int max = (kcontrol->private_value >> 12) & 0xff;
-	int mask = (1 << fls(max)) - 1;
-	int invert = (kcontrol->private_value >> 20) & 0x01;
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value;
+	int mask = (1 << fls(mc->max)) - 1;
 	int err;
 	unsigned short val, val2, val_mask;

-	val_mask = mask << shift;
+	val_mask = mask << mc->shift;
 	val = (ucontrol->value.integer.value[0] & mask);
 	val2 = (ucontrol->value.integer.value[1] & mask);

-	if (invert) {
-		val = max - val;
-		val2 = max - val2;
+	if (mc->invert) {
+		val = mc->max - val;
+		val2 = mc->max - val2;
 	}

-	val = val << shift;
-	val2 = val2 << shift;
+	val = val << mc->shift;
+	val2 = val2 << mc->shift;

-	if ((err = snd_soc_update_bits(codec, reg, val_mask, val)) < 0)
+	if ((err = snd_soc_update_bits(codec, mc->reg, val_mask, 0, val)) < 0)
 		return err;

-	err = snd_soc_update_bits(codec, reg2, val_mask, val2);
+	err = snd_soc_update_bits(codec, mc->rreg, val_mask, 0, val2);
 	return err;
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_2r);
