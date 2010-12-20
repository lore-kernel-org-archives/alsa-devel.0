From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/3] ALSA: HDA: Rename "Int Mic" to "Internal
	Mic"
Date: Mon, 20 Dec 2010 14:55:56 +0100
Message-ID: <4D0F606C.7000008@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020600030805050203080003"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D3A7245CE
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 14:56:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020600030805050203080003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------020600030805050203080003
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Rename-Int-Mic-to-Internal-Mic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ALSA-HDA-Rename-Int-Mic-to-Internal-Mic.patch"

>From c3cd7abfecec21c2ee9efeb615633bd1fd9012b6 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 20 Dec 2010 14:24:29 +0100
Subject: [PATCH 1/3] ALSA: HDA: Rename "Int Mic" to "Internal Mic"

"Int Mic" and "Internal Mic" both mean the same thing, so rename
the former to the latter in order to clean up the namespace a little.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |   36 ++++++++++----------
 sound/pci/hda/patch_realtek.c  |   72 ++++++++++++++++++++--------------------
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index e584b3d..62acf10 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -869,14 +869,14 @@ static void cxt5045_hp_unsol_event(struct hda_codec *codec,
 }
 
 static struct snd_kcontrol_new cxt5045_mixers[] = {
-	HDA_CODEC_VOLUME("Int Mic Capture Volume", 0x1a, 0x01, HDA_INPUT),
-	HDA_CODEC_MUTE("Int Mic Capture Switch", 0x1a, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Capture Volume", 0x1a, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Capture Switch", 0x1a, 0x01, HDA_INPUT),
 	HDA_CODEC_VOLUME("Ext Mic Capture Volume", 0x1a, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Ext Mic Capture Switch", 0x1a, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("PCM Playback Volume", 0x17, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("PCM Playback Switch", 0x17, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x17, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x17, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x17, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x17, 0x1, HDA_INPUT),
 	HDA_CODEC_VOLUME("Ext Mic Playback Volume", 0x17, 0x2, HDA_INPUT),
 	HDA_CODEC_MUTE("Ext Mic Playback Switch", 0x17, 0x2, HDA_INPUT),
 	HDA_BIND_VOL("Master Playback Volume", &cxt5045_hp_bind_master_vol),
@@ -910,14 +910,14 @@ static struct snd_kcontrol_new cxt5045_benq_mixers[] = {
 };
 
 static struct snd_kcontrol_new cxt5045_mixers_hp530[] = {
-	HDA_CODEC_VOLUME("Int Mic Capture Volume", 0x1a, 0x02, HDA_INPUT),
-	HDA_CODEC_MUTE("Int Mic Capture Switch", 0x1a, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Capture Volume", 0x1a, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Capture Switch", 0x1a, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Ext Mic Capture Volume", 0x1a, 0x01, HDA_INPUT),
 	HDA_CODEC_MUTE("Ext Mic Capture Switch", 0x1a, 0x01, HDA_INPUT),
 	HDA_CODEC_VOLUME("PCM Playback Volume", 0x17, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("PCM Playback Switch", 0x17, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x17, 0x2, HDA_INPUT),
-	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x17, 0x2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x17, 0x2, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x17, 0x2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Ext Mic Playback Volume", 0x17, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Ext Mic Playback Switch", 0x17, 0x1, HDA_INPUT),
 	HDA_BIND_VOL("Master Playback Volume", &cxt5045_hp_bind_master_vol),
@@ -947,7 +947,7 @@ static struct hda_verb cxt5045_init_verbs[] = {
 	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
 	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
 	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
-	/* Record selector: Int mic */
+	/* Record selector: Internal mic */
 	{0x1a, AC_VERB_SET_CONNECT_SEL,0x1},
 	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE,
 	 AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x17},
@@ -960,7 +960,7 @@ static struct hda_verb cxt5045_init_verbs[] = {
 };
 
 static struct hda_verb cxt5045_benq_init_verbs[] = {
-	/* Int Mic, Mic */
+	/* Internal Mic, Mic */
 	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
 	/* Line In,HP, Amp  */
@@ -973,7 +973,7 @@ static struct hda_verb cxt5045_benq_init_verbs[] = {
 	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
 	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
 	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
-	/* Record selector: Int mic */
+	/* Record selector: Internal mic */
 	{0x1a, AC_VERB_SET_CONNECT_SEL, 0x1},
 	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE,
 	 AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x17},
@@ -1847,7 +1847,7 @@ static struct hda_verb cxt5051_init_verbs[] = {
 	{0x16, AC_VERB_SET_CONNECT_SEL, 0x00},
 	/* DAC1 */	
 	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	/* Record selector: Int mic */
+	/* Record selector: Internal mic */
 	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) | 0x44},
 	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1) | 0x44},
 	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) | 0x44},
