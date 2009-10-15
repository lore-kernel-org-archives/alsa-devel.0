From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 07/11] hda - reorder intelhdmi prepare/cleanup
	callbacks
Date: Thu, 15 Oct 2009 15:03:55 +0800
Message-ID: <20091015070918.703247292@intel.com>
References: <20091015070348.390451250@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 32CB710393F
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Oct 2009 09:10:15 +0200 (CEST)
Content-Disposition: inline; filename=hdmi-swap-pcm-prepare-cleanup.patch
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
 sound/pci/hda/patch_intelhdmi.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-10-15 10:19:14.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-10-15 10:19:31.000000000 +0800
@@ -543,30 +543,30 @@ static void intel_hdmi_unsol_event(struc
  * Callbacks
  */
 
-static int intel_hdmi_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
+static int intel_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 					   struct hda_codec *codec,
+					   unsigned int stream_tag,
+					   unsigned int format,
 					   struct snd_pcm_substream *substream)
 {
-	struct intel_hdmi_spec *spec = codec->spec;
+	hdmi_set_channel_count(codec, cvt_nid,
+			       substream->runtime->channels);
 
-	hdmi_stop_infoframe_trans(codec, pin_nid);
+	hdmi_setup_audio_infoframe(codec, cvt_nid, substream);
 
-	snd_hda_codec_cleanup_stream(codec, hinfo->nid);
+	snd_hda_codec_setup_stream(codec, hinfo->nid, stream_tag, 0, format);
 	return 0;
 }
 
-static int intel_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
+static int intel_hdmi_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
 					   struct hda_codec *codec,
-					   unsigned int stream_tag,
-					   unsigned int format,
 					   struct snd_pcm_substream *substream)
 {
-	hdmi_set_channel_count(codec, cvt_nid,
-			       substream->runtime->channels);
+	struct intel_hdmi_spec *spec = codec->spec;
 
-	hdmi_setup_audio_infoframe(codec, cvt_nid, substream);
+	hdmi_stop_infoframe_trans(codec, pin_nid);
 
-	snd_hda_codec_setup_stream(codec, hinfo->nid, stream_tag, 0, format);
+	snd_hda_codec_cleanup_stream(codec, hinfo->nid);
 	return 0;
 }
