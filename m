From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] AD198x controls
Date: Mon, 03 Nov 2003 08:38:32 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0311030834400.766-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


new controls for AD1981A/B/1980/1985


Index: alsa-kernel/pci/ac97/ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.110
diff -u -r1.110 ac97_codec.c
--- alsa-kernel/pci/ac97/ac97_codec.c	27 Oct 2003 10:48:41 -0000	1.110
+++ alsa-kernel/pci/ac97/ac97_codec.c	3 Nov 2003 07:31:39 -0000
@@ -101,8 +101,8 @@
 { 0x41445362, 0xffffffff, "AD1887",		patch_ad1881,	NULL },
 { 0x41445363, 0xffffffff, "AD1886A",		patch_ad1881,	NULL },
 { 0x41445370, 0xffffffff, "AD1980",		patch_ad1980,	NULL },
-{ 0x41445372, 0xffffffff, "AD1981A",		patch_ad1881,	NULL },
-{ 0x41445374, 0xffffffff, "AD1981B",		patch_ad1881,	NULL },
+{ 0x41445372, 0xffffffff, "AD1981A",		patch_ad1981a,	NULL },
+{ 0x41445374, 0xffffffff, "AD1981B",		patch_ad1981b,	NULL },
 { 0x41445375, 0xffffffff, "AD1985",		patch_ad1985,	NULL },
 { 0x414c4300, 0xfffffff0, "RL5306",	 	NULL,		NULL },
 { 0x414c4310, 0xfffffff0, "RL5382", 		NULL,		NULL },
Index: alsa-kernel/pci/ac97/ac97_patch.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.c,v
retrieving revision 1.28
diff -u -r1.28 ac97_patch.c
--- alsa-kernel/pci/ac97/ac97_patch.c	27 Oct 2003 10:48:42 -0000	1.28
+++ alsa-kernel/pci/ac97/ac97_patch.c	3 Nov 2003 07:31:39 -0000
@@ -708,7 +708,7 @@
 #define AC97_AD198X_2MIC	0x0040	/* 2-channel mic select */
 #define AC97_AD198X_SPRD	0x0080	/* SPREAD enable */
 #define AC97_AD198X_DMIX0	0x0100	/* downmix mode: 0 = 6-to-4, 1 = 6-to-2 downmix */
-#define AC97_AD198X_DMIX1	0x0300	/* downmix mode: 1 = enabled */
+#define AC97_AD198X_DMIX1	0x0200	/* downmix mode: 1 = enabled */
 #define AC97_AD198X_HPSEL	0x0400	/* headphone amplifier input select */
 #define AC97_AD198X_CLDIS	0x0800	/* center/lfe disable */
 #define AC97_AD198X_LODIS	0x1000	/* LINE_OUT disable */
@@ -717,7 +717,7 @@
 #define AC97_AD198X_DACZ	0x8000	/* DAC zero-fill mode */


-static int snd_ac97_ad1980_spdif_source_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+static int snd_ac97_ad198x_spdif_source_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	static char *texts[2] = { "AC-Link", "A/D Converter" };

@@ -730,7 +730,7 @@
 	return 0;
 }

-static int snd_ac97_ad1980_spdif_source_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+static int snd_ac97_ad198x_spdif_source_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
 	unsigned short val;
@@ -740,7 +740,7 @@
 	return 0;
 }

-static int snd_ac97_ad1980_spdif_source_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+static int snd_ac97_ad198x_spdif_source_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
 	unsigned short val;
@@ -751,31 +751,162 @@
 	return snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 0x0004, val);
 }

