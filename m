From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] AD1888 support
Date: Wed, 11 Feb 2004 10:49:43 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402111047360.24733-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


This adds support for the AD1888 (same as AD1980, but without 2CMIC).

Not tested.


Index: alsa-kernel/pci/ac97/ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.120
diff -u -r1.120 ac97_codec.c
--- alsa-kernel/pci/ac97/ac97_codec.c	9 Feb 2004 12:01:07 -0000	1.120
+++ alsa-kernel/pci/ac97/ac97_codec.c	11 Feb 2004 09:26:20 -0000
@@ -100,6 +100,7 @@
 { 0x41445361, 0xffffffff, "AD1886",		patch_ad1886,	NULL },
 { 0x41445362, 0xffffffff, "AD1887",		patch_ad1881,	NULL },
 { 0x41445363, 0xffffffff, "AD1886A",		patch_ad1881,	NULL },
+{ 0x41445368, 0xffffffff, "AD1888",		patch_ad1888,	NULL },
 { 0x41445370, 0xffffffff, "AD1980",		patch_ad1980,	NULL },
 { 0x41445372, 0xffffffff, "AD1981A",		patch_ad1981a,	NULL },
 { 0x41445374, 0xffffffff, "AD1981B",		patch_ad1981b,	NULL },
Index: alsa-kernel/pci/ac97/ac97_patch.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.c,v
retrieving revision 1.34
diff -u -r1.34 ac97_patch.c
--- alsa-kernel/pci/ac97/ac97_patch.c	9 Feb 2004 11:45:40 -0000	1.34
+++ alsa-kernel/pci/ac97/ac97_patch.c	11 Feb 2004 09:26:20 -0000
@@ -799,7 +799,7 @@
 	return 0;
 }

-static int snd_ac97_ad1980_lohpsel_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+static int snd_ac97_ad1888_lohpsel_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = 1;
@@ -808,7 +808,7 @@
 	return 0;
 }

-static int snd_ac97_ad1980_lohpsel_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t* ucontrol)
+static int snd_ac97_ad1888_lohpsel_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t* ucontrol)
 {
 	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
 	unsigned short val;
@@ -818,7 +818,7 @@
 	return 0;
 }

-static int snd_ac97_ad1980_lohpsel_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+static int snd_ac97_ad1888_lohpsel_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
 	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
 	unsigned short val;
@@ -829,7 +829,7 @@
 				    AC97_AD198X_LOSEL | AC97_AD198X_HPSEL, val);
 }

-static int snd_ac97_ad1980_downmix_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+static int snd_ac97_ad1888_downmix_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
 {
 	static char *texts[3] = {"Off", "6 -> 4", "6 -> 2"};

@@ -842,7 +842,7 @@
 	return 0;
 }

-static int snd_ac97_ad1980_downmix_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t* ucontrol)
+static int snd_ac97_ad1888_downmix_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t* ucontrol)
 {
 	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
 	unsigned short val;
@@ -855,7 +855,7 @@
 	return 0;
 }

-static int snd_ac97_ad1980_downmix_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+static int snd_ac97_ad1888_downmix_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
 	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
 	unsigned short val;
@@ -871,51 +871,47 @@
 				    AC97_AD198X_DMIX0 | AC97_AD198X_DMIX1, val);
 }

-static const snd_kcontrol_new_t snd_ac97_ad1980_controls[] = {
+static const snd_kcontrol_new_t snd_ac97_ad1888_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Exchange Front/Surround",
-		.info = snd_ac97_ad1980_lohpsel_info,
-		.get = snd_ac97_ad1980_lohpsel_get,
-		.put = snd_ac97_ad1980_lohpsel_put
+		.info = snd_ac97_ad1888_lohpsel_info,
+		.get = snd_ac97_ad1888_lohpsel_get,
+		.put = snd_ac97_ad1888_lohpsel_put
 	},
 	AC97_SINGLE("Spread Front to Surround and Center/LFE", AC97_AD_MISC, 7, 1, 0),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Downmix",
