From: Tony Vroon <tony@linx.net>
Subject: [PATCH] Acer Inspire 6530G model for Realtek ALC888
Date: Sun, 21 Jun 2009 00:40:10 +0100 (BST)
Message-ID: <20090620234010.BB353100F3@gold.linx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id BF60C24580
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Jun 2009 01:40:11 +0200 (CEST)
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

The selected 4930G model seemed to keep the subwoofer 'tuba' 
function from operating correctly. Removing the existing PCI 
ID match made this work again, but it was mapped to 'Side' 
instead of to LFE as one would expect.
This attempts to enable all functionality and keep the amount 
of available mixer sliders low. Any slider that had no audible 
effect on the output audio has been removed, and as such EAPD 
is not currently enabled.

Signed-off-by: Tony Vroon <tony@linx.net>

--- linux-2.6.30-git14/sound/pci/hda/patch_realtek.c.orig	2009-06-20 21:55:53.000000000 +0100
+++ linux-2.6.30-git14/sound/pci/hda/patch_realtek.c	2009-06-21 00:19:53.000000000 +0100
@@ -224,6 +224,7 @@
 	ALC883_ACER,
 	ALC883_ACER_ASPIRE,
 	ALC888_ACER_ASPIRE_4930G,
+	ALC888_ACER_ASPIRE_6530G,
 	ALC888_ACER_ASPIRE_8930G,
 	ALC883_MEDION,
 	ALC883_MEDION_MD2,
@@ -1471,6 +1472,25 @@
 };
 
 /*
+ * ALC888 Acer Aspire 6530G model
+ */
+
+static struct hda_verb alc888_acer_aspire_6530g_verbs[] = {
+/* Bias voltage on for external mic port */
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN | PIN_VREF80},
+/* Enable unsolicited event for HP jack */
+	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+/* Enable speaker output */
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+/* Enable headphone output */
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT | PIN_HP},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{ }
+};
+
+/*
  * ALC889 Acer Aspire 8930G model
  */
 
@@ -1544,6 +1564,25 @@
 	}
 };
 
+static struct hda_input_mux alc888_acer_aspire_6530_sources[2] = {
+	/* Interal mic only available on one ADC */
+	{
+		.num_items = 3,
+		.items = {
+			{ "Ext Mic", 0x0 },
+			{ "CD", 0x4 },
+			{ "Int Mic", 0xb },
+		},
+	},
+	{
+		.num_items = 2,
+		.items = {
+			{ "Ext Mic", 0x0 },
+			{ "CD", 0x4 },
+		},
+	}
+};
+
 static struct hda_input_mux alc889_capture_sources[3] = {
 	/* Digital mic only available on first "ADC" */
 	{
@@ -8153,6 +8192,19 @@
 	{ } /* end */
 };
 
+static struct snd_kcontrol_new alc888_acer_aspire_6530_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("LFE Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("LFE Playback Switch", 0x0f, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	{ } /* end */
+};
+
 static struct snd_kcontrol_new alc888_lenovo_sky_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
@@ -9021,7 +9073,7 @@
 	SND_PCI_QUIRK(0x1025, 0x015e, "Acer Aspire 6930G",
 		ALC888_ACER_ASPIRE_4930G),
 	SND_PCI_QUIRK(0x1025, 0x0166, "Acer Aspire 6530G",
-		ALC888_ACER_ASPIRE_4930G),
+		ALC888_ACER_ASPIRE_6530G),
 	/* default Acer -- disabled as it causes more problems.
 	 *    model=auto should work fine now
 	 */
@@ -9255,6 +9307,24 @@
 		.unsol_event = alc_automute_amp_unsol_event,
 		.init_hook = alc888_acer_aspire_4930g_init_hook,
 	},
+	[ALC888_ACER_ASPIRE_6530G] = {
+		.mixers = { alc888_acer_aspire_6530_mixer },
+		.init_verbs = { alc883_init_verbs, alc880_gpio1_init_verbs,
+				alc888_acer_aspire_6530g_verbs },
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.num_adc_nids = ARRAY_SIZE(alc883_adc_nids_rev),
+		.adc_nids = alc883_adc_nids_rev,
+		.capsrc_nids = alc883_capsrc_nids_rev,
+		.dig_out_nid = ALC883_DIGOUT_NID,
+		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
+		.channel_mode = alc883_3ST_2ch_modes,
+		.num_mux_defs =
+			ARRAY_SIZE(alc888_2_capture_sources),
+		.input_mux = alc888_acer_aspire_6530_sources,
+		.unsol_event = alc_automute_amp_unsol_event,
+		.init_hook = alc888_acer_aspire_4930g_init_hook,
+	},
 	[ALC888_ACER_ASPIRE_8930G] = {
 		.mixers = { alc888_base_mixer,
 				alc883_chmode_mixer },
