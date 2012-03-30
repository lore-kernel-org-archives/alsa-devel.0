From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH] ASoC: core: Rework SOC_DOUBLE_R_SX_TLV add
	SOC_SINGLE_SX_TLV
Date: Fri, 30 Mar 2012 10:43:55 -0500
Message-ID: <1333122235-30774-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe003.messaging.microsoft.com [216.32.180.13])
	by alsa0.perex.cz (Postfix) with ESMTP id BF29B1045EE
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Mar 2012 17:45:07 +0200 (CEST)
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
Cc: apatard@mandriva.com, Brian Austin <brian.austin@cirrus.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Some codecs namely Cirrus Logic Codecs have a way of wrapping the dB scale around 0dB without 0dB being in the middle.

Rework of SOC_DOUBLE_R_SX_TLV to be more consistent with other asoc tlv macros.
Add single register macro : SOC_SINGLE_SX_TLV.
Use snd_soc_info_volsw for .info
Use snd_soc_get_volsw_sx, snd_soc_put_volsw_sx for single and double.

kcontrols for CS42L51 and CS42L73 are adjusted to these new TLV Macros.

The max value is determined by: (number of steps) +1 for 0dB +max from codec datasheet.

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 include/sound/soc.h        |   48 +++++++-----
 sound/soc/codecs/cs42l51.c |    6 +-
 sound/soc/codecs/cs42l73.c |   26 +++---
 sound/soc/soc-core.c       |  174 ++++++++++++++++++++-----------------------
 4 files changed, 125 insertions(+), 129 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2ebf787..1e17e04 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -55,6 +55,18 @@
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
 	.put = snd_soc_put_volsw, \
 	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
+#define SOC_SINGLE_SX_TLV(xname, xreg, xshift, xmin, xmax, tlv_array) \
+{       .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+	SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.tlv.p  = (tlv_array),\
+	.info = snd_soc_info_volsw, \
+	.get = snd_soc_get_volsw_sx,\
+	.put = snd_soc_put_volsw_sx, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = xreg, .rreg = xreg, \
+		.shift = xshift, .rshift = xshift, \
+		.max = xmax, .min = xmin} }
 #define SOC_DOUBLE(xname, reg, shift_left, shift_right, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
@@ -85,6 +97,18 @@
 	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
 					    xmax, xinvert) }
+#define SOC_DOUBLE_R_SX_TLV(xname, xreg, xrreg, xshift, xmin, xmax, tlv_array) \
+{       .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+	SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.tlv.p  = (tlv_array), \
+	.info = snd_soc_info_volsw, \
+	.get = snd_soc_get_volsw_sx, \
+	.put = snd_soc_put_volsw_sx, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = xreg, .rreg = xrreg, \
+		.shift = xshift, .rshift = xshift, \
+		.max = xmax, .min = xmin} }
 #define SOC_DOUBLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \
 {	.iface  = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
@@ -171,20 +195,6 @@
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = (unsigned long)&xenum }
 
-#define SOC_DOUBLE_R_SX_TLV(xname, xreg_left, xreg_right, xshift,\
-		xmin, xmax, tlv_array) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
-		  SNDRV_CTL_ELEM_ACCESS_READWRITE, \
-	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw_2r_sx, \
-	.get = snd_soc_get_volsw_2r_sx, \
-	.put = snd_soc_put_volsw_2r_sx, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg_left, \
-		 .rreg = xreg_right, .shift = xshift, \
-		 .min = xmin, .max = xmax} }
-
 #define SND_SOC_BYTES(xname, xbase, xregs)		      \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,   \
 	.info = snd_soc_bytes_info, .get = snd_soc_bytes_get, \
@@ -413,6 +423,10 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 #define snd_soc_get_volsw_2r snd_soc_get_volsw
 #define snd_soc_put_volsw_2r snd_soc_put_volsw