-static const snd_kcontrol_new_t snd_ac97_ad1980_spdif_source = {
+static const snd_kcontrol_new_t snd_ac97_ad198x_spdif_source = {
 	.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name	= SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Source",
-	.info	= snd_ac97_ad1980_spdif_source_info,
-	.get	= snd_ac97_ad1980_spdif_source_get,
-	.put	= snd_ac97_ad1980_spdif_source_put,
+	.info	= snd_ac97_ad198x_spdif_source_info,
+	.get	= snd_ac97_ad198x_spdif_source_get,
+	.put	= snd_ac97_ad198x_spdif_source_put,
 };

-static int patch_ad1980_post_spdif(ac97_t * ac97)
+static int patch_ad198x_post_spdif(ac97_t * ac97)
 {
- 	return patch_build_controls(ac97, &snd_ac97_ad1980_spdif_source, 1);
+ 	return patch_build_controls(ac97, &snd_ac97_ad198x_spdif_source, 1);
 }

+static struct snd_ac97_build_ops patch_ad1981a_build_ops = {
+	.build_post_spdif = patch_ad198x_post_spdif
+};
+
+int patch_ad1981a(ac97_t *ac97)
+{
+	patch_ad1881(ac97);
+	ac97->build_ops = &patch_ad1981a_build_ops;
+	snd_ac97_update_bits(ac97, AC97_AD_MISC, AC97_AD198X_MSPLT, AC97_AD198X_MSPLT);
+	ac97->flags |= AC97_STEREO_MUTES;
+	return 0;
+}
+
+static const snd_kcontrol_new_t snd_ac97_ad198x_2cmic =
+AC97_SINGLE("Stereo Mic", AC97_AD_MISC, 6, 1, 0);
+
+static int patch_ad1981b_specific(ac97_t *ac97)
+{
+	return patch_build_controls(ac97, &snd_ac97_ad198x_2cmic, 1);
+}
+
+static struct snd_ac97_build_ops patch_ad1981b_build_ops = {
+	.build_post_spdif = patch_ad198x_post_spdif,
+	.build_specific = patch_ad1981b_specific
+};
+
+int patch_ad1981b(ac97_t *ac97)
+{
+	patch_ad1881(ac97);
+	ac97->build_ops = &patch_ad1981b_build_ops;
+	snd_ac97_update_bits(ac97, AC97_AD_MISC, AC97_AD198X_MSPLT, AC97_AD198X_MSPLT);
+	ac97->flags |= AC97_STEREO_MUTES;
+	return 0;
+}
+
+static int snd_ac97_ad1980_lohpsel_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int snd_ac97_ad1980_lohpsel_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t* ucontrol)
+{
+	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+
+	val = ac97->regs[AC97_AD_MISC];
+	ucontrol->value.integer.value[0] = !(val & AC97_AD198X_LOSEL);
+	return 0;
+}
+
+static int snd_ac97_ad1980_lohpsel_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+
+	val = !ucontrol->value.integer.value[0]
+		? (AC97_AD198X_LOSEL | AC97_AD198X_HPSEL) : 0;
+	return snd_ac97_update_bits(ac97, AC97_AD_MISC,
+				    AC97_AD198X_LOSEL | AC97_AD198X_HPSEL, val);
+}
+
+static int snd_ac97_ad1980_downmix_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	static char *texts[3] = {"Off", "6 -> 4", "6 -> 2"};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 3;
+	if (uinfo->value.enumerated.item > 2)
+		uinfo->value.enumerated.item = 2;
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int snd_ac97_ad1980_downmix_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t* ucontrol)
+{
+	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+
+	val = ac97->regs[AC97_AD_MISC];
+	if (!(val & AC97_AD198X_DMIX1))
+		ucontrol->value.enumerated.item[0] = 0;
+	else
+		ucontrol->value.enumerated.item[0] = 1 + ((val >> 8) & 1);
+	return 0;
+}
+
+static int snd_ac97_ad1980_downmix_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+
+	if (ucontrol->value.enumerated.item[0] > 2)
+		return -EINVAL;
+	if (ucontrol->value.enumerated.item[0] == 0)
+		val = 0;
+	else
+		val = AC97_AD198X_DMIX1 |
+			((ucontrol->value.enumerated.item[0] - 1) << 8);
+	return snd_ac97_update_bits(ac97, AC97_AD_MISC,
+				    AC97_AD198X_DMIX0 | AC97_AD198X_DMIX1, val);
+}
+
+static const snd_kcontrol_new_t snd_ac97_ad1980_controls[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Exchange Front/Surround",
+		.info = snd_ac97_ad1980_lohpsel_info,
+		.get = snd_ac97_ad1980_lohpsel_get,
+		.put = snd_ac97_ad1980_lohpsel_put
+	},
+	AC97_SINGLE("Spread Front to Surround and Center/LFE", AC97_AD_MISC, 7, 1, 0),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Downmix",
+		.info = snd_ac97_ad1980_downmix_info,
+		.get = snd_ac97_ad1980_downmix_get,
+		.put = snd_ac97_ad1980_downmix_put
+	},
+	AC97_SINGLE("Surround Jack as Input", AC97_AD_MISC, 12, 1, 0),
+	AC97_SINGLE("Center/LFE Jack as Input", AC97_AD_MISC, 11, 1, 0),
+};
+
 static int patch_ad1980_specific(ac97_t *ac97)
 {
+	int err;
+
 	/* rename 0x04 as "Master" and 0x02 as "Master Surround" */
 	snd_ac97_rename_ctl(ac97, "Master Playback Switch", "Master Surround Playback Switch");
 	snd_ac97_rename_ctl(ac97, "Master Playback Volume", "Master Surround Playback Volume");
 	snd_ac97_rename_ctl(ac97, "Headphone Playback Switch", "Master Playback Switch");
 	snd_ac97_rename_ctl(ac97, "Headphone Playback Volume", "Master Playback Volume");
-	return 0;
+	if ((err = patch_build_controls(ac97, &snd_ac97_ad198x_2cmic, 1)) < 0)
+		return err;
+	return patch_build_controls(ac97, snd_ac97_ad1980_controls, ARRAY_SIZE(snd_ac97_ad1980_controls));
 }

 static struct snd_ac97_build_ops patch_ad1980_build_ops = {
-	.build_post_spdif = patch_ad1980_post_spdif,
+	.build_post_spdif = patch_ad198x_post_spdif,
 	.build_specific = patch_ad1980_specific
 };