-		.info = snd_ac97_ad1980_downmix_info,
-		.get = snd_ac97_ad1980_downmix_get,
-		.put = snd_ac97_ad1980_downmix_put
+		.info = snd_ac97_ad1888_downmix_info,
+		.get = snd_ac97_ad1888_downmix_get,
+		.put = snd_ac97_ad1888_downmix_put
 	},
 	AC97_SINGLE("Surround Jack as Input", AC97_AD_MISC, 12, 1, 0),
 	AC97_SINGLE("Center/LFE Jack as Input", AC97_AD_MISC, 11, 1, 0),
 };

-static int patch_ad1980_specific(ac97_t *ac97)
+static int patch_ad1888_specific(ac97_t *ac97)
 {
-	int err;
-
 	/* rename 0x04 as "Master" and 0x02 as "Master Surround" */
 	snd_ac97_rename_ctl(ac97, "Master Playback Switch", "Master Surround Playback Switch");
 	snd_ac97_rename_ctl(ac97, "Master Playback Volume", "Master Surround Playback Volume");
 	snd_ac97_rename_ctl(ac97, "Headphone Playback Switch", "Master Playback Switch");
 	snd_ac97_rename_ctl(ac97, "Headphone Playback Volume", "Master Playback Volume");
-	if ((err = patch_build_controls(ac97, &snd_ac97_ad198x_2cmic, 1)) < 0)
-		return err;
-	return patch_build_controls(ac97, snd_ac97_ad1980_controls, ARRAY_SIZE(snd_ac97_ad1980_controls));
+	return patch_build_controls(ac97, snd_ac97_ad1888_controls, ARRAY_SIZE(snd_ac97_ad1888_controls));
 }

-static struct snd_ac97_build_ops patch_ad1980_build_ops = {
+static struct snd_ac97_build_ops patch_ad1888_build_ops = {
 	.build_post_spdif = patch_ad198x_post_spdif,
-	.build_specific = patch_ad1980_specific
+	.build_specific = patch_ad1888_specific
 };

-int patch_ad1980(ac97_t * ac97)
+int patch_ad1888(ac97_t * ac97)
 {
 	unsigned short misc;

 	patch_ad1881(ac97);
-	ac97->build_ops = &patch_ad1980_build_ops;
+	ac97->build_ops = &patch_ad1888_build_ops;
 	/* Switch FRONT/SURROUND LINE-OUT/HP-OUT default connection */
 	/* it seems that most vendors connect line-out connector to headphone out of AC'97 */
 	/* AD-compatible mode */
@@ -927,6 +923,27 @@
 			     AC97_AD198X_MSPLT |
 			     AC97_AD198X_AC97NC);
 	ac97->flags |= AC97_STEREO_MUTES;
+	return 0;
+}
+
+static int patch_ad1980_specific(ac97_t *ac97)
+{
+	int err;
+
+	if ((err = patch_ad1888_specific(ac97)) < 0)
+		return err;
+	return patch_build_controls(ac97, &snd_ac97_ad198x_2cmic, 1);
+}
+
+static struct snd_ac97_build_ops patch_ad1980_build_ops = {
+	.build_post_spdif = patch_ad198x_post_spdif,
+	.build_specific = patch_ad1980_specific
+};
+
+int patch_ad1980(ac97_t * ac97)
+{
+	patch_ad1888(ac97);
+	ac97->build_ops = &patch_ad1980_build_ops;
 	return 0;
 }

Index: alsa-kernel/pci/ac97/ac97_patch.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.h,v
retrieving revision 1.13
diff -u -r1.13 ac97_patch.h
--- alsa-kernel/pci/ac97/ac97_patch.h	12 Jan 2004 14:38:06 -0000	1.13
+++ alsa-kernel/pci/ac97/ac97_patch.h	11 Feb 2004 09:26:20 -0000
@@ -41,6 +41,7 @@
 int patch_ad1881(ac97_t * ac97);
 int patch_ad1885(ac97_t * ac97);
 int patch_ad1886(ac97_t * ac97);
+int patch_ad1888(ac97_t * ac97);
 int patch_ad1980(ac97_t * ac97);
 int patch_ad1981a(ac97_t * ac97);
 int patch_ad1981b(ac97_t * ac97);




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