+int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_info_volsw_s8(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_get_volsw_s8(struct snd_kcontrol *kcontrol,
@@ -421,12 +435,6 @@ int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_limit_volume(struct snd_soc_codec *codec,
 	const char *name, int max);
-int snd_soc_info_volsw_2r_sx(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo);
-int snd_soc_get_volsw_2r_sx(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_put_volsw_2r_sx(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_bytes_info(struct snd_kcontrol *kcontrol,
 		       struct snd_ctl_elem_info *uinfo);
 int snd_soc_bytes_get(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index a8bf588..85d6069 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -141,15 +141,15 @@ static const struct soc_enum cs42l51_chan_mix =
 static const struct snd_kcontrol_new cs42l51_snd_controls[] = {
 	SOC_DOUBLE_R_SX_TLV("PCM Playback Volume",
 			CS42L51_PCMA_VOL, CS42L51_PCMB_VOL,
-			7, 0xffffff99, 0x18, adc_pcm_tlv),
+			6, 0x19, 0x7F, adc_pcm_tlv),
 	SOC_DOUBLE_R("PCM Playback Switch",
 			CS42L51_PCMA_VOL, CS42L51_PCMB_VOL, 7, 1, 1),
 	SOC_DOUBLE_R_SX_TLV("Analog Playback Volume",
 			CS42L51_AOUTA_VOL, CS42L51_AOUTB_VOL,
-			8, 0xffffff19, 0x18, aout_tlv),
+			0, 0x34, 0xE4, aout_tlv),
 	SOC_DOUBLE_R_SX_TLV("ADC Mixer Volume",
 			CS42L51_ADCA_VOL, CS42L51_ADCB_VOL,
-			7, 0xffffff99, 0x18, adc_pcm_tlv),
+			6, 0x19, 0x7F, adc_pcm_tlv),
 	SOC_DOUBLE_R("ADC Mixer Switch",
 			CS42L51_ADCA_VOL, CS42L51_ADCB_VOL, 7, 1, 1),
 	SOC_SINGLE("Playback Deemphasis Switch", CS42L51_DAC_CTL, 3, 1, 0),
diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 78979b3..d39b3e7 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -402,37 +402,37 @@ static const struct snd_kcontrol_new ear_amp_ctl =
 
 static const struct snd_kcontrol_new cs42l73_snd_controls[] = {
 	SOC_DOUBLE_R_SX_TLV("Headphone Analog Playback Volume",
-			CS42L73_HPAAVOL, CS42L73_HPBAVOL, 7,
-			0xffffffC1, 0x0C, hpaloa_tlv),
+			CS42L73_HPAAVOL, CS42L73_HPBAVOL, 0,
+			0x41, 0x4B, hpaloa_tlv),
 
 	SOC_DOUBLE_R_SX_TLV("LineOut Analog Playback Volume", CS42L73_LOAAVOL,
-			CS42L73_LOBAVOL, 7, 0xffffffC1, 0x0C, hpaloa_tlv),
+			CS42L73_LOBAVOL, 0, 0x41, 0x4B, hpaloa_tlv),
 
 	SOC_DOUBLE_R_SX_TLV("Input PGA Analog Volume", CS42L73_MICAPREPGAAVOL,
-			CS42L73_MICBPREPGABVOL, 5, 0xffffff35,
-			0x34, micpga_tlv),
+			CS42L73_MICBPREPGABVOL, 5, 0x34,
+			0x24, micpga_tlv),
 
 	SOC_DOUBLE_R("MIC Preamp Switch", CS42L73_MICAPREPGAAVOL,
 			CS42L73_MICBPREPGABVOL, 6, 1, 1),
 
 	SOC_DOUBLE_R_SX_TLV("Input Path Digital Volume", CS42L73_IPADVOL,
-			CS42L73_IPBDVOL, 7, 0xffffffA0, 0xA0, ipd_tlv),
+			CS42L73_IPBDVOL, 0, 0xA0, 0x6C, ipd_tlv),
 
 	SOC_DOUBLE_R_SX_TLV("HL Digital Playback Volume",
-			CS42L73_HLADVOL, CS42L73_HLBDVOL, 7, 0xffffffE5,
-			0xE4, hl_tlv),
+			CS42L73_HLADVOL, CS42L73_HLBDVOL,
+			0, 0x34, 0xE4, hl_tlv),
 
 	SOC_SINGLE_TLV("ADC A Boost Volume",
 			CS42L73_ADCIPC, 2, 0x01, 1, adc_boost_tlv),
 
 	SOC_SINGLE_TLV("ADC B Boost Volume",
-			CS42L73_ADCIPC, 6, 0x01, 1, adc_boost_tlv),
+		       CS42L73_ADCIPC, 6, 0x01, 1, adc_boost_tlv),
 
-	SOC_SINGLE_TLV("Speakerphone Digital Playback Volume",
-			CS42L73_SPKDVOL, 0, 0xE4, 1, hl_tlv),
+	SOC_SINGLE_SX_TLV("Speakerphone Digital Volume",
+			    CS42L73_SPKDVOL, 0, 0x34, 0xE4, hl_tlv),
 
