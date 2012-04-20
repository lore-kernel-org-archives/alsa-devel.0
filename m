From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 1/8] ASoC: core: Add signed multi register
	control
Date: Fri, 20 Apr 2012 11:32:13 +0200
Message-ID: <1334914333-27335-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog111.obsmtp.com (eu1sys200aog111.obsmtp.com
	[207.126.144.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 57D52103F90
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Apr 2012 11:32:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
List-Id: alsa-devel@alsa-project.org

From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>

Added control type that can span multiple consecutive codec registers
forming a single signed value in a MSB/LSB manner.
The control dynamically adjusts to the register word size configured
in driver.

Added convenience macro.

SOC_SINGLE_XR_SX

Added accessor implementations.

snd_soc_info_xr_sx
snd_soc_get_xr_sx
snd_soc_put_xr_sx

Signed-off-by: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
---
 include/sound/soc.h  |   22 +++++++++-
 sound/soc/soc-core.c |  118 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2ebf787..8888adc 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -200,6 +200,15 @@
 		{.base = xbase, .num_regs = xregs,	      \
 		 .mask = xmask }) }
 
+#define SOC_SINGLE_XR_SX(xname, xregbase, xregcount, xnbits, \
+		xmin, xmax, xinvert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.info = snd_soc_info_xr_sx, .get = snd_soc_get_xr_sx, \
+	.put = snd_soc_put_xr_sx, \
+	.private_value = (unsigned long)&(struct soc_mreg_control) \
+		{.regbase = xregbase, .regcount = xregcount, .nbits = xnbits, \
+		.invert = xinvert, .min = xmin, .max = xmax} }
+
 /*
  * Simplified versions of above macros, declaring a struct and calculating
  * ARRAY_SIZE internally
@@ -433,7 +442,12 @@ int snd_soc_bytes_get(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol);
 int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol);
-
+int snd_soc_info_xr_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo);
+int snd_soc_get_xr_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
 
 /**
  * struct snd_soc_reg_access - Describes whether a given register is
@@ -916,6 +930,12 @@ struct soc_bytes {
 	u32 mask;
 };
 
+/* multi register control */
+struct soc_mreg_control {
+	long min, max;
+	unsigned int regbase, regcount, nbits, invert;
+};
+
 /* enumerated kcontrol */
 struct soc_enum {
 	unsigned short reg;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e19c24a..7fc7294b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2848,6 +2848,124 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_bytes_put);
 
 /**
+ * snd_soc_info_xr_sx - signed multi register info callback
+ * @kcontrol: mreg control
+ * @uinfo: control element information
+ *
+ * Callback to provide information of a control that can
+ * span multiple codec registers which together
+ * forms a single signed value in a MSB/LSB manner.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_info_xr_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct soc_mreg_control *mc =
+		(struct soc_mreg_control *)kcontrol->private_value;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = mc->min;
+	uinfo->value.integer.max = mc->max;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_info_xr_sx);
+
+/**
+ * snd_soc_get_xr_sx - signed multi register get callback
+ * @kcontrol: mreg control
+ * @ucontrol: control element information
+ *
+ * Callback to get the value of a control that can span
+ * multiple codec registers which together forms a single
+ * signed value in a MSB/LSB manner. The control supports
+ * specifying total no of bits used to allow for bitfields
+ * across the multiple codec registers.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_get_xr_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mreg_control *mc =
+		(struct soc_mreg_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int regbase = mc->regbase;
+	unsigned int regcount = mc->regcount;
+	unsigned int regwshift = codec->driver->reg_word_size * BITS_PER_BYTE;
+	unsigned int regwmask = (1<<regwshift)-1;
+	unsigned int invert = mc->invert;
+	unsigned long mask = (1UL<<mc->nbits)-1;
+	long min = mc->min;
+	long max = mc->max;
+	long val = 0;
+	unsigned long regval;
+	unsigned int i;
+
+	for (i = 0; i < regcount; i++) {
+		regval = snd_soc_read(codec, regbase+i) & regwmask;
+		val |= regval << (regwshift*(regcount-i-1));
+	}
+	val &= mask;
+	if (min < 0 && val > max)
+		val |= ~mask;
+	if (invert)
+		val = max - val;
+	ucontrol->value.integer.value[0] = val;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_get_xr_sx);
+
+/**
+ * snd_soc_put_xr_sx - signed multi register get callback
+ * @kcontrol: mreg control
+ * @ucontrol: control element information
+ *
+ * Callback to set the value of a control that can span
+ * multiple codec registers which together forms a single
+ * signed value in a MSB/LSB manner. The control supports
+ * specifying total no of bits used to allow for bitfields
+ * across the multiple codec registers.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mreg_control *mc =
+		(struct soc_mreg_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int regbase = mc->regbase;
+	unsigned int regcount = mc->regcount;
+	unsigned int regwshift = codec->driver->reg_word_size * BITS_PER_BYTE;
+	unsigned int regwmask = (1<<regwshift)-1;
+	unsigned int invert = mc->invert;
+	unsigned long mask = (1UL<<mc->nbits)-1;
+	long min = mc->min;
+	long max = mc->max;
+	long val = ucontrol->value.integer.value[0];
+	unsigned int i, regval, regmask;
+	int err;
+
+	if (invert)
+		val = max - val;
+	val &= mask;
+	for (i = 0; i < regcount; i++) {
+		regval = (val >> (regwshift*(regcount-i-1))) & regwmask;
+		regmask = (mask >> (regwshift*(regcount-i-1))) & regwmask;
+		err = snd_soc_update_bits_locked(codec, regbase+i,
+				regmask, regval);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_put_xr_sx);
+
+/**
  * snd_soc_dai_set_sysclk - configure DAI system or master clock.
  * @dai: DAI
  * @clk_id: DAI specific clock ID
-- 
1.7.8.3
