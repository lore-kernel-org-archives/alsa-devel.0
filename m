From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH 2/3] ALSA: hda - Add headphone automute support
	for 3stack-hp model (ALC888)
Date: Wed,  4 Mar 2009 14:22:51 -0300
Message-ID: <1236187372-15818-2-git-send-email-herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FF75103813
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 18:28:45 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>
List-Id: alsa-devel@alsa-project.org

Mute speaker outputs on headphone insertion for machines that use
3stack-hp model.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 sound/pci/hda/patch_realtek.c |   38 +++++++++++++++++++++++++++++++++-----
 1 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3696ff3..251647d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8056,16 +8056,42 @@ static struct hda_verb alc888_lenovo_sky_verbs[] = {
 	{ } /* end */
 };
 
+static struct hda_verb alc888_6st_dell_verbs[] = {
+	{0x1b, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+	{ }
+};
+
+static void alc888_3st_hp_front_automute(struct hda_codec *codec)
+{
+	unsigned int present, bits;
+
+	present = snd_hda_codec_read(codec, 0x1b, 0,
+			AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	bits = present ? HDA_AMP_MUTE : 0;
+	snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, bits);
+	snd_hda_codec_amp_stereo(codec, 0x16, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, bits);
+	snd_hda_codec_amp_stereo(codec, 0x18, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, bits);
+}
+
+static void alc888_3st_hp_unsol_event(struct hda_codec *codec,
+				      unsigned int res)
+{
+	switch (res >> 26) {
+	case ALC880_HP_EVENT:
+		alc888_3st_hp_front_automute(codec);
+		break;
+	}
+}
+
 static struct hda_verb alc888_3st_hp_verbs[] = {
 	{0x14, AC_VERB_SET_CONNECT_SEL, 0x00},	/* Front: output 0 (0x0c) */
 	{0x16, AC_VERB_SET_CONNECT_SEL, 0x01},	/* Rear : output 1 (0x0d) */
 	{0x18, AC_VERB_SET_CONNECT_SEL, 0x02},	/* CLFE : output 2 (0x0e) */
-	{ }
-};
-
-static struct hda_verb alc888_6st_dell_verbs[] = {
 	{0x1b, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
-	{ }
+	{ } /* end */
 };
 
 /*
@@ -8950,6 +8976,8 @@ static struct alc_config_preset alc883_presets[] = {
 		.channel_mode = alc888_3st_hp_modes,
 		.need_dac_fix = 1,
 		.input_mux = &alc883_capture_source,
+		.unsol_event = alc888_3st_hp_unsol_event,
+		.init_hook = alc888_3st_hp_front_automute,
 	},
 	[ALC888_6ST_DELL] = {
 		.mixers = { alc883_base_mixer, alc883_chmode_mixer },
-- 
1.6.1.3
