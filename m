From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Fix capture mixers of ALC662 models
Date: Tue, 18 Dec 2007 22:40:31 -0200
Message-ID: <200712182240.31984.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 3023E2447C
	for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2007 01:41:57 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Kailang Yang <kailang@realtek.com.tw>
List-Id: alsa-devel@alsa-project.org

The below patches fixes capture mixers of ALC662 models. The first one applies 
to current hg tree, the second one to Linus tree (2.6.24-rcX).

The commit that added support for ASUS P701 eeepc also changed the
mixers of other ALC662 models, duplicating entries for the Capture
items, making them to not work anymore. This fixes it by removing
duplicated entries using where possible the common alc662_capture_mixer.
Also alc662_capture_mixer should use alc662* functions and not alc882
(I checked /proc/asound/card0/codec* on an eepc model and it's ok).

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com>

--- alsa-kernel/pci/hda/patch_realtek.c.orig	2007-12-18 21:57:02.000000000 -0200
+++ alsa-kernel/pci/hda/patch_realtek.c	2007-12-18 22:01:24.000000000 -0200
@@ -12364,17 +12364,6 @@ static struct snd_kcontrol_new alc662_3S
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x05, HDA_INPUT),
 	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x05, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		/* .name = "Capture Source", */
-		.name = "Input Source",
-		.count = 1,
-		.info = alc662_mux_enum_info,
-		.get = alc662_mux_enum_get,
-		.put = alc662_mux_enum_put,
-	},
 	{ } /* end */
 };
 
@@ -12398,17 +12387,6 @@ static struct snd_kcontrol_new alc662_3S
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x05, HDA_INPUT),
 	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x05, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		/* .name = "Capture Source", */
-		.name = "Input Source",
-		.count = 1,
-		.info = alc662_mux_enum_info,
-		.get = alc662_mux_enum_get,
-		.put = alc662_mux_enum_put,
-	},
 	{ } /* end */
 };
 
@@ -12422,17 +12400,6 @@ static struct snd_kcontrol_new alc662_le
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		/* .name = "Capture Source", */
-		.name = "Input Source",
-		.count = 1,
-		.info = alc662_mux_enum_info,
-		.get = alc662_mux_enum_get,
-		.put = alc662_mux_enum_put,
-	},
 	{ } /* end */
 };
 
@@ -12463,6 +12430,25 @@ static struct snd_kcontrol_new alc662_ch
 	{ } /* end */
 };
 
+/* capture mixer elements */
+static struct snd_kcontrol_new alc662_capture_mixer[] = {
+	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		/* The multiple "Capture Source" controls confuse alsamixer
+		 * So call somewhat different..
+		 */
+		/* .name = "Capture Source", */
+		.name = "Input Source",
+		.count = 1,
+		.info = alc662_mux_enum_info,
+		.get = alc662_mux_enum_get,
+		.put = alc662_mux_enum_put,
+	},
+	{ } /* end */
+};
+
 static struct hda_verb alc662_init_verbs[] = {
 	/* ADC: mute amp left and right */
 	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
@@ -12585,26 +12571,6 @@ static struct hda_verb alc662_auto_init_
 	{ }
 };
 
