From: murray.alex@gmail.com
Subject: [PATCH - hda 1/1] ALSA: hda - Improved MacBook (Pro) 5,
	1 / 5, 2 support
Date: Wed, 13 Jan 2010 23:15:03 +1030
Message-ID: <4b4dc076.0f0bca0a.2927.63a7@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Alex Murray <murray.alex@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Alex Murray <murray.alex@gmail.com>

This patch adds support for automatically muting the speakers when headphones
are inserted, as well as relabelling the headphone widgets from the
non-standard "HP" to the standard "Headphone" for the mb5 model.

Signed-off-by: Alex Murray <murray.alex@gmail.com>
---
 pci/hda/patch_realtek.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/pci/hda/patch_realtek.c b/pci/hda/patch_realtek.c
index f858dcd..bd65e47 100644
--- a/pci/hda/patch_realtek.c
+++ b/pci/hda/patch_realtek.c
@@ -7201,8 +7201,8 @@ static struct snd_kcontrol_new alc885_mb5_mixer[] = {
 	HDA_BIND_MUTE   ("Surround Playback Switch", 0x0d, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("LFE Playback Volume", 0x0e, 0x00, HDA_OUTPUT),
 	HDA_BIND_MUTE   ("LFE Playback Switch", 0x0e, 0x02, HDA_INPUT),
-	HDA_CODEC_VOLUME("HP Playback Volume", 0x0f, 0x00, HDA_OUTPUT),
-	HDA_BIND_MUTE   ("HP Playback Switch", 0x0f, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x0f, 0x00, HDA_OUTPUT),
+	HDA_BIND_MUTE   ("Headphone Playback Switch", 0x0f, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE  ("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x01, HDA_INPUT),
@@ -7603,6 +7603,7 @@ static struct hda_verb alc885_mb5_init_verbs[] = {
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
 	{0x14, AC_VERB_SET_CONNECT_SEL, 0x03},
+	{0x14, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
 	/* Front Mic pin: input vref at 80% */
 	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
 	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
@@ -7787,6 +7788,27 @@ static void alc885_mbp3_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[0] = 0x14;
 }
 
+static void alc885_mb5_automute(struct hda_codec *codec)
+{
+	unsigned int present;
+
+	present = snd_hda_codec_read(codec, 0x14, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	snd_hda_codec_amp_stereo(codec, 0x18, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
+	snd_hda_codec_amp_stereo(codec, 0x1a, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
+
+}
+
+static void alc885_mb5_unsol_event(struct hda_codec *codec,
+				    unsigned int res)
+{
+	/* Headphone insertion or removal. */
+	if ((res >> 26) == ALC880_HP_EVENT)
+		alc885_mb5_automute(codec);
+}
+
 static void alc885_imac91_automute(struct hda_codec *codec)
 {
  	unsigned int present;
@@ -9233,6 +9255,8 @@ static struct alc_config_preset alc882_presets[] = {
 		.input_mux = &mb5_capture_source,
 		.dig_out_nid = ALC882_DIGOUT_NID,
 		.dig_in_nid = ALC882_DIGIN_NID,
+		.unsol_event = alc885_mb5_unsol_event,
+		.init_hook = alc885_mb5_automute,
 	},
 	[ALC885_MACPRO] = {
 		.mixers = { alc882_macpro_mixer },
-- 
1.6.3.3
