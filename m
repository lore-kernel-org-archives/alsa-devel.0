From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] HDA/Realtek: multiple input mux definitions and pin mode additions
Date: Mon, 27 Mar 2006 09:06:43 +0930 (CST)
Message-ID: <200603262336.k2QNahYB006656@auster.physics.adelaide.edu.au>
References: <s5hr74uyc3h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr74uyc3h.wl%tiwai@suse.de> from "Takashi Iwai" at Mar 22, 2006 12:04:34 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Rimas Kudelis <rq@akl.lt>, Lee Revell <rlrevell@joe-job.com>, ALSA devel <alsa-devel@lists.sourceforge.net>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi everyone

The following patch relative to CVS from 20060324 adds the following
features to the Realtek HDA codec.

1) Define two new pin modes: ALC_PIN_DIR_IN_NOMICBIAS and
   ALC_PIN_DIR_INOUT_NOMICBIAS.  These can be used with jack mode switch
   definitions in mixers to prevent the user being offered the mic bias
   options if the hardware doesn't support it.

2) Add the ability to have different input mux definitions for different
   ADCs.  This is needed because the ALC260 chip uses different mux layouts
   for the two onboard ADCs.  A new field (num_mux_defs) was added to the
   alc_spec and alc_config_preset structures to support this.

3) Adjust numerous comments to make them consistent with the above changes.

4) Utilise the new multi-mux definition functionality for the ALC260 fujitsu
   model to allow recording of the mixer output.

5) Utilise the new multi-mux definition functionality for the ALC260 test
   model to make the mux selections a little less confusing.

6) Allow the headphone jack of the ALC260 acer model to be retasked in
   the mixer.

6) Utilise the new multi-mux definition functionality for the ALC260 acer
   model to give access to the mixer output and the retasked headphone
   jack.

At this stage the *_NOMICBIAS modes are not used.  We have reports that the
"Line" jack of at least some Acer models doesn't pass the bias out, and we
also know that NIDs 0x0f and 0x10 don't seem to accept the mic bias requests
at all.  However, I feel we need to collect more evidence on both counts
before committing to the use of *_NOMICBIAS.  In the case of the Acers, it's
not clear whether this issue (probably caused by the inclusion of DC
blocking capacitors) affects all Acer models or just a small number.  With
the issue with NIDs 0x0f and 0x10 it's unclear whether this is a hardware
bug which will be addressed in later chip revisions or if it's an
intentional restriction.  The datasheet makes no mention of the restriction
so at this stage I'm inclined to consider it a hardware bug.  Comments in
the source reflect this reasoning.

On a similar theme, the headphone jack of the Fujitsu S7020 also doesn't
appear to pass mic bias voltage.  I'm still investigating this however.

With the ability to retask the headphone jack, owners of ALC260-based Acer
laptops should now be able to record 4 channels of audio if they desire. The
multiple mux definitions allow this jack to be presented from both ADCs
(since this mux input is one of those which differs between the muxes).

This patch has been tested on a Fujitsu S7020 laptop and appears to behave
itself both for the "test" and "fujitsu" models.  Definitions using only a
single mux specification also work.  Other ALC chips should be fine but I
cannot test these myself.  The "auto" modes should also continue to function
but again I have not verified this.

I apologise that this patch does so much (although note that a majority
of the patch is consumed by comment revision).  The major problem was that
many of these changes were inter-related and the changes were done in an
order which did not facilitate sensible splitting of the patch.  If this
is a problem let me know and I'll try to split it up, but it could be fiddly.

Regards
  jonathan

--- patch_realtek.c-orig	2006-03-24 16:49:31.000000000 +1030
+++ patch_realtek.c	2006-03-26 21:53:03.000000000 +0930
@@ -132,6 +132,7 @@
 	hda_nid_t dig_in_nid;		/* digital-in NID; optional */
 
 	/* capture source */
+	unsigned int num_mux_defs;
 	const struct hda_input_mux *input_mux;
 	unsigned int cur_mux[3];
 
@@ -173,6 +174,7 @@
 	hda_nid_t dig_in_nid;
 	unsigned int num_channel_mode;
 	const struct hda_channel_mode *channel_mode;
