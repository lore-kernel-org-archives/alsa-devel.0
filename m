From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] Convert bitfields in ASOC into full int width
Date: Tue, 22 Jul 2008 23:01:35 -0400
Message-ID: <20080723030135.21577.69012.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A29C1038EA
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 05:01:37 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so464145and.80
	for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2008 20:01:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Convert bitfields in ASOC into full int width. This needs testing, I don't have sample controls for all of the different configurations. This is a simple mechanical conversion, behavior should not be changed. I did find two places in the DAPM code where max was being used as a mask. I fixed them to convert max to a mask, was this right?

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---

 include/sound/soc.h  |   46 ++++++++++++++++++------------
 sound/soc/soc-core.c |   77 ++++++++++++++++++++++++++++----------------------
 sound/soc/soc-dapm.c |   46 +++++++++++++++++-------------
 3 files changed, 96 insertions(+), 73 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1890d87..8d16394 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -26,10 +26,12 @@
 /*
  * Convenience kcontrol builders
  */
-#define SOC_SINGLE_VALUE(reg, shift, max, invert) ((reg) | ((shift) << 8) |\
-	((shift) << 12) | ((max) << 16) | ((invert) << 24))
-#define SOC_SINGLE_VALUE_EXT(reg, max, invert) ((reg) | ((max) << 16) |\
-	((invert) << 31))
+#define SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert) \
+	(unsigned long)&(struct mixer_control) \
+	{.reg=xreg, .shift=xshift, .max=xmax, .invert=xinvert}
+#define SOC_SINGLE_VALUE_EXT(xreg, xmax, xinvert) \
+	(unsigned long)&(struct mixer_control) \
+	{.reg=xreg, .max=xmax, .invert=xinvert}
 #define SOC_SINGLE(xname, reg, shift, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
@@ -43,45 +45,45 @@
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
 	.put = snd_soc_put_volsw, \
 	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
-#define SOC_DOUBLE(xname, reg, shift_left, shift_right, max, invert) \
+#define SOC_DOUBLE(xname, xreg, shift_left, shift_right, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
 	.put = snd_soc_put_volsw, \
-	.private_value = (reg) | ((shift_left) << 8) | \
-		((shift_right) << 12) | ((max) << 16) | ((invert) << 24) }
-#define SOC_DOUBLE_R(xname, reg_left, reg_right, shift, max, invert) \
+	.private_value = (unsigned long)&(struct mixer_control) \
+		{.reg=xreg, .shift=shift_left, .rshift=shift_right, .max=xmax, .invert=xinvert}
+#define SOC_DOUBLE_R(xname, reg_left, reg_right, xshift, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.info = snd_soc_info_volsw_2r, \
 	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
-	.private_value = (reg_left) | ((shift) << 8)  | \
-		((max) << 12) | ((invert) << 20) | ((reg_right) << 24) }
-#define SOC_DOUBLE_TLV(xname, reg, shift_left, shift_right, max, invert, tlv_array) \
+	.private_value = (unsigned long)&(struct mixer_control) \
+		{.reg=reg_left, .rreg=reg_right, .shift=xshift, .max=xmax, .invert=xinvert}
+#define SOC_DOUBLE_TLV(xname, xreg, shift_left, shift_right, xmax, xinvert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
 	.put = snd_soc_put_volsw, \
-	.private_value = (reg) | ((shift_left) << 8) | \
-		((shift_right) << 12) | ((max) << 16) | ((invert) << 24) }
-#define SOC_DOUBLE_R_TLV(xname, reg_left, reg_right, shift, max, invert, tlv_array) \
+	.private_value = (unsigned long)&(struct mixer_control) \
+		{.reg=xreg, .shift=shift_left, .rshift=right_shift, .max=xmax, .invert=xinvert}
+#define SOC_DOUBLE_R_TLV(xname, reg_left, reg_right, xshift, xmax, xinvert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw_2r, \
 	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
