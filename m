From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 08/11] intelhdmi - sticky stream id and format
Date: Sun, 15 Nov 2009 19:32:27 +0800
Message-ID: <20091115114440.345255218@intel.com>
References: <20091115113219.606666087@intel.com>
Content-Type: multipart/mixed; boundary="===============3325059002994544817=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id CC26124154
	for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2009 12:46:13 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>, Shane W <shane-alsa@csy.ca>, =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>
List-Id: alsa-devel@alsa-project.org

--===============3325059002994544817==
Content-Disposition: inline; filename=hdmi-setup-stream.patch

We tracked down the first-0.5s-hdmi-audio-samples-lost problem to the
AC_VERB_SET_CHANNEL_STREAMID command. It is suspected that many HDMI
sinks need some time to adapt to the new state.

The workaround is to avoid changing stream id/format whenever possible.
Proposed by David.

Signed-off-by: David Härdeman <david@hardeman.nu>
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-11-05 13:56:58.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-11-05 13:58:05.000000000 +0800
@@ -772,6 +772,31 @@ static void intel_hdmi_unsol_event(struc
  * Callbacks
  */
 
+static void hdmi_setup_stream(struct hda_codec *codec, hda_nid_t nid,
+			      u32 stream_tag, int format)
+{
+	int tag;
+	int fmt;
+
+	tag = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0) >> 4;
+	fmt = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_STREAM_FORMAT, 0);
+
+	snd_printdd("hdmi_setup_stream: "
+		    "NID=0x%x, %sstream=0x%x, %sformat=0x%x\n",
+		    nid,
+		    tag == stream_tag ? "" : "new-",
+		    stream_tag,
+		    fmt == format ? "" : "new-",
+		    format);
+
+	if (tag != stream_tag)
+		snd_hda_codec_write(codec, nid, 0,
+				    AC_VERB_SET_CHANNEL_STREAMID, stream_tag << 4);
+	if (fmt != format)
+		snd_hda_codec_write(codec, nid, 0,
+				    AC_VERB_SET_STREAM_FORMAT, format);
+}
+
 static int intel_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 					   struct hda_codec *codec,
 					   unsigned int stream_tag,
@@ -783,7 +808,7 @@ static int intel_hdmi_playback_pcm_prepa
 
 	hdmi_setup_audio_infoframe(codec, hinfo->nid, substream);
 
-	snd_hda_codec_setup_stream(codec, hinfo->nid, stream_tag, 0, format);
+	hdmi_setup_stream(codec, hinfo->nid, stream_tag, format);
 	return 0;
 }
 
@@ -791,7 +816,6 @@ static int intel_hdmi_playback_pcm_clean
 					   struct hda_codec *codec,
 					   struct snd_pcm_substream *substream)
 {
-	snd_hda_codec_cleanup_stream(codec, hinfo->nid);
 	return 0;
 }
 



--===============3325059002994544817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3325059002994544817==--
