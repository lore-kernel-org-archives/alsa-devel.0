From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] hda-intel: Add Quanta IL1 ALC267 model
Date: Tue, 25 Mar 2008 17:31:28 -0300
Message-ID: <200803251731.28856.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id AF6CB103818
	for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2008 21:31:36 +0100 (CET)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 9B4AD3EB7
	for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2008 17:31:32 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id MxD2GKipQBBN for <alsa-devel@alsa-project.org>;
	Tue, 25 Mar 2008 17:31:32 -0300 (BRT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 0F1BE3EB6
	for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2008 17:31:31 -0300 (BRT)
Received: from gotham.conectiva (gotham.conectiva [10.0.2.23])
	by fox.conectiva (Postfix) with ESMTP id 48CCE2F666
	for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2008 17:31:30 -0300 (BRT)
Content-Disposition: inline
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

This adds support for Quanta IL1 mini-notebook to alsa, defining a new model for
it. It comes with an ALC267 codec chip. Some notes about this model:

* In headphone automute, I use AC_VERB_SET_PIN_WIDGET_CONTROL instead of common
  amp mute, to avoid conflict with mixer switch (mixer and automute use the same
  nid).
* The only connected capture sources in the hardware are the internal mic and
  external mic jack. So instead of using an input source selector like on other
  ALC268 models, the mic automute automatically switch between captures.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com>

diff -p -up alsa-kernel/Documentation/ALSA-Configuration.txt.orig alsa-kernel/Documentation/ALSA-Configuration.txt
--- alsa-kernel/Documentation/ALSA-Configuration.txt.orig	2008-03-25 16:30:07.000000000 -0300
+++ alsa-kernel/Documentation/ALSA-Configuration.txt	2008-03-25 16:33:52.000000000 -0300
@@ -829,7 +829,8 @@ Prior to version 0.9.0rc4 options had a 
 	  basic		fixed pin assignment w/o SPDIF
 	  auto		auto-config reading BIOS (default)
 
-	ALC268
+	ALC267/268
+	  quanta-il1	Quanta IL1 mini-notebook
 	  3stack	3-stack model
 	  toshiba	Toshiba A205
 	  acer		Acer laptops
diff -p -up alsa-kernel/pci/hda/patch_realtek.c.orig alsa-kernel/pci/hda/patch_realtek.c
--- alsa-kernel/pci/hda/patch_realtek.c.orig	2008-03-25 16:30:07.000000000 -0300
+++ alsa-kernel/pci/hda/patch_realtek.c	2008-03-25 16:33:52.000000000 -0300
@@ -105,6 +105,7 @@ enum {
 
 /* ALC268 models */
 enum {
+	ALC267_QUANTA_IL1,
 	ALC268_3ST,
 	ALC268_TOSHIBA,
 	ALC268_ACER,
@@ -9896,6 +9897,64 @@ static void alc268_dell_unsol_event(stru
 
 #define alc268_dell_init_hook	alc268_dell_automute
 
+static struct snd_kcontrol_new alc267_quanta_il1_mixer[] = {
+	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x2, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Speaker Playback Switch", 0x14, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x3, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Capture Volume", 0x23, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Mic Capture Switch", 0x23, 2, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Ext Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
+	{ }
+};
+
+static struct hda_verb alc267_quanta_il1_verbs[] = {
+	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+	{0x18, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_MIC_EVENT | AC_USRSP_EN},
+	{ }
+};
+
+static void alc267_quanta_il1_hp_automute(struct hda_codec *codec)
+{
+	unsigned int present;
+
+	present = snd_hda_codec_read(codec, 0x15, 0, AC_VERB_GET_PIN_SENSE, 0)
+		& AC_PINSENSE_PRESENCE;
+	snd_hda_codec_write(codec, 0x14, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+			    present ? 0 : PIN_OUT);
+}
+
+static void alc267_quanta_il1_mic_automute(struct hda_codec *codec)
+{
+	unsigned int present;
+
+	present = snd_hda_codec_read(codec, 0x18, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	snd_hda_codec_write(codec, 0x23, 0,
+			    AC_VERB_SET_CONNECT_SEL,
+			    present ? 0x00 : 0x01);
+}
+
+static void alc267_quanta_il1_automute(struct hda_codec *codec)
+{
+	alc267_quanta_il1_hp_automute(codec);
+	alc267_quanta_il1_mic_automute(codec);
+}
+
+static void alc267_quanta_il1_unsol_event(struct hda_codec *codec,
+					   unsigned int res)
+{
+	switch (res >> 26) {
+	case ALC880_HP_EVENT:
+		alc267_quanta_il1_hp_automute(codec);
+		break;
+	case ALC880_MIC_EVENT:
+		alc267_quanta_il1_mic_automute(codec);
+		break;
+	}
+}
+
 /*
  * generic initialization of ADC, input mixers and output mixers
  */
@@ -10318,6 +10377,7 @@ static void alc268_auto_init(struct hda_
  * configuration and preset
  */
 static const char *alc268_models[ALC268_MODEL_LAST] = {
+	[ALC267_QUANTA_IL1]	= "quanta-il1",
 	[ALC268_3ST]		= "3stack",
 	[ALC268_TOSHIBA]	= "toshiba",
 	[ALC268_ACER]		= "acer",
@@ -10340,11 +10400,27 @@ static struct snd_pci_quirk alc268_cfg_t
 	SND_PCI_QUIRK(0x1179, 0xff10, "TOSHIBA A205", ALC268_TOSHIBA),
 	SND_PCI_QUIRK(0x1179, 0xff50, "TOSHIBA A305", ALC268_TOSHIBA),
 	SND_PCI_QUIRK(0x152d, 0x0763, "Diverse (CPR2000)", ALC268_ACER),
+	SND_PCI_QUIRK(0x152d, 0x0771, "Quanta IL1", ALC267_QUANTA_IL1),
 	SND_PCI_QUIRK(0x1170, 0x0040, "ZEPTO", ALC268_ZEPTO),
 	{}
 };
 
 static struct alc_config_preset alc268_presets[] = {
+	[ALC267_QUANTA_IL1] = {
+		.mixers = { alc267_quanta_il1_mixer },
+		.init_verbs = { alc268_base_init_verbs, alc268_eapd_verbs,
+				alc267_quanta_il1_verbs },
+		.num_dacs = ARRAY_SIZE(alc268_dac_nids),
+		.dac_nids = alc268_dac_nids,
+		.num_adc_nids = ARRAY_SIZE(alc268_adc_nids_alt),
+		.adc_nids = alc268_adc_nids_alt,
+		.hp_nid = 0x03,
+		.num_channel_mode = ARRAY_SIZE(alc268_modes),
+		.channel_mode = alc268_modes,
+		.input_mux = &alc268_capture_source,
+		.unsol_event = alc267_quanta_il1_unsol_event,
+		.init_hook = alc267_quanta_il1_automute,
+	},
 	[ALC268_3ST] = {
 		.mixers = { alc268_base_mixer, alc268_capture_alt_mixer,
 			    alc268_beep_mixer },

-- 
[]'s
Herton
