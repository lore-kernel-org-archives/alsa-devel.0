From: Hector Martin <hector@marcansoft.com>
Subject: HDA: CLFE DAC on ALC889 (Acer Aspire 8930G)
Date: Wed, 03 Dec 2008 01:59:14 +0100
Message-ID: <4935D9E2.1040704@marcansoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070404090902050101040901"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.marcansoft.com (marcansoft.com [80.68.93.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EFDD24370
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 01:59:17 +0100 (CET)
Received: from [192.168.3.170] (233.Red-81-36-254.dynamicIP.rima-tde.net
	[81.36.254.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.marcansoft.com (Postfix) with ESMTP id 1379F6523A
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 01:59:15 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070404090902050101040901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've been trying to get ALSA working with this laptop. So far the 
attached patch adds rear support to the existing 4930g model, and tries 
to add CLFE support. However, I haven't been able to get CLFE to work. I 
don't seem to get any audio through DACs/mixers other than the first two 
(front and rear).

I can assign the CLFE output (pin 0x16) to the front or rear DAC and 
hear the front audio through the CLFE speakers. I can also force the 
front DAC (0x02) or rear DAC (0x03) to use the CLFE stream and hear it 
through the front or rear speakers, so the audio is getting to the 
codec. But either DACs 0x04 and 0x05 aren't working, or their associated 
mixers (0x0e and 0x0f) aren't passing through the audio, or the OUT pins 
don't like selections above 1. I've checked that they're unmuted and 
that the volumes are turned up on both. I've also tried the 0x25->0x26 
DAC/mixer auxiliary pathway, which doesn't work either.

Here's what the relevant NIDs correspond to:
0x02 - (normally) Front DAC
0x03 - (normally) Rear DAC
0x04 - (normally) CLFE DAC
0x05 - (presumably) side DAC (no side speakers)

0x0c - (normally) Front mixer
0x0d - (normally) Rear mixer
0x0e - (normally) CLFE mixer
0x0f - (presumably) side mixer

0x14 - Front speakers pin
0x15 - Headphones pin (also EAPD for speaker amp)
0x16 - CLFE speakers pin
0x1b - Rear speakers pin

Here's what the codec graph looks like:
http://marcansoft.com/transf/codec.png

Any ideas? I'm pretty stumped here. Are there any other magic bits to 
enable the remaining DACs or mixers?


-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc


--------------070404090902050101040901
Content-Type: text/plain;
 name="0001-Add-partial-8930G-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Add-partial-8930G-support.patch"

>From 8aaa46dfda9b7c0ab19021532750adb03ded877e Mon Sep 17 00:00:00 2001
From: Hector Martin <hector@marcansoft.com>
Date: Wed, 3 Dec 2008 01:50:49 +0100
Subject: [PATCH - snd-intel-hda 1/1] Add partial 8930G support


Signed-off-by: Hector Martin <hector@marcansoft.com>

diff --git a/pci/hda/patch_realtek.c b/pci/hda/patch_realtek.c
index 4afa0c9..6d6e06a 100644
--- a/pci/hda/patch_realtek.c
+++ b/pci/hda/patch_realtek.c
@@ -1302,7 +1302,7 @@ static struct hda_verb alc888_acer_aspire_4930g_verbs[] = {
 	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0xb)},
 /* Enable unsolicited event for HP jack */
 	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
-/* Connect Internal HP to front */
+/* Connect Front speakers to front */
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
 	{0x14, AC_VERB_SET_CONNECT_SEL, 0x00},
@@ -1310,6 +1310,16 @@ static struct hda_verb alc888_acer_aspire_4930g_verbs[] = {
 	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
 	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
+/* Connect Rear speakers to rear */
+	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x1b, AC_VERB_SET_CONNECT_SEL, 0x01},
+/* Connect CLFE speakers to CLFE */
+	{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x16, AC_VERB_SET_CONNECT_SEL, 0x02},
+/* Set EAPD to enable speakers */
+	{0x15, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
 	{ }
 };
 
@@ -1365,8 +1375,15 @@ static void alc888_acer_aspire_4930g_automute(struct hda_codec *codec)
 	present = snd_hda_codec_read(codec, 0x15, 0,
 				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
 	bits = present ? HDA_AMP_MUTE : 0;
+	/* Front */
 	snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
 				 HDA_AMP_MUTE, bits);
+	/* CLFE */
+	snd_hda_codec_amp_stereo(codec, 0x16, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, bits);
+	/* Rear */
+	snd_hda_codec_amp_stereo(codec, 0x1b, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, bits);
 }
 
 static void alc888_acer_aspire_4930g_unsol_event(struct hda_codec *codec,
-- 
1.5.6.4


--------------070404090902050101040901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070404090902050101040901--
