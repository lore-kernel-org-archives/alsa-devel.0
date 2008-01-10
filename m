From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 04/17] ASoC TLV support.
Date: Thu, 10 Jan 2008 13:17:02 +0000
Message-ID: <1199971035-13553-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1199971035-13553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	by alsa0.perex.cz (Postfix) with ESMTP id 46B5324591
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 14:17:20 +0100 (CET)
In-Reply-To: <1199971035-13553-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Philipp Zabel <philipp.zabel@gmail.com>

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |   24 ++++++++++++++---
 include/sound/soc.h      |   58 +++++++++++++++++++++++++++++++++-------
 sound/soc/soc-core.c     |   66 ++++++++++++++++++++++++++-------------------
 sound/soc/soc-dapm.c     |   14 +++++----
 4 files changed, 114 insertions(+), 48 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index db02159..335d73c 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -131,18 +131,34 @@
 	.shift = wshift, .invert = winvert}
 
 /* dapm kcontrol types */
-#define SOC_DAPM_SINGLE(xname, reg, shift, mask, invert) \
+#define SOC_DAPM_SINGLE(xname, reg, shift, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
-	.private_value =  SOC_SINGLE_VALUE(reg, shift, mask, invert) }
-#define SOC_DAPM_DOUBLE(xname, reg, shift_left, shift_right, mask, invert, \
+	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
+#define SOC_DAPM_DOUBLE(xname, reg, shift_left, shift_right, max, invert, \
 	power) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.info = snd_soc_info_volsw, \
  	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
  	.private_value = (reg) | ((shift_left) << 8) | ((shift_right) << 12) |\
- 		 ((mask) << 16) | ((invert) << 24) }
+		((max) << 16) | ((invert) << 24) }
+#define SOC_DAPM_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_volsw, \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
+	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
+#define SOC_DAPM_DOUBLE_TLV(xname, reg, shift_left, shift_right, max, invert, \
+	power, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw, \
+	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
+	.private_value = (reg) | ((shift_left) << 8) | ((shift_right) << 12) |\
+		((max) << 16) | ((invert) << 24) }
 #define SOC_DAPM_ENUM(xname, xenum) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_enum_double, \
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 000f3e7..c69b58c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -27,27 +27,53 @@
 /*
  * Convenience kcontrol builders
  */
-#define SOC_SINGLE_VALUE(reg,shift,mask,invert) ((reg) | ((shift) << 8) |\
-	((shift) << 12) | ((mask) << 16) | ((invert) << 24))
-#define SOC_SINGLE_VALUE_EXT(reg,mask,invert) ((reg) | ((mask) << 16) |\
+#define SOC_SINGLE_VALUE(reg, shift, max, invert) ((reg) | ((shift) << 8) |\
+	((shift) << 12) | ((max) << 16) | ((invert) << 24))
+#define SOC_SINGLE_VALUE_EXT(reg, max, invert) ((reg) | ((max) << 16) |\
 	((invert) << 31))
-#define SOC_SINGLE(xname, reg, shift, mask, invert) \
+#define SOC_SINGLE(xname, reg, shift, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
 	.put = snd_soc_put_volsw, \
-	.private_value =  SOC_SINGLE_VALUE(reg, shift, mask, invert) }
-#define SOC_DOUBLE(xname, reg, shift_left, shift_right, mask, invert) \
+	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
+#define SOC_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
+	.put = snd_soc_put_volsw, \
+	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
+#define SOC_DOUBLE(xname, reg, shift_left, shift_right, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
 	.put = snd_soc_put_volsw, \
 	.private_value = (reg) | ((shift_left) << 8) | \
-		((shift_right) << 12) | ((mask) << 16) | ((invert) << 24) }
-#define SOC_DOUBLE_R(xname, reg_left, reg_right, shift, mask, invert) \
+		((shift_right) << 12) | ((max) << 16) | ((invert) << 24) }
+#define SOC_DOUBLE_R(xname, reg_left, reg_right, shift, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.info = snd_soc_info_volsw_2r, \
 	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
 	.private_value = (reg_left) | ((shift) << 8)  | \
-		((mask) << 12) | ((invert) << 20) | ((reg_right) << 24) }
+		((max) << 12) | ((invert) << 20) | ((reg_right) << 24) }
+#define SOC_DOUBLE_TLV(xname, reg, shift_left, shift_right, max, invert, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
+	.put = snd_soc_put_volsw, \
+	.private_value = (reg) | ((shift_left) << 8) | \
+		((shift_right) << 12) | ((max) << 16) | ((invert) << 24) }
+#define SOC_DOUBLE_R_TLV(xname, reg_left, reg_right, shift, max, invert, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw_2r, \
+	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
+	.private_value = (reg_left) | ((shift) << 8)  | \
+		((max) << 12) | ((invert) << 20) | ((reg_right) << 24) }
 #define SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, xtexts) \
 {	.reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
 	.mask = xmask, .texts = xtexts }