+	unsigned int num_mux_defs;
 	const struct hda_input_mux *input_mux;
 	void (*unsol_event)(struct hda_codec *, unsigned int);
 	void (*init_hook)(struct hda_codec *);
@@ -186,7 +188,10 @@
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct alc_spec *spec = codec->spec;
-	return snd_hda_input_mux_info(spec->input_mux, uinfo);
+	unsigned int mux_idx = snd_ctl_get_ioffidx(kcontrol, &uinfo->id);
+	if (mux_idx >= spec->num_mux_defs)
+		mux_idx = 0;
+	return snd_hda_input_mux_info(&spec->input_mux[mux_idx], uinfo);
 }
 
 static int alc_mux_enum_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -204,7 +209,8 @@
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct alc_spec *spec = codec->spec;
 	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
-	return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
+	unsigned int mux_idx = (adc_idx>=spec->num_mux_defs?0:adc_idx);
+	return snd_hda_input_mux_put(codec, &spec->input_mux[mux_idx], ucontrol,
 				     spec->adc_nids[adc_idx], &spec->cur_mux[adc_idx]);
 }
 
@@ -246,7 +252,8 @@
  * states other than HiZ (eg: PIN_VREFxx) and revert to HiZ if any of these
  * are requested.  Therefore order this list so that this behaviour will not
  * cause problems when mixer clients move through the enum sequentially.
- * NIDs 0x0f and 0x10 have been observed to have this behaviour.
+ * NIDs 0x0f and 0x10 have been observed to have this behaviour as of
+ * March 2006.
  */
 static char *alc_pin_mode_names[] = {
 	"Mic 50pc bias", "Mic 80pc bias",
@@ -256,19 +263,27 @@
 	PIN_VREF50, PIN_VREF80, PIN_IN, PIN_OUT, PIN_HP,
 };
 /* The control can present all 5 options, or it can limit the options based
- * in the pin being assumed to be exclusively an input or an output pin.
- */
-#define ALC_PIN_DIR_IN    0x00
-#define ALC_PIN_DIR_OUT   0x01
-#define ALC_PIN_DIR_INOUT 0x02
+ * in the pin being assumed to be exclusively an input or an output pin.  In
+ * addition, "input" pins may or may not process the mic bias option
+ * depending on actual widget capability (NIDs 0x0f and 0x10 don't seem to
+ * accept requests for bias as of chip versions up to March 2006) and/or
+ * wiring in the computer.
+ */
+#define ALC_PIN_DIR_IN              0x00
+#define ALC_PIN_DIR_OUT             0x01
+#define ALC_PIN_DIR_INOUT           0x02
+#define ALC_PIN_DIR_IN_NOMICBIAS    0x03
+#define ALC_PIN_DIR_INOUT_NOMICBIAS 0x04
 
-/* Info about the pin modes supported by the three different pin directions. 
+/* Info about the pin modes supported by the different pin direction modes. 
  * For each direction the minimum and maximum values are given.
  */
