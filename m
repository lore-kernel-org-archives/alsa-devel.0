From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 08/11] hda - vectorize intelhdmi
Date: Thu, 15 Oct 2009 15:03:56 +0800
Message-ID: <20091015070918.820479295@intel.com>
References: <20091015070348.390451250@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B66A103942
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Oct 2009 09:10:18 +0200 (CEST)
Content-Disposition: inline; filename=alsa-ibexpeak-hdmi-pin-array.patch
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
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

The Intel IbexPeak HDMI codec supports 2 converters and 3 pins,
which requires converting the cvt_nid/pin_nid to arrays.

The active pin number (the one connected with a live HDMI monitor/sink)
will be dynamically identified on hotplug events.

It exports two HDMI devices, so that user space can choose the A/V pipe
for sending the audio samples.

It's still undefined behavior when there are two active monitors
connected and routed to the same audio converter.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_eld.c         |    5 
 sound/pci/hda/hda_local.h       |    6 
 sound/pci/hda/patch_intelhdmi.c |  191 +++++++++++++++++++++++-------
 3 files changed, 155 insertions(+), 47 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-10-15 12:35:40.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-10-15 12:38:34.000000000 +0800
@@ -33,14 +33,43 @@
 #include "hda_codec.h"
 #include "hda_local.h"
 
-static hda_nid_t cvt_nid;	/* audio converter */
-static hda_nid_t pin_nid;	/* HDMI output pin */
+/*
+ * The HDMI/DisplayPort configuration can be highly dynamic. A graphics device
+ * could support two independent pipes, each of them can be connected to one or
+ * more ports (DVI, HDMI or DisplayPort).
+ *
+ * The HDA correspondence of pipes/ports are converter/pin nodes.
+ */
+#define INTEL_HDMI_CVTS	2
+#define INTEL_HDMI_PINS	3
 
-#define INTEL_HDMI_EVENT_TAG		0x08
+static char *intel_hdmi_pcm_names[INTEL_HDMI_CVTS] = {
+	"INTEL HDMI 0",
+	"INTEL HDMI 1",
+};
 
 struct intel_hdmi_spec {
-	struct hda_pcm pcm_rec;
-	struct hdmi_eld sink_eld;
+	int num_cvts;
+	int num_pins;
+	hda_nid_t cvt[INTEL_HDMI_CVTS+1];  /* audio sources */
+	hda_nid_t pin[INTEL_HDMI_PINS+1];  /* audio sinks */
+
+	/*
+	 * source connection for each pin
+	 */
+	hda_nid_t pin_cvt[INTEL_HDMI_PINS+1];
+
+	/*
+	 * HDMI sink attached to each pin
+	 */
+	bool		sink_present[INTEL_HDMI_PINS];
+	bool		sink_eldv[INTEL_HDMI_PINS];
+	struct hdmi_eld sink_eld[INTEL_HDMI_PINS];
+
+	/*
+	 * export one pcm per pipe
+	 */
+	struct hda_pcm	pcm_rec[INTEL_HDMI_CVTS];
 };
 
 struct hdmi_audio_infoframe {
@@ -183,6 +212,19 @@ static struct cea_channel_speaker_alloca
 { .ca_index = 0x31,  .speakers = { FRW,  FLW,  RR,  RL,  FC,  LFE,  FR,  FL } },
 };
 
+
+static int hda_node_index(hda_nid_t *nids, hda_nid_t nid)
+{
+	int i;
+
+	for (i = 0; nids[i]; i++)
+		if (nids[i] == nid)
+			return i;
+
+	snd_printk(KERN_WARNING "HDMI: nid %d not registered\n", nid);
+	return -EINVAL;
+}
+
 /*
  * HDMI routines
  */
@@ -283,12 +325,12 @@ static void hdmi_debug_channel_mapping(s
 #endif
 }
 
-static void hdmi_parse_eld(struct hda_codec *codec)
+static void hdmi_parse_eld(struct hda_codec *codec, int index)
 {
 	struct intel_hdmi_spec *spec = codec->spec;
-	struct hdmi_eld *eld = &spec->sink_eld;
+	struct hdmi_eld *eld = &spec->sink_eld[index];
 
-	if (!snd_hdmi_get_eld(eld, codec, pin_nid))
+	if (!snd_hdmi_get_eld(eld, codec, spec->pin[index]))
 		snd_hdmi_show_eld(eld);
 }
 
