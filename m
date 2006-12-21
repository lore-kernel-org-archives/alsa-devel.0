From: Randy Cushman <rcushman_linux@earthlink.net>
Subject: Patch for AD1986 AC97 CODEC
Date: Thu, 21 Dec 2006 13:30:03 -0500
Message-ID: <458AD2AB.70602@earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020203030603080407030509"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020203030603080407030509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi,

Attached please find the third and final installment of separated 
patches you requested.

I have retested all 3 patches applied to ALSA 1.0.13.  (The patches were 
derived sequentially from Mercurial.)

I decided to leave out the output volume control renaming for the 
AD1986, because 1) I found the name "Master Surround" to be confusing, 
since "Surround" is used to refer to the rear channels of a multichannel 
configuration.  Also renaming "Headphone" to "Master" makes no sense for 
the AD1986, since the AD1986 has separate Headphone pins, unlike the 
AD1888, AD1980 and AD1985 for which the same pins are used for either 
the Headphone or Surround outputs.

I do plan to revisit output volume control names in the future.  The 
AD1986 uses volume controls somewhat differently than most AC '97 
Devices.  For example, normally for AC '97 devices, register 0x18 
controls DAC PCM attenuation for all channels; the AD1986 uses a special 
"ADI Mode" configuration in which register 0x18 controls DAC PCM 
attenuation only for the front channels, with other registers 
controlling DAC PCM attenuation for the other channels.

The AD1888, AD1980 and AD1985 can be configured in software to use 
either the AC '97 Compatibility mode or the ADI Mode.  (In ALSA 
currently they are fixed in ADI Mode.)  The AD1986 can use only the ADI 
Mode.

FYI: The AD1986 and AD1986A have the same Vendor ID codes, and therefore 
are indistinguishable from an AC '97 perspective.  The difference is the 
AD1986 is AC '97 only, and the AD1986A can be configured for AC '97 or 
HD Audio use.

Randy Cushman


--------------020203030603080407030509
Content-Type: text/plain;
 name="ac97_ad1986_2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97_ad1986_2.patch"

Summary: fix various issues with AD1986/AD1986A support

Previously, ac97_codec.c was coded to support AD1986 and AD1986A
CODECs using code written for the AD1985 CODEC.  This allowed the
LINE_OUT and HEADPHONE jacks to function properly, however register
differences between the CODECs prevented line and microphone inputs
from functioning.

Specifically, this patch fixes issues with the following mixer
controls:  'V_REFOUT', 'Spread Front to Surround and Center/LFE',
'Exchange Front/Surround', 'Surround Jack Mode', and 'Channel Mode'.
This patch removes the undocumented AD1888 control
'High Pass Filter Enable' and adds the new control
'Exchange Mic/Line In'.

Signed-off-by: Randy Cushman <rcushman_linux@earthlink.net>


--- b/alsa-kernel/include/ac97_codec.h	2006-11-30 17:34:01.000000000 -0500
+++ c/alsa-kernel/include/ac97_codec.h	2006-12-21 10:14:32.000000000 -0500
@@ -503,6 +503,7 @@
 			unsigned short id[3];		// codec IDs (lower 16-bit word)
 			unsigned short pcmreg[3];	// PCM registers
 			unsigned short codec_cfg[3];	// CODEC_CFG bits
+			unsigned char swap_mic_linein;	// AD1986/AD1986A only
 		} ad18xx;
 		unsigned int dev_flags;		/* device specific */
 	} spec;
--- b/alsa-kernel/pci/ac97/ac97_codec.c	2006-12-19 09:51:51.000000000 -0500
+++ c/alsa-kernel/pci/ac97/ac97_codec.c	2006-12-21 09:22:14.000000000 -0500
@@ -111,7 +111,7 @@
 { 0x41445372, 0xffffffff, "AD1981A",		patch_ad1981a,	NULL },
 { 0x41445374, 0xffffffff, "AD1981B",		patch_ad1981b,	NULL },
 { 0x41445375, 0xffffffff, "AD1985",		patch_ad1985,	NULL },
-{ 0x41445378, 0xffffffff, "AD1986",		patch_ad1985,	NULL },
+{ 0x41445378, 0xffffffff, "AD1986",		patch_ad1986,	NULL },
 { 0x414c4300, 0xffffff00, "ALC100,100P", 	NULL,		NULL },
 { 0x414c4710, 0xfffffff0, "ALC200,200P",	NULL,		NULL },
 { 0x414c4721, 0xffffffff, "ALC650D",		NULL,	NULL }, /* already patched */
