From: Andreas Mohr <andi@lisas.de>
Subject: [PATCH] sound azt3328: hook up new emulated AC97 on
	AC97 patch side
Date: Thu, 17 Feb 2011 00:16:12 +0100
Message-ID: <20110216231612.GB1638@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id C1394103918
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2011 00:16:12 +0100 (CET)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ChangeLog:

Make newly created AC97 emulation of azt3328 known to the AC97 layer side.
- relocate common functions to the top (due to definition after use)
- rename control names
- adjust 3D settings to the card's custom layout of this register

Signed-off-by: Andreas Mohr <andi@lisas.de>
---
Patch created on -rc3, tested and checkpatch.pl'd.
GIT history seems clean, should thus apply easily.

Thanks!

Index: linux-2.6/sound/pci/ac97/ac97_codec.c
===================================================================
--- linux-2.6.orig/sound/pci/ac97/ac97_codec.c	2011-02-16 23:18:54.000000000 +0100
+++ linux-2.6/sound/pci/ac97/ac97_codec.c	2011-02-16 23:24:12.000000000 +0100
@@ -71,6 +71,12 @@
 { 0x414b4d00, 0xffffff00, "Asahi Kasei",	NULL,	NULL },
 { 0x414c4300, 0xffffff00, "Realtek",		NULL,	NULL },
 { 0x414c4700, 0xffffff00, "Realtek",		NULL,	NULL },
+/*
+ * This is an _inofficial_ Aztech Labs entry
+ * (value might differ from unknown official Aztech ID),
+ * currently used by the AC97 emulation of the almost-AC97 PCI168 card.
+ */
+{ 0x415a5400, 0xffffff00, "Aztech Labs (emulated)",	NULL,	NULL },
 { 0x434d4900, 0xffffff00, "C-Media Electronics", NULL,	NULL },
 { 0x43525900, 0xffffff00, "Cirrus Logic",	NULL,	NULL },
 { 0x43585400, 0xffffff00, "Conexant",           NULL,	NULL },
@@ -127,6 +133,7 @@
 { 0x414c4781, 0xffffffff, "ALC658D",		NULL,	NULL }, /* already patched */
 { 0x414c4780, 0xfffffff0, "ALC658",		patch_alc655,	NULL },
 { 0x414c4790, 0xfffffff0, "ALC850",		patch_alc850,	NULL },
+{ 0x415a5401, 0xffffffff, "AZF3328",		patch_aztech_azf3328,	NULL },
 { 0x434d4941, 0xffffffff, "CMI9738",		patch_cm9738,	NULL },
 { 0x434d4961, 0xffffffff, "CMI9739",		patch_cm9739,	NULL },
 { 0x434d4969, 0xffffffff, "CMI9780",		patch_cm9780,	NULL },
Index: linux-2.6/sound/pci/ac97/ac97_patch.c
===================================================================
--- linux-2.6.orig/sound/pci/ac97/ac97_patch.c	2011-02-16 23:18:54.000000000 +0100
+++ linux-2.6/sound/pci/ac97/ac97_patch.c	2011-02-16 23:19:03.000000000 +0100
@@ -222,6 +222,47 @@
 	return is_surround_on(ac97);
 }
 