@@ -395,7 +437,7 @@ static int hdmi_setup_channel_allocation
 					 struct hdmi_audio_infoframe *ai)
 {
 	struct intel_hdmi_spec *spec = codec->spec;
-	struct hdmi_eld *eld = &spec->sink_eld;
+	struct hdmi_eld *eld;
 	int i;
 	int spk_mask = 0;
 	int channels = 1 + (ai->CC02_CT47 & 0x7);
@@ -407,6 +449,11 @@ static int hdmi_setup_channel_allocation
 	if (channels <= 2)
 		return 0;
 
+	i = hda_node_index(spec->pin_cvt, nid);
+	if (i < 0)
+		return 0;
+	eld = &spec->sink_eld[i];
+
 	/*
 	 * HDMI sink's ELD info cannot always be retrieved for now, e.g.
 	 * in console or for audio devices. Assume the highest speakers
@@ -469,6 +516,9 @@ static void hdmi_setup_channel_mapping(s
 static void hdmi_setup_audio_infoframe(struct hda_codec *codec, hda_nid_t nid,
 					struct snd_pcm_substream *substream)
 {
+	struct intel_hdmi_spec *spec = codec->spec;
+	hda_nid_t pin_nid;
+	int i;
 	struct hdmi_audio_infoframe ai = {
 		.type		= 0x84,
 		.ver		= 0x01,
@@ -479,8 +529,16 @@ static void hdmi_setup_audio_infoframe(s
 	hdmi_setup_channel_allocation(codec, nid, &ai);
 	hdmi_setup_channel_mapping(codec, nid, &ai);
 
-	hdmi_fill_audio_infoframe(codec, pin_nid, &ai);
-	hdmi_start_infoframe_trans(codec, pin_nid);
+	for (i = 0; i < spec->num_pins; i++) {
+		if (spec->pin_cvt[i] != nid)
+			continue;
+		if (spec->sink_present[i] != true)
+			continue;
+
+		pin_nid = spec->pin[i];
+		hdmi_fill_audio_infoframe(codec, pin_nid, &ai);
+		hdmi_start_infoframe_trans(codec, pin_nid);
+	}
 }
 
 
@@ -490,27 +548,39 @@ static void hdmi_setup_audio_infoframe(s
 
 static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
 {
+	struct intel_hdmi_spec *spec = codec->spec;
+	int tag = res >> AC_UNSOL_RES_TAG_SHIFT;
 	int pind = !!(res & AC_UNSOL_RES_PD);
 	int eldv = !!(res & AC_UNSOL_RES_ELDV);
+	int index;
 
 	printk(KERN_INFO
-		"HDMI hot plug event: Presence_Detect=%d ELD_Valid=%d\n",
-		pind, eldv);
+		"HDMI hot plug event: Pin=%d Presence_Detect=%d ELD_Valid=%d\n",
+		tag, pind, eldv);
+
+	index = hda_node_index(spec->pin, tag);
+	if (index < 0)
+		return;
+
+	spec->sink_present[index] = pind;
+	spec->sink_eldv[index] = eldv;
 
 	if (pind && eldv) {
-		hdmi_parse_eld(codec);
+		hdmi_parse_eld(codec, index);
 		/* TODO: do real things about ELD */
 	}
 }
 
 static void hdmi_non_intrinsic_event(struct hda_codec *codec, unsigned int res)
 {
+	int tag = res >> AC_UNSOL_RES_TAG_SHIFT;
 	int subtag = (res & AC_UNSOL_RES_SUBTAG) >> AC_UNSOL_RES_SUBTAG_SHIFT;
 	int cp_state = !!(res & AC_UNSOL_RES_CP_STATE);
 	int cp_ready = !!(res & AC_UNSOL_RES_CP_READY);
 
 	printk(KERN_INFO
-		"HDMI content protection event: SUBTAG=0x%x CP_STATE=%d CP_READY=%d\n",
+		"HDMI CP event: PIN=%d SUBTAG=0x%x CP_STATE=%d CP_READY=%d\n",
+		tag,
 		subtag,
 		cp_state,
 		cp_ready);
@@ -525,10 +595,11 @@ static void hdmi_non_intrinsic_event(str
 
 static void intel_hdmi_unsol_event(struct hda_codec *codec, unsigned int res)
 {
+	struct intel_hdmi_spec *spec = codec->spec;
 	int tag = res >> AC_UNSOL_RES_TAG_SHIFT;
 	int subtag = (res & AC_UNSOL_RES_SUBTAG) >> AC_UNSOL_RES_SUBTAG_SHIFT;
 
-	if (tag != INTEL_HDMI_EVENT_TAG) {
+	if (hda_node_index(spec->pin, tag) < 0) {
 		snd_printd(KERN_INFO "Unexpected HDMI event tag 0x%x\n", tag);
 		return;
 	}
@@ -549,10 +620,10 @@ static int intel_hdmi_playback_pcm_prepa
 					   unsigned int format,
 					   struct snd_pcm_substream *substream)
 {
-	hdmi_set_channel_count(codec, cvt_nid,
+	hdmi_set_channel_count(codec, hinfo->nid,
 			       substream->runtime->channels);
 
-	hdmi_setup_audio_infoframe(codec, cvt_nid, substream);
+	hdmi_setup_audio_infoframe(codec, hinfo->nid, substream);
 
 	snd_hda_codec_setup_stream(codec, hinfo->nid, stream_tag, 0, format);
 	return 0;
@@ -563,8 +634,14 @@ static int intel_hdmi_playback_pcm_clean
 					   struct snd_pcm_substream *substream)
 {
 	struct intel_hdmi_spec *spec = codec->spec;
+	int i;
+
+	for (i = 0; i < spec->num_pins; i++) {
+		if (spec->pin_cvt[i] != hinfo->nid)
+			continue;
 
-	hdmi_stop_infoframe_trans(codec, pin_nid);
+		hdmi_stop_infoframe_trans(codec, spec->pin[i]);
+	}
 
 	snd_hda_codec_cleanup_stream(codec, hinfo->nid);
 	return 0;
@@ -583,17 +660,19 @@ static struct hda_pcm_stream intel_hdmi_
 static int intel_hdmi_build_pcms(struct hda_codec *codec)
 {
 	struct intel_hdmi_spec *spec = codec->spec;
-	struct hda_pcm *info = &spec->pcm_rec;
+	struct hda_pcm *info = spec->pcm_rec;
+	int i;
 
-	codec->num_pcms = 1;
+	codec->num_pcms = spec->num_cvts;
 	codec->pcm_info = info;
 
-	/* NID to query formats and rates and setup streams */
-	intel_hdmi_pcm_playback.nid = cvt_nid;
-
-	info->name = "INTEL HDMI";
-	info->pcm_type = HDA_PCM_TYPE_HDMI;
-	info->stream[SNDRV_PCM_STREAM_PLAYBACK] = intel_hdmi_pcm_playback;
+	for (i = 0; i < codec->num_pcms; i++, info++) {
+		info->name = intel_hdmi_pcm_names[i];
+		info->pcm_type = HDA_PCM_TYPE_HDMI;
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK] =
+							intel_hdmi_pcm_playback;
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->cvt[i];
+	}
 
 	return 0;
 }
@@ -602,29 +681,39 @@ static int intel_hdmi_build_controls(str
 {
 	struct intel_hdmi_spec *spec = codec->spec;
 	int err;
+	int i;
 
-	err = snd_hda_create_spdif_out_ctls(codec, cvt_nid);
-	if (err < 0)
-		return err;
+	for (i = 0; i < codec->num_pcms; i++) {
+		err = snd_hda_create_spdif_out_ctls(codec, spec->cvt[i]);
+		if (err < 0)
+			return err;
+	}
 
 	return 0;
 }
 
 static int intel_hdmi_init(struct hda_codec *codec)
 {
-	hdmi_enable_output(codec, pin_nid);
+	struct intel_hdmi_spec *spec = codec->spec;
+	int i;
 
-	snd_hda_codec_write(codec, pin_nid, 0,
-			    AC_VERB_SET_UNSOLICITED_ENABLE,
-			    AC_USRSP_EN | INTEL_HDMI_EVENT_TAG);
+	for (i = 0; spec->pin[i]; i++) {
+		hdmi_enable_output(codec, spec->pin[i]);
+		snd_hda_codec_write(codec, spec->pin[i], 0,
+				    AC_VERB_SET_UNSOLICITED_ENABLE,
+				    AC_USRSP_EN | spec->pin[i]);
+	}
 	return 0;
 }
 
 static void intel_hdmi_free(struct hda_codec *codec)
 {
 	struct intel_hdmi_spec *spec = codec->spec;
+	int i;
+
+	for (i = 0; i < spec->num_pins; i++)
+		snd_hda_eld_proc_free(codec, &spec->sink_eld[i]);
 
-	snd_hda_eld_proc_free(codec, &spec->sink_eld);
 	kfree(spec);
 }
 
@@ -636,18 +725,38 @@ static struct hda_codec_ops intel_hdmi_p
 	.unsol_event		= intel_hdmi_unsol_event,
 };
 
-static int do_patch_intel_hdmi(struct hda_codec *codec)
+static struct intel_hdmi_spec static_specs[] = {
+	{
+		.num_cvts = 1,
+		.num_pins = 1,
+		.cvt	  = { 0x2 },
+		.pin	  = { 0x3 },
+		.pin_cvt  = { 0x2 },
+	},
+	{
+		.num_cvts = 2,
+		.num_pins = 3,
+		.cvt	  = { 0x2, 0x3 },
+		.pin	  = { 0x4, 0x5, 0x6 },
+		.pin_cvt  = { 0x2, 0x2, 0x2 },
+	},
+};
+
+static int do_patch_intel_hdmi(struct hda_codec *codec, int spec_id)
 {
 	struct intel_hdmi_spec *spec;
+	int i;
 
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
 
+	*spec = static_specs[spec_id];
 	codec->spec = spec;
 	codec->patch_ops = intel_hdmi_patch_ops;
 
-	snd_hda_eld_proc_new(codec, &spec->sink_eld);
+	for (i = 0; i < spec->num_pins; i++)
+		snd_hda_eld_proc_new(codec, &spec->sink_eld[i], i);
 
 	init_channel_allocations();
 
@@ -656,16 +765,12 @@ static int do_patch_intel_hdmi(struct hd
 
 static int patch_intel_hdmi(struct hda_codec *codec)
 {
-	cvt_nid = 0x02;
-	pin_nid = 0x03;
-	return do_patch_intel_hdmi(codec);
+	return do_patch_intel_hdmi(codec, 0);
 }
 
 static int patch_intel_hdmi_ibexpeak(struct hda_codec *codec)
 {
-	cvt_nid = 0x02;
-	pin_nid = 0x04;
-	return do_patch_intel_hdmi(codec);
+	return do_patch_intel_hdmi(codec, 1);
 }
 
 static struct hda_codec_preset snd_hda_preset_intelhdmi[] = {
--- sound-2.6.orig/sound/pci/hda/hda_eld.c	2009-10-15 11:16:02.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_eld.c	2009-10-15 12:35:42.000000000 +0800
@@ -560,13 +560,14 @@ static void hdmi_write_eld_info(struct s
 }
 
 
-int snd_hda_eld_proc_new(struct hda_codec *codec, struct hdmi_eld *eld)
+int snd_hda_eld_proc_new(struct hda_codec *codec, struct hdmi_eld *eld,
+			 int index)
 {
 	char name[32];
 	struct snd_info_entry *entry;
 	int err;
 
-	snprintf(name, sizeof(name), "eld#%d", codec->addr);
+	snprintf(name, sizeof(name), "eld#%d.%d", codec->addr, index);
 	err = snd_card_proc_new(codec->bus->card, name, &entry);
 	if (err < 0)
 		return err;
--- sound-2.6.orig/sound/pci/hda/hda_local.h	2009-10-15 11:16:02.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_local.h	2009-10-15 12:35:42.000000000 +0800
@@ -541,11 +541,13 @@ int snd_hdmi_get_eld(struct hdmi_eld *, 
 void snd_hdmi_show_eld(struct hdmi_eld *eld);
 
 #ifdef CONFIG_PROC_FS
-int snd_hda_eld_proc_new(struct hda_codec *codec, struct hdmi_eld *eld);
+int snd_hda_eld_proc_new(struct hda_codec *codec, struct hdmi_eld *eld,
+			 int index);
 void snd_hda_eld_proc_free(struct hda_codec *codec, struct hdmi_eld *eld);
 #else
 static inline int snd_hda_eld_proc_new(struct hda_codec *codec,
-				       struct hdmi_eld *eld)
+				       struct hdmi_eld *eld,
+				       int index)
 {
 	return 0;
 }
