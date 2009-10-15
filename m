From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 04/11] hda - convert intelhdmi global
	references to local parameters
Date: Thu, 15 Oct 2009 15:03:52 +0800
Message-ID: <20091015070918.298545777@intel.com>
References: <20091015070348.390451250@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id D050E103937
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Oct 2009 09:10:17 +0200 (CEST)
Content-Disposition: inline; filename=hdmi-local-pin-params.patch
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

No behavior change.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   80 ++++++++++++++++--------------
 1 file changed, 43 insertions(+), 37 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-10-15 10:18:16.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-10-15 10:19:06.000000000 +0800
@@ -189,35 +189,36 @@ static struct cea_channel_speaker_alloca
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
@@ -231,7 +232,8 @@ static void hdmi_enable_output(struct hd
 /*
  * Enable Audio InfoFrame Transmission
  */
-static void hdmi_start_infoframe_trans(struct hda_codec *codec)
+static void hdmi_start_infoframe_trans(struct hda_codec *codec,
+				       hda_nid_t pin_nid)
 {
 	hdmi_set_dip_index(codec, pin_nid, 0x0, 0x0);
 	snd_hda_codec_write(codec, pin_nid, 0, AC_VERB_SET_HDMI_DIP_XMIT,
@@ -241,37 +243,40 @@ static void hdmi_start_infoframe_trans(s
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
 						slot >> 4, slot & 0x7);
@@ -293,7 +298,7 @@ static void hdmi_parse_eld(struct hda_co
  * Audio InfoFrame routines
  */
 
-static void hdmi_debug_dip_size(struct hda_codec *codec)
+static void hdmi_debug_dip_size(struct hda_codec *codec, hda_nid_t pin_nid)
 {
 #ifdef CONFIG_SND_DEBUG_VERBOSE
 	int i;
@@ -310,7 +315,7 @@ static void hdmi_debug_dip_size(struct h
 #endif
 }
 
-static void hdmi_clear_dip_buffers(struct hda_codec *codec)
+static void hdmi_clear_dip_buffers(struct hda_codec *codec, hda_nid_t pin_nid)
 {
 #ifdef BE_PARANOID
 	int i, j;
@@ -340,14 +345,15 @@ static void hdmi_clear_dip_buffers(struc
 }
 
 static void hdmi_fill_audio_infoframe(struct hda_codec *codec,
-					struct hdmi_audio_infoframe *ai)
+				      hda_nid_t pin_nid,
+				      struct hdmi_audio_infoframe *ai)
 {
 	u8 *params = (u8 *)ai;
 	u8 sum = 0;
 	int i;
 
-	hdmi_debug_dip_size(codec);
-	hdmi_clear_dip_buffers(codec); /* be paranoid */
+	hdmi_debug_dip_size(codec, pin_nid);
+	hdmi_clear_dip_buffers(codec, pin_nid); /* be paranoid */
 
 	for (i = 0; i < sizeof(ai); i++)
 		sum += params[i];
@@ -386,7 +392,7 @@ static void init_channel_allocations(voi
  *
  * TODO: it could select the wrong CA from multiple candidates.
 */
-static int hdmi_setup_channel_allocation(struct hda_codec *codec,
+static int hdmi_setup_channel_allocation(struct hda_codec *codec, hda_nid_t nid,
 					 struct hdmi_audio_infoframe *ai)
 {
 	struct intel_hdmi_spec *spec = codec->spec;
@@ -439,8 +445,8 @@ static int hdmi_setup_channel_allocation
 	return ai->CA;
 }
 
-static void hdmi_setup_channel_mapping(struct hda_codec *codec,
-					struct hdmi_audio_infoframe *ai)
+static void hdmi_setup_channel_mapping(struct hda_codec *codec, hda_nid_t nid,
+				       struct hdmi_audio_infoframe *ai)
 {
 	int i;
 
@@ -453,15 +459,15 @@ static void hdmi_setup_channel_mapping(s
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
 	struct hdmi_audio_infoframe ai = {
@@ -471,11 +477,11 @@ static void hdmi_setup_audio_infoframe(s
 		.CC02_CT47	= substream->runtime->channels - 1,
 	};
 
-	hdmi_setup_channel_allocation(codec, &ai);
-	hdmi_setup_channel_mapping(codec, &ai);
+	hdmi_setup_channel_allocation(codec, nid, &ai);
+	hdmi_setup_channel_mapping(codec, nid, &ai);
 
-	hdmi_fill_audio_infoframe(codec, &ai);
-	hdmi_start_infoframe_trans(codec);
+	hdmi_fill_audio_infoframe(codec, pin_nid, &ai);
+	hdmi_start_infoframe_trans(codec, pin_nid);
 }
 
 
@@ -553,7 +559,7 @@ static int intel_hdmi_playback_pcm_close
 {
 	struct intel_hdmi_spec *spec = codec->spec;
 
-	hdmi_stop_infoframe_trans(codec);
+	hdmi_stop_infoframe_trans(codec, pin_nid);
 
 	return snd_hda_multi_out_dig_close(codec, &spec->multiout);
 }
@@ -569,9 +575,9 @@ static int intel_hdmi_playback_pcm_prepa
 	snd_hda_multi_out_dig_prepare(codec, &spec->multiout, stream_tag,
 					     format, substream);
 
-	hdmi_set_channel_count(codec, substream->runtime->channels);
+	hdmi_set_channel_count(codec, cvt_nid, substream->runtime->channels);
 
-	hdmi_setup_audio_infoframe(codec, substream);
+	hdmi_setup_audio_infoframe(codec, cvt_nid, substream);
 
 	return 0;
 }
@@ -619,7 +625,7 @@ static int intel_hdmi_build_controls(str
 
 static int intel_hdmi_init(struct hda_codec *codec)
 {
-	hdmi_enable_output(codec);
+	hdmi_enable_output(codec, pin_nid);
 
 	snd_hda_codec_write(codec, pin_nid, 0,
 			    AC_VERB_SET_UNSOLICITED_ENABLE,
