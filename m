From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALC268 "test" model
Date: Tue, 8 Jan 2008 10:23:35 +1030 (CST)
Message-ID: <200801072353.m07NrZ2q024795@turbo.physics.adelaide.edu.au>
References: <s5h7iilan34.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 278122438C
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 00:53:38 +0100 (CET)
In-Reply-To: <s5h7iilan34.wl%tiwai@suse.de> from "Takashi Iwai" at Jan 07,
	2008 12:31:43 PM
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
Cc: marco@harddisk.is-a-geek.org, alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi

> > +	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
> > +	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
> > +	HDA_CODEC_VOLUME("Line In Boost", 0x1a, 0, HDA_INPUT),
> > +	{ }
> > +};
> > +#endif
> 
> What's this chunk? ;)

Another brain fade.  I really must get out of holiday mode.

Find attached two revised patches against alsa-driver hg snapshot from
20080107:

 * alc260-test-eapd-0.2.diff

   This implements a switch control for the EAPD signal output by the ALC26x
   chips.  Since some laptops may utilise this to activate useful things it
   is handy to have a control for this in the ALC26x test models.  The patch
   includes the control in the ALC260 test model.

   Signed-off-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>


 * alc268-test-0.4.diff

   This implements a test model for the ALC268.  It depends on the feature
   added by alc260-test-eapd-0.2.diff.  This patch also adds a mention of
   the ALC260 test model to ALSA-Configuration.txt since this seems to have
   been missed.

   Signed-off-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>


Regards
  jonathan

=== alc260-test-eapd-0.2.diff ===

diff -ru alsa-driver-hg20080107/alsa-kernel/pci/hda/patch_realtek.c alsa-driver-hg20080107+alc_eapd/alsa-kernel/pci/hda/patch_realtek.c
--- alsa-driver-hg20080107/alsa-kernel/pci/hda/patch_realtek.c	2007-12-21 11:30:06.000000000 +1030
+++ alsa-driver-hg20080107+alc_eapd/alsa-kernel/pci/hda/patch_realtek.c	2008-01-08 10:05:10.000000000 +1030
@@ -608,6 +608,57 @@
 	  .private_value = nid | (mask<<16) }
 #endif   /* CONFIG_SND_DEBUG */
 
+/* A switch control to allow the enabling EAPD digital outputs on the ALC26x.
+ * Again, this is only used in the ALC26x test models to help identify when
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
@@ -4332,6 +4383,12 @@
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
diff -ru alsa-driver-hg20080107/sound/pci/hda/patch_realtek.c alsa-driver-hg20080107+alc_eapd/sound/pci/hda/patch_realtek.c
--- alsa-driver-hg20080107/sound/pci/hda/patch_realtek.c	2007-12-21 11:30:06.000000000 +1030
+++ alsa-driver-hg20080107+alc_eapd/sound/pci/hda/patch_realtek.c	2008-01-08 10:05:10.000000000 +1030
@@ -608,6 +608,57 @@
 	  .private_value = nid | (mask<<16) }
 #endif   /* CONFIG_SND_DEBUG */
 
+/* A switch control to allow the enabling EAPD digital outputs on the ALC26x.
+ * Again, this is only used in the ALC26x test models to help identify when
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
@@ -4332,6 +4383,12 @@
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


=== alc268-test-0.4.diff ===

diff -ru alsa-driver-hg20080107+alc_eapd/alsa-kernel/Documentation/ALSA-Configuration.txt alsa-driver-hg20080107+alc268test/alsa-kernel/Documentation/ALSA-Configuration.txt
--- alsa-driver-hg20080107+alc_eapd/alsa-kernel/Documentation/ALSA-Configuration.txt	2007-12-14 11:30:08.000000000 +1030
+++ alsa-driver-hg20080107+alc268test/alsa-kernel/Documentation/ALSA-Configuration.txt	2008-01-08 10:14:14.000000000 +1030
@@ -798,6 +798,9 @@
 	  will		Will laptops (PB V7900)
 	  replacer	Replacer 672V
 	  basic		fixed pin assignment (old default model)
+	  test		for testing/debugging purpose, almost all controls can
+			adjusted.  Appearing only when compiled with
+			$CONFIG_SND_DEBUG=y
 	  auto		auto-config reading BIOS (default)
 
 	ALC262
@@ -818,6 +821,9 @@
 	  3stack	3-stack model
 	  toshiba	Toshiba A205
 	  acer		Acer laptops
+	  test		for testing/debugging purpose, almost all controls can
+			adjusted.  Appearing only when compiled with
+			$CONFIG_SND_DEBUG=y
 	  auto		auto-config reading BIOS (default)
 
 	ALC662
diff -ru alsa-driver-hg20080107+alc_eapd/alsa-kernel/pci/hda/patch_realtek.c alsa-driver-hg20080107+alc268test/alsa-kernel/pci/hda/patch_realtek.c
--- alsa-driver-hg20080107+alc_eapd/alsa-kernel/pci/hda/patch_realtek.c	2008-01-08 10:05:10.000000000 +1030
+++ alsa-driver-hg20080107+alc268test/alsa-kernel/pci/hda/patch_realtek.c	2008-01-08 10:06:36.000000000 +1030
@@ -106,6 +106,9 @@
 	ALC268_3ST,
 	ALC268_TOSHIBA,
 	ALC268_ACER,
+#ifdef CONFIG_SND_DEBUG
+	ALC268_TEST,
+#endif
 	ALC268_AUTO,
 	ALC268_MODEL_LAST /* last tag */
 };