@@ -105,9 +131,21 @@
 #define SND_SOC_DAIFMT_GATED		(1 << 4)	/* clock is gated when not Tx/Rx */
 
 /*
+ * DAI Sync
+ * Synchronous LR (Left Right) clocks and Frame signals.
+ */
+#define SND_SOC_DAIFMT_SYNC		(0 << 5)	/* Tx FRM = Rx FRM */
+#define SND_SOC_DAIFMT_ASYNC		(1 << 5)	/* Tx FRM ~ Rx FRM */
+
+/*
+ * TDM
+ */
+#define SND_SOC_DAIFMT_TDM		(1 << 6)
+
+/*
  * DAI hardware signal inversions
  */
-#define SND_SOC_DAIFMT_NB_NF		(0 << 8)	/* normal bit clock + frame */
+#define SND_SOC_DAIFMT_NB_NF		(0 << 8)	/* normal bclk + frm */
 #define SND_SOC_DAIFMT_NB_IF		(1 << 8)	/* normal bclk + inv frm */
 #define SND_SOC_DAIFMT_IB_NF		(2 << 8)	/* invert bclk + nor frm */
 #define SND_SOC_DAIFMT_IB_IF		(3 << 8)	/* invert bclk + frm */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index aaf141c..0e361d5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1214,7 +1214,6 @@ struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
 	memcpy(&template, _template, sizeof(template));
 	if (long_name)
 		template.name = long_name;
-	template.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
 	template.index = 0;
 
 	return snd_ctl_new1(&template, data);
@@ -1349,13 +1348,16 @@ EXPORT_SYMBOL_GPL(snd_soc_info_enum_ext);
 int snd_soc_info_volsw_ext(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo)
 {
-	int mask = kcontrol->private_value;
+	int max = kcontrol->private_value;
+
+	if (max == 1)
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	else
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 
-	uinfo->type =
-		mask == 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN : SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = mask;
+	uinfo->value.integer.max = max;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_info_volsw_ext);
@@ -1372,15 +1374,18 @@ EXPORT_SYMBOL_GPL(snd_soc_info_volsw_ext);
 int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo)
 {
-	int mask = (kcontrol->private_value >> 16) & 0xff;
+	int max = (kcontrol->private_value >> 16) & 0xff;
 	int shift = (kcontrol->private_value >> 8) & 0x0f;
 	int rshift = (kcontrol->private_value >> 12) & 0x0f;
 
-	uinfo->type =
-		mask == 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN : SNDRV_CTL_ELEM_TYPE_INTEGER;
+	if (max == 1)
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	else
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+
 	uinfo->count = shift == rshift ? 1 : 2;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = mask;
+	uinfo->value.integer.max = max;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_info_volsw);
@@ -1401,7 +1406,8 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	int reg = kcontrol->private_value & 0xff;
 	int shift = (kcontrol->private_value >> 8) & 0x0f;
 	int rshift = (kcontrol->private_value >> 12) & 0x0f;
-	int mask = (kcontrol->private_value >> 16) & 0xff;
+	int max = (kcontrol->private_value >> 16) & 0xff;
+	int mask = (1 << fls(max)) - 1;
 	int invert = (kcontrol->private_value >> 24) & 0x01;
 
 	ucontrol->value.integer.value[0] =
@@ -1411,10 +1417,10 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 			(snd_soc_read(codec, reg) >> rshift) & mask;
 	if (invert) {
 		ucontrol->value.integer.value[0] =
-			mask - ucontrol->value.integer.value[0];
+			max - ucontrol->value.integer.value[0];
 		if (shift != rshift)
 			ucontrol->value.integer.value[1] =
-				mask - ucontrol->value.integer.value[1];
+				max - ucontrol->value.integer.value[1];
 	}
 
 	return 0;
@@ -1437,25 +1443,24 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	int reg = kcontrol->private_value & 0xff;
 	int shift = (kcontrol->private_value >> 8) & 0x0f;
 	int rshift = (kcontrol->private_value >> 12) & 0x0f;
-	int mask = (kcontrol->private_value >> 16) & 0xff;
+	int max = (kcontrol->private_value >> 16) & 0xff;
+	int mask = (1 << fls(max)) - 1;
 	int invert = (kcontrol->private_value >> 24) & 0x01;
-	int err;
 	unsigned short val, val2, val_mask;
 
 	val = (ucontrol->value.integer.value[0] & mask);
 	if (invert)
-		val = mask - val;
+		val = max - val;
 	val_mask = mask << shift;
 	val = val << shift;
 	if (shift != rshift) {
 		val2 = (ucontrol->value.integer.value[1] & mask);
 		if (invert)
-			val2 = mask - val2;
+			val2 = max - val2;
 		val_mask |= mask << rshift;
 		val |= val2 << rshift;
 	}
-	err = snd_soc_update_bits(codec, reg, val_mask, val);
-	return err;
+	return snd_soc_update_bits(codec, reg, val_mask, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw);
 