-	.private_value = (reg_left) | ((shift) << 8)  | \
-		((max) << 12) | ((invert) << 20) | ((reg_right) << 24) }
-#define SOC_DOUBLE_S8_TLV(xname, reg, min, max, tlv_array) \
+	.private_value = (unsigned long)&(struct mixer_control) \
+		{.reg=reg_left, .rreg=reg_right, .shift=xshift, .max=xmax, .invert=xinvert}
+#define SOC_DOUBLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \
 {	.iface  = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
 		  SNDRV_CTL_ELEM_ACCESS_READWRITE, \
 	.tlv.p  = (tlv_array), \
 	.info   = snd_soc_info_volsw_s8, .get = snd_soc_get_volsw_s8, \
 	.put    = snd_soc_put_volsw_s8, \
-	.private_value = (reg) | (((signed char)max) << 16) | \
-			 (((signed char)min) << 24) }
+	.private_value = (unsigned long)&(struct mixer_control) \
+		{.reg=xreg, .min=xmin, .max=xmax}
 #define SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, xtexts) \
 {	.reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
 	.mask = xmask, .texts = xtexts }
@@ -516,6 +518,12 @@ struct snd_soc_pcm_runtime {
 	struct snd_soc_device *socdev;
 };
 
+/* mixer control */
+struct mixer_control {
+	int min, max;
+ 	uint reg, rreg, shift, rshift, invert;
+};
+
 /* enumerated kcontrol */
 struct soc_enum {
 	unsigned short reg;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 83f1190..3c36b4d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1434,9 +1434,10 @@ EXPORT_SYMBOL_GPL(snd_soc_info_volsw_ext);
 int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo)
 {
-	int max = (kcontrol->private_value >> 16) & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0x0f;
-	int rshift = (kcontrol->private_value >> 12) & 0x0f;
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value; 
+	int max = mc->max;
+	uint shift = mc->min;
+	uint rshift = mc->rshift;
 
 	if (max == 1)
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
@@ -1462,13 +1463,14 @@ EXPORT_SYMBOL_GPL(snd_soc_info_volsw);
 int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value; 
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0x0f;
-	int rshift = (kcontrol->private_value >> 12) & 0x0f;
-	int max = (kcontrol->private_value >> 16) & 0xff;
-	int mask = (1 << fls(max)) - 1;
-	int invert = (kcontrol->private_value >> 24) & 0x01;
+	uint reg = mc->reg;
+	uint shift = mc->shift;
+	uint rshift = mc->rshift;
+	int max = mc->max;
+	uint mask = (1 << fls(max)) - 1;
+	uint invert = mc->invert;
 
 	ucontrol->value.integer.value[0] =
 		(snd_soc_read(codec, reg) >> shift) & mask;
@@ -1499,13 +1501,14 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw);
 int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value; 
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0x0f;
-	int rshift = (kcontrol->private_value >> 12) & 0x0f;
-	int max = (kcontrol->private_value >> 16) & 0xff;
-	int mask = (1 << fls(max)) - 1;
-	int invert = (kcontrol->private_value >> 24) & 0x01;
+	uint reg = mc->reg;
+	uint shift = mc->shift;
+	uint rshift = mc->rshift;
+	int max = mc->max;
+	uint mask = (1 << fls(max)) - 1;
+	uint invert = mc->invert;
 	unsigned short val, val2, val_mask;
 
 	val = (ucontrol->value.integer.value[0] & mask);
