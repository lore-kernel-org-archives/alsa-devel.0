From: Jaroslaw Sobierski <fycio@gucio.com>
Subject: Re: S/PDIF on AD1980 patch
Date: Mon, 17 Feb 2003 11:36:34 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045510594.3e5139c2531dd@webmail.namezero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

OK, here is the unified diff. Two of them actually, i separated the 
different options for better clarity.

   Option 1 : The simple switch control 

Index: ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.66
diff -u -r1.66 ac97_codec.c
--- ac97_codec.c	17 Feb 2003 10:32:04 -0000	1.66
+++ ac97_codec.c	17 Feb 2003 19:25:50 -0000
@@ -1022,6 +1022,9 @@
 AD18XX_PCM_BITS("LFE Playback Volume", 2, 0, 31)
 };
 
+static const snd_kcontrol_new_t snd_ac97_ad1980_spdif_link =
+    AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Link",
AC97_AD_SERIAL_CFG, 2, 1, 0);
+
 /*
  * ALC650
  */
@@ -1679,6 +1682,10 @@
 			if (ac97->id == AC97_ID_YMF753) {
 				for (idx = 0; idx < 3; idx++)
 					if ((err = snd_ctl_add(card,
snd_ac97_cnew(&snd_ac97_ymf753_controls_spdif[idx], ac97))) < 0)
+						return err;
+			}
+			if (ac97->id == AC97_ID_AD1980) {
+					if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_ad1980_spdif_link,
ac97))) < 0)
 						return err;
 			}
 			/* set default PCM S/PDIF params */
Index: ac97_id.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_id.h,v
retrieving revision 1.6
diff -u -r1.6 ac97_id.h
--- ac97_id.h	3 Dec 2002 17:46:53 -0000	1.6
+++ ac97_id.h	17 Feb 2003 19:25:50 -0000
@@ -31,6 +31,7 @@
 #define AC97_ID_AD1886		0x41445361
 #define AC97_ID_AD1887		0x41445362
 #define AC97_ID_AD1886A		0x41445363
+#define AC97_ID_AD1980 		0x41445370
 #define AC97_ID_TR28028		0x54524108
 #define AC97_ID_STAC9700	0x83847600
 #define AC97_ID_STAC9704	0x83847604
===================================================================

   Option 2 : The enumerated (more readable but more code) control

Index: ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.66
diff -u -r1.66 ac97_codec.c
--- ac97_codec.c	17 Feb 2003 10:32:04 -0000	1.66
+++ ac97_codec.c	17 Feb 2003 19:25:09 -0000
@@ -1022,6 +1022,49 @@
 AD18XX_PCM_BITS("LFE Playback Volume", 2, 0, 31)
 };
 
+static int snd_ac97_ad1980_spdif_source_info(snd_kcontrol_t *kcontrol,
snd_ctl_elem_info_t * uinfo)
+{
+	static char *texts[2] = { "AC-Link", "A/D Converter" };
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+	if (uinfo->value.enumerated.item > 1)
+		uinfo->value.enumerated.item = 1;
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int snd_ac97_ad1980_spdif_source_get(snd_kcontrol_t * kcontrol,
snd_ctl_elem_value_t * ucontrol)
+{
+	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+
+	val = ac97->regs[AC97_AD_SERIAL_CFG];
+	ucontrol->value.enumerated.item[0] = (val >> 2) & 1;
+	return 0;
+}
+
+static int snd_ac97_ad1980_spdif_source_put(snd_kcontrol_t * kcontrol,
snd_ctl_elem_value_t * ucontrol)
+{
+	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+
+	if (ucontrol->value.enumerated.item[0] > 1)
+		return -EINVAL;
+	val = ucontrol->value.enumerated.item[0] << 2;
+	return snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 0x0004, val);
+}
+
+static const snd_kcontrol_new_t snd_ac97_ad1980_spdif_source =
+	{
+		iface: SNDRV_CTL_ELEM_IFACE_MIXER,
+		name: SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Source",
+		info: snd_ac97_ad1980_spdif_source_info,
+		get: snd_ac97_ad1980_spdif_source_get,
+		put: snd_ac97_ad1980_spdif_source_put,
+	};
+
 /*
  * ALC650
  */
@@ -1679,6 +1722,10 @@
 			if (ac97->id == AC97_ID_YMF753) {
 				for (idx = 0; idx < 3; idx++)
 					if ((err = snd_ctl_add(card,
snd_ac97_cnew(&snd_ac97_ymf753_controls_spdif[idx], ac97))) < 0)
+						return err;
+			}
+			if (ac97->id == AC97_ID_AD1980) {
+					if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_ad1980_spdif_source,
ac97))) < 0)
 						return err;
 			}
 			/* set default PCM S/PDIF params */
Index: ac97_id.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_id.h,v
retrieving revision 1.6
diff -u -r1.6 ac97_id.h
--- ac97_id.h	3 Dec 2002 17:46:53 -0000	1.6
+++ ac97_id.h	17 Feb 2003 19:25:09 -0000
@@ -31,6 +31,7 @@
 #define AC97_ID_AD1886		0x41445361
 #define AC97_ID_AD1887		0x41445362
 #define AC97_ID_AD1886A		0x41445363
+#define AC97_ID_AD1980 		0x41445370
 #define AC97_ID_TR28028		0x54524108
 #define AC97_ID_STAC9700	0x83847600
 #define AC97_ID_STAC9704	0x83847604
===================================================================

See previous post for details.

--------------
Fycio (J.Sobierski)
 fycio@gucio.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
