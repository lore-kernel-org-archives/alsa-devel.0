From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Add SOC_DOUBLE_S8_TLV control type
Date: Wed, 28 May 2008 17:58:05 +0100
Message-ID: <1211993886-26854-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 463CF246AA
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 18:58:08 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

The SOC_DOUBLE_S8_TLV control type was originally implemented in the
UDA1380 driver by Philipp Zabel and was moved into the core by me.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |   15 ++++++++++
 sound/soc/soc-core.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index bca9538..9fa2093 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -73,6 +73,15 @@
 	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
 	.private_value = (reg_left) | ((shift) << 8)  | \
 		((max) << 12) | ((invert) << 20) | ((reg_right) << 24) }
+#define SOC_DOUBLE_S8_TLV(xname, reg, min, max, tlv_array) \
+{	.iface  = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+		  SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.tlv.p  = (tlv_array), \
+	.info   = snd_soc_info_volsw_s8, .get = snd_soc_get_volsw_s8, \
+	.put    = snd_soc_put_volsw_s8, \
+	.private_value = (reg) | (((signed char)max) << 16) | \
+			 (((signed char)min) << 24) }
 #define SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, xtexts) \
 {	.reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
 	.mask = xmask, .texts = xtexts }
@@ -267,6 +276,12 @@ int snd_soc_get_volsw_2r(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_volsw_2r(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_info_volsw_s8(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo);
+int snd_soc_get_volsw_s8(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
 
 /* SoC PCM stream information */
 struct snd_soc_pcm_stream {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a3f091e..f594ab8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1589,6 +1589,78 @@ int snd_soc_put_volsw_2r(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_2r);
 
+/**
+ * snd_soc_info_volsw_s8 - signed mixer info callback
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Callback to provide information about a signed mixer control.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_info_volsw_s8(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	int max = (signed char)((kcontrol->private_value >> 16) & 0xff);
+	int min = (signed char)((kcontrol->private_value >> 24) & 0xff);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = max-min;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_info_volsw_s8);
+
+/**
+ * snd_soc_get_volsw_s8 - signed mixer get callback
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Callback to get the value of a signed mixer control.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_get_volsw_s8(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int reg = kcontrol->private_value & 0xff;
+	int min = (signed char)((kcontrol->private_value >> 24) & 0xff);
+	int val = snd_soc_read(codec, reg);
+
+	ucontrol->value.integer.value[0] =
+		((signed char)(val & 0xff))-min;
+	ucontrol->value.integer.value[1] =
+		((signed char)((val >> 8) & 0xff))-min;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_get_volsw_s8);
+
+/**
+ * snd_soc_put_volsw_sgn - signed mixer put callback
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Callback to set the value of a signed mixer control.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int reg = kcontrol->private_value & 0xff;
+	int min = (signed char)((kcontrol->private_value >> 24) & 0xff);
+	unsigned short val;
+
+	val = (ucontrol->value.integer.value[0]+min) & 0xff;
+	val |= ((ucontrol->value.integer.value[1]+min) & 0xff) << 8;
+
+	return snd_soc_update_bits(codec, reg, 0xffff, val);
+}
+EXPORT_SYMBOL_GPL(snd_soc_put_volsw_s8);
+
 static int __devinit snd_soc_init(void)
 {
 	printk(KERN_INFO "ASoC version %s\n", SND_SOC_VERSION);
-- 
1.5.5.1
