From: Rimas Kudelis <rq@akl.lt>
Subject: [PATCH] Add support for Acer TravelMate and similar laptops
Date: Mon, 27 Feb 2006 00:35:33 +0200
Message-ID: <44022D35.7050909@akl.lt>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020704040309050904080905"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Paulo Matias <syscoder@gmail.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020704040309050904080905
Content-Type: text/plain; charset=windows-1257; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Attached here is a patch that adds an Acer model to the HDA codec 
driver. It assumes that Jonathan's patch (posted here on 23 Feb 2006 
11:18:26 +1030 (CST)) has already been applied, so it applies on top 
of it.

I have tested the patch with my mom's Acer (erased 
/var/lib/alsa/asound.state, then cold-rebooted the computer), 
everything seems to be working fine.

The patch itself is much cleaner than the one attached to bug 1618. It 
doesn't clutter the mixer with useless controls, and starts up with 
settings more appropriate for an Acer.

Also, please note the "(?)"'s next to CD and Beep controls. These 
controls don't actually influence anything now, but I suspect they 
would work after a few more GPIO commands are issued, so I've left 
them there for now (read below).

Btw, this patch also fixes a few comment typos in patch_realtek.c and 
changes one setting in test model (it seems like inicially copy-pasted 
from Fujitsu model). Also, it adds lines muting NID 0x15 for Fujitsu 
model on startup (Jonathan, you said it turned out not to be 
problematic at all).

Takashi, would you please commit this to upstream (along with 
Jonathan's patch)?

Jonathan, how about your idea to add GPIO controls to the test model? 
I think it would help testing. Hopefully, after these are added, I 
could modify the Acer model in a way that CD and Beep controls would 
become useful. Or, if playing with GPIO would seem useless, I could 
simply remove those controls out of the mixer at all.

Now a few notes/questions:
* is there any reason in defining ADC NIDs for every model separately? 
They seem to be the same anyways, and not to get in anyones way. Or do 
they?
* There seems to be a mixup between tab-indented and space-indented 
lines. It was like that at least in Fujitsu init verbs definition, and 
now i've partially copied it to Acer...
* If the jack is called "Line In", should I leave it as "Line" in 
mixer, or should I name it "Line In"?
* What's your opinion about adding a model configuration line that 
would only check the subvendor (and ignore the subdevice setting)? 
There would be more chances to autodetect an Acer laptop then, but 
OTOH, if one day there'll be an ALC-260 based Acer with a different 
config, you'd risk to misdetect, or to regress in automatic Acer 
detectlion by removing that line...

bye,

Rimas

--------------020704040309050904080905
Content-Type: text/plain;
 name="patch_realtek.after-jwoithe.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_realtek.after-jwoithe.diff"

--- alsa-kernel/pci/hda/patch_realtek.c.orig	2006-02-26 23:50:48.000000000 +0200
+++ alsa-kernel/pci/hda/patch_realtek.c	2006-02-26 23:27:13.000000000 +0200
@@ -64,6 +64,7 @@
 	ALC260_HP,
 	ALC260_HP_3013,
 	ALC260_FUJITSU_S702X,
+	ALC260_ACER,
 #ifdef CONFIG_SND_DEBUG
 	ALC260_TEST,
 #endif
@@ -2424,6 +2425,11 @@
 	0x04, 0x05
 };
 
+static hda_nid_t alc260_acer_adc_nids[2] = {
+	/* ADC0, ADC1 */
+	0x04, 0x05
+};
+
 #define ALC260_DIGOUT_NID	0x03
 #define ALC260_DIGIN_NID	0x06
 
@@ -2449,6 +2455,19 @@
 	},
 };
 
