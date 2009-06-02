From: Hector Martin <hector@marcansoft.com>
Subject: Re: [PATCH] RESEND: Acer Aspire 8930G support
Date: Tue, 02 Jun 2009 10:37:47 +0200
Message-ID: <4A24E4DB.2050801@marcansoft.com>
References: <4A24CD7B.4060809@marcansoft.com> <s5heiu3rrqo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030706070807050402090404"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.marcansoft.com (marcansoft.com [80.68.93.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AB5A244AB
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 10:37:49 +0200 (CEST)
In-Reply-To: <s5heiu3rrqo.wl%tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------030706070807050402090404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> The changes you made are fine, but could you reformat the patch as
> checkpatch.pl-clean and repost?

Done.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc


--------------030706070807050402090404
Content-Type: text/plain;
 name="alsa-aspire-8930g.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-aspire-8930g.patch"

Signed-off-by: Hector Martin <hector@marcansoft.com>
--- alsa-driver-1.0.20.8.g6254b.219.g5b2b1/alsa-kernel/pci/hda/patch_realtek_orig.c	2009-06-02 10:27:52.000000000 +0200
+++ alsa-driver-1.0.20.8.g6254b.219.g5b2b1/alsa-kernel/pci/hda/patch_realtek.c	2009-06-02 10:33:27.000000000 +0200
@@ -223,6 +223,7 @@
 	ALC883_ACER,
 	ALC883_ACER_ASPIRE,
 	ALC888_ACER_ASPIRE_4930G,
+	ALC888_ACER_ASPIRE_8930G,
 	ALC883_MEDION,
 	ALC883_MEDION_MD2,
 	ALC883_LAPTOP_EAPD,
@@ -313,6 +314,8 @@
 	const struct hda_channel_mode *channel_mode;
 	int num_channel_mode;
 	int need_dac_fix;
+	int const_channel_count;
+	int ext_channel_count;
 
 	/* PCM information */
 	struct hda_pcm pcm_rec[3];	/* used in alc_build_pcms() */
@@ -368,6 +371,7 @@
 	unsigned int num_channel_mode;
 	const struct hda_channel_mode *channel_mode;
 	int need_dac_fix;
+	int const_channel_count;
 	unsigned int num_mux_defs;
 	const struct hda_input_mux *input_mux;
 	void (*unsol_event)(struct hda_codec *, unsigned int);
@@ -462,7 +466,7 @@
 	struct alc_spec *spec = codec->spec;
 	return snd_hda_ch_mode_get(codec, ucontrol, spec->channel_mode,
 				   spec->num_channel_mode,
-				   spec->multiout.max_channels);
+				   spec->ext_channel_count);
 }
 
 static int alc_ch_mode_put(struct snd_kcontrol *kcontrol,
@@ -472,9 +476,12 @@
 	struct alc_spec *spec = codec->spec;
 	int err = snd_hda_ch_mode_put(codec, ucontrol, spec->channel_mode,
 				      spec->num_channel_mode,
-				      &spec->multiout.max_channels);
-	if (err >= 0 && spec->need_dac_fix)
-		spec->multiout.num_dacs = spec->multiout.max_channels / 2;
+				      &spec->ext_channel_count);
+	if (err >= 0 && spec->const_channel_count == 0) {
+		spec->multiout.max_channels = spec->ext_channel_count;
+		if (spec->need_dac_fix)
+			spec->multiout.num_dacs = spec->multiout.max_channels / 2;
+	}
 	return err;
 }
 
@@ -854,8 +861,13 @@
 	spec->channel_mode = preset->channel_mode;
 	spec->num_channel_mode = preset->num_channel_mode;
 	spec->need_dac_fix = preset->need_dac_fix;
+	spec->const_channel_count = preset->const_channel_count;
 
-	spec->multiout.max_channels = spec->channel_mode[0].channels;
+	if (preset->const_channel_count == 0)
+		spec->multiout.max_channels = preset->const_channel_count;
+	else
+		spec->multiout.max_channels = spec->channel_mode[0].channels;
+	spec->ext_channel_count = spec->channel_mode[0].channels;
 
 	spec->multiout.num_dacs = preset->num_dacs;
 	spec->multiout.dac_nids = preset->dac_nids;
@@ -1456,6 +1468,48 @@
 	{ }
 };
 