@@ -1472,13 +1477,16 @@ EXPORT_SYMBOL_GPL(snd_soc_put_volsw);
 int snd_soc_info_volsw_2r(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo)
 {
-	int mask = (kcontrol->private_value >> 12) & 0xff;
+	int max = (kcontrol->private_value >> 12) & 0xff;
+
+	if (max == 1)
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	else
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 
-	uinfo->type =
-		mask == 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN : SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 2;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = mask;
+	uinfo->value.integer.max = max;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_info_volsw_2r);
@@ -1499,7 +1507,8 @@ int snd_soc_get_volsw_2r(struct snd_kcontrol *kcontrol,
 	int reg = kcontrol->private_value & 0xff;
 	int reg2 = (kcontrol->private_value >> 24) & 0xff;
 	int shift = (kcontrol->private_value >> 8) & 0x0f;
-	int mask = (kcontrol->private_value >> 12) & 0xff;
+	int max = (kcontrol->private_value >> 12) & 0xff;
+	int mask = (1<<fls(max))-1;
 	int invert = (kcontrol->private_value >> 20) & 0x01;
 
 	ucontrol->value.integer.value[0] =
@@ -1508,9 +1517,9 @@ int snd_soc_get_volsw_2r(struct snd_kcontrol *kcontrol,
 		(snd_soc_read(codec, reg2) >> shift) & mask;
 	if (invert) {
 		ucontrol->value.integer.value[0] =
-			mask - ucontrol->value.integer.value[0];
+			max - ucontrol->value.integer.value[0];
 		ucontrol->value.integer.value[1] =
-			mask - ucontrol->value.integer.value[1];
+			max - ucontrol->value.integer.value[1];
 	}
 
 	return 0;
@@ -1533,7 +1542,8 @@ int snd_soc_put_volsw_2r(struct snd_kcontrol *kcontrol,
 	int reg = kcontrol->private_value & 0xff;
 	int reg2 = (kcontrol->private_value >> 24) & 0xff;
 	int shift = (kcontrol->private_value >> 8) & 0x0f;
-	int mask = (kcontrol->private_value >> 12) & 0xff;
+	int max = (kcontrol->private_value >> 12) & 0xff;
+	int mask = (1 << fls(max)) - 1;
 	int invert = (kcontrol->private_value >> 20) & 0x01;
 	int err;
 	unsigned short val, val2, val_mask;
@@ -1543,8 +1553,8 @@ int snd_soc_put_volsw_2r(struct snd_kcontrol *kcontrol,
 	val2 = (ucontrol->value.integer.value[1] & mask);
 
 	if (invert) {
-		val = mask - val;
-		val2 = mask - val2;
+		val = max - val;
+		val2 = max - val2;
 	}
 
 	val = val << shift;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0a9d192..d5d3c17 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1019,8 +1019,9 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 	int reg = kcontrol->private_value & 0xff;
 	int shift = (kcontrol->private_value >> 8) & 0x0f;
 	int rshift = (kcontrol->private_value >> 12) & 0x0f;
-	int mask = (kcontrol->private_value >> 16) & 0xff;
+	int max = (kcontrol->private_value >> 16) & 0xff;
 	int invert = (kcontrol->private_value >> 24) & 0x01;
+	int mask = (1 << fls(max)) - 1;
 
 	/* return the saved value if we are powered down */
 	if (widget->id == snd_soc_dapm_pga && !widget->power) {
@@ -1035,10 +1036,10 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 			(snd_soc_read(widget->codec, reg) >> rshift) & mask;
 	if (invert) {
 		ucontrol->value.integer.value[0] =
-			mask - ucontrol->value.integer.value[0];
+			max - ucontrol->value.integer.value[0];
 		if (shift != rshift)
 			ucontrol->value.integer.value[1] =
-				mask - ucontrol->value.integer.value[1];
+				max - ucontrol->value.integer.value[1];
 	}
 
 	return 0;
@@ -1061,7 +1062,8 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	int reg = kcontrol->private_value & 0xff;
 	int shift = (kcontrol->private_value >> 8) & 0x0f;
 	int rshift = (kcontrol->private_value >> 12) & 0x0f;
-	int mask = (kcontrol->private_value >> 16) & 0xff;
+	int max = (kcontrol->private_value >> 16) & 0xff;
+	int mask = (1 << fls(max)) - 1;
 	int invert = (kcontrol->private_value >> 24) & 0x01;
 	unsigned short val, val2, val_mask;
 	int ret;
@@ -1069,13 +1071,13 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	val = (ucontrol->value.integer.value[0] & mask);
 
 	if (invert)
-		val = mask - val;
+		val = max - val;
 	val_mask = mask << shift;
 	val = val << shift;
 	if (shift != rshift) {
 		val2 = (ucontrol->value.integer.value[1] & mask);
 		if (invert)
-			val2 = mask - val2;
+			val2 = max - val2;
 		val_mask |= mask << rshift;
 		val |= val2 << rshift;
 	}
-- 
1.5.3.8
