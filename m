From: Nickolas <ultrageek.lloyd@gmail.com>
Subject: [PATCH] - fix speaker output for toshiba nb205 netbooks
Date: Tue, 12 Jan 2010 16:58:32 -0500
Message-ID: <20100112165832.35b5d23f@nick-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196])
	by alsa0.perex.cz (Postfix) with ESMTP id C8EDC1037FC
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 22:58:19 +0100 (CET)
Received: by yxe34 with SMTP id 34so20648844yxe.16
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 13:58:18 -0800 (PST)
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

this is a quick fix i wrote up a couple days ago to fix speaker output on the Realtek ALC272 codec present in toshiba nb205 netbooks.  presently, speaker output doesn't work at all on this model, regardless of settings in the mixer.  this is because the current driver thinks the speaker is at nid 0x0c instead of the correct 0x17.  i'm not too familiar with this hardware, so i'm not sure that this patch won't have any negative effects for other hardware.  it also seems like a messy way of fixing the problem.  any comments or suggestions are welcome, as is testing for those who have this board.  diffed against the latest git.

Thanks,
Nick

--

Signed-off-by: Nickolas Lloyd <ultrageek.lloyd@gmail.com>

--- alsa-driver/sound/pci/hda/patch_realtek.c	2010-01-12 08:03:28.000000000 -0500
+++ alsa-driver-b/sound/pci/hda/patch_realtek.c	2010-01-12 16:27:48.000000000 -0500
@@ -192,6 +192,7 @@ enum {
 	ALC663_ASUS_MODE8,
 	ALC272_DELL,
 	ALC272_DELL_ZM1,
+	ALC272_TOSHIBA_N200,
 	ALC272_SAMSUNG_NC10,
 	ALC662_AUTO,
 	ALC662_MODEL_LAST,
@@ -16725,6 +16726,11 @@ static struct hda_verb alc272_dell_init_
 	{}
 };
 
+static struct hda_verb alc272_toshiba_init_verbs[] = {
+	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{}
+};
+
 static struct hda_verb alc663_mode7_init_verbs[] = {
 	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
 	{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
@@ -17255,6 +17261,36 @@ static void alc663_g50v_inithook(struct 
 	alc_mic_automute(codec);
 }
 
+static void alc272_toshiba_speaker_automute(struct hda_codec *codec)
+{
+	unsigned int present;
+	unsigned char bits;
+
+	present = snd_hda_jack_detect(codec, 0x21);
+	bits = present ? HDA_AMP_MUTE : 0;
+	snd_hda_codec_amp_stereo(codec, 0x17, HDA_OUTPUT, 0,
+					HDA_AMP_MUTE, bits);
+}
+
+static void alc272_toshiba_unsol_event(struct hda_codec *codec,
+					   unsigned int res)
+{
+	switch (res >> 26) {
+	case ALC880_HP_EVENT:
+		alc272_toshiba_speaker_automute(codec);
+		break;
+	case ALC880_MIC_EVENT:
+		alc_mic_automute(codec);
+		break;
+	}
+}
+
+static void alc272_toshiba_init_hook(struct hda_codec *codec)
+{
+	alc272_toshiba_speaker_automute(codec);
+	alc_mic_automute(codec);
+}
+
 static struct snd_kcontrol_new alc662_ecs_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0x02, 0x0, HDA_OUTPUT),
 	ALC262_HIPPO_MASTER_SWITCH,
@@ -17391,7 +17427,7 @@ static struct snd_pci_quirk alc662_cfg_t
 	SND_PCI_QUIRK(0x105b, 0x0cd6, "Foxconn", ALC662_ECS),
 	SND_PCI_QUIRK(0x105b, 0x0d47, "Foxconn 45CMX/45GMX/45CMX-K",
 		      ALC662_3ST_6ch_DIG),
-	SND_PCI_QUIRK(0x1179, 0xff6e, "Toshiba NB200", ALC663_ASUS_MODE4),
+	SND_PCI_QUIRK(0x1179, 0xff6e, "Toshiba NB200", ALC272_TOSHIBA_N200),
 	SND_PCI_QUIRK(0x144d, 0xca00, "Samsung NC10", ALC272_SAMSUNG_NC10),
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte 945GCM-S2L",
 		      ALC662_3ST_6ch_DIG),
@@ -17696,6 +17732,22 @@ static struct alc_config_preset alc662_p
 		.setup = alc663_m51va_setup,
 		.init_hook = alc663_m51va_inithook,
 	},
+	[ALC272_TOSHIBA_N200] = {
+		.mixers = { alc663_asus_21jd_clfe_mixer },
+		.cap_mixer = alc662_auto_capture_mixer,
+		.init_verbs = { alc662_init_verbs,
+				alc663_21jd_amic_init_verbs,
+				alc272_toshiba_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc662_dac_nids),
+		.hp_nid = 0x03,
+		.dac_nids = alc662_dac_nids,
+		.dig_out_nid = ALC662_DIGOUT_NID,
+		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
+		.channel_mode = alc662_3ST_2ch_modes,
+		.unsol_event = alc272_toshiba_unsol_event,
+		.setup = alc663_mode4_setup,
+		.init_hook = alc272_toshiba_init_hook,
+	},
 	[ALC272_SAMSUNG_NC10] = {
 		.mixers = { alc272_nc10_mixer },
 		.init_verbs = { alc662_init_verbs,
