From: Matt <matt@embeddedalley.com>
Subject: Re: [PATCH][2/2] hda: add sigmatel codec support
Date: Wed, 13 Apr 2005 00:49:52 -0700
Message-ID: <20050413004951.F24624@cox.net>
References: <20050413003805.E24624@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050413003805.E24624@cox.net>; from matt@embeddedalley.com on Wed, Apr 13, 2005 at 12:38:05AM -0700
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
List-Id: alsa-devel@alsa-project.org

Add initial SigmaTel codec support for 9200 and 922x. Note that
this hda patch relies on the configuration default registers to
be set correctly (normally by BIOS/firmware) in order for it to
set up pin widgets properly. There's a test switch in the patch
so it will work with the SigmaTel reference boards that are usually
plugged into a system that doesn't set the configuration default
registers. It supports 2 channel analog out and line/mic in. I
plan to add >2 channel support and spdif support shortly.
Please apply.

Signed-off-by: Matt <matt@embeddedalley.com>

Index: alsa-driver/pci/hda/patch_sigmatel.c
===================================================================
RCS file: alsa-driver/pci/hda/patch_sigmatel.c
diff -N alsa-driver/pci/hda/patch_sigmatel.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ alsa-driver/pci/hda/patch_sigmatel.c	13 Apr 2005 07:28:28 -0000
@@ -0,0 +1,2 @@
+#define __NO_VERSION__
+#include "../../alsa-kernel/pci/hda/patch_sigmatel.c"
Index: alsa-kernel/pci/hda/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/Makefile,v
retrieving revision 1.2
diff -u -r1.2 Makefile
--- alsa-kernel/pci/hda/Makefile	22 Mar 2005 21:02:04 -0000	1.2
+++ alsa-kernel/pci/hda/Makefile	13 Apr 2005 07:28:28 -0000
@@ -1,5 +1,5 @@
 snd-hda-intel-objs := hda_intel.o
-snd-hda-codec-objs := hda_codec.o hda_generic.o patch_realtek.o patch_cmedia.o patch_analog.o
+snd-hda-codec-objs := hda_codec.o hda_generic.o patch_realtek.o patch_cmedia.o patch_analog.o patch_sigmatel.o
 ifdef CONFIG_PROC_FS
 snd-hda-codec-objs += hda_proc.o
 endif
Index: alsa-kernel/pci/hda/hda_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_codec.c,v
retrieving revision 1.9
diff -u -r1.9 hda_codec.c
--- alsa-kernel/pci/hda/hda_codec.c	21 Mar 2005 19:42:00 -0000	1.9
+++ alsa-kernel/pci/hda/hda_codec.c	13 Apr 2005 07:28:29 -0000
@@ -51,6 +51,7 @@
 	{ 0x10ec, "Realtek" },
 	{ 0x13f6, "C-Media" },
 	{ 0x434d, "C-Media" },
+	{ 0x8384, "SigmaTel" },
 	{} /* terminator */
 };
 
Index: alsa-kernel/pci/hda/hda_patch.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_patch.h,v
retrieving revision 1.2
diff -u -r1.2 hda_patch.h
--- alsa-kernel/pci/hda/hda_patch.h	22 Mar 2005 21:02:04 -0000	1.2
+++ alsa-kernel/pci/hda/hda_patch.h	13 Apr 2005 07:28:30 -0000
@@ -8,10 +8,13 @@
 extern struct hda_codec_preset snd_hda_preset_cmedia[];
 /* Analog Devices codecs */
 extern struct hda_codec_preset snd_hda_preset_analog[];
+/* SigmaTel codecs */
+extern struct hda_codec_preset snd_hda_preset_sigmatel[];
 
 static const struct hda_codec_preset *hda_preset_tables[] = {
 	snd_hda_preset_realtek,
 	snd_hda_preset_cmedia,
 	snd_hda_preset_analog,
+	snd_hda_preset_sigmatel,
 	NULL
 };
