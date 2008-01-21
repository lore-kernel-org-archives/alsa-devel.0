From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH 1/2] hda: STAC92xx mono mixer controls
Date: Mon, 21 Jan 2008 12:12:31 -0500
Message-ID: <4794D27F.3080909@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp110.biz.mail.mud.yahoo.com (smtp110.biz.mail.mud.yahoo.com
	[68.142.201.179]) by alsa0.perex.cz (Postfix) with SMTP id 442F1245A4
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 18:12:31 +0100 (CET)
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

Added mono mixer volume/switch controls for STAC9205 and STAC925x codecs.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 4177ec41bbef pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Mon Jan 21 14:33:37 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Mon Jan 21 11:37:49 2008 -0500
@@ -572,6 +572,7 @@ static struct hda_verb stac925x_core_ini
 static struct hda_verb stac925x_core_init[] = {
 	/* set dac0mux for dac converter */
 	{ 0x06, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{ 0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{}
 };
 
@@ -600,6 +601,7 @@ static struct hda_verb stac9205_core_ini
 static struct hda_verb stac9205_core_init[] = {
 	/* set master volume and direct control */	
 	{ 0x24, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
+	{ 0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{}
 };
 
@@ -748,6 +750,9 @@ static struct snd_kcontrol_new stac92hd7
 
 static struct snd_kcontrol_new stac925x_mixer[] = {
 	STAC_INPUT_SOURCE(1),
+	HDA_CODEC_MUTE_MONO("Mono Playback Switch", 0x10, 0x1, 0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("Mono Playback Volume", 0x10, 0x1, 0, HDA_OUTPUT),
+
 	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x09, 0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Mux Volume", 0x0f, 0, HDA_OUTPUT),
@@ -757,6 +762,9 @@ static struct snd_kcontrol_new stac9205_
 static struct snd_kcontrol_new stac9205_mixer[] = {
 	STAC_INPUT_SOURCE(2),
 	STAC_ANALOG_LOOPBACK(0xFE0, 0x7E0, 1),
+
+	HDA_CODEC_MUTE_MONO("Mono Playback Switch", 0x14, 0x1, 0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("Mono Playback Volume", 0x14, 0x1, 0, HDA_OUTPUT),
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1d, 0x0, HDA_OUTPUT),