@@ -799,12 +930,31 @@
 	return 0;
 }

+static const snd_kcontrol_new_t snd_ac97_ad1985_controls[] = {
+	AC97_SINGLE("Center/LFE Jack as Mic", AC97_AD_SERIAL_CFG, 9, 1, 0),
+	AC97_SINGLE("Exchange Center/LFE", AC97_AD_SERIAL_CFG, 3, 1, 0)
+};
+
+static int patch_ad1985_specific(ac97_t *ac97)
+{
+	int err;
+
+	if ((err = patch_ad1980_specific(ac97)) < 0)
+		return err;
+	return patch_build_controls(ac97, snd_ac97_ad1985_controls, ARRAY_SIZE(snd_ac97_ad1985_controls));
+}
+
+static struct snd_ac97_build_ops patch_ad1985_build_ops = {
+	.build_post_spdif = patch_ad198x_post_spdif,
+	.build_specific = patch_ad1985_specific
+};
+
 int patch_ad1985(ac97_t * ac97)
 {
 	unsigned short misc;

 	patch_ad1881(ac97);
-	ac97->build_ops = &patch_ad1980_build_ops;
+	ac97->build_ops = &patch_ad1985_build_ops;
 	misc = snd_ac97_read(ac97, AC97_AD_MISC);
 	/* switch front/surround line-out/hp-out */
 	/* center/LFE, surround in High-Z mode */
Index: alsa-kernel/pci/ac97/ac97_patch.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.h,v
retrieving revision 1.10
diff -u -r1.10 ac97_patch.h
--- alsa-kernel/pci/ac97/ac97_patch.h	27 Oct 2003 10:48:42 -0000	1.10
+++ alsa-kernel/pci/ac97/ac97_patch.h	3 Nov 2003 07:31:39 -0000
@@ -42,6 +42,8 @@
 int patch_ad1885(ac97_t * ac97);
 int patch_ad1886(ac97_t * ac97);
 int patch_ad1980(ac97_t * ac97);
+int patch_ad1981a(ac97_t * ac97);
+int patch_ad1981b(ac97_t * ac97);
 int patch_ad1985(ac97_t * ac97);
 int patch_alc650(ac97_t * ac97);
 int patch_cm9738(ac97_t * ac97);




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
