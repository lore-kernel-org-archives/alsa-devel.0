From: Andrew Paprocki <andrew@ishiboo.com>
Subject: [PATCH] hda-codec - Add missing #defines (and 1
	rename) in hda_codec.h
Date: Tue, 18 Dec 2007 21:49:54 -0400
Message-ID: <54a57ee44eb6095dc1eb.1198032594@firewall.26broadway.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id F0A40245B8
	for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2007 06:56:15 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id u77so4625187pyb.16
	for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2007 21:56:14 -0800 (PST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Added AC_VERB_GET_DIGI_CONVERT_2 and renamed AC_VERB_GET_DIGI_CONVERT to
AC_VERB_GET_DIGI_CONVERT_1 to stay consistent with the SET variants. Added
AC_VERB_GET_GPIO_UNSOLICITED_RSP_MASK, AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK,
and AC_PINCAP_LR_SWAP. The missing fields were listed in the ALC883 datasheet
rev 1.3.

Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>

diff -r fbe3540c8df4 -r 54a57ee44eb6 pci/hda/hda_codec.c
--- a/pci/hda/hda_codec.c	Tue Dec 18 18:05:52 2007 +0100
+++ b/pci/hda/hda_codec.c	Tue Dec 18 21:48:58 2007 -0500
@@ -1435,7 +1435,8 @@ int snd_hda_create_spdif_out_ctls(struct
 			return err;
 	}
 	codec->spdif_ctls =
-		snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_DIGI_CONVERT, 0);
+		snd_hda_codec_read(codec, nid, 0,
+				   AC_VERB_GET_DIGI_CONVERT_1, 0);
 	codec->spdif_status = convert_to_spdif_status(codec->spdif_ctls);
 	return 0;
 }
@@ -1482,7 +1483,7 @@ static int snd_hda_spdif_in_status_get(s
 	unsigned short val;
 	unsigned int sbits;
 
-	val = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_DIGI_CONVERT, 0);
+	val = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_DIGI_CONVERT_1, 0);
 	sbits = convert_to_spdif_status(val);
 	ucontrol->value.iec958.status[0] = sbits;
 	ucontrol->value.iec958.status[1] = sbits >> 8;
@@ -1533,7 +1534,8 @@ int snd_hda_create_spdif_in_ctls(struct 
 			return err;
 	}
 	codec->spdif_in_enable =
-		snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_DIGI_CONVERT, 0) &
+		snd_hda_codec_read(codec, nid, 0,
+				   AC_VERB_GET_DIGI_CONVERT_1, 0) &
 		AC_DIG1_ENABLE;
 	return 0;
 }
diff -r fbe3540c8df4 -r 54a57ee44eb6 pci/hda/hda_codec.h
--- a/pci/hda/hda_codec.h	Tue Dec 18 18:05:52 2007 +0100
+++ b/pci/hda/hda_codec.h	Tue Dec 18 21:48:58 2007 -0500
@@ -77,12 +77,14 @@ enum {
 #define AC_VERB_GET_PIN_SENSE			0x0f09
 #define AC_VERB_GET_BEEP_CONTROL		0x0f0a
 #define AC_VERB_GET_EAPD_BTLENABLE		0x0f0c
-#define AC_VERB_GET_DIGI_CONVERT		0x0f0d
+#define AC_VERB_GET_DIGI_CONVERT_1		0x0f0d
+#define AC_VERB_GET_DIGI_CONVERT_2		0x0f0e
 #define AC_VERB_GET_VOLUME_KNOB_CONTROL		0x0f0f
 /* f10-f1a: GPIO */
 #define AC_VERB_GET_GPIO_DATA			0x0f15
 #define AC_VERB_GET_GPIO_MASK			0x0f16
 #define AC_VERB_GET_GPIO_DIRECTION		0x0f17
+#define AC_VERB_GET_GPIO_UNSOLICITED_RSP_MASK	0x0f19
 #define AC_VERB_GET_CONFIG_DEFAULT		0x0f1c
 /* f20: AFG/MFG */
 #define AC_VERB_GET_SUBSYSTEM_ID		0x0f20
@@ -110,6 +112,7 @@ enum {
 #define AC_VERB_SET_GPIO_DATA			0x715
 #define AC_VERB_SET_GPIO_MASK			0x716
 #define AC_VERB_SET_GPIO_DIRECTION		0x717
+#define AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK	0x719
 #define AC_VERB_SET_CONFIG_DEFAULT_BYTES_0	0x71c
 #define AC_VERB_SET_CONFIG_DEFAULT_BYTES_1	0x71d
 #define AC_VERB_SET_CONFIG_DEFAULT_BYTES_2	0x71e
@@ -190,6 +193,10 @@ enum {
 #define AC_PINCAP_OUT			(1<<4)	/* output capable */
 #define AC_PINCAP_IN			(1<<5)	/* input capable */
 #define AC_PINCAP_BALANCE		(1<<6)	/* balanced I/O capable */
+/* Note: This LR_SWAP pincap is defined in the Realtek ALC883 specification,
+ *       but is marked reserved in the Intel HDA specification.
+ */
+#define AC_PINCAP_LR_SWAP		(1<<7)	/* L/R swap */
 #define AC_PINCAP_VREF			(0x37<<8)
 #define AC_PINCAP_VREF_SHIFT		8
 #define AC_PINCAP_EAPD			(1<<16)	/* EAPD capable */
diff -r fbe3540c8df4 -r 54a57ee44eb6 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Tue Dec 18 18:05:52 2007 +0100
+++ b/pci/hda/patch_realtek.c	Tue Dec 18 21:48:58 2007 -0500
@@ -572,7 +572,7 @@ static int alc_spdif_ctrl_get(struct snd
 	unsigned char mask = (kcontrol->private_value >> 16) & 0xff;
 	long *valp = ucontrol->value.integer.value;
 	unsigned int val = snd_hda_codec_read(codec, nid, 0,
-					      AC_VERB_GET_DIGI_CONVERT, 0x00);
+					      AC_VERB_GET_DIGI_CONVERT_1, 0x00);
 
 	*valp = (val & mask) != 0;
 	return 0;
@@ -586,7 +586,7 @@ static int alc_spdif_ctrl_put(struct snd
 	unsigned char mask = (kcontrol->private_value >> 16) & 0xff;
 	long val = *ucontrol->value.integer.value;
 	unsigned int ctrl_data = snd_hda_codec_read(codec, nid, 0,
-						    AC_VERB_GET_DIGI_CONVERT,
+						    AC_VERB_GET_DIGI_CONVERT_1,
 						    0x00);
 
 	/* Set/unset the masked control bit(s) as needed */
