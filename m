From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH 1/2] ALSA: hda - Configure XO-1.5 microphones
	at capture time
Date: Thu,  7 Jan 2010 12:46:25 +0000 (GMT)
Message-ID: <20100107124625.F0B899D400D@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mtaout03-winn.ispmail.ntl.com (mtaout03-winn.ispmail.ntl.com
	[81.103.221.49]) by alsa0.perex.cz (Postfix) with ESMTP id 4916024500
	for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2010 13:46:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, devel@lists.laptop.org
List-Id: alsa-devel@alsa-project.org

The XO-1.5 has a microphone LED designed to indicate to the user when
something is being recorded.

This light is controlled by the microphone bias voltage and it is
currently coming on all the time.

This patch defers the microphone port configuration until when recording
is actually taking place, fixing the behaviour of the LED.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 sound/pci/hda/patch_conexant.c |  125 +++++++++++++++++++++++++++-------------
 1 files changed, 85 insertions(+), 40 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index c578c28..9ad1219 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -111,8 +111,12 @@ struct conexant_spec {
 
 	unsigned int dell_automute;
 	unsigned int port_d_mode;
-	unsigned char ext_mic_bias;
 	unsigned int dell_vostro;
+
+	unsigned int ext_mic_present;
+	unsigned int recording;
+	void (*capture_prepare)(struct hda_codec *codec);
+	void (*capture_cleanup)(struct hda_codec *codec);
 };
 
 static int conexant_playback_pcm_open(struct hda_pcm_stream *hinfo,
@@ -185,6 +189,8 @@ static int conexant_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
 				      struct snd_pcm_substream *substream)
 {
 	struct conexant_spec *spec = codec->spec;
+	if (spec->capture_prepare)
+		spec->capture_prepare(codec);
 	snd_hda_codec_setup_stream(codec, spec->adc_nids[substream->number],
 				   stream_tag, 0, format);
 	return 0;
@@ -196,6 +202,8 @@ static int conexant_capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
 {
 	struct conexant_spec *spec = codec->spec;
 	snd_hda_codec_cleanup_stream(codec, spec->adc_nids[substream->number]);
+	if (spec->capture_cleanup)
+		spec->capture_cleanup(codec);
 	return 0;
 }
 
@@ -1966,53 +1974,53 @@ static int cxt5066_hp_master_sw_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-/* toggle input of built-in and mic jack appropriately */
-static void cxt5066_automic(struct hda_codec *codec)
+/* OLPC defers mic widget control until when capture is started because the
+ * microphone LED comes on as soon as these settings are put in place. if we
+ * did this before recording, it would give the false indication that recording
+ * is happening when it is not. */
+static void cxt5066_olpc_select_mic(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
-	struct hda_verb ext_mic_present[] = {
-		/* enable external mic, port B */
-		{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, spec->ext_mic_bias},
-
-		/* switch to external mic input */
-		{0x17, AC_VERB_SET_CONNECT_SEL, 0},
+	if (!spec->recording)
+		return;
 
-		/* disable internal mic, port C */
-		{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
-		{}
-	};
-	static struct hda_verb ext_mic_absent[] = {
-		/* enable internal mic, port C */
-		{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
+	/* external mic, port B */
+	snd_hda_codec_write(codec, 0x1a, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+		spec->ext_mic_present ? CXT5066_OLPC_EXT_MIC_BIAS : 0);
 
-		/* switch to internal mic input */
-		{0x17, AC_VERB_SET_CONNECT_SEL, 1},
+	/* internal mic, port C */
+	snd_hda_codec_write(codec, 0x1b, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+		spec->ext_mic_present ? 0 : PIN_VREF80);
+}
 
-		/* disable external mic, port B */
-		{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
-		{}
-	};
+/* toggle input of built-in and mic jack appropriately */
+static void cxt5066_olpc_automic(struct hda_codec *codec)
+{
+	struct conexant_spec *spec = codec->spec;
 	unsigned int present;
 
-	present = snd_hda_jack_detect(codec, 0x1a);
-	if (present) {
+	present = snd_hda_codec_read(codec, 0x1a, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	if (present)
 		snd_printdd("CXT5066: external microphone detected\n");
-		snd_hda_sequence_write(codec, ext_mic_present);
-	} else {
+	else
 		snd_printdd("CXT5066: external microphone absent\n");
-		snd_hda_sequence_write(codec, ext_mic_absent);
-	}
+
+	snd_hda_codec_write(codec, 0x17, 0, AC_VERB_SET_CONNECT_SEL,
+		present ? 0 : 1);
+	spec->ext_mic_present = !!present;
+
+	cxt5066_olpc_select_mic(codec);
 }
 
 /* toggle input of built-in digital mic and mic jack appropriately */
 static void cxt5066_vostro_automic(struct hda_codec *codec)
 {
-	struct conexant_spec *spec = codec->spec;
 	unsigned int present;
 
 	struct hda_verb ext_mic_present[] = {
 		/* enable external mic, port B */
-		{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, spec->ext_mic_bias},
+		{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
 
 		/* switch to external mic input */
 		{0x17, AC_VERB_SET_CONNECT_SEL, 0},
@@ -2063,7 +2071,7 @@ static void cxt5066_hp_automute(struct hda_codec *codec)
 }
 
 /* unsolicited event for jack sensing */
-static void cxt5066_unsol_event(struct hda_codec *codec, unsigned int res)
+static void cxt5066_olpc_unsol_event(struct hda_codec *codec, unsigned int res)
 {
 	snd_printdd("CXT5066: unsol event %x (%x)\n", res, res >> 26);
 	switch (res >> 26) {
@@ -2071,7 +2079,7 @@ static void cxt5066_unsol_event(struct hda_codec *codec, unsigned int res)
 		cxt5066_hp_automute(codec);
 		break;
 	case CONEXANT_MIC_EVENT:
-		cxt5066_automic(codec);
+		cxt5066_olpc_automic(codec);
 		break;
 	}
 }
@@ -2147,6 +2155,31 @@ static int cxt5066_mic_boost_mux_enum_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+static void cxt5066_olpc_capture_prepare(struct hda_codec *codec)
+{
+	struct conexant_spec *spec = codec->spec;
+	/* mark as recording and configure the microphone widget so that the
+	 * recording LED comes on. */
+	spec->recording = 1;
+	cxt5066_olpc_select_mic(codec);
+}
+
+static void cxt5066_olpc_capture_cleanup(struct hda_codec *codec)
+{
+	struct conexant_spec *spec = codec->spec;
+	const struct hda_verb disable_mics[] = {
+		/* disable external mic, port B */
+		{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+
+		/* disble internal mic, port C */
+		{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+		{},
+	};
+
+	snd_hda_sequence_write(codec, disable_mics);
+	spec->recording = 0;
+}
+
 static struct hda_input_mux cxt5066_capture_source = {
 	.num_items = 4,
 	.items = {
@@ -2296,10 +2329,10 @@ static struct hda_verb cxt5066_init_verbs_olpc[] = {
 	{0x19, AC_VERB_SET_CONNECT_SEL, 0x00}, /* DAC1 */
 
 	/* Port B: external microphone */
-	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, CXT5066_OLPC_EXT_MIC_BIAS},
+	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
 
 	/* Port C: internal microphone */
-	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
+	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
 
 	/* Port D: unused */
 	{0x1c, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
@@ -2428,12 +2461,19 @@ static int cxt5066_init(struct hda_codec *codec)
 		cxt5066_hp_automute(codec);
 		if (spec->dell_vostro)
 			cxt5066_vostro_automic(codec);
-		else
-			cxt5066_automic(codec);
 	}
 	return 0;
 }
 
+static int cxt5066_olpc_init(struct hda_codec *codec)
+{
+	snd_printdd("CXT5066: init\n");
+	conexant_init(codec);
+	cxt5066_hp_automute(codec);
+	cxt5066_olpc_automic(codec);
+	return 0;
+}
+
 enum {
 	CXT5066_LAPTOP,			/* Laptops w/ EAPD support */
 	CXT5066_DELL_LAPTOP,	/* Dell Laptop */
@@ -2470,7 +2510,7 @@ static int patch_cxt5066(struct hda_codec *codec)
 	codec->spec = spec;
 
 	codec->patch_ops = conexant_patch_ops;
-	codec->patch_ops.init = cxt5066_init;
+	codec->patch_ops.init = conexant_init;
 
 	spec->dell_automute = 0;
 	spec->multiout.max_channels = 2;
@@ -2483,7 +2523,6 @@ static int patch_cxt5066(struct hda_codec *codec)
 	spec->input_mux = &cxt5066_capture_source;
 
 	spec->port_d_mode = PIN_HP;
-	spec->ext_mic_bias = PIN_VREF80;
 
 	spec->num_init_verbs = 1;
 	spec->init_verbs[0] = cxt5066_init_verbs;
@@ -2510,20 +2549,26 @@ static int patch_cxt5066(struct hda_codec *codec)
 		spec->dell_automute = 1;
 		break;
 	case CXT5066_OLPC_XO_1_5:
-		codec->patch_ops.unsol_event = cxt5066_unsol_event;
+		codec->patch_ops.init = cxt5066_olpc_init;
+		codec->patch_ops.unsol_event = cxt5066_olpc_unsol_event;
 		spec->init_verbs[0] = cxt5066_init_verbs_olpc;
 		spec->mixers[spec->num_mixers++] = cxt5066_mixer_master_olpc;
 		spec->mixers[spec->num_mixers++] = cxt5066_mixers;
 		spec->port_d_mode = 0;
-		spec->ext_mic_bias = CXT5066_OLPC_EXT_MIC_BIAS;
 
 		/* no S/PDIF out */
 		spec->multiout.dig_out_nid = 0;
 
 		/* input source automatically selected */
 		spec->input_mux = NULL;
+
+		/* our capture hooks which allow us to turn on the microphone LED
+		 * at the right time */
+		spec->capture_prepare = cxt5066_olpc_capture_prepare;
+		spec->capture_cleanup = cxt5066_olpc_capture_cleanup;
 		break;
 	case CXT5066_DELL_VOSTO:
+		codec->patch_ops.init = cxt5066_init;
 		codec->patch_ops.unsol_event = cxt5066_vostro_event;
 		spec->init_verbs[0] = cxt5066_init_verbs_vostro;
 		spec->mixers[spec->num_mixers++] = cxt5066_mixer_master_olpc;
-- 
1.6.2.5
