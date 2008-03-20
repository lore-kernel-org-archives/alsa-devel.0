From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] Support mic automute for Clevo M720R/SR
Date: Thu, 20 Mar 2008 17:09:22 -0300
Message-ID: <200803201709.22456.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 07C4524589
	for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2008 21:09:25 +0100 (CET)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 6D7313EA7
	for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2008 17:09:24 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id Qx7Aylno4ayD for <alsa-devel@alsa-project.org>;
	Thu, 20 Mar 2008 17:09:23 -0300 (BRT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 6B48E3E7FE
	for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2008 17:09:23 -0300 (BRT)
Received: from gotham.conectiva (gotham.conectiva [10.0.2.23])
	by fox.conectiva (Postfix) with ESMTP id C31492F7DC
	for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2008 17:09:22 -0300 (BRT)
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

Add support for mic automute in clevo-m720r ALC883 model, and rename it
to more generic clevo-m720. Also change model entry in ALSA-Configuration.txt
accordingly.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com>

diff -p -up alsa-kernel/Documentation/ALSA-Configuration.txt.orig alsa-kernel/Documentation/ALSA-Configuration.txt
--- alsa-kernel/Documentation/ALSA-Configuration.txt.orig	2008-03-20 16:51:03.000000000 -0300
+++ alsa-kernel/Documentation/ALSA-Configuration.txt	2008-03-20 16:52:00.000000000 -0300
@@ -886,7 +886,7 @@ Prior to version 0.9.0rc4 options had a 
 	  3stack-hp	HP machines with 3stack (Lucknow, Samba boards)
 	  6stack-dell	Dell machines with 6stack (Inspiron 530)
 	  mitac		Mitac 8252D
-	  clevo-m720r	Clevo laptop M720R
+	  clevo-m720	Clevo M720 laptop series
 	  fujitsu-pi2515 Fujitsu AMILO Pi2515
 	  auto		auto-config reading BIOS (default)
 
diff -p -up alsa-kernel/pci/hda/patch_realtek.c.orig alsa-kernel/pci/hda/patch_realtek.c
--- alsa-kernel/pci/hda/patch_realtek.c.orig	2008-03-20 16:43:55.000000000 -0300
+++ alsa-kernel/pci/hda/patch_realtek.c	2008-03-20 16:49:22.000000000 -0300
@@ -201,7 +201,7 @@ enum {
 	ALC888_3ST_HP,
 	ALC888_6ST_DELL,
 	ALC883_MITAC,
-	ALC883_CLEVO_M720R,
+	ALC883_CLEVO_M720,
 	ALC883_FUJITSU_PI2515,
 	ALC883_AUTO,
 	ALC883_MODEL_LAST,
@@ -6661,7 +6661,7 @@ static struct snd_kcontrol_new alc883_mi
 	{ } /* end */
 };
 
-static struct snd_kcontrol_new alc883_clevo_m720r_mixer[] = {
+static struct snd_kcontrol_new alc883_clevo_m720_mixer[] = {
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Headphone Playback Switch", 0x0c, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
@@ -7130,7 +7130,7 @@ static struct hda_verb alc883_mitac_verb
 	{ } /* end */
 };
 
-static struct hda_verb alc883_clevo_m720r_verbs[] = {
+static struct hda_verb alc883_clevo_m720_verbs[] = {
 	/* HP */
 	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
 	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
@@ -7140,6 +7140,7 @@ static struct hda_verb alc883_clevo_m720
 
 	/* enable unsolicited event */
 	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+	{0x18, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_MIC_EVENT | AC_USRSP_EN},
 
 	{ } /* end */
 };
@@ -7330,7 +7331,7 @@ static void alc883_tagra_unsol_event(str
 }
 
 /* toggle speaker-output according to the hp-jack state */
-static void alc883_clevo_m720r_automute(struct hda_codec *codec)
+static void alc883_clevo_m720_hp_automute(struct hda_codec *codec)
 {
 	unsigned int present;
 	unsigned char bits;
@@ -7342,11 +7343,33 @@ static void alc883_clevo_m720r_automute(
 				 HDA_AMP_MUTE, bits);
 }
 
-static void alc883_clevo_m720r_unsol_event(struct hda_codec *codec,
+static void alc883_clevo_m720_mic_automute(struct hda_codec *codec)
+{
+	unsigned int present;
+
+	present = snd_hda_codec_read(codec, 0x18, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	snd_hda_codec_amp_stereo(codec, 0x0b, HDA_INPUT, 1,
+				 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
+}
+
+static void alc883_clevo_m720_automute(struct hda_codec *codec)
+{
+	alc883_clevo_m720_hp_automute(codec);
+	alc883_clevo_m720_mic_automute(codec);
+}
+
+static void alc883_clevo_m720_unsol_event(struct hda_codec *codec,
 					   unsigned int res)
 {
-	if ((res >> 26) == ALC880_HP_EVENT)
-		alc883_clevo_m720r_automute(codec);
+	switch (res >> 26) {
+	case ALC880_HP_EVENT:
+		alc883_clevo_m720_hp_automute(codec);
+		break;
+	case ALC880_MIC_EVENT:
+		alc883_clevo_m720_mic_automute(codec);
+		break;
+	}
 }
 
 /* toggle speaker-output according to the hp-jack state */
@@ -7605,7 +7628,7 @@ static const char *alc883_models[ALC883_
 	[ALC888_3ST_HP]		= "3stack-hp",
 	[ALC888_6ST_DELL]	= "6stack-dell",
 	[ALC883_MITAC]		= "mitac",
-	[ALC883_CLEVO_M720R]	= "clevo-m720r",
+	[ALC883_CLEVO_M720]	= "clevo-m720",
 	[ALC883_FUJITSU_PI2515] = "fujitsu-pi2515",
 	[ALC883_AUTO]		= "auto",
 };
@@ -7649,8 +7672,8 @@ static struct snd_pci_quirk alc883_cfg_t
 	SND_PCI_QUIRK(0x1462, 0x7327, "MSI", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0xa422, "MSI", ALC883_TARGA_2ch_DIG),
 	SND_PCI_QUIRK(0x147b, 0x1083, "Abit IP35-PRO", ALC883_6ST_DIG),
-	SND_PCI_QUIRK(0x1558, 0x0721, "Clevo laptop M720R", ALC883_CLEVO_M720R),
-	SND_PCI_QUIRK(0x1558, 0x0722, "Clevo laptop M720SR", ALC883_CLEVO_M720R),
+	SND_PCI_QUIRK(0x1558, 0x0721, "Clevo laptop M720R", ALC883_CLEVO_M720),
+	SND_PCI_QUIRK(0x1558, 0x0722, "Clevo laptop M720SR", ALC883_CLEVO_M720),
 	SND_PCI_QUIRK(0x1558, 0, "Clevo laptop", ALC883_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x15d9, 0x8780, "Supermicro PDSBA", ALC883_3ST_6ch),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Medion laptop", ALC883_MEDION),
@@ -7794,17 +7817,17 @@ static struct alc_config_preset alc883_p
 		.channel_mode = alc883_3ST_2ch_modes,
 		.input_mux = &alc883_capture_source,
 	},
-	[ALC883_CLEVO_M720R] = {
-		.mixers = { alc883_clevo_m720r_mixer },
-		.init_verbs = { alc883_init_verbs, alc883_clevo_m720r_verbs },
+	[ALC883_CLEVO_M720] = {
+		.mixers = { alc883_clevo_m720_mixer },
+		.init_verbs = { alc883_init_verbs, alc883_clevo_m720_verbs },
 		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
 		.dac_nids = alc883_dac_nids,
 		.dig_out_nid = ALC883_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
 		.channel_mode = alc883_3ST_2ch_modes,
 		.input_mux = &alc883_capture_source,
-		.unsol_event = alc883_clevo_m720r_unsol_event,
-		.init_hook = alc883_clevo_m720r_automute,
+		.unsol_event = alc883_clevo_m720_unsol_event,
+		.init_hook = alc883_clevo_m720_automute,
 	},
 	[ALC883_LENOVO_101E_2ch] = {
 		.mixers = { alc883_lenovo_101e_2ch_mixer},

-- 
[]'s
Herton