-static signed char alc_pin_mode_dir_info[3][2] = {
+static signed char alc_pin_mode_dir_info[5][2] = {
 	{ 0, 2 },    /* ALC_PIN_DIR_IN */
 	{ 3, 4 },    /* ALC_PIN_DIR_OUT */
 	{ 0, 4 },    /* ALC_PIN_DIR_INOUT */
+	{ 2, 2 },    /* ALC_PIN_DIR_IN_NOMICBIAS */
+	{ 2, 4 },    /* ALC_PIN_DIR_INOUT_NOMICBIAS */
 };
 #define alc_pin_mode_min(_dir) (alc_pin_mode_dir_info[_dir][0])
 #define alc_pin_mode_max(_dir) (alc_pin_mode_dir_info[_dir][1])
@@ -330,9 +345,10 @@
 		 * input modes.
 		 *
 		 * Dynamically switching the input/output buffers probably
-		 * reduces noise slightly, particularly on input.  However,
-		 * havingboth input and output buffers enabled
-		 * simultaneously doesn't seem to be problematic.
+		 * reduces noise slightly (particularly on input) so we'll
+		 * do it.  However, having both input and output buffers
+		 * enabled simultaneously doesn't seem to be problematic if
+		 * this turns out to be necessary in the future.
 		 */
 		if (val <= 2) {
 			snd_hda_codec_write(codec,nid,0,AC_VERB_SET_AMP_GAIN_MUTE,
@@ -484,6 +500,7 @@
 	spec->multiout.dig_out_nid = preset->dig_out_nid;
 	spec->multiout.hp_nid = preset->hp_nid;
 	
+	spec->num_mux_defs = preset->num_mux_defs;
 	spec->input_mux = preset->input_mux;
 
 	spec->num_adc_nids = preset->num_adc_nids;
@@ -2177,6 +2194,7 @@
 		.dac_nids = alc880_dac_nids,
 		.num_channel_mode = ARRAY_SIZE(alc880_threestack_modes),
 		.channel_mode = alc880_threestack_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_capture_source,
 	},
 	[ALC880_3ST_DIG] = {
@@ -2187,6 +2205,7 @@
 		.dig_out_nid = ALC880_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc880_threestack_modes),
 		.channel_mode = alc880_threestack_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_capture_source,
 	},
 	[ALC880_TCL_S700] = {
@@ -2199,6 +2218,7 @@
 		.hp_nid = 0x03,
 		.num_channel_mode = ARRAY_SIZE(alc880_2_jack_modes),
 		.channel_mode = alc880_2_jack_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_capture_source,
 	},
 	[ALC880_5ST] = {
@@ -2208,6 +2228,7 @@
 		.dac_nids = alc880_dac_nids,
 		.num_channel_mode = ARRAY_SIZE(alc880_fivestack_modes),
 		.channel_mode = alc880_fivestack_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_capture_source,
 	},
 	[ALC880_5ST_DIG] = {
@@ -2218,6 +2239,7 @@
 		.dig_out_nid = ALC880_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc880_fivestack_modes),
 		.channel_mode = alc880_fivestack_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_capture_source,
 	},
 	[ALC880_6ST] = {
@@ -2227,6 +2249,7 @@
 		.dac_nids = alc880_6st_dac_nids,
 		.num_channel_mode = ARRAY_SIZE(alc880_sixstack_modes),
 		.channel_mode = alc880_sixstack_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_6stack_capture_source,
 	},
 	[ALC880_6ST_DIG] = {
@@ -2237,6 +2260,7 @@
 		.dig_out_nid = ALC880_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc880_sixstack_modes),
 		.channel_mode = alc880_sixstack_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_6stack_capture_source,
 	},
 	[ALC880_W810] = {
@@ -2248,6 +2272,7 @@
 		.dig_out_nid = ALC880_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc880_w810_modes),
 		.channel_mode = alc880_w810_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_capture_source,
 	},
 	[ALC880_Z71V] = {
@@ -2259,6 +2284,7 @@
 		.hp_nid = 0x03,
 		.num_channel_mode = ARRAY_SIZE(alc880_2_jack_modes),
 		.channel_mode = alc880_2_jack_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_capture_source,
 	},
 	[ALC880_F1734] = {
@@ -2269,6 +2295,7 @@
 		.hp_nid = 0x02,
 		.num_channel_mode = ARRAY_SIZE(alc880_2_jack_modes),
 		.channel_mode = alc880_2_jack_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_capture_source,
 	},
 	[ALC880_ASUS] = {
@@ -2279,6 +2306,7 @@
 		.dac_nids = alc880_asus_dac_nids,
 		.num_channel_mode = ARRAY_SIZE(alc880_asus_modes),
 		.channel_mode = alc880_asus_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_capture_source,
 	},
 	[ALC880_ASUS_DIG] = {
@@ -2290,6 +2318,7 @@
 		.dig_out_nid = ALC880_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc880_asus_modes),
 		.channel_mode = alc880_asus_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_capture_source,
 	},
 	[ALC880_ASUS_DIG2] = {
@@ -2301,6 +2330,7 @@
 		.dig_out_nid = ALC880_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc880_asus_modes),
 		.channel_mode = alc880_asus_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_capture_source,
 	},
 	[ALC880_ASUS_W1V] = {
@@ -2312,6 +2342,7 @@
 		.dig_out_nid = ALC880_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc880_asus_modes),
 		.channel_mode = alc880_asus_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_capture_source,
 	},
 	[ALC880_UNIWILL_DIG] = {
@@ -2322,6 +2353,7 @@
 		.dig_out_nid = ALC880_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc880_asus_modes),
 		.channel_mode = alc880_asus_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_capture_source,
 	},
 	[ALC880_CLEVO] = {
@@ -2333,6 +2365,7 @@
 		.hp_nid = 0x03,
 		.num_channel_mode = ARRAY_SIZE(alc880_threestack_modes),
 		.channel_mode = alc880_threestack_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_capture_source,
 	},
 	[ALC880_LG] = {
@@ -2344,6 +2377,7 @@
 		.dig_out_nid = ALC880_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc880_lg_ch_modes),
 		.channel_mode = alc880_lg_ch_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_lg_capture_source,
 		.unsol_event = alc880_lg_unsol_event,
 		.init_hook = alc880_lg_automute,
