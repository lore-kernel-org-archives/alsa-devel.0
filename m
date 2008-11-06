From: Tony Vroon <tony@linx.net>
Subject: [PATCH] Add lifebook model for Realtek ALC269
Date: Thu,  6 Nov 2008 15:08:49 +0000 (GMT)
Message-ID: <20081106150849.EB38B1008F@gold.linx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CEE51037E3
	for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2008 16:08:55 +0100 (CET)
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

The widget layout of the Fujitsu Lifebook S6420 (which is ICH9M-based and uses an ALC269)
is similar but not identical to the Lifebook S6410/E8410 (which are ICH8M-based and use
an ALC262).
It is named lifebook as fujitsu is in use for Amilo machines. This builds on the Quanta FL1 
work and supports all analog inputs & outputs that I am aware of. Microphone autoswitch is 
implemented. The laptop mic port takes precedence over the dock mic port if both happen to 
have a jack plugged in. This made sense to me as a design decision (imagine a presentation 
environment with the dock fully wired in and the presenter quickly wanting to override the 
mic with a headset).

There is mention of a digital audio path on the codec graph, so perhaps the headphone
socket is dual-function analog/digital. I will follow up with another patch if I can
acquire equipment to test this.

Signed-off-by: Tony Vroon <tony@linx.net>
--- patch_realtek.c.orig	2008-11-06 14:05:06.000000000 +0000
+++ patch_realtek.c	2008-11-06 14:19:51.000000000 +0000
@@ -132,6 +132,7 @@
 	ALC269_ASUS_EEEPC_P703,
 	ALC269_ASUS_EEEPC_P901,
 	ALC269_FUJITSU,
+	ALC269_LIFEBOOK,
 	ALC269_AUTO,
 	ALC269_MODEL_LAST /* last tag */
 };
@@ -11703,6 +11704,31 @@
 	{ }
 };
 
+static struct snd_kcontrol_new alc269_lifebook_mixer[] = {
+	/* output mixer control */
+	HDA_BIND_VOL("Master Playback Volume", &alc268_acer_bind_master_vol),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Playback Switch",
+		.info = snd_hda_mixer_amp_switch_info,
+		.get = snd_hda_mixer_amp_switch_get,
+		.put = alc268_acer_master_sw_put,
+		.private_value = HDA_COMPOSE_AMP_VAL(0x14, 3, 0, HDA_OUTPUT),
+	},
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Dock Mic Playback Volume", 0x0b, 0x03, HDA_INPUT),
+	HDA_CODEC_MUTE("Dock Mic Playback Switch", 0x0b, 0x03, HDA_INPUT),
+	HDA_CODEC_VOLUME("Dock Mic Boost", 0x1b, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x04, HDA_INPUT),
+	{ }
+};
+
 /* bind volumes of both NID 0x0c and 0x0d */
 static struct hda_bind_ctls alc269_epc_bind_vol = {
 	.ops = &snd_hda_bind_vol,
@@ -11753,6 +11779,20 @@
 	{ }
 };
 
+static struct hda_verb alc269_lifebook_verbs[] = {
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x01},
+	{0x1a, AC_VERB_SET_CONNECT_SEL, 0x01},
+	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{0x1a, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+	{0x18, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | ALC880_MIC_EVENT},
+	{0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	{ }
+};
+
 /* toggle speaker-output according to the hp-jack state */
 static void alc269_quanta_fl1_speaker_automute(struct hda_codec *codec)
 {
@@ -11778,6 +11818,37 @@
 			AC_VERB_SET_PROC_COEF, 0x480);
 }
 
+/* toggle speaker-output according to the hp-jacks state */
+static void alc269_lifebook_speaker_automute(struct hda_codec *codec)
+{
+	unsigned int present;
+	unsigned char bits;
+
+	/* Check laptop headphone socket */
+	present = snd_hda_codec_read(codec, 0x15, 0,
+			AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+
+	/* Check port replicator headphone socket */
+	present |= snd_hda_codec_read(codec, 0x1a, 0,
+			AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+
+	bits = present ? AMP_IN_MUTE(0) : 0;
+	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
+			AMP_IN_MUTE(0), bits);
+	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 1,
+			AMP_IN_MUTE(0), bits);
+
+	snd_hda_codec_write(codec, 0x20, 0,
+			AC_VERB_SET_COEF_INDEX, 0x0c);
+	snd_hda_codec_write(codec, 0x20, 0,
+			AC_VERB_SET_PROC_COEF, 0x680);
+
+	snd_hda_codec_write(codec, 0x20, 0,
+			AC_VERB_SET_COEF_INDEX, 0x0c);
+	snd_hda_codec_write(codec, 0x20, 0,
+			AC_VERB_SET_PROC_COEF, 0x480);
+}
+
 static void alc269_quanta_fl1_mic_automute(struct hda_codec *codec)
 {
 	unsigned int present;
@@ -11788,6 +11859,29 @@
 			    AC_VERB_SET_CONNECT_SEL, present ? 0x0 : 0x1);
 }
 