@@ -1537,7 +1540,8 @@ EXPORT_SYMBOL_GPL(snd_soc_put_volsw);
 int snd_soc_info_volsw_2r(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo)
 {
-	int max = (kcontrol->private_value >> 12) & 0xff;
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value; 
+	int max = mc->max;
 
 	if (max == 1)
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
@@ -1563,13 +1567,14 @@ EXPORT_SYMBOL_GPL(snd_soc_info_volsw_2r);
 int snd_soc_get_volsw_2r(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value; 
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value & 0xff;
-	int reg2 = (kcontrol->private_value >> 24) & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0x0f;
-	int max = (kcontrol->private_value >> 12) & 0xff;
-	int mask = (1<<fls(max))-1;
-	int invert = (kcontrol->private_value >> 20) & 0x01;
+	uint reg = mc->reg;
+	uint reg2 = mc->rreg;
+	uint shift = mc->shift;
+	int max = mc->max;
+	uint mask = (1<<fls(max))-1;
+	uint invert = mc->invert;
 
 	ucontrol->value.integer.value[0] =
 		(snd_soc_read(codec, reg) >> shift) & mask;
@@ -1598,13 +1603,14 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw_2r);
 int snd_soc_put_volsw_2r(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value; 
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value & 0xff;
-	int reg2 = (kcontrol->private_value >> 24) & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0x0f;
-	int max = (kcontrol->private_value >> 12) & 0xff;
-	int mask = (1 << fls(max)) - 1;
-	int invert = (kcontrol->private_value >> 20) & 0x01;
+	uint reg = mc->reg;
+	uint reg2 = mc->rreg;
+	uint shift = mc->shift;
+	int max = mc->max;
+	uint mask = (1 << fls(max)) - 1;
+	uint invert = mc->invert;
 	int err;
 	unsigned short val, val2, val_mask;
 
@@ -1641,8 +1647,9 @@ EXPORT_SYMBOL_GPL(snd_soc_put_volsw_2r);
 int snd_soc_info_volsw_s8(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo)
 {
-	int max = (signed char)((kcontrol->private_value >> 16) & 0xff);
-	int min = (signed char)((kcontrol->private_value >> 24) & 0xff);
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value; 
+	int max = mc->max;
+	int min = mc->min;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 2;
@@ -1664,9 +1671,10 @@ EXPORT_SYMBOL_GPL(snd_soc_info_volsw_s8);
 int snd_soc_get_volsw_s8(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value; 
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value & 0xff;
-	int min = (signed char)((kcontrol->private_value >> 24) & 0xff);
+	uint reg = mc->reg;
+	int min = mc->min;
 	int val = snd_soc_read(codec, reg);
 
 	ucontrol->value.integer.value[0] =
@@ -1689,9 +1697,10 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw_s8);
 int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value; 
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value & 0xff;
-	int min = (signed char)((kcontrol->private_value >> 24) & 0xff);
+	uint reg = mc->reg;
+	int min = mc->min;
 	unsigned short val;
 
 	val = (ucontrol->value.integer.value[0]+min) & 0xff;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2c87061..490a486 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -104,10 +104,12 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	case snd_soc_dapm_switch:
 	case snd_soc_dapm_mixer: {
 		int val;
-		int reg = w->kcontrols[i].private_value & 0xff;
-		int shift = (w->kcontrols[i].private_value >> 8) & 0x0f;
-		int mask = (w->kcontrols[i].private_value >> 16) & 0xff;
-		int invert = (w->kcontrols[i].private_value >> 24) & 0x01;
+		struct mixer_control *mc = (struct mixer_control *)w->kcontrols[i].private_value; 
+		uint reg = mc->reg;
+		uint shift = mc->shift;
+		int max = mc->max;
+		uint mask = (1 << fls(max)) - 1;
+		uint invert = mc->invert;
 
 		val = snd_soc_read(w->codec, reg);
 		val = (val >> shift) & mask;
@@ -247,10 +249,12 @@ static int dapm_set_pga(struct snd_soc_dapm_widget *widget, int power)
 		return 0;
 
 	if (widget->num_kcontrols && k) {
-		int reg = k->private_value & 0xff;
-		int shift = (k->private_value >> 8) & 0x0f;
-		int mask = (k->private_value >> 16) & 0xff;
-		int invert = (k->private_value >> 24) & 0x01;
+		struct mixer_control *mc = (struct mixer_control *)k->private_value; 
+		uint reg = mc->reg;
+		uint shift = mc->shift;
+		int max = mc->max;
+		uint mask = (1 << fls(max)) - 1;
+		uint invert = mc->invert;
 
 		if (power) {
 			int i;
@@ -1139,12 +1143,13 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0x0f;
-	int rshift = (kcontrol->private_value >> 12) & 0x0f;
-	int max = (kcontrol->private_value >> 16) & 0xff;
-	int invert = (kcontrol->private_value >> 24) & 0x01;
-	int mask = (1 << fls(max)) - 1;
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value; 
+	uint reg = mc->reg;
+	uint shift = mc->shift;
+	uint rshift = mc->rshift;
+	int max = mc->max;
+	uint invert = mc->invert;
+	uint mask = (1 << fls(max)) - 1;
 
 	/* return the saved value if we are powered down */
 	if (widget->id == snd_soc_dapm_pga && !widget->power) {
@@ -1182,12 +1187,13 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0x0f;
-	int rshift = (kcontrol->private_value >> 12) & 0x0f;
-	int max = (kcontrol->private_value >> 16) & 0xff;
-	int mask = (1 << fls(max)) - 1;
-	int invert = (kcontrol->private_value >> 24) & 0x01;
+	struct mixer_control *mc = (struct mixer_control *)kcontrol->private_value; 
+	uint reg = mc->reg;
+	uint shift = mc->shift;
+	uint rshift = mc->rshift;
+	int max = mc->max;
+	uint mask = (1 << fls(max)) - 1;
+	uint invert = mc->invert;
 	unsigned short val, val2, val_mask;
 	int ret;