--- b/alsa-kernel/pci/ac97/ac97_patch.c	2006-12-21 10:03:42.000000000 -0500
+++ c/alsa-kernel/pci/ac97/ac97_patch.c	2006-12-21 10:06:25.000000000 -0500
@@ -1623,7 +1623,7 @@
 	return 0;
 }
 
-/* MISC bits */
+/* MISC bits (AD1888/AD1980/AD1985 register 0x76) */
 #define AC97_AD198X_MBC		0x0003	/* mic boost */
 #define AC97_AD198X_MBC_20	0x0000	/* +20dB */
 #define AC97_AD198X_MBC_10	0x0001	/* +10dB */
@@ -1647,6 +1647,83 @@
 #define AC97_AD198X_AC97NC	0x4000	/* AC97 no compatible mode */
 #define AC97_AD198X_DACZ	0x8000	/* DAC zero-fill mode */
 
+/* MISC 1 bits (AD1986 register 0x76) */
+#define AC97_AD1986_MBC		0x0003	/* mic boost */
+#define AC97_AD1986_MBC_20	0x0000	/* +20dB */
+#define AC97_AD1986_MBC_10	0x0001	/* +10dB */
+#define AC97_AD1986_MBC_30	0x0002	/* +30dB */
+#define AC97_AD1986_LISEL0	0x0004	/* LINE_IN select bit 0 */
+#define AC97_AD1986_LISEL1	0x0008	/* LINE_IN select bit 1 */
+#define AC97_AD1986_LISEL_MASK	(AC97_AD1986_LISEL1 | AC97_AD1986_LISEL0)
+#define AC97_AD1986_LISEL_LI	0x0000  /* LINE_IN pins as LINE_IN source */
+#define AC97_AD1986_LISEL_SURR	0x0004  /* SURROUND pins as LINE_IN source */
+#define AC97_AD1986_LISEL_MIC	0x0008  /* MIC_1/2 pins as LINE_IN source */
+#define AC97_AD1986_SRU		0x0010	/* sample rate unlock */
+#define AC97_AD1986_SOSEL	0x0020	/* SURROUND_OUT amplifiers input sel */
+#define AC97_AD1986_2MIC	0x0040	/* 2-channel mic select */
+#define AC97_AD1986_SPRD	0x0080	/* SPREAD enable */
+#define AC97_AD1986_DMIX0	0x0100	/* downmix mode: */
+					/*  0 = 6-to-4, 1 = 6-to-2 downmix */
+#define AC97_AD1986_DMIX1	0x0200	/* downmix mode: 1 = enabled */
+#define AC97_AD1986_CLDIS	0x0800	/* center/lfe disable */
+#define AC97_AD1986_SODIS	0x1000	/* SURROUND_OUT disable */
+#define AC97_AD1986_MSPLT	0x2000	/* mute split (read only 1) */
+#define AC97_AD1986_AC97NC	0x4000	/* AC97 no compatible mode (r/o 1) */
+#define AC97_AD1986_DACZ	0x8000	/* DAC zero-fill mode */
+
+/* MISC 2 bits (AD1986 register 0x70) */
+#define AC97_AD_MISC2		0x70	/* Misc Control Bits 2 (AD1986) */
+
+#define AC97_AD1986_CVREF0	0x0004	/* C/LFE VREF_OUT 2.25V */
+#define AC97_AD1986_CVREF1	0x0008	/* C/LFE VREF_OUT 0V */
+#define AC97_AD1986_CVREF2	0x0010	/* C/LFE VREF_OUT 3.7V */
+#define AC97_AD1986_CVREF_MASK \
+	(AC97_AD1986_CVREF2 | AC97_AD1986_CVREF1 | AC97_AD1986_CVREF0)
+#define AC97_AD1986_JSMAP	0x0020	/* Jack Sense Mapping 1 = alternate */
+#define AC97_AD1986_MMDIS	0x0080	/* Mono Mute Disable */
+#define AC97_AD1986_MVREF0	0x0400	/* MIC VREF_OUT 2.25V */
+#define AC97_AD1986_MVREF1	0x0800	/* MIC VREF_OUT 0V */
+#define AC97_AD1986_MVREF2	0x1000	/* MIC VREF_OUT 3.7V */
+#define AC97_AD1986_MVREF_MASK \
+	(AC97_AD1986_MVREF2 | AC97_AD1986_MVREF1 | AC97_AD1986_MVREF0)
+
+/* MISC 3 bits (AD1986 register 0x7a) */
+#define AC97_AD_MISC3		0x7a	/* Misc Control Bits 3 (AD1986) */
+
+#define AC97_AD1986_MMIX	0x0004	/* Mic Mix, left/right */
+#define AC97_AD1986_GPO		0x0008	/* General Purpose Out */
+#define AC97_AD1986_LOHPEN	0x0010	/* LINE_OUT headphone drive */
+#define AC97_AD1986_LVREF0	0x0100	/* LINE_OUT VREF_OUT 2.25V */
+#define AC97_AD1986_LVREF1	0x0200	/* LINE_OUT VREF_OUT 0V */
+#define AC97_AD1986_LVREF2	0x0400	/* LINE_OUT VREF_OUT 3.7V */
+#define AC97_AD1986_LVREF_MASK \
+	(AC97_AD1986_LVREF2 | AC97_AD1986_LVREF1 | AC97_AD1986_LVREF0)
+#define AC97_AD1986_JSINVA	0x0800	/* Jack Sense Invert SENSE_A */
+#define AC97_AD1986_LOSEL	0x1000	/* LINE_OUT amplifiers input select */
+#define AC97_AD1986_HPSEL0	0x2000	/* Headphone amplifiers */
+					/*   input select Surround DACs */
+#define AC97_AD1986_HPSEL1	0x4000	/* Headphone amplifiers input */
+					/*   select C/LFE DACs */
+#define AC97_AD1986_JSINVB	0x8000	/* Jack Sense Invert SENSE_B */
+
+/* Serial Config bits (AD1986 register 0x74) (incomplete) */
+#define AC97_AD1986_OMS0	0x0100	/* Optional Mic Selector bit 0 */
+#define AC97_AD1986_OMS1	0x0200	/* Optional Mic Selector bit 1 */
+#define AC97_AD1986_OMS2	0x0400	/* Optional Mic Selector bit 2 */
+#define AC97_AD1986_OMS_MASK \
+	(AC97_AD1986_OMS2 | AC97_AD1986_OMS1 | AC97_AD1986_OMS0)
+#define AC97_AD1986_OMS_M	0x0000  /* MIC_1/2 pins are MIC sources */
+#define AC97_AD1986_OMS_L	0x0100  /* LINE_IN pins are MIC sources */
+#define AC97_AD1986_OMS_C	0x0200  /* Center/LFE pins are MCI sources */
+#define AC97_AD1986_OMS_MC	0x0400  /* Mix of MIC and C/LFE pins */
+					/*   are MIC sources */
+#define AC97_AD1986_OMS_ML	0x0500  /* MIX of MIC and LINE_IN pins */
+					/*   are MIC sources */
+#define AC97_AD1986_OMS_LC	0x0600  /* MIX of LINE_IN and C/LFE pins */
+					/*   are MIC sources */
+#define AC97_AD1986_OMS_MLC	0x0700  /* MIX of MIC, LINE_IN, C/LFE pins */
+					/*   are MIC sources */
+
 
 static int snd_ac97_ad198x_spdif_source_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
