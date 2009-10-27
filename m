From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [Intel-gfx] Problems with HDMI audio on Intel
	DG45FC	motherboard
Date: Tue, 27 Oct 2009 11:28:57 +0800
Message-ID: <20091027032857.GA6753@localhost>
References: <20091011214513.GB12771@hardeman.nu>
	<20091014015455.GI13364@zhen-devel.sh.intel.com>
	<20091014020044.GA10032@localhost>
	<20091014174053.GA31149@hardeman.nu>
	<20091020012600.GA6548@localhost> <20091020224353.GA23186@csy.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 2863324463
	for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2009 04:29:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091020224353.GA23186@csy.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shane W <shane-alsa@csy.ca>
Cc: "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "david@hardeman.nu" <david@hardeman.nu>
List-Id: alsa-devel@alsa-project.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Shane,

[sorry for late response - I was out traveling]

On Wed, Oct 21, 2009 at 06:43:53AM +0800, Shane W wrote:
> Hey all,
> 
> On Tue, Oct 20, 2009 at 09:26:00AM +0800, Wu Fengguang wrote:
> > It's <= 0.5 second silence from my experience.
> 
> Correct.
> 
> > HDMI codec/sink seem to take some time to response to the output
> > enable and new infoframe, so there are some delay. I've moved the HDMI
> > output enable command to module load time, this helps. The infoframe
> > is in theory created in run time based on the format of _each_ new
> > audio stream, so infoframe transmission has to be started/stopped
> > for each track..
> 
> I know this has come up before but can't we not start/stop
> the infoframe if the sample format on the new track is the
> same as the old. I mean playing an album, you're gonna get
> 44100, 2ch s16le 95% of the time so that would atleast
> cause the problem to appear much less.

Yeah, this is worth trying. The attached (combined) patch have bits to
do sticky infoframe. However my tests show that it didn't improve the
0.5s delay..

Thanks,
Fengguang


--ibTvN161/egqYuK8
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="hdmi-intel.patch"

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-10-15 11:16:05.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-10-27 11:23:12.000000000 +0800
@@ -33,15 +33,19 @@
 #include "hda_codec.h"
 #include "hda_local.h"
 
-static hda_nid_t cvt_nid;	/* audio converter */
-static hda_nid_t pin_nid;	/* HDMI output pin */
-
-#define INTEL_HDMI_EVENT_TAG		0x08
+/*
+ * The HDMI/DisplayPort configuration can be highly dynamic. A graphics device
+ * could support two independent pipes, each of them can be connected to one or
+ * more ports (DVI, HDMI or DisplayPort).
+ *
+ * The HDA correspondence of pipes/ports are converter/pin nodes.
+ */
+#define INTEL_HDMI_CVTS	2
+#define INTEL_HDMI_PINS	3
 
