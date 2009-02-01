From: Michael Schwingen <michael@schwingen.org>
Subject: PATCH: Maxdata Favorit 100XS support
Date: Sun, 1 Feb 2009 20:30:39 +0100
Message-ID: <20090201193039.GA24196@discworld.dascon.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dascon.de (polyphem.dascon.de [212.117.81.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 46F7E243CB
	for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2009 20:31:27 +0100 (CET)
Received: from discworld.dascon.de (discworld.dascon.de [192.168.11.1])
	by a-tuin.dascon.de (Postfix) with SMTP id C8F1F807DA
	for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2009 20:29:20 +0100 (CET)
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


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this is my first ALSA patch, so I am not sure if this is the right place &
form to post patches?

Anyway, here is a patch to enable audio on the Maxdata Favorit 100XS - a
compact PC sold by German company Maxdata (probably manufactured by FIC,
Transtec Senyo 600/Belinea o.max XS/Lynx Silent PC MP-I *might* be
identical, but I have none of those).

The Favorit 100XS uses an Intel 945 chipset with a Realtek HD audio codec
connected to exactly 2 jacks: one input, and one output jack. Using the
standard ALSA driver, output is silent.

This patch enables audio input/output on these machines - it is based in
part on the acer code in the same file.

Signed-off-by: Michael Schwingen <michael@schwingen.org>

cu
Michael

--+QahgC5+KEYLbs62
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="favorit100.diff"

diff -cr linux-2.6.28.2/sound/pci/hda/patch_realtek.c linux-2.6.28.2-atuin/sound/pci/hda/patch_realtek.c
*** linux-2.6.28.2/sound/pci/hda/patch_realtek.c	Sun Jan 25 01:42:07 2009
--- linux-2.6.28.2-atuin/sound/pci/hda/patch_realtek.c	Sun Jan 25 19:28:11 2009
***************
*** 78,83 ****
--- 78,84 ----
  	ALC260_ACER,
  	ALC260_WILL,
  	ALC260_REPLACER_672V,
+ 	ALC260_FAVORIT100,
  #ifdef CONFIG_SND_DEBUG
  	ALC260_TEST,
  #endif
***************
*** 4101,4106 ****
--- 4102,4126 ----
  		},
  	},
  };
+ 
+ /* Maxdata Favorit 100XS */
+ static struct hda_input_mux alc260_favorit100_capture_sources[2] = {
+ 	{
+ 		.num_items = 2,
+ 		.items = {
+ 			{ "Line/Mic", 0x0 },
+ 			{ "CD", 0x4 },
+ 		},
+ 	},
+ 	{
+ 		.num_items = 3,
+ 		.items = {
+ 			{ "Line/Mic", 0x0 },
+ 			{ "CD", 0x4 },
+ 			{ "Mixer", 0x5 },
+ 		},
+ 	},
+ };
  /*
   * This is just place-holder, so there's something for alc_build_pcms to look
   * at when it calculates the maximum number of channels. ALC260 has no mixer
***************
*** 4391,4396 ****
--- 4411,4430 ----
  	{ } /* end */
  };
  
+ /* Maxdata Favorit 100XS: one output and one input (0x12) jack
+  */
+ static struct snd_kcontrol_new alc260_favorit100_mixer[] = {
+ 	HDA_CODEC_VOLUME("Master Playback Volume", 0x08, 0x0, HDA_OUTPUT),
+ 	HDA_BIND_MUTE("Master Playback Switch", 0x08, 2, HDA_INPUT),
+ 	ALC_PIN_MODE("Output Jack Mode", 0x0f, ALC_PIN_DIR_INOUT),
+ 	HDA_CODEC_VOLUME("Line/Mic Playback Volume", 0x07, 0x0, HDA_INPUT),
+ 	HDA_CODEC_MUTE("Line/Mic Playback Switch", 0x07, 0x0, HDA_INPUT),
+ 	ALC_PIN_MODE("Line/Mic Jack Mode", 0x12, ALC_PIN_DIR_IN),
+ 	HDA_CODEC_VOLUME("Beep Playback Volume", 0x07, 0x05, HDA_INPUT),
+ 	HDA_CODEC_MUTE("Beep Playback Switch", 0x07, 0x05, HDA_INPUT),
+ 	{ } /* end */
+ };
+ 
  /* Packard bell V7900  ALC260 pin usage: HP = 0x0f, Mic jack = 0x12,
   * Line In jack = 0x14, CD audio =  0x16, pc beep = 0x17.
   */
***************
*** 4803,4808 ****
--- 4837,4925 ----
  	{ }
  };
  
