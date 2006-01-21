From: Matt Porter <mporter@embeddedalley.com>
Subject: [PATCH] hda: add sigmatel 927x codec support
Date: Fri, 20 Jan 2006 17:46:35 -0700
Message-ID: <20060120174635.C26939@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 88D2B18F
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2006 01:46:54 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adds support for the SigmaTel STAC927x HDA codec family.

Signed-off-by: Matt Porter <mporter@embeddedalley.com>

--- alsa-driver/alsa-kernel/pci/hda/patch_sigmatel.c.orig	2006-01-20 17:54:29.000000000 -0700
+++ alsa-driver/alsa-kernel/pci/hda/patch_sigmatel.c	2006-01-20 17:56:58.000000000 -0700
@@ -50,10 +50,11 @@
 	unsigned int surr_switch: 1;
 	unsigned int line_switch: 1;
 	unsigned int mic_switch: 1;
+	unsigned int alt_switch: 1;
 
 	/* playback */
 	struct hda_multi_out multiout;
-	hda_nid_t dac_nids[4];
+	hda_nid_t dac_nids[5];
 
 	/* capture */
 	hda_nid_t *adc_nids;
@@ -73,7 +74,7 @@
 
 	/* capture source */
 	struct hda_input_mux *input_mux;
-	unsigned int cur_mux[2];
+	unsigned int cur_mux[3];
 
 	/* i/o switches */
 	unsigned int io_switch[2];
@@ -107,6 +108,14 @@
         0x12, 0x13,
 };
 
+static hda_nid_t stac927x_adc_nids[3] = {
+        0x07, 0x08, 0x09
+};
+
+static hda_nid_t stac927x_mux_nids[3] = {
+        0x15, 0x16, 0x17
+};
+
 static hda_nid_t stac9200_pin_nids[8] = {
 	0x08, 0x09, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12,
 };
@@ -116,6 +125,12 @@
 	0x0f, 0x10, 0x11, 0x15, 0x1b,
 };
 
+static hda_nid_t stac927x_pin_nids[14] = {
+	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
+	0x0f, 0x10, 0x11, 0x12, 0x13,
+	0x14, 0x21, 0x22, 0x23,
+};
+
 static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
@@ -155,6 +170,12 @@
 	{}
 };
 
+static struct hda_verb stac927x_core_init[] = {
+	/* set master volume and direct control */	
+	{ 0x24, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
+	{}
+};
+
 static struct snd_kcontrol_new stac9200_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0xb, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Master Playback Switch", 0xb, 0, HDA_OUTPUT),
@@ -188,6 +209,21 @@
 	{ } /* end */
 };
 
+static snd_kcontrol_new_t stac927x_mixer[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input Source",
+		.count = 1,
+		.info = stac92xx_mux_enum_info,
+		.get = stac92xx_mux_enum_get,
+		.put = stac92xx_mux_enum_put,
+	},
+	HDA_CODEC_VOLUME("InMux Capture Volume", 0x15, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("InVol Capture Volume", 0x18, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("ADCMux Capture Switch", 0x1b, 0x0, HDA_OUTPUT),
+	{ } /* end */
+};
+
 static int stac92xx_build_controls(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
@@ -281,6 +317,25 @@
 	{} /* terminator */
 };
 
+static unsigned int ref927x_pin_configs[14] = {
+	0x01813122, 0x01a19021, 0x01014010, 0x01016011,
+	0x01012012, 0x01011014, 0x40000100, 0x40000100, 
+	0x40000100, 0x40000100, 0x40000100, 0x01441030,
+	0x01c41030, 0x40000100,
+};
+
+static unsigned int *stac927x_brd_tbl[] = {
+	ref927x_pin_configs,
+};
+
+static struct hda_board_config stac927x_cfg_tbl[] = {
+	{ .modelname = "ref",
+	  .pci_subvendor = PCI_VENDOR_ID_INTEL,
+	  .pci_subdevice = 0x2668,	/* DFI LanParty */
+	  .config = STAC_REF },		/* SigmaTel reference board */
+	{} /* terminator */
+};
+
 static void stac92xx_set_config_regs(struct hda_codec *codec)
 {
 	int i;
@@ -412,11 +467,23 @@
 	},
 };
 