Index: alsa-kernel/pci/hda/patch_sigmatel.c
===================================================================
RCS file: alsa-kernel/pci/hda/patch_sigmatel.c
diff -N alsa-kernel/pci/hda/patch_sigmatel.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ alsa-kernel/pci/hda/patch_sigmatel.c	13 Apr 2005 07:28:30 -0000
@@ -0,0 +1,560 @@
+/*
+ * Universal Interface for Intel High Definition Audio Codec
+ *
+ * HD audio interface patch for SigmaTel STAC92xx
+ *
+ * Copyright (c) 2005 Embedded Alley Solutions, Inc.
+ * <matt@embeddedalley.com>
+ *
+ * Based on patch_cmedia.c and patch_realtek.c
+ * Copyright (c) 2004 Takashi Iwai <tiwai@suse.de>
+ *
+ *  This driver is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This driver is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <sound/driver.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <sound/core.h>
+#include "hda_codec.h"
+#include "hda_local.h"
+
+#undef STAC_TEST
+
+struct sigmatel_spec {
+	/* playback */
+	struct hda_multi_out multiout;
+	hda_nid_t playback_nid;
+
+	/* capture */
+	hda_nid_t *adc_nids;
+	hda_nid_t *mux_nids;
+	unsigned int num_adcs;
+	hda_nid_t capture_nid;
+
+	/* power management*/
+	hda_nid_t *pstate_nids;
+	unsigned int num_pstates;
+
+	/* pin widgets */
+	hda_nid_t *pin_nids;
+	unsigned int num_pins;
+#ifdef STAC_TEST
+	unsigned int *pin_configs;
+#endif
+
+	/* codec specific stuff */
+	struct hda_verb *init;
+	snd_kcontrol_new_t *mixer;
+
+	/* capture source */
+	const struct hda_input_mux *input_mux;
+	unsigned int cur_mux[2];
+
+	/* channel mode */
+	unsigned int num_ch_modes;
+	unsigned int cur_ch_mode;
+	const struct sigmatel_channel_mode *channel_modes;
+
+	struct hda_pcm pcm_rec[1];	/* PCM information */
+};
+
+static hda_nid_t stac9200_adc_nids[1] = {
+        0x03,
+};
+
+static hda_nid_t stac9200_mux_nids[1] = {
+        0x0c,
+};
+
+static hda_nid_t stac9200_dac_nids[1] = {
+        0x02,
+};
+
+static hda_nid_t stac9200_pstate_nids[3] = {
+	0x01, 0x02, 0x03,
+};
+
+static hda_nid_t stac9200_pin_nids[8] = {
+	0x08, 0x09, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12,
+};
+
+static hda_nid_t stac922x_adc_nids[2] = {
+        0x06, 0x07,
+};
+
+static hda_nid_t stac922x_mux_nids[2] = {
+        0x12, 0x13,
+};
+
+static hda_nid_t stac922x_dac_nids[4] = {
+        0x02, 0x03, 0x04, 0x05,
+};
+
+static hda_nid_t stac922x_pstate_nids[7] = {
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+};
+
+static hda_nid_t stac922x_pin_nids[10] = {
+	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
+	0x0f, 0x10, 0x11, 0x15, 0x1b,
+};
+
+static int stac92xx_mux_enum_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	return snd_hda_input_mux_info(spec->input_mux, uinfo);
+}
+
+static int stac92xx_mux_enum_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+
+	ucontrol->value.enumerated.item[0] = spec->cur_mux[adc_idx];
+	return 0;
+}
+
+static int stac92xx_mux_enum_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+
+	return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
+				     spec->mux_nids[adc_idx], &spec->cur_mux[adc_idx]);
+}
+
+static struct hda_verb stac9200_ch2_init[] = {
+	/* set dac0mux for dac converter */
+	{ 0x07, 0x701, 0x00},
+	{}
+};
+
+static struct hda_verb stac922x_ch2_init[] = {
+	/* set master volume and direct control */	
+	{ 0x16, 0x70f, 0xff},
+	{}
+};
+
+struct sigmatel_channel_mode {
+	unsigned int channels;
+	const struct hda_verb *sequence;
+};
+
+static snd_kcontrol_new_t stac9200_mixer[] = {
+	HDA_CODEC_VOLUME("Master Playback Volume", 0xb, 0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Master Playback Switch", 0xb, 0, HDA_OUTPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input Source",
+		.count = 1,
+		.info = stac92xx_mux_enum_info,
+		.get = stac92xx_mux_enum_get,
+		.put = stac92xx_mux_enum_put,
+	},
+	HDA_CODEC_VOLUME("Capture Volume", 0x0a, 0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x0a, 0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Input Mux Volume", 0x0c, 0, HDA_OUTPUT),
+	{ } /* end */
+};
+
+static snd_kcontrol_new_t stac922x_mixer[] = {
+	HDA_CODEC_VOLUME("PCM Playback Volume", 0x2, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("PCM Playback Switch", 0x2, 0x0, HDA_OUTPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input Source",
+		.count = 1,
+		.info = stac92xx_mux_enum_info,
+		.get = stac92xx_mux_enum_get,
+		.put = stac92xx_mux_enum_put,
+	},
+	HDA_CODEC_VOLUME("Capture Volume", 0x17, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x17, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mux Capture Volume", 0x12, 0x0, HDA_OUTPUT),
+	{ } /* end */
+};
+
+static struct hda_input_mux stac9200_input_mux = {
+	.num_items = 5,
+	.items = {
+		{ "Port B", 0x0 },
+		{ "Port C", 0x1 },
+		{ "Port D", 0x2 },
+		{ "Port A", 0x3 },
+		{ "CD", 0x4 },
+	}
+};
+
+static struct hda_input_mux stac922x_input_mux = {
+	.num_items = 7,
+	.items = {
+		{ "Port E", 0x0 },
+		{ "CD", 0x1 },
+		{ "Port F", 0x2 },
+		{ "Port B", 0x3 },
+		{ "Port C", 0x4 },
+		{ "Port D", 0x5 },
+		{ "Port A", 0x6 },
+	}
+};
+
+static int stac92xx_build_controls(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	int err;
+
+	err = snd_hda_add_new_ctls(codec, spec->mixer);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+#ifdef STAC_TEST
+static unsigned int stac9200_pin_configs[8] = {
+	0x40000100, 0x40000100, 0x0221401f, 0x01114010,
+	0x02a19020, 0x01a19021, 0x90100140, 0x01813122,
+};
+
+static unsigned int stac922x_pin_configs[14] = {
+	0x40000100, 0x40000100, 0x40000100, 0x01114010,
+	0x01813122, 0x40000100, 0x40000100, 0x40000100,
+	0x40000100, 0x40000100,
+};
+
+static void stac92xx_set_config_regs(struct hda_codec *codec)
+{
+	int i;
+	struct sigmatel_spec *spec = codec->spec;
+	unsigned int pin_cfg;
+
+	for (i=0; i < spec->num_pins; i++) {
+		snd_hda_codec_write(codec, spec->pin_nids[i], 0,
+				    AC_VERB_SET_CONFIG_DEFAULT_BYTES_0,
+				    spec->pin_configs[i] & 0x000000ff);
+		snd_hda_codec_write(codec, spec->pin_nids[i], 0,
+				    AC_VERB_SET_CONFIG_DEFAULT_BYTES_1,
+				    (spec->pin_configs[i] & 0x0000ff00) >> 8);
+		snd_hda_codec_write(codec, spec->pin_nids[i], 0,
+				    AC_VERB_SET_CONFIG_DEFAULT_BYTES_2,
+				    (spec->pin_configs[i] & 0x00ff0000) >> 16);
+		snd_hda_codec_write(codec, spec->pin_nids[i], 0,
+				    AC_VERB_SET_CONFIG_DEFAULT_BYTES_3,
+				    spec->pin_configs[i] >> 24);
+		pin_cfg = snd_hda_codec_read(codec, spec->pin_nids[i], 0,
+					     AC_VERB_GET_CONFIG_DEFAULT,
+					     0x00);	
+		printk("pin nid %2.2x pin config %8.8x\n", spec->pin_nids[i], pin_cfg);
+	}
+}
+#endif
+
+static int stac92xx_set_pinctl(struct hda_codec *codec, hda_nid_t nid, unsigned int value)
+{
+	unsigned int pin_ctl;
+
+	pin_ctl = snd_hda_codec_read(codec, nid, 0,
+				     AC_VERB_GET_PIN_WIDGET_CONTROL,
+				     0x00);
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+			    pin_ctl | value);
+
+	return 0;
+}
+
+static int stac92xx_set_vref(struct hda_codec *codec, hda_nid_t nid)
+{
+	unsigned int vref_caps = snd_hda_param_read(codec, nid, AC_PAR_PIN_CAP) >> AC_PINCAP_VREF_SHIFT;
+	unsigned int vref_ctl = AC_PINCTL_VREF_HIZ;
+
+	if (vref_caps & AC_PINCAP_VREF_100)
+		vref_ctl = AC_PINCTL_VREF_100;
+	else if (vref_caps & AC_PINCAP_VREF_80)
+		vref_ctl = AC_PINCTL_VREF_80;
+	else if (vref_caps & AC_PINCAP_VREF_50)
+		vref_ctl = AC_PINCTL_VREF_50;
+	else if (vref_caps & AC_PINCAP_VREF_GRD)
+		vref_ctl = AC_PINCTL_VREF_GRD;
+
+	stac92xx_set_pinctl(codec, nid, vref_ctl);
+	
+	return 0;
+}
+
+static int stac92xx_config_pin(struct hda_codec *codec, hda_nid_t nid, unsigned int pin_cfg)
+{
+	switch((pin_cfg & AC_DEFCFG_DEVICE) >> AC_DEFCFG_DEVICE_SHIFT) {
+		case AC_JACK_HP_OUT:
+			/* Enable HP amp */
+			stac92xx_set_pinctl(codec, nid, AC_PINCTL_HP_EN);
+			/* Fall through */
+		case AC_JACK_LINE_OUT:
+		case AC_JACK_SPEAKER:
+			/* Enable output */
+			stac92xx_set_pinctl(codec, nid, AC_PINCTL_OUT_EN);
+			break;
+		case AC_JACK_MIC_IN:
+			/* Set vref */
+			stac92xx_set_vref(codec, nid);
+		case AC_JACK_CD:
+		case AC_JACK_LINE_IN:
+		case AC_JACK_AUX:
+			/* Enable input */
+			stac92xx_set_pinctl(codec, nid, AC_PINCTL_IN_EN);
+			break;
+	}
+
+	return 0;
+}
+
+static int stac92xx_config_pins(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	int i;
+	unsigned int pin_cfg;
+
+	for (i=0; i < spec->num_pins; i++) {
+		/* Default to disabled */
+		snd_hda_codec_write(codec, spec->pin_nids[i], 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL,
+				    0x00);
+
+		pin_cfg = snd_hda_codec_read(codec, spec->pin_nids[i], 0,
+					     AC_VERB_GET_CONFIG_DEFAULT,
+					     0x00);
+		if (((pin_cfg & AC_DEFCFG_PORT_CONN) >> AC_DEFCFG_PORT_CONN_SHIFT) == AC_JACK_PORT_NONE)
+			continue;	/* Move on */
+
+		stac92xx_config_pin(codec, spec->pin_nids[i], pin_cfg);
+	}
+
+	return 0;
+}
+
+static int stac92xx_init(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	int i;
+
+	for (i=0; i < spec->num_pstates; i++)
+		snd_hda_codec_write(codec, spec->pstate_nids[i], 0,
+				    AC_VERB_SET_POWER_STATE, 0x00);
+
+	mdelay(100);
+
+	snd_hda_sequence_write(codec, spec->init);
+
+#ifdef STAC_TEST
+	stac92xx_set_config_regs(codec);
+#endif
+
+	stac92xx_config_pins(codec);
+
+	return 0;
+}
+
+/*
+ * Analog playback callbacks
+ */
+static int stac92xx_playback_pcm_open(struct hda_pcm_stream *hinfo,
+				      struct hda_codec *codec,
+				      snd_pcm_substream_t *substream)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream);
+}
+
+static int stac92xx_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
+					 struct hda_codec *codec,
+					 unsigned int stream_tag,
+					 unsigned int format,
+					 snd_pcm_substream_t *substream)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	return snd_hda_multi_out_analog_prepare(codec, &spec->multiout, stream_tag,
+						format, substream);
+}
+
+static int stac92xx_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
+					struct hda_codec *codec,
+					snd_pcm_substream_t *substream)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	return snd_hda_multi_out_analog_cleanup(codec, &spec->multiout);
+}
+
+/*
+ * Analog capture callbacks
+ */
+static int stac92xx_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
+					struct hda_codec *codec,
+					unsigned int stream_tag,
+					unsigned int format,
+					snd_pcm_substream_t *substream)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	snd_hda_codec_setup_stream(codec, spec->adc_nids[substream->number],
+                                   stream_tag, 0, format);
+	return 0;
+}
+
+static int stac92xx_capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
+					struct hda_codec *codec,
+					snd_pcm_substream_t *substream)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	snd_hda_codec_setup_stream(codec, spec->adc_nids[substream->number], 0, 0, 0);
+	return 0;
+}
+
+static struct hda_pcm_stream stac92xx_pcm_analog_playback = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	.nid = 0x02, /* NID to query formats and rates */
+	.ops = {
+		.open = stac92xx_playback_pcm_open,
+		.prepare = stac92xx_playback_pcm_prepare,
+		.cleanup = stac92xx_playback_pcm_cleanup
+	},
+};
+
+static struct hda_pcm_stream stac92xx_pcm_analog_capture = {
+	.substreams = 2,
+	.channels_min = 2,
+	.channels_max = 2,
+	.nid = 0x06, /* NID to query formats and rates */
+	.ops = {
+		.prepare = stac92xx_capture_pcm_prepare,
+		.cleanup = stac92xx_capture_pcm_cleanup
+	},
+};
+
+static int stac92xx_build_pcms(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	struct hda_pcm *info = spec->pcm_rec;
+
+	codec->num_pcms = 1;
+	codec->pcm_info = info;
+
+	info->name = "STAC92xx";
+	info->stream[SNDRV_PCM_STREAM_PLAYBACK] = stac92xx_pcm_analog_playback;
+	info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->playback_nid;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE] = stac92xx_pcm_analog_capture;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->capture_nid;
+
+	return 0;
+}
+
+static void stac92xx_free(struct hda_codec *codec)
+{
+	kfree(codec->spec);
+}
+
+static struct hda_codec_ops stac92xx_patch_ops = {
+	.build_controls = stac92xx_build_controls,
+	.build_pcms = stac92xx_build_pcms,
+	.init = stac92xx_init,
+	.free = stac92xx_free,
+};
+
+static int patch_stac9200(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec;
+
+	spec  = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+
+	spec->multiout.max_channels = 2;
+	spec->multiout.num_dacs = 1;
+	spec->multiout.dac_nids = stac9200_dac_nids;
+	spec->adc_nids = stac9200_adc_nids;
+	spec->mux_nids = stac9200_mux_nids;
+	spec->input_mux = &stac9200_input_mux;
+	spec->pstate_nids = stac9200_pstate_nids;
+	spec->num_pstates = 3;
+	spec->pin_nids = stac9200_pin_nids;
+#ifdef STAC_TEST
+	spec->pin_configs = stac9200_pin_configs;
+#endif
+	spec->num_pins = 8;
+	spec->init = stac9200_ch2_init;
+	spec->mixer = stac9200_mixer;
+	spec->playback_nid = 0x02;
+	spec->capture_nid = 0x03;
+
+	codec->patch_ops = stac92xx_patch_ops;
+
+	return 0;
+}
+
+static int patch_stac922x(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec;
+
+	spec  = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+
+	spec->multiout.max_channels = 2;
+	spec->multiout.num_dacs = 4;
+	spec->multiout.dac_nids = stac922x_dac_nids;
+	spec->adc_nids = stac922x_adc_nids;
+	spec->mux_nids = stac922x_mux_nids;
+	spec->input_mux = &stac922x_input_mux;
+	spec->pstate_nids = stac922x_pstate_nids;
+	spec->num_pstates = 7;
+	spec->pin_nids = stac922x_pin_nids;
+#ifdef STAC_TEST
+	spec->pin_configs = stac922x_pin_configs;
+#endif
+	spec->num_pins = 10;
+	spec->init = stac922x_ch2_init;
+	spec->mixer = stac922x_mixer;
+	spec->playback_nid = 0x02;
+	spec->capture_nid = 0x06;
+
+	codec->patch_ops = stac92xx_patch_ops;
+
+	return 0;
+}
+
+/*
+ * patch entries
+ */
+struct hda_codec_preset snd_hda_preset_sigmatel[] = {
+ 	{ .id = 0x83847690, .name = "STAC9200", .patch = patch_stac9200 },
+ 	{ .id = 0x83847882, .name = "STAC9220 A1", .patch = patch_stac922x },
+ 	{ .id = 0x83847680, .name = "STAC9221 A1", .patch = patch_stac922x },
+ 	{ .id = 0x83847880, .name = "STAC9220 A2", .patch = patch_stac922x },
+ 	{ .id = 0x83847681, .name = "STAC9220D/9223D A2", .patch = patch_stac922x },
+ 	{ .id = 0x83847682, .name = "STAC9221 A2", .patch = patch_stac922x },
+ 	{ .id = 0x83847683, .name = "STAC9221D A2", .patch = patch_stac922x },
+	{} /* terminator */
+};


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