+ /* Initialisation sequence for Maxdata Favorit 100XS
+  * (adapted from Acer init verbs).
+  */
+ static struct hda_verb alc260_favorit100_init_verbs[] = {
+ 	/* GPIO 0 enables the output jack.
+ 	 * Turn this on and rely on the standard mute
+ 	 * methods whenever the user wants to turn these outputs off.
+ 	 */
+ 	{0x01, AC_VERB_SET_GPIO_MASK, 0x01},
+ 	{0x01, AC_VERB_SET_GPIO_DIRECTION, 0x01},
+ 	{0x01, AC_VERB_SET_GPIO_DATA, 0x01},
+ 	/* Line/Mic input jack is connected to Mic1 pin */
+ 	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF50},
+ 	/* Ensure all other unused pins are disabled and muted. */
+ 	{0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+ 	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+ 	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+ 	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+ 	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+ 	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+ 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+ 	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+ 	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+ 	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+ 	/* Disable digital (SPDIF) pins */
+ 	{0x03, AC_VERB_SET_DIGI_CONVERT_1, 0},
+ 	{0x06, AC_VERB_SET_DIGI_CONVERT_1, 0},
+ 
+ 	/* Ensure Mic1 and Line1 pin widgets take input from the OUT1 sum
+ 	 * bus when acting as outputs.
+ 	 */
+ 	{0x0b, AC_VERB_SET_CONNECT_SEL, 0},
+ 	{0x0d, AC_VERB_SET_CONNECT_SEL, 0},
+ 
+ 	/* Start with output sum widgets muted and their output gains at min */
+ 	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+ 	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+ 	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+ 	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+ 	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+ 	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+ 	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+ 	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+ 	{0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+ 
+ 	/* Unmute Line-out pin widget amp left and right
+ 	 * (no equiv mixer ctrl)
+ 	 */
+ 	{0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+ 	/* Unmute Mic1 and Line1 pin widget input buffers since they start as
+ 	 * inputs. If the pin mode is changed by the user the pin mode control
+ 	 * will take care of enabling the pin's input/output buffers as needed.
+ 	 * Therefore there's no need to enable the input buffer at this
+ 	 * stage.
+ 	 */
+ 	{0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+ 
+ 	/* Mute capture amp left and right */
+ 	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+ 	/* Set ADC connection select to match default mixer setting - mic
+ 	 * (on mic1 pin)
+ 	 */
+ 	{0x04, AC_VERB_SET_CONNECT_SEL, 0x00},
+ 
+ 	/* Do similar with the second ADC: mute capture input amp and
+ 	 * set ADC connection to mic to match ALSA's default state.
+ 	 */
+ 	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+ 	{0x05, AC_VERB_SET_CONNECT_SEL, 0x00},
+ 
+ 	/* Mute all inputs to mixer widget (even unconnected ones) */
+ 	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)}, /* mic1 pin */
+ 	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)}, /* mic2 pin */
+ 	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)}, /* line1 pin */
+ 	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)}, /* line2 pin */
+ 	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)}, /* CD pin */
+ 	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(5)}, /* Beep-gen pin */
+ 	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(6)}, /* Line-out pin */
+ 	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(7)}, /* HP-pin pin */
+ 
+ 	{ }
+ };
+ 
  static struct hda_verb alc260_will_verbs[] = {
  	{0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
  	{0x0b, AC_VERB_SET_CONNECT_SEL, 0x00},
***************
*** 5362,5367 ****
--- 5479,5485 ----
  	[ALC260_ACER]		= "acer",
  	[ALC260_WILL]		= "will",
  	[ALC260_REPLACER_672V]	= "replacer",
+ 	[ALC260_FAVORIT100]	= "favorit100",
  #ifdef CONFIG_SND_DEBUG
  	[ALC260_TEST]		= "test",
  #endif
***************
*** 5371,5376 ****
--- 5489,5495 ----
  static struct snd_pci_quirk alc260_cfg_tbl[] = {
  	SND_PCI_QUIRK(0x1025, 0x007b, "Acer C20x", ALC260_ACER),
  	SND_PCI_QUIRK(0x1025, 0x008f, "Acer", ALC260_ACER),
+ 	SND_PCI_QUIRK(0x1509, 0x4540, "Favorit 100XS", ALC260_FAVORIT100),
  	SND_PCI_QUIRK(0x103c, 0x2808, "HP d5700", ALC260_HP_3013),
  	SND_PCI_QUIRK(0x103c, 0x280a, "HP d5750", ALC260_HP_3013),
  	SND_PCI_QUIRK(0x103c, 0x3010, "HP", ALC260_HP_3013),
***************
*** 5479,5484 ****
--- 5598,5616 ----
  		.num_mux_defs = ARRAY_SIZE(alc260_acer_capture_sources),
  		.input_mux = alc260_acer_capture_sources,
  	},
+ 	[ALC260_FAVORIT100] = {
+ 		.mixers = { alc260_favorit100_mixer,
+ 			    alc260_capture_mixer },
+ 		.init_verbs = { alc260_acer_init_verbs },
+ 		.num_dacs = ARRAY_SIZE(alc260_dac_nids),
+ 		.dac_nids = alc260_dac_nids,
+ 		.num_adc_nids = ARRAY_SIZE(alc260_dual_adc_nids),
+ 		.adc_nids = alc260_dual_adc_nids,
+ 		.num_channel_mode = ARRAY_SIZE(alc260_modes),
+ 		.channel_mode = alc260_modes,
+ 		.num_mux_defs = ARRAY_SIZE(alc260_favorit100_capture_sources),
+ 		.input_mux = alc260_favorit100_capture_sources,
+ 	},
  	[ALC260_WILL] = {
  		.mixers = { alc260_will_mixer,
  			    alc260_capture_mixer },

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--+QahgC5+KEYLbs62--
