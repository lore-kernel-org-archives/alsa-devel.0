From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [ANNOUNCE] patch for INTEL HDMI codec
Date: Tue, 28 Oct 2008 16:07:39 +0800
Message-ID: <1225181260.867710.21503@de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id F2AB41037FA
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 09:07:43 +0100 (CET)
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
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

We have recently enabled sound output for Intel HDMI codecs,
and would like to share the good news and some early code :-)

The audio enabling code includes both ALSA and X.Org patches.
Attached is one single patch against today's sound-2.6 tree.
It contains very basic code for handling
        - audio infoframe
        - ELD(E-EDID Like Data)
        - unsolicited response

The patch is full enough to produce stereo sound via HDMI.
But it still lacks features and contains many 'defined but unused' staffs.

It was tested OK on ASUS P5E-VM board and HP 2230s notebook.
It _should_ also work on Intel DG45ID board.

Takashi, I can prepare a trimmed-down patch series, in doing so I'd like
to know if you are interested in the basic DIP/ELD/UNSOL routines?
Or should I only submit bare code comparable to the current patch_atihdmi.c?

Thank you,
Fengguang
---

PS: the patch can now produce the following ELD information:

[10340.656719] eldv = 1, pinp = 1
[10340.660711] ELD buffer size  is 64
[10340.660716] ELD baseline len is 10*4
[10340.660720] vendor block len is 20
[10340.660724] ELD version      is CEA-861D or below
[10340.660728] CEA-EDID version is CEA-861-B, C or D
[10340.660732] manufacture name is 0x4544
[10340.660736] product code     is 0xa02c
[10340.660740] port id          is 0x0
[10340.660743] HDCP support     is 0
[10340.660747] AI support       is 0
[10340.660751] SAD count        is 0
[10340.660754] audio sync delay is 0
[10340.660758] connection type  is HDMI
[10340.660763] speaker allocations:
[10340.660766] monitor name     is DELL 2408WFP


--dDRMvlgZJXvWKvBx
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="alsa-intelhdmi.patch"

--- sound-2.6.orig/sound/pci/hda/hda_patch.h
+++ sound-2.6/sound/pci/hda/hda_patch.h
@@ -20,3 +20,5 @@ extern struct hda_codec_preset snd_hda_p
 extern struct hda_codec_preset snd_hda_preset_via[];
 /* NVIDIA HDMI codecs */
 extern struct hda_codec_preset snd_hda_preset_nvhdmi[];
+/* INTEL HDMI codecs */
+extern struct hda_codec_preset snd_hda_preset_intelhdmi[];
--- sound-2.6.orig/sound/pci/hda/Makefile
+++ sound-2.6/sound/pci/hda/Makefile
@@ -16,5 +16,6 @@ snd-hda-intel-$(CONFIG_SND_HDA_CODEC_ATI
 snd-hda-intel-$(CONFIG_SND_HDA_CODEC_CONEXANT) += patch_conexant.o
 snd-hda-intel-$(CONFIG_SND_HDA_CODEC_VIA) += patch_via.o
 snd-hda-intel-$(CONFIG_SND_HDA_CODEC_NVHDMI) += patch_nvhdmi.o
+snd-hda-intel-$(CONFIG_SND_HDA_CODEC_INTELHDMI) += patch_intelhdmi.o
 
 obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-intel.o
--- sound-2.6.orig/sound/pci/Kconfig
+++ sound-2.6/sound/pci/Kconfig
@@ -574,6 +574,14 @@ config SND_HDA_CODEC_NVHDMI
 	  Say Y here to include NVIDIA HDMI HD-audio codec support in
 	  snd-hda-intel driver, such as NVIDIA MCP78 HDMI.
 
+config SND_HDA_CODEC_INTELHDMI
+	bool "Build INTEL HDMI HD-audio codec support"
+	depends on SND_HDA_INTEL
+	default y
+	help
+	  Say Y here to include INTEL HDMI HD-audio codec support in
+	  snd-hda-intel driver, such as Eaglelake integrated HDMI.
+
 config SND_HDA_CODEC_CONEXANT
 	bool "Build Conexant HD-audio codec support"
 	depends on SND_HDA_INTEL
--- sound-2.6.orig/sound/pci/hda/hda_codec.c
+++ sound-2.6/sound/pci/hda/hda_codec.c
@@ -97,6 +97,9 @@ static const struct hda_codec_preset *hd
 #ifdef CONFIG_SND_HDA_CODEC_NVHDMI
 	snd_hda_preset_nvhdmi,
 #endif
+#ifdef CONFIG_SND_HDA_CODEC_INTELHDMI
+	snd_hda_preset_intelhdmi,
+#endif
 	NULL
 };
 
