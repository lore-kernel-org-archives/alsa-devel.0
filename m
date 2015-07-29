From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v3 02/13] topology: Add topology core parser.
Date: Wed, 29 Jul 2015 17:45:14 +0100
Message-ID: <1438188325-11553-3-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1438188325-11553-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E2BD2605E1
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 18:45:45 +0200 (CEST)
In-Reply-To: <1438188325-11553-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The topology core parses the high level topology file and calls the
individual object parsers when any new object element is detected at
the high level.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/topology.h        | 497 ++++++++++++++++++++++++++++++++++++++++++++++
 src/topology/elem.c       | 187 +++++++++++++++++
 src/topology/parser.c     | 359 +++++++++++++++++++++++++++++++++
 src/topology/tplg_local.h | 234 ++++++++++++++++++++++
 4 files changed, 1277 insertions(+)
 create mode 100644 include/topology.h
 create mode 100644 src/topology/elem.c
 create mode 100644 src/topology/parser.c
 create mode 100644 src/topology/tplg_local.h

diff --git a/include/topology.h b/include/topology.h
new file mode 100644
index 0000000..f604ed1
--- /dev/null
+++ b/include/topology.h
@@ -0,0 +1,497 @@
+/*
+ *
+ *  This library is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU Lesser General Public License as
+ *  published by the Free Software Foundation; either version 2.1 of
+ *  the License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ *  Copyright (C) 2015 Intel Corporation
+ *
+ */
+
+#ifndef __ALSA_TOPOLOGY_H
+#define __ALSA_TOPOLOGY_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * \defgroup topology Topology Interface
+ * \{
+ */
+
+/*! \page topology ALSA Topology Interface
+ *
+ * The topology interface allows developers to define DSP topologies in a text
+ * file format and to convert the text topology to a binary topology
+ * representation that can be understood by the kernel. The topology core
+ * currently recognises the following object types :-
+ *
+ *  * Controls (mixer, enumerated and byte) including TLV data.
+ *  * PCMs (FE and BE configurations and capabilities)
+ *  * DAPM widgets
+ *  * DAPM graph elements.
+ *  * Private data for each object type.
+ *  * Manifest (containing count of each object type)
+ *
+ * <h3>Topology File Format</h3>
+ *
+ * The topology text format uses the standard ALSA configuration file format to
+ * describe each topology object type. This allows topology objects to include
+ * other topology objects as part of thier definition. i.e. a TLV data object
+ * can be shared amongst many control objects that use the same TLV data.
+ *
+ *
+ * <h4>Controls</h4>
+ * Topology audio controls can belong to three different types :-
+ *   * Mixer control
+ *   * Enumerated control
+ *   * Byte control
+ *
+ * Each control type can contain TLV data, private data, operations and also
+ * belong to widget objects.<br>
+ *
+ * <h5>Control Operations</h5>
+ * Driver Kcontrol callback info(), get() and put() operations are mapped with
+ * the CTL ops section in topology configuration files. The ctl ops section can
+ * assign operations using the standard names (listed below) for the standard
+ * kcontrol types or use ID numbers (>256) to map to bespoke driver controls.<br>
+ *
+ * <pre>
+ *
+ *	ops."ctl" {
+ *		info "volsw"
+ *		get "257"
+ *		put "257"
+ *	}
+ *
+ * </pre>
+ *
+ * This mapping shows info() using the standard "volsw" info callback whilst
+ * the get() and put() are mapped to bespoke driver callbacks. <br>
+ *
+ * The Standard operations names for control get(), put() and info calls
+ * are :-
+ *  * volsw
+ *  * volsw_sx
+ *  * volsw_xr_sx
+ *  * enum
+ *  * bytes
+ *  * enum_value
+ *  * range
+ *  * strobe
+ *
+ * <h5>Control TLV Data</h5>
+ * Controls can also use TLV data to represent dB information. This can be done
+ * by defining a TLV section and using the TLV section within the control.
+ * The TLV data for DBScale types are defined as follows :-
+ *
+ * <pre>
+ *	scale {
+ *		min "-9000"
+ *		step "300"
+ *		mute "1"
+ *	}
+ * </pre>
+ *
+ * Where the meanings and values for min, step and mute are exactly the same
+ * as defined in driver code.
+ *
+ * <h5>Control Channel Mapping</h5>
+ * Controls can also specify which channels they are mapped with. This is useful
+ * for userspace as it allows applications to determine the correct control
+ * channel for Left and Right etc. Channel maps are defined as follows :-
+ *
+ * <pre>
+ *	channel."name" {
+ *		reg "0"
+ *		shift "0"
+ *	}
+ * </pre>
+ *
+ * The channel map reg is the register offset for the control, shift is the
+ * bit shift within the register for the channel and the section name is the
+ * channel name and can be one of the following :-
+ *
+ * <pre>
+ *  * mono		# mono stream
+ *  * fl 		# front left
+ *  * fr		# front right
+ *  * rl		# rear left
+ *  * rr		# rear right
+ *  * fc		# front center
+ *  * lfe		# LFE
+ *  * sl		# side left
+ *  * sr		# side right
+ *  * rc		# rear center
+ *  * flc		# front left center
+ *  * frc		# front right center
+ *  * rlc		# rear left center
+ *  * rrc		# rear right center
+ *  * flw		# front left wide
+ *  * frw		# front right wide
+ *  * flh		# front left high
+ *  * fch		# front center high
+ *  * frh		# front right high
+ *  * tc		# top center
+ *  * tfl		# top front left
+ *  * tfr		# top front right
+ *  * tfc		# top front center
+ *  * trl		# top rear left
+ *  * trr		# top rear right
+ *  * trc		# top rear center
+ *  * tflc		# top front left center
+ *  * tfrc		# top front right center
+ *  * tsl		# top side left
+ *  * tsr		# top side right
+ *  * llfe		# left LFE
+ *  * rlfe		# right LFE
+ *  * bc		# bottom center
+ *  * blc		# bottom left center
+ *  * brc		# bottom right center
+ * </pre>
+ *
+ *  <h5>Control Private Data</h5>
+ * Controls can also have private data. This can be done by defining a private
+ * data section and including the section within the control. The private data
+ * section is defined as follows :-
+ *
+ * <pre>
+ * SectionData."pdata for EQU1" {
+ *	file "/path/to/file"
+ *	bytes "0x12,0x34,0x56,0x78"
+ *	shorts "0x1122,0x3344,0x5566,0x7788"
+ *	words "0xaabbccdd,0x11223344,0x66aa77bb,0xefef1234"
+ * };
+ * </pre>
+ * The file, bytes, shorts and words keywords are all mutulally exclusive as
+ * the private data should only be taken from one source.  The private data can
+ * either be read from a separate file or defined in the topology file using
+ * the bytes, shorts or words keywords.
+ *
+ * <h5>Mixer Controls</h5>
+ * A mixer control is defined as a new section that can include channel mapping,
+ * TLV data, callback operations and private data. The mixer section also
+ * includes a few other config options that are shown here :-
+ *
+ * <pre>
+ * SectionControlMixer."mixer name" {
+ *	comment "optional comments"
+ *
+ *	index "1"			# Index number
+ *
+ *	channel."name" {		# Channel maps
+ *	   ....
+ *	}
+ *
+ *	ops."ctl" {			# Ops callback functions
+ *	   ....
+ *	}
+ *
+ *	max "32"			# Max control value
+ *	invert "0"			# Whether control values are inverted
+ *
+ *	tlv "tld_data"			# optional TLV data
+ *
+ *	data "pdata for mixer1"		# optional private data
+ * }
+ * </pre>
+ *
+ * The section name is used to define the mixer name. The index number can be
+ * used to identify topology objects groups. This allows driver operations on
+ * objects with index number N and can be used to add/remove pipelines of
+ * objects whilst other objects are unaffected.
+ *
+ * <h5>Byte Controls</h5>
+ * A byte control is defined as a new section that can include channel mapping,
+ * TLV data, callback operations and private data. The bytes section also
+ * includes a few other config options that are shown here :-
+ *
+ * <pre>
+ * SectionControlBytes."name" {
+ *	comment "optional comments"
+ *
+ *	index "1"			# Index number
+ *
+ *	channel."name" {		# Channel maps
+ *	   ....
+ *	}
+ *
+ *	ops."ctl" {			# Ops callback functions
+ *	   ....
+ *	}
+ *
+ *	base "0"			# Register base
+ *	num_regs "16"			# Number of registers
+ *	mask "0xff"			# Mask
+ *	max "255"			# Maximum value
+ *
+ *	tlv "tld_data"			# optional TLV data
+ *
+ *	data "pdata for mixer1"		# optional private data
+ * }
+ * </pre>
+ *
+ * <h5>Enumerated Controls</h5>
+ * A enumerated control is defined as a new section (like mixer and byte) that
+ * can include channel mapping, callback operations, private data and
+ * text strings to represent the enumerated control options.<br>
+ *
+ * The text strings for the enumerated controls are defined in a seperate
+ * section as follows :-
+ *
+ * <pre>
+ * SectionText."name" {
+ *
+ *		Values [
+ *			"value1"
+ *			"value2"
+			"value3"
+ *		]
+ * }
+ * </pre>
+ *
+ * All the enumerated text values are listed in the values list.<br>
+ * The enumerated control is similar to the other controls and defined as
+ * follows :-
+ *
+ * <pre>
+ * SectionControlMixer."name" {
+ *	comment "optional comments"
+ *
+ *	index "1"			# Index number
+ *
+ *	texts "EQU1"			# Enumerated text items
+ *
+ *	channel."name" {		# Channel maps
+ *	   ....
+ *	}
+ *
+ *	ops."ctl" {			# Ops callback functions
+ *	   ....
+ *	}
+ *
+ *	data "pdata for mixer1"		# optional private data
+ * }
+ * </pre>
+ *
+ * <h4>DAPM Graph</h4>
+ * DAPM graphs can easily be defined using the topology file. The format is
+ * very similar to the DAPM graph kernel format. :-
+ *
+ * <pre>
+ * SectionGraph."dsp" {
+ *	index "1"			# Index number
+ *
+ *	lines [
+ *		"sink1, control, source1"
+ *		"sink2, , source2"
+ *	]
+ * }
+ * </pre>
+ *
+ * The lines in the graph are defined as a variable size list of sinks,
+ * controls and sources. The control name is optional as some graph lines have
+ * no associated controls. The section name can be used to differentiate the
+ * graph with other graphs, it's not used by the kernel atm.
+ *
+ * <h4>DAPM Widgets</h4>
+ * DAPM wigets are similar to controls in that they can include many other
+ * objects. Widgets can contain private data, mixer controls and enum controls.
+ *
+ * The following widget types are supported and match the driver types :-
+ *
+ *  * input
+ *  * output
+ *  * mux
+ *  * mixer
+ *  * pga
+ *  * out_drv
+ *  * adc
+ *  * dac
+ *  * switch
+ *  * pre
+ *  * post
+ *  * aif_in
+ *  * aif_out
+ *  * dai_in
+ *  * dai_out
+ *  * dai_link
+ *
+ * Widgets are defined as follows :-
+ *
+ * <pre>
+ * SectionWidget."name" {
+ *
+ *	index "1"			# Index number
+ *
+ *	type "aif_in"			# Widget type - detailed above
+ *
+ *	no_pm "true"			# No PM control bit.
+ *	reg "20"			# PM bit register offset
+ *	shift "0"			# PM bit register shift
+ *	invert "1			# PM bit is inverted
+ *	subseq "8"			# subsequence number
+ *
+ *	event_type "1"			# DAPM widget event type
+ *	event_flags "1"			# DAPM widget event flags
+ *
+ *	mixer "name"			# Optional Mixer Control
+ *	enum "name"			# Optional Enum Control
+ *
+ *	data "name"			# optional private data
+ * }
+ * </pre>
+ *
+ * The section name is the widget name. The mixer and enum fields are mutually
+ * exclusive and used to include controls into the widget. The index and data
+ * fields are the same for widgets as they are for controls whilst the other
+ * fields map on very closely to the driver widget fields.
+ *
+ * <h4>PCM Capabilities</h4>
+ * Topology can also define the capabilities of FE and BE PCMs. Capabilities
+ * can be defined with the following section :-
+ *
+ * <pre>
+ * SectionPCMCapabilities."name" {
+ *
+ *	formats "S24_LE,S16_LE"		# Supported formats
+ *	rate_min "48000"		# Max supported sample rate
+ *	rate_max "48000"		# Min suppoprted sample rate
+ *	channels_min "2"		# Min number of channels
+ *	channels_max "2"		# max number of channels
+ * }
+ * </pre>
+ * The supported formats use the same naming convention as the driver macros.
+ * The PCM capabilities name can be reffered to and included by BE, PCM and
+ * Codec <-> codec topology sections.
+ *
+ * <h4>PCM Configurations</h4>
+ * PCM runtime configurations can be defined for playback and capture stream
+ * directions with the following section  :-
+ *
+ * <pre>
+ * SectionPCMConfig."name" {
+ *
+ *	config."playback" {		# playback config
+ *		format "S16_LE"		# playback format
+ *		rate "48000"		# playback sample rate
+ *		channels "2"		# playback channels
+ *		tdm_slot "0xf"		# playback TDM slot
+ *	}
+ *
+ *	config."capture" {		# capture config
+ *		format "S16_LE"		# capture format
+ *		rate "48000"		# capture sample rate
+ *		channels "2"		# capture channels
+ *		tdm_slot "0xf"		# capture TDM slot
+ *	}
+ * }
+ * </pre>
+ *
+ * The supported formats use the same naming convention as the driver macros.
+ * The PCM configuration name can be reffered to and included by BE, PCM and
+ * Codec <-> codec topology sections.
+ *
+ * <h4>PCM Configurations</h4>
+ * PCM, BE and Codec to Codec link sections define the supported capabilities
+ * and configurations for supported playback and capture streams. The
+ * definitions and content for PCMs, BE and Codec links are the same with the
+ * exception of the section type :-
+ *
+ * <pre>
+ * SectionPCM."name" {
+ *	....
+ * }
+ * SectionBE."name" {
+ *	....
+ * }
+ * SectionCC."name" {
+ *	....
+ * }
+ * </pre>
+ *
+ * The section types above should be used for PCMs, Back Ends and Codec to Codec
+ * links respectively.<br>
+ *
+ * The data for each section is defined as follows :-
+ *
+ * <pre>
+ * SectionPCM."name" {
+ *
+ *	index "1"			# Index number
+ *
+ *	id "0"				# used for binding to the PCM
+ *
+ *	pcm."playback" {
+ *		capabilities "capabilities1"	# capbilities for playback
+ *
+ *		configs [		# supported configs for playback
+ *			"config1"
+ *			"config2"
+ *		]
+ *	}
+ *
+ *	pcm."capture" {
+ *		capabilities "capabilities2"	# capabilities for capture
+ *
+ *		configs [		# supported configs for capture
+ *			"config1"
+ *			"config2"
+ *			"config3"
+ *		]
+ *	}
+ * }
+ * </pre>
+ *
+ */
+
+/** Topology context */
+typedef struct snd_tplg snd_tplg_t;
+
+/**
+ * \brief Create a new topology parser instance.
+ * \return New topology parser instance
+ */
+snd_tplg_t *snd_tplg_new(void);
+
+/**
+ * \brief Free a topology parser instance.
+ * \param tplg Topology parser instance
+ */
+void snd_tplg_free(snd_tplg_t *tplg);
+
+/**
+ * \brief Parse and build topology text file into binary file.
+ * \param tplg Topology instance.
+ * \param infile Topology text input file to be parsed
+ * \param outfile Binary topology output file.
+ * \return Zero on sucess, otherwise a negative error code
+ */
+int snd_tplg_build_file(snd_tplg_t *tplg, const char *infile,
+	const char *outfile);
+
+/**
+ * \brief Enable verbose reporting of binary file output
+ * \param tplg Topology Instance
+ * \param verbose Enable verbose output level if non zero
+ */
+void snd_tplg_verbose(snd_tplg_t *tplg, int verbose);
+
+/* \} */
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __ALSA_TOPOLOGY_H */
diff --git a/src/topology/elem.c b/src/topology/elem.c
new file mode 100644
index 0000000..32ba2c1
--- /dev/null
+++ b/src/topology/elem.c
@@ -0,0 +1,187 @@
+/*
+  Copyright(c) 2014-2015 Intel Corporation
+  All rights reserved.
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of version 2 of the GNU General Public License as
+  published by the Free Software Foundation.
+
+  This program is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+  General Public License for more details.
+
+  Authors: Mengdong Lin <mengdong.lin@intel.com>
+           Yao Jin <yao.jin@intel.com>
+           Liam Girdwood <liam.r.girdwood@linux.intel.com>
+*/
+
+#include "list.h"
+#include "tplg_local.h"
+
+int tplg_ref_add(struct tplg_elem *elem, int type, const char* id)
+{
+	struct tplg_ref *ref;
+
+	ref = calloc(1, sizeof(*ref));
+	if (!ref)
+		return -ENOMEM;
+
+	strncpy(ref->id, id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	ref->id[SNDRV_CTL_ELEM_ID_NAME_MAXLEN - 1] = 0;
+	ref->type = type;
+
+	list_add_tail(&ref->list, &elem->ref_list);
+	return 0;
+}
+
+void tplg_ref_free_list(struct list_head *base)
+{
+	struct list_head *pos, *npos;
+	struct tplg_ref *ref;
+
+	list_for_each_safe(pos, npos, base) {
+		ref = list_entry(pos, struct tplg_ref, list);
+		list_del(&ref->list);
+		free(ref);
+	}
+}
+
+struct tplg_elem *tplg_elem_new(void)
+{
+	struct tplg_elem *elem;
+
+	elem = calloc(1, sizeof(*elem));
+	if (!elem)
+		return NULL;
+
+	INIT_LIST_HEAD(&elem->ref_list);
+	return elem;
+}
+
+void tplg_elem_free(struct tplg_elem *elem)
+{
+	tplg_ref_free_list(&elem->ref_list);
+
+	/* free struct snd_tplg_ object,
+	 * the union pointers share the same address
+	 */
+	if (elem->mixer_ctrl)
+		free(elem->mixer_ctrl);
+
+	free(elem);
+}
+
+void tplg_elem_free_list(struct list_head *base)
+{
+	struct list_head *pos, *npos;
+	struct tplg_elem *elem;
+
+	list_for_each_safe(pos, npos, base) {
+		elem = list_entry(pos, struct tplg_elem, list);
+		list_del(&elem->list);
+		tplg_elem_free(elem);
+	}
+}
+
+struct tplg_elem *tplg_elem_lookup(struct list_head *base, const char* id,
+	unsigned int type)
+{
+	struct list_head *pos;
+	struct tplg_elem *elem;
+
+	list_for_each(pos, base) {
+
+		elem = list_entry(pos, struct tplg_elem, list);
+
+		if (!strcmp(elem->id, id) && elem->type == type)
+			return elem;
+	}
+
+	return NULL;
+}
+
+/* create a new common element and object */
+struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
+	snd_config_t *cfg, enum object_type type)
+{
+	struct tplg_elem *elem;
+	const char *id;
+	int obj_size = 0;
+	void *obj;
+
+	elem = tplg_elem_new();
+	if (!elem)
+		return NULL;
+
+	snd_config_get_id(cfg, &id);
+	strncpy(elem->id, id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	elem->id[SNDRV_CTL_ELEM_ID_NAME_MAXLEN - 1] = 0;
+
+	switch (type) {
+	case OBJECT_TYPE_DATA:
+		list_add_tail(&elem->list, &tplg->pdata_list);
+		break;
+	case OBJECT_TYPE_TEXT:
+		list_add_tail(&elem->list, &tplg->text_list);
+		break;
+	case OBJECT_TYPE_TLV:
+		list_add_tail(&elem->list, &tplg->tlv_list);
+		elem->size = sizeof(struct snd_soc_tplg_ctl_tlv);
+		break;
+	case OBJECT_TYPE_BYTES:
+		list_add_tail(&elem->list, &tplg->bytes_ext_list);
+		obj_size = sizeof(struct snd_soc_tplg_bytes_control);
+		break;
+	case OBJECT_TYPE_ENUM:
+		list_add_tail(&elem->list, &tplg->enum_list);
+		obj_size = sizeof(struct snd_soc_tplg_enum_control);
+		break;
+	case SND_SOC_TPLG_TYPE_MIXER:
+		list_add_tail(&elem->list, &tplg->mixer_list);
+		obj_size = sizeof(struct snd_soc_tplg_mixer_control);
+		break;
+	case OBJECT_TYPE_DAPM_WIDGET:
+		list_add_tail(&elem->list, &tplg->widget_list);
+		obj_size = sizeof(struct snd_soc_tplg_dapm_widget);
+		break;
+	case OBJECT_TYPE_STREAM_CONFIG:
+		list_add_tail(&elem->list, &tplg->pcm_config_list);
+		obj_size = sizeof(struct snd_soc_tplg_stream_config);
+		break;
+	case OBJECT_TYPE_STREAM_CAPS:
+		list_add_tail(&elem->list, &tplg->pcm_caps_list);
+		obj_size = sizeof(struct snd_soc_tplg_stream_caps);
+		break;
+	case OBJECT_TYPE_PCM:
+		list_add_tail(&elem->list, &tplg->pcm_list);
+		obj_size = sizeof(struct snd_soc_tplg_pcm_dai);
+		break;
+	case OBJECT_TYPE_BE:
+		list_add_tail(&elem->list, &tplg->be_list);
+		obj_size = sizeof(struct snd_soc_tplg_pcm_dai);
+		break;
+	case OBJECT_TYPE_CC:
+		list_add_tail(&elem->list, &tplg->cc_list);
+		obj_size = sizeof(struct snd_soc_tplg_pcm_dai);
+		break;
+	default:
+		free(elem);
+		return NULL;
+	}
+
+	/* create new object too if required */
+	if (obj_size > 0) {
+		obj = calloc(1, obj_size);
+		if (obj == NULL) {
+			free(elem);
+			return NULL;
+		}
+
+		elem->obj = obj;
+		elem->size = obj_size;
+	}
+
+	elem->type = type;
+	return elem;
+}
diff --git a/src/topology/parser.c b/src/topology/parser.c
new file mode 100644
index 0000000..ed25bb8
--- /dev/null
+++ b/src/topology/parser.c
@@ -0,0 +1,359 @@
+/*
+  Copyright(c) 2014-2015 Intel Corporation
+  All rights reserved.
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of version 2 of the GNU General Public License as
+  published by the Free Software Foundation.
+
+  This program is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+  General Public License for more details.
+
+  Authors: Mengdong Lin <mengdong.lin@intel.com>
+           Yao Jin <yao.jin@intel.com>
+           Liam Girdwood <liam.r.girdwood@linux.intel.com>
+*/
+
+#include "list.h"
+#include "tplg_local.h"
+
+/*
+ * Parse compound
+ */
+int tplg_parse_compound(snd_tplg_t *tplg, snd_config_t *cfg,
+	int (*fcn)(snd_tplg_t *, snd_config_t *, void *),
+	void *private)
+{
+	const char *id;
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	int err = -EINVAL;
+
+	if (snd_config_get_id(cfg, &id) < 0)
+		return -EINVAL;
+
+	if (snd_config_get_type(cfg) != SND_CONFIG_TYPE_COMPOUND) {
+		SNDERR("error: compound type expected for %s", id);
+		return -EINVAL;
+	}
+
+	/* parse compound */
+	snd_config_for_each(i, next, cfg) {
+		n = snd_config_iterator_entry(i);
+
+		if (snd_config_get_type(cfg) != SND_CONFIG_TYPE_COMPOUND) {
+			SNDERR("error: compound type expected for %s, is %d",
+				id, snd_config_get_type(cfg));
+			return -EINVAL;
+		}
+
+		err = fcn(tplg, n, private);
+		if (err < 0)
+			return err;
+	}
+
+	return err;
+}
+
+static int tplg_parse_config(snd_tplg_t *tplg, snd_config_t *cfg)
+{
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *id;
+	int err;
+
+	if (snd_config_get_type(cfg) != SND_CONFIG_TYPE_COMPOUND) {
+		SNDERR("error: compound type expected at top level");
+		return -EINVAL;
+	}
+
+	/* parse topology config sections */
+	snd_config_for_each(i, next, cfg) {
+
+		n = snd_config_iterator_entry(i);
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+
+		if (strcmp(id, "SectionTLV") == 0) {
+			err = tplg_parse_compound(tplg, n, tplg_parse_tlv,
+				NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionControlMixer") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_control_mixer, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionControlEnum") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_control_enum, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionControlBytes") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_control_bytes, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionWidget") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_dapm_widget, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionPCMConfig") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_pcm_config, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionPCMCapabilities") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_pcm_caps, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionPCM") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_pcm, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionBE") == 0) {
+			err = tplg_parse_compound(tplg, n, tplg_parse_be,
+				NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionCC") == 0) {
+			err = tplg_parse_compound(tplg, n, tplg_parse_cc,
+				NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionGraph") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_dapm_graph, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionText") == 0) {
+			err = tplg_parse_compound(tplg, n, tplg_parse_text,
+				NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionData") == 0) {
+			err = tplg_parse_compound(tplg, n, tplg_parse_data,
+				NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		SNDERR("error: unknown section %s\n", id);
+	}
+	return 0;
+}
+
+static int tplg_load_config(const char *file, snd_config_t **cfg)
+{
+	FILE *fp;
+	snd_input_t *in;
+	snd_config_t *top;
+	int ret;
+
+	fp = fopen(file, "r");
+	if (fp == NULL) {
+		SNDERR("error: could not open configuration file %s",
+			file);
+		return -errno;
+	}
+
+	ret = snd_input_stdio_attach(&in, fp, 1);
+	if (ret < 0) {
+		SNDERR("error: could not attach stdio %s", file);
+		goto err;
+	}
+	ret = snd_config_top(&top);
+	if (ret < 0)
+		goto err;
+
+	ret = snd_config_load(top, in);
+	if (ret < 0) {
+		SNDERR("error: could not load configuration file %s",
+			file);
+		goto err_load;
+	}
+
+	ret = snd_input_close(in);
+	if (ret < 0)
+		goto err_load;
+
+	*cfg = top;
+	return 0;
+
+err_load:
+	snd_config_delete(top);
+err:
+	fclose(fp);
+	return ret;
+}
+
+static int tplg_build_integ(snd_tplg_t *tplg)
+{
+	int err;
+
+	err = tplg_build_controls(tplg);
+	if (err <  0)
+		return err;
+
+	err = tplg_build_widgets(tplg);
+	if (err <  0)
+		return err;
+
+	err = tplg_build_pcm_dai(tplg, OBJECT_TYPE_PCM);
+	if (err <  0)
+		return err;
+
+	err = tplg_build_pcm_dai(tplg, OBJECT_TYPE_BE);
+	if (err <  0)
+		return err;
+
+	err = tplg_build_pcm_dai(tplg, OBJECT_TYPE_CC);
+	if (err <  0)
+		return err;
+
+	err = tplg_build_routes(tplg);
+	if (err <  0)
+		return err;
+
+	return err;
+}
+
+int snd_tplg_build_file(snd_tplg_t *tplg, const char *infile,
+	const char *outfile)
+{
+	snd_config_t *cfg = NULL;
+	int err = 0;
+
+	/* delete any old output files */
+	unlink(outfile);
+
+	tplg->out_fd =
+		open(outfile, O_RDWR | O_CREAT, S_IRWXU | S_IRWXG | S_IRWXO);
+	if (tplg->out_fd < 0) {
+		SNDERR("error: failed to open %s err %d\n",
+			outfile, -errno);
+		return -errno;
+	}
+
+	err = tplg_load_config(infile, &cfg);
+	if (err < 0) {
+		SNDERR("error: failed to load topology file %s\n",
+			infile);
+		goto out_close;
+	}
+
+	err = tplg_parse_config(tplg, cfg);
+	if (err < 0) {
+		SNDERR("error: failed to parse topology\n");
+		goto out;
+	}
+
+	err = tplg_build_integ(tplg);
+	if (err < 0) {
+		SNDERR("error: failed to check topology integrity\n");
+		goto out;
+	}
+
+	err = tplg_write_data(tplg);
+	if (err < 0) {
+		SNDERR("error: failed to write data %d\n", err);
+		goto out;
+	}
+
+out:
+	snd_config_delete(cfg);
+out_close:
+	close(tplg->out_fd);
+	return err;
+}
+
+void snd_tplg_verbose(snd_tplg_t *tplg, int verbose)
+{
+	tplg->verbose = verbose;
+}
+
+snd_tplg_t *snd_tplg_new(void)
+{
+	snd_tplg_t *tplg;
+
+	tplg = calloc(1, sizeof(snd_tplg_t));
+	if (!tplg)
+		return NULL;
+
+	INIT_LIST_HEAD(&tplg->tlv_list);
+	INIT_LIST_HEAD(&tplg->widget_list);
+	INIT_LIST_HEAD(&tplg->pcm_list);
+	INIT_LIST_HEAD(&tplg->be_list);
+	INIT_LIST_HEAD(&tplg->cc_list);
+	INIT_LIST_HEAD(&tplg->route_list);
+	INIT_LIST_HEAD(&tplg->pdata_list);
+	INIT_LIST_HEAD(&tplg->text_list);
+	INIT_LIST_HEAD(&tplg->pcm_config_list);
+	INIT_LIST_HEAD(&tplg->pcm_caps_list);
+	INIT_LIST_HEAD(&tplg->mixer_list);
+	INIT_LIST_HEAD(&tplg->enum_list);
+	INIT_LIST_HEAD(&tplg->bytes_ext_list);
+
+	return tplg;
+}
+
+void snd_tplg_free(snd_tplg_t *tplg)
+{
+	tplg_elem_free_list(&tplg->tlv_list);
+	tplg_elem_free_list(&tplg->widget_list);
+	tplg_elem_free_list(&tplg->pcm_list);
+	tplg_elem_free_list(&tplg->be_list);
+	tplg_elem_free_list(&tplg->cc_list);
+	tplg_elem_free_list(&tplg->route_list);
+	tplg_elem_free_list(&tplg->pdata_list);
+	tplg_elem_free_list(&tplg->text_list);
+	tplg_elem_free_list(&tplg->pcm_config_list);
+	tplg_elem_free_list(&tplg->pcm_caps_list);
+	tplg_elem_free_list(&tplg->mixer_list);
+	tplg_elem_free_list(&tplg->enum_list);
+	tplg_elem_free_list(&tplg->bytes_ext_list);
+
+	free(tplg);
+}
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
new file mode 100644
index 0000000..688c78f
--- /dev/null
+++ b/src/topology/tplg_local.h
@@ -0,0 +1,234 @@
+/*
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ */
+
+#include <limits.h>
+#include <stdint.h>
+#include <linux/types.h>
+
+#include "local.h"
+#include "list.h"
+#include "topology.h"
+
+#include <sound/asound.h>
+#include <sound/asoc.h>
+#include <sound/tlv.h>
+
+#define TPLG_DEBUG
+#ifdef TPLG_DEBUG
+#define tplg_dbg SNDERR
+#else
+#define tplg_dbg(fmt, arg...) do { } while (0)
+#endif
+
+#define MAX_FILE		256
+#define TPLG_MAX_PRIV_SIZE	(1024 * 128)
+#define ALSA_TPLG_DIR	ALSA_CONFIG_DIR "/topology"
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(x[0]))
+
+/** The name of the environment variable containing the tplg directory */
+#define ALSA_CONFIG_TPLG_VAR "ALSA_CONFIG_TPLG"
+
+struct tplg_ref;
+struct tplg_elem;
+
+/* internal topology object type not used by kernel */
+enum object_type {
+	OBJECT_TYPE_TLV = 0,
+	OBJECT_TYPE_MIXER,
+	OBJECT_TYPE_ENUM,
+	OBJECT_TYPE_TEXT,
+	OBJECT_TYPE_DATA,
+	OBJECT_TYPE_BYTES,
+	OBJECT_TYPE_STREAM_CONFIG,
+	OBJECT_TYPE_STREAM_CAPS,
+	OBJECT_TYPE_PCM,
+	OBJECT_TYPE_DAPM_WIDGET,
+	OBJECT_TYPE_DAPM_GRAPH,
+	OBJECT_TYPE_BE,
+	OBJECT_TYPE_CC,
+	OBJECT_TYPE_MANIFEST,
+};
+
+struct snd_tplg {
+
+	/* opaque vendor data */
+	int vendor_fd;
+	char *vendor_name;
+
+	/* out file */
+	int out_fd;
+
+	int verbose;
+	unsigned int version;
+
+	/* runtime state */
+	unsigned int next_hdr_pos;
+	int index;
+	int channel_idx;
+
+	/* manifest */
+	struct snd_soc_tplg_manifest manifest;
+
+	/* list of each element type */
+	struct list_head tlv_list;
+	struct list_head widget_list;
+	struct list_head pcm_list;
+	struct list_head be_list;
+	struct list_head cc_list;
+	struct list_head route_list;
+	struct list_head text_list;
+	struct list_head pdata_list;
+	struct list_head pcm_config_list;
+	struct list_head pcm_caps_list;
+
+	/* type-specific control lists */
+	struct list_head mixer_list;
+	struct list_head enum_list;
+	struct list_head bytes_ext_list;
+};
+
+/* object text references */
+struct tplg_ref {
+	unsigned int type;
+	struct tplg_elem *elem;
+	char id[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	struct list_head list;
+};
+
+/* topology element */
+struct tplg_elem {
+
+	char id[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+
+	/* storage for texts and data if this is text or data elem*/
+	char texts[SND_SOC_TPLG_NUM_TEXTS][SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+
+	int index;
+	enum object_type type;
+
+	int size; /* total size of this object inc pdata and ref objects */
+	int compound_elem; /* dont write this element as individual elem */
+	int vendor_type; /* vendor type for private data */
+
+	/* UAPI object for this elem */
+	union {
+		void *obj;
+		struct snd_soc_tplg_mixer_control *mixer_ctrl;
+		struct snd_soc_tplg_enum_control *enum_ctrl;
+		struct snd_soc_tplg_bytes_control *bytes_ext;
+		struct snd_soc_tplg_dapm_widget *widget;
+		struct snd_soc_tplg_pcm_dai *pcm;
+		struct snd_soc_tplg_pcm_dai *be;
+		struct snd_soc_tplg_pcm_dai *cc;
+		struct snd_soc_tplg_dapm_graph_elem *route;
+		struct snd_soc_tplg_stream_config *stream_cfg;
+		struct snd_soc_tplg_stream_caps *stream_caps;
+
+		/* these do not map to UAPI structs but are internal only */
+		struct snd_soc_tplg_ctl_tlv *tlv;
+		struct snd_soc_tplg_private *data;
+	};
+
+	/* an element may refer to other elements:
+	 * a mixer control may refer to a tlv,
+	 * a widget may refer to a mixer control array,
+	 * a graph may refer to some widgets.
+	 */
+	struct list_head ref_list;
+	struct list_head list; /* list of all elements with same type */
+};
+
+struct map_elem {
+	const char *name;
+	int id;
+};
+
+int tplg_parse_compound(snd_tplg_t *tplg, snd_config_t *cfg,
+	int (*fcn)(snd_tplg_t *, snd_config_t *, void *),
+	void *private);
+
+int tplg_write_data(snd_tplg_t *tplg);
+
+int tplg_parse_tlv(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_text(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_data(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_control_bytes(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_control_enum(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_control_mixer(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_dapm_graph(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_dapm_widget(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_pcm_config(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_pcm_caps(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_pcm_cap_cfg(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private);
+
+int tplg_parse_pcm(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_be(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_cc(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
+int tplg_build_controls(snd_tplg_t *tplg);
+int tplg_build_widgets(snd_tplg_t *tplg);
+int tplg_build_routes(snd_tplg_t *tplg);
+int tplg_build_pcm_dai(snd_tplg_t *tplg, unsigned int type);
+
+int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref);
+
+int tplg_ref_add(struct tplg_elem *elem, int type, const char* id);
+
+struct tplg_elem *tplg_elem_new(void);
+void tplg_elem_free(struct tplg_elem *elem);
+void tplg_elem_free_list(struct list_head *base);
+struct tplg_elem *tplg_elem_lookup(struct list_head *base,
+				const char* id,
+				unsigned int type);
+struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
+	snd_config_t *cfg, enum object_type type);
+
+static inline void elem_copy_text(char *dest, const char *src, int len)
+{
+	strncpy(dest, src, len);
+	dest[len - 1] = 0;
+}
+
+int tplg_parse_channel(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
+	snd_config_t *cfg, void *private);
+
+int tplg_parse_ops(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
+	snd_config_t *cfg, void *private);
+
+struct tplg_elem *lookup_pcm_dai_stream(struct list_head *base,
+	const char* id);
-- 
2.1.4
