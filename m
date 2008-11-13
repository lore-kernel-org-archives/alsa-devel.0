From: Wu Fengguang <wfg@linux.intel.com>
Subject: [RFC][PATCH] ELD routines and proc interface
Date: Thu, 13 Nov 2008 10:21:53 +0800
Message-ID: <1226542918.126598.6912@de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 05DE724394
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 03:22:14 +0100 (CET)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Create hda_eld.c for ELD routines and proc interface.

ELD handling routines can be shared by all HDMI codecs,
and they are large enough to make a standalone source file.

Some notes on the code:

- Shall we show an empty file if the ELD content is not valid?
  Well it's not that simple. There could be partially populated ELD,
  and there may be malformed ELD provided by buggy drivers/monitors.
  So I tend to expose ELD as it is. 

- hdmi_show_eld() and hdmi_print_eld_info() are somehow duplicated
  The plan is to shrink hdmi_show_eld()/hdmi_show_short_audio_desc(), and to
  show a compact message at monitor hotplug and driver initialization time.

- The ELD retrieval routines rely on the Intel HDA interface,
  others are/could be universal and independent ones.

- The ELD proc interface code could be moved to hda_proc.c if necessary.

- How do we name the proc file?
  If there are going to be two HDMI pins per codec, then the current naming
  scheme (eld#<codec no>) will fail.

- The ELD proc file content is designed to be easy for scripts and human reading.
  Its lines all have the pattern:
	  <item_name>\t[\t]*<item_value>
  where <item_name> is a keyword in c language, while <item_value> could be any
  contents, including white spaces. <item_value> could also be a null value.


Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/Kconfig               |    4 
 sound/pci/hda/Makefile          |    1 
 sound/pci/hda/hda_eld.c         |  532 ++++++++++++++++++++++++++++++
 sound/pci/hda/hda_local.h       |   62 ++-
 sound/pci/hda/patch_intelhdmi.c |  484 ---------------------------
 5 files changed, 600 insertions(+), 483 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
@@ -30,7 +30,6 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <sound/core.h>
-#include <asm/unaligned.h>
 #include "hda_codec.h"
 #include "hda_local.h"
 #include "hda_patch.h"
@@ -40,43 +39,6 @@
 
 #define INTEL_HDMI_EVENT_TAG		0x08
 
-/*
- * CEA Short Audio Descriptor data
- */
-struct cea_sad {
-	int	channels;
-	int	format;		/* (format == 0) indicates invalid SAD */
-	int	rates;
-	int	sample_bits;	/* for LPCM */
-	int	max_bitrate;	/* for AC3...ATRAC */
-	int	profile;	/* for WMAPRO */
-};
-
-#define ELD_FIXED_BYTES	20
-#define ELD_MAX_MNL	16
-#define ELD_MAX_SAD	16
-
-/*
- * ELD: EDID Like Data
- */
-struct sink_eld {
-	int	eld_size;
-	int	baseline_len;
-	int	eld_ver;	/* (eld_ver == 0) indicates invalid ELD */
-	int	cea_edid_ver;
-	char	monitor_name[ELD_MAX_MNL + 1];
-	int	manufacture_id;
-	int	product_id;
-	u64	port_id;
-	int	support_hdcp;
-	int	support_ai;
-	int	conn_type;
-	int	aud_synch_delay;
-	int	spk_alloc;
-	int	sad_count;
-	struct cea_sad sad[ELD_MAX_SAD];
-};
-
 struct intel_hdmi_spec {
 	struct hda_multi_out multiout;
 	struct hda_pcm pcm_rec;
@@ -127,160 +89,9 @@ struct hdmi_audio_infoframe {
 };
 
 /*
- * SS1:SS0 index => sample size
- */
-static int cea_sample_sizes[4] = {
-	0,	 		/* 0: Refer to Stream Header */
-	AC_SUPPCM_BITS_16,	/* 1: 16 bits */
-	AC_SUPPCM_BITS_20,	/* 2: 20 bits */
-	AC_SUPPCM_BITS_24,	/* 3: 24 bits */
-};
-
-/*
- * SF2:SF1:SF0 index => sampling frequency
- */
-static int cea_sampling_frequencies[8] = {
-	0,			/* 0: Refer to Stream Header */
-	SNDRV_PCM_RATE_32000,	/* 1:  32000Hz */
-	SNDRV_PCM_RATE_44100,	/* 2:  44100Hz */
-	SNDRV_PCM_RATE_48000,	/* 3:  48000Hz */
-	SNDRV_PCM_RATE_88200,	/* 4:  88200Hz */
-	SNDRV_PCM_RATE_96000,	/* 5:  96000Hz */
-	SNDRV_PCM_RATE_176400,	/* 6: 176400Hz */
-	SNDRV_PCM_RATE_192000,	/* 7: 192000Hz */
-};
-
-enum eld_versions {
-	ELD_VER_CEA_861D	= 2,
-	ELD_VER_PARTIAL		= 31,
-};
-
-static char *eld_versoin_names[32] = {
-	"0-reserved",
-	"1-reserved",
-	"CEA-861D or below",
-	"3-reserved",
-	[4 ... 30] = "reserved",
-	[31] = "partial"
-};
-
-enum cea_edid_versions {
-	CEA_EDID_VER_NONE	= 0,
-	CEA_EDID_VER_CEA861	= 1,
-	CEA_EDID_VER_CEA861A	= 2,
-	CEA_EDID_VER_CEA861BCD	= 3,
-	CEA_EDID_VER_RESERVED	= 4,
-};
-
-static char *cea_edid_version_names[8] = {
-	"no CEA EDID Timing Extension block present",
-	"CEA-861",
-	"CEA-861-A",
-	"CEA-861-B, C or D",
-	"4-reserved",
-	[5 ... 7] = "reserved"
-};
-
-/*
- * CEA Speaker Allocation data block bits
- */
-#define CEA_SA_FLR	(0 << 0)
-#define CEA_SA_LFE	(1 << 1)
-#define CEA_SA_FC	(1 << 2)
-#define CEA_SA_RLR	(1 << 3)
-#define CEA_SA_RC	(1 << 4)
-#define CEA_SA_FLRC	(1 << 5)
-#define CEA_SA_RLRC	(1 << 6)
-/* the following are not defined in ELD yet */
-#define CEA_SA_FLRW	(1 << 7)
-#define CEA_SA_FLRH	(1 << 8)
-#define CEA_SA_TC	(1 << 9)
-#define CEA_SA_FCH	(1 << 10)
-
-static char *cea_speaker_allocation_names[] = {
-	/*  0 */ "FL/FR",
-	/*  1 */ "LFE",
-	/*  2 */ "FC",
-	/*  3 */ "RL/RR",
-	/*  4 */ "RC",
-	/*  5 */ "FLC/FRC",
-	/*  6 */ "RLC/RRC",
-	/*  7 */ "FLW/FRW",
-	/*  8 */ "FLH/FRH",
-	/*  9 */ "TC",
-	/* 10 */ "FCH",
-};
-
-static char *eld_connection_type_names[4] = {
-	"HDMI",
-	"Display Port",
-	"2-reserved",
-	"3-reserved"
-};
-
-enum cea_audio_coding_types {
-	AUDIO_CODING_TYPE_REF_STREAM_HEADER	=  0,
-	AUDIO_CODING_TYPE_LPCM			=  1,
-	AUDIO_CODING_TYPE_AC3			=  2,
-	AUDIO_CODING_TYPE_MPEG1			=  3,
-	AUDIO_CODING_TYPE_MP3			=  4,
-	AUDIO_CODING_TYPE_MPEG2			=  5,
-	AUDIO_CODING_TYPE_AACLC			=  6,
-	AUDIO_CODING_TYPE_DTS			=  7,
-	AUDIO_CODING_TYPE_ATRAC			=  8,
-	AUDIO_CODING_TYPE_SACD			=  9,
-	AUDIO_CODING_TYPE_EAC3			= 10,
-	AUDIO_CODING_TYPE_DTS_HD		= 11,
-	AUDIO_CODING_TYPE_MLP			= 12,
-	AUDIO_CODING_TYPE_DST			= 13,
-	AUDIO_CODING_TYPE_WMAPRO		= 14,
-	AUDIO_CODING_TYPE_REF_CXT		= 15,
-	/* also include valid xtypes below */
-	AUDIO_CODING_TYPE_HE_AAC		= 15,
-	AUDIO_CODING_TYPE_HE_AAC2		= 16,
-	AUDIO_CODING_TYPE_MPEG_SURROUND		= 17,
-};
-
-enum cea_audio_coding_xtypes {
-	AUDIO_CODING_XTYPE_HE_REF_CT		= 0,
-	AUDIO_CODING_XTYPE_HE_AAC		= 1,
-	AUDIO_CODING_XTYPE_HE_AAC2		= 2,
-	AUDIO_CODING_XTYPE_MPEG_SURROUND	= 3,
-	AUDIO_CODING_XTYPE_FIRST_RESERVED	= 4,
-};
-
-static char *cea_audio_coding_type_names[] = {
-	/*  0 */ "undefined",
-	/*  1 */ "LPCM",
-	/*  2 */ "AC-3",
-	/*  3 */ "MPEG1",
-	/*  4 */ "MP3",
-	/*  5 */ "MPEG2",
-	/*  6 */ "AAC-LC",
-	/*  7 */ "DTS",
-	/*  8 */ "ATRAC",
-	/*  9 */ "DSD(1-bit audio)",
-	/* 10 */ "Dolby Digital Plus(E-AC-3/DD+)",
-	/* 11 */ "DTS-HD",
-	/* 12 */ "Dolby TrueHD(MLP)",
-	/* 13 */ "DST",
-	/* 14 */ "WMAPro",
-	/* 15 */ "HE-AAC",
-	/* 16 */ "HE-AACv2",
-	/* 17 */ "MPEG Surround",
-};
-
-
-/*
  * HDMI routines
  */
 
-static int hdmi_get_eld_size(struct hda_codec *codec, hda_nid_t nid)
-{
-	return snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_HDMI_DIP_SIZE,
-						 AC_DIPSIZE_ELD_BUF);
-}
-
 #ifdef BE_PARANOID
 static void hdmi_get_dip_index(struct hda_codec *codec, hda_nid_t nid,
 				int *packet_index, int *byte_index)
@@ -375,294 +186,13 @@ static void hdmi_setup_channel_mapping(s
 }
 
 
-/*
- * ELD(EDID Like Data) routines
- */
-
-static int hdmi_present_sense(struct hda_codec *codec, hda_nid_t nid)
-{
-	return snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_PIN_SENSE, 0);
-}
-
-static void hdmi_debug_present_sense(struct hda_codec *codec)
-{
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-	int eldv;
-	int present;
-
-	present = hdmi_present_sense(codec, PIN_NID);
-	eldv    = (present & AC_PINSENSE_ELDV);
-	present = (present & AC_PINSENSE_PRESENCE);
-
-	printk(KERN_INFO "pinp = %d, eldv = %d\n", !!present, !!eldv);
-#endif
-}
-
-static unsigned char hdmi_get_eld_byte(struct hda_codec *codec, int byte_index)
-{
-	unsigned int val;
-
-	val = snd_hda_codec_read(codec, PIN_NID, 0,
-					AC_VERB_GET_HDMI_ELDD, byte_index);
-
-#ifdef BE_PARANOID
-	printk(KERN_INFO "ELD data byte %d: 0x%x\n", byte_index, val);
-#endif
-
-	if ((val & AC_ELDD_ELD_VALID) == 0) {
-		snd_printd(KERN_INFO "Invalid ELD data byte %d\n",
-								byte_index);
-		val = 0;
-	}
-
-	return val & AC_ELDD_ELD_DATA;
-}
-
-static inline unsigned char grab_bits(const unsigned char *buf,
-						int byte, int lowbit, int bits)
-{
-	BUG_ON(lowbit > 7);
-	BUG_ON(bits > 8);
-	BUG_ON(bits <= 0);
-
-	return (buf[byte] >> lowbit) & ((1 << bits) - 1);
-}
-
-static void hdmi_update_short_audio_desc(struct cea_sad *a,
-					 const unsigned char *buf)
-{
-	int i;
-	int val;
-
-	val = grab_bits(buf, 1, 0, 7);
-	a->rates = 0;
-	for (i = 0; i < 7; i++)
-		if (val & (1 << i))
-			a->rates |= cea_sampling_frequencies[i + 1];
-
-	a->channels = grab_bits(buf, 0, 0, 3);
-	a->channels++;
-
-	a->format = grab_bits(buf, 0, 3, 4);
-	switch (a->format) {
-	case AUDIO_CODING_TYPE_REF_STREAM_HEADER:
-		snd_printd(KERN_INFO
-				"audio coding type 0 not expected in ELD\n");
-		break;
-
-	case AUDIO_CODING_TYPE_LPCM:
-		val = grab_bits(buf, 2, 0, 3);
-		a->sample_bits = 0;
-		for (i = 0; i < 3; i++)
-			if (val & (1 << i))
-				a->sample_bits |= cea_sample_sizes[i + 1];
-		break;
-
-	case AUDIO_CODING_TYPE_AC3:
-	case AUDIO_CODING_TYPE_MPEG1:
-	case AUDIO_CODING_TYPE_MP3:
-	case AUDIO_CODING_TYPE_MPEG2:
-	case AUDIO_CODING_TYPE_AACLC:
-	case AUDIO_CODING_TYPE_DTS:
-	case AUDIO_CODING_TYPE_ATRAC:
-		a->max_bitrate = grab_bits(buf, 2, 0, 8);
-		a->max_bitrate *= 8000;
-		break;
-
-	case AUDIO_CODING_TYPE_SACD:
-		break;
-
-	case AUDIO_CODING_TYPE_EAC3:
-		break;
-
-	case AUDIO_CODING_TYPE_DTS_HD:
-		break;
-
-	case AUDIO_CODING_TYPE_MLP:
-		break;
-
-	case AUDIO_CODING_TYPE_DST:
-		break;
-
-	case AUDIO_CODING_TYPE_WMAPRO:
-		a->profile = grab_bits(buf, 2, 0, 3);
-		break;
-
-	case AUDIO_CODING_TYPE_REF_CXT:
-		a->format = grab_bits(buf, 2, 3, 5);
-		if (a->format == AUDIO_CODING_XTYPE_HE_REF_CT ||
-		    a->format >= AUDIO_CODING_XTYPE_FIRST_RESERVED) {
-			snd_printd(KERN_INFO
-				"audio coding xtype %d not expected in ELD\n",
-				a->format);
-			a->format = 0;
-		} else
-			a->format += AUDIO_CODING_TYPE_HE_AAC -
-				     AUDIO_CODING_XTYPE_HE_AAC;
-		break;
-	}
-}
-
-static int hdmi_update_sink_eld(struct hda_codec *codec,
-				const unsigned char *buf, int size)
-{
-	struct intel_hdmi_spec *spec = codec->spec;
-	struct sink_eld *e = &spec->sink;
-	int mnl;
-	int i;
-
-	e->eld_ver = grab_bits(buf, 0, 3, 5);
-	if (e->eld_ver != ELD_VER_CEA_861D &&
-	    e->eld_ver != ELD_VER_PARTIAL) {
-		snd_printd(KERN_INFO "Unknown ELD version %d\n", e->eld_ver);
-		goto out_fail;
-	}
-
-	e->eld_size = size;
-	e->baseline_len = grab_bits(buf, 2, 0, 8);
-	mnl		= grab_bits(buf, 4, 0, 5);
-	e->cea_edid_ver	= grab_bits(buf, 4, 5, 3);
-
-	e->support_hdcp	= grab_bits(buf, 5, 0, 1);
-	e->support_ai	= grab_bits(buf, 5, 1, 1);
-	e->conn_type	= grab_bits(buf, 5, 2, 2);
-	e->sad_count	= grab_bits(buf, 5, 4, 4);
-
-	e->aud_synch_delay = grab_bits(buf, 6, 0, 8);
-	e->spk_alloc	= grab_bits(buf, 7, 0, 7);
-
-	e->port_id	  = get_unaligned_le64(buf + 8);
-
-	/* not specified, but the spec's tendency is little endian */
-	e->manufacture_id = get_unaligned_le16(buf + 16);
-	e->product_id	  = get_unaligned_le16(buf + 18);
-
-	if (mnl > ELD_MAX_MNL) {
-		snd_printd(KERN_INFO "MNL is reserved value %d\n", mnl);
-		goto out_fail;
-	} else if (ELD_FIXED_BYTES + mnl > size) {
-		snd_printd(KERN_INFO "out of range MNL %d\n", mnl);
-		goto out_fail;
-	} else
-		strlcpy(e->monitor_name, buf + ELD_FIXED_BYTES, mnl);
-
-	for (i = 0; i < e->sad_count; i++) {
-		if (ELD_FIXED_BYTES + mnl + 3 * (i + 1) > size) {
-			snd_printd(KERN_INFO "out of range SAD %d\n", i);
-			goto out_fail;
-		}
-		hdmi_update_short_audio_desc(e->sad + i,
-					buf + ELD_FIXED_BYTES + mnl + 3 * i);
-	}
-
-	return 0;
-
-out_fail:
-	e->eld_ver = 0;
-	return -EINVAL;
-}
-
-static int hdmi_get_eld(struct hda_codec *codec)
-{
-	int i;
-	int ret;
-	int size;
-	unsigned char *buf;
-
-	i = hdmi_present_sense(codec, PIN_NID) & AC_PINSENSE_ELDV;
-	if (!i)
-		return -ENOENT;
-
-	size = hdmi_get_eld_size(codec, PIN_NID);
-	if (size == 0) {
-		/* wfg: workaround for ASUS P5E-VM HDMI board */
-		snd_printd(KERN_INFO "ELD buf size is 0, force 128\n");
-		size = 128;
-	}
-	if (size < ELD_FIXED_BYTES || size > PAGE_SIZE) {
-		snd_printd(KERN_INFO "Invalid ELD buf size %d\n", size);
-		return -ERANGE;
-	}
-
-	buf = kmalloc(size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	for (i = 0; i < size; i++)
-		buf[i] = hdmi_get_eld_byte(codec, i);
-
-	ret = hdmi_update_sink_eld(codec, buf, size);
-
-	kfree(buf);
-	return ret;
-}
-
-static void hdmi_show_short_audio_desc(struct cea_sad *a)
-{
-	printk(KERN_INFO "coding type: %s\n",
-					cea_audio_coding_type_names[a->format]);
-	printk(KERN_INFO "channels: %d\n", a->channels);
-	printk(KERN_INFO "sampling frequencies: 0x%x\n", a->rates);
-
-	if (a->format == AUDIO_CODING_TYPE_LPCM)
-		printk(KERN_INFO "sample bits: 0x%x\n", a->sample_bits);
-
-	if (a->max_bitrate)
-		printk(KERN_INFO "max bitrate: %d HZ\n", a->max_bitrate);
-
-	if (a->profile)
-		printk(KERN_INFO "profile: %d\n", a->profile);
-}
-
-static void hdmi_show_eld(struct hda_codec *codec)
-{
-	int i;
-	int j;
-	struct intel_hdmi_spec *spec = codec->spec;
-	struct sink_eld *e = &spec->sink;
-	char buf[80];
-
-	printk(KERN_INFO "ELD buffer size  is %d\n", e->eld_size);
-	printk(KERN_INFO "ELD baseline len is %d*4\n", e->baseline_len);
-	printk(KERN_INFO "vendor block len is %d\n",
-					e->eld_size - e->baseline_len * 4 - 4);
-	printk(KERN_INFO "ELD version      is %s\n",
-					eld_versoin_names[e->eld_ver]);
-	printk(KERN_INFO "CEA EDID version is %s\n",
-				cea_edid_version_names[e->cea_edid_ver]);
-	printk(KERN_INFO "manufacture id   is 0x%x\n", e->manufacture_id);
-	printk(KERN_INFO "product id       is 0x%x\n", e->product_id);
-	printk(KERN_INFO "port id          is 0x%llx\n", (long long)e->port_id);
-	printk(KERN_INFO "HDCP support     is %d\n", e->support_hdcp);
-	printk(KERN_INFO "AI support       is %d\n", e->support_ai);
-	printk(KERN_INFO "SAD count        is %d\n", e->sad_count);
-	printk(KERN_INFO "audio sync delay is %x\n", e->aud_synch_delay);
-	printk(KERN_INFO "connection type  is %s\n",
-				eld_connection_type_names[e->conn_type]);
-	printk(KERN_INFO "monitor name     is %s\n", e->monitor_name);
-
-	j = 0;
-	for (i = 0; i < ARRAY_SIZE(cea_speaker_allocation_names); i++) {
-		if (e->spk_alloc & (1 << i))
-			j += snprintf(buf + j, sizeof(buf) - j,  " %s",
-					cea_speaker_allocation_names[i]);
-	}
-	buf[j] = '\0'; /* necessary when j == 0 */
-	printk(KERN_INFO "speaker allocations: (0x%x)%s\n", e->spk_alloc, buf);
-
-	for (i = 0; i < e->sad_count; i++)
-		hdmi_show_short_audio_desc(e->sad + i);
-}
-
-/*
- * Be careful, ELD buf could be totally rubbish!
- */
 static void hdmi_parse_eld(struct hda_codec *codec)
 {
-	hdmi_debug_present_sense(codec);
+	struct intel_hdmi_spec *spec = codec->spec;
+	struct sink_eld *eld = &spec->sink;
 
-	if (!hdmi_get_eld(codec))
-		hdmi_show_eld(codec);
+	if (!hdmi_get_eld(eld, codec, PIN_NID))
+		hdmi_show_eld(eld);
 }
 
 
@@ -880,6 +410,11 @@ static int intel_hdmi_build_controls(str
 
 static int intel_hdmi_init(struct hda_codec *codec)
 {
+	struct intel_hdmi_spec *spec = codec->spec;
+	struct sink_eld *eld = &spec->sink;
+
+	snd_hda_eld_proc_new(codec, eld);
+
 	/* disable audio output as early as possible */
 	hdmi_disable_output(codec);
 
@@ -927,3 +462,4 @@ struct hda_codec_preset snd_hda_preset_i
 	{ .id = 0x10951392, .name = "SiI1392 HDMI",     .patch = patch_intel_hdmi },
 	{} /* terminator */
 };
+
--- /dev/null
+++ sound-2.6/sound/pci/hda/hda_eld.c
@@ -0,0 +1,532 @@
+/*
+ * Generic routines and proc interface for ELD(EDID Like Data) information
+ *
+ * Copyright(c) 2008 Intel Corporation.
+ *
+ * Authors:
+ * 		Wu Fengguang <wfg@linux.intel.com>
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
+#include <linux/init.h>
+#include <sound/core.h>
+#include <asm/unaligned.h>
+#include "hda_codec.h"
+#include "hda_local.h"
+
+enum eld_versions {
+	ELD_VER_CEA_861D	= 2,
+	ELD_VER_PARTIAL		= 31,
+};
+
+static char *eld_versoin_names[32] = {
+	"reserved",
+	"reserved",
+	"CEA-861D or below",
+	[3 ... 30] = "reserved",
+	[31] = "partial"
+};
+
+enum cea_edid_versions {
+	CEA_EDID_VER_NONE	= 0,
+	CEA_EDID_VER_CEA861	= 1,
+	CEA_EDID_VER_CEA861A	= 2,
+	CEA_EDID_VER_CEA861BCD	= 3,
+	CEA_EDID_VER_RESERVED	= 4,
+};
+
+static char *cea_edid_version_names[8] = {
+	"no CEA EDID Timing Extension block present",
+	"CEA-861",
+	"CEA-861-A",
+	"CEA-861-B, C or D",
+	[4 ... 7] = "reserved"
+};
+
+/*
+ * CEA Speaker Allocation data block bits
+ */
+#define CEA_SA_FLR	(0 << 0)
+#define CEA_SA_LFE	(1 << 1)
+#define CEA_SA_FC	(1 << 2)
+#define CEA_SA_RLR	(1 << 3)
+#define CEA_SA_RC	(1 << 4)
+#define CEA_SA_FLRC	(1 << 5)
+#define CEA_SA_RLRC	(1 << 6)
+/* the following are not defined in ELD yet */
+#define CEA_SA_FLRW	(1 << 7)
+#define CEA_SA_FLRH	(1 << 8)
+#define CEA_SA_TC	(1 << 9)
+#define CEA_SA_FCH	(1 << 10)
+
+static char *cea_speaker_allocation_names[] = {
+	/*  0 */ "FL/FR",
+	/*  1 */ "LFE",
+	/*  2 */ "FC",
+	/*  3 */ "RL/RR",
+	/*  4 */ "RC",
+	/*  5 */ "FLC/FRC",
+	/*  6 */ "RLC/RRC",
+	/*  7 */ "FLW/FRW",
+	/*  8 */ "FLH/FRH",
+	/*  9 */ "TC",
+	/* 10 */ "FCH",
+};
+
+static char *eld_connection_type_names[4] = {
+	"HDMI",
+	"Display Port",
+	"2-reserved",
+	"3-reserved"
+};
+
+enum cea_audio_coding_types {
+	AUDIO_CODING_TYPE_REF_STREAM_HEADER	=  0,
+	AUDIO_CODING_TYPE_LPCM			=  1,
+	AUDIO_CODING_TYPE_AC3			=  2,
+	AUDIO_CODING_TYPE_MPEG1			=  3,
+	AUDIO_CODING_TYPE_MP3			=  4,
+	AUDIO_CODING_TYPE_MPEG2			=  5,
+	AUDIO_CODING_TYPE_AACLC			=  6,
+	AUDIO_CODING_TYPE_DTS			=  7,
+	AUDIO_CODING_TYPE_ATRAC			=  8,
+	AUDIO_CODING_TYPE_SACD			=  9,
+	AUDIO_CODING_TYPE_EAC3			= 10,
+	AUDIO_CODING_TYPE_DTS_HD		= 11,
+	AUDIO_CODING_TYPE_MLP			= 12,
+	AUDIO_CODING_TYPE_DST			= 13,
+	AUDIO_CODING_TYPE_WMAPRO		= 14,
+	AUDIO_CODING_TYPE_REF_CXT		= 15,
+	/* also include valid xtypes below */
+	AUDIO_CODING_TYPE_HE_AAC		= 15,
+	AUDIO_CODING_TYPE_HE_AAC2		= 16,
+	AUDIO_CODING_TYPE_MPEG_SURROUND		= 17,
+};
+
+enum cea_audio_coding_xtypes {
+	AUDIO_CODING_XTYPE_HE_REF_CT		= 0,
+	AUDIO_CODING_XTYPE_HE_AAC		= 1,
+	AUDIO_CODING_XTYPE_HE_AAC2		= 2,
+	AUDIO_CODING_XTYPE_MPEG_SURROUND	= 3,
+	AUDIO_CODING_XTYPE_FIRST_RESERVED	= 4,
+};
+
+static char *cea_audio_coding_type_names[] = {
+	/*  0 */ "undefined",
+	/*  1 */ "LPCM",
+	/*  2 */ "AC-3",
+	/*  3 */ "MPEG1",
+	/*  4 */ "MP3",
+	/*  5 */ "MPEG2",
+	/*  6 */ "AAC-LC",
+	/*  7 */ "DTS",
+	/*  8 */ "ATRAC",
+	/*  9 */ "DSD(1-bit audio)",
+	/* 10 */ "Dolby Digital Plus(E-AC-3/DD+)",
+	/* 11 */ "DTS-HD",
+	/* 12 */ "Dolby TrueHD(MLP)",
+	/* 13 */ "DST",
+	/* 14 */ "WMAPro",
+	/* 15 */ "HE-AAC",
+	/* 16 */ "HE-AACv2",
+	/* 17 */ "MPEG Surround",
+};
+
+/*
+ * The following two lists are shared between
+ * 	- HDMI audio infoframe (source to sink)
+ * 	- CEA E-EDID extension (sink to source)
+ */
+
+/*
+ * SS1:SS0 index => sample size
+ */
+static int cea_sample_sizes[4] = {
+	0,	 		/* 0: Refer to Stream Header */
+	AC_SUPPCM_BITS_16,	/* 1: 16 bits */
+	AC_SUPPCM_BITS_20,	/* 2: 20 bits */
+	AC_SUPPCM_BITS_24,	/* 3: 24 bits */
+};
+
+/*
+ * SF2:SF1:SF0 index => sampling frequency
+ */
+static int cea_sampling_frequencies[8] = {
+	0,			/* 0: Refer to Stream Header */
+	SNDRV_PCM_RATE_32000,	/* 1:  32000Hz */
+	SNDRV_PCM_RATE_44100,	/* 2:  44100Hz */
+	SNDRV_PCM_RATE_48000,	/* 3:  48000Hz */
+	SNDRV_PCM_RATE_88200,	/* 4:  88200Hz */
+	SNDRV_PCM_RATE_96000,	/* 5:  96000Hz */
+	SNDRV_PCM_RATE_176400,	/* 6: 176400Hz */
+	SNDRV_PCM_RATE_192000,	/* 7: 192000Hz */
+};
+
+static unsigned char hdmi_get_eld_byte(struct hda_codec *codec, hda_nid_t nid,
+					int byte_index)
+{
+	unsigned int val;
+
+	val = snd_hda_codec_read(codec, nid, 0,
+					AC_VERB_GET_HDMI_ELDD, byte_index);
+
+#ifdef BE_PARANOID
+	printk(KERN_INFO "ELD data byte %d: 0x%x\n", byte_index, val);
+#endif
+
+	if ((val & AC_ELDD_ELD_VALID) == 0) {
+		snd_printd(KERN_INFO "Invalid ELD data byte %d\n",
+								byte_index);
+		val = 0;
+	}
+
+	return val & AC_ELDD_ELD_DATA;
+}
+
+static inline unsigned char grab_bits(const unsigned char *buf,
+						int byte, int lowbit, int bits)
+{
+	BUG_ON(lowbit > 7);
+	BUG_ON(bits > 8);
+	BUG_ON(bits <= 0);
+
+	return (buf[byte] >> lowbit) & ((1 << bits) - 1);
+}
+
+static void hdmi_update_short_audio_desc(struct cea_sad *a,
+					 const unsigned char *buf)
+{
+	int i;
+	int val;
+
+	val = grab_bits(buf, 1, 0, 7);
+	a->rates = 0;
+	for (i = 0; i < 7; i++)
+		if (val & (1 << i))
+			a->rates |= cea_sampling_frequencies[i + 1];
+
+	a->channels = grab_bits(buf, 0, 0, 3);
+	a->channels++;
+
+	a->format = grab_bits(buf, 0, 3, 4);
+	switch (a->format) {
+	case AUDIO_CODING_TYPE_REF_STREAM_HEADER:
+		snd_printd(KERN_INFO
+				"audio coding type 0 not expected in ELD\n");
+		break;
+
+	case AUDIO_CODING_TYPE_LPCM:
+		val = grab_bits(buf, 2, 0, 3);
+		a->sample_bits = 0;
+		for (i = 0; i < 3; i++)
+			if (val & (1 << i))
+				a->sample_bits |= cea_sample_sizes[i + 1];
+		break;
+
+	case AUDIO_CODING_TYPE_AC3:
+	case AUDIO_CODING_TYPE_MPEG1:
+	case AUDIO_CODING_TYPE_MP3:
+	case AUDIO_CODING_TYPE_MPEG2:
+	case AUDIO_CODING_TYPE_AACLC:
+	case AUDIO_CODING_TYPE_DTS:
+	case AUDIO_CODING_TYPE_ATRAC:
+		a->max_bitrate = grab_bits(buf, 2, 0, 8);
+		a->max_bitrate *= 8000;
+		break;
+
+	case AUDIO_CODING_TYPE_SACD:
+		break;
+
+	case AUDIO_CODING_TYPE_EAC3:
+		break;
+
+	case AUDIO_CODING_TYPE_DTS_HD:
+		break;
+
+	case AUDIO_CODING_TYPE_MLP:
+		break;
+
+	case AUDIO_CODING_TYPE_DST:
+		break;
+
+	case AUDIO_CODING_TYPE_WMAPRO:
+		a->profile = grab_bits(buf, 2, 0, 3);
+		break;
+
+	case AUDIO_CODING_TYPE_REF_CXT:
+		a->format = grab_bits(buf, 2, 3, 5);
+		if (a->format == AUDIO_CODING_XTYPE_HE_REF_CT ||
+		    a->format >= AUDIO_CODING_XTYPE_FIRST_RESERVED) {
+			snd_printd(KERN_INFO
+				"audio coding xtype %d not expected in ELD\n",
+				a->format);
+			a->format = 0;
+		} else
+			a->format += AUDIO_CODING_TYPE_HE_AAC -
+				     AUDIO_CODING_XTYPE_HE_AAC;
+		break;
+	}
+}
+
+/*
+ * Be careful, ELD buf could be totally rubbish!
+ */
+static int hdmi_update_sink_eld(struct sink_eld *e,
+				const unsigned char *buf, int size)
+{
+	int mnl;
+	int i;
+
+	e->eld_ver = grab_bits(buf, 0, 3, 5);
+	if (e->eld_ver != ELD_VER_CEA_861D &&
+	    e->eld_ver != ELD_VER_PARTIAL) {
+		snd_printd(KERN_INFO "Unknown ELD version %d\n", e->eld_ver);
+		goto out_fail;
+	}
+
+	e->eld_size = size;
+	e->baseline_len = grab_bits(buf, 2, 0, 8);
+	mnl		= grab_bits(buf, 4, 0, 5);
+	e->cea_edid_ver	= grab_bits(buf, 4, 5, 3);
+
+	e->support_hdcp	= grab_bits(buf, 5, 0, 1);
+	e->support_ai	= grab_bits(buf, 5, 1, 1);
+	e->conn_type	= grab_bits(buf, 5, 2, 2);
+	e->sad_count	= grab_bits(buf, 5, 4, 4);
+
+	e->aud_synch_delay = grab_bits(buf, 6, 0, 8) * 2;
+	e->spk_alloc	= grab_bits(buf, 7, 0, 7);
+
+	e->port_id	  = get_unaligned_le64(buf + 8);
+
+	/* not specified, but the spec's tendency is little endian */
+	e->manufacture_id = get_unaligned_le16(buf + 16);
+	e->product_id	  = get_unaligned_le16(buf + 18);
+
+	if (mnl > ELD_MAX_MNL) {
+		snd_printd(KERN_INFO "MNL is reserved value %d\n", mnl);
+		goto out_fail;
+	} else if (ELD_FIXED_BYTES + mnl > size) {
+		snd_printd(KERN_INFO "out of range MNL %d\n", mnl);
+		goto out_fail;
+	} else
+		strlcpy(e->monitor_name, buf + ELD_FIXED_BYTES, mnl);
+
+	for (i = 0; i < e->sad_count; i++) {
+		if (ELD_FIXED_BYTES + mnl + 3 * (i + 1) > size) {
+			snd_printd(KERN_INFO "out of range SAD %d\n", i);
+			goto out_fail;
+		}
+		hdmi_update_short_audio_desc(e->sad + i,
+					buf + ELD_FIXED_BYTES + mnl + 3 * i);
+	}
+
+	return 0;
+
+out_fail:
+	e->eld_ver = 0;
+	return -EINVAL;
+}
+
+static int hdmi_present_sense(struct hda_codec *codec, hda_nid_t nid)
+{
+	return snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_PIN_SENSE, 0);
+}
+
+static int hdmi_eld_valid(struct hda_codec *codec, hda_nid_t nid)
+{
+	int eldv;
+	int present;
+
+	present = hdmi_present_sense(codec, nid);
+	eldv    = (present & AC_PINSENSE_ELDV);
+	present = (present & AC_PINSENSE_PRESENCE);
+
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+	printk(KERN_INFO "pinp = %d, eldv = %d\n", !!present, !!eldv);
+#endif
+
+	return eldv && present;
+}
+
+int hdmi_get_eld_size(struct hda_codec *codec, hda_nid_t nid)
+{
+	return snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_HDMI_DIP_SIZE,
+						 AC_DIPSIZE_ELD_BUF);
+}
+
+int hdmi_get_eld(struct sink_eld *eld,
+		 struct hda_codec *codec, hda_nid_t nid)
+{
+	int i;
+	int ret;
+	int size;
+	unsigned char *buf;
+
+	if (!hdmi_eld_valid(codec, nid))
+		return -ENOENT;
+
+	size = hdmi_get_eld_size(codec, nid);
+	if (size == 0) {
+		/* wfg: workaround for ASUS P5E-VM HDMI board */
+		snd_printd(KERN_INFO "ELD buf size is 0, force 128\n");
+		size = 128;
+	}
+	if (size < ELD_FIXED_BYTES || size > PAGE_SIZE) {
+		snd_printd(KERN_INFO "Invalid ELD buf size %d\n", size);
+		return -ERANGE;
+	}
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	for (i = 0; i < size; i++)
+		buf[i] = hdmi_get_eld_byte(codec, nid, i);
+
+	ret = hdmi_update_sink_eld(eld, buf, size);
+
+	kfree(buf);
+	return ret;
+}
+
+static void hdmi_show_short_audio_desc(struct cea_sad *a)
+{
+	printk(KERN_INFO "coding type: %s\n",
+					cea_audio_coding_type_names[a->format]);
+	printk(KERN_INFO "channels: %d\n", a->channels);
+	printk(KERN_INFO "sampling frequencies: 0x%x\n", a->rates);
+
+	if (a->format == AUDIO_CODING_TYPE_LPCM)
+		printk(KERN_INFO "sample bits: 0x%x\n", a->sample_bits);
+
+	if (a->max_bitrate)
+		printk(KERN_INFO "max bitrate: %d HZ\n", a->max_bitrate);
+
+	if (a->profile)
+		printk(KERN_INFO "profile: %d\n", a->profile);
+}
+
+static void hdmi_print_speaker_allocations(int spk_alloc, char *buf, int buflen)
+{
+	int i, j;
+
+	for (i = 0, j = 0; i < ARRAY_SIZE(cea_speaker_allocation_names); i++) {
+		if (spk_alloc & (1 << i))
+			j += snprintf(buf + j, buflen - j,  " %s",
+					cea_speaker_allocation_names[i]);
+	}
+	buf[j] = '\0'; /* necessary when j == 0 */
+}
+
+void hdmi_show_eld(struct sink_eld *e)
+{
+	int i;
+	char buf[80];
+
+	printk(KERN_INFO "ELD buffer size  is %d\n", e->eld_size);
+	printk(KERN_INFO "ELD baseline len is %d*4\n", e->baseline_len);
+	printk(KERN_INFO "vendor block len is %d\n",
+					e->eld_size - e->baseline_len * 4 - 4);
+	printk(KERN_INFO "ELD version      is %s\n",
+					eld_versoin_names[e->eld_ver]);
+	printk(KERN_INFO "CEA EDID version is %s\n",
+				cea_edid_version_names[e->cea_edid_ver]);
+	printk(KERN_INFO "manufacture id   is 0x%x\n", e->manufacture_id);
+	printk(KERN_INFO "product id       is 0x%x\n", e->product_id);
+	printk(KERN_INFO "port id          is 0x%llx\n", (long long)e->port_id);
+	printk(KERN_INFO "HDCP support     is %d\n", e->support_hdcp);
+	printk(KERN_INFO "AI support       is %d\n", e->support_ai);
+	printk(KERN_INFO "SAD count        is %d\n", e->sad_count);
+	printk(KERN_INFO "audio sync delay is %x\n", e->aud_synch_delay);
+	printk(KERN_INFO "connection type  is %s\n",
+				eld_connection_type_names[e->conn_type]);
+	printk(KERN_INFO "monitor name     is %s\n", e->monitor_name);
+
+	hdmi_print_speaker_allocations(e->spk_alloc, buf, sizeof(buf));
+	printk(KERN_INFO "speaker allocations: (0x%x)%s\n", e->spk_alloc, buf);
+
+	for (i = 0; i < e->sad_count; i++)
+		hdmi_show_short_audio_desc(e->sad + i);
+}
+
+#ifdef CONFIG_PROC_FS
+
+static void hdmi_print_sad_info(int i, struct cea_sad *a,
+				struct snd_info_buffer *buffer)
+{
+	snd_iprintf(buffer, "sad%d_coding_type\t%s\n",
+			i, cea_audio_coding_type_names[a->format]);
+	snd_iprintf(buffer, "sad%d_channels\t\t%d\n", i, a->channels);
+	snd_iprintf(buffer, "sad%d_sampling_rates\t0x%x\n", i, a->rates);
+
+	if (a->format == AUDIO_CODING_TYPE_LPCM)
+		snd_iprintf(buffer, "sad%d_sample_bits\t0x%x\n", i, a->sample_bits);
+
+	if (a->max_bitrate)
+		snd_iprintf(buffer, "sad%d_max_bitrate\t%d HZ\n",
+							i, a->max_bitrate);
+
+	if (a->profile)
+		snd_iprintf(buffer, "sad%d_profile\t\t%d\n", i, a->profile);
+}
+
+static void hdmi_print_eld_info(struct snd_info_entry *entry,
+				struct snd_info_buffer *buffer)
+{
+	struct sink_eld *e = entry->private_data;
+	char buf[80];
+	int i;
+
+	snd_iprintf(buffer, "monitor name\t\t%s\n", e->monitor_name);
+	snd_iprintf(buffer, "connection_type\t\t%s\n",
+				eld_connection_type_names[e->conn_type]);
+	snd_iprintf(buffer, "eld_version\t\t%d:%s\n", e->eld_ver,
+					eld_versoin_names[e->eld_ver]);
+	snd_iprintf(buffer, "edid_version\t\t%d:%s\n", e->cea_edid_ver,
+				cea_edid_version_names[e->cea_edid_ver]);
+	snd_iprintf(buffer, "manufacture_id\t\t0x%x\n", e->manufacture_id);
+	snd_iprintf(buffer, "product_id\t\t0x%x\n", e->product_id);
+	snd_iprintf(buffer, "port_id\t\t\t0x%llx\n", (long long)e->port_id);
+	snd_iprintf(buffer, "support_hdcp\t\t%d\n", e->support_hdcp);
+	snd_iprintf(buffer, "support_ai\t\t%d\n", e->support_ai);
+	snd_iprintf(buffer, "audio_sync_delay\t%d ms\n", e->aud_synch_delay);
+
+	hdmi_print_speaker_allocations(e->spk_alloc, buf, sizeof(buf));
+	snd_iprintf(buffer, "speakers\t\t%s\n", buf);
+
+	snd_iprintf(buffer, "sad_count\t\t%d\n", e->sad_count);
+
+	for (i = 0; i < e->sad_count; i++)
+		hdmi_print_sad_info(i, e->sad + i, buffer);
+}
+
+int snd_hda_eld_proc_new(struct hda_codec *codec, struct sink_eld *eld)
+{
+	char name[32];
+	struct snd_info_entry *entry;
+	int err;
+
+	snprintf(name, sizeof(name), "eld#%d", codec->addr);
+	err = snd_card_proc_new(codec->bus->card, name, &entry);
+	if (err < 0)
+		return err;
+
+	snd_info_set_text_ops(entry, eld, hdmi_print_eld_info);
+	return 0;
+}
+
+#endif
--- sound-2.6.orig/sound/pci/Kconfig
+++ sound-2.6/sound/pci/Kconfig
@@ -582,6 +582,10 @@ config SND_HDA_CODEC_INTELHDMI
 	  Say Y here to include INTEL HDMI HD-audio codec support in
 	  snd-hda-intel driver, such as Eaglelake integrated HDMI.
 