--- /dev/null
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
@@ -0,0 +1,930 @@
+/*
+ *
+ *  patch_intelhdmi.c - Patch for Intel HDMI and Display Port codecs
+ *
+ *  Copyright(c) 2008 Intel Corporation. All rights reserved.
+ *
+ *  Authors:
+ *  			Jiang Zhe <zhe.jiang@intel.com>
+ *  			Wu Fengguang <wfg@linux.intel.com>
+ *
+ *  Maintained by:
+ *  			Wu Fengguang <wfg@linux.intel.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the Free
+ *  Software Foundation; either version 2 of the License, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ *  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software Foundation,
+ *  Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include "hda_codec.h"
+#include "hda_local.h"
+#include "hda_patch.h"
+
+#define CVT_NID		0x02	/* audio converter */
+#define PIN_NID		0x03	/* HDMI output pin */
+
+#define INTEL_HDMI_EVENT_TAG		0x01
+
+struct intel_hdmi_spec {
+	struct hda_multi_out multiout;
+	struct hda_pcm pcm_rec;
+};
+
+static struct hda_verb pinout_enable_verb[] = {
+	{PIN_NID, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{} /* terminator */
+};
+
+static struct hda_verb pinout_disable_verb[] = {
+	{PIN_NID, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00},
+	{}
+};
+
+static struct hda_verb unsolicited_response_verb[] = {
+	{PIN_NID, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN |
+						  INTEL_HDMI_EVENT_TAG},
+	{}
+};
+
+static struct hda_verb def_chan_map[] = {
+	{CVT_NID, AC_VERB_SET_HDMI_CHAN_SLOT, 0x00},
+	{CVT_NID, AC_VERB_SET_HDMI_CHAN_SLOT, 0x11},
+	{CVT_NID, AC_VERB_SET_HDMI_CHAN_SLOT, 0x22},
+	{CVT_NID, AC_VERB_SET_HDMI_CHAN_SLOT, 0x33},
+	{CVT_NID, AC_VERB_SET_HDMI_CHAN_SLOT, 0x44},
+	{CVT_NID, AC_VERB_SET_HDMI_CHAN_SLOT, 0x55},
+	{CVT_NID, AC_VERB_SET_HDMI_CHAN_SLOT, 0x66},
+	{CVT_NID, AC_VERB_SET_HDMI_CHAN_SLOT, 0x77},
+	{}
+};
+
+struct ELD_fixed_fields {
+	__u8 rsv_0		:3;
+	__u8 ELD_ver		:5;
+	__u8 rsv_1;
+	__u8 baseline_ELD_len;
+	__u8 rsv_3;
+
+	/* byte 4 */
+	__u8 MNL		:5;
+	__u8 CEA_EDID_ver	:3;
+
+	/* byte 5 */
+	__u8 HDCP		:1;
+	__u8 S_AI		:1;
+	__u8 conn_type		:2;
+	__u8 SAD_count		:4;
+
+	/* byte 6 */
+	__u8 aud_synch_delay;
+
+	/* byte 7 */
+	__u8 FLR		:1;
+	__u8 LFE		:1;
+	__u8 FC 		:1;
+	__u8 RLR		:1;
+	__u8 RC 		:1;
+	__u8 FLRC		:1;
+	__u8 RLRC		:1;
+	__u8 rsv_7		:1;
+
+	/* byte 8-15 */
+	__le64 port_id; /* little endian */
+
+	/* byte 16-17 */
+	__u16 manufacture_name;
+	/* byte 18-19 */
+	__u16 product_code;
+
+	/* byte 20 len MNL */
+	char monitor_name[0];
+} __attribute__ ((packed));
+
+static char *ELD_ELD_ver[32] = {
+	"0-reserved",
+	"1-reserved",
+	"CEA-861D or below",
+	"3-reserved",
+	[4 ... 30] = "reserved",
+	[31] = "partial"
+};
+
+static char *ELD_CEA_EDID_ver[8] = {
+	"no CEA EDID Timing Extension block present",
+	"CEA-861",
+	"CEA-861-A",
+	"CEA-861-B, C or D",
+	"4-reserved",
+	[5 ... 7] = "reserved"
+};
+
+static char *ELD_speaker_allocations[8] = {
+	/* 0 */ "",
+	/* 1 */ " FLR",
+	/* 2 */ " LFE",
+	/* 3 */ " FC",
+	/* 4 */ " RLR",
+	/* 5 */ " RC",
+	/* 6 */ " FLRC",
+	/* 7 */ " RLRC",
+};
+
+static char *ELD_conn_type[4] = {
+	"HDMI",
+	"Display Port",
+	"2-reserved",
+	"3-reserved"
+};
+
+struct ELD_SAD {
+	__u8	channels:3;
+	__u8	format	:4;
+	__u8	f17	:1;
+	__u8	rates	:7;
+	__u8	f27	:1;
+	__u8	ext;
+} __attribute__ ((packed));
+
+
+struct hdmi_audio_infoframe {
+	__u8 type; /* 0x84 */
+	__u8 ver;  /* 0x01 */
+	__u8 len;  /* 0x0a */
+
+	__u8 checksum;		/* PB0 */
+
+	__u8 CC		:3;
+	__u8 f13	:1;
+	__u8 CT		:4;
+
+	__u8 SSx	:2;
+	__u8 SF		:3;
+	__u8 reserved2	:3;
+
+	__u8 CXT	:5;
+	__u8 reserved3	:3;
+
+	__u8 CA;
+
+	__u8 LFEPBL	:2;
+	__u8 f52	:1;
+	__u8 LSV	:4;
+	__u8 DM_INH	:1;
+
+	__u8 reserved[5];	/* PB6  - PB10 */
+};
+
+/*
+ * SS1:SS0 index to sample size
+ */
+static int ai_sample_sizes[4] = {
+	0,  /* Refer to Stream Header */
+	16,
+	20,
+	24
+};
+
+/*
+ * SF2:SF1:SF0 index to sampling frequency
+ */
+static int ai_sampling_frequencies[8] = {
+	0,                     /* 0: Refer to Stream Header */
+	SNDRV_PCM_RATE_32000,  /* 1: 32000Hz */
+	SNDRV_PCM_RATE_44100,  /* 2: 44100Hz */
+	SNDRV_PCM_RATE_48000,  /* 3: 48000Hz */
+	SNDRV_PCM_RATE_88200,  /* 4: 88200Hz */
+	SNDRV_PCM_RATE_96000,  /* 5: 96000Hz */
+	SNDRV_PCM_RATE_176400, /* 6: 176400Hz */
+	SNDRV_PCM_RATE_192000, /* 7: 192000Hz */
+};
+
+/*
+ * Speaker placement:
+ *
+ *        FLH       FCH        FRH
+ *  FLW    FL  FLC   FC   FRC   FR   FRW
+ *
+ *                                  LFE
+ *                     TC
+ *
+ *          RL  RLC   RC   RRC   RR
+ */
+enum ai_speaker_placement {
+	FL  = 1,	/* Front Left           */
+	FC  = 2,	/* Front Center         */
+	FR  = 3,	/* Front Right          */
+	FLC = 4,	/* Front Left Center    */
+	FRC = 5,	/* Front Right Center   */
+	RL  = 6,	/* Rear Left            */
+	RC  = 7,	/* Rear Center          */
+	RR  = 8,	/* Rear Right           */
+	RLC = 9,	/* Rear Left Center     */
+	RRC = 10,	/* Rear Right Center    */
+	LFE = 11,	/* Low Frequency Effect */
+	FLW = 12,	/* Front Left Wide      */
+	FRW = 13,	/* Front Right Wide     */
+	FLH = 14,	/* Front Left High      */
+	FCH = 15,	/* Front Center High    */
+	FRH = 16,	/* Front Right High     */
+	TC  = 17,	/* Top Center           */
+};
+
+struct ai_channel_speaker_allocation {
+	unsigned char CA;
+	unsigned char speakers[8];
+};
+
+static struct ai_channel_speaker_allocation ai_ca_mapping[] = {
+/* channel number:   8      7     6     5     4      3     2     1 */
+	{ 0x00,  {   0,     0,    0,    0,    0,     0,   FR,   FL }},
+	{ 0x01,  {   0,     0,    0,    0,    0,   LFE,   FR,   FL }},
+	{ 0x02,  {   0,     0,    0,    0,   FC,     0,   FR,   FL }},
+	{ 0x03,  {   0,     0,    0,    0,   FC,   LFE,   FR,   FL }},
+	{ 0x04,  {   0,     0,    0,   RC,    0,     0,   FR,   FL }},
+	{ 0x05,  {   0,     0,    0,   RC,    0,   LFE,   FR,   FL }},
+	{ 0x06,  {   0,     0,    0,   RC,   FC,     0,   FR,   FL }},
+	{ 0x07,  {   0,     0,    0,   RC,   FC,   LFE,   FR,   FL }},
+	{ 0x08,  {   0,     0,   RR,   RL,    0,     0,   FR,   FL }},
+	{ 0x09,  {   0,     0,   RR,   RL,    0,   LFE,   FR,   FL }},
+	{ 0x0a,  {   0,     0,   RR,   RL,   FC,     0,   FR,   FL }},
+	{ 0x0b,  {   0,     0,   RR,   RL,   FC,   LFE,   FR,   FL }},
+	{ 0x0c,  {   0,    RC,   RR,   RL,    0,     0,   FR,   FL }},
+	{ 0x0d,  {   0,    RC,   RR,   RL,    0,   LFE,   FR,   FL }},
+	{ 0x0e,  {   0,    RC,   RR,   RL,   FC,     0,   FR,   FL }},
+	{ 0x0f,  {   0,    RC,   RR,   RL,   FC,   LFE,   FR,   FL }},
+	{ 0x10,  { RRC,   RLC,   RR,   RL,    0,     0,   FR,   FL }},
+	{ 0x11,  { RRC,   RLC,   RR,   RL,    0,   LFE,   FR,   FL }},
+	{ 0x12,  { RRC,   RLC,   RR,   RL,   FC,     0,   FR,   FL }},
+	{ 0x13,  { RRC,   RLC,   RR,   RL,   FC,   LFE,   FR,   FL }},
+	{ 0x14,  { FRC,   FLC,    0,    0,    0,     0,   FR,   FL }},
+	{ 0x15,  { FRC,   FLC,    0,    0,    0,   LFE,   FR,   FL }},
+	{ 0x16,  { FRC,   FLC,    0,    0,   FC,     0,   FR,   FL }},
+	{ 0x17,  { FRC,   FLC,    0,    0,   FC,   LFE,   FR,   FL }},
+	{ 0x18,  { FRC,   FLC,    0,   RC,    0,     0,   FR,   FL }},
+	{ 0x19,  { FRC,   FLC,    0,   RC,    0,   LFE,   FR,   FL }},
+	{ 0x1a,  { FRC,   FLC,    0,   RC,   FC,     0,   FR,   FL }},
+	{ 0x1b,  { FRC,   FLC,    0,   RC,   FC,   LFE,   FR,   FL }},
+	{ 0x1c,  { FRC,   FLC,   RR,   RL,    0,     0,   FR,   FL }},
+	{ 0x1d,  { FRC,   FLC,   RR,   RL,    0,   LFE,   FR,   FL }},
+	{ 0x1e,  { FRC,   FLC,   RR,   RL,   FC,     0,   FR,   FL }},
+	{ 0x1f,  { FRC,   FLC,   RR,   RL,   FC,   LFE,   FR,   FL }},
+	{ 0x20,  {   0,   FCH,   RR,   RL,   FC,     0,   FR,   FL }},
+	{ 0x21,  {   0,   FCH,   RR,   RL,   FC,   LFE,   FR,   FL }},
+	{ 0x22,  {  TC,     0,   RR,   RL,   FC,     0,   FR,   FL }},
+	{ 0x23,  {  TC,     0,   RR,   RL,   FC,   LFE,   FR,   FL }},
+	{ 0x24,  { FRH,   FLH,   RR,   RL,    0,     0,   FR,   FL }},
+	{ 0x25,  { FRH,   FLH,   RR,   RL,    0,   LFE,   FR,   FL }},
+	{ 0x26,  { FRW,   FLW,   RR,   RL,    0,     0,   FR,   FL }},
+	{ 0x27,  { FRW,   FLW,   RR,   RL,    0,   LFE,   FR,   FL }},
+	{ 0x28,  {  TC,    RC,   RR,   RL,   FC,     0,   FR,   FL }},
+	{ 0x29,  {  TC,    RC,   RR,   RL,   FC,   LFE,   FR,   FL }},
+	{ 0x2a,  { FCH,    RC,   RR,   RL,   FC,     0,   FR,   FL }},
+	{ 0x2b,  { FCH,    RC,   RR,   RL,   FC,   LFE,   FR,   FL }},
+	{ 0x2c,  {  TC,   FCH,   RR,   RL,   FC,     0,   FR,   FL }},
+	{ 0x2d,  {  TC,   FCH,   RR,   RL,   FC,   LFE,   FR,   FL }},
+};
+
+enum ai_audio_coding_types {
+	AUDIO_CODING_TYPE_REF_STREAM_HEADER	=  0,
+	AUDIO_CODING_TYPE_PCM			=  1,
+	AUDIO_CODING_TYPE_AC3			=  2,
+	AUDIO_CODING_TYPE_MPEG1			=  3,
+	AUDIO_CODING_TYPE_MP3			=  4,
+	AUDIO_CODING_TYPE_MPEG2			=  5,
+	AUDIO_CODING_TYPE_AACLC			=  6,
+	AUDIO_CODING_TYPE_DTS			=  7,
+	AUDIO_CODING_TYPE_ATRAC			=  8,
+	AUDIO_CODING_TYPE_DSD			=  9,
+	AUDIO_CODING_TYPE_EAC3			= 10,
+	AUDIO_CODING_TYPE_DTS_HD		= 11,
+	AUDIO_CODING_TYPE_MLP			= 12,
+	AUDIO_CODING_TYPE_DST			= 13,
+	AUDIO_CODING_TYPE_WMAPRO		= 14,
+	AUDIO_CODING_TYPE_REF_CXT		= 15,
+};
+
+static char *ai_audio_coding_types[16] = {
+	/*  0 */ "refer-to-stream-header",
+	/*  1 */ "PCM",
+	/*  2 */ "AC-3",
+	/*  3 */ "MPEG-1",
+	/*  4 */ "MP3",
+	/*  5 */ "MPEG2",
+	/*  6 */ "AACLC",
+	/*  7 */ "DTS",
+	/*  8 */ "ATRAC",
+	/*  9 */ "DSD",
+	/* 10 */ "E-AC-3",
+	/* 11 */ "DTS-HD",
+	/* 12 */ "MLP",
+	/* 13 */ "DST",
+	/* 14 */ "WMAPro",
+	/* 15 */ "refer-to-CXT"
+};
+
+enum ai_audio_coding_xtypes {
+	AUDIO_CODING_XTYPE_HE_REF_CT		= 0,
+	AUDIO_CODING_XTYPE_HE_AAC		= 1,
+	AUDIO_CODING_XTYPE_HE_AAC2		= 2,
+	AUDIO_CODING_XTYPE_HE_MPEG_SURROUND	= 3,
+};
+
+static char *ai_ext_audio_coding_types[32] = {
+	"refer-to-CT",
+	"HE-AAC",
+	"HE-AACv2",
+	"MPEG Surround",
+	[0x04 ... 0x1f] = "reserved"
+};
+
+
+/*
+ * HDMI routines
+ */
+
+static void hdmi_get_dip_index(struct hda_codec *codec, hda_nid_t nid,
+				int *packet_index, int *byte_index)
+{
+	int val;
+
+	val = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_HDMI_DIP_INDEX, 0);
+
+	*packet_index = val >> 5;
+	*byte_index = val & 0x1f;
+}
+
+static void hdmi_set_dip_index(struct hda_codec *codec, hda_nid_t nid,
+				int packet_index, int byte_index)
+{
+	int val;
+
+	val = (packet_index << 5) | (byte_index & 0x1f);
+
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_HDMI_DIP_INDEX, val);
+}
+
+static void hdmi_write_dip_byte(struct hda_codec *codec, hda_nid_t nid,
+				unsigned char val)
+{
+	snd_hda_codec_write(codec, PIN_NID, 0, AC_VERB_SET_HDMI_DIP_DATA, val);
+}
+
+static void hdmi_enable_output(struct hda_codec *codec)
+{
+	/* Enable pin out and unmute */
+	snd_hda_sequence_write(codec, pinout_enable_verb);
+	if (get_wcaps(codec, PIN_NID) & AC_WCAP_OUT_AMP)
+		snd_hda_codec_write(codec, PIN_NID, 0,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+
+	/* Enable Audio InfoFrame Transmission */
+	hdmi_set_dip_index(codec, PIN_NID, 0x0, 0x0);
+	snd_hda_codec_write(codec, PIN_NID, 0, AC_VERB_SET_HDMI_DIP_XMIT,
+		 			       AC_DIPXMIT_BEST);
+}
+
+static void hdmi_disable_output(struct hda_codec *codec)
+{
+	snd_hda_sequence_write(codec, pinout_disable_verb);
+	if (get_wcaps(codec, PIN_NID) & AC_WCAP_OUT_AMP)
+		snd_hda_codec_write(codec, PIN_NID, 0,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+
+	/*
+	 * FIXME: noises will arise when playing music after reloading the
+	 * kernel module, until the next X restart or monitor repower.
+	 */
+}
+
+static int hdmi_get_channel_count(struct hda_codec *codec)
+{
+	return 1 + snd_hda_codec_read(codec, CVT_NID, 0,
+					AC_VERB_GET_CVT_CHAN_COUNT, 0);
+}
+
+static void hdmi_set_channel_count(struct hda_codec *codec, int chs)
+{
+	snd_hda_codec_write(codec, CVT_NID, 0,
+					AC_VERB_SET_CVT_CHAN_COUNT, chs - 1);
+#ifdef CONFIG_SND_DEBUG
+	if (hdmi_get_channel_count(codec) != chs)
+		snd_printk(KERN_WARNING "Channel count expect=%d, real=%d\n",
+				chs, hdmi_get_channel_count(codec));
+#endif
+}
+
+static void hdmi_debug_slot_mapping(struct hda_codec *codec)
+{
+#ifdef CONFIG_SND_DEBUG
+	int i;
+	int slot;
+
+	for (i = 0; i < 8; i++) {
+		slot = snd_hda_codec_read(codec, CVT_NID, 0,
+						AC_VERB_GET_HDMI_CHAN_SLOT, i);
+		printk(KERN_DEBUG "ASP channel %d => slot %d\n",
+				slot >> 4, slot & 0x7);
+	}
+#endif
+}
+
+static void hdmi_setup_channel_mapping(struct hda_codec *codec)
+{
+	snd_hda_sequence_write(codec, def_chan_map);
+	hdmi_debug_slot_mapping(codec);
+}
+
+
+/*
+ * ELD(E-EDID Like Data) routines
+ */
+
+static int hdmi_present_sense(struct hda_codec *codec)
+{
+	return snd_hda_codec_read(codec, PIN_NID, 0, AC_VERB_GET_PIN_SENSE, 0);
+}
+
+static void hdmi_debug_present_sense(struct hda_codec *codec)
+{
+#ifdef CONFIG_SND_DEBUG
+	int eldv;
+	int present;
+
+	present = hdmi_present_sense(codec);
+	eldv    = (present & AC_PINSENSE_ELDV);
+	present = (present & AC_PINSENSE_PRESENCE);
+
+	printk(KERN_INFO "eldv = %d, pinp = %d\n", !!eldv, !!present);
+#endif
+}
+
+static int hdmi_get_eldd_byte(struct hda_codec *codec, int byte_index)
+{
+	unsigned int eldd;
+
+	eldd = snd_hda_codec_read(codec, PIN_NID, 0,
+					AC_VERB_GET_HDMI_ELDD, byte_index);
+
+	if ((eldd & AC_ELDD_ELD_VALID) == 0) {
+		snd_printk(KERN_WARNING "Invalid ELD data byte %d\n",
+								byte_index);
+		eldd = 0;
+	}
+
+	return eldd & AC_ELDD_ELD_DATA;
+}
+
+static int hdmi_get_eldd(struct hda_codec *codec, char **eldd)
+{
+	int i;
+	int size;
+	char *buf;
+
+	i = hdmi_present_sense(codec) & AC_PINSENSE_ELDV;
+	if (!i)
+		return 0;
+
+	size = snd_hda_codec_read(codec, PIN_NID, 0, AC_VERB_GET_HDMI_DIP_SIZE,
+						     AC_DIPSIZE_ELD_BUF);
+	if (size == 0) {
+		/* wfg: workaround for ASUS P5E-VM HDMI board */
+		snd_printk(KERN_INFO "ELD buf size is 0, force 64\n");
+		size = 64;
+	}
+	if (size < sizeof(struct ELD_fixed_fields)) {
+		snd_printk(KERN_WARNING "Invalid ELD buf size %d\n", size);
+		return 0;
+	}
+	WARN_ON(size > PAGE_SIZE);
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf)
+		return 0;
+
+	for (i = 0; i < size; i++)
+		buf[i] = hdmi_get_eldd_byte(codec, i);
+
+	*eldd = buf;
+	return size;
+}
+
+static void hdmi_parse_short_audio_desc(struct ELD_SAD *a)
+{
+	printk(KERN_INFO "coding type: %s\n",
+					ai_audio_coding_types[a->format]);
+	printk(KERN_INFO "channels: %d\n", (int)a->channels + 1);
+	printk(KERN_INFO "sampling frequencies:%s%s%s%s%s%s%s\n",
+			a->rates & (1<<0) ?  " 32"	: "",
+			a->rates & (1<<1) ?  " 44.1"	: "",
+			a->rates & (1<<2) ?  " 48"	: "",
+			a->rates & (1<<3) ?  " 88.2"	: "",
+			a->rates & (1<<4) ?  " 96"	: "",
+			a->rates & (1<<5) ? " 176.4"	: "",
+			a->rates & (1<<6) ? " 192"	: "");
+
+	switch (a->format) {
+	case AUDIO_CODING_TYPE_REF_STREAM_HEADER:
+		break;
+
+	case AUDIO_CODING_TYPE_PCM:
+		printk(KERN_INFO "sample sizes: %s %s %s\n",
+				a->ext & 1 ? "16" : "",
+				a->ext & 2 ? "24" : "",
+				a->ext & 4 ? "32" : "");
+		break;
+
+	case AUDIO_CODING_TYPE_AC3:
+	case AUDIO_CODING_TYPE_MPEG1:
+	case AUDIO_CODING_TYPE_MP3:
+	case AUDIO_CODING_TYPE_MPEG2:
+	case AUDIO_CODING_TYPE_AACLC:
+	case AUDIO_CODING_TYPE_DTS:
+	case AUDIO_CODING_TYPE_ATRAC:
+		printk(KERN_INFO "max bitrate = %d * 8kHZ\n", a->ext);
+		break;
+
+	case AUDIO_CODING_TYPE_DSD:
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
+		printk(KERN_INFO "profile = 0x%x\n", a->ext & 0x7);
+		break;
+
+	case AUDIO_CODING_TYPE_REF_CXT:
+		break;
+	};
+}
+
+static void hdmi_show_eld(char *buf, int size)
+{
+	int i;
+	struct ELD_fixed_fields *e;
+	struct ELD_SAD *sad;
+
+	e = (struct ELD_fixed_fields *)buf;
+	printk(KERN_INFO "ELD buffer size  is %d\n", size);
+	printk(KERN_INFO "ELD baseline len is %d*4\n",
+					(int)e->baseline_ELD_len);
+	printk(KERN_INFO "vendor block len is %d\n",
+					size - e->baseline_ELD_len * 4 - 4);
+	printk(KERN_INFO "ELD version      is %s\n",
+					ELD_ELD_ver[e->ELD_ver]);
+	printk(KERN_INFO "CEA-EDID version is %s\n",
+					ELD_CEA_EDID_ver[e->CEA_EDID_ver]);
+	printk(KERN_INFO "manufacture name is 0x%x\n",
+					(int)e->manufacture_name);
+	printk(KERN_INFO "product code     is 0x%x\n",
+					(int)e->product_code);
+	printk(KERN_INFO "port id          is 0x%lx\n",
+					(long)le64_to_cpu(e->port_id));
+	printk(KERN_INFO "HDCP support     is %d\n", (int)e->HDCP);
+	printk(KERN_INFO "AI support       is %d\n", (int)e->S_AI);
+	printk(KERN_INFO "SAD count        is %d\n", (int)e->SAD_count);
+	printk(KERN_INFO "audio sync delay is %x\n",
+					(int)e->aud_synch_delay);
+	printk(KERN_INFO "connection type  is %s\n",
+					ELD_conn_type[e->conn_type]);
+	printk(KERN_INFO "speaker allocations:%s%s%s%s%s%s%s\n",
+			ELD_speaker_allocations[1 * e->FLR ],
+			ELD_speaker_allocations[2 * e->LFE ],
+			ELD_speaker_allocations[3 * e->FC  ],
+			ELD_speaker_allocations[4 * e->RLR ],
+			ELD_speaker_allocations[5 * e->RC  ],
+			ELD_speaker_allocations[6 * e->FLRC],
+			ELD_speaker_allocations[7 * e->RLRC]);
+
+	if (e->MNL == 0)
+		printk(KERN_INFO "monitor name     is absent\n");
+	else if (e->MNL < 16) {
+		if (e->monitor_name + e->MNL - buf >= size) {
+			snd_printk(KERN_WARNING "Out of range MNL %d\n",
+								e->MNL);
+			return;
+		}
+		i = e->monitor_name[e->MNL];
+		e->monitor_name[e->MNL] = '\0';
+		printk(KERN_INFO "monitor name     is %s\n",
+							e->monitor_name);
+		e->monitor_name[e->MNL] = i;
+	} else {
+		snd_printk(KERN_WARNING "MNL is reserved value(0x%x)\n",
+								e->MNL);
+		return;
+	}
+
+	sad = (struct ELD_SAD *)(e->monitor_name + e->MNL);
+	for (i = 0; i < e->SAD_count; i++) {
+		if ((char *)(sad + i + 1) - buf > size) {
+			snd_printk(KERN_WARNING "Out of range SAD %d!\n", i);
+			return;
+		}
+		hdmi_parse_short_audio_desc(sad + i);
+	}
+}
+
+static void hdmi_parse_eld(struct hda_codec *codec)
+{
+	int size;
+	char *buf;
+
+	hdmi_debug_present_sense(codec);
+
+	size = hdmi_get_eldd(codec, &buf);
+	if (!size)
+		return;
+
+	hdmi_show_eld(buf, size);
+
+	/* TODO: do real things about ELD */
+
+	kfree(buf);
+}
+
+
+/*
+ * Audio Infoframe routines
+ */
+
+static void hdmi_debug_dip_size(struct hda_codec *codec)
+{
+#ifdef CONFIG_SND_DEBUG
+	int i;
+	int size;
+
+	size = snd_hda_codec_read(codec, PIN_NID, 0,
+						AC_VERB_GET_HDMI_DIP_SIZE, 0x8);
+
+	printk(KERN_DEBUG "ELD buf size is %d\n", size);
+
+	for (i = 0; i < 8; i++) {
+		size = snd_hda_codec_read(codec, PIN_NID, 0,
+						AC_VERB_GET_HDMI_DIP_SIZE, i);
+		printk(KERN_DEBUG "DIP GP[%d] buf size is %d\n", i, size);
+	}
+#endif
+}
+
+static void hdmi_clear_dip_buffers(struct hda_codec *codec)
+{
+#ifdef BE_PARANOID
+	int i, j;
+	int size;
+	int pi, bi;
+	for (i = 0; i < 8; i++) {
+		size = snd_hda_codec_read(codec, PIN_NID, 0,
+						AC_VERB_GET_HDMI_DIP_SIZE, i);
+		if (size == 0)
+			continue;
+
+		hdmi_set_dip_index(codec, PIN_NID, i, 0x0);
+		for (j = 1; j < 1000; j++) {
+			snd_hda_codec_write(codec, PIN_NID, 0,
+					AC_VERB_SET_HDMI_DIP_DATA, 0x0);
+			hdmi_get_dip_index(codec, PIN_NID, &pi, &bi);
+			WARN_ON(pi != i);
+			if (bi == 0) /* byte index wrapped around */
+				break;
+		}
+		snd_printd(KERN_INFO
+				"DIP GP[%d] buf reported size=%d, written=%d\n",
+				i, size, j);
+	}
+#endif
+}
+
+static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
+					struct snd_pcm_substream *substream)
+{
+	struct hdmi_audio_infoframe audio_infoframe = {
+		.type	= 0x84,
+		.ver	= 0x01,
+		.len	= 0x0a,
+		.CC	= substream->runtime->channels - 1,
+	};
+	unsigned char *params = (char *)&audio_infoframe;
+	int i;
+
+	hdmi_debug_dip_size(codec);
+	hdmi_clear_dip_buffers(codec); /* be paranoid */
+
+	hdmi_set_dip_index(codec, PIN_NID, 0x0, 0x0);
+	for (i = 0; i < sizeof(audio_infoframe); i++)
+		hdmi_write_dip_byte(codec, PIN_NID, params[i]);
+}
+
+/*
+ * Unsolicited events
+ */
+
+static void hdmi_intrinsic_event(struct hda_codec *codec,
+							unsigned int res)
+{
+	printk(KERN_INFO "HDMI intrinsic event: PD=%d ELDV=%d\n",
+			!!(res & AC_UNSOL_RES_PD),
+			!!(res & AC_UNSOL_RES_ELDV));
+
+	if ((res & AC_UNSOL_RES_PD) && (res & AC_UNSOL_RES_ELDV)) {
+		hdmi_parse_eld(codec);
+	}
+}
+
+static void hdmi_non_intrinsic_event(struct hda_codec *codec,
+							unsigned int res)
+{
+	printk(KERN_INFO "HDMI non-intrinsic event: "
+			"SUBTAG=0x%x CP_STATE=%d CP_READY=%d\n",
+			res & AC_UNSOL_RES_SUBTAG,
+			!!(res & AC_UNSOL_RES_CP_STATE),
+			!!(res & AC_UNSOL_RES_CP_READY));
+
+	/* TODO */
+	if (res & AC_UNSOL_RES_CP_STATE)
+		;
+	else if (res & AC_UNSOL_RES_CP_READY)
+		;
+}
+
+
+static void intel_hdmi_unsol_event(struct hda_codec *codec,
+							unsigned int res)
+{
+	int tag = res >> AC_UNSOL_RES_TAG_SHIFT;
+
+	if (tag != INTEL_HDMI_EVENT_TAG) {
+		snd_printk(KERN_WARNING
+				"Unexpected HDMI unsolicited event tag 0x%x\n",
+				tag);
+		return;
+	}
+
+	if ((res & AC_UNSOL_RES_SUBTAG) == 0)
+		hdmi_intrinsic_event(codec, res);
+	else
+		hdmi_non_intrinsic_event(codec, res);
+}
+
+/*
+ * Callbacks
+ */
+
+static int intel_hdmi_playback_pcm_open(struct hda_pcm_stream *hinfo,
+				     struct hda_codec *codec,
+				     struct snd_pcm_substream *substream)
+{
+	struct intel_hdmi_spec *spec = codec->spec;
+
+	return snd_hda_multi_out_dig_open(codec, &spec->multiout);
+
+	return snd_pcm_hw_constraint_step(substream->runtime, 0,
+					  SNDRV_PCM_HW_PARAM_CHANNELS, 2);
+}
+
+static int intel_hdmi_playback_pcm_close(struct hda_pcm_stream *hinfo,
+				      struct hda_codec *codec,
+				      struct snd_pcm_substream *substream)
+{
+	struct intel_hdmi_spec *spec = codec->spec;
+
+	hdmi_disable_output(codec);
+
+	return snd_hda_multi_out_dig_close(codec, &spec->multiout);
+}
+
+static int intel_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
+					   struct hda_codec *codec,
+					   unsigned int stream_tag,
+					   unsigned int format,
+					   struct snd_pcm_substream *substream)
+{
+	struct intel_hdmi_spec *spec = codec->spec;
+
+	snd_hda_multi_out_dig_prepare(codec, &spec->multiout, stream_tag,
+					     format, substream);
+
+	hdmi_parse_eld(codec);
+
+	hdmi_set_channel_count(codec, substream->runtime->channels);
+
+	/* wfg: channel mapping not supported by intel codec */
+	hdmi_setup_channel_mapping(codec);
+
+	hdmi_setup_audio_infoframe(codec, substream);
+
+	hdmi_enable_output(codec);
+
+	return 0;
+}
+
+static struct hda_pcm_stream intel_hdmi_pcm_playback = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 8,
+	.nid = CVT_NID, /* NID to query formats and rates and setup streams */
+	.ops = {
+		.open = intel_hdmi_playback_pcm_open,
+		.close = intel_hdmi_playback_pcm_close,
+		.prepare = intel_hdmi_playback_pcm_prepare
+	},
+};
+
+static int intel_hdmi_build_pcms(struct hda_codec *codec)
+{
+	struct intel_hdmi_spec *spec = codec->spec;
+	struct hda_pcm *info = &spec->pcm_rec;
+
+	codec->num_pcms = 1;
+	codec->pcm_info = info;
+
+	info->name = "INTEL HDMI";
+	info->pcm_type = HDA_PCM_TYPE_HDMI;
+	info->stream[SNDRV_PCM_STREAM_PLAYBACK] = intel_hdmi_pcm_playback;
+
+	return 0;
+}
+
+static int intel_hdmi_build_controls(struct hda_codec *codec)
+{
+	struct intel_hdmi_spec *spec = codec->spec;
+	int err;
+
+	err = snd_hda_create_spdif_out_ctls(codec, spec->multiout.dig_out_nid);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int intel_hdmi_init(struct hda_codec *codec)
+{
+	hdmi_disable_output(codec);
+	snd_hda_sequence_write(codec, unsolicited_response_verb);
+
+	return 0;
+}
+
+static void intel_hdmi_free(struct hda_codec *codec)
+{
+	kfree(codec->spec);
+}
+
+static struct hda_codec_ops intel_hdmi_patch_ops = {
+	.init			= intel_hdmi_init,
+	.free			= intel_hdmi_free,
+	.build_pcms		= intel_hdmi_build_pcms,
+	.build_controls 	= intel_hdmi_build_controls,
+	.unsol_event		= intel_hdmi_unsol_event,
+};
+
+static int patch_intel_hdmi(struct hda_codec *codec)
+{
+	struct intel_hdmi_spec *spec;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+
+	spec->multiout.num_dacs = 0;	  /* no analog */
+	spec->multiout.max_channels = 8;
+	spec->multiout.dig_out_nid = CVT_NID;
+
+	codec->patch_ops = intel_hdmi_patch_ops;
+
+	return 0;
+}
+
+struct hda_codec_preset snd_hda_preset_intelhdmi[] = {
+	{ .id = 0x808629fb, .name = "INTEL G45 DEVCL",  .patch = patch_intel_hdmi },
+	{ .id = 0x80862801, .name = "INTEL G45 DEVBLC", .patch = patch_intel_hdmi },
+	{ .id = 0x80862802, .name = "INTEL G45 DEVCTG", .patch = patch_intel_hdmi },
+	{ .id = 0x80862803, .name = "INTEL G45 DEVELK", .patch = patch_intel_hdmi },
+	{ .id = 0x10951392, .name = "SiI1392 HDMI",     .patch = patch_intel_hdmi },
+	{} /* terminator */
+};
--- sound-2.6.orig/sound/pci/hda/hda_codec.h
+++ sound-2.6/sound/pci/hda/hda_codec.h
@@ -380,6 +380,10 @@ enum {
 #define AC_ELDD_ELD_VALID		(1<<31)
 #define AC_ELDD_ELD_DATA		0xff
 
+/* HDMI ELD version */
+#define AC_ELDD_ELD_VER_CEA_861D	(0x02)
+#define AC_ELDD_ELD_VER_PARTIAL 	(0x1f)
+
 /* HDMI DIP size */
 #define AC_DIPSIZE_ELD_BUF		(1<<3) /* ELD buf size of packet size */
 #define AC_DIPSIZE_PACK_IDX		(0x07<<0) /* packet index */
--- sound-2.6.orig/sound/pci/hda/patch_atihdmi.c
+++ sound-2.6/sound/pci/hda/patch_atihdmi.c
@@ -193,7 +193,6 @@ struct hda_codec_preset snd_hda_preset_a
 	{ .id = 0x1002791a, .name = "ATI RS690/780 HDMI", .patch = patch_atihdmi },
 	{ .id = 0x1002aa01, .name = "ATI R6xx HDMI", .patch = patch_atihdmi },
 	{ .id = 0x10951390, .name = "SiI1390 HDMI", .patch = patch_atihdmi },
-	{ .id = 0x10951392, .name = "SiI1392 HDMI", .patch = patch_atihdmi },
 	{ .id = 0x17e80047, .name = "Chrontel HDMI",  .patch = patch_atihdmi },
 	{} /* terminator */
 };
--- sound-2.6.orig/sound/pci/hda/hda_intel.c
+++ sound-2.6/sound/pci/hda/hda_intel.c
@@ -1196,7 +1196,7 @@ static unsigned int azx_max_codecs[AZX_N
  * report wrongly the non-existing 4th slot availability
  */
 static unsigned int azx_default_codecs[AZX_NUM_DRIVERS] __devinitdata = {
-	[AZX_DRIVER_ICH] = 3,
+	[AZX_DRIVER_ICH] = 4,
 	[AZX_DRIVER_ATI] = 3,
 };
 

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--dDRMvlgZJXvWKvBx--
