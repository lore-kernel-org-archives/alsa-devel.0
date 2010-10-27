From: Todd Broch <tbroch@chromium.org>
Subject: [PATCH] ALSA: hda: Add setup for mario
Date: Wed, 27 Oct 2010 13:18:41 -0700
Message-ID: <1288210721-28473-1-git-send-email-tbroch@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 4497C1037F2
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Oct 2010 22:18:55 +0200 (CEST)
Received: from hpaq5.eem.corp.google.com (hpaq5.eem.corp.google.com
	[172.25.149.5]) by smtp-out.google.com with ESMTP id o9RKIoaQ018815
	for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2010 13:18:50 -0700
Received: from qyk1 (qyk1.prod.google.com [10.241.83.129])
	by hpaq5.eem.corp.google.com with ESMTP id o9RKImsx003101
	for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2010 13:18:49 -0700
Received: by qyk1 with SMTP id 1so53685qyk.15
	for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2010 13:18:48 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Todd Broch <tbroch@chromium.org>
List-Id: alsa-devel@alsa-project.org

Add preset configuration for mario to override amp capabilities

Signed-off-by: Todd Broch <tbroch@chromium.org>
---
 sound/pci/hda/patch_realtek.c |   52 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 79bf4c8..7c77950 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -196,6 +196,7 @@ enum {
 	ALC272_DELL,
 	ALC272_DELL_ZM1,
 	ALC272_SAMSUNG_NC10,
+	ALC272_MARIO,
 	ALC662_AUTO,
 	ALC662_MODEL_LAST,
 };
@@ -17643,6 +17644,18 @@ static struct hda_verb alc663_mode8_init_verbs[] = {
 	{}
 };
 
+static struct hda_verb alc272_mario_init_verbs[] = {
+	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	{0x21, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x21, AC_VERB_SET_CONNECT_SEL, 0x01},	/* Headphone */
+	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(9)},
+	{0x18, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | ALC880_MIC_EVENT},
+	{0x21, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | ALC880_HP_EVENT},
+	{}
+};
+
 static struct snd_kcontrol_new alc662_auto_capture_mixer[] = {
 	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
@@ -18126,6 +18139,20 @@ static void alc663_g50v_unsol_event(struct hda_codec *codec,
 	}
 }
 
+static void alc272_mario_inithook(struct hda_codec *codec)
+{
+	alc663_21jd_two_speaker_automute(codec);
+	alc_mic_automute(codec);
+	if (snd_hda_override_amp_caps(codec, 0x2, HDA_OUTPUT,
+				      (0x3b << AC_AMPCAP_OFFSET_SHIFT) |
+				      (0x3b << AC_AMPCAP_NUM_STEPS_SHIFT) |
+				      (0x03 << AC_AMPCAP_STEP_SIZE_SHIFT) |
+				      (0 << AC_AMPCAP_MUTE_SHIFT))) {
+		printk(KERN_WARNING
+		       "hda_codec: failed to override amp caps for NID 0x2\n");
+	}
+}
+
 #define alc663_g50v_setup	alc663_m51va_setup
 
 static void alc663_g50v_inithook(struct hda_codec *codec)
@@ -18165,6 +18192,18 @@ static struct snd_kcontrol_new alc272_nc10_mixer[] = {
 	{ } /* end */
 };
 
+static struct snd_kcontrol_new alc272_mario_mixer[] = {
+	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x2, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Speaker Playback Switch", 0xc, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x3, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0xd, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	{ } /* end */
+};
+
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 #define alc662_loopbacks	alc880_loopbacks
 #endif
@@ -18203,6 +18242,7 @@ static const char *alc662_models[ALC662_MODEL_LAST] = {
 	[ALC272_DELL]		= "dell",
 	[ALC272_DELL_ZM1]	= "dell-zm1",
 	[ALC272_SAMSUNG_NC10]	= "samsung-nc10",
+	[ALC272_MARIO]	        = "mario",
 	[ALC662_AUTO]		= "auto",
 };
 
@@ -18590,6 +18630,18 @@ static struct alc_config_preset alc662_presets[] = {
 		.setup = alc663_mode4_setup,
 		.init_hook = alc663_mode4_inithook,
 	},
+	[ALC272_MARIO] = {
+		.mixers = { alc272_mario_mixer },
+		.init_verbs = { alc662_init_verbs,
+				alc272_mario_init_verbs},
+		.num_dacs = ARRAY_SIZE(alc272_dac_nids),
+		.dac_nids = alc272_dac_nids,
+		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
+		.channel_mode = alc662_3ST_2ch_modes,
+		.unsol_event = alc663_mode4_unsol_event,
+		.setup = alc663_mode4_setup,
+		.init_hook = alc272_mario_inithook,
+	},
 };
 
 
-- 
1.7.1