+/* Acer TravelMate(/Extensa/Aspire) notebooks have similar configutation to
+ * the Fujitsu S702x, but jacks are marked differently. We won't allow
+ * retasking the Headphone jack, so it won't be available here.
+ */
+static struct hda_input_mux alc260_acer_capture_source = {
+	.num_items = 3,
+	.items = {
+		{ "Mic", 0x0 },
+		{ "Line", 0x2 },
+		{ "CD", 0x4 },
+        },
+};
+
 /*
  * This is just place-holder, so there's something for alc_build_pcms to look
  * at when it calculates the maximum number of channels. ALC260 has no mixer
@@ -2466,6 +2485,7 @@
  * HP: base_output + input + capture_alt
  * HP_3013: hp_3013 + input + capture
  * fujitsu: fujitsu + capture
+ * acer: acer + capture
  */
 
 static struct snd_kcontrol_new alc260_base_output_mixer[] = {
@@ -2524,6 +2544,22 @@
 	{ } /* end */
 };
 
+static struct snd_kcontrol_new alc260_acer_mixer[] = {
+	HDA_CODEC_VOLUME("Master Playback Volume", 0x08, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Master Playback Switch", 0x08, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("CD (?) Playback Volume", 0x07, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD (?) Playback Switch", 0x07, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x07, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x07, 0x0, HDA_INPUT),
+	ALC_PIN_MODE("Mic Jack Mode", 0x12, ALC_PIN_DIR_IN),
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x07, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 0x07, 0x02, HDA_INPUT),
+	ALC_PIN_MODE("Line Jack Mode", 0x14, ALC_PIN_DIR_INOUT),
+	HDA_CODEC_VOLUME("Beep (?) Playback Volume", 0x07, 0x05, HDA_INPUT),
+	HDA_CODEC_MUTE("Beep (?) Playback Switch", 0x07, 0x05, HDA_INPUT),
+	{ } /* end */
+};
+
 /* capture mixer elements */
 static struct snd_kcontrol_new alc260_capture_mixer[] = {
 	HDA_CODEC_VOLUME("Capture Volume", 0x04, 0x0, HDA_INPUT),
@@ -2735,16 +2771,15 @@
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
         /* Mic/Line-in jack is connected to mic1 pin, so make it an input */
         {0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
-        /* Ensure all other unused pins are disabled and muted.
-	 * Note: trying to set widget 0x15 to anything blocks all audio
-	 * output for some reason, so just leave that at the default.
-	 */
+        /* Ensure all other unused pins are disabled and muted. */
         {0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
         {0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
 	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
         {0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
 	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
         {0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+        {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
         /* Disable digital (SPDIF) pins */
         {0x03, AC_VERB_SET_DIGI_CONVERT_1, 0},
         {0x06, AC_VERB_SET_DIGI_CONVERT_1, 0},
@@ -2805,6 +2840,88 @@
 	{ }
 };
 
+/* Initialisation sequence for ALC260 as configured in Acer TravelMate and
+ * similar laptops (adapted from Fujitsu init verbs).
+ */
+static struct hda_verb alc260_acer_init_verbs[] = {
+	/* Without this, the internal speaker and HP jacks are silent */
+	{0x01, AC_VERB_SET_GPIO_MASK, 0x01},
+	{0x01, AC_VERB_SET_GPIO_DIRECTION, 0x01},
+	{0x01, AC_VERB_SET_GPIO_DATA, 0x01},
+	/* Internal speaker/Headphone jack is connected to Line-out pin */
+	{0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	/* Internal microphone/Mic jack is connected to Mic1 pin */
+	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF50},
+	/* Line In jack is connected to Line1 pin */
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	/* Ensure all other unused pins are disabled and muted. */
+	{0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	/* Disable digital (SPDIF) pins */
+	{0x03, AC_VERB_SET_DIGI_CONVERT_1, 0},
+	{0x06, AC_VERB_SET_DIGI_CONVERT_1, 0},
+
+	/* Ensure Mic1 and Line1 pin widgets take input from the OUT1 sum 
+	 * bus when acting as outputs.
+	 */
+	{0x0b, AC_VERB_SET_CONNECT_SEL, 0},
+	{0x0d, AC_VERB_SET_CONNECT_SEL, 0},
+
+	/* Start with output sum widgets muted and their output gains at min */
+	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+
+        /* Unmute Line-out pin widget amp left and right (no equiv mixer ctrl) */
+        {0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+        /* Unmute Mic1 and Line1 pin widget input buffers since they start as
+         * inputs. If the pin mode is changed by the user the pin mode control
+         * will take care of enabling the pin's input/output buffers as needed.
+         * Therefore there's no need to enable the input buffer at this
+         * stage.
+	 */
+        {0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+        {0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+
+
+        /* Mute capture amp left and right */
+        {0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+        /* Set ADC connection select to match default mixer setting - mic
+         * (on mic1 pin)
+         */
+        {0x04, AC_VERB_SET_CONNECT_SEL, 0x00},
+
+        /* Do similar with the second ADC: mute capture input amp and
+         * set ADC connection to line (on line1 pin)
+         */
+        {0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+        {0x05, AC_VERB_SET_CONNECT_SEL, 0x02},
+
+        /* Mute all inputs to mixer widget (even unconnected ones) */
+        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)}, /* mic1 pin */
+        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)}, /* mic2 pin */
+        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)}, /* line1 pin */
+        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)}, /* line2 pin */
+        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)}, /* CD pin */
+        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(5)}, /* Beep-gen pin */
+        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(6)}, /* Line-out pin */
+        {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(7)}, /* HP-pin pin */
+
+	{ }
+};
+
 /* Test configuration for debugging, modelled after the ALC880 test
  * configuration.
  */
