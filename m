From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] Fix DAC assignment order in ALC883
Date: Tue, 18 Mar 2008 00:56:12 -0300
Message-ID: <200803180056.12322.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 11D1824345
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 04:56:16 +0100 (CET)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 2E5423D8AA
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 00:56:14 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id Q74N4FFuawqo for <alsa-devel@alsa-project.org>;
	Tue, 18 Mar 2008 00:56:13 -0300 (BRT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 7ECB73D8A7
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 00:56:13 -0300 (BRT)
Received: from [172.21.225.22] (unknown [172.21.225.22])
	by fox.conectiva (Postfix) with ESMTP id 09E3E2F1EC
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 00:56:13 -0300 (BRT)
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

Actually clfe and surround DACs are inverted in alc883_dac_nids array
(see ALC883 datasheet). I discovered this while testing multi-channel
setup (using 3stack-6ch-dig model) on MSI 945GCM5 V2 motherboard that
has an ALC883 codec. Simply Rear Left/Right and Center/LFE were swapped
in 6 channel mode (also in 4 channel mode you didn't get rear left/right
output). Other models also were affected by this bug, as can be seen by
the mixer layouts that "workaround" this (the real bug was not noticed,
and some other models simply played with mixer and initial verbs). Thus
along with fixing the order of dac nids, also change the models that
relied on previous dac ordering properly.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com>

diff -p -up alsa-kernel/pci/hda/patch_realtek.c.orig alsa-kernel/pci/hda/patch_realtek.c
--- alsa-kernel/pci/hda/patch_realtek.c.orig	2008-03-18 00:16:12.000000000 -0300
+++ alsa-kernel/pci/hda/patch_realtek.c	2008-03-18 00:18:52.000000000 -0300
@@ -6450,7 +6450,7 @@ static int patch_alc882(struct hda_codec
 
 static hda_nid_t alc883_dac_nids[4] = {
 	/* front, rear, clfe, rear_surr */
-	0x02, 0x04, 0x03, 0x05
+	0x02, 0x03, 0x04, 0x05
 };
 
 static hda_nid_t alc883_adc_nids[2] = {
@@ -6958,12 +6958,12 @@ static struct snd_kcontrol_new alc883_me
 static struct snd_kcontrol_new alc888_6st_hp_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0e, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Surround Playback Switch", 0x0e, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0d, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0d, 2, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0d, 1, 2, HDA_INPUT),
-	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0d, 2, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 2, HDA_INPUT),
+	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Side Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Side Playback Switch", 0x0f, 2, HDA_INPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
@@ -6998,12 +6998,12 @@ static struct snd_kcontrol_new alc888_6s
 static struct snd_kcontrol_new alc888_3st_hp_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0e, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Surround Playback Switch", 0x0e, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0d, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0d, 2, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0d, 1, 2, HDA_INPUT),
-	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0d, 2, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 2, HDA_INPUT),
+	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_INPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
@@ -7036,12 +7036,12 @@ static struct snd_kcontrol_new alc888_3s
 static struct snd_kcontrol_new alc888_6st_dell_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0e, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Surround Playback Switch", 0x0e, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0d, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0d, 2, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0d, 1, 2, HDA_INPUT),
-	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0d, 2, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 2, HDA_INPUT),
+	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Side Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Side Playback Switch", 0x0f, 2, HDA_INPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
@@ -7332,26 +7332,14 @@ static struct hda_verb alc883_haier_w66_
 	{ } /* end */
 };
 
-static struct hda_verb alc888_6st_hp_verbs[] = {
-	{0x14, AC_VERB_SET_CONNECT_SEL, 0x00},	/* Front: output 0 (0x0c) */
-	{0x15, AC_VERB_SET_CONNECT_SEL, 0x02},	/* Rear : output 2 (0x0e) */
-	{0x16, AC_VERB_SET_CONNECT_SEL, 0x01},	/* CLFE : output 1 (0x0d) */
-	{0x17, AC_VERB_SET_CONNECT_SEL, 0x03},	/* Side : output 3 (0x0f) */
-	{ }
-};
-
 static struct hda_verb alc888_3st_hp_verbs[] = {
 	{0x14, AC_VERB_SET_CONNECT_SEL, 0x00},	/* Front: output 0 (0x0c) */
-	{0x18, AC_VERB_SET_CONNECT_SEL, 0x01},	/* Rear : output 1 (0x0d) */
-	{0x16, AC_VERB_SET_CONNECT_SEL, 0x02},	/* CLFE : output 2 (0x0e) */
+	{0x16, AC_VERB_SET_CONNECT_SEL, 0x01},	/* Rear : output 1 (0x0d) */
+	{0x18, AC_VERB_SET_CONNECT_SEL, 0x02},	/* CLFE : output 2 (0x0e) */
 	{ }
 };
 
 static struct hda_verb alc888_6st_dell_verbs[] = {
-	{0x14, AC_VERB_SET_CONNECT_SEL, 0x00},	/* Front: output 0 (0x0c) */
-	{0x15, AC_VERB_SET_CONNECT_SEL, 0x02},	/* Rear : output 1 (0x0e) */
-	{0x16, AC_VERB_SET_CONNECT_SEL, 0x01},	/* CLFE : output 2 (0x0d) */
-	{0x17, AC_VERB_SET_CONNECT_SEL, 0x03},	/* Side : output 3 (0x0f) */
 	{0x1b, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
 	{ }
 };
@@ -7985,7 +7973,7 @@ static struct alc_config_preset alc883_p
 	},	
 	[ALC888_6ST_HP] = {
 		.mixers = { alc888_6st_hp_mixer, alc883_chmode_mixer },
-		.init_verbs = { alc883_init_verbs, alc888_6st_hp_verbs },
+		.init_verbs = { alc883_init_verbs },
 		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
 		.dac_nids = alc883_dac_nids,
 		.dig_out_nid = ALC883_DIGOUT_NID,

-- 
[]'s
Herton