+/*
+ * ALC888 Acer Aspire 8930G model
+ */
+
+static struct hda_verb alc888_acer_aspire_8930g_verbs[] = {
+/* Front Mic: set to PIN_IN (empty by default) */
+	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+/* Unselect Front Mic by default in input mixer 3 */
+	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0xb)},
+/* Enable unsolicited event for HP jack */
+	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+/* Connect Internal Front to Front */
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x14, AC_VERB_SET_CONNECT_SEL, 0x00},
+/* Connect Internal Rear to Rear */
+	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x1b, AC_VERB_SET_CONNECT_SEL, 0x01},
+/* Connect Internal CLFE to CLFE */
+	{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x16, AC_VERB_SET_CONNECT_SEL, 0x02},
+/* Connect HP out to Front */
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
+/* Enable all DACs */
+/*  DAC DISABLE/MUTE 1? */
+/*  setting bits 1-5 disables DAC nids 0x02-0x06 apparently. Init=0x38 */
+	{0x20, AC_VERB_SET_COEF_INDEX, 0x03},
+	{0x20, AC_VERB_SET_PROC_COEF, 0x0000},
+/*  DAC DISABLE/MUTE 2? */
+/*  some bit here disables the other DACs. Init=0x4900 */
+	{0x20, AC_VERB_SET_COEF_INDEX, 0x08},
+	{0x20, AC_VERB_SET_PROC_COEF, 0x0000},
+/* Enable amplifiers */
+	{0x14, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
+	{0x15, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
+	{ }
+};
+
 static struct hda_input_mux alc888_2_capture_sources[2] = {
 	/* Front mic only available on one ADC */
 	{
@@ -1508,6 +1562,17 @@
 	alc_automute_amp(codec);
 }
 
+static void alc888_acer_aspire_8930g_init_hook(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+
+	spec->autocfg.hp_pins[0] = 0x15;
+	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->autocfg.speaker_pins[1] = 0x16;
+	spec->autocfg.speaker_pins[2] = 0x1b;
+	alc_automute_amp(codec);
+}
+
 /*
  * ALC880 3-stack model
  *
@@ -8708,6 +8773,7 @@
 	[ALC883_ACER]		= "acer",
 	[ALC883_ACER_ASPIRE]	= "acer-aspire",
 	[ALC888_ACER_ASPIRE_4930G]	= "acer-aspire-4930g",
+	[ALC888_ACER_ASPIRE_8930G]	= "acer-aspire-8930g",
 	[ALC883_MEDION]		= "medion",
 	[ALC883_MEDION_MD2]	= "medion-md2",
 	[ALC883_LAPTOP_EAPD]	= "laptop-eapd",
@@ -8746,6 +8812,8 @@
 		ALC888_ACER_ASPIRE_4930G),
 	SND_PCI_QUIRK(0x1025, 0x0166, "Acer Aspire 6530G",
 		ALC888_ACER_ASPIRE_4930G),
+	SND_PCI_QUIRK(0x1025, 0x0145, "Acer Aspire 8930G",
+		ALC888_ACER_ASPIRE_8930G),
 	/* default Acer -- disabled as it causes more problems.
 	 *    model=auto should work fine now
 	 */
@@ -8959,6 +9027,27 @@
 		.unsol_event = alc_automute_amp_unsol_event,
 		.init_hook = alc888_acer_aspire_4930g_init_hook,
 	},
+	[ALC888_ACER_ASPIRE_8930G] = {
+		.mixers = { alc888_base_mixer,
+				alc883_chmode_mixer },
+		.init_verbs = { alc883_init_verbs, alc880_gpio1_init_verbs,
+				alc888_acer_aspire_8930g_verbs },
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.num_adc_nids = ARRAY_SIZE(alc883_adc_nids_rev),
+		.adc_nids = alc883_adc_nids_rev,
+		.capsrc_nids = alc883_capsrc_nids_rev,
+		.dig_out_nid = ALC883_DIGOUT_NID,
+		.num_channel_mode = ARRAY_SIZE(alc883_3ST_6ch_modes),
+		.channel_mode = alc883_3ST_6ch_modes,
+		.need_dac_fix = 1,
+		.const_channel_count = 6,
+		.num_mux_defs =
+			ARRAY_SIZE(alc888_2_capture_sources),
+		.input_mux = alc888_2_capture_sources,
+		.unsol_event = alc_automute_amp_unsol_event,
+		.init_hook = alc888_acer_aspire_8930g_init_hook,
+	},
 	[ALC883_MEDION] = {
 		.mixers = { alc883_fivestack_mixer,
 			    alc883_chmode_mixer },

--------------030706070807050402090404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030706070807050402090404--