-struct intel_hdmi_spec {
-	struct hda_multi_out multiout;
-	struct hda_pcm pcm_rec;
-	struct hdmi_eld sink_eld;
+static char *intel_hdmi_pcm_names[INTEL_HDMI_CVTS] = {
+	"INTEL HDMI 0",
+	"INTEL HDMI 1",
 };
 
 struct hdmi_audio_infoframe {
@@ -49,7 +53,6 @@ struct hdmi_audio_infoframe {
 	u8 ver;  /* 0x01 */
 	u8 len;  /* 0x0a */
 
-	u8 checksum;	/* PB0 */
 	u8 CC02_CT47;	/* CC in bits 0:2, CT in 4:7 */
 	u8 SS01_SF24;
 	u8 CXT04;
@@ -58,6 +61,35 @@ struct hdmi_audio_infoframe {
 	u8 reserved[5];	/* PB6 - PB10 */
 };
 
+struct intel_hdmi_spec {
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
+
+	/*
+	 * cache the active infoframe
+	 */
+	struct hdmi_audio_infoframe ai[INTEL_HDMI_PINS];
+};
+
 /*
  * CEA speaker placement:
  *
@@ -184,40 +216,165 @@ static struct cea_channel_speaker_alloca
 { .ca_index = 0x31,  .speakers = { FRW,  FLW,  RR,  RL,  FC,  LFE,  FR,  FL } },
 };
 
+
+/*
+ * HDA/HDMI auto parsing
+ */
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
+static int intel_hdmi_read_pin_conn(struct hda_codec *codec, hda_nid_t pin_nid)
+{
+	struct intel_hdmi_spec *spec = codec->spec;
+	hda_nid_t conn_list[HDA_MAX_CONNECTIONS];
+	int conn_len, curr;
+	int index;
+
+	if (!(get_wcaps(codec, pin_nid) & AC_WCAP_CONN_LIST)) {
+		snd_printk(KERN_WARNING
+			   "HDMI: pin %d wcaps %#x "
+			   "does not support connection list\n",
+			   pin_nid, get_wcaps(codec, pin_nid));
+		return -EINVAL;
+	}
+
+	conn_len = snd_hda_get_connections(codec, pin_nid, conn_list,
+					   HDA_MAX_CONNECTIONS);
+	if (conn_len > 1)
+		curr = snd_hda_codec_read(codec, pin_nid, 0,
+					  AC_VERB_GET_CONNECT_SEL, 0);
+	else
+		curr = 0;
+
+	index = hda_node_index(spec->pin, pin_nid);
+	if (index < 0)
+		return -EINVAL;
+
+	spec->pin_cvt[index] = conn_list[curr];
+
+	return 0;
+}
+
+static int intel_hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
+{
+	struct intel_hdmi_spec *spec = codec->spec;
+
+	if (spec->num_pins >= INTEL_HDMI_PINS) {
+		snd_printk(KERN_WARNING
+			   "HDMI: no space for pin %d \n", pin_nid);
+		return -EINVAL;
+	}
+
+	spec->pin[spec->num_pins] = pin_nid;
+	spec->num_pins++;
+
+	/*
+	 * It is assumed that converter nodes come first in the node list and
+	 * hence have been registered and usable now.
+	 */
+	return intel_hdmi_read_pin_conn(codec, pin_nid);
+}
+
+static int intel_hdmi_add_cvt(struct hda_codec *codec, hda_nid_t nid)
+{
+	struct intel_hdmi_spec *spec = codec->spec;
+
+	if (spec->num_cvts >= INTEL_HDMI_CVTS) {
+		snd_printk(KERN_WARNING
+			   "HDMI: no space for converter %d \n", nid);
+		return -EINVAL;
+	}
+
+	spec->cvt[spec->num_cvts] = nid;
+	spec->num_cvts++;
+
+	return 0;
+}
+
+static int intel_hdmi_parse_codec(struct hda_codec *codec)
+{
+	hda_nid_t nid;
+	int i, nodes;
+
+	nodes = snd_hda_get_sub_nodes(codec, codec->afg, &nid);
+	if (!nid || nodes < 0) {
+		snd_printk(KERN_WARNING "HDMI: failed to get afg sub nodes\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < nodes; i++, nid++) {
+		unsigned int caps;
+		unsigned int type;
+
+		caps = snd_hda_param_read(codec, nid, AC_PAR_AUDIO_WIDGET_CAP);
+		type = get_wcaps_type(caps);
+
+		if (!(caps & AC_WCAP_DIGITAL))
+			continue;
+
+		switch (type) {
+		case AC_WID_AUD_OUT:
+			if (intel_hdmi_add_cvt(codec, nid) < 0)
+				return -EINVAL;
+			break;
+		case AC_WID_PIN:
+			caps = snd_hda_param_read(codec, nid, AC_PAR_PIN_CAP);
+			if (!(caps & AC_PINCAP_HDMI))
+				continue;
+			if (intel_hdmi_add_pin(codec, nid) < 0)
+				return -EINVAL;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * HDMI routines
  */
 
 #ifdef BE_PARANOID
-static void hdmi_get_dip_index(struct hda_codec *codec, hda_nid_t nid,
+static void hdmi_get_dip_index(struct hda_codec *codec, hda_nid_t pin_nid,
 				int *packet_index, int *byte_index)
 {
 	int val;
 
-	val = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_HDMI_DIP_INDEX, 0);
+	val = snd_hda_codec_read(codec, pin_nid, 0,
+				 AC_VERB_GET_HDMI_DIP_INDEX, 0);
 
 	*packet_index = val >> 5;
 	*byte_index = val & 0x1f;
 }
 #endif
 
-static void hdmi_set_dip_index(struct hda_codec *codec, hda_nid_t nid,
+static void hdmi_set_dip_index(struct hda_codec *codec, hda_nid_t pin_nid,
 				int packet_index, int byte_index)
 {
 	int val;
 
 	val = (packet_index << 5) | (byte_index & 0x1f);
 
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_HDMI_DIP_INDEX, val);
+	snd_hda_codec_write(codec, pin_nid, 0, AC_VERB_SET_HDMI_DIP_INDEX, val);
 }
 
-static void hdmi_write_dip_byte(struct hda_codec *codec, hda_nid_t nid,
+static void hdmi_write_dip_byte(struct hda_codec *codec, hda_nid_t pin_nid,
 				unsigned char val)
 {
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_HDMI_DIP_DATA, val);
+	snd_hda_codec_write(codec, pin_nid, 0, AC_VERB_SET_HDMI_DIP_DATA, val);
 }
 
-static void hdmi_enable_output(struct hda_codec *codec)
+static void hdmi_enable_output(struct hda_codec *codec, hda_nid_t pin_nid)
 {
 	/* Unmute */
 	if (get_wcaps(codec, pin_nid) & AC_WCAP_OUT_AMP)
@@ -231,7 +388,8 @@ static void hdmi_enable_output(struct hd
 /*
  * Enable Audio InfoFrame Transmission
  */
-static void hdmi_start_infoframe_trans(struct hda_codec *codec)
+static void hdmi_start_infoframe_trans(struct hda_codec *codec,
+				       hda_nid_t pin_nid)
 {
 	hdmi_set_dip_index(codec, pin_nid, 0x0, 0x0);
 	snd_hda_codec_write(codec, pin_nid, 0, AC_VERB_SET_HDMI_DIP_XMIT,
@@ -241,50 +399,53 @@ static void hdmi_start_infoframe_trans(s
 /*
  * Disable Audio InfoFrame Transmission
  */
-static void hdmi_stop_infoframe_trans(struct hda_codec *codec)
+static void hdmi_stop_infoframe_trans(struct hda_codec *codec,
+				      hda_nid_t pin_nid)
 {
 	hdmi_set_dip_index(codec, pin_nid, 0x0, 0x0);
 	snd_hda_codec_write(codec, pin_nid, 0, AC_VERB_SET_HDMI_DIP_XMIT,
 						AC_DIPXMIT_DISABLE);
 }
 
-static int hdmi_get_channel_count(struct hda_codec *codec)
+static int hdmi_get_channel_count(struct hda_codec *codec, hda_nid_t nid)
 {
-	return 1 + snd_hda_codec_read(codec, cvt_nid, 0,
+	return 1 + snd_hda_codec_read(codec, nid, 0,
 					AC_VERB_GET_CVT_CHAN_COUNT, 0);
 }
 
-static void hdmi_set_channel_count(struct hda_codec *codec, int chs)
+static void hdmi_set_channel_count(struct hda_codec *codec,
+				   hda_nid_t nid, int chs)
 {
-	snd_hda_codec_write(codec, cvt_nid, 0,
-					AC_VERB_SET_CVT_CHAN_COUNT, chs - 1);
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_CVT_CHAN_COUNT, chs - 1);
 
-	if (chs != hdmi_get_channel_count(codec))
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+	if (chs != hdmi_get_channel_count(codec, nid))
 		snd_printd(KERN_INFO "HDMI channel count: expect %d, get %d\n",
-					chs, hdmi_get_channel_count(codec));
+			   chs, hdmi_get_channel_count(codec, nid));
+#endif
 }
 
-static void hdmi_debug_channel_mapping(struct hda_codec *codec)
+static void hdmi_debug_channel_mapping(struct hda_codec *codec, hda_nid_t nid)
 {
 #ifdef CONFIG_SND_DEBUG_VERBOSE
 	int i;
 	int slot;
 
 	for (i = 0; i < 8; i++) {
-		slot = snd_hda_codec_read(codec, cvt_nid, 0,
+		slot = snd_hda_codec_read(codec, nid, 0,
 						AC_VERB_GET_HDMI_CHAN_SLOT, i);
 		printk(KERN_DEBUG "HDMI: ASP channel %d => slot %d\n",
-						slot >> 4, slot & 0x7);
+						slot >> 4, slot & 0xf);
 	}
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
 
@@ -293,7 +454,7 @@ static void hdmi_parse_eld(struct hda_co
  * Audio InfoFrame routines
  */
 
-static void hdmi_debug_dip_size(struct hda_codec *codec)
+static void hdmi_debug_dip_size(struct hda_codec *codec, hda_nid_t pin_nid)
 {
 #ifdef CONFIG_SND_DEBUG_VERBOSE
 	int i;
@@ -310,7 +471,7 @@ static void hdmi_debug_dip_size(struct h
 #endif
 }
 
-static void hdmi_clear_dip_buffers(struct hda_codec *codec)
+static void hdmi_clear_dip_buffers(struct hda_codec *codec, hda_nid_t pin_nid)
 {
 #ifdef BE_PARANOID
 	int i, j;
@@ -340,21 +501,17 @@ static void hdmi_clear_dip_buffers(struc
 }
 
 static void hdmi_fill_audio_infoframe(struct hda_codec *codec,
-					struct hdmi_audio_infoframe *ai)
+				      hda_nid_t pin_nid,
+				      struct hdmi_audio_infoframe *ai)
 {
 	u8 *params = (u8 *)ai;
-	u8 sum = 0;
 	int i;
 
-	hdmi_debug_dip_size(codec);
-	hdmi_clear_dip_buffers(codec); /* be paranoid */
-
-	for (i = 0; i < sizeof(ai); i++)
-		sum += params[i];
-	ai->checksum = - sum;
+	hdmi_debug_dip_size(codec, pin_nid);
+	hdmi_clear_dip_buffers(codec, pin_nid); /* be paranoid */
 
 	hdmi_set_dip_index(codec, pin_nid, 0x0, 0x0);
-	for (i = 0; i < sizeof(ai); i++)
+	for (i = 0; i < sizeof(*ai); i++)
 		hdmi_write_dip_byte(codec, pin_nid, params[i]);
 }
 
@@ -386,11 +543,11 @@ static void init_channel_allocations(voi
  *
  * TODO: it could select the wrong CA from multiple candidates.
 */
-static int hdmi_setup_channel_allocation(struct hda_codec *codec,
+static int hdmi_setup_channel_allocation(struct hda_codec *codec, hda_nid_t nid,
 					 struct hdmi_audio_infoframe *ai)
 {
 	struct intel_hdmi_spec *spec = codec->spec;
-	struct hdmi_eld *eld = &spec->sink_eld;
+	struct hdmi_eld *eld;
 	int i;
 	int spk_mask = 0;
 	int channels = 1 + (ai->CC02_CT47 & 0x7);
@@ -402,6 +559,11 @@ static int hdmi_setup_channel_allocation
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
@@ -439,8 +601,8 @@ static int hdmi_setup_channel_allocation
 	return ai->CA;
 }
 
-static void hdmi_setup_channel_mapping(struct hda_codec *codec,
-					struct hdmi_audio_infoframe *ai)
+static void hdmi_setup_channel_mapping(struct hda_codec *codec, hda_nid_t nid,
+				       struct hdmi_audio_infoframe *ai)
 {
 	int i;
 
@@ -453,17 +615,20 @@ static void hdmi_setup_channel_mapping(s
 	 */
 
 	for (i = 0; i < 8; i++)
-		snd_hda_codec_write(codec, cvt_nid, 0,
+		snd_hda_codec_write(codec, nid, 0,
 				    AC_VERB_SET_HDMI_CHAN_SLOT,
 				    (i << 4) | i);
 
-	hdmi_debug_channel_mapping(codec);
+	hdmi_debug_channel_mapping(codec, nid);
 }
 
 
-static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
+static void hdmi_setup_audio_infoframe(struct hda_codec *codec, hda_nid_t nid,
 					struct snd_pcm_substream *substream)
 {
+	struct intel_hdmi_spec *spec = codec->spec;
+	hda_nid_t pin_nid;
+	int i;
 	struct hdmi_audio_infoframe ai = {
 		.type		= 0x84,
 		.ver		= 0x01,
@@ -471,11 +636,23 @@ static void hdmi_setup_audio_infoframe(s
 		.CC02_CT47	= substream->runtime->channels - 1,
 	};
 
-	hdmi_setup_channel_allocation(codec, &ai);
-	hdmi_setup_channel_mapping(codec, &ai);
+	hdmi_setup_channel_allocation(codec, nid, &ai);
+	hdmi_setup_channel_mapping(codec, nid, &ai);
 
-	hdmi_fill_audio_infoframe(codec, &ai);
-	hdmi_start_infoframe_trans(codec);
+	for (i = 0; i < spec->num_pins; i++) {
+		if (spec->pin_cvt[i] != nid)
+			continue;
+		if (spec->sink_present[i] != true)
+			continue;
+
+		pin_nid = spec->pin[i];
+		if (memcmp(&ai, &spec->ai[i], sizeof(ai))) {
+			hdmi_stop_infoframe_trans(codec, pin_nid);
+			hdmi_fill_audio_infoframe(codec, pin_nid, &ai);
+			hdmi_start_infoframe_trans(codec, pin_nid);
+			spec->ai[i] = ai;
+		}
+	}
 }
 
 
@@ -485,27 +662,39 @@ static void hdmi_setup_audio_infoframe(s
 
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
@@ -520,10 +709,11 @@ static void hdmi_non_intrinsic_event(str
 
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
@@ -538,69 +728,60 @@ static void intel_hdmi_unsol_event(struc
  * Callbacks
  */
 
-static int intel_hdmi_playback_pcm_open(struct hda_pcm_stream *hinfo,
-					struct hda_codec *codec,
-					struct snd_pcm_substream *substream)
-{
-	struct intel_hdmi_spec *spec = codec->spec;
-
-	return snd_hda_multi_out_dig_open(codec, &spec->multiout);
-}
-
-static int intel_hdmi_playback_pcm_close(struct hda_pcm_stream *hinfo,
-					 struct hda_codec *codec,
-					 struct snd_pcm_substream *substream)
-{
-	struct intel_hdmi_spec *spec = codec->spec;
-
-	hdmi_stop_infoframe_trans(codec);
-
-	return snd_hda_multi_out_dig_close(codec, &spec->multiout);
-}
-
 static int intel_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 					   struct hda_codec *codec,
 					   unsigned int stream_tag,
 					   unsigned int format,
 					   struct snd_pcm_substream *substream)
 {
-	struct intel_hdmi_spec *spec = codec->spec;
-
-	snd_hda_multi_out_dig_prepare(codec, &spec->multiout, stream_tag,
-					     format, substream);
+	hdmi_set_channel_count(codec, hinfo->nid,
+			       substream->runtime->channels);
 
-	hdmi_set_channel_count(codec, substream->runtime->channels);
+	hdmi_setup_audio_infoframe(codec, hinfo->nid, substream);
 
-	hdmi_setup_audio_infoframe(codec, substream);
+	snd_hda_codec_setup_stream(codec, hinfo->nid, stream_tag, 0, format);
+	return 0;
+}
 
+static int intel_hdmi_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
+					   struct hda_codec *codec,
+					   struct snd_pcm_substream *substream)
+{
+	snd_hda_codec_cleanup_stream(codec, hinfo->nid);
 	return 0;
 }
 
 static struct hda_pcm_stream intel_hdmi_pcm_playback = {
 	.substreams = 1,
 	.channels_min = 2,
-	.channels_max = 8,
 	.ops = {
-		.open    = intel_hdmi_playback_pcm_open,
-		.close   = intel_hdmi_playback_pcm_close,
-		.prepare = intel_hdmi_playback_pcm_prepare
+		.prepare = intel_hdmi_playback_pcm_prepare,
+		.cleanup = intel_hdmi_playback_pcm_cleanup,
 	},
 };
 
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
+	for (i = 0; i < codec->num_pcms; i++, info++) {
+		unsigned int chans;
 
-	info->name = "INTEL HDMI";
-	info->pcm_type = HDA_PCM_TYPE_HDMI;
-	info->stream[SNDRV_PCM_STREAM_PLAYBACK] = intel_hdmi_pcm_playback;
+		chans = get_wcaps(codec, spec->cvt[i]);
+		chans = get_wcaps_channels(chans);
+
+		info->name = intel_hdmi_pcm_names[i];
+		info->pcm_type = HDA_PCM_TYPE_HDMI;
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK] =
+							intel_hdmi_pcm_playback;
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->cvt[i];
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max = chans;
+	}
 
 	return 0;
 }
@@ -609,29 +790,39 @@ static int intel_hdmi_build_controls(str
 {
 	struct intel_hdmi_spec *spec = codec->spec;
 	int err;
+	int i;
 
-	err = snd_hda_create_spdif_out_ctls(codec, spec->multiout.dig_out_nid);
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
-	hdmi_enable_output(codec);
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
 
@@ -643,22 +834,45 @@ static struct hda_codec_ops intel_hdmi_p
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
 
-	spec->multiout.num_dacs = 0;	  /* no analog */
-	spec->multiout.max_channels = 8;
-	spec->multiout.dig_out_nid = cvt_nid;
-
 	codec->spec = spec;
+	if (intel_hdmi_parse_codec(codec) < 0) {
+		codec->spec = NULL;
+		kfree(spec);
+		return -EINVAL;
+	}
+	if (memcmp(spec, static_specs + spec_id, sizeof(*spec)))
+		snd_printk(KERN_WARNING
+			   "HDMI: auto parse disagree with known config\n");
 	codec->patch_ops = intel_hdmi_patch_ops;
 
-	snd_hda_eld_proc_new(codec, &spec->sink_eld);
+	for (i = 0; i < spec->num_pins; i++)
+		snd_hda_eld_proc_new(codec, &spec->sink_eld[i], i);
 
 	init_channel_allocations();
 
@@ -667,16 +881,12 @@ static int do_patch_intel_hdmi(struct hd
 
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
@@ -684,7 +894,7 @@ static struct hda_codec_preset snd_hda_p
 	{ .id = 0x80862801, .name = "G45 DEVBLC", .patch = patch_intel_hdmi },
 	{ .id = 0x80862802, .name = "G45 DEVCTG", .patch = patch_intel_hdmi },
 	{ .id = 0x80862803, .name = "G45 DEVELK", .patch = patch_intel_hdmi },
-	{ .id = 0x80862804, .name = "G45 DEVIBX", .patch = patch_intel_hdmi },
+	{ .id = 0x80862804, .name = "G45 DEVIBX", .patch = patch_intel_hdmi_ibexpeak },
 	{ .id = 0x80860054, .name = "Q57 DEVIBX", .patch = patch_intel_hdmi_ibexpeak },
 	{ .id = 0x10951392, .name = "SiI1392 HDMI",     .patch = patch_intel_hdmi },
 	{} /* terminator */
@@ -718,3 +928,4 @@ static void __exit patch_intelhdmi_exit(
 
 module_init(patch_intelhdmi_init)
 module_exit(patch_intelhdmi_exit)
+
--- sound-2.6.orig/sound/pci/hda/hda_codec.c	2009-10-15 11:16:05.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_codec.c	2009-10-15 11:16:12.000000000 +0800
@@ -2885,43 +2885,26 @@ static int get_empty_pcm_device(struct h
 	static const char *dev_name[HDA_PCM_NTYPES] = {
 		"Audio", "SPDIF", "HDMI", "Modem"
 	};
-	/* starting device index for each PCM type */
-	static int dev_idx[HDA_PCM_NTYPES] = {
-		[HDA_PCM_TYPE_AUDIO] = 0,
-		[HDA_PCM_TYPE_SPDIF] = 1,
-		[HDA_PCM_TYPE_HDMI] = 3,
-		[HDA_PCM_TYPE_MODEM] = 6
+	/* audio device indices; not linear to keep compatibility */
+	static int audio_idx[HDA_PCM_NTYPES][5] = {
+		[HDA_PCM_TYPE_AUDIO] = { 0, 2, 4, 5, -1 },
+		[HDA_PCM_TYPE_SPDIF] = { 1, -1 },
+		[HDA_PCM_TYPE_HDMI]  = { 3, 7, 8, 9, -1 },
+		[HDA_PCM_TYPE_MODEM] = { 6, -1 },
 	};
-	/* normal audio device indices; not linear to keep compatibility */
-	static int audio_idx[4] = { 0, 2, 4, 5 };
-	int i, dev;
-
-	switch (type) {
-	case HDA_PCM_TYPE_AUDIO:
-		for (i = 0; i < ARRAY_SIZE(audio_idx); i++) {
-			dev = audio_idx[i];
-			if (!test_bit(dev, bus->pcm_dev_bits))
-				goto ok;
-		}
-		snd_printk(KERN_WARNING "Too many audio devices\n");
-		return -EAGAIN;
-	case HDA_PCM_TYPE_SPDIF:
-	case HDA_PCM_TYPE_HDMI:
-	case HDA_PCM_TYPE_MODEM:
-		dev = dev_idx[type];
-		if (test_bit(dev, bus->pcm_dev_bits)) {
-			snd_printk(KERN_WARNING "%s already defined\n",
-				   dev_name[type]);
-			return -EAGAIN;
-		}
-		break;
-	default:
+	int i;
+
+	if (type >= HDA_PCM_NTYPES) {
 		snd_printk(KERN_WARNING "Invalid PCM type %d\n", type);
 		return -EINVAL;
 	}
- ok:
-	set_bit(dev, bus->pcm_dev_bits);
-	return dev;
+
+	for (i = 0; audio_idx[type][i] >= 0 ; i++)
+		if (!test_and_set_bit(audio_idx[type][i], bus->pcm_dev_bits))
+			return audio_idx[type][i];
+
+	snd_printk(KERN_WARNING "Too many %s devices\n", dev_name[type]);
+	return -EAGAIN;
 }
 
 /*
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

--ibTvN161/egqYuK8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--ibTvN161/egqYuK8--
