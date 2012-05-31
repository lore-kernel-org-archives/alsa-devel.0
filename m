From: Adam Thomson <Adam.Thomson@diasemi.com>
Subject: [PATCH 1/2] ASoC: core: Add single controls with
	specified range of values
Date: Thu, 31 May 2012 11:19:15 +0100
Message-ID: <201205311027.q4VARIG5009001@sw-eng-lt-apt-vm1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay1.diasemi.com (mailrelay1.diasemi.com [82.210.246.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EB7324336
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 12:28:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Adam Thomson <Adam.Thomson@diasemi.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Michal Hajduk <Michal.Hajduk@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Control type added for cases where a specific range of values
within a register are required for control.

Added convenience macro:

SOC_SINGLE_RANGE_TLV

Added accessor implementations:

snd_soc_info_volsw_range
snd_soc_put_volsw_range
snd_soc_get_volsw_range

Signed-off-by: Michal Hajduk <Michal.Hajduk@diasemi.com>
Signed-off-by: Adam Thomson <Adam.Thomson@diasemi.com>
---
 include/sound/soc.h  |   16 +++++++++
 sound/soc/soc-core.c |   89 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index c703871..2096c60 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -67,6 +67,16 @@
 		{.reg = xreg, .rreg = xreg, \
 		.shift = xshift, .rshift = xshift, \
 		.max = xmax, .min = xmin} }
+#define SOC_SINGLE_RANGE_TLV(xname, xreg, xshift, xmin, xmax, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw_range, \
+	.get = snd_soc_get_volsw_range, .put = snd_soc_put_volsw_range, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = xreg, .shift = xshift, .min = xmin,\
+		 .max = xmax, .platform_max = xmax} }
 #define SOC_DOUBLE(xname, reg, shift_left, shift_right, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
@@ -460,6 +470,12 @@ int snd_soc_get_volsw_s8(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_info_volsw_range(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo);
+int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_limit_volume(struct snd_soc_codec *codec,
 	const char *name, int max);
 int snd_soc_bytes_info(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b37ee80..1a1aba4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2790,6 +2790,95 @@ int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_s8);
 
 /**
+ * snd_soc_info_volsw_range - single mixer info callback with range.
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Callback to provide information, within a range, about a single
+ * mixer control.
+ *
+ * returns 0 for success.
+ */
+int snd_soc_info_volsw_range(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int platform_max;
+	int min = mc->min;
+
+	if (!mc->platform_max)
+		mc->platform_max = mc->max;
+	platform_max = mc->platform_max;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = platform_max - min;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_info_volsw_range);
+
+/**
+ * snd_soc_put_volsw_range - single mixer put value callback with range.
+ * @kcontrol: mixer control
+ * @ucontrol: control element information
+ *
+ * Callback to set the value, within a range, for a single mixer control.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	int min = mc->min;
+	int max = mc->max;
+	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int val, val_mask;
+
+	val = ((ucontrol->value.integer.value[0] + min) & mask);
+	val_mask = mask << shift;
+	val = val << shift;
+
+	return snd_soc_update_bits_locked(codec, reg, val_mask, val);
+}
+EXPORT_SYMBOL_GPL(snd_soc_put_volsw_range);
+
+/**
+ * snd_soc_get_volsw_range - single mixer get callback with range
+ * @kcontrol: mixer control
+ * @ucontrol: control element information
+ *
+ * Callback to get the value, within a range, of a single mixer control.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	int min = mc->min;
+	int max = mc->max;
+	unsigned int mask = (1 << fls(max)) - 1;
+
+	ucontrol->value.integer.value[0] =
+		((snd_soc_read(codec, reg) >> shift) & mask) - min;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_get_volsw_range);
+
+/**
  * snd_soc_limit_volume - Set new limit to an existing volume control.
  *
  * @codec: where to look for the control
-- 
1.7.0.4
