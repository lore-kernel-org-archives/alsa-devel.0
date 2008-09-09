From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 01/24] sound/pci: coding style fixes: ac97
Date: Tue, 9 Sep 2008 05:45:02 +0400
Message-ID: <20080909014502.GE6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.185])
	by alsa0.perex.cz (Postfix) with ESMTP id D46CF24478
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:45:13 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so1402318fka.0
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:45:13 -0700 (PDT)
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
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



- <asm/io.h> -> <linux/io.h>
- remove trailing whitespaces
- convert comments

Only compile tested.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/ac97/ac97_codec.c |  192 ++++++++++++++++----------------
 sound/pci/ac97/ac97_patch.c |  252 +++++++++++++++++++++---------------------
 sound/pci/ac97/ac97_pcm.c   |   10 +-
 sound/pci/ac97/ac97_proc.c  |   24 ++--
 4 files changed, 239 insertions(+), 239 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 6704acb..0cf819a 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -141,33 +141,33 @@ static const struct ac97_codec_id snd_ac97_codec_ids[] = {
 { 0x43525958, 0xfffffff8, "CS4205",		patch_cirrus_spdif,	NULL },
 { 0x43525960, 0xfffffff8, "CS4291",		NULL,		NULL },
 { 0x43525970, 0xfffffff8, "CS4202",		NULL,		NULL },
-{ 0x43585421, 0xffffffff, "HSD11246",		NULL,		NULL },	// SmartMC II
-{ 0x43585428, 0xfffffff8, "Cx20468",		patch_conexant,	NULL }, // SmartAMC fixme: the mask might be different
+{ 0x43585421, 0xffffffff, "HSD11246",		NULL,		NULL },	/* SmartMC II */
+{ 0x43585428, 0xfffffff8, "Cx20468",		patch_conexant,	NULL }, /* SmartAMC fixme: the mask might be different */
 { 0x43585431, 0xffffffff, "Cx20551",           patch_cx20551,  NULL },
 { 0x44543031, 0xfffffff0, "DT0398",		NULL,		NULL },
-{ 0x454d4328, 0xffffffff, "EM28028",		NULL,		NULL },  // same as TR28028?
+{ 0x454d4328, 0xffffffff, "EM28028",		NULL,		NULL },  /* same as TR28028? */
 { 0x45838308, 0xffffffff, "ESS1988",		NULL,		NULL },
 { 0x48525300, 0xffffff00, "HMP9701",		NULL,		NULL },
 { 0x49434501, 0xffffffff, "ICE1230",		NULL,		NULL },
-{ 0x49434511, 0xffffffff, "ICE1232",		NULL,		NULL }, // alias VIA VT1611A?
+{ 0x49434511, 0xffffffff, "ICE1232",		NULL,		NULL }, /* alias VIA VT1611A? */
 { 0x49434514, 0xffffffff, "ICE1232A",		NULL,		NULL },
-{ 0x49434551, 0xffffffff, "VT1616", 		patch_vt1616,	NULL }, 
-{ 0x49434552, 0xffffffff, "VT1616i",		patch_vt1616,	NULL }, // VT1616 compatible (chipset integrated)
+{ 0x49434551, 0xffffffff, "VT1616", 		patch_vt1616,	NULL },
+{ 0x49434552, 0xffffffff, "VT1616i",		patch_vt1616,	NULL }, /* VT1616 compatible (chipset integrated) */
 { 0x49544520, 0xffffffff, "IT2226E",		NULL,		NULL },
 { 0x49544561, 0xffffffff, "IT2646E",		patch_it2646,	NULL },
-{ 0x4e534300, 0xffffffff, "LM4540,43,45,46,48",	NULL,		NULL }, // only guess --jk
+{ 0x4e534300, 0xffffffff, "LM4540,43,45,46,48",	NULL,		NULL }, /* only guess --jk */
 { 0x4e534331, 0xffffffff, "LM4549",		NULL,		NULL },
-{ 0x4e534350, 0xffffffff, "LM4550",		patch_lm4550,  	NULL }, // volume wrap fix 
+{ 0x4e534350, 0xffffffff, "LM4550",		patch_lm4550,  	NULL }, /* volume wrap fix */
 { 0x50534304, 0xffffffff, "UCB1400",		patch_ucb1400,	NULL },
 { 0x53494c20, 0xffffffe0, "Si3036,8",		mpatch_si3036,	mpatch_si3036, AC97_MODEM_PATCH },
 { 0x54524102, 0xffffffff, "TR28022",		NULL,		NULL },
 { 0x54524103, 0xffffffff, "TR28023",		NULL,		NULL },
 { 0x54524106, 0xffffffff, "TR28026",		NULL,		NULL },
-{ 0x54524108, 0xffffffff, "TR28028",		patch_tritech_tr28028,	NULL }, // added by xin jin [07/09/99]
-{ 0x54524123, 0xffffffff, "TR28602",		NULL,		NULL }, // only guess --jk [TR28023 = eMicro EM28023 (new CT1297)]
+{ 0x54524108, 0xffffffff, "TR28028",		patch_tritech_tr28028,	NULL }, /* added by xin jin [07/09/99] */
+{ 0x54524123, 0xffffffff, "TR28602",		NULL,		NULL }, /* only guess --jk [TR28023 = eMicro EM28023 (new CT1297)] */
 { 0x54584e20, 0xffffffff, "TLC320AD9xC",	NULL,		NULL },
-{ 0x56494161, 0xffffffff, "VIA1612A",		NULL,		NULL }, // modified ICE1232 with S/PDIF
-{ 0x56494170, 0xffffffff, "VIA1617A",		patch_vt1617a,	NULL }, // modified VT1616 with S/PDIF
+{ 0x56494161, 0xffffffff, "VIA1612A",		NULL,		NULL }, /* modified ICE1232 with S/PDIF */
+{ 0x56494170, 0xffffffff, "VIA1617A",		patch_vt1617a,	NULL }, /* modified VT1616 with S/PDIF */
 { 0x56494182, 0xffffffff, "VIA1618",		patch_vt1618,   NULL },
 { 0x57454301, 0xffffffff, "W83971D",		NULL,		NULL },
 { 0x574d4c00, 0xffffffff, "WM9701,WM9701A",	NULL,		NULL },
@@ -186,11 +186,11 @@ static const struct ac97_codec_id snd_ac97_codec_ids[] = {
 { 0x83847608, 0xffffffff, "STAC9708,11",	patch_sigmatel_stac9708,	NULL },
 { 0x83847609, 0xffffffff, "STAC9721,23",	patch_sigmatel_stac9721,	NULL },
 { 0x83847644, 0xffffffff, "STAC9744",		patch_sigmatel_stac9744,	NULL },
-{ 0x83847650, 0xffffffff, "STAC9750,51",	NULL,		NULL },	// patch?
-{ 0x83847652, 0xffffffff, "STAC9752,53",	NULL,		NULL }, // patch?
+{ 0x83847650, 0xffffffff, "STAC9750,51",	NULL,		NULL },	/* patch? */
+{ 0x83847652, 0xffffffff, "STAC9752,53",	NULL,		NULL }, /* patch? */
 { 0x83847656, 0xffffffff, "STAC9756,57",	patch_sigmatel_stac9756,	NULL },
 { 0x83847658, 0xffffffff, "STAC9758,59",	patch_sigmatel_stac9758,	NULL },
-{ 0x83847666, 0xffffffff, "STAC9766,67",	NULL,		NULL }, // patch?
+{ 0x83847666, 0xffffffff, "STAC9766,67",	NULL,		NULL }, /* patch? */
 { 0, 	      0,	  NULL,			NULL,		NULL }
 };
 
@@ -274,7 +274,7 @@ EXPORT_SYMBOL(snd_ac97_write);
 
 /**
  * snd_ac97_read - read a value from the given register
- * 
+ *
  * @ac97: the ac97 instance
  * @reg: the register to read
  *
@@ -293,9 +293,9 @@ unsigned short snd_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 /* read a register - return the cached value if already read */
 static inline unsigned short snd_ac97_read_cache(struct snd_ac97 *ac97, unsigned short reg)
 {
-	if (! test_bit(reg, ac97->reg_accessed)) {
+	if (!test_bit(reg, ac97->reg_accessed)) {
 		ac97->regs[reg] = ac97->bus->ops->read(ac97, reg);
-		// set_bit(reg, ac97->reg_accessed);
+		/* set_bit(reg, ac97->reg_accessed); */
 	}
 	return ac97->regs[reg];
 }
@@ -437,11 +437,11 @@ static int snd_ac97_info_enum_double(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_info *uinfo)
 {
 	struct ac97_enum *e = (struct ac97_enum *)kcontrol->private_value;
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = e->shift_l == e->shift_r ? 1 : 2;
 	uinfo->value.enumerated.items = e->mask;
-	
+
 	if (uinfo->value.enumerated.item > e->mask - 1)
 		uinfo->value.enumerated.item = e->mask - 1;
 	strcpy(uinfo->value.enumerated.name, e->texts[uinfo->value.enumerated.item]);
@@ -454,7 +454,7 @@ static int snd_ac97_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
 	struct ac97_enum *e = (struct ac97_enum *)kcontrol->private_value;
 	unsigned short val, bitmask;
-	
+
 	for (bitmask = 1; bitmask < e->mask; bitmask <<= 1)
 		;
 	val = snd_ac97_read_cache(ac97, e->reg);
@@ -472,7 +472,7 @@ static int snd_ac97_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct ac97_enum *e = (struct ac97_enum *)kcontrol->private_value;
 	unsigned short val;
 	unsigned short mask, bitmask;
-	
+
 	for (bitmask = 1; bitmask < e->mask; bitmask <<= 1)
 		;
 	if (ucontrol->value.enumerated.item[0] > e->mask - 1)
@@ -561,7 +561,7 @@ static int snd_ac97_put_volsw(struct snd_kcontrol *kcontrol,
 	int invert = (kcontrol->private_value >> 24) & 0x01;
 	int err, page_save;
 	unsigned short val, val2, val_mask;
-	
+
 	page_save = snd_ac97_page_save(ac97, reg, kcontrol);
 	val = (ucontrol->value.integer.value[0] & mask);
 	if (invert)
@@ -622,8 +622,8 @@ AC97_ENUM_SINGLE(AC97_GENERAL_PURPOSE, 9, 2, std_mix),
 AC97_ENUM_SINGLE(AC97_GENERAL_PURPOSE, 8, 2, std_mic),
 };
 
-static const struct snd_kcontrol_new snd_ac97_control_capture_src = 
-AC97_ENUM("Capture Source", std_enum[0]); 
+static const struct snd_kcontrol_new snd_ac97_control_capture_src =
+AC97_ENUM("Capture Source", std_enum[0]);
 
 static const struct snd_kcontrol_new snd_ac97_control_capture_vol =
 AC97_DOUBLE("Capture Volume", AC97_REC_GAIN, 8, 0, 15, 0);
@@ -690,7 +690,7 @@ static int snd_ac97_spdif_mask_info(struct snd_kcontrol *kcontrol, struct snd_ct
 	uinfo->count = 1;
 	return 0;
 }
-                        
+
 static int snd_ac97_spdif_cmask_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	ucontrol->value.iec958.status[0] = IEC958_AES0_PROFESSIONAL |
@@ -702,7 +702,7 @@ static int snd_ac97_spdif_cmask_get(struct snd_kcontrol *kcontrol, struct snd_ct
 	ucontrol->value.iec958.status[3] = IEC958_AES3_CON_FS;
 	return 0;
 }
-                        
+
 static int snd_ac97_spdif_pmask_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	/* FIXME: AC'97 spec doesn't say which bits are used for what */
@@ -725,7 +725,7 @@ static int snd_ac97_spdif_default_get(struct snd_kcontrol *kcontrol, struct snd_
 	mutex_unlock(&ac97->reg_mutex);
 	return 0;
 }
-                        
+
 static int snd_ac97_spdif_default_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
@@ -752,7 +752,7 @@ static int snd_ac97_spdif_default_put(struct snd_kcontrol *kcontrol, struct snd_
 			val |= 1<<3;
 		if (!(new & IEC958_AES0_CON_NOT_COPYRIGHT))
 			val |= 1<<2;
-		val |= ((new >> 8) & 0xff) << 4;	// category + original
+		val |= ((new >> 8) & 0xff) << 4;	/* category + original */
 		switch ((new >> 24) & 0xff) {
 		case IEC958_AES3_CON_FS_44100: val |= 0<<12; break;
 		case IEC958_AES3_CON_FS_48000: val |= 2<<12; break;
@@ -768,16 +768,16 @@ static int snd_ac97_spdif_default_put(struct snd_kcontrol *kcontrol, struct snd_
 	if (ac97->flags & AC97_CS_SPDIF) {
 		int x = (val >> 12) & 0x03;
 		switch (x) {
-		case 0: x = 1; break;  // 44.1
-		case 2: x = 0; break;  // 48.0
-		default: x = 0; break; // illegal.
+		case 0: x = 1; break;  /* 44.1 */
+		case 2: x = 0; break;  /* 48.0 */
+		default: x = 0; break; /* illegal. */
 		}
 		change |= snd_ac97_update_bits_nolock(ac97, AC97_CSR_SPDIF, 0x3fff, ((val & 0xcfff) | (x << 12)));
 	} else if (ac97->flags & AC97_CX_SPDIF) {
 		int v;
 		v = new & (IEC958_AES0_CON_EMPHASIS_5015|IEC958_AES0_CON_NOT_COPYRIGHT) ? 0 : AC97_CXR_COPYRGT;
 		v |= new & IEC958_AES0_NONAUDIO ? AC97_CXR_SPDIF_AC3 : AC97_CXR_SPDIF_PCM;
-		change |= snd_ac97_update_bits_nolock(ac97, AC97_CXR_AUDIO_MISC, 
+		change |= snd_ac97_update_bits_nolock(ac97, AC97_CXR_AUDIO_MISC,
 						      AC97_CXR_SPDIF_MASK | AC97_CXR_COPYRGT,
 						      v);
 	} else if (ac97->id == AC97_ID_YMF743) {
@@ -806,7 +806,7 @@ static int snd_ac97_put_spsa(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_
 	int reg = kcontrol->private_value & 0xff;
 	int shift = (kcontrol->private_value >> 8) & 0xff;
 	int mask = (kcontrol->private_value >> 16) & 0xff;
-	// int invert = (kcontrol->private_value >> 24) & 0xff;
+	/* int invert = (kcontrol->private_value >> 24) & 0xff; */
 	unsigned short value, old, new;
 	int change;
 
@@ -893,7 +893,7 @@ static int snd_ac97_ad18xx_pcm_get_bits(struct snd_kcontrol *kcontrol, struct sn
 	int lshift = (kcontrol->private_value >> 8) & 0x0f;
 	int rshift = (kcontrol->private_value >> 12) & 0x0f;
 	int mask = (kcontrol->private_value >> 16) & 0xff;
-	
+
 	ucontrol->value.integer.value[0] = mask - ((ac97->spec.ad18xx.pcmreg[codec] >> lshift) & mask);
 	if (lshift != rshift && (ac97->flags & AC97_STEREO_MUTES))
 		ucontrol->value.integer.value[1] = mask - ((ac97->spec.ad18xx.pcmreg[codec] >> rshift) & mask);
@@ -908,7 +908,7 @@ static int snd_ac97_ad18xx_pcm_put_bits(struct snd_kcontrol *kcontrol, struct sn
 	int rshift = (kcontrol->private_value >> 12) & 0x0f;
 	int mask = (kcontrol->private_value >> 16) & 0xff;
 	unsigned short val, valmask;
-	
+
 	val = (mask - (ucontrol->value.integer.value[0] & mask)) << lshift;
 	valmask = mask << lshift;
 	if (lshift != rshift && (ac97->flags & AC97_STEREO_MUTES)) {
@@ -936,7 +936,7 @@ static int snd_ac97_ad18xx_pcm_get_volume(struct snd_kcontrol *kcontrol, struct
 {
 	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
 	int codec = kcontrol->private_value & 3;
-	
+
 	mutex_lock(&ac97->page_mutex);
 	ucontrol->value.integer.value[0] = 31 - ((ac97->spec.ad18xx.pcmreg[codec] >> 0) & 31);
 	ucontrol->value.integer.value[1] = 31 - ((ac97->spec.ad18xx.pcmreg[codec] >> 8) & 31);
@@ -949,7 +949,7 @@ static int snd_ac97_ad18xx_pcm_put_volume(struct snd_kcontrol *kcontrol, struct
 	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
 	int codec = kcontrol->private_value & 3;
 	unsigned short val1, val2;
-	
+
 	val1 = 31 - (ucontrol->value.integer.value[0] & 31);
 	val2 = 31 - (ucontrol->value.integer.value[1] & 31);
 	return snd_ac97_ad18xx_update_pcm_bits(ac97, codec, 0x1f1f, (val1 << 8) | val2);
@@ -1023,11 +1023,11 @@ static int snd_ac97_dev_free(struct snd_device *device)
 	return snd_ac97_free(ac97);
 }
 
-static int snd_ac97_try_volume_mix(struct snd_ac97 * ac97, int reg)
+static int snd_ac97_try_volume_mix(struct snd_ac97 *ac97, int reg)
 {
 	unsigned short val, mask = 0x8000;
 
-	if (! snd_ac97_valid_reg(ac97, reg))
+	if (!snd_ac97_valid_reg(ac97, reg))
 		return 0;
 
 	switch (reg) {
@@ -1092,7 +1092,7 @@ static void check_volume_resolution(struct snd_ac97 *ac97, int reg, unsigned cha
 	}
 
 	*lo_max = *hi_max = 0;
-	for (i = 0 ; i < ARRAY_SIZE(cbit); i++) {
+	for (i = 0; i < ARRAY_SIZE(cbit); i++) {
 		unsigned short val;
 		snd_ac97_write(ac97, reg, 0x8080 | cbit[i] | (cbit[i] << 8));
 		/* Do the read twice due to buffers on some ac97 codecs.
@@ -1110,7 +1110,7 @@ static void check_volume_resolution(struct snd_ac97 *ac97, int reg, unsigned cha
 	}
 }
 
-static int snd_ac97_try_bit(struct snd_ac97 * ac97, int reg, int bit)
+static int snd_ac97_try_bit(struct snd_ac97 *ac97, int reg, int bit)
 {
 	unsigned short mask, val, orig, res;
 
@@ -1124,7 +1124,7 @@ static int snd_ac97_try_bit(struct snd_ac97 * ac97, int reg, int bit)
 }
 
 /* check the volume resolution of center/lfe */
-static void snd_ac97_change_volume_params2(struct snd_ac97 * ac97, int reg, int shift, unsigned char *max)
+static void snd_ac97_change_volume_params2(struct snd_ac97 *ac97, int reg, int shift, unsigned char *max)
 {
 	unsigned short val, val1;
 
@@ -1151,7 +1151,7 @@ static inline int printable(unsigned int x)
 }
 
 static struct snd_kcontrol *snd_ac97_cnew(const struct snd_kcontrol_new *_template,
-					  struct snd_ac97 * ac97)
+					  struct snd_ac97 *ac97)
 {
 	struct snd_kcontrol_new template;
 	memcpy(&template, _template, sizeof(template));
@@ -1170,7 +1170,7 @@ static int snd_ac97_cmute_new_stereo(struct snd_card *card, char *name, int reg,
 	int err;
 	unsigned short val, val1, mute_mask;
 
-	if (! snd_ac97_valid_reg(ac97, reg))
+	if (!snd_ac97_valid_reg(ac97, reg))
 		return 0;
 
 	mute_mask = 0x8000;
@@ -1238,7 +1238,7 @@ static int snd_ac97_cvol_new(struct snd_card *card, char *name, int reg, unsigne
 	int err;
 	struct snd_kcontrol *kctl;
 
-	if (! snd_ac97_valid_reg(ac97, reg))
+	if (!snd_ac97_valid_reg(ac97, reg))
 		return 0;
 	if (hi_max) {
 		/* invert */
@@ -1275,7 +1275,7 @@ static int snd_ac97_cmix_new_stereo(struct snd_card *card, const char *pfx,
 	char name[44];
 	unsigned char lo_max, hi_max;
 
-	if (! snd_ac97_valid_reg(ac97, reg))
+	if (!snd_ac97_valid_reg(ac97, reg))
 		return 0;
 
 	if (snd_ac97_try_bit(ac97, reg, 15)) {
@@ -1301,7 +1301,7 @@ static int snd_ac97_cmix_new_stereo(struct snd_card *card, const char *pfx,
 
 static unsigned int snd_ac97_determine_spdif_rates(struct snd_ac97 *ac97);
 
-static int snd_ac97_mixer_build(struct snd_ac97 * ac97)
+static int snd_ac97_mixer_build(struct snd_ac97 *ac97)
 {
 	struct snd_card *card = ac97->bus->card;
 	struct snd_kcontrol *kctl;
@@ -1325,7 +1325,7 @@ static int snd_ac97_mixer_build(struct snd_ac97 * ac97)
 	ac97->regs[AC97_CENTER_LFE_MASTER] = 0x8080;
 
 	/* build center controls */
-	if ((snd_ac97_try_volume_mix(ac97, AC97_CENTER_LFE_MASTER)) 
+	if ((snd_ac97_try_volume_mix(ac97, AC97_CENTER_LFE_MASTER))
 		&& !(ac97->flags & AC97_AD_MULTI)) {
 		if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_controls_center[0], ac97))) < 0)
 			return err;
@@ -1353,7 +1353,7 @@ static int snd_ac97_mixer_build(struct snd_ac97 * ac97)
 	}
 
 	/* build surround controls */
-	if ((snd_ac97_try_volume_mix(ac97, AC97_SURROUND_MASTER)) 
+	if ((snd_ac97_try_volume_mix(ac97, AC97_SURROUND_MASTER))
 		&& !(ac97->flags & AC97_AD_MULTI)) {
 		/* Surround Master (0x38) is with stereo mutes */
 		if ((err = snd_ac97_cmix_new_stereo(card, "Surround Playback",
@@ -1368,14 +1368,14 @@ static int snd_ac97_mixer_build(struct snd_ac97 * ac97)
 					     AC97_HEADPHONE, 0, ac97)) < 0)
 			return err;
 	}
-	
+
 	/* build master mono controls */
 	if (snd_ac97_try_volume_mix(ac97, AC97_MASTER_MONO)) {
 		if ((err = snd_ac97_cmix_new(card, "Master Mono Playback",
 					     AC97_MASTER_MONO, 0, ac97)) < 0)
 			return err;
 	}
-	
+
 	/* build master tone controls */
 	if (!(ac97->flags & AC97_HAS_NO_TONE)) {
 		if (snd_ac97_try_volume_mix(ac97, AC97_MASTER_TONE)) {
@@ -1391,9 +1391,9 @@ static int snd_ac97_mixer_build(struct snd_ac97 * ac97)
 			snd_ac97_write_cache(ac97, AC97_MASTER_TONE, 0x0f0f);
 		}
 	}
-	
+
 	/* build PC Speaker controls */
-	if (!(ac97->flags & AC97_HAS_NO_PC_BEEP) && 
+	if (!(ac97->flags & AC97_HAS_NO_PC_BEEP) &&
 		((ac97->flags & AC97_HAS_PC_BEEP) ||
 	    snd_ac97_try_volume_mix(ac97, AC97_PC_BEEP))) {
 		for (idx = 0; idx < 2; idx++)
@@ -1403,7 +1403,7 @@ static int snd_ac97_mixer_build(struct snd_ac97 * ac97)
 		snd_ac97_write_cache(ac97, AC97_PC_BEEP,
 				     snd_ac97_read(ac97, AC97_PC_BEEP) | 0x801e);
 	}
-	
+
 	/* build Phone controls */
 	if (!(ac97->flags & AC97_HAS_NO_PHONE)) {
 		if (snd_ac97_try_volume_mix(ac97, AC97_PHONE)) {
@@ -1412,7 +1412,7 @@ static int snd_ac97_mixer_build(struct snd_ac97 * ac97)
 				return err;
 		}
 	}
-	
+
 	/* build MIC controls */
 	if (!(ac97->flags & AC97_HAS_NO_MIC)) {
 		if (snd_ac97_try_volume_mix(ac97, AC97_MIC)) {
@@ -1430,7 +1430,7 @@ static int snd_ac97_mixer_build(struct snd_ac97 * ac97)
 					     AC97_LINE, 1, ac97)) < 0)
 			return err;
 	}
-	
+
 	/* build CD controls */
 	if (!(ac97->flags & AC97_HAS_NO_CD)) {
 		if (snd_ac97_try_volume_mix(ac97, AC97_CD)) {
@@ -1439,7 +1439,7 @@ static int snd_ac97_mixer_build(struct snd_ac97 * ac97)
 				return err;
 		}
 	}
-	
+
 	/* build Video controls */
 	if (!(ac97->flags & AC97_HAS_NO_VIDEO)) {
 		if (snd_ac97_try_volume_mix(ac97, AC97_VIDEO)) {
@@ -1620,7 +1620,7 @@ static int snd_ac97_mixer_build(struct snd_ac97 * ac97)
 		}
 		ac97->spdif_status = SNDRV_PCM_DEFAULT_CON_SPDIF;
 	}
-	
+
 	/* build chip specific controls */
 	if (ac97->build_ops->build_specific)
 		if ((err = ac97->build_ops->build_specific(ac97)) < 0)
@@ -1628,7 +1628,7 @@ static int snd_ac97_mixer_build(struct snd_ac97 * ac97)
 
 	if (snd_ac97_try_bit(ac97, AC97_POWERDOWN, 15)) {
 		kctl = snd_ac97_cnew(&snd_ac97_control_eapd, ac97);
-		if (! kctl)
+		if (!kctl)
 			return -ENOMEM;
 		if (ac97->scaps & AC97_SCAP_INV_EAPD)
 			set_inv_eapd(ac97, kctl);
@@ -1639,11 +1639,11 @@ static int snd_ac97_mixer_build(struct snd_ac97 * ac97)
 	return 0;
 }
 
-static int snd_ac97_modem_build(struct snd_card *card, struct snd_ac97 * ac97)
+static int snd_ac97_modem_build(struct snd_card *card, struct snd_ac97 *ac97)
 {
 	int err, idx;
 
-	//printk("AC97_GPIO_CFG = %x\n",snd_ac97_read(ac97,AC97_GPIO_CFG));
+	/* printk("AC97_GPIO_CFG = %x\n",snd_ac97_read(ac97,AC97_GPIO_CFG)); */
 	snd_ac97_write(ac97, AC97_GPIO_CFG, 0xffff & ~(AC97_GPIO_LINE1_OH));
 	snd_ac97_write(ac97, AC97_GPIO_POLARITY, 0xffff & ~(AC97_GPIO_LINE1_OH));
 	snd_ac97_write(ac97, AC97_GPIO_STICKY, 0xffff);
@@ -1776,15 +1776,15 @@ void snd_ac97_get_name(struct snd_ac97 *ac97, unsigned int id, char *name, int m
 		printable(id >> 16),
 		printable(id >> 8));
 	pid = look_for_codec_id(snd_ac97_codec_id_vendors, id);
-	if (! pid)
+	if (!pid)
 		return;
 
 	strcpy(name, pid->name);
 	if (ac97 && pid->patch) {
 		if ((modem && (pid->flags & AC97_MODEM_PATCH)) ||
-		    (! modem && ! (pid->flags & AC97_MODEM_PATCH)))
+		    (!modem && !(pid->flags & AC97_MODEM_PATCH)))
 			pid->patch(ac97);
-	} 
+	}
 
 	pid = look_for_codec_id(snd_ac97_codec_ids, id);
 	if (pid) {
@@ -1794,7 +1794,7 @@ void snd_ac97_get_name(struct snd_ac97 *ac97, unsigned int id, char *name, int m
 			sprintf(name + strlen(name), " rev %d", id & ~pid->mask);
 		if (ac97 && pid->patch) {
 			if ((modem && (pid->flags & AC97_MODEM_PATCH)) ||
-			    (! modem && ! (pid->flags & AC97_MODEM_PATCH)))
+			    (!modem && !(pid->flags & AC97_MODEM_PATCH)))
 				pid->patch(ac97);
 		}
 	} else
@@ -1829,7 +1829,7 @@ static int ac97_reset_wait(struct snd_ac97 *ac97, int timeout, int with_modem)
 
 	end_time = jiffies + timeout;
 	do {
-		
+
 		/* use preliminary reads to settle the communication */
 		snd_ac97_read(ac97, AC97_RESET);
 		snd_ac97_read(ac97, AC97_VENDOR_ID1);
@@ -1872,7 +1872,7 @@ static int ac97_reset_wait(struct snd_ac97 *ac97, int timeout, int with_modem)
  *
  * The ops table must include valid callbacks (at least read and
  * write).  The other callbacks, wait and reset, are not mandatory.
- * 
+ *
  * The clock is set to 48000.  If another clock is needed, set
  * (*rbus)->clock manually.
  *
@@ -1971,7 +1971,7 @@ static void do_update_power(struct work_struct *work)
  *
  * The template must include the codec number (num) and address (addr),
  * and the private data (private_data).
- * 
+ *
  * The ac97 instance is registered as a low-level device, so you don't
  * have to release it manually.
  *
@@ -2061,10 +2061,10 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 			/* proceed anyway - it's often non-critical */
 		}
 	}
-      __access_ok:
+__access_ok:
 	ac97->id = snd_ac97_read(ac97, AC97_VENDOR_ID1) << 16;
 	ac97->id |= snd_ac97_read(ac97, AC97_VENDOR_ID2);
-	if (! (ac97->scaps & AC97_SCAP_DETECT_BY_VENDOR) &&
+	if (!(ac97->scaps & AC97_SCAP_DETECT_BY_VENDOR) &&
 	    (ac97->id == 0x00000000 || ac97->id == 0xffffffff)) {
 		snd_printk(KERN_ERR "AC'97 %d access is not valid [0x%x], removing mixer.\n", ac97->num, ac97->id);
 		snd_ac97_free(ac97);
@@ -2073,7 +2073,7 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 	pid = look_for_codec_id(snd_ac97_codec_ids, ac97->id);
 	if (pid)
 		ac97->flags |= pid->flags;
-	
+
 	/* test for AC'97 */
 	if (!(ac97->scaps & AC97_SCAP_SKIP_AUDIO) && !(ac97->scaps & AC97_SCAP_AUDIO)) {
 		/* test if we can write to the record gain volume register */
@@ -2104,14 +2104,14 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 		return -EACCES;
 	}
 
-	if (bus->ops->reset) // FIXME: always skipping?
+	if (bus->ops->reset) /* FIXME: always skipping? */
 		goto __ready_ok;
 
 	/* FIXME: add powerdown control */
 	if (ac97_is_audio(ac97)) {
 		/* nothing should be in powerdown mode */
 		snd_ac97_write_cache(ac97, AC97_POWERDOWN, 0);
-		if (! (ac97->flags & AC97_DEFAULT_POWER_OFF)) {
+		if (!(ac97->flags & AC97_DEFAULT_POWER_OFF)) {
 			snd_ac97_write_cache(ac97, AC97_RESET, 0); /* reset to defaults */
 			udelay(100);
 			snd_ac97_write_cache(ac97, AC97_POWERDOWN, 0);
@@ -2158,8 +2158,8 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 		} while (time_after_eq(end_time, jiffies));
 		snd_printk(KERN_WARNING "MC'97 %d converters and GPIO not ready (0x%x)\n", ac97->num, snd_ac97_read(ac97, AC97_EXTENDED_MSTATUS));
 	}
-	
-      __ready_ok:
+
+__ready_ok:
 	if (ac97_is_audio(ac97))
 		ac97->addr = (ac97->ext_id & AC97_EI_ADDR_MASK) >> AC97_EI_ADDR_SHIFT;
 	else
@@ -2167,7 +2167,7 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 	if (ac97->ext_id & 0x01c9) {	/* L/R, MIC, SDAC, LDAC VRA support */
 		reg = snd_ac97_read(ac97, AC97_EXTENDED_STATUS);
 		reg |= ac97->ext_id & 0x01c0; /* LDAC/SDAC/CDAC */
-		if (! bus->no_vra)
+		if (!bus->no_vra)
 			reg |= ac97->ext_id & 0x0009; /* VRA/VRM */
 		snd_ac97_write_cache(ac97, AC97_EXTENDED_STATUS, reg);
 	}
@@ -2210,8 +2210,8 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 	if (bus->ops->init)
 		bus->ops->init(ac97);
 	snd_ac97_get_name(ac97, ac97->id, name, !ac97_is_audio(ac97));
-	snd_ac97_get_name(NULL, ac97->id, name, !ac97_is_audio(ac97));  // ac97->id might be changed in the special setup code
-	if (! ac97->build_ops)
+	snd_ac97_get_name(NULL, ac97->id, name, !ac97_is_audio(ac97));  /* ac97->id might be changed in the special setup code */
+	if (!ac97->build_ops)
 		ac97->build_ops = &null_build_ops;
 
 	if (ac97_is_audio(ac97)) {
@@ -2295,7 +2295,7 @@ static void snd_ac97_powerdown(struct snd_ac97 *ac97)
 	/* powerdown external amplifier */
 	if (ac97->scaps & AC97_SCAP_INV_EAPD)
 		power = ac97->regs[AC97_POWERDOWN] & ~AC97_PD_EAPD;
-	else if (! (ac97->scaps & AC97_SCAP_EAPD_LED))
+	else if (!(ac97->scaps & AC97_SCAP_EAPD_LED))
 		power = ac97->regs[AC97_POWERDOWN] | AC97_PD_EAPD;
 	power |= AC97_PD_PR6;	/* Headphone amplifier powerdown */
 	power |= AC97_PD_PR0 | AC97_PD_PR1;	/* ADC & DAC powerdown */
@@ -2347,7 +2347,7 @@ int snd_ac97_update_power(struct snd_ac97 *ac97, int reg, int powerup)
 {
 	int i;
 
-	if (! ac97)
+	if (!ac97)
 		return 0;
 
 	if (reg) {
@@ -2416,8 +2416,8 @@ static void update_power_regs(struct snd_ac97 *ac97)
 		snd_ac97_update_bits(ac97, power_regs[i].power_reg,
 				     power_regs[i].mask, bits);
 	}
-	if (! power_up) {
-		if (! (ac97->regs[AC97_POWERDOWN] & AC97_PD_PR2)) {
+	if (!power_up) {
+		if (!(ac97->regs[AC97_POWERDOWN] & AC97_PD_PR2)) {
 			/* power down analog mix and vref */
 			snd_ac97_update_bits(ac97, AC97_POWERDOWN,
 					     AC97_PD_PR2, AC97_PD_PR2);
@@ -2437,7 +2437,7 @@ static void update_power_regs(struct snd_ac97 *ac97)
  */
 void snd_ac97_suspend(struct snd_ac97 *ac97)
 {
-	if (! ac97)
+	if (!ac97)
 		return;
 	if (ac97->build_ops->suspend)
 		ac97->build_ops->suspend(ac97);
@@ -2457,7 +2457,7 @@ static void snd_ac97_restore_status(struct snd_ac97 *ac97)
 {
 	int i;
 
-	for (i = 2; i < 0x7c ; i += 2) {
+	for (i = 2; i < 0x7c; i += 2) {
 		if (i == AC97_POWERDOWN || i == AC97_EXTENDED_ID)
 			continue;
 		/* restore only accessible registers
@@ -2501,7 +2501,7 @@ void snd_ac97_resume(struct snd_ac97 *ac97)
 {
 	unsigned long end_time;
 
-	if (! ac97)
+	if (!ac97)
 		return;
 
 	if (ac97->bus->ops->reset) {
@@ -2510,7 +2510,7 @@ void snd_ac97_resume(struct snd_ac97 *ac97)
 	}
 
 	snd_ac97_write(ac97, AC97_POWERDOWN, 0);
-	if (! (ac97->flags & AC97_DEFAULT_POWER_OFF)) {
+	if (!(ac97->flags & AC97_DEFAULT_POWER_OFF)) {
 		if (!(ac97->scaps & AC97_SCAP_SKIP_AUDIO))
 			snd_ac97_write(ac97, AC97_RESET, 0);
 		else if (!(ac97->scaps & AC97_SCAP_SKIP_MODEM))
@@ -2568,7 +2568,7 @@ static void set_ctl_name(char *dst, const char *src, const char *suffix)
 		sprintf(dst, "%s %s", src, suffix);
 	else
 		strcpy(dst, src);
-}	
+}
 
 /* remove the control with the given name and optional suffix */
 static int snd_ac97_remove_ctl(struct snd_ac97 *ac97, const char *name,
@@ -2644,7 +2644,7 @@ static int tune_hp_only(struct snd_ac97 *ac97)
 {
 	struct snd_kcontrol *msw = ctl_find(ac97, "Master Playback Switch", NULL);
 	struct snd_kcontrol *mvol = ctl_find(ac97, "Master Playback Volume", NULL);
-	if (! msw || ! mvol)
+	if (!msw || !mvol)
 		return -ENOENT;
 	msw->put = bind_hp_volsw_put;
 	mvol->put = bind_hp_volsw_put;
@@ -2699,7 +2699,7 @@ static int tune_ad_sharing(struct snd_ac97 *ac97)
 	return 0;
 }
 
-static const struct snd_kcontrol_new snd_ac97_alc_jack_detect = 
+static const struct snd_kcontrol_new snd_ac97_alc_jack_detect =
 AC97_SINGLE("Jack Detect", AC97_ALC650_CLOCK, 5, 1, 0);
 
 /* ac97 tune: set up ALC jack-select */
@@ -2720,7 +2720,7 @@ static int tune_alc_jack(struct snd_ac97 *ac97)
 static int tune_inv_eapd(struct snd_ac97 *ac97)
 {
 	struct snd_kcontrol *kctl = ctl_find(ac97, "External Amplifier", NULL);
-	if (! kctl)
+	if (!kctl)
 		return -ENOENT;
 	set_inv_eapd(ac97, kctl);
 	return 0;
@@ -2749,7 +2749,7 @@ static int master_mute_sw_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem
 static int tune_mute_led(struct snd_ac97 *ac97)
 {
 	struct snd_kcontrol *msw = ctl_find(ac97, "Master Playback Switch", NULL);
-	if (! msw)
+	if (!msw)
 		return -ENOENT;
 	msw->put = master_mute_sw_put;
 	snd_ac97_remove_ctl(ac97, "External Amplifier", NULL);
@@ -2782,7 +2782,7 @@ static int tune_hp_mute_led(struct snd_ac97 *ac97)
 {
 	struct snd_kcontrol *msw = ctl_find(ac97, "Master Playback Switch", NULL);
 	struct snd_kcontrol *mvol = ctl_find(ac97, "Master Playback Volume", NULL);
-	if (! msw || ! mvol)
+	if (!msw || !mvol)
 		return -ENOENT;
 	msw->put = hp_master_mute_sw_put;
 	mvol->put = bind_hp_volsw_put;
@@ -2830,7 +2830,7 @@ static int apply_quirk_str(struct snd_ac97 *ac97, const char *typestr)
 
 	for (i = 0; i < ARRAY_SIZE(applicable_quirks); i++) {
 		q = &applicable_quirks[i];
-		if (q->name && ! strcmp(typestr, q->name))
+		if (q->name && !strcmp(typestr, q->name))
 			return apply_quirk(ac97, i);
 	}
 	/* for compatibility, accept the numbers, too */
@@ -2864,13 +2864,13 @@ int snd_ac97_tune_hardware(struct snd_ac97 *ac97, struct ac97_quirk *quirk, cons
 		return result;
 	}
 
-	if (! quirk)
+	if (!quirk)
 		return -EINVAL;
 
 	for (; quirk->subvendor; quirk++) {
 		if (quirk->subvendor != ac97->subsystem_vendor)
 			continue;
-		if ((! quirk->mask && quirk->subdevice == ac97->subsystem_device) ||
+		if ((!quirk->mask && quirk->subdevice == ac97->subsystem_device) ||
 		    quirk->subdevice == (quirk->mask & ac97->subsystem_device)) {
 			if (quirk->codec_id && quirk->codec_id != ac97->id)
 				continue;
diff --git a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
index 6ce3cbe..19e8572 100644
--- a/sound/pci/ac97/ac97_patch.c
+++ b/sound/pci/ac97/ac97_patch.c
@@ -30,7 +30,7 @@
  *  Chip specific initialization
  */
 
-static int patch_build_controls(struct snd_ac97 * ac97, const struct snd_kcontrol_new *controls, int count)
+static int patch_build_controls(struct snd_ac97 *ac97, const struct snd_kcontrol_new *controls, int count)
 {
 	int idx, err;
 
@@ -446,7 +446,7 @@ static const struct snd_kcontrol_new snd_ac97_ymf753_controls_spdif[3] = {
 		    AC97_YMF7X3_DIT_CTRL, 2, 1, 1)
 };
 
-static int patch_yamaha_ymf753_post_spdif(struct snd_ac97 * ac97)
+static int patch_yamaha_ymf753_post_spdif(struct snd_ac97 *ac97)
 {
 	int err;
 
@@ -460,7 +460,7 @@ static struct snd_ac97_build_ops patch_yamaha_ymf753_ops = {
 	.build_post_spdif = patch_yamaha_ymf753_post_spdif
 };
 
-static int patch_yamaha_ymf753(struct snd_ac97 * ac97)
+static int patch_yamaha_ymf753(struct snd_ac97 *ac97)
 {
 	/* Patch for Yamaha YMF753, Copyright (c) by David Shust, dshust@shustring.com.
 	   This chip has nonstandard and extended behaviour with regard to its S/PDIF output.
@@ -486,14 +486,14 @@ AC97_DOUBLE("Front Playback Volume", AC97_WM97XX_FMIXER_VOL, 8, 0, 31, 1),
 AC97_SINGLE("Front Playback Switch", AC97_WM97XX_FMIXER_VOL, 15, 1, 1),
 };
 
-static int patch_wolfson_wm9703_specific(struct snd_ac97 * ac97)
+static int patch_wolfson_wm9703_specific(struct snd_ac97 *ac97)
 {
 	/* This is known to work for the ViewSonic ViewPad 1000
 	 * Randolph Bentson <bentson@holmsjoen.com>
-	 * WM9703/9707/9708/9717 
+	 * WM9703/9707/9708/9717
 	 */
 	int err, i;
-	
+
 	for (i = 0; i < ARRAY_SIZE(wm97xx_snd_ac97_controls); i++) {
 		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm97xx_snd_ac97_controls[i], ac97))) < 0)
 			return err;
@@ -506,7 +506,7 @@ static struct snd_ac97_build_ops patch_wolfson_wm9703_ops = {
 	.build_specific = patch_wolfson_wm9703_specific,
 };
 
-static int patch_wolfson03(struct snd_ac97 * ac97)
+static int patch_wolfson03(struct snd_ac97 *ac97)
 {
 	ac97->build_ops = &patch_wolfson_wm9703_ops;
 	return 0;
@@ -521,7 +521,7 @@ AC97_DOUBLE("Rear DAC Volume", AC97_WM9704_RPCM_VOL, 8, 0, 31, 1),
 AC97_DOUBLE("Surround Volume", AC97_SURROUND_MASTER, 8, 0, 31, 1),
 };
 
-static int patch_wolfson_wm9704_specific(struct snd_ac97 * ac97)
+static int patch_wolfson_wm9704_specific(struct snd_ac97 *ac97)
 {
 	int err, i;
 	for (i = 0; i < ARRAY_SIZE(wm9704_snd_ac97_controls); i++) {
@@ -537,14 +537,14 @@ static struct snd_ac97_build_ops patch_wolfson_wm9704_ops = {
 	.build_specific = patch_wolfson_wm9704_specific,
 };
 
-static int patch_wolfson04(struct snd_ac97 * ac97)
+static int patch_wolfson04(struct snd_ac97 *ac97)
 {
 	/* WM9704M/9704Q */
 	ac97->build_ops = &patch_wolfson_wm9704_ops;
 	return 0;
 }
 
-static int patch_wolfson_wm9705_specific(struct snd_ac97 * ac97)
+static int patch_wolfson_wm9705_specific(struct snd_ac97 *ac97)
 {
 	int err, i;
 	for (i = 0; i < ARRAY_SIZE(wm97xx_snd_ac97_controls); i++) {
@@ -559,7 +559,7 @@ static struct snd_ac97_build_ops patch_wolfson_wm9705_ops = {
 	.build_specific = patch_wolfson_wm9705_specific,
 };
 
-static int patch_wolfson05(struct snd_ac97 * ac97)
+static int patch_wolfson05(struct snd_ac97 *ac97)
 {
 	/* WM9705, WM9710 */
 	ac97->build_ops = &patch_wolfson_wm9705_ops;
@@ -578,7 +578,7 @@ static const char* wm9711_rec_adc[] = {"Stereo", "Left", "Right", "Mute"};
 static const char* wm9711_base[] = {"Linear Control", "Adaptive Boost"};
 static const char* wm9711_rec_gain[] = {"+1.5dB Steps", "+0.75dB Steps"};
 static const char* wm9711_mic[] = {"Mic 1", "Differential", "Mic 2", "Stereo"};
-static const char* wm9711_rec_sel[] = 
+static const char* wm9711_rec_sel[] =
 	{"Mic 1", "NC", "NC", "Master Mix", "Line", "Headphone Mix", "Phone Mix", "Phone"};
 static const char* wm9711_ng_type[] = {"Constant Gain", "Mute"};
 
@@ -675,10 +675,10 @@ AC97_SINGLE("Headphone ZC Switch", AC97_HEADPHONE, 7, 1, 0),
 AC97_SINGLE("Mono ZC Switch", AC97_MASTER_MONO, 7, 1, 0),
 };
 
-static int patch_wolfson_wm9711_specific(struct snd_ac97 * ac97)
+static int patch_wolfson_wm9711_specific(struct snd_ac97 *ac97)
 {
 	int err, i;
-	
+
 	for (i = 0; i < ARRAY_SIZE(wm9711_snd_ac97_controls); i++) {
 		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm9711_snd_ac97_controls[i], ac97))) < 0)
 			return err;
@@ -696,32 +696,32 @@ static struct snd_ac97_build_ops patch_wolfson_wm9711_ops = {
 	.build_specific = patch_wolfson_wm9711_specific,
 };
 
-static int patch_wolfson11(struct snd_ac97 * ac97)
+static int patch_wolfson11(struct snd_ac97 *ac97)
 {
 	/* WM9711, WM9712 */
 	ac97->build_ops = &patch_wolfson_wm9711_ops;
 
 	ac97->flags |= AC97_HAS_NO_REC_GAIN | AC97_STEREO_MUTES | AC97_HAS_NO_MIC |
 		AC97_HAS_NO_PC_BEEP | AC97_HAS_NO_VIDEO | AC97_HAS_NO_CD;
-	
+
 	return 0;
 }
 
 static const char* wm9713_mic_mixer[] = {"Stereo", "Mic 1", "Mic 2", "Mute"};
 static const char* wm9713_rec_mux[] = {"Stereo", "Left", "Right", "Mute"};
-static const char* wm9713_rec_src[] = 
-	{"Mic 1", "Mic 2", "Line", "Mono In", "Headphone Mix", "Master Mix", 
+static const char* wm9713_rec_src[] =
+	{"Mic 1", "Mic 2", "Line", "Mono In", "Headphone Mix", "Master Mix",
 	"Mono Mix", "Zh"};
 static const char* wm9713_rec_gain[] = {"+1.5dB Steps", "+0.75dB Steps"};
 static const char* wm9713_alc_select[] = {"None", "Left", "Right", "Stereo"};
 static const char* wm9713_mono_pga[] = {"Vmid", "Zh", "Mono Mix", "Inv 1"};
-static const char* wm9713_spk_pga[] = 
+static const char* wm9713_spk_pga[] =
 	{"Vmid", "Zh", "Headphone Mix", "Master Mix", "Inv", "NC", "NC", "NC"};
 static const char* wm9713_hp_pga[] = {"Vmid", "Zh", "Headphone Mix", "NC"};
 static const char* wm9713_out3_pga[] = {"Vmid", "Zh", "Inv 1", "NC"};
 static const char* wm9713_out4_pga[] = {"Vmid", "Zh", "Inv 2", "NC"};
-static const char* wm9713_dac_inv[] = 
-	{"Off", "Mono Mix", "Master Mix", "Headphone Mix L", "Headphone Mix R", 
+static const char* wm9713_dac_inv[] =
+	{"Off", "Mono Mix", "Master Mix", "Headphone Mix L", "Headphone Mix R",
 	"Headphone Mix Mono", "NC", "Vmid"};
 static const char* wm9713_base[] = {"Linear Control", "Adaptive Boost"};
 static const char* wm9713_ng_type[] = {"Constant Gain", "Mute"};
@@ -842,10 +842,10 @@ AC97_SINGLE("3D Lower Cut-off Switch", AC97_REC_GAIN_MIC, 4, 1, 0),
 AC97_SINGLE("3D Depth", AC97_REC_GAIN_MIC, 0, 15, 1),
 };
 
-static int patch_wolfson_wm9713_3d (struct snd_ac97 * ac97)
+static int patch_wolfson_wm9713_3d(struct snd_ac97 *ac97)
 {
 	int err, i;
-    
+
 	for (i = 0; i < ARRAY_SIZE(wm13_snd_ac97_controls_3d); i++) {
 		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm13_snd_ac97_controls_3d[i], ac97))) < 0)
 			return err;
@@ -853,10 +853,10 @@ static int patch_wolfson_wm9713_3d (struct snd_ac97 * ac97)
 	return 0;
 }
 
-static int patch_wolfson_wm9713_specific(struct snd_ac97 * ac97)
+static int patch_wolfson_wm9713_specific(struct snd_ac97 *ac97)
 {
 	int err, i;
-	
+
 	for (i = 0; i < ARRAY_SIZE(wm13_snd_ac97_controls); i++) {
 		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm13_snd_ac97_controls[i], ac97))) < 0)
 			return err;
@@ -872,13 +872,13 @@ static int patch_wolfson_wm9713_specific(struct snd_ac97 * ac97)
 }
 
 #ifdef CONFIG_PM
-static void patch_wolfson_wm9713_suspend (struct snd_ac97 * ac97)
+static void patch_wolfson_wm9713_suspend(struct snd_ac97 *ac97)
 {
 	snd_ac97_write_cache(ac97, AC97_EXTENDED_MID, 0xfeff);
 	snd_ac97_write_cache(ac97, AC97_EXTENDED_MSTATUS, 0xffff);
 }
 
-static void patch_wolfson_wm9713_resume (struct snd_ac97 * ac97)
+static void patch_wolfson_wm9713_resume(struct snd_ac97 *ac97)
 {
 	snd_ac97_write_cache(ac97, AC97_EXTENDED_MID, 0xda00);
 	snd_ac97_write_cache(ac97, AC97_EXTENDED_MSTATUS, 0x3810);
@@ -889,13 +889,13 @@ static void patch_wolfson_wm9713_resume (struct snd_ac97 * ac97)
 static struct snd_ac97_build_ops patch_wolfson_wm9713_ops = {
 	.build_specific = patch_wolfson_wm9713_specific,
 	.build_3d = patch_wolfson_wm9713_3d,
-#ifdef CONFIG_PM	
+#ifdef CONFIG_PM
 	.suspend = patch_wolfson_wm9713_suspend,
 	.resume = patch_wolfson_wm9713_resume
 #endif
 };
 
-static int patch_wolfson13(struct snd_ac97 * ac97)
+static int patch_wolfson13(struct snd_ac97 *ac97)
 {
 	/* WM9713, WM9714 */
 	ac97->build_ops = &patch_wolfson_wm9713_ops;
@@ -915,7 +915,7 @@ static int patch_wolfson13(struct snd_ac97 * ac97)
 /*
  * Tritech codec
  */
-static int patch_tritech_tr28028(struct snd_ac97 * ac97)
+static int patch_tritech_tr28028(struct snd_ac97 *ac97)
 {
 	snd_ac97_write_cache(ac97, 0x26, 0x0300);
 	snd_ac97_write_cache(ac97, 0x26, 0x0000);
@@ -927,7 +927,7 @@ static int patch_tritech_tr28028(struct snd_ac97 * ac97)
 /*
  * Sigmatel STAC97xx codecs
  */
-static int patch_sigmatel_stac9700_3d(struct snd_ac97 * ac97)
+static int patch_sigmatel_stac9700_3d(struct snd_ac97 *ac97)
 {
 	struct snd_kcontrol *kctl;
 	int err;
@@ -940,7 +940,7 @@ static int patch_sigmatel_stac9700_3d(struct snd_ac97 * ac97)
 	return 0;
 }
 
-static int patch_sigmatel_stac9708_3d(struct snd_ac97 * ac97)
+static int patch_sigmatel_stac9708_3d(struct snd_ac97 *ac97)
 {
 	struct snd_kcontrol *kctl;
 	int err;
@@ -968,7 +968,7 @@ AC97_SINGLE("Sigmatel DAC 6dB Attenuate", AC97_SIGMATEL_ANALOG, 1, 1, 0),
 AC97_SINGLE("Sigmatel ADC 6dB Attenuate", AC97_SIGMATEL_ANALOG, 0, 1, 0)
 };
 
-static int patch_sigmatel_stac97xx_specific(struct snd_ac97 * ac97)
+static int patch_sigmatel_stac97xx_specific(struct snd_ac97 *ac97)
 {
 	int err;
 
@@ -993,7 +993,7 @@ static struct snd_ac97_build_ops patch_sigmatel_stac9700_ops = {
 	.build_specific	= patch_sigmatel_stac97xx_specific
 };
 
-static int patch_sigmatel_stac9700(struct snd_ac97 * ac97)
+static int patch_sigmatel_stac9700(struct snd_ac97 *ac97)
 {
 	ac97->build_ops = &patch_sigmatel_stac9700_ops;
 	return 0;
@@ -1040,7 +1040,7 @@ static struct snd_ac97_build_ops patch_sigmatel_stac9708_ops = {
 	.build_specific	= patch_sigmatel_stac9708_specific
 };
 
-static int patch_sigmatel_stac9708(struct snd_ac97 * ac97)
+static int patch_sigmatel_stac9708(struct snd_ac97 *ac97)
 {
 	unsigned int codec72, codec6c;
 
@@ -1066,11 +1066,11 @@ static int patch_sigmatel_stac9708(struct snd_ac97 * ac97)
 	return 0;
 }
 
-static int patch_sigmatel_stac9721(struct snd_ac97 * ac97)
+static int patch_sigmatel_stac9721(struct snd_ac97 *ac97)
 {
 	ac97->build_ops = &patch_sigmatel_stac9700_ops;
 	if (snd_ac97_read(ac97, AC97_SIGMATEL_ANALOG) == 0) {
-		// patch for SigmaTel
+		/* patch for SigmaTel */
 		snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC1, 0xabba);
 		snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC2, 0x4000);
 		snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS1, 0xabba);
@@ -1080,9 +1080,9 @@ static int patch_sigmatel_stac9721(struct snd_ac97 * ac97)
 	return 0;
 }
 
-static int patch_sigmatel_stac9744(struct snd_ac97 * ac97)
+static int patch_sigmatel_stac9744(struct snd_ac97 *ac97)
 {
-	// patch for SigmaTel
+	/* patch for SigmaTel */
 	ac97->build_ops = &patch_sigmatel_stac9700_ops;
 	snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC1, 0xabba);
 	snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC2, 0x0000);	/* is this correct? --jk */
@@ -1092,9 +1092,9 @@ static int patch_sigmatel_stac9744(struct snd_ac97 * ac97)
 	return 0;
 }
 
-static int patch_sigmatel_stac9756(struct snd_ac97 * ac97)
+static int patch_sigmatel_stac9756(struct snd_ac97 *ac97)
 {
-	// patch for SigmaTel
+	/* patch for SigmaTel */
 	ac97->build_ops = &patch_sigmatel_stac9700_ops;
 	snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC1, 0xabba);
 	snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC2, 0x0000);	/* is this correct? --jk */
@@ -1269,7 +1269,7 @@ static struct snd_ac97_build_ops patch_sigmatel_stac9758_ops = {
 	.build_specific	= patch_sigmatel_stac9758_specific
 };
 
-static int patch_sigmatel_stac9758(struct snd_ac97 * ac97)
+static int patch_sigmatel_stac9758(struct snd_ac97 *ac97)
 {
 	static unsigned short regs[4] = {
 		AC97_SIGMATEL_OUTSEL,
@@ -1293,12 +1293,12 @@ static int patch_sigmatel_stac9758(struct snd_ac97 * ac97)
 	int i;
 
 	/* Gateway M675 notebook */
-	if (ac97->pci && 
+	if (ac97->pci &&
 	    ac97->subsystem_vendor == 0x107b &&
 	    ac97->subsystem_device == 0x0601)
 	    	pregs = m675_regs;
 
-	// patch for SigmaTel
+	/* patch for SigmaTel */
 	ac97->build_ops = &patch_sigmatel_stac9758_ops;
 	/* FIXME: assume only page 0 for writing cache */
 	snd_ac97_update_bits(ac97, AC97_INT_PAGING, AC97_PAGE_MASK, AC97_PAGE_VENDOR);
@@ -1317,7 +1317,7 @@ static const struct snd_kcontrol_new snd_ac97_cirrus_controls_spdif[2] = {
 	AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "AC97-SPSA", AC97_CSR_ACMODE, 0, 3, 0)
 };
 
-static int patch_cirrus_build_spdif(struct snd_ac97 * ac97)
+static int patch_cirrus_build_spdif(struct snd_ac97 *ac97)
 {
 	int err;
 
@@ -1343,7 +1343,7 @@ static struct snd_ac97_build_ops patch_cirrus_ops = {
 	.build_spdif = patch_cirrus_build_spdif
 };
 
-static int patch_cirrus_spdif(struct snd_ac97 * ac97)
+static int patch_cirrus_spdif(struct snd_ac97 *ac97)
 {
 	/* Basically, the cs4201/cs4205/cs4297a has non-standard sp/dif registers.
 	   WHY CAN'T ANYONE FOLLOW THE BLOODY SPEC?  *sigh*
@@ -1357,18 +1357,18 @@ static int patch_cirrus_spdif(struct snd_ac97 * ac97)
 	*/
 
 	ac97->build_ops = &patch_cirrus_ops;
-	ac97->flags |= AC97_CS_SPDIF; 
+	ac97->flags |= AC97_CS_SPDIF;
 	ac97->rates[AC97_RATES_SPDIF] &= ~SNDRV_PCM_RATE_32000;
         ac97->ext_id |= AC97_EI_SPDIF;	/* force the detection of spdif */
 	snd_ac97_write_cache(ac97, AC97_CSR_ACMODE, 0x0080);
 	return 0;
 }
 
-static int patch_cirrus_cs4299(struct snd_ac97 * ac97)
+static int patch_cirrus_cs4299(struct snd_ac97 *ac97)
 {
 	/* force the detection of PC Beep */
 	ac97->flags |= AC97_HAS_PC_BEEP;
-	
+
 	return patch_cirrus_spdif(ac97);
 }
 
@@ -1379,7 +1379,7 @@ static const struct snd_kcontrol_new snd_ac97_conexant_controls_spdif[1] = {
 	AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",PLAYBACK,SWITCH), AC97_CXR_AUDIO_MISC, 3, 1, 0),
 };
 
-static int patch_conexant_build_spdif(struct snd_ac97 * ac97)
+static int patch_conexant_build_spdif(struct snd_ac97 *ac97)
 {
 	int err;
 
@@ -1400,7 +1400,7 @@ static struct snd_ac97_build_ops patch_conexant_ops = {
 	.build_spdif = patch_conexant_build_spdif
 };
 
-static int patch_conexant(struct snd_ac97 * ac97)
+static int patch_conexant(struct snd_ac97 *ac97)
 {
 	ac97->build_ops = &patch_conexant_ops;
 	ac97->flags |= AC97_CX_SPDIF;
@@ -1434,13 +1434,13 @@ static void ad18xx_resume(struct snd_ac97 *ac97)
 		}
 	}
 
-	if (! (ac97->flags & AC97_AD_MULTI))
+	if (!(ac97->flags & AC97_AD_MULTI))
 		/* normal restore */
 		snd_ac97_restore_status(ac97);
 	else {
 		/* restore the AD18xx codec configurations */
 		for (codec = 0; codec < 3; codec++) {
-			if (! ac97->spec.ad18xx.id[codec])
+			if (!ac97->spec.ad18xx.id[codec])
 				continue;
 			/* select single codec */
 			snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 0x7000,
@@ -1451,14 +1451,14 @@ static void ad18xx_resume(struct snd_ac97 *ac97)
 		snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 0x7000, 0x7000);
 
 		/* restore status */
-		for (i = 2; i < 0x7c ; i += 2) {
+		for (i = 2; i < 0x7c; i += 2) {
 			if (i == AC97_POWERDOWN || i == AC97_EXTENDED_ID)
 				continue;
 			if (test_bit(i, ac97->reg_accessed)) {
 				/* handle multi codecs for AD18xx */
 				if (i == AC97_PCM) {
 					for (codec = 0; codec < 3; codec++) {
-						if (! ac97->spec.ad18xx.id[codec])
+						if (!ac97->spec.ad18xx.id[codec])
 							continue;
 						/* select single codec */
 						snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 0x7000,
@@ -1501,22 +1501,22 @@ static const struct snd_ac97_res_table ad1819_restbl[] = {
 	{ } /* terminator */
 };
 
-static int patch_ad1819(struct snd_ac97 * ac97)
+static int patch_ad1819(struct snd_ac97 *ac97)
 {
 	unsigned short scfg;
 
-	// patch for Analog Devices
+	/* patch for Analog Devices */
 	scfg = snd_ac97_read(ac97, AC97_AD_SERIAL_CFG);
 	snd_ac97_write_cache(ac97, AC97_AD_SERIAL_CFG, scfg | 0x7000); /* select all codecs */
 	ac97->res_table = ad1819_restbl;
 	return 0;
 }
 
-static unsigned short patch_ad1881_unchained(struct snd_ac97 * ac97, int idx, unsigned short mask)
+static unsigned short patch_ad1881_unchained(struct snd_ac97 *ac97, int idx, unsigned short mask)
 {
 	unsigned short val;
 
-	// test for unchained codec
+	/* test for unchained codec */
 	snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 0x7000, mask);
 	snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0000);	/* ID0C, ID1C, SDIE = off */
 	val = snd_ac97_read(ac97, AC97_VENDOR_ID2);
@@ -1528,13 +1528,13 @@ static unsigned short patch_ad1881_unchained(struct snd_ac97 * ac97, int idx, un
 	return mask;
 }
 
-static int patch_ad1881_chained1(struct snd_ac97 * ac97, int idx, unsigned short codec_bits)
+static int patch_ad1881_chained1(struct snd_ac97 *ac97, int idx, unsigned short codec_bits)
 {
 	static int cfg_bits[3] = { 1<<12, 1<<14, 1<<13 };
 	unsigned short val;
-	
+
 	snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 0x7000, cfg_bits[idx]);
-	snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0004);	// SDIE
+	snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0004);	/* SDIE */
 	val = snd_ac97_read(ac97, AC97_VENDOR_ID2);
 	if ((val & 0xff40) != 0x5340)
 		return 0;
@@ -1546,26 +1546,26 @@ static int patch_ad1881_chained1(struct snd_ac97 * ac97, int idx, unsigned short
 	return 1;
 }
 
-static void patch_ad1881_chained(struct snd_ac97 * ac97, int unchained_idx, int cidx1, int cidx2)
+static void patch_ad1881_chained(struct snd_ac97 *ac97, int unchained_idx, int cidx1, int cidx2)
 {
-	// already detected?
+	/* already detected? */
 	if (ac97->spec.ad18xx.unchained[cidx1] || ac97->spec.ad18xx.chained[cidx1])
 		cidx1 = -1;
 	if (ac97->spec.ad18xx.unchained[cidx2] || ac97->spec.ad18xx.chained[cidx2])
 		cidx2 = -1;
 	if (cidx1 < 0 && cidx2 < 0)
 		return;
-	// test for chained codecs
+	/* test for chained codecs */
 	snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 0x7000,
 			     ac97->spec.ad18xx.unchained[unchained_idx]);
-	snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0002);		// ID1C
+	snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0002);		/* ID1C */
 	ac97->spec.ad18xx.codec_cfg[unchained_idx] = 0x0002;
 	if (cidx1 >= 0) {
 		if (cidx2 < 0)
 			patch_ad1881_chained1(ac97, cidx1, 0);
-		else if (patch_ad1881_chained1(ac97, cidx1, 0x0006))	// SDIE | ID1C
+		else if (patch_ad1881_chained1(ac97, cidx1, 0x0006))	/* SDIE | ID1C */
 			patch_ad1881_chained1(ac97, cidx2, 0);
-		else if (patch_ad1881_chained1(ac97, cidx2, 0x0006))	// SDIE | ID1C
+		else if (patch_ad1881_chained1(ac97, cidx2, 0x0006))	/* SDIE | ID1C */
 			patch_ad1881_chained1(ac97, cidx1, 0);
 	} else if (cidx2 >= 0) {
 		patch_ad1881_chained1(ac97, cidx2, 0);
@@ -1578,15 +1578,15 @@ static struct snd_ac97_build_ops patch_ad1881_build_ops = {
 #endif
 };
 
-static int patch_ad1881(struct snd_ac97 * ac97)
+static int patch_ad1881(struct snd_ac97 *ac97)
 {
 	static const char cfg_idxs[3][2] = {
 		{2, 1},
 		{0, 2},
 		{0, 1}
 	};
-	
-	// patch for Analog Devices
+
+	/* patch for Analog Devices */
 	unsigned short codecs[3];
 	unsigned short val;
 	int idx, num;
@@ -1597,7 +1597,7 @@ static int patch_ad1881(struct snd_ac97 * ac97)
 	codecs[1] = patch_ad1881_unchained(ac97, 1, (1<<14));
 	codecs[2] = patch_ad1881_unchained(ac97, 2, (1<<13));
 
-	if (! (codecs[0] || codecs[1] || codecs[2]))
+	if (!(codecs[0] || codecs[1] || codecs[2]))
 		goto __end;
 
 	for (idx = 0; idx < 3; idx++)
@@ -1613,7 +1613,7 @@ static int patch_ad1881(struct snd_ac97 * ac97)
 		ac97->scaps |= AC97_SCAP_CENTER_LFE_DAC;
 	}
 
-      __end:
+__end:
 	/* select all codecs */
 	snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 0x7000, 0x7000);
 	/* check if only one codec is present */
@@ -1623,8 +1623,8 @@ static int patch_ad1881(struct snd_ac97 * ac97)
 	if (num == 1) {
 		/* ok, deselect all ID bits */
 		snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0000);
-		ac97->spec.ad18xx.codec_cfg[0] = 
-			ac97->spec.ad18xx.codec_cfg[1] = 
+		ac97->spec.ad18xx.codec_cfg[0] =
+			ac97->spec.ad18xx.codec_cfg[1] =
 			ac97->spec.ad18xx.codec_cfg[2] = 0x0000;
 	}
 	/* required for AD1886/AD1885 combination */
@@ -1648,7 +1648,7 @@ static const struct snd_kcontrol_new snd_ac97_controls_ad1885[] = {
 
 static const DECLARE_TLV_DB_SCALE(db_scale_6bit_6db_max, -8850, 150, 0);
 
-static int patch_ad1885_specific(struct snd_ac97 * ac97)
+static int patch_ad1885_specific(struct snd_ac97 *ac97)
 {
 	int err;
 
@@ -1666,7 +1666,7 @@ static struct snd_ac97_build_ops patch_ad1885_build_ops = {
 #endif
 };
 
-static int patch_ad1885(struct snd_ac97 * ac97)
+static int patch_ad1885(struct snd_ac97 *ac97)
 {
 	patch_ad1881(ac97);
 	/* This is required to deal with the Intel D815EEAL2 */
@@ -1679,7 +1679,7 @@ static int patch_ad1885(struct snd_ac97 * ac97)
 	return 0;
 }
 
-static int patch_ad1886_specific(struct snd_ac97 * ac97)
+static int patch_ad1886_specific(struct snd_ac97 *ac97)
 {
 	reset_tlv(ac97, "Headphone Playback Volume",
 		  db_scale_6bit_6db_max);
@@ -1693,7 +1693,7 @@ static struct snd_ac97_build_ops patch_ad1886_build_ops = {
 #endif
 };
 
-static int patch_ad1886(struct snd_ac97 * ac97)
+static int patch_ad1886(struct snd_ac97 *ac97)
 {
 	patch_ad1881(ac97);
 	/* Presario700 workaround */
@@ -1847,7 +1847,7 @@ static const struct snd_kcontrol_new snd_ac97_ad198x_spdif_source = {
 	.put	= snd_ac97_ad198x_spdif_source_put,
 };
 
-static int patch_ad198x_post_spdif(struct snd_ac97 * ac97)
+static int patch_ad198x_post_spdif(struct snd_ac97 *ac97)
 {
  	return patch_build_controls(ac97, &snd_ac97_ad198x_spdif_source, 1);
 }
@@ -1882,7 +1882,7 @@ static int check_list(struct snd_ac97 *ac97, const unsigned int *list)
 	return 0;
 }
 
-static int patch_ad1981a_specific(struct snd_ac97 * ac97)
+static int patch_ad1981a_specific(struct snd_ac97 *ac97)
 {
 	if (check_list(ac97, ad1981_jacks_blacklist))
 		return 0;
@@ -2092,10 +2092,10 @@ static struct snd_ac97_build_ops patch_ad1888_build_ops = {
 	.update_jacks = ad1888_update_jacks,
 };
 
-static int patch_ad1888(struct snd_ac97 * ac97)
+static int patch_ad1888(struct snd_ac97 *ac97)
 {
 	unsigned short misc;
-	
+
 	patch_ad1881(ac97);
 	ac97->build_ops = &patch_ad1888_build_ops;
 
@@ -2141,7 +2141,7 @@ static struct snd_ac97_build_ops patch_ad1980_build_ops = {
 	.update_jacks = ad1888_update_jacks,
 };
 
-static int patch_ad1980(struct snd_ac97 * ac97)
+static int patch_ad1980(struct snd_ac97 *ac97)
 {
 	patch_ad1888(ac97);
 	ac97->build_ops = &patch_ad1980_build_ops;
@@ -2175,7 +2175,7 @@ static int snd_ac97_ad1985_vrefout_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int snd_ac97_ad1985_vrefout_put(struct snd_kcontrol *kcontrol, 
+static int snd_ac97_ad1985_vrefout_put(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_value *ucontrol)
 {
 	static const int ctrl2reg[4] = {1, 2, 0, 3};
@@ -2256,10 +2256,10 @@ static struct snd_ac97_build_ops patch_ad1985_build_ops = {
 	.update_jacks = ad1985_update_jacks,
 };
 
-static int patch_ad1985(struct snd_ac97 * ac97)
+static int patch_ad1985(struct snd_ac97 *ac97)
 {
 	unsigned short misc;
-	
+
 	patch_ad1881(ac97);
 	ac97->build_ops = &patch_ad1985_build_ops;
 	misc = snd_ac97_read(ac97, AC97_AD_MISC);
@@ -2548,7 +2548,7 @@ static struct snd_ac97_build_ops patch_ad1986_build_ops = {
 	.update_jacks = ad1986_update_jacks,
 };
 
-static int patch_ad1986(struct snd_ac97 * ac97)
+static int patch_ad1986(struct snd_ac97 *ac97)
 {
 	patch_ad1881(ac97);
 	ac97->build_ops = &patch_ad1986_build_ops;
@@ -2575,7 +2575,7 @@ static int patch_alc203(struct snd_ac97 *ac97)
 static void alc650_update_jacks(struct snd_ac97 *ac97)
 {
 	int shared;
-	
+
 	/* shared Line-In / Surround Out */
 	shared = is_shared_surrout(ac97);
 	snd_ac97_update_bits(ac97, AC97_ALC650_MULTICH, 1 << 9,
@@ -2628,7 +2628,7 @@ static const struct snd_kcontrol_new snd_ac97_spdif_controls_alc650[] = {
 
 static const DECLARE_TLV_DB_SCALE(db_scale_5bit_3db_max, -4350, 150, 0);
 
-static int patch_alc650_specific(struct snd_ac97 * ac97)
+static int patch_alc650_specific(struct snd_ac97 *ac97)
 {
 	int err;
 
@@ -2649,7 +2649,7 @@ static struct snd_ac97_build_ops patch_alc650_ops = {
 	.update_jacks = alc650_update_jacks
 };
 
-static int patch_alc650(struct snd_ac97 * ac97)
+static int patch_alc650(struct snd_ac97 *ac97)
 {
 	unsigned short val;
 
@@ -2672,7 +2672,7 @@ static int patch_alc650(struct snd_ac97 * ac97)
 				ac97->id == 0x414c4723);
 
 	/* enable AC97_ALC650_GPIO_SETUP, AC97_ALC650_CLOCK for R/W */
-	snd_ac97_write_cache(ac97, AC97_ALC650_GPIO_STATUS, 
+	snd_ac97_write_cache(ac97, AC97_ALC650_GPIO_STATUS,
 		snd_ac97_read(ac97, AC97_ALC650_GPIO_STATUS) | 0x8000);
 
 	/* Enable SPDIF-IN only on Rev.E and above */
@@ -2680,7 +2680,7 @@ static int patch_alc650(struct snd_ac97 * ac97)
 	/* SPDIF IN with pin 47 */
 	if (ac97->spec.dev_flags &&
 	    /* ASUS A6KM requires EAPD */
-	    ! (ac97->subsystem_vendor == 0x1043 &&
+	    !(ac97->subsystem_vendor == 0x1043 &&
 	       ac97->subsystem_device == 0x1103))
 		val |= 0x03; /* enable */
 	else
@@ -2710,7 +2710,7 @@ static int patch_alc650(struct snd_ac97 * ac97)
 static void alc655_update_jacks(struct snd_ac97 *ac97)
 {
 	int shared;
-	
+
 	/* shared Line-In / Surround Out */
 	shared = is_shared_surrout(ac97);
 	ac97_update_bits_page(ac97, AC97_ALC650_MULTICH, 1 << 9,
@@ -2783,7 +2783,7 @@ static const struct snd_kcontrol_new snd_ac97_spdif_controls_alc655[] = {
 	},
 };
 
-static int patch_alc655_specific(struct snd_ac97 * ac97)
+static int patch_alc655_specific(struct snd_ac97 *ac97)
 {
 	int err;
 
@@ -2801,7 +2801,7 @@ static struct snd_ac97_build_ops patch_alc655_ops = {
 	.update_jacks = alc655_update_jacks
 };
 
-static int patch_alc655(struct snd_ac97 * ac97)
+static int patch_alc655(struct snd_ac97 *ac97)
 {
 	unsigned int val;
 
@@ -2862,7 +2862,7 @@ static void alc850_update_jacks(struct snd_ac97 *ac97)
 {
 	int shared;
 	int aux_is_back_surround;
-	
+
 	/* shared Line-In / Surround Out */
 	shared = is_shared_surrout(ac97);
 	/* SURR 1kOhm (bit4), Amp (bit5) */
@@ -2963,7 +2963,7 @@ static const struct snd_kcontrol_new snd_ac97_cm9738_controls[] = {
 	AC97_CHANNEL_MODE_4CH_CTL,
 };
 
-static int patch_cm9738_specific(struct snd_ac97 * ac97)
+static int patch_cm9738_specific(struct snd_ac97 *ac97)
 {
 	return patch_build_controls(ac97, snd_ac97_cm9738_controls, ARRAY_SIZE(snd_ac97_cm9738_controls));
 }
@@ -2973,7 +2973,7 @@ static struct snd_ac97_build_ops patch_cm9738_ops = {
 	.update_jacks = cm9738_update_jacks
 };
 
-static int patch_cm9738(struct snd_ac97 * ac97)
+static int patch_cm9738(struct snd_ac97 *ac97)
 {
 	ac97->build_ops = &patch_cm9738_ops;
 	/* FIXME: can anyone confirm below? */
@@ -3012,7 +3012,7 @@ static int snd_ac97_cmedia_spdif_playback_source_put(struct snd_kcontrol *kcontr
 	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
 
 	return snd_ac97_update_bits(ac97, AC97_CM9739_SPDIF_CTRL,
-				    0x01 << 1, 
+				    0x01 << 1,
 				    (ucontrol->value.enumerated.item[0] & 0x01) << 1);
 }
 
@@ -3028,7 +3028,7 @@ static const struct snd_kcontrol_new snd_ac97_cm9739_controls_spdif[] = {
 	/* BIT 2: IG_SPIV */
 	AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",CAPTURE,NONE) "Valid Switch", AC97_CM9739_SPDIF_CTRL, 2, 1, 0),
 	/* BIT 3: SPI2F */
-	AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",CAPTURE,NONE) "Monitor", AC97_CM9739_SPDIF_CTRL, 3, 1, 0), 
+	AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",CAPTURE,NONE) "Monitor", AC97_CM9739_SPDIF_CTRL, 3, 1, 0),
 	/* BIT 4: SPI2SDI */
 	AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",CAPTURE,SWITCH), AC97_CM9739_SPDIF_CTRL, 4, 1, 0),
 	/* BIT 8: SPD32 - 32bit SPDIF - not supported yet */
@@ -3049,12 +3049,12 @@ static const struct snd_kcontrol_new snd_ac97_cm9739_controls[] = {
 	AC97_CHANNEL_MODE_CTL,
 };
 
-static int patch_cm9739_specific(struct snd_ac97 * ac97)
+static int patch_cm9739_specific(struct snd_ac97 *ac97)
 {
 	return patch_build_controls(ac97, snd_ac97_cm9739_controls, ARRAY_SIZE(snd_ac97_cm9739_controls));
 }
 
-static int patch_cm9739_post_spdif(struct snd_ac97 * ac97)
+static int patch_cm9739_post_spdif(struct snd_ac97 *ac97)
 {
 	return patch_build_controls(ac97, snd_ac97_cm9739_controls_spdif, ARRAY_SIZE(snd_ac97_cm9739_controls_spdif));
 }
@@ -3065,7 +3065,7 @@ static struct snd_ac97_build_ops patch_cm9739_ops = {
 	.update_jacks = cm9739_update_jacks
 };
 
-static int patch_cm9739(struct snd_ac97 * ac97)
+static int patch_cm9739(struct snd_ac97 *ac97)
 {
 	unsigned short val;
 
@@ -3100,7 +3100,7 @@ static int patch_cm9739(struct snd_ac97 * ac97)
 	val = snd_ac97_read(ac97, AC97_CM9739_MULTI_CHAN) & (1 << 4);
 	val |= (1 << 3);
 	val |= (1 << 13);
-	if (! (ac97->ext_id & AC97_EI_SPDIF))
+	if (!(ac97->ext_id & AC97_EI_SPDIF))
 		val |= (1 << 14);
 	snd_ac97_write_cache(ac97, AC97_CM9739_MULTI_CHAN, val);
 
@@ -3216,19 +3216,19 @@ static const struct snd_kcontrol_new snd_ac97_cm9761_controls_spdif[] = {
 	/* BIT 2: IG_SPIV */
 	AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",CAPTURE,NONE) "Valid Switch", AC97_CM9761_SPDIF_CTRL, 2, 1, 0),
 	/* BIT 3: SPI2F */
-	AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",CAPTURE,NONE) "Monitor", AC97_CM9761_SPDIF_CTRL, 3, 1, 0), 
+	AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",CAPTURE,NONE) "Monitor", AC97_CM9761_SPDIF_CTRL, 3, 1, 0),
 	/* BIT 4: SPI2SDI */
 	AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",CAPTURE,SWITCH), AC97_CM9761_SPDIF_CTRL, 4, 1, 0),
 	/* BIT 9-10: DAC_CTL */
 	AC97_ENUM("DAC Clock Source", cm9761_dac_clock_enum),
 };
 
-static int patch_cm9761_post_spdif(struct snd_ac97 * ac97)
+static int patch_cm9761_post_spdif(struct snd_ac97 *ac97)
 {
 	return patch_build_controls(ac97, snd_ac97_cm9761_controls_spdif, ARRAY_SIZE(snd_ac97_cm9761_controls_spdif));
 }
 
-static int patch_cm9761_specific(struct snd_ac97 * ac97)
+static int patch_cm9761_specific(struct snd_ac97 *ac97)
 {
 	return patch_build_controls(ac97, snd_ac97_cm9761_controls, ARRAY_SIZE(snd_ac97_cm9761_controls));
 }
@@ -3308,7 +3308,7 @@ static int patch_cm9761(struct snd_ac97 *ac97)
 
 	return 0;
 }
-       
+
 #define AC97_CM9780_SIDE	0x60
 #define AC97_CM9780_JACK	0x62
 #define AC97_CM9780_MIXER	0x64
@@ -3418,7 +3418,7 @@ static int snd_ac97_add_vmaster(struct snd_ac97 *ac97, char *name,
 	return 0;
 }
 
-static int patch_vt1616_specific(struct snd_ac97 * ac97)
+static int patch_vt1616_specific(struct snd_ac97 *ac97)
 {
 	struct snd_kcontrol *kctl;
 	int err;
@@ -3453,7 +3453,7 @@ static struct snd_ac97_build_ops patch_vt1616_ops = {
 	.build_specific	= patch_vt1616_specific
 };
 
-static int patch_vt1616(struct snd_ac97 * ac97)
+static int patch_vt1616(struct snd_ac97 *ac97)
 {
 	ac97->build_ops = &patch_vt1616_ops;
 	return 0;
@@ -3480,7 +3480,7 @@ static int snd_ac97_vt1617a_smart51_info(struct snd_kcontrol *kcontrol,
 	/* ordering in this list reflects vt1617a docs for Reg 20 and
 	 * 7a and Table 6 that lays out the matrix NB WRT Table6: SM51
 	 * is SM51EN *AND* it's Bit14, not Bit15 so the table is very
-	 * counter-intuitive */ 
+	 * counter-intuitive */
 
 	static const char* texts[] = { "LineIn Mic1", "LineIn Mic1 Mic3",
 				       "Surr LFE/C Mic3", "LineIn LFE/C Mic3",
@@ -3492,18 +3492,18 @@ static int snd_ac97_vt1617a_smart51_info(struct snd_kcontrol *kcontrol,
 static int snd_ac97_vt1617a_smart51_get(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_value *ucontrol)
 {
-	ushort usSM51, usMS;  
+	ushort usSM51, usMS;
 
 	struct snd_ac97 *pac97;
-	
+
 	pac97 = snd_kcontrol_chip(kcontrol); /* grab codec handle */
 
 	/* grab our desired bits, then mash them together in a manner
 	 * consistent with Table 6 on page 17 in the 1617a docs */
- 
+
 	usSM51 = snd_ac97_read(pac97, 0x7a) >> 14;
 	usMS   = snd_ac97_read(pac97, 0x20) >> 8;
-  
+
 	ucontrol->value.enumerated.item[0] = (usSM51 << 1) + usMS;
 
 	return 0;
@@ -3512,7 +3512,7 @@ static int snd_ac97_vt1617a_smart51_get(struct snd_kcontrol *kcontrol,
 static int snd_ac97_vt1617a_smart51_put(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_value *ucontrol)
 {
-	ushort usSM51, usMS, usReg;  
+	ushort usSM51, usMS, usReg;
 
 	struct snd_ac97 *pac97;
 
@@ -3548,7 +3548,7 @@ static const struct snd_kcontrol_new snd_ac97_controls_vt1617a[] = {
 	},
 };
 
-static int patch_vt1617a(struct snd_ac97 * ac97)
+static int patch_vt1617a(struct snd_ac97 *ac97)
 {
 	int err = 0;
 	int val;
@@ -3793,7 +3793,7 @@ static const struct snd_kcontrol_new snd_ac97_spdif_controls_it2646[] = {
 	AC97_SINGLE("IEC958 Input Monitor", 0x76, 13, 1, 0),
 };
 
-static int patch_it2646_specific(struct snd_ac97 * ac97)
+static int patch_it2646_specific(struct snd_ac97 *ac97)
 {
 	int err;
 	if ((err = patch_build_controls(ac97, snd_ac97_controls_it2646, ARRAY_SIZE(snd_ac97_controls_it2646))) < 0)
@@ -3808,7 +3808,7 @@ static struct snd_ac97_build_ops patch_it2646_ops = {
 	.update_jacks = it2646_update_jacks
 };
 
-static int patch_it2646(struct snd_ac97 * ac97)
+static int patch_it2646(struct snd_ac97 *ac97)
 {
 	ac97->build_ops = &patch_it2646_ops;
 	/* full DAC volume */
@@ -3828,7 +3828,7 @@ static const struct snd_kcontrol_new snd_ac97_controls_si3036[] = {
 AC97_DOUBLE("Modem Speaker Volume", 0x5c, 14, 12, 3, 1)
 };
 
-static int patch_si3036_specific(struct snd_ac97 * ac97)
+static int patch_si3036_specific(struct snd_ac97 *ac97)
 {
 	int idx, err;
 	for (idx = 0; idx < ARRAY_SIZE(snd_ac97_controls_si3036); idx++)
@@ -3841,10 +3841,10 @@ static struct snd_ac97_build_ops patch_si3036_ops = {
 	.build_specific	= patch_si3036_specific,
 };
 
-static int mpatch_si3036(struct snd_ac97 * ac97)
+static int mpatch_si3036(struct snd_ac97 *ac97)
 {
 	ac97->build_ops = &patch_si3036_ops;
-	snd_ac97_write_cache(ac97, 0x5c, 0xf210 );
+	snd_ac97_write_cache(ac97, 0x5c, 0xf210);
 	snd_ac97_write_cache(ac97, 0x68, 0);
 	return 0;
 }
@@ -3879,7 +3879,7 @@ static int patch_lm4550(struct snd_ac97 *ac97)
 	return 0;
 }
 
-/* 
+/*
  *  UCB1400 codec (http://www.semiconductors.philips.com/acrobat_download/datasheets/UCB1400-02.pdf)
  */
 static const struct snd_kcontrol_new snd_ac97_controls_ucb1400[] = {
@@ -3895,7 +3895,7 @@ AC97_SINGLE("DC Filter", 0x6a, 4, 1, 0),
 AC97_SINGLE("Smart Low Power Mode", 0x6c, 4, 3, 0),
 };
 
-static int patch_ucb1400_specific(struct snd_ac97 * ac97)
+static int patch_ucb1400_specific(struct snd_ac97 *ac97)
 {
 	int idx, err;
 	for (idx = 0; idx < ARRAY_SIZE(snd_ac97_controls_ucb1400); idx++)
@@ -3908,7 +3908,7 @@ static struct snd_ac97_build_ops patch_ucb1400_ops = {
 	.build_specific	= patch_ucb1400_specific,
 };
 
-static int patch_ucb1400(struct snd_ac97 * ac97)
+static int patch_ucb1400(struct snd_ac97 *ac97)
 {
 	ac97->build_ops = &patch_ucb1400_ops;
 	/* enable headphone driver and smart low power mode by default */
diff --git a/sound/pci/ac97/ac97_pcm.c b/sound/pci/ac97/ac97_pcm.c
index 48cbda9..cb86273 100644
--- a/sound/pci/ac97/ac97_pcm.c
+++ b/sound/pci/ac97/ac97_pcm.c
@@ -175,7 +175,7 @@ static int set_spdif_rate(struct snd_ac97 *ac97, unsigned short rate)
 	unsigned short old, bits, reg, mask;
 	unsigned int sbits;
 
-	if (! (ac97->ext_id & AC97_EI_SPDIF))
+	if (!(ac97->ext_id & AC97_EI_SPDIF))
 		return -ENODEV;
 
 	/* TODO: double rate support */
@@ -258,7 +258,7 @@ int snd_ac97_set_rate(struct snd_ac97 *ac97, int reg, unsigned int rate)
 {
 	int dbl;
 	unsigned int tmp;
-	
+
 	dbl = rate > 48000;
 	if (dbl) {
 		if (!(ac97->flags & AC97_DOUBLE_RATE))
@@ -281,11 +281,11 @@ int snd_ac97_set_rate(struct snd_ac97 *ac97, int reg, unsigned int rate)
 				return -EINVAL;
 		break;
 	case AC97_PCM_SURR_DAC_RATE:
-		if (! (ac97->scaps & AC97_SCAP_SURROUND_DAC))
+		if (!(ac97->scaps & AC97_SCAP_SURROUND_DAC))
 			return -EINVAL;
 		break;
 	case AC97_PCM_LFE_DAC_RATE:
-		if (! (ac97->scaps & AC97_SCAP_CENTER_LFE_DAC))
+		if (!(ac97->scaps & AC97_SCAP_CENTER_LFE_DAC))
 			return -EINVAL;
 		break;
 	case AC97_SPDIF:
@@ -618,7 +618,7 @@ int snd_ac97_pcm_open(struct ac97_pcm *pcm, unsigned int rate,
 				}
 				if (reg_ok[cidx] & (1 << (reg - AC97_PCM_FRONT_DAC_RATE)))
 					continue;
-				//printk(KERN_DEBUG "setting ac97 reg 0x%x to rate %d\n", reg, rate);
+				/* printk(KERN_DEBUG "setting ac97 reg 0x%x to rate %d\n", reg, rate); */
 				err = snd_ac97_set_rate(pcm->r[r].codec[cidx], reg, rate);
 				if (err < 0)
 					snd_printk(KERN_ERR "error in snd_ac97_set_rate: cidx=%d, reg=0x%x, rate=%d, err=%d\n", cidx, reg, rate, err);
diff --git a/sound/pci/ac97/ac97_proc.c b/sound/pci/ac97/ac97_proc.c
index 060ea59..11f7e50 100644
--- a/sound/pci/ac97/ac97_proc.c
+++ b/sound/pci/ac97/ac97_proc.c
@@ -140,7 +140,7 @@ static void snd_ac97_proc_read_main(struct snd_ac97 *ac97, struct snd_info_buffe
 				     AC97_PAGE_MASK, val & AC97_PAGE_MASK);
 	}
 
-	// val = snd_ac97_read(ac97, AC97_RESET);
+	/* val = snd_ac97_read(ac97, AC97_RESET); */
 	val = ac97->caps;
 	snd_iprintf(buffer, "Capabilities     :%s%s%s%s%s%s\n",
 	    	    val & AC97_BC_DEDICATED_MIC ? " -dedicated MIC PCM IN channel-" : "",
@@ -188,7 +188,7 @@ static void snd_ac97_proc_read_main(struct snd_ac97 *ac97, struct snd_info_buffe
 	ext = snd_ac97_read(ac97, AC97_EXTENDED_ID);
 	if (ext == 0)
 		goto __modem;
-		
+
 	snd_iprintf(buffer, "Extended ID      : codec=%i rev=%i%s%s%s%s DSA=%i%s%s%s%s\n",
 			(ext & AC97_EI_ADDR_MASK) >> AC97_EI_ADDR_SHIFT,
 			(ext & AC97_EI_REV_MASK) >> AC97_EI_REV_SHIFT,
@@ -295,11 +295,11 @@ static void snd_ac97_proc_read_main(struct snd_ac97 *ac97, struct snd_info_buffe
 	}
 
 
-      __modem:
+__modem:
 	mext = snd_ac97_read(ac97, AC97_EXTENDED_MID);
 	if (mext == 0)
 		return;
-	
+
 	snd_iprintf(buffer, "Extended modem ID: codec=%i%s%s%s%s%s\n",
 			(mext & AC97_MEI_ADDR_MASK) >> AC97_MEI_ADDR_SHIFT,
 			mext & AC97_MEI_CID2 ? " CID2" : "",
@@ -342,9 +342,9 @@ static void snd_ac97_proc_read_main(struct snd_ac97 *ac97, struct snd_info_buffe
 static void snd_ac97_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 {
 	struct snd_ac97 *ac97 = entry->private_data;
-	
+
 	mutex_lock(&ac97->page_mutex);
-	if ((ac97->id & 0xffffff40) == AC97_ID_AD1881) {	// Analog Devices AD1881/85/86
+	if ((ac97->id & 0xffffff40) == AC97_ID_AD1881) {	/* Analog Devices AD1881/85/86 */
 		int idx;
 		for (idx = 0; idx < 3; idx++)
 			if (ac97->spec.ad18xx.id[idx]) {
@@ -356,7 +356,7 @@ static void snd_ac97_proc_read(struct snd_info_entry *entry, struct snd_info_buf
 			}
 		/* select all codecs */
 		snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 0x7000, 0x7000);
-		
+
 		snd_iprintf(buffer, "\nAD18XX configuration\n");
 		snd_iprintf(buffer, "Unchained        : 0x%04x,0x%04x,0x%04x\n",
 			ac97->spec.ad18xx.unchained[0],
@@ -401,13 +401,13 @@ static void snd_ac97_proc_regs_read_main(struct snd_ac97 *ac97, struct snd_info_
 	}
 }
 
-static void snd_ac97_proc_regs_read(struct snd_info_entry *entry, 
+static void snd_ac97_proc_regs_read(struct snd_info_entry *entry,
 				    struct snd_info_buffer *buffer)
 {
 	struct snd_ac97 *ac97 = entry->private_data;
 
 	mutex_lock(&ac97->page_mutex);
-	if ((ac97->id & 0xffffff40) == AC97_ID_AD1881) {	// Analog Devices AD1881/85/86
+	if ((ac97->id & 0xffffff40) == AC97_ID_AD1881) {	/* Analog Devices AD1881/85/86 */
 
 		int idx;
 		for (idx = 0; idx < 3; idx++)
@@ -421,11 +421,11 @@ static void snd_ac97_proc_regs_read(struct snd_info_entry *entry,
 		snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 0x7000, 0x7000);
 	} else {
 		snd_ac97_proc_regs_read_main(ac97, buffer, 0);
-	}	
+	}
 	mutex_unlock(&ac97->page_mutex);
 }
 
-void snd_ac97_proc_init(struct snd_ac97 * ac97)
+void snd_ac97_proc_init(struct snd_ac97 *ac97)
 {
 	struct snd_info_entry *entry;
 	char name[32];
@@ -458,7 +458,7 @@ void snd_ac97_proc_init(struct snd_ac97 * ac97)
 	ac97->proc_regs = entry;
 }
 
-void snd_ac97_proc_done(struct snd_ac97 * ac97)
+void snd_ac97_proc_done(struct snd_ac97 *ac97)
 {
 	snd_info_free_entry(ac97->proc_regs);
 	ac97->proc_regs = NULL;