+/* find a mixer control element with the given name */
+static struct snd_kcontrol *snd_ac97_find_mixer_ctl(struct snd_ac97 *ac97,
+						    const char *name)
+{
+	struct snd_ctl_elem_id id;
+	memset(&id, 0, sizeof(id));
+	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	strcpy(id.name, name);
+	return snd_ctl_find_id(ac97->bus->card, &id);
+}
+
+/* create a virtual master control and add slaves */
+static int snd_ac97_add_vmaster(struct snd_ac97 *ac97, char *name,
+				const unsigned int *tlv, const char **slaves)
+{
+	struct snd_kcontrol *kctl;
+	const char **s;
+	int err;
+
+	kctl = snd_ctl_make_virtual_master(name, tlv);
+	if (!kctl)
+		return -ENOMEM;
+	err = snd_ctl_add(ac97->bus->card, kctl);
+	if (err < 0)
+		return err;
+
+	for (s = slaves; *s; s++) {
+		struct snd_kcontrol *sctl;
+
+		sctl = snd_ac97_find_mixer_ctl(ac97, *s);
+		if (!sctl) {
+			snd_printdd("Cannot find slave %s, skipped\n", *s);
+			continue;
+		}
+		err = snd_ctl_add_slave(kctl, sctl);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
 /* The following snd_ac97_ymf753_... items added by David Shust (dshust@shustring.com) */
 /* Modified for YMF743 by Keita Maehara <maehara@debian.org> */
 
@@ -2940,6 +2981,49 @@
 	return 0;
 }
 
+static int patch_aztech_azf3328_specific(struct snd_ac97 *ac97)
+{
+	struct snd_kcontrol *kctl_3d_center =
+		snd_ac97_find_mixer_ctl(ac97, "3D Control - Center");
+	struct snd_kcontrol *kctl_3d_depth =
+		snd_ac97_find_mixer_ctl(ac97, "3D Control - Depth");
+
+	/*
+	 * 3D register is different from AC97 standard layout
+	 * (also do some renaming, to resemble Windows driver naming)
+	 */
+	if (kctl_3d_center) {
+		kctl_3d_center->private_value =
+			AC97_SINGLE_VALUE(AC97_3D_CONTROL, 1, 0x07, 0);
+		snd_ac97_rename_vol_ctl(ac97,
+			"3D Control - Center", "3D Control - Width"
+		);
+	}
+	if (kctl_3d_depth)
+		kctl_3d_depth->private_value =
+			AC97_SINGLE_VALUE(AC97_3D_CONTROL, 8, 0x03, 0);
+
+	/* Aztech Windows driver calls the
+	   equivalent control "Modem Playback", thus rename it: */
+	snd_ac97_rename_vol_ctl(ac97,
+		"Master Mono Playback", "Modem Playback"
+	);
+	snd_ac97_rename_vol_ctl(ac97,
+		"Headphone Playback", "FM Synth Playback"
+	);
+
+	return 0;
+}
+
+static const struct snd_ac97_build_ops patch_aztech_azf3328_ops = {
+	.build_specific	= patch_aztech_azf3328_specific
+};
+
+static int patch_aztech_azf3328(struct snd_ac97 *ac97)
+{
+	ac97->build_ops = &patch_aztech_azf3328_ops;
+	return 0;
+}
 
 /*
  * C-Media CM97xx codecs
@@ -3371,47 +3455,6 @@
 	NULL
 };
 
-/* find a mixer control element with the given name */
-static struct snd_kcontrol *snd_ac97_find_mixer_ctl(struct snd_ac97 *ac97,
-						    const char *name)
-{
-	struct snd_ctl_elem_id id;
-	memset(&id, 0, sizeof(id));
-	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-	strcpy(id.name, name);
-	return snd_ctl_find_id(ac97->bus->card, &id);
-}
-
-/* create a virtual master control and add slaves */
-static int snd_ac97_add_vmaster(struct snd_ac97 *ac97, char *name,
-				const unsigned int *tlv, const char **slaves)
-{
-	struct snd_kcontrol *kctl;
-	const char **s;
-	int err;
-
-	kctl = snd_ctl_make_virtual_master(name, tlv);
-	if (!kctl)
-		return -ENOMEM;
-	err = snd_ctl_add(ac97->bus->card, kctl);
-	if (err < 0)
-		return err;
-
-	for (s = slaves; *s; s++) {
-		struct snd_kcontrol *sctl;
-
-		sctl = snd_ac97_find_mixer_ctl(ac97, *s);
-		if (!sctl) {
-			snd_printdd("Cannot find slave %s, skipped\n", *s);
-			continue;
-		}
-		err = snd_ctl_add_slave(kctl, sctl);
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
-
 static int patch_vt1616_specific(struct snd_ac97 * ac97)
 {
 	struct snd_kcontrol *kctl;