@@ -2878,7 +2995,7 @@
 	{0x03, AC_VERB_SET_DIGI_CONVERT_1, 0},
 	{0x06, AC_VERB_SET_DIGI_CONVERT_1, 0},
 
-	/* Ensure mic1, mic2, line1 and line2 pin widget take input from the 
+	/* Ensure mic1, mic2, line1 and line2 pin widgets take input from the 
 	 * OUT1 sum bus when acting as an output.
 	 */
 	{0x0b, AC_VERB_SET_CONNECT_SEL, 0},
@@ -2913,16 +3030,16 @@
 
 	/* Mute capture amp left and right */
 	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	/* Set ADC connection select to match default mixer setting - line 
-	 * in (on mic1 pin)
+	/* Set ADC connection select to match default mixer setting -
+	 * mic1 pin
 	 */
 	{0x04, AC_VERB_SET_CONNECT_SEL, 0x00},
 
-	/* Do the same for the second ADC: mute capture input amp and
-	 * set ADC connection to line in
+	/* Do similar with the second ADC: mute capture input amp and
+	 * set ADC connection to line1 pin
 	 */
 	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
-	{0x05, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{0x05, AC_VERB_SET_CONNECT_SEL, 0x02},
 
 	/* Mute all inputs to mixer widget (even unconnected ones) */
 	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)}, /* mic1 pin */
@@ -3221,6 +3338,8 @@
 	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3016, .config = ALC260_HP },
 	{ .modelname = "fujitsu", .config = ALC260_FUJITSU_S702X },
 	{ .pci_subvendor = 0x10cf, .pci_subdevice = 0x1326, .config = ALC260_FUJITSU_S702X },
+	{ .modelname = "acer", .config = ALC260_ACER },
+	{ .pci_subvendor = 0x1025, .pci_subdevice = 0x008f, .config = ALC260_ACER },
 #ifdef CONFIG_SND_DEBUG
 	{ .modelname = "test", .config = ALC260_TEST },
 #endif
@@ -3281,6 +3400,18 @@
 		.channel_mode = alc260_modes,
 		.input_mux = &alc260_fujitsu_capture_source,
 	},
+	[ALC260_ACER] = {
+		.mixers = { alc260_acer_mixer,
+			    alc260_capture_mixer },
+		.init_verbs = { alc260_acer_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc260_dac_nids),
+		.dac_nids = alc260_dac_nids,
+		.num_adc_nids = ARRAY_SIZE(alc260_acer_adc_nids),
+		.adc_nids = alc260_acer_adc_nids,
+		.num_channel_mode = ARRAY_SIZE(alc260_modes),
+		.channel_mode = alc260_modes,
+		.input_mux = &alc260_acer_capture_source,
+	},
 #ifdef CONFIG_SND_DEBUG
 	[ALC260_TEST] = {
 		.mixers = { alc260_test_mixer,

--------------020704040309050904080905--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
