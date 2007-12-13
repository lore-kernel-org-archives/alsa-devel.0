From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: 92HD73 DMIC Amps
Date: Thu, 13 Dec 2007 13:37:54 -0500
Message-ID: <47617C02.6060903@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080908070706010306000002"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp105.biz.mail.mud.yahoo.com (smtp105.biz.mail.mud.yahoo.com
	[68.142.200.253]) by alsa0.perex.cz (Postfix) with SMTP id 34400246C2
	for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2007 19:38:09 +0100 (CET)
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

This is a multi-part message in MIME format.
--------------080908070706010306000002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changed hardware gain mixers for the digital mic's from HDA_OUTPUT to 
HDA_INPUT.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------080908070706010306000002
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac92hd73_dmic_mixers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac92hd73_dmic_mixers.patch"

diff -r 51415b2a4cbb pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Thu Dec 13 17:51:00 2007 +0100
+++ b/pci/hda/patch_sigmatel.c	Thu Dec 13 13:25:46 2007 -0500
@@ -626,8 +626,8 @@ static struct snd_kcontrol_new stac92hd7
 	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A1, 3),
 
 	/* hardware gain controls */
-	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x14, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x13, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x14, 0x0, HDA_INPUT),
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x20, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),
@@ -657,8 +657,8 @@ static struct snd_kcontrol_new stac92hd7
 	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A1, 4),
 
 	/* hardware gain controls */
-	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x14, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x13, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x14, 0x0, HDA_INPUT),
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x20, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),
@@ -688,8 +688,8 @@ static struct snd_kcontrol_new stac92hd7
 	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A1, 5),
 
 	/* hardware gain controls */
-	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x14, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x13, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x14, 0x0, HDA_INPUT),
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x20, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),

--------------080908070706010306000002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080908070706010306000002--
