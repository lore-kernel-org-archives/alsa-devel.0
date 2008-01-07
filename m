From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALC268 "test" model
Date: Mon, 7 Jan 2008 10:50:14 +1030 (CST)
Message-ID: <200801070020.m070KEcI006140@turbo.physics.adelaide.edu.au>
References: <1199664375.4061.94.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id D48EA103879
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 01:20:16 +0100 (CET)
In-Reply-To: <1199664375.4061.94.camel@razman.gruemaster.com> from "Tobin
	Davis" at Jan 06, 2008 04:06:15 PM
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@alsa-project.org, marco@harddisk.is-a-geek.org, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi Tobin

> The compiling errors will only be visible if the drivers are compiled
> with "--with-debug=detect", as the preparser will ignore this section of
> code otherwise.  That's probably why you aren't seeing any compiler
> issues.

No, it was due to a stupid typo on my part.  That's what happens when you
try to do things in a hurry.

> The error is the HDA_BIND_MUTE controls; there are too many
> fields for that data type.

Indeed.  There were also other problems with some of the HDA_CODEC_VOLUME()
calls, and I included two instances of a control which are only in my
working copy at present (ALC_EAPD_CTRL_SWITCH).

> I don't have a problem with taking over the patch, but I just got
> inundated with the holidays, hardware issues on my home development
> system, and CES preparation at work.  I'll try to get a completely
> working version of the patch into the alsa tree this next week.

No problem - since you actually have an ALC268 it'll make verification
somewhat easier.  If it helps I've attached a later version of the patch
which corrects the more glaring errors.  I can't compile-test this right now
though so there still are probably some further issues.

This patch depends on a new control I've added to my development code which
may or may not be useful for others (ALC_EAPD_CTRL_SWITCH).  I'll include
the patch for this (which is compile-tested) at the end of this email as
well - see what you think.  If you don't want to use it in ALSA just omit
the calls to ALC_EAPD_CTRL_SWITCH() in the ALC268 test mixer block.

Regards
  jonathan

--- patch_realtek.c-orig	2007-10-15 18:15:06.000000000 +0930
+++ patch_realtek.c	2008-01-12 10:43:23.000000000 +1030
@@ -104,6 +104,9 @@
 	ALC268_3ST,
 	ALC268_TOSHIBA,
 	ALC268_ACER,
+#ifdef CONFIG_SND_DEBUG
+	ALC268_TEST,
+#endif
 	ALC268_AUTO,
 	ALC268_MODEL_LAST /* last tag */
 };
@@ -8903,6 +8906,74 @@
 	},
 };
 