@@ -2102,6 +2179,294 @@
 	return 0;
 }
 
+static int snd_ac97_ad1986_bool_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int snd_ac97_ad1986_lososel_get(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+
+	val = ac97->regs[AC97_AD_MISC3];
+	ucontrol->value.integer.value[0] = (val & AC97_AD1986_LOSEL) != 0;
+	return 0;
+}
+
+static int snd_ac97_ad1986_lososel_put(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+	int ret0;
+	int ret1;
+	int sprd = (ac97->regs[AC97_AD_MISC] & AC97_AD1986_SPRD) != 0;
+
+	ret0 = snd_ac97_update_bits(ac97, AC97_AD_MISC3, AC97_AD1986_LOSEL,
+					ucontrol->value.integer.value[0] != 0
+				    ? AC97_AD1986_LOSEL : 0);
+	if (ret0 < 0)
+		return ret0;
+
+	/* SOSEL is set to values of "Spread" or "Exchange F/S" controls */
+	ret1 = snd_ac97_update_bits(ac97, AC97_AD_MISC, AC97_AD1986_SOSEL,
+				    (ucontrol->value.integer.value[0] != 0
+				     || sprd)
+				    ? AC97_AD1986_SOSEL : 0);
+	if (ret1 < 0)
+		return ret1;
+
+	return (ret0 > 0 || ret1 > 0) ? 1 : 0;
+}
+
+static int snd_ac97_ad1986_spread_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+
+	val = ac97->regs[AC97_AD_MISC];
+	ucontrol->value.integer.value[0] = (val & AC97_AD1986_SPRD) != 0;
+	return 0;
+}
+
+static int snd_ac97_ad1986_spread_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+	int ret0;
+	int ret1;
+	int sprd = (ac97->regs[AC97_AD_MISC3] & AC97_AD1986_LOSEL) != 0;
+
+	ret0 = snd_ac97_update_bits(ac97, AC97_AD_MISC, AC97_AD1986_SPRD,
+					ucontrol->value.integer.value[0] != 0
+				    ? AC97_AD1986_SPRD : 0);
+	if (ret0 < 0)
+		return ret0;
+
+	/* SOSEL is set to values of "Spread" or "Exchange F/S" controls */
+	ret1 = snd_ac97_update_bits(ac97, AC97_AD_MISC, AC97_AD1986_SOSEL,
+				    (ucontrol->value.integer.value[0] != 0
+				     || sprd)
+				    ? AC97_AD1986_SOSEL : 0);
+	if (ret1 < 0)
+		return ret1;
+
+	return (ret0 > 0 || ret1 > 0) ? 1 : 0;
+}
+
+static int snd_ac97_ad1986_miclisel_get(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = ac97->spec.ad18xx.swap_mic_linein;
+	return 0;
+}
+
+static int snd_ac97_ad1986_miclisel_put(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned char swap = ucontrol->value.integer.value[0] != 0;
+
+	if (swap != ac97->spec.ad18xx.swap_mic_linein) {
+		ac97->spec.ad18xx.swap_mic_linein = swap;
+		if (ac97->build_ops->update_jacks)
+			ac97->build_ops->update_jacks(ac97);
+		return 1;
+	}
+	return 0;
+}
+
+static int snd_ac97_ad1986_vrefout_get(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	/* Use MIC_1/2 V_REFOUT as the "get" value */
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+	unsigned short reg = ac97->regs[AC97_AD_MISC2];
+	if ((reg & AC97_AD1986_MVREF0) != 0)
+		val = 2;
+	else if ((reg & AC97_AD1986_MVREF1) != 0)
+		val = 3;
+	else if ((reg & AC97_AD1986_MVREF2) != 0)
+		val = 1;
+	else
+		val = 0;
+	ucontrol->value.enumerated.item[0] = val;
+	return 0;
+}
+
+static int snd_ac97_ad1986_vrefout_put(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short cval;
+	unsigned short lval;
+	unsigned short mval;
+	int cret;
+	int lret;
+	int mret;
+
+	switch (ucontrol->value.enumerated.item[0])
+	{
+	case 0: /* High-Z */
+		cval = 0;
+		lval = 0;
+		mval = 0;
+		break;
+	case 1: /* 3.7 V */
+		cval = AC97_AD1986_CVREF2;
+		lval = AC97_AD1986_LVREF2;
+		mval = AC97_AD1986_MVREF2;
+		break;
+	case 2: /* 2.25 V */
+		cval = AC97_AD1986_CVREF0;
+		lval = AC97_AD1986_LVREF0;
+		mval = AC97_AD1986_MVREF0;
+		break;
+	case 3: /* 0 V */
+		cval = AC97_AD1986_CVREF1;
+		lval = AC97_AD1986_LVREF1;
+		mval = AC97_AD1986_MVREF1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	cret = snd_ac97_update_bits(ac97, AC97_AD_MISC2,
+				    AC97_AD1986_CVREF_MASK, cval);
+	if (cret < 0)
+		return cret;
+	lret = snd_ac97_update_bits(ac97, AC97_AD_MISC3,
+				    AC97_AD1986_LVREF_MASK, lval);
+	if (lret < 0)
+		return lret;
+	mret = snd_ac97_update_bits(ac97, AC97_AD_MISC2,
+				    AC97_AD1986_MVREF_MASK, mval);
+	if (mret < 0)
+		return mret;
+
+	return (cret > 0 || lret > 0 || mret > 0) ? 1 : 0;
+}
+
+static const struct snd_kcontrol_new snd_ac97_ad1986_controls[] = {
+	AC97_SINGLE("Exchange Center/LFE", AC97_AD_SERIAL_CFG, 3, 1, 0),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Exchange Front/Surround",
+		.info = snd_ac97_ad1986_bool_info,
+		.get = snd_ac97_ad1986_lososel_get,
+		.put = snd_ac97_ad1986_lososel_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Exchange Mic/Line In",
+		.info = snd_ac97_ad1986_bool_info,
+		.get = snd_ac97_ad1986_miclisel_get,
+		.put = snd_ac97_ad1986_miclisel_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Spread Front to Surround and Center/LFE",
+		.info = snd_ac97_ad1986_bool_info,
+		.get = snd_ac97_ad1986_spread_get,
+		.put = snd_ac97_ad1986_spread_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Downmix",
+		.info = snd_ac97_ad1888_downmix_info,
+		.get = snd_ac97_ad1888_downmix_get,
+		.put = snd_ac97_ad1888_downmix_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "V_REFOUT",
+		.info = snd_ac97_ad1985_vrefout_info,
+		.get = snd_ac97_ad1986_vrefout_get,
+		.put = snd_ac97_ad1986_vrefout_put
+	},
+	AC97_SURROUND_JACK_MODE_CTL,
+	AC97_CHANNEL_MODE_CTL,
+
+	AC97_SINGLE("Headphone Jack Sense", AC97_AD_JACK_SPDIF, 10, 1, 0),
+	AC97_SINGLE("Line Jack Sense", AC97_AD_JACK_SPDIF, 12, 1, 0)
+};
+
+static void ad1986_update_jacks(struct snd_ac97 *ac97)
+{
+	unsigned short misc_val = 0;
+	unsigned short ser_val;
+
+	/* disable SURROUND and CENTER/LFE if not surround mode */
+	if (! is_surround_on(ac97))
+		misc_val |= AC97_AD1986_SODIS;
+	if (! is_clfe_on(ac97))
+		misc_val |= AC97_AD1986_CLDIS;
+
+	/* select line input (default=LINE_IN, SURROUND or MIC_1/2) */
+	if (is_shared_linein(ac97))
+		misc_val |= AC97_AD1986_LISEL_SURR;
+	else if (ac97->spec.ad18xx.swap_mic_linein != 0)
+		misc_val |= AC97_AD1986_LISEL_MIC;
+	snd_ac97_update_bits(ac97, AC97_AD_MISC,
+			     AC97_AD1986_SODIS | AC97_AD1986_CLDIS |
+			     AC97_AD1986_LISEL_MASK,
+			     misc_val);
+
+	/* select microphone input (MIC_1/2, Center/LFE or LINE_IN) */
+	if (is_shared_micin(ac97))
+		ser_val = AC97_AD1986_OMS_C;
+	else if (ac97->spec.ad18xx.swap_mic_linein != 0)
+		ser_val = AC97_AD1986_OMS_L;
+	else
+		ser_val = AC97_AD1986_OMS_M;
+	snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG,
+			     AC97_AD1986_OMS_MASK,
+			     ser_val);
+}
+
+static int patch_ad1986_specific(struct snd_ac97 *ac97)
+{
+	int err;
+
+	if ((err = patch_build_controls(ac97, &snd_ac97_ad198x_2cmic, 1)) < 0)
+		return err;
+
+	return patch_build_controls(ac97, snd_ac97_ad1986_controls,
+				    ARRAY_SIZE(snd_ac97_ad1985_controls));
+}
+
+static struct snd_ac97_build_ops patch_ad1986_build_ops = {
+	.build_post_spdif = patch_ad198x_post_spdif,
+	.build_specific = patch_ad1986_specific,
+#ifdef CONFIG_PM
+	.resume = ad18xx_resume,
+#endif
+	.update_jacks = ad1986_update_jacks,
+};
+
+int patch_ad1986(struct snd_ac97 * ac97)
+{
+	patch_ad1881(ac97);
+	ac97->build_ops = &patch_ad1986_build_ops;
+	ac97->flags |= AC97_STEREO_MUTES;
+
+	/* update current jack configuration */
+	ad1986_update_jacks(ac97);
+
+	return 0;
+}
+
+
 /*
  * realtek ALC65x/850 codecs
  */
--- b/alsa-kernel/pci/ac97/ac97_patch.h	2006-11-30 17:34:01.000000000 -0500
+++ c/alsa-kernel/pci/ac97/ac97_patch.h	2006-12-21 09:40:27.000000000 -0500
@@ -48,6 +48,7 @@
 int patch_ad1981a(struct snd_ac97 * ac97);
 int patch_ad1981b(struct snd_ac97 * ac97);
 int patch_ad1985(struct snd_ac97 * ac97);
+int patch_ad1986(struct snd_ac97 * ac97);
 int patch_alc650(struct snd_ac97 * ac97);
 int patch_alc655(struct snd_ac97 * ac97);
 int patch_alc850(struct snd_ac97 * ac97);

--------------020203030603080407030509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------020203030603080407030509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------020203030603080407030509--