-/* capture mixer elements */
-static struct snd_kcontrol_new alc662_capture_mixer[] = {
-	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		/* The multiple "Capture Source" controls confuse alsamixer
-		 * So call somewhat different..
-		 * FIXME: the controls appear in the "playback" view!
-		 */
-		/* .name = "Capture Source", */
-		.name = "Input Source",
-		.count = 1,
-		.info = alc882_mux_enum_info,
-		.get = alc882_mux_enum_get,
-		.put = alc882_mux_enum_put,
-	},
-	{ } /* end */
-};
-
 static void alc662_lenovo_101e_ispeaker_automute(struct hda_codec *codec)
 {
 	unsigned int present;
@@ -12746,8 +12712,7 @@ static struct alc_config_preset alc662_p
 		.input_mux = &alc662_capture_source,
 	},
 	[ALC662_5ST_DIG] = {
-		.mixers = { alc662_base_mixer, alc662_chmode_mixer,
-			    alc662_capture_mixer },
+		.mixers = { alc662_base_mixer, alc662_chmode_mixer },
 		.init_verbs = { alc662_init_verbs },
 		.num_dacs = ARRAY_SIZE(alc662_dac_nids),
 		.dac_nids = alc662_dac_nids,

The commit that added support for ASUS P701 eeepc also changed the
mixers of other ALC662 models, duplicating entries for the Capture
items, making them to not work anymore. This fixes it by removing
duplicated entries using where possible the common alc662_capture_mixer.
Also alc662_capture_mixer should use alc662* functions and not alc882
(I checked /proc/asound/card0/codec* on an eepc model and it's ok).

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1c50278..85e54d1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11728,17 +11728,6 @@ static struct snd_kcontrol_new alc662_3ST_2ch_mixer[] = {
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x05, HDA_INPUT),
 	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x05, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		/* .name = "Capture Source", */
-		.name = "Input Source",
-		.count = 1,
-		.info = alc662_mux_enum_info,
-		.get = alc662_mux_enum_get,
-		.put = alc662_mux_enum_put,
-	},
 	{ } /* end */
 };
 
@@ -11762,17 +11751,6 @@ static struct snd_kcontrol_new alc662_3ST_6ch_mixer[] = {
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x05, HDA_INPUT),
 	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x05, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		/* .name = "Capture Source", */
-		.name = "Input Source",
-		.count = 1,
-		.info = alc662_mux_enum_info,
-		.get = alc662_mux_enum_get,
-		.put = alc662_mux_enum_put,
-	},
 	{ } /* end */
 };
 
@@ -11786,17 +11764,6 @@ static struct snd_kcontrol_new alc662_lenovo_101e_mixer[] = {
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		/* .name = "Capture Source", */
-		.name = "Input Source",
-		.count = 1,
-		.info = alc662_mux_enum_info,
-		.get = alc662_mux_enum_get,
-		.put = alc662_mux_enum_put,
-	},
 	{ } /* end */
 };
 
@@ -11827,6 +11794,25 @@ static struct snd_kcontrol_new alc662_chmode_mixer[] = {
 	{ } /* end */
 };
 
+/* capture mixer elements */
+static struct snd_kcontrol_new alc662_capture_mixer[] = {
+	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		/* The multiple "Capture Source" controls confuse alsamixer
+		 * So call somewhat different..
+		 */
+		/* .name = "Capture Source", */
+		.name = "Input Source",
+		.count = 1,
+		.info = alc662_mux_enum_info,
+		.get = alc662_mux_enum_get,
+		.put = alc662_mux_enum_put,
+	},
+	{ } /* end */
+};
+
 static struct hda_verb alc662_init_verbs[] = {
 	/* ADC: mute amp left and right */
 	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
@@ -11949,26 +11935,6 @@ static struct hda_verb alc662_auto_init_verbs[] = {
 	{ }
 };
 
-/* capture mixer elements */
-static struct snd_kcontrol_new alc662_capture_mixer[] = {
-	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		/* The multiple "Capture Source" controls confuse alsamixer
-		 * So call somewhat different..
-		 * FIXME: the controls appear in the "playback" view!
-		 */
-		/* .name = "Capture Source", */
-		.name = "Input Source",
-		.count = 1,
-		.info = alc882_mux_enum_info,
-		.get = alc882_mux_enum_get,
-		.put = alc882_mux_enum_put,
-	},
-	{ } /* end */
-};
-
 static void alc662_lenovo_101e_ispeaker_automute(struct hda_codec *codec)
 {
 	unsigned int present;
@@ -12109,8 +12075,7 @@ static struct alc_config_preset alc662_presets[] = {
 		.input_mux = &alc662_capture_source,
 	},
 	[ALC662_5ST_DIG] = {
-		.mixers = { alc662_base_mixer, alc662_chmode_mixer,
-			    alc662_capture_mixer },
+		.mixers = { alc662_base_mixer, alc662_chmode_mixer },
 		.init_verbs = { alc662_init_verbs },
 		.num_dacs = ARRAY_SIZE(alc662_dac_nids),
 		.dac_nids = alc662_dac_nids,

--
[]'s
Herton
