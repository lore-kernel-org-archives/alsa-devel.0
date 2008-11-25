From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 05/13] ASoC: TWL4030: Add helper function for
	output gain controls
Date: Tue, 25 Nov 2008 15:44:41 +0000
Message-ID: <1227627889-8373-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081125154302.GA8319@rakim.wolfsonmicro.main>
	<1227627889-8373-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0033F24495
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 16:44:51 +0100 (CET)
In-Reply-To: <1227627889-8373-4-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Some of the gain controls in TWL (mostly those which are associated with
the outputs) are implemented in an interesting way:
 0x0 : Power down (mute)
 0x1 : 6dB
 0x2 : 0 dB
 0x3 : -6 dB
Inverting not going to help with these.
Custom volsw and volsw_2r get/put functions to handle these gains.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |  157 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 157 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 91effd3..4136231 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -191,6 +191,163 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 }
 
 /*
+ * Some of the gain controls in TWL (mostly those which are associated with
+ * the outputs) are implemented in an interesting way:
+ * 0x0 : Power down (mute)
+ * 0x1 : 6dB
+ * 0x2 : 0 dB
+ * 0x3 : -6 dB
+ * Inverting not going to help with these.
+ * Custom volsw and volsw_2r get/put functions to handle these gain bits.
+ */
+#define SOC_DOUBLE_TLV_TWL4030(xname, xreg, shift_left, shift_right, xmax,\
+			       xinvert, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw, \
+	.get = snd_soc_get_volsw_twl4030, \
+	.put = snd_soc_put_volsw_twl4030, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = xreg, .shift = shift_left, .rshift = shift_right,\
+		 .max = xmax, .invert = xinvert} }
+#define SOC_DOUBLE_R_TLV_TWL4030(xname, reg_left, reg_right, xshift, xmax,\
+				 xinvert, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw_2r, \
+	.get = snd_soc_get_volsw_r2_twl4030,\
+	.put = snd_soc_put_volsw_r2_twl4030, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
+		.max = xmax, .invert = xinvert} }
+#define SOC_SINGLE_TLV_TWL4030(xname, xreg, xshift, xmax, xinvert, tlv_array) \
+	SOC_DOUBLE_TLV_TWL4030(xname, xreg, xshift, xshift, xmax, \
+			       xinvert, tlv_array)
+
+static int snd_soc_get_volsw_twl4030(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	unsigned int rshift = mc->rshift;
+	int max = mc->max;
+	int mask = (1 << fls(max)) - 1;
+
+	ucontrol->value.integer.value[0] =
+		(snd_soc_read(codec, reg) >> shift) & mask;
+	if (ucontrol->value.integer.value[0])
+		ucontrol->value.integer.value[0] =
+			max + 1 - ucontrol->value.integer.value[0];
+
+	if (shift != rshift) {
+		ucontrol->value.integer.value[1] =
+			(snd_soc_read(codec, reg) >> rshift) & mask;
+		if (ucontrol->value.integer.value[1])
+			ucontrol->value.integer.value[1] =
+				max + 1 - ucontrol->value.integer.value[1];
+	}
+
+	return 0;
+}
+
+static int snd_soc_put_volsw_twl4030(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	unsigned int rshift = mc->rshift;
+	int max = mc->max;
+	int mask = (1 << fls(max)) - 1;
+	unsigned short val, val2, val_mask;
+
+	val = (ucontrol->value.integer.value[0] & mask);
+
+	val_mask = mask << shift;
+	if (val)
+		val = max + 1 - val;
+	val = val << shift;
+	if (shift != rshift) {
+		val2 = (ucontrol->value.integer.value[1] & mask);
+		val_mask |= mask << rshift;
+		if (val2)
+			val2 = max + 1 - val2;
+		val |= val2 << rshift;
+	}
+	return snd_soc_update_bits(codec, reg, val_mask, val);
+}
+
+static int snd_soc_get_volsw_r2_twl4030(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int reg = mc->reg;
+	unsigned int reg2 = mc->rreg;
+	unsigned int shift = mc->shift;
+	int max = mc->max;
+	int mask = (1<<fls(max))-1;
+
+	ucontrol->value.integer.value[0] =
+		(snd_soc_read(codec, reg) >> shift) & mask;
+	ucontrol->value.integer.value[1] =
+		(snd_soc_read(codec, reg2) >> shift) & mask;
+
+	if (ucontrol->value.integer.value[0])
+		ucontrol->value.integer.value[0] =
+			max + 1 - ucontrol->value.integer.value[0];
+	if (ucontrol->value.integer.value[1])
+		ucontrol->value.integer.value[1] =
+			max + 1 - ucontrol->value.integer.value[1];
+
+	return 0;
+}
+
+static int snd_soc_put_volsw_r2_twl4030(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int reg = mc->reg;
+	unsigned int reg2 = mc->rreg;
+	unsigned int shift = mc->shift;
+	int max = mc->max;
+	int mask = (1 << fls(max)) - 1;
+	int err;
+	unsigned short val, val2, val_mask;
+
+	val_mask = mask << shift;
+	val = (ucontrol->value.integer.value[0] & mask);
+	val2 = (ucontrol->value.integer.value[1] & mask);
+
+	if (val)
+		val = max + 1 - val;
+	if (val2)
+		val2 = max + 1 - val2;
+
+	val = val << shift;
+	val2 = val2 << shift;
+
+	err = snd_soc_update_bits(codec, reg, val_mask, val);
+	if (err < 0)
+		return err;
+
+	err = snd_soc_update_bits(codec, reg2, val_mask, val2);
+	return err;
+}
+
+/*
  * FGAIN volume control:
  * from -62 to 0 dB in 1 dB steps (mute instead of -63 dB)
  */
-- 
1.5.6.5
