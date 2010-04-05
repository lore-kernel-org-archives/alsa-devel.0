From: Tony Vroon <tony@linx.net>
Subject: [PATCH] Enable amplifiers on Acer Inspire 6530G
Date: Mon,  5 Apr 2010 16:30:43 +0100 (BST)
Message-ID: <20100405153043.84D4010077@gold.linx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id AFEFB24402
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Apr 2010 17:30:48 +0200 (CEST)
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

After more tests it appears that EAPD needs to be enabled 
on both the 0x14 and 0x15 NIDs to enable the main speaker
and headphone amplifiers. The maximum volume setting is 
now equal to what the machine achieves under other operating 
systems.
Disabling Front or LFE playback triggers EAPD and disables 
the amplifier. As such, these two playback switches have 
been removed from the mixer.

Signed-off-by: Tony Vroon <tony@linx.net>
---
Takashi, I would appreciate it if this could make it for 2.6.34; 
it could be explained as a regression in the earlier 6530g changes.

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1621,6 +1621,11 @@ static struct hda_verb alc888_acer_aspire_4930g_verbs[] = {
  */
 
 static struct hda_verb alc888_acer_aspire_6530g_verbs[] = {
+/* Route to built-in subwoofer as well as speakers */
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
 /* Bias voltage on for external mic port */
 	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN | PIN_VREF80},
 /* Front Mic: set to PIN_IN (empty by default) */
@@ -1632,10 +1637,12 @@ static struct hda_verb alc888_acer_aspire_6530g_verbs[] = {
 /* Enable speaker output */
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x14, AC_VERB_SET_EAPD_BTLENABLE, 2},
 /* Enable headphone output */
 	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT | PIN_HP},
 	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
 	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{0x15, AC_VERB_SET_EAPD_BTLENABLE, 2},
 	{ }
 };
 
@@ -8398,9 +8405,7 @@ static struct snd_kcontrol_new alc883_acer_aspire_mixer[] = {
 
 static struct snd_kcontrol_new alc888_acer_aspire_6530_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("LFE Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("LFE Playback Switch", 0x0f, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