+static void alc269_lifebook_mic_autoswitch(struct hda_codec *codec)
+{
+	unsigned int present_laptop;
+	unsigned int present_dock;
+
+	present_laptop = snd_hda_codec_read(codec, 0x18, 0,
+				AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+
+	present_dock = snd_hda_codec_read(codec, 0x1b, 0,
+				AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+
+	/* Laptop mic port overrides dock mic port, design decision */
+	if (present_dock)
+		snd_hda_codec_write(codec, 0x23, 0,
+				AC_VERB_SET_CONNECT_SEL, 0x3);
+	if (present_laptop)
+		snd_hda_codec_write(codec, 0x23, 0,
+				AC_VERB_SET_CONNECT_SEL, 0x0);
+	if (!present_dock && !present_laptop)
+		snd_hda_codec_write(codec, 0x23, 0,
+				AC_VERB_SET_CONNECT_SEL, 0x1);
+}
+
 static void alc269_quanta_fl1_unsol_event(struct hda_codec *codec,
 				    unsigned int res)
 {
@@ -11797,12 +11891,27 @@
 		alc269_quanta_fl1_mic_automute(codec);
 }
 
+static void alc269_lifebook_unsol_event(struct hda_codec *codec,
+					unsigned int res)
+{
+	if ((res >> 26) == ALC880_HP_EVENT)
+		alc269_lifebook_speaker_automute(codec);
+	if ((res >> 26) == ALC880_MIC_EVENT)
+		alc269_lifebook_mic_autoswitch(codec);
+}
+
 static void alc269_quanta_fl1_init_hook(struct hda_codec *codec)
 {
 	alc269_quanta_fl1_speaker_automute(codec);
 	alc269_quanta_fl1_mic_automute(codec);
 }
 
+static void alc269_lifebook_init_hook(struct hda_codec *codec)
+{
+	alc269_lifebook_speaker_automute(codec);
+	alc269_lifebook_mic_autoswitch(codec);
+}
+
 static struct hda_verb alc269_eeepc_dmic_init_verbs[] = {
 	{0x15, AC_VERB_SET_CONNECT_SEL, 0x01},
 	{0x23, AC_VERB_SET_CONNECT_SEL, 0x05},
@@ -12156,7 +12265,8 @@
 	[ALC269_QUANTA_FL1]		= "quanta",
 	[ALC269_ASUS_EEEPC_P703]	= "eeepc-p703",
 	[ALC269_ASUS_EEEPC_P901]	= "eeepc-p901",
-	[ALC269_FUJITSU]		= "fujitsu"
+	[ALC269_FUJITSU]		= "fujitsu",
+	[ALC269_LIFEBOOK]		= "lifebook"
 };
 
 static struct snd_pci_quirk alc269_cfg_tbl[] = {
@@ -12168,6 +12278,7 @@
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS Eeepc S101",
 		      ALC269_ASUS_EEEPC_P901),
 	SND_PCI_QUIRK(0x1734, 0x115d, "FSC Amilo", ALC269_FUJITSU),
+	SND_PCI_QUIRK(0x10cf, 0x1475, "Lifebook ICH9M-based", ALC269_LIFEBOOK),
 	{}
 };
 
@@ -12236,6 +12347,18 @@
 		.unsol_event = alc269_eeepc_dmic_unsol_event,
 		.init_hook = alc269_eeepc_dmic_inithook,
 	},
+	[ALC269_LIFEBOOK] = {
+		.mixers = { alc269_lifebook_mixer },
+		.init_verbs = { alc269_init_verbs, alc269_lifebook_verbs },
+		.num_dacs = ARRAY_SIZE(alc269_dac_nids),
+		.dac_nids = alc269_dac_nids,
+		.hp_nid = 0x03,
+		.num_channel_mode = ARRAY_SIZE(alc269_modes),
+		.channel_mode = alc269_modes,
+		.input_mux = &alc269_capture_source,
+		.unsol_event = alc269_lifebook_unsol_event,
+		.init_hook = alc269_lifebook_init_hook,
+	},
 };
 
 static int patch_alc269(struct hda_codec *codec)