@@ -9364,6 +9367,60 @@
 	},
 };
 
+#ifdef CONFIG_SND_DEBUG
+static struct snd_kcontrol_new alc268_test_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x2, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Front Playback Switch", 0x14, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x3, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
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
+	/* Switches to allow the digital SPDIF output pin to be enabled.
+	 * The ALC268 does not have an SPDIF input.
+	 */
+	ALC_SPDIF_CTRL_SWITCH("SPDIF Playback Switch", 0x06, 0x01),
+
+	/* A switch allowing EAPD to be enabled.  Some laptops seem to use
+	 * this output to turn on an external amplifier.
+	 */
+	ALC_EAPD_CTRL_SWITCH("LINE-OUT EAPD Enable Switch", 0x0f, 0x02),
+	ALC_EAPD_CTRL_SWITCH("HP-OUT EAPD Enable Switch", 0x10, 0x02),
+
+	{ } /* end */
+};
+#endif
+
 /* create input playback/capture controls for the given pin */
 static int alc268_new_analog_output(struct alc_spec *spec, hda_nid_t nid,
 				    const char *ctlname, int idx)
@@ -9576,6 +9633,9 @@
 	[ALC268_3ST]		= "3stack",
 	[ALC268_TOSHIBA]	= "toshiba",
 	[ALC268_ACER]		= "acer",
+#ifdef CONFIG_SND_DEBUG
+	[ALC268_TEST]		= "test",
+#endif
 	[ALC268_AUTO]		= "auto",
 };
 
@@ -9634,6 +9694,21 @@
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
diff -ru alsa-driver-hg20080107+alc_eapd/sound/Documentation/ALSA-Configuration.txt alsa-driver-hg20080107+alc268test/sound/Documentation/ALSA-Configuration.txt
--- alsa-driver-hg20080107+alc_eapd/sound/Documentation/ALSA-Configuration.txt	2007-12-14 11:30:08.000000000 +1030
+++ alsa-driver-hg20080107+alc268test/sound/Documentation/ALSA-Configuration.txt	2008-01-08 10:14:14.000000000 +1030
@@ -798,6 +798,9 @@
 	  will		Will laptops (PB V7900)
 	  replacer	Replacer 672V
 	  basic		fixed pin assignment (old default model)
+	  test		for testing/debugging purpose, almost all controls can
+			adjusted.  Appearing only when compiled with
+			$CONFIG_SND_DEBUG=y
 	  auto		auto-config reading BIOS (default)
 
 	ALC262
@@ -818,6 +821,9 @@
 	  3stack	3-stack model
 	  toshiba	Toshiba A205
 	  acer		Acer laptops
+	  test		for testing/debugging purpose, almost all controls can
+			adjusted.  Appearing only when compiled with
+			$CONFIG_SND_DEBUG=y
 	  auto		auto-config reading BIOS (default)
 
 	ALC662
diff -ru alsa-driver-hg20080107+alc_eapd/sound/pci/hda/patch_realtek.c alsa-driver-hg20080107+alc268test/sound/pci/hda/patch_realtek.c
--- alsa-driver-hg20080107+alc_eapd/sound/pci/hda/patch_realtek.c	2008-01-08 10:05:10.000000000 +1030
+++ alsa-driver-hg20080107+alc268test/sound/pci/hda/patch_realtek.c	2008-01-08 10:06:36.000000000 +1030
@@ -106,6 +106,9 @@
 	ALC268_3ST,
 	ALC268_TOSHIBA,
 	ALC268_ACER,
+#ifdef CONFIG_SND_DEBUG
+	ALC268_TEST,
+#endif
 	ALC268_AUTO,
 	ALC268_MODEL_LAST /* last tag */
 };
@@ -9364,6 +9367,60 @@
 	},
 };
 
+#ifdef CONFIG_SND_DEBUG
+static struct snd_kcontrol_new alc268_test_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x2, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Front Playback Switch", 0x14, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x3, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
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
+	/* Switches to allow the digital SPDIF output pin to be enabled.
+	 * The ALC268 does not have an SPDIF input.
+	 */
+	ALC_SPDIF_CTRL_SWITCH("SPDIF Playback Switch", 0x06, 0x01),
+
+	/* A switch allowing EAPD to be enabled.  Some laptops seem to use
+	 * this output to turn on an external amplifier.
+	 */
+	ALC_EAPD_CTRL_SWITCH("LINE-OUT EAPD Enable Switch", 0x0f, 0x02),
+	ALC_EAPD_CTRL_SWITCH("HP-OUT EAPD Enable Switch", 0x10, 0x02),
+
+	{ } /* end */
+};
+#endif
+
 /* create input playback/capture controls for the given pin */
 static int alc268_new_analog_output(struct alc_spec *spec, hda_nid_t nid,
 				    const char *ctlname, int idx)
@@ -9576,6 +9633,9 @@
 	[ALC268_3ST]		= "3stack",
 	[ALC268_TOSHIBA]	= "toshiba",
 	[ALC268_ACER]		= "acer",
+#ifdef CONFIG_SND_DEBUG
+	[ALC268_TEST]		= "test",
+#endif
 	[ALC268_AUTO]		= "auto",
 };
 
@@ -9634,6 +9694,21 @@
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
