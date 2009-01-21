From: Hector Martin <hector@marcansoft.com>
Subject: Re: Acer Aspire 8920g / snd-hda-intel /
 ALC889	/	surround sound
Date: Wed, 21 Jan 2009 23:31:30 +0100
Message-ID: <4977A242.3080504@marcansoft.com>
References: <20081225192456.GA16788@deadlock.dhs.org>	<20090105201722.GA23503@deadlock.dhs.org>
	<20090114141402.GA14581@deadlock.dhs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060204020609000202040409"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.marcansoft.com (marcansoft.com [80.68.93.119])
	by alsa0.perex.cz (Postfix) with ESMTP id D2658103873
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 23:31:38 +0100 (CET)
In-Reply-To: <20090114141402.GA14581@deadlock.dhs.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sergey 'Jin' Bostandzhyan <jin@deadlock.dhs.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060204020609000202040409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I was able to get audio to work on an Aspire 8930G using the attached
patch, including routing all speakers. However, I could never get any
DACs other than the first two to work. I've been holding off on making a
real patch to add full support properly until I fix this issue.

Can you test the patch? For me, only Front and Rear work, not Center/Sub.

I'm currently using a nasty hack which routes DAC 0 to both Front and
Rear and DAC 1 to CLFE and some asound.conf magic to make it sound
decent, but it's 3.1 sound, not 5.1.

I managed to get hda-analyzer to work and confirmed that the audio does
get to the DACs (if I configure the Rear DAC to the CLFE stream
dynamically it does work), but "something" is making all but the first
to DACs not work. It could also be the mixers attached to the DACs - the
actual audio outputs are okay because I can route them to the working
DACs and get output. I've tried tweaking everything and ensured that
everything was turned up and unmuted, but I've run out of ideas.

Recently I've also tested the three audio jacks in 5.1 output mode. Same
problem - the CLFE *output* works but I get no sound unless I hack the
routing to connect it to the other DACs.

I'm starting to suspect that there's some proprietary Realtek init
missing - maybe some tables or something related to the "encryption module".

Here's a little render that I made of the codec routing:
http://marcansoft.com/transf/codec.png


-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc


--------------060204020609000202040409
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


--------------060204020609000202040409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060204020609000202040409--