@@ -2357,6 +2391,7 @@
 		.dig_out_nid = ALC880_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc880_2_jack_modes),
 		.channel_mode = alc880_2_jack_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_lg_lw_capture_source,
 		.unsol_event = alc880_lg_lw_unsol_event,
 		.init_hook = alc880_lg_lw_automute,
@@ -2370,6 +2405,7 @@
 		.dig_out_nid = ALC880_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc880_test_modes),
 		.channel_mode = alc880_test_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc880_test_capture_source,
 	},
 #endif
@@ -2686,6 +2722,7 @@
 
 	spec->init_verbs[spec->num_init_verbs++] = alc880_volume_init_verbs;
 
+	spec->num_mux_defs = 1;
 	spec->input_mux = &spec->private_imux;
 
 	return 1;
@@ -2815,30 +2852,56 @@
 };
 
 /* On Fujitsu S702x laptops capture only makes sense from Mic/LineIn jack,
- * headphone jack and the internal CD lines.
+ * headphone jack and the internal CD lines since these are the only pins at
+ * which audio can appear.  For flexibility, also allow the option of
+ * recording the mixer output on the second ADC (ADC0 doesn't have a
+ * connection to the mixer output).
  */
-static struct hda_input_mux alc260_fujitsu_capture_source = {
-	.num_items = 3,
-	.items = {
-		{ "Mic/Line", 0x0 },
-		{ "CD", 0x4 },
-		{ "Headphone", 0x2 },
+static struct hda_input_mux alc260_fujitsu_capture_sources[2] = {
+	{
+		.num_items = 3,
+		.items = {
+			{ "Mic/Line", 0x0 },
+			{ "CD", 0x4 },
+			{ "Headphone", 0x2 },
+		},
+	},
+	{
+		.num_items = 4,
+		.items = {
+			{ "Mic/Line", 0x0 },
+			{ "CD", 0x4 },
+			{ "Headphone", 0x2 },
+			{ "Mixer", 0x5 },
+		},
 	},
+
 };
 
-/* Acer TravelMate(/Extensa/Aspire) notebooks have similar configutation to
- * the Fujitsu S702x, but jacks are marked differently. We won't allow
- * retasking the Headphone jack, so it won't be available here.
+/* Acer TravelMate(/Extensa/Aspire) notebooks have similar configuration to
+ * the Fujitsu S702x, but jacks are marked differently.
  */
-static struct hda_input_mux alc260_acer_capture_source = {
-	.num_items = 3,
-	.items = {
-		{ "Mic", 0x0 },
-		{ "Line", 0x2 },
-		{ "CD", 0x4 },
+static struct hda_input_mux alc260_acer_capture_sources[2] = {
+	{
+		.num_items = 4,
+		.items = {
+			{ "Mic", 0x0 },
+			{ "Line", 0x2 },
+			{ "CD", 0x4 },
+			{ "Headphone", 0x5 },
+		},
+	},
+	{
+		.num_items = 5,
+		.items = {
+			{ "Mic", 0x0 },
+			{ "Line", 0x2 },
+			{ "CD", 0x4 },
+			{ "Headphone", 0x6 },
+			{ "Mixer", 0x5 },
+		},
 	},
 };
-
 /*
  * This is just place-holder, so there's something for alc_build_pcms to look
  * at when it calculates the maximum number of channels. ALC260 has no mixer
@@ -2899,6 +2962,9 @@
 	{ } /* end */
 };
 
+/* Fujitsu S702x series laptops.  ALC260 pin usage: Mic/Line jack = 0x12, 
+ * HP jack = 0x14, CD audio =  0x16, internal speaker = 0x10.
+ */
 static struct snd_kcontrol_new alc260_fujitsu_mixer[] = {
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x08, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Headphone Playback Switch", 0x08, 2, HDA_INPUT),
@@ -2915,9 +2981,28 @@
 	{ } /* end */
 };
 
+/* Mixer for Acer TravelMate(/Extensa/Aspire) notebooks.  Note that current
+ * versions of the ALC260 don't act on requests to enable mic bias from NID
+ * 0x0f (used to drive the headphone jack in these laptops).  The ALC260
+ * datasheet doesn't mention this restriction.  At this stage it's not clear
+ * whether this behaviour is intentional or is a hardware bug in chip
+ * revisions available in early 2006.  Therefore for now allow the
+ * "Headphone Jack Mode" control to span all choices, but if it turns out
+ * that the lack of mic bias for this NID is intentional we could change the
+ * mode from ALC_PIN_DIR_INOUT to ALC_PIN_DIR_INOUT_NOMICBIAS.
+ *
+ * In addition, Acer TravelMate(/Extensa/Aspire) notebooks in early 2006
+ * don't appear to make the mic bias available from the "line" jack, even
+ * though the NID used for this jack (0x14) can supply it.  The theory is
+ * that perhaps Acer have included blocking capacitors between the ALC260
+ * and the output jack.  If this turns out to be the case for all such
+ * models the "Line Jack Mode" mode could be changed from ALC_PIN_DIR_INOUT
+ * to ALC_PIN_DIR_INOUT_NOMICBIAS.
+ */
 static struct snd_kcontrol_new alc260_acer_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0x08, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Master Playback Switch", 0x08, 2, HDA_INPUT),
+	ALC_PIN_MODE("Headphone Jack Mode", 0x0f, ALC_PIN_DIR_INOUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x07, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x07, 0x04, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x07, 0x0, HDA_INPUT),
@@ -3131,7 +3216,8 @@
 };
 
 /* Initialisation sequence for ALC260 as configured in Fujitsu S702x
- * laptops.
+ * laptops.  ALC260 pin usage: Mic/Line jack = 0x12, HP jack = 0x14, CD
+ * audio = 0x16, internal speaker = 0x10.
  */
 static struct hda_verb alc260_fujitsu_init_verbs[] = {
 	/* Disable all GPIOs */
@@ -3278,10 +3364,10 @@
 	{0x04, AC_VERB_SET_CONNECT_SEL, 0x00},
 
 	/* Do similar with the second ADC: mute capture input amp and
-	 * set ADC connection to line (on line1 pin)
+	 * set ADC connection to mic to match ALSA's default state.
 	 */
 	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x05, AC_VERB_SET_CONNECT_SEL, 0x02},
+	{0x05, AC_VERB_SET_CONNECT_SEL, 0x00},
 
 	/* Mute all inputs to mixer widget (even unconnected ones) */
 	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)}, /* mic1 pin */
