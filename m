From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 3/7] ALSA: hda - hdmi: Fix programmed active
	channel count
Date: Sat,  5 Oct 2013 02:25:40 +0300
Message-ID: <1380929144-24944-4-git-send-email-anssi.hannula@iki.fi>
References: <1380929144-24944-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F6622616AC
 for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2013 01:26:07 +0200 (CEST)
In-Reply-To: <1380929144-24944-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently the converter channel count is set to the number of actual
input channels. The audio infoframe channel count field is set
similarly.

However, sometimes the used channel map does not map all input channels
to outputs. Notably, 3 channel modes (e.g. 2.1) require a dummy input
channel so there are 4 input channels. According to the HDA
specification, converter channel count should be programmed according to
the number of _active_ channels.

On Intel HDMI codecs (but not on NVIDIA), setting the converter channel
to a higher value than there are actually mapped channels to HDMI slots
will cause no audio to be output at all.

Note that the effects of this issue are currently partially masked by
other bugs that prevent the driver from actually unmapping channels in
certain cases. For example, if a 4 channel stream is first created and
prepared, it gets a FL,FR,RL,RR mapping (ALSA->HDMI slot mapping 0->0,
1->1, 2->4, 3->5). If one thereafter assigns a FR,FL,FC mapping to it,
the driver will remap 2->3 but fail to unmap 2->4 and 3->5, so there are
still 4 active channels and the issue will not trigger in this case.
These bugs will be fixed separately.

Fix the channel counts in the converter channel count field and in the
audio infoframe channel count field to match the actual number of active
channels.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 sound/pci/hda/patch_hdmi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 5244802..ac818cb 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -63,6 +63,7 @@ struct hdmi_spec_per_pin {
 	hda_nid_t pin_nid;
 	int num_mux_nids;
 	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
+	hda_nid_t cvt_nid;
 
 	struct hda_codec *codec;
 	struct hdmi_eld sink_eld;
@@ -902,8 +903,9 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 {
 	hda_nid_t pin_nid = per_pin->pin_nid;
 	int channels = per_pin->channels;
+	int active_channels;
 	struct hdmi_eld *eld;
-	int ca;
+	int ca, ordered_ca;
 	union audio_infoframe ai;
 
 	if (!channels)
@@ -925,6 +927,11 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 	if (ca < 0)
 		ca = 0;
 
+	ordered_ca = get_channel_allocation_order(ca);
+	active_channels = channel_allocations[ordered_ca].channels;
+
+	hdmi_set_channel_count(codec, per_pin->cvt_nid, active_channels);
+
 	memset(&ai, 0, sizeof(ai));
 	if (eld->info.conn_type == 0) { /* HDMI */
 		struct hdmi_audio_infoframe *hdmi_ai = &ai.hdmi;
@@ -932,7 +939,7 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 		hdmi_ai->type		= 0x84;
 		hdmi_ai->ver		= 0x01;
 		hdmi_ai->len		= 0x0a;
-		hdmi_ai->CC02_CT47	= channels - 1;
+		hdmi_ai->CC02_CT47	= active_channels - 1;
 		hdmi_ai->CA		= ca;
 		hdmi_checksum_audio_infoframe(hdmi_ai);
 	} else if (eld->info.conn_type == 1) { /* DisplayPort */
@@ -941,7 +948,7 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 		dp_ai->type		= 0x84;
 		dp_ai->len		= 0x1b;
 		dp_ai->ver		= 0x11 << 2;
-		dp_ai->CC02_CT47	= channels - 1;
+		dp_ai->CC02_CT47	= active_channels - 1;
 		dp_ai->CA		= ca;
 	} else {
 		snd_printd("HDMI: unknown connection type at pin %d\n",
@@ -959,7 +966,7 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 		snd_printdd("hdmi_setup_audio_infoframe: "
 			    "pin=%d channels=%d\n",
 			    pin_nid,
-			    channels);
+			    active_channels);
 		hdmi_setup_channel_mapping(codec, pin_nid, non_pcm, ca,
 					   channels, per_pin->chmap,
 					   per_pin->chmap_set);
@@ -1238,6 +1245,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	per_cvt = get_cvt(spec, cvt_idx);
 	/* Claim converter */
 	per_cvt->assigned = 1;
+	per_pin->cvt_nid = per_cvt->cvt_nid;
 	hinfo->nid = per_cvt->cvt_nid;
 
 	snd_hda_codec_write_cache(codec, per_pin->pin_nid, 0,
@@ -1560,8 +1568,6 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 	per_pin->channels = substream->runtime->channels;
 	per_pin->setup = true;
 
-	hdmi_set_channel_count(codec, cvt_nid, substream->runtime->channels);
-
 	hdmi_setup_audio_infoframe(codec, per_pin, non_pcm);
 
 	return hdmi_setup_stream(codec, cvt_nid, pin_nid, stream_tag, format);
-- 
1.8.1.5