+static struct hda_pcm_stream stac92xx_pcm_analog_alt_playback = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	.nid = 0x06, /* NID to query formats and rates */
+	.ops = {
+		.open = stac92xx_playback_pcm_open,
+		.prepare = stac92xx_playback_pcm_prepare,
+		.cleanup = stac92xx_playback_pcm_cleanup
+	},
+};
+
 static struct hda_pcm_stream stac92xx_pcm_analog_capture = {
 	.substreams = 2,
 	.channels_min = 2,
 	.channels_max = 2,
-	.nid = 0x06, /* NID to query formats and rates */
+	/* NID is set in stac92xx_build_pcms */
 	.ops = {
 		.prepare = stac92xx_capture_pcm_prepare,
 		.cleanup = stac92xx_capture_pcm_cleanup
@@ -434,6 +501,14 @@
 	info->name = "STAC92xx Analog";
 	info->stream[SNDRV_PCM_STREAM_PLAYBACK] = stac92xx_pcm_analog_playback;
 	info->stream[SNDRV_PCM_STREAM_CAPTURE] = stac92xx_pcm_analog_capture;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adc_nids[0];
+
+	if (spec->alt_switch) {
+		codec->num_pcms++;
+		info++;
+		info->name = "STAC92xx Analog Alt";
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK] = stac92xx_pcm_analog_alt_playback;
+	}
 
 	if (spec->multiout.dig_out_nid || spec->dig_in_nid) {
 		codec->num_pcms++;
@@ -592,6 +667,16 @@
 	return 0;
 }
 
+/*
+ * XXX The line_out pin widget connection list may not be set to the
+ * desired DAC nid. This is the case on 927x where ports A and B can
+ * be routed to several DACs.
+ *
+ * This requires an analysis of the line-out/hp pin configuration
+ * to provide a best fit for pin/DAC configurations that are routable.
+ * For now, 927x DAC4 is not supported and 927x DAC1 output to ports
+ * A and B is not supported.
+ */
 /* fill in the dac_nids table from the parsed pin configuration */
 static int stac92xx_auto_fill_dac_nids(struct hda_codec *codec, const struct auto_pin_cfg *cfg)
 {
@@ -757,7 +842,7 @@
 		stac92xx_auto_set_pinctl(codec, pin, AC_PINCTL_OUT_EN | AC_PINCTL_HP_EN);
 }
 
-static int stac922x_parse_auto_config(struct hda_codec *codec)
+static int stac92xx_parse_auto_config(struct hda_codec *codec, hda_nid_t dig_out, hda_nid_t dig_in)
 {
 	struct sigmatel_spec *spec = codec->spec;
 	int err;
@@ -781,11 +866,11 @@
 		spec->surr_switch = 1;
 
 	if (spec->autocfg.dig_out_pin) {
-		spec->multiout.dig_out_nid = 0x08;
+		spec->multiout.dig_out_nid = dig_out;
 		stac92xx_auto_set_pinctl(codec, spec->autocfg.dig_out_pin, AC_PINCTL_OUT_EN);
 	}
 	if (spec->autocfg.dig_in_pin) {
-		spec->dig_in_nid = 0x09;
+		spec->dig_in_nid = dig_in;
 		stac92xx_auto_set_pinctl(codec, spec->autocfg.dig_in_pin, AC_PINCTL_IN_EN);
 	}
 
@@ -1000,7 +1085,47 @@
 
 	spec->multiout.dac_nids = spec->dac_nids;
 
-	err = stac922x_parse_auto_config(codec);
+	err = stac92xx_parse_auto_config(codec, 0x08, 0x09);
+	if (err < 0) {
+		stac92xx_free(codec);
+		return err;
+	}
+
+	codec->patch_ops = stac92xx_patch_ops;
+
+	return 0;
+}
+
+static int patch_stac927x(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec;
+	int err;
+
+	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+	spec->board_config = snd_hda_check_board_config(codec, stac927x_cfg_tbl);
+	if (spec->board_config < 0)
+                snd_printdd(KERN_INFO "hda_codec: Unknown model for STAC927x, using BIOS defaults\n");
+	else {
+		spec->num_pins = 14;
+		spec->pin_nids = stac927x_pin_nids;
+		spec->pin_configs = stac927x_brd_tbl[spec->board_config];
+		stac92xx_set_config_regs(codec);
+	}
+
+	spec->adc_nids = stac927x_adc_nids;
+	spec->mux_nids = stac927x_mux_nids;
+	spec->num_muxes = 3;
+
+	spec->init = stac927x_core_init;
+	spec->mixer = stac927x_mixer;
+
+	spec->multiout.dac_nids = spec->dac_nids;
+
+	err = stac92xx_parse_auto_config(codec, 0x1e, 0x20);
 	if (err < 0) {
 		stac92xx_free(codec);
 		return err;
@@ -1022,5 +1147,15 @@
  	{ .id = 0x83847681, .name = "STAC9220D/9223D A2", .patch = patch_stac922x },
  	{ .id = 0x83847682, .name = "STAC9221 A2", .patch = patch_stac922x },
  	{ .id = 0x83847683, .name = "STAC9221D A2", .patch = patch_stac922x },
+ 	{ .id = 0x83847620, .name = "STAC9274", .patch = patch_stac927x },
+ 	{ .id = 0x83847621, .name = "STAC9274D", .patch = patch_stac927x },
+ 	{ .id = 0x83847622, .name = "STAC9273X", .patch = patch_stac927x },
+ 	{ .id = 0x83847623, .name = "STAC9273D", .patch = patch_stac927x },
+ 	{ .id = 0x83847624, .name = "STAC9272X", .patch = patch_stac927x },
+ 	{ .id = 0x83847625, .name = "STAC9272D", .patch = patch_stac927x },
+ 	{ .id = 0x83847626, .name = "STAC9271X", .patch = patch_stac927x },
+ 	{ .id = 0x83847627, .name = "STAC9271D", .patch = patch_stac927x },
+ 	{ .id = 0x83847628, .name = "STAC9274X5NH", .patch = patch_stac927x },
+ 	{ .id = 0x83847629, .name = "STAC9274D5NH", .patch = patch_stac927x },
 	{} /* terminator */
 };


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
