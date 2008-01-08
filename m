From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: 92HD71BXX Mono Mute Support
Date: Tue, 08 Jan 2008 18:02:04 -0500
Message-ID: <478400EC.8090001@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050409000803090901080206"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp103.biz.mail.mud.yahoo.com (smtp103.biz.mail.mud.yahoo.com
	[68.142.200.238]) by alsa0.perex.cz (Postfix) with SMTP id 2C2EC24408
	for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2008 00:02:11 +0100 (CET)
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
Cc: tawai@suse.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050409000803090901080206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added a mono output mute mixer for the 92hd71bxx family of codecs, this 
also removes the need for the mono out node to explicitly unmuted in the 
core init.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------050409000803090901080206
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="92hd71bxx_mono_mute.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="92hd71bxx_mono_mute.patch"

diff -r b3915b3a8a22 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Tue Jan 08 12:33:19 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Tue Jan 08 17:58:12 2008 -0500
@@ -534,8 +534,6 @@ static struct hda_verb stac92hd71bxx_cor
 	{ 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	/* unmute mono out node */
-	{ 0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 };
 
 static struct hda_verb stac92hd71bxx_analog_core_init[] = {
@@ -553,8 +551,6 @@ static struct hda_verb stac92hd71bxx_ana
 	{ 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	/* unmute mono out node */
-	{ 0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{}
 };
 
@@ -714,6 +710,8 @@ static struct snd_kcontrol_new stac92hd7
 
 	HDA_CODEC_MUTE("Analog Loopback 1", 0x17, 0x3, HDA_INPUT),
 	HDA_CODEC_MUTE("Analog Loopback 2", 0x17, 0x4, HDA_INPUT),
+
+	HDA_CODEC_MUTE_MONO("Mono Playback Switch", 0x14, 0x1, 0, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -728,6 +726,8 @@ static struct snd_kcontrol_new stac92hd7
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x1, 0x1b, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_MUTE_MONO("Mono Playback Switch", 0x14, 0x1, 0, HDA_INPUT),
 	{ } /* end */
 };
 

--------------050409000803090901080206
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050409000803090901080206--