-	SOC_SINGLE_TLV("Ear Speaker Digital Playback Volume",
-			CS42L73_ESLDVOL, 0, 0xE4, 1, hl_tlv),
+	SOC_SINGLE_SX_TLV("Ear Speaker Digital Volume",
+			    CS42L73_ESLDVOL, 0, 0x34, 0xE4, hl_tlv),
 
 	SOC_DOUBLE_R("Headphone Analog Playback Switch", CS42L73_HPAAVOL,
 			CS42L73_HPBAVOL, 7, 1, 1),
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a4deebc..548fb05 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2531,6 +2531,87 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw);
 
 /**
+ * snd_soc_get_volsw_sx - single mixer get callback
+ * @kcontrol: mixer control
+ * @ucontrol: control element information
+ *
+ * Callback to get the value of a single mixer control, or a double mixer
+ * control that spans 2 registers.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct soc_mixer_control *mc =
+	    (struct soc_mixer_control *)kcontrol->private_value;
+
+	unsigned int reg = mc->reg;
+	unsigned int reg2 = mc->rreg;
+	unsigned int shift = mc->shift;
+	unsigned int rshift = mc->rshift;
+	int max = mc->max;
+	int min = mc->min;
+	int mask = (1 << (fls(min + max) - 1)) - 1;
+
+	ucontrol->value.integer.value[0] =
+	    ((snd_soc_read(codec, reg) >> shift) - min) & mask;
+
+	if (snd_soc_volsw_is_stereo(mc))
+		ucontrol->value.integer.value[1] =
+			((snd_soc_read(codec, reg2) >> rshift) - min) & mask;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_get_volsw_sx);
+
+/**
+ * snd_soc_put_volsw_sx - double mixer set callback
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Callback to set the value of a double mixer control that spans 2 registers.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct soc_mixer_control *mc =
+	    (struct soc_mixer_control *)kcontrol->private_value;
+
+	unsigned int reg = mc->reg;
+	unsigned int reg2 = mc->rreg;
+	unsigned int shift = mc->shift;
+	unsigned int rshift = mc->rshift;
+	int max = mc->max;
+	int min = mc->min;
+	int mask = (1 << (fls(min + max) - 1)) - 1;
+	int err;
+	unsigned short val, val_mask, val2 = 0;
+
+	val_mask = mask << shift;
+	val = (ucontrol->value.integer.value[0] + min) & mask;
+	val = val << shift;
+
+	if (snd_soc_update_bits_locked(codec, reg, val_mask, val))
+			return err;
+
+	if (snd_soc_volsw_is_stereo(mc)) {
+		val_mask = mask << rshift;
+		val2 = (ucontrol->value.integer.value[1] + min) & mask;
+		val2 = val2 << rshift;
+
+		if (snd_soc_update_bits_locked(codec, reg2, val_mask, val2))
+			return err;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_put_volsw_sx);
+
+/**
  * snd_soc_info_volsw_s8 - signed mixer info callback
  * @kcontrol: mixer control
  * @uinfo: control element information
@@ -2651,99 +2732,6 @@ int snd_soc_limit_volume(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_soc_limit_volume);
 
-/**
- * snd_soc_info_volsw_2r_sx - double with tlv and variable data size
- *  mixer info callback
- * @kcontrol: mixer control
- * @uinfo: control element information
- *
- * Returns 0 for success.
- */
-int snd_soc_info_volsw_2r_sx(struct snd_kcontrol *kcontrol,
-			struct snd_ctl_elem_info *uinfo)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	int max = mc->max;
-	int min = mc->min;
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 2;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = max-min;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_info_volsw_2r_sx);
-
-/**
- * snd_soc_get_volsw_2r_sx - double with tlv and variable data size
- *  mixer get callback
- * @kcontrol: mixer control
- * @uinfo: control element information
- *
- * Returns 0 for success.
- */
-int snd_soc_get_volsw_2r_sx(struct snd_kcontrol *kcontrol,
-			struct snd_ctl_elem_value *ucontrol)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	unsigned int mask = (1<<mc->shift)-1;
-	int min = mc->min;
-	int val = snd_soc_read(codec, mc->reg) & mask;
-	int valr = snd_soc_read(codec, mc->rreg) & mask;
-
-	ucontrol->value.integer.value[0] = ((val & 0xff)-min) & mask;
-	ucontrol->value.integer.value[1] = ((valr & 0xff)-min) & mask;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_get_volsw_2r_sx);
-
-/**
- * snd_soc_put_volsw_2r_sx - double with tlv and variable data size
- *  mixer put callback
- * @kcontrol: mixer control
- * @uinfo: control element information
- *
- * Returns 0 for success.
- */
-int snd_soc_put_volsw_2r_sx(struct snd_kcontrol *kcontrol,
-			struct snd_ctl_elem_value *ucontrol)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	unsigned int mask = (1<<mc->shift)-1;
-	int min = mc->min;
-	int ret;
-	unsigned int val, valr, oval, ovalr;
-
-	val = ((ucontrol->value.integer.value[0]+min) & 0xff);
-	val &= mask;
-	valr = ((ucontrol->value.integer.value[1]+min) & 0xff);
-	valr &= mask;
-
-	oval = snd_soc_read(codec, mc->reg) & mask;
-	ovalr = snd_soc_read(codec, mc->rreg) & mask;
-
-	ret = 0;
-	if (oval != val) {
-		ret = snd_soc_write(codec, mc->reg, val);
-		if (ret < 0)
-			return ret;
-	}
-	if (ovalr != valr) {
-		ret = snd_soc_write(codec, mc->rreg, valr);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_put_volsw_2r_sx);
-
 int snd_soc_bytes_info(struct snd_kcontrol *kcontrol,
 		       struct snd_ctl_elem_info *uinfo)
 {
-- 
1.7.9.1