+config SND_HDA_ELD
+	def_bool y
+	depends on SND_HDA_CODEC_INTELHDMI
+
 config SND_HDA_CODEC_CONEXANT
 	bool "Build Conexant HD-audio codec support"
 	depends on SND_HDA_INTEL
--- sound-2.6.orig/sound/pci/hda/Makefile
+++ sound-2.6/sound/pci/hda/Makefile
@@ -4,6 +4,7 @@ snd-hda-intel-y := hda_intel.o
 # designed to be individual modules
 snd-hda-intel-y += hda_codec.o
 snd-hda-intel-$(CONFIG_PROC_FS) += hda_proc.o
+snd-hda-intel-$(CONFIG_SND_HDA_ELD) += hda_eld.o
 snd-hda-intel-$(CONFIG_SND_HDA_HWDEP) += hda_hwdep.o
 snd-hda-intel-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
 snd-hda-intel-$(CONFIG_SND_HDA_GENERIC) += hda_generic.o
--- sound-2.6.orig/sound/pci/hda/hda_local.h
+++ sound-2.6/sound/pci/hda/hda_local.h
@@ -276,15 +276,6 @@ static inline int snd_hda_parse_generic_
 #endif
 
 /*
- * generic proc interface
- */
-#ifdef CONFIG_PROC_FS
-int snd_hda_codec_proc_new(struct hda_codec *codec);
-#else
-static inline int snd_hda_codec_proc_new(struct hda_codec *codec) { return 0; }
-#endif
-
-/*
  * Misc
  */
 int snd_hda_check_board_config(struct hda_codec *codec, int num_configs,
@@ -440,4 +431,57 @@ int snd_hda_check_amp_list_power(struct 
 #define get_amp_direction(kc)	(((kc)->private_value >> 18) & 0x1)
 #define get_amp_index(kc)	(((kc)->private_value >> 19) & 0xf)
 
+/*
+ * CEA Short Audio Descriptor data
+ */
+struct cea_sad {
+	int	channels;
+	int	format;		/* (format == 0) indicates invalid SAD */
+	int	rates;
+	int	sample_bits;	/* for LPCM */
+	int	max_bitrate;	/* for AC3...ATRAC */
+	int	profile;	/* for WMAPRO */
+};
+
+#define ELD_FIXED_BYTES	20
+#define ELD_MAX_MNL	16
+#define ELD_MAX_SAD	16
+
+/*
+ * ELD: EDID Like Data
+ */
+struct sink_eld {
+	int	eld_size;
+	int	baseline_len;
+	int	eld_ver;	/* (eld_ver == 0) indicates invalid ELD */
+	int	cea_edid_ver;
+	char	monitor_name[ELD_MAX_MNL + 1];
+	int	manufacture_id;
+	int	product_id;
+	u64	port_id;
+	int	support_hdcp;
+	int	support_ai;
+	int	conn_type;
+	int	aud_synch_delay;
+	int	spk_alloc;
+	int	sad_count;
+	struct cea_sad sad[ELD_MAX_SAD];
+};
+
+int hdmi_get_eld_size(struct hda_codec *codec, hda_nid_t nid);
+int hdmi_get_eld(struct sink_eld *eld, struct hda_codec *codec, hda_nid_t nid);
+void hdmi_show_eld(struct sink_eld *eld);
+
+/*
+ * generic proc interface
+ */
+#ifdef CONFIG_PROC_FS
+int snd_hda_codec_proc_new(struct hda_codec *codec);
+int snd_hda_eld_proc_new(struct hda_codec *codec, struct sink_eld *eld);
+#else
+static inline int snd_hda_codec_proc_new(struct hda_codec *codec) { return 0; }
+static inline int snd_hda_eld_proc_new(struct hda_codec *codec,
+					struct sink_eld *eld) { return 0; }
+#endif
+
 #endif /* __SOUND_HDA_LOCAL_H */
