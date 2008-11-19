From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 4/4] hda: HDMI channel mapping cleanups
Date: Wed, 19 Nov 2008 08:56:18 +0800
Message-ID: <20081119013904.977235568@linux.intel.com>
References: <20081119005614.431653658@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 54BC1244E9
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 02:41:28 +0100 (CET)
Content-Disposition: inline; filename=alsa-speakers2.patch
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

Refactor the channel mapping code for consistent naming
and make it more informed about channel allocations.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
@@ -290,7 +290,7 @@ static void hdmi_set_channel_count(struc
 				chs, hdmi_get_channel_count(codec));
 }
 
-static void hdmi_debug_slot_mapping(struct hda_codec *codec)
+static void hdmi_debug_channel_mapping(struct hda_codec *codec)
 {
 #ifdef CONFIG_SND_DEBUG_VERBOSE
 	int i;
@@ -305,13 +305,6 @@ static void hdmi_debug_slot_mapping(stru
 #endif
 }
 
-static void hdmi_setup_channel_mapping(struct hda_codec *codec)
-{
-	snd_hda_sequence_write(codec, def_chan_map);
-	hdmi_debug_slot_mapping(codec);
-}
-
-
 static void hdmi_parse_eld(struct hda_codec *codec)
 {
 	struct intel_hdmi_spec *spec = codec->spec;
@@ -461,6 +454,22 @@ static int hdmi_setup_channel_allocation
 	return -1;
 }
 
+static void hdmi_setup_channel_mapping(struct hda_codec *codec,
+					struct hdmi_audio_infoframe *ai)
+{
+	if (!ai->CA)
+		return;
+
+	/*
+	 * TODO: adjust channel mapping if necessary
+	 * ALSA sequence is front/surr/clfe/side?
+	 */
+
+	snd_hda_sequence_write(codec, def_chan_map);
+	hdmi_debug_channel_mapping(codec);
+}
+
+
 static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 					struct snd_pcm_substream *substream)
 {
@@ -472,6 +481,7 @@ static void hdmi_setup_audio_infoframe(s
 	};
 
 	hdmi_setup_channel_allocation(codec, &ai);
+	hdmi_setup_channel_mapping(codec, &ai);
 
 	hdmi_fill_audio_infoframe(codec, &ai);
 }
@@ -569,9 +579,6 @@ static int intel_hdmi_playback_pcm_prepa
 
 	hdmi_set_channel_count(codec, substream->runtime->channels);
 
-	/* wfg: channel mapping not supported by DEVCTG */
-	hdmi_setup_channel_mapping(codec);
-
 	hdmi_setup_audio_infoframe(codec, substream);
 
 	hdmi_enable_output(codec);

-- 