@@ -1874,7 +1874,7 @@ static struct hda_verb cxt5051_hp_dv6736_init_verbs[] = {
 	{0x16, AC_VERB_SET_CONNECT_SEL, 0x00},
 	/* DAC1 */
 	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	/* Record selector: Int mic */
+	/* Record selector: Internal mic */
 	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1) | 0x44},
 	{0x14, AC_VERB_SET_CONNECT_SEL, 0x1},
 	/* SPDIF route: PCM */
@@ -1904,7 +1904,7 @@ static struct hda_verb cxt5051_lenovo_x200_init_verbs[] = {
 	{0x19, AC_VERB_SET_CONNECT_SEL, 0x00},
 	/* DAC1 */
 	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	/* Record selector: Int mic */
+	/* Record selector: Internal mic */
 	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) | 0x44},
 	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1) | 0x44},
 	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) | 0x44},
@@ -1932,7 +1932,7 @@ static struct hda_verb cxt5051_f700_init_verbs[] = {
 	{0x16, AC_VERB_SET_CONNECT_SEL, 0x00},
 	/* DAC1 */
 	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-	/* Record selector: Int mic */
+	/* Record selector: Internal mic */
 	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1) | 0x44},
 	{0x14, AC_VERB_SET_CONNECT_SEL, 0x1},
 	/* SPDIF route: PCM */
