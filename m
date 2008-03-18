From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] Remove now uneeded 6stack-hp model from ALC883
Date: Tue, 18 Mar 2008 18:15:32 -0300
Message-ID: <200803181815.32917.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 77E7E2452F
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 22:15:36 +0100 (CET)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id CD69E3DCC9
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 18:15:34 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id d0OHigT6KkRv for <alsa-devel@alsa-project.org>;
	Tue, 18 Mar 2008 18:15:34 -0300 (BRT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 2360B3DCC5
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 18:15:33 -0300 (BRT)
Received: from gotham.conectiva (gotham.conectiva [10.0.2.23])
	by fox.conectiva (Postfix) with ESMTP id 76AB52F20B
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 18:15:33 -0300 (BRT)
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

After DAC assignment fix in ALC883, the 6stack-hp model is now the same
as 6stack-dig. So just remove 6stack-hp model and replace its use with
6stack-dig.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com>

diff -p -up alsa-kernel/Documentation/ALSA-Configuration.txt.orig alsa-kernel/Documentation/ALSA-Configuration.txt
--- alsa-kernel/Documentation/ALSA-Configuration.txt.orig	2008-03-18 17:41:33.000000000 -0300
+++ alsa-kernel/Documentation/ALSA-Configuration.txt	2008-03-18 17:43:06.000000000 -0300
@@ -879,7 +879,6 @@ Prior to version 0.9.0rc4 options had a 
 	  lenovo-nb0763	Lenovo NB0763
 	  lenovo-ms7195-dig Lenovo MS7195
 	  haier-w66	Haier W66
-	  6stack-hp	HP machines with 6stack (Nettle boards)
 	  3stack-hp	HP machines with 3stack (Lucknow, Samba boards)
 	  6stack-dell	Dell machines with 6stack (Inspiron 530)
 	  mitac		Mitac 8252D
diff -p -up alsa-kernel/pci/hda/patch_realtek.c.orig alsa-kernel/pci/hda/patch_realtek.c
--- alsa-kernel/pci/hda/patch_realtek.c.orig	2008-03-18 17:30:24.000000000 -0300
+++ alsa-kernel/pci/hda/patch_realtek.c	2008-03-18 17:41:13.000000000 -0300
@@ -197,7 +197,6 @@ enum {
 	ALC883_LENOVO_NB0763,
 	ALC888_LENOVO_MS7195_DIG,
 	ALC883_HAIER_W66,		
-	ALC888_6ST_HP,
 	ALC888_3ST_HP,
 	ALC888_6ST_DELL,
 	ALC883_MITAC,
@@ -6955,46 +6954,6 @@ static struct snd_kcontrol_new alc883_me
 	{ } /* end */
 };	
 
-static struct snd_kcontrol_new alc888_6st_hp_mixer[] = {
-	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 2, HDA_INPUT),
-	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Side Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Side Playback Switch", 0x0f, 2, HDA_INPUT),
-	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
-	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
-	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
-	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x05, HDA_INPUT),
-	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x05, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x08, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x08, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x09, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x09, 0x0, HDA_INPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		/* .name = "Capture Source", */
-		.name = "Input Source",
-		.count = 2,
-		.info = alc883_mux_enum_info,
-		.get = alc883_mux_enum_get,
-		.put = alc883_mux_enum_put,
-	},
-	{ } /* end */
-};
-
 static struct snd_kcontrol_new alc888_3st_hp_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
@@ -7720,7 +7679,6 @@ static const char *alc883_models[ALC883_
 	[ALC883_LENOVO_NB0763]	= "lenovo-nb0763",
 	[ALC888_LENOVO_MS7195_DIG] = "lenovo-ms7195-dig",
 	[ALC883_HAIER_W66] 	= "haier-w66",
-	[ALC888_6ST_HP]		= "6stack-hp",
 	[ALC888_3ST_HP]		= "3stack-hp",
 	[ALC888_6ST_DELL]	= "6stack-dell",
 	[ALC883_MITAC]		= "mitac",
@@ -7739,7 +7697,7 @@ static struct snd_pci_quirk alc883_cfg_t
 	SND_PCI_QUIRK(0x103c, 0x2a3d, "HP Pavillion", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x103c, 0x2a4f, "HP Samba", ALC888_3ST_HP),
 	SND_PCI_QUIRK(0x103c, 0x2a60, "HP Lucknow", ALC888_3ST_HP),
-	SND_PCI_QUIRK(0x103c, 0x2a61, "HP Nettle", ALC888_6ST_HP),
+	SND_PCI_QUIRK(0x103c, 0x2a61, "HP Nettle", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1043, 0x8249, "Asus M2A-VM HDMI", ALC883_3ST_6ch_DIG),
 	SND_PCI_QUIRK(0x105b, 0x6668, "Foxconn", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1071, 0x8253, "Mitac 8252d", ALC883_MITAC),
@@ -7972,17 +7930,6 @@ static struct alc_config_preset alc883_p
 		.unsol_event = alc883_haier_w66_unsol_event,
 		.init_hook = alc883_haier_w66_automute,
 	},	
-	[ALC888_6ST_HP] = {
-		.mixers = { alc888_6st_hp_mixer, alc883_chmode_mixer },
-		.init_verbs = { alc883_init_verbs },
-		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
-		.dac_nids = alc883_dac_nids,
-		.dig_out_nid = ALC883_DIGOUT_NID,
-		.dig_in_nid = ALC883_DIGIN_NID,
-		.num_channel_mode = ARRAY_SIZE(alc883_sixstack_modes),
-		.channel_mode = alc883_sixstack_modes,
-		.input_mux = &alc883_capture_source,
-	},
 	[ALC888_3ST_HP] = {
 		.mixers = { alc888_3st_hp_mixer, alc883_chmode_mixer },
 		.init_verbs = { alc883_init_verbs, alc888_3st_hp_verbs },

-- 
[]'s
Herton