@@ -3306,26 +3392,35 @@
 static hda_nid_t alc260_test_adc_nids[2] = {
 	0x04, 0x05,
 };
-/* This is a bit messy since the two input muxes in the ALC260 have slight
- * variations in their signal assignments.  The ideal way to deal with this
- * is to extend alc_spec.input_mux to allow a different input MUX for each
- * ADC.  For the purposes of the test model it's sufficient to just list
- * both options for affected signal indices.  The separate input mux
- * functionality only needs to be considered if a model comes along which
- * actually uses signals 0x5, 0x6 and 0x7 for something which makes sense to
- * record.
+/* For testing the ALC260, each input MUX needs its own definition since
+ * the signal assignments are different.  This assumes that the first ADC 
+ * is NID 0x04.
  */
-static struct hda_input_mux alc260_test_capture_source = {
-	.num_items = 8,
-	.items = {
-		{ "MIC1 pin", 0x0 },
-		{ "MIC2 pin", 0x1 },
-		{ "LINE1 pin", 0x2 },
-		{ "LINE2 pin", 0x3 },
-		{ "CD pin", 0x4 },
-		{ "LINE-OUT pin (cap1), Mixer (cap2)", 0x5 },
-		{ "HP-OUT pin (cap1), LINE-OUT pin (cap2)", 0x6 },
-		{ "HP-OUT pin (cap2 only)", 0x7 },
+static struct hda_input_mux alc260_test_capture_sources[2] = {
+	{
+		.num_items = 7,
+		.items = {
+			{ "MIC1 pin", 0x0 },
+			{ "MIC2 pin", 0x1 },
+			{ "LINE1 pin", 0x2 },
+			{ "LINE2 pin", 0x3 },
+			{ "CD pin", 0x4 },
+			{ "LINE-OUT pin", 0x5 },
+			{ "HP-OUT pin", 0x6 },
+		},
+        },
+	{
+		.num_items = 8,
+		.items = {
+			{ "MIC1 pin", 0x0 },
+			{ "MIC2 pin", 0x1 },
+			{ "LINE1 pin", 0x2 },
+			{ "LINE2 pin", 0x3 },
+			{ "CD pin", 0x4 },
+			{ "Mixer", 0x5 },
+			{ "LINE-OUT pin", 0x6 },
+			{ "HP-OUT pin", 0x7 },
+		},
         },
 };
 static struct snd_kcontrol_new alc260_test_mixer[] = {
@@ -3337,7 +3432,17 @@
 	HDA_CODEC_VOLUME("LOUT1 Playback Volume", 0x08, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("LOUT1 Playback Switch", 0x08, 2, HDA_INPUT),
 
-	/* Modes for retasking pin widgets */
+	/* Modes for retasking pin widgets
+	 * Note: the ALC260 doesn't seem to act on requests to enable mic
+         * bias from NIDs 0x0f and 0x10.  The ALC260 datasheet doesn't
+         * mention this restriction.  At this stage it's not clear whether
+         * this behaviour is intentional or is a hardware bug in chip
+         * revisions available at least up until early 2006.  Therefore for
+         * now allow the "HP-OUT" and "LINE-OUT" Mode controls to span all
+         * choices, but if it turns out that the lack of mic bias for these
+         * NIDs is intentional we could change their modes from
+         * ALC_PIN_DIR_INOUT to ALC_PIN_DIR_INOUT_NOMICBIAS.
+	 */
 	ALC_PIN_MODE("HP-OUT pin mode", 0x10, ALC_PIN_DIR_INOUT),
 	ALC_PIN_MODE("LINE-OUT pin mode", 0x0f, ALC_PIN_DIR_INOUT),
 	ALC_PIN_MODE("LINE2 pin mode", 0x15, ALC_PIN_DIR_INOUT),
@@ -3699,6 +3804,7 @@
 
 	spec->init_verbs[spec->num_init_verbs++] = alc260_volume_init_verbs;
 
+	spec->num_mux_defs = 1;
 	spec->input_mux = &spec->private_imux;
 
 	/* check whether NID 0x04 is valid */
@@ -3766,6 +3872,7 @@
 		.adc_nids = alc260_adc_nids,
 		.num_channel_mode = ARRAY_SIZE(alc260_modes),
 		.channel_mode = alc260_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc260_capture_source,
 	},
 	[ALC260_HP] = {
@@ -3779,6 +3886,7 @@
 		.adc_nids = alc260_hp_adc_nids,
 		.num_channel_mode = ARRAY_SIZE(alc260_modes),
 		.channel_mode = alc260_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc260_capture_source,
 	},
 	[ALC260_HP_3013] = {
@@ -3792,6 +3900,7 @@
 		.adc_nids = alc260_hp_adc_nids,
 		.num_channel_mode = ARRAY_SIZE(alc260_modes),
 		.channel_mode = alc260_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc260_capture_source,
 	},
 	[ALC260_FUJITSU_S702X] = {
@@ -3804,7 +3913,8 @@
 		.adc_nids = alc260_dual_adc_nids,
 		.num_channel_mode = ARRAY_SIZE(alc260_modes),
 		.channel_mode = alc260_modes,
-		.input_mux = &alc260_fujitsu_capture_source,
+		.num_mux_defs = ARRAY_SIZE(alc260_fujitsu_capture_sources),
+		.input_mux = alc260_fujitsu_capture_sources,
 	},
 	[ALC260_ACER] = {
 		.mixers = { alc260_acer_mixer,
@@ -3816,7 +3926,8 @@
 		.adc_nids = alc260_dual_adc_nids,
 		.num_channel_mode = ARRAY_SIZE(alc260_modes),
 		.channel_mode = alc260_modes,
-		.input_mux = &alc260_acer_capture_source,
+		.num_mux_defs = ARRAY_SIZE(alc260_acer_capture_sources),
+		.input_mux = alc260_acer_capture_sources,
 	},
 #ifdef CONFIG_SND_DEBUG
 	[ALC260_TEST] = {
@@ -3829,7 +3940,8 @@
 		.adc_nids = alc260_test_adc_nids,
 		.num_channel_mode = ARRAY_SIZE(alc260_modes),
 		.channel_mode = alc260_modes,
-		.input_mux = &alc260_test_capture_source,
+		.num_mux_defs = ARRAY_SIZE(alc260_test_capture_sources),
+		.input_mux = alc260_test_capture_sources,
 	},
 #endif
 };
@@ -3921,7 +4033,6 @@
 		{ "CD", 0x4 },
 	},
 };
-
 #define alc882_mux_enum_info alc_mux_enum_info
 #define alc882_mux_enum_get alc_mux_enum_get
 
@@ -4255,6 +4366,7 @@
 		.dig_in_nid = ALC882_DIGIN_NID,
 		.num_channel_mode = ARRAY_SIZE(alc882_ch_modes),
 		.channel_mode = alc882_ch_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc882_capture_source,
 	},
 	[ALC882_6ST_DIG] = {
@@ -4268,6 +4380,7 @@
 		.dig_in_nid = ALC882_DIGIN_NID,
 		.num_channel_mode = ARRAY_SIZE(alc882_sixstack_modes),
 		.channel_mode = alc882_sixstack_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc882_capture_source,
 	},
 };
