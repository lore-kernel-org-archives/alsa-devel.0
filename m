From: Tony Vroon <chainsaw@gentoo.org>
Subject: [PATCH] Add fujitsu model for Realtek ALC269
Date: Wed,  5 Nov 2008 20:44:26 +0000 (GMT)
Message-ID: <20081105204426.86C5710078@gold.linx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BCD9244DD
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 21:44:27 +0100 (CET)
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
This is builds on the Quanta FL1 work and supports all analog inputs & outputs that I am 
aware of. The microphone automute is more of an auto-switch as there are three inputs. 
The laptop mic port takes precedence over the dock mic port if both happen to have a jack 
plugged in. This made sense to me as a design decision (imagine a presentation environment 
with the dock fully wired in and the presenter quickly wanting to override the mic with 
a headset).

There is mention of a digital audio path on the codec graph, so perhaps the headphone 
socket is dual-function analog/digital. I will follow up with another patch if I can 
acquire equipment to test this.
This applies on top of current linus git, let me know if this is inconvenient and you'd 
like it based on something else.

Signed-off-by: Tony Vroon <tony@linx.net>

--- linux-2.6/sound/pci/hda/patch_realtek.c.orig	2008-11-05 18:34:26.000000000 +0000
+++ linux-2.6/sound/pci/hda/patch_realtek.c	2008-11-05 20:20:47.000000000 +0000
@@ -130,6 +130,7 @@
 	ALC269_QUANTA_FL1,
 	ALC269_ASUS_EEEPC_P703,
 	ALC269_ASUS_EEEPC_P901,
+	ALC269_FUJITSU,
 	ALC269_AUTO,
 	ALC269_MODEL_LAST /* last tag */
 };
@@ -11892,6 +11893,31 @@
 	{ }
 };
 
+static struct snd_kcontrol_new alc269_fujitsu_mixer[] = {
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
@@ -11952,6 +11978,20 @@
 	{ }
 };
 
+static struct hda_verb alc269_fujitsu_verbs[] = {
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
@@ -11977,6 +12017,37 @@
 			AC_VERB_SET_PROC_COEF, 0x480);
 }
 
+/* toggle speaker-output according to the hp-jack state */
+static void alc269_fujitsu_speaker_automute(struct hda_codec *codec)
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
@@ -11987,6 +12058,29 @@
 			    AC_VERB_SET_CONNECT_SEL, present ? 0x0 : 0x1);
 }
 
+static void alc269_fujitsu_mic_automute(struct hda_codec *codec)
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
+				    AC_VERB_SET_CONNECT_SEL, 0x3);
+	if (present_laptop)
+		snd_hda_codec_write(codec, 0x23, 0,
+				    AC_VERB_SET_CONNECT_SEL, 0x0);
+	if (!present_dock && !present_laptop)
+		snd_hda_codec_write(codec, 0x23, 0,
+				    AC_VERB_SET_CONNECT_SEL, 0x1);
+}
+
 static void alc269_quanta_fl1_unsol_event(struct hda_codec *codec,
 				    unsigned int res)
 {
@@ -11996,12 +12090,27 @@
 		alc269_quanta_fl1_mic_automute(codec);
 }
 
+static void alc269_fujitsu_unsol_event(struct hda_codec *codec,
+				    unsigned int res)
+{
+	if ((res >> 26) == ALC880_HP_EVENT)
+		alc269_fujitsu_speaker_automute(codec);
+	if ((res >> 26) == ALC880_MIC_EVENT)
+		alc269_fujitsu_mic_automute(codec);
+}
+
 static void alc269_quanta_fl1_init_hook(struct hda_codec *codec)
 {
 	alc269_quanta_fl1_speaker_automute(codec);
 	alc269_quanta_fl1_mic_automute(codec);
 }
 
+static void alc269_fujitsu_init_hook(struct hda_codec *codec)
+{
+	alc269_fujitsu_speaker_automute(codec);
+	alc269_fujitsu_mic_automute(codec);
+}
+
 static struct hda_verb alc269_eeepc_dmic_init_verbs[] = {
 	{0x15, AC_VERB_SET_CONNECT_SEL, 0x01},
 	{0x23, AC_VERB_SET_CONNECT_SEL, 0x05},
@@ -12354,7 +12463,8 @@
 	[ALC269_BASIC]			= "basic",
 	[ALC269_QUANTA_FL1]		= "quanta",
 	[ALC269_ASUS_EEEPC_P703]	= "eeepc-p703",
-	[ALC269_ASUS_EEEPC_P901]	= "eeepc-p901"
+	[ALC269_ASUS_EEEPC_P901]	= "eeepc-p901",
+	[ALC269_FUJITSU]		= "fujitsu"
 };
 
 static struct snd_pci_quirk alc269_cfg_tbl[] = {
@@ -12365,6 +12475,7 @@
 		      ALC269_ASUS_EEEPC_P901),
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS Eeepc S101",
 		      ALC269_ASUS_EEEPC_P901),
+	SND_PCI_QUIRK(0x10cf, 0x1475, "Fujitsu ICH9M-based", ALC269_FUJITSU),
 	{}
 };
 
@@ -12417,6 +12528,18 @@
 		.unsol_event = alc269_eeepc_dmic_unsol_event,
 		.init_hook = alc269_eeepc_dmic_inithook,
 	},
+	[ALC269_FUJITSU] = {
+		.mixers = { alc269_fujitsu_mixer },
+		.init_verbs = { alc269_init_verbs, alc269_fujitsu_verbs },
+		.num_dacs = ARRAY_SIZE(alc269_dac_nids),
+		.dac_nids = alc269_dac_nids,
+		.hp_nid = 0x03,
+		.num_channel_mode = ARRAY_SIZE(alc269_modes),
+		.channel_mode = alc269_modes,
+		.input_mux = &alc269_capture_source,
+		.unsol_event = alc269_fujitsu_unsol_event,
+		.init_hook = alc269_fujitsu_init_hook,
+	},
 };
 
 static int patch_alc269(struct hda_codec *codec)
