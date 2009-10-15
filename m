From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 05/11] hda - remove intelhdmi dependency on
	multiout
Date: Thu, 15 Oct 2009 15:03:53 +0800
Message-ID: <20091015070918.431446053@intel.com>
References: <20091015070348.390451250@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D9B8103937
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Oct 2009 09:10:13 +0200 (CEST)
Content-Disposition: inline; filename=hdmi-remove-multiout.patch
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

We'll be managing multiple HDMI audio sources/sinks on our own.
So remove multiout dependency from intelhdmi.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-10-15 12:31:57.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-10-15 12:33:18.000000000 +0800
@@ -39,7 +39,6 @@ static hda_nid_t pin_nid;	/* HDMI output
 #define INTEL_HDMI_EVENT_TAG		0x08
 
 struct intel_hdmi_spec {
-	struct hda_multi_out multiout;
 	struct hda_pcm pcm_rec;
 	struct hdmi_eld sink_eld;
 };
@@ -548,9 +547,7 @@ static int intel_hdmi_playback_pcm_open(
 					struct hda_codec *codec,
 					struct snd_pcm_substream *substream)
 {
-	struct intel_hdmi_spec *spec = codec->spec;
-
-	return snd_hda_multi_out_dig_open(codec, &spec->multiout);
+	return 0;
 }
 
 static int intel_hdmi_playback_pcm_close(struct hda_pcm_stream *hinfo,
@@ -561,7 +558,8 @@ static int intel_hdmi_playback_pcm_close
 
 	hdmi_stop_infoframe_trans(codec, pin_nid);
 
-	return snd_hda_multi_out_dig_close(codec, &spec->multiout);
+	snd_hda_codec_cleanup_stream(codec, hinfo->nid);
+	return 0;
 }
 
 static int intel_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
@@ -570,15 +568,12 @@ static int intel_hdmi_playback_pcm_prepa
 					   unsigned int format,
 					   struct snd_pcm_substream *substream)
 {
-	struct intel_hdmi_spec *spec = codec->spec;
-
-	snd_hda_multi_out_dig_prepare(codec, &spec->multiout, stream_tag,
-					     format, substream);
-
-	hdmi_set_channel_count(codec, cvt_nid, substream->runtime->channels);
+	hdmi_set_channel_count(codec, cvt_nid,
+			       substream->runtime->channels);
 
 	hdmi_setup_audio_infoframe(codec, cvt_nid, substream);
 
+	snd_hda_codec_setup_stream(codec, hinfo->nid, stream_tag, 0, format);
 	return 0;
 }
 
@@ -616,7 +611,7 @@ static int intel_hdmi_build_controls(str
 	struct intel_hdmi_spec *spec = codec->spec;
 	int err;
 
-	err = snd_hda_create_spdif_out_ctls(codec, spec->multiout.dig_out_nid);
+	err = snd_hda_create_spdif_out_ctls(codec, cvt_nid);
 	if (err < 0)
 		return err;
 
@@ -657,10 +652,6 @@ static int do_patch_intel_hdmi(struct hd
 	if (spec == NULL)
 		return -ENOMEM;
 
-	spec->multiout.num_dacs = 0;	  /* no analog */
-	spec->multiout.max_channels = 8;
-	spec->multiout.dig_out_nid = cvt_nid;
-
 	codec->spec = spec;
 	codec->patch_ops = intel_hdmi_patch_ops;