@@ -4823,6 +4936,7 @@
 		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
 
 	spec->init_verbs[spec->num_init_verbs++] = alc262_volume_init_verbs;
+	spec->num_mux_defs = 1;
 	spec->input_mux = &spec->private_imux;
 
 	return 1;
@@ -4861,6 +4975,7 @@
 		.hp_nid = 0x03,
 		.num_channel_mode = ARRAY_SIZE(alc262_modes),
 		.channel_mode = alc262_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc262_capture_source,
 	},
 	[ALC262_FUJITSU] = {
@@ -4872,6 +4987,7 @@
 		.dig_out_nid = ALC262_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc262_modes),
 		.channel_mode = alc262_modes,
+		.num_mux_defs = 1,
 		.input_mux = &alc262_fujitsu_capture_source,
 		.unsol_event = alc262_fujitsu_unsol_event,
 	},
@@ -5499,6 +5615,7 @@
 
 	spec->init_verbs[spec->num_init_verbs++] = alc861_auto_init_verbs;
 
+	spec->num_mux_defs = 1;
 	spec->input_mux = &spec->private_imux;
 
 	spec->adc_nids = alc861_adc_nids;
@@ -5540,6 +5657,7 @@
 		.channel_mode = alc861_threestack_modes,
 		.num_adc_nids = ARRAY_SIZE(alc861_adc_nids),
 		.adc_nids = alc861_adc_nids,
+		.num_mux_defs = 1,
 		.input_mux = &alc861_capture_source,
 	},
 	[ALC861_3ST_DIG] = {
@@ -5552,6 +5670,7 @@
 		.channel_mode = alc861_threestack_modes,
 		.num_adc_nids = ARRAY_SIZE(alc861_adc_nids),
 		.adc_nids = alc861_adc_nids,
+		.num_mux_defs = 1,
 		.input_mux = &alc861_capture_source,
 	},
 	[ALC861_6ST_DIG] = {
@@ -5564,6 +5683,7 @@
 		.channel_mode = alc861_8ch_modes,
 		.num_adc_nids = ARRAY_SIZE(alc861_adc_nids),
 		.adc_nids = alc861_adc_nids,
+		.num_mux_defs = 1,
 		.input_mux = &alc861_capture_source,
 	},
 };	


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