+#ifdef CONFIG_SND_DEBUG
+static struct snd_kcontrol_new alc268_test_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x2, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Front Playback Switch", 0x14, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x3, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line In Boost", 0x1a, 0, HDA_INPUT),
+
+	/* Volume widgets */
+	HDA_CODEC_VOLUME("LOUT1 Playback Volume", 0x02, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("LOUT2 Playback Volume", 0x03, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("Mono sum Playback Switch", 0x0e, 1, 2, HDA_INPUT),
+	HDA_BIND_MUTE("LINE-OUT sum Playback Switch", 0x0f, 2, HDA_INPUT),
+	HDA_BIND_MUTE("HP-OUT sum Playback Switch", 0x10, 2, HDA_INPUT),
+	HDA_BIND_MUTE("LINE-OUT Playback Switch", 0x14, 2, HDA_OUTPUT),
+	HDA_BIND_MUTE("HP-OUT Playback Switch", 0x15, 2, HDA_OUTPUT),
+	HDA_BIND_MUTE("Mono Playback Switch", 0x16, 2, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("MIC1 Capture Volume", 0x18, 0x0, HDA_INPUT),
+	HDA_BIND_MUTE("MIC1 Capture Switch", 0x18, 2, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("MIC2 Capture Volume", 0x19, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("LINE1 Capture Volume", 0x1a, 0x0, HDA_INPUT),
+	HDA_BIND_MUTE("LINE1 Capture Switch", 0x1a, 2, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("PCBEEP Playback Volume", 0x1d, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("PCM-IN1 Capture Volume", 0x23, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("PCM-IN1 Capture Switch", 0x23, 2, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("PCM-IN2 Capture Volume", 0x24, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("PCM-IN2 Capture Switch", 0x24, 2, HDA_OUTPUT),
+	
+	/* Modes for retasking pin widgets */
+	ALC_PIN_MODE("LINE-OUT pin mode", 0x14, ALC_PIN_DIR_INOUT),
+	ALC_PIN_MODE("HP-OUT pin mode", 0x15, ALC_PIN_DIR_INOUT),
+	ALC_PIN_MODE("MIC1 pin mode", 0x18, ALC_PIN_DIR_INOUT),
+	ALC_PIN_MODE("LINE1 pin mode", 0x1a, ALC_PIN_DIR_INOUT),
+
+	/* Controls for GPIO pins, assuming they are configured as outputs */
+	ALC_GPIO_DATA_SWITCH("GPIO pin 0", 0x01, 0x01),
+	ALC_GPIO_DATA_SWITCH("GPIO pin 1", 0x01, 0x02),
+	ALC_GPIO_DATA_SWITCH("GPIO pin 2", 0x01, 0x04),
+	ALC_GPIO_DATA_SWITCH("GPIO pin 3", 0x01, 0x08),
+
+	/* Switches to allow the digital IO pins to be enabled.  The datasheet
+	 * is ambigious as to which NID is which; testing on laptops which
+	 * make this output available should provide clarification. 
+	 */
+	ALC_SPDIF_CTRL_SWITCH("SPDIF Playback Switch", 0x03, 0x01),
+	ALC_SPDIF_CTRL_SWITCH("SPDIF Capture Switch", 0x06, 0x01),
+
+	/* A switch allowing EAPD to be enabled.  Some laptops seem to use
+	 * this output to turn on an external amplifier.
+	 */
+	ALC_EAPD_CTRL_SWITCH("LINE-OUT EAPD Enable Switch", 0x0f, 0x02),
+	ALC_EAPD_CTRL_SWITCH("HP-OUT EAPD Enable Switch", 0x10, 0x02),
+
+	{ } /* end */
+};
+
+
+
+
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line In Boost", 0x1a, 0, HDA_INPUT),
+	{ }
+};
+#endif
+
 /* create input playback/capture controls for the given pin */
 static int alc268_new_analog_output(struct alc_spec *spec, hda_nid_t nid,
 				    const char *ctlname, int idx)
@@ -9115,6 +9186,9 @@
 	[ALC268_3ST]		= "3stack",
 	[ALC268_TOSHIBA]	= "toshiba",
 	[ALC268_ACER]		= "acer",
+#ifdef CONFIG_SND_DEBUG
+	[ALC268_TEST]		= "test",
+#endif
 	[ALC268_AUTO]		= "auto",
 };
 
@@ -9174,6 +9248,21 @@
 		.unsol_event = alc268_acer_unsol_event,
 		.init_hook = alc268_acer_init_hook,
 	},
+#ifdef CONFIG_SND_DEBUG
+	[ALC268_TEST] = {
+		.mixers = { alc268_test_mixer, alc268_capture_mixer },
+		.init_verbs = { alc268_base_init_verbs, alc268_eapd_verbs, alc268_volume_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc268_dac_nids),
+		.dac_nids = alc268_dac_nids,
+                .num_adc_nids = ARRAY_SIZE(alc268_adc_nids_alt),
+                .adc_nids = alc268_adc_nids_alt,
+		.hp_nid = 0x03,
+		.dig_out_nid = ALC268_DIGOUT_NID,
+		.num_channel_mode = ARRAY_SIZE(alc268_modes),
+		.channel_mode = alc268_modes,
+		.input_mux = &alc268_capture_source,
+	},
+#endif
 };
 
 static int patch_alc268(struct hda_codec *codec)

===== Following is the EAPD switch control implementation I mentioned =====

diff -ru alsa-driver-1.0.15-orig/alsa-kernel/pci/hda/patch_realtek.c alsa-driver-1.0.15/alsa-kernel/pci/hda/patch_realtek.c
--- alsa-driver-1.0.15-orig/alsa-kernel/pci/hda/patch_realtek.c	2007-10-15 18:15:06.000000000 +0930
+++ alsa-driver-1.0.15/alsa-kernel/pci/hda/patch_realtek.c	2007-11-08 19:05:13.000000000 +1030
@@ -597,6 +597,57 @@
 	  .private_value = nid | (mask<<16) }
 #endif   /* CONFIG_SND_DEBUG */
 
+/* A switch control to allow the enabling EAPD digital output on the ALC260.
+ * Again, this is only used in the ALC260 test model to help identify when
+ * the EAPD line must be asserted for features to work.
+ */
+#ifdef CONFIG_SND_DEBUG
+#define alc_eapd_ctrl_info	snd_ctl_boolean_mono_info
+
+static int alc_eapd_ctrl_get(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = kcontrol->private_value & 0xffff;
+	unsigned char mask = (kcontrol->private_value >> 16) & 0xff;
+	long *valp = ucontrol->value.integer.value;
+	unsigned int val = snd_hda_codec_read(codec, nid, 0,
+					      AC_VERB_GET_EAPD_BTLENABLE, 0x00);
+
+	*valp = (val & mask) != 0;
+	return 0;
+}
+static int alc_eapd_ctrl_put(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	signed int change;
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = kcontrol->private_value & 0xffff;
+	unsigned char mask = (kcontrol->private_value >> 16) & 0xff;
+	long val = *ucontrol->value.integer.value;
+	unsigned int ctrl_data = snd_hda_codec_read(codec, nid, 0,
+						    AC_VERB_GET_EAPD_BTLENABLE,
+						    0x00);
+
+	/* Set/unset the masked control bit(s) as needed */
+	change = (val == 0 ? 0 : mask) != (ctrl_data & mask);
+	if (val==0)
+		ctrl_data &= ~mask;
+	else
+		ctrl_data |= mask;
+	snd_hda_codec_write_cache(codec, nid, 0, AC_VERB_SET_EAPD_BTLENABLE,
+				  ctrl_data);
+
+	return change;
+}
+#define ALC_EAPD_CTRL_SWITCH(xname, nid, mask) \
+	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = 0,  \
+	  .info = alc_eapd_ctrl_info, \
+	  .get = alc_eapd_ctrl_get, \
+	  .put = alc_eapd_ctrl_put, \
+	  .private_value = nid | (mask<<16) }
+#endif   /* CONFIG_SND_DEBUG */
+
 /*
  * set up from the preset table
  */
@@ -4188,6 +4239,12 @@
 	ALC_SPDIF_CTRL_SWITCH("SPDIF Playback Switch", 0x03, 0x01),
 	ALC_SPDIF_CTRL_SWITCH("SPDIF Capture Switch", 0x06, 0x01),
 
+	/* A switch allowing EAPD to be enabled.  Some laptops seem to use
+	 * this output to turn on an external amplifier.
+	 */
+	ALC_EAPD_CTRL_SWITCH("LINE-OUT EAPD Enable Switch", 0x0f, 0x02),
+	ALC_EAPD_CTRL_SWITCH("HP-OUT EAPD Enable Switch", 0x10, 0x02),
+
 	{ } /* end */
 };
 static struct hda_verb alc260_test_init_verbs[] = {
