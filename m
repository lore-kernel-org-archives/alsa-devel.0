From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: STAC92HD71 codec mixer
Date: Tue, 06 Nov 2007 21:33:22 -0500
Message-ID: <473123F2.3050901@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050704010801020605080708"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp109.biz.mail.re2.yahoo.com (smtp109.biz.mail.re2.yahoo.com
	[206.190.53.8]) by alsa0.perex.cz (Postfix) with SMTP id D9FE224424
	for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2007 03:33:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050704010801020605080708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added analog loopback support and missing ADC capture mixer for the 
STAC92HD71 codec family.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------050704010801020605080708
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac92hd71_mixer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac92hd71_mixer.patch"

diff -r 43708ece3f6f pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Tue Nov 06 11:56:17 2007 +0100
+++ b/pci/hda/patch_sigmatel.c	Tue Nov 06 21:05:54 2007 -0500
@@ -428,6 +428,11 @@ static struct hda_verb stac92hd71bxx_cor
 	{ 0x28, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
 	/* connect headphone jack to dac1 */
 	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
+	/* connect ports 0d and 0f to audio mixer */ 
+	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x2},
+	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x2},
+	/* unmute dac0 input in audio mixer */ 
+	{ 0x17, AC_VERB_SET_AMP_GAIN_MUTE, 0x701f},
 	/* unmute right and left channels for nodes 0x0a, 0xd, 0x0f */
 	{ 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
@@ -512,8 +517,7 @@ static struct hda_verb stac9205_core_ini
 		.put   = stac92xx_volknob_put, \
 			.private_value = 127 | (knob_nid << 16), \
 	}
-
-
+ 
 static struct snd_kcontrol_new stac9200_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0xb, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Master Playback Switch", 0xb, 0, HDA_OUTPUT),
@@ -530,12 +534,19 @@ static struct snd_kcontrol_new stac92hd7
 	STAC_VOLKNOB(0x28),
 
 	/* hardware gain controls */
-	HDA_CODEC_VOLUME("Digital Mic 1 Volume", 0x18, 0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Digital Mic 2 Volume", 0x19, 0, HDA_OUTPUT),
-
-	HDA_CODEC_VOLUME("Capture Volume", 0x1c, 0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x1c, 0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Capture Mux Volume", 0x1a, 0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x18, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x19, 0x0, HDA_OUTPUT),
+	
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x0, 0x1a, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x1d, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1d, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x1, 0x1b, 0x0, HDA_OUTPUT),
+	
+	HDA_CODEC_MUTE("Analog Loopback 1", 0x17, 0x3, HDA_INPUT),
+	HDA_CODEC_MUTE("Analog Loopback 2", 0x17, 0x4, HDA_INPUT),
 	{ } /* end */
 };
 

--------------050704010801020605080708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050704010801020605080708--