@@ -2729,7 +2729,7 @@ static struct snd_kcontrol_new cxt5066_mixers[] = {
 static struct snd_kcontrol_new cxt5066_vostro_mixers[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Int Mic Boost Capture Enum",
+		.name = "Internal Mic Boost Capture Enum",
 		.info = cxt5066_mic_boost_mux_enum_info,
 		.get = cxt5066_mic_boost_mux_enum_get,
 		.put = cxt5066_mic_boost_mux_enum_put,
@@ -2955,7 +2955,7 @@ static struct hda_verb cxt5066_init_verbs_ideapad[] = {
 	{0x22, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 
 	/* internal microphone */
-	{0x23, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN}, /* enable int mic */
+	{0x23, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN}, /* enable internal mic */
 
 	/* EAPD */
 	{0x1d, AC_VERB_SET_EAPD_BTLENABLE, 0x2}, /* default on */
@@ -3010,7 +3010,7 @@ static struct hda_verb cxt5066_init_verbs_thinkpad[] = {
 	{0x22, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 
 	/* internal microphone */
-	{0x23, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN}, /* enable int mic */
+	{0x23, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN}, /* enable internal mic */
 
 	/* EAPD */
 	{0x1d, AC_VERB_SET_EAPD_BTLENABLE, 0x2}, /* default on */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 487015d..1506292 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2169,7 +2169,7 @@ static struct hda_input_mux alc888_acer_aspire_6530_sources[2] = {
 			{ "Line In", 0x2 },
 			{ "CD", 0x4 },
 			{ "Input Mix", 0xa },
-			{ "Int Mic", 0xb },
+			{ "Internal Mic", 0xb },
 		},
 	},
 	{
@@ -2843,8 +2843,8 @@ static struct snd_kcontrol_new alc880_fujitsu_mixer[] = {
 	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_VOLUME("Ext Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Ext Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -7451,7 +7451,7 @@ static struct hda_input_mux alc883_lenovo_nb0763_capture_source = {
 	.num_items = 4,
 	.items = {
 		{ "Mic", 0x0 },
-		{ "Int Mic", 0x1 },
+		{ "Internal Mic", 0x1 },
 		{ "Line", 0x2 },
 		{ "CD", 0x4 },
 	},
@@ -7461,7 +7461,7 @@ static struct hda_input_mux alc883_fujitsu_pi2515_capture_source = {
 	.num_items = 2,
 	.items = {
 		{ "Mic", 0x0 },
-		{ "Int Mic", 0x1 },
+		{ "Internal Mic", 0x1 },
 	},
 };
 
@@ -8824,9 +8824,9 @@ static struct snd_kcontrol_new alc883_clevo_m720_mixer[] = {
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
-	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -8838,9 +8838,9 @@ static struct snd_kcontrol_new alc883_2ch_fujitsu_pi2515_mixer[] = {
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
-	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -8986,18 +8986,18 @@ static struct snd_kcontrol_new alc883_targa_2ch_mixer[] = {
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
-	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
 
 static struct snd_kcontrol_new alc883_targa_8ch_mixer[] = {
 	HDA_CODEC_VOLUME("Side Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Side Playback Switch", 0x0f, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
-	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -9021,8 +9021,8 @@ static struct snd_kcontrol_new alc883_lenovo_nb0763_mixer[] = {
 	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -11676,7 +11676,7 @@ static struct hda_input_mux alc262_fujitsu_capture_source = {
 	.num_items = 3,
 	.items = {
 		{ "Mic", 0x0 },
-		{ "Int Mic", 0x1 },
+		{ "Internal Mic", 0x1 },
 		{ "CD", 0x4 },
 	},
 };
@@ -11831,9 +11831,9 @@ static struct snd_kcontrol_new alc262_fujitsu_mixer[] = {
 	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -11867,9 +11867,9 @@ static struct snd_kcontrol_new alc262_lenovo_3000_mixer[] = {
 	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -13248,7 +13248,7 @@ static struct snd_kcontrol_new alc267_quanta_il1_mixer[] = {
 	HDA_CODEC_VOLUME("Mic Capture Volume", 0x23, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Mic Capture Switch", 0x23, 2, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Ext Mic Boost", 0x18, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
 	{ }
 };
 
@@ -16380,7 +16380,7 @@ static struct hda_input_mux alc861vd_dallas_capture_source = {
 	.num_items = 2,
 	.items = {
 		{ "Ext Mic", 0x0 },
-		{ "Int Mic", 0x1 },
+		{ "Internal Mic", 0x1 },
 	},
 };
 
@@ -16521,7 +16521,7 @@ static struct snd_kcontrol_new alc861vd_lenovo_mixer[] = {
 };
 
 /* Pin assignment: Speaker=0x14, HP = 0x15,
- *                 Ext Mic=0x18, Int Mic = 0x19, CD = 0x1c, PC Beep = 0x1d
+ *                 Ext Mic=0x18, Internal Mic = 0x19, CD = 0x1c, PC Beep = 0x1d
  */
 static struct snd_kcontrol_new alc861vd_dallas_mixer[] = {
 	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x02, 0x0, HDA_OUTPUT),
@@ -16531,9 +16531,9 @@ static struct snd_kcontrol_new alc861vd_dallas_mixer[] = {
 	HDA_CODEC_VOLUME("Ext Mic Boost", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Ext Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Ext Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -18550,9 +18550,9 @@ static struct snd_kcontrol_new alc272_nc10_mixer[] = {
 	HDA_CODEC_MUTE("Ext Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Ext Mic Boost", 0x18, 0, HDA_INPUT),
 
-	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -19595,7 +19595,7 @@ static struct snd_kcontrol_new alc680_base_mixer[] = {
 	HDA_CODEC_MUTE("Front Playback Switch", 0x14, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x4, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x16, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Int Mic Boost", 0x12, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost", 0x12, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Line In Boost", 0x19, 0, HDA_INPUT),
 	{ }
-- 
1.7.1


--------------020600030805050203080003
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020600030805050203080003--
