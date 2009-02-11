From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 2/4] hda - enable HDMI audio pin out at module
	loading time
Date: Wed, 11 Feb 2009 15:22:29 +0800
Message-ID: <20090211073402.680690787@intel.com>
References: <20090211072227.760779741@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E50A103895
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 08:56:19 +0100 (CET)
Content-Disposition: inline; filename=intel-hdmi-oneshot-enable.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Shane W <shane-alsa@csy.ca>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

We found that enabling/disabling HDMI audio pin out at stream start/stop
time will kill the leading 500ms or so sound samples. Avoid this by enabling
pin out once and for ever at module loading time.

The leading ~500ms audio samples will still be lost when switching from
X-channel playback to Y-channel playback where X != Y. However there's no
much we can do about it: the audio infoframe has to change and it looks like
either G45 or YAMAHA requires some time to switch the configuration.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   42 +++++++++++++-----------------
 1 file changed, 19 insertions(+), 23 deletions(-)

--- mm.orig/sound/pci/hda/patch_intelhdmi.c
+++ mm/sound/pci/hda/patch_intelhdmi.c
@@ -49,11 +49,6 @@ static struct hda_verb pinout_enable_ver
 	{} /* terminator */
 };
 
-static struct hda_verb pinout_disable_verb[] = {
-	{PIN_NID, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00},
-	{}
-};
-
 static struct hda_verb unsolicited_response_verb[] = {
 	{PIN_NID, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN |
 						  INTEL_HDMI_EVENT_TAG},
@@ -248,10 +243,6 @@ static void hdmi_write_dip_byte(struct h
 
 static void hdmi_enable_output(struct hda_codec *codec)
 {
-	/* Enable Audio InfoFrame Transmission */
-	hdmi_set_dip_index(codec, PIN_NID, 0x0, 0x0);
-	snd_hda_codec_write(codec, PIN_NID, 0, AC_VERB_SET_HDMI_DIP_XMIT,
-						AC_DIPXMIT_BEST);
 	/* Unmute */
 	if (get_wcaps(codec, PIN_NID) & AC_WCAP_OUT_AMP)
 		snd_hda_codec_write(codec, PIN_NID, 0,
@@ -260,17 +251,24 @@ static void hdmi_enable_output(struct hd
 	snd_hda_sequence_write(codec, pinout_enable_verb);
 }
 
-static void hdmi_disable_output(struct hda_codec *codec)
+/*
+ * Enable Audio InfoFrame Transmission
+ */
+static void hdmi_start_infoframe_trans(struct hda_codec *codec)
 {
-	snd_hda_sequence_write(codec, pinout_disable_verb);
-	if (get_wcaps(codec, PIN_NID) & AC_WCAP_OUT_AMP)
-		snd_hda_codec_write(codec, PIN_NID, 0,
-				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+	hdmi_set_dip_index(codec, PIN_NID, 0x0, 0x0);
+	snd_hda_codec_write(codec, PIN_NID, 0, AC_VERB_SET_HDMI_DIP_XMIT,
+						AC_DIPXMIT_BEST);
+}
 
-	/*
-	 * FIXME: noises may arise when playing music after reloading the
-	 * kernel module, until the next X restart or monitor repower.
-	 */
+/*
+ * Disable Audio InfoFrame Transmission
+ */
+static void hdmi_stop_infoframe_trans(struct hda_codec *codec)
+{
+	hdmi_set_dip_index(codec, PIN_NID, 0x0, 0x0);
+	snd_hda_codec_write(codec, PIN_NID, 0, AC_VERB_SET_HDMI_DIP_XMIT,
+						AC_DIPXMIT_DISABLE);
 }
 
 static int hdmi_get_channel_count(struct hda_codec *codec)
@@ -489,6 +487,7 @@ static void hdmi_setup_audio_infoframe(s
 	hdmi_setup_channel_mapping(codec, &ai);
 
 	hdmi_fill_audio_infoframe(codec, &ai);
+	hdmi_start_infoframe_trans(codec);
 }
 
 
@@ -566,7 +565,7 @@ static int intel_hdmi_playback_pcm_close
 {
 	struct intel_hdmi_spec *spec = codec->spec;
 
-	hdmi_disable_output(codec);
+	hdmi_stop_infoframe_trans(codec);
 
 	return snd_hda_multi_out_dig_close(codec, &spec->multiout);
 }
@@ -586,8 +585,6 @@ static int intel_hdmi_playback_pcm_prepa
 
 	hdmi_setup_audio_infoframe(codec, substream);
 
-	hdmi_enable_output(codec);
-
 	return 0;
 }
 
@@ -632,8 +629,7 @@ static int intel_hdmi_build_controls(str
 
 static int intel_hdmi_init(struct hda_codec *codec)
 {
-	/* disable audio output as early as possible */
-	hdmi_disable_output(codec);
+	hdmi_enable_output(codec);
 
 	snd_hda_sequence_write(codec, unsolicited_response_verb);
 

-- 
