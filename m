From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 07/11] intelhdmi - sticky infoframe
Date: Sun, 15 Nov 2009 19:32:26 +0800
Message-ID: <20091115114440.214195260@intel.com>
References: <20091115113219.606666087@intel.com>
Content-Type: multipart/mixed; boundary="===============4272755697412814473=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 9736D24154
	for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2009 12:46:15 +0100 (CET)
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

--===============4272755697412814473==
Content-Disposition: inline; filename=hdmi-sticky-infoframe.patch

Remember the active infoframe, so as to avoid stop/restart infoframe
transmission when switching between audio clips of the same format.

Proposed by Shang and David.

CC: Shane W <shane-alsa@csy.ca>
CC: David Härdeman <david@hardeman.nu>
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   38 ++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 12 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-11-05 13:52:12.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-11-05 13:56:58.000000000 +0800
@@ -646,6 +646,27 @@ static void hdmi_setup_channel_mapping(s
 	hdmi_debug_channel_mapping(codec, nid);
 }
 
+static bool hdmi_infoframe_uptodate(struct hda_codec *codec, hda_nid_t pin_nid,
+				    struct hdmi_audio_infoframe *ai)
+{
+	u8 *bytes = (u8 *)ai;
+	u8 val;
+	int i;
+
+	if (snd_hda_codec_read(codec, pin_nid, 0, AC_VERB_GET_HDMI_DIP_XMIT, 0)
+							    != AC_DIPXMIT_BEST)
+		return false;
+
+	hdmi_set_dip_index(codec, pin_nid, 0x0, 0x0);
+	for (i = 0; i < sizeof(*ai); i++) {
+		val = snd_hda_codec_read(codec, pin_nid, 0,
+					 AC_VERB_GET_HDMI_DIP_DATA, 0);
+		if (val != bytes[i])
+			return false;
+	}
+
+	return true;
+}
 
 static void hdmi_setup_audio_infoframe(struct hda_codec *codec, hda_nid_t nid,
 					struct snd_pcm_substream *substream)
@@ -670,8 +691,11 @@ static void hdmi_setup_audio_infoframe(s
 			continue;
 
 		pin_nid = spec->pin[i];
-		hdmi_fill_audio_infoframe(codec, pin_nid, &ai);
-		hdmi_start_infoframe_trans(codec, pin_nid);
+		if (!hdmi_infoframe_uptodate(codec, pin_nid, &ai)) {
+			hdmi_stop_infoframe_trans(codec, pin_nid);
+			hdmi_fill_audio_infoframe(codec, pin_nid, &ai);
+			hdmi_start_infoframe_trans(codec, pin_nid);
+		}
 	}
 }
 
@@ -767,16 +791,6 @@ static int intel_hdmi_playback_pcm_clean
 					   struct hda_codec *codec,
 					   struct snd_pcm_substream *substream)
 {
-	struct intel_hdmi_spec *spec = codec->spec;
-	int i;
-
-	for (i = 0; i < spec->num_pins; i++) {
-		if (spec->pin_cvt[i] != hinfo->nid)
-			continue;
-
-		hdmi_stop_infoframe_trans(codec, spec->pin[i]);
-	}
-
 	snd_hda_codec_cleanup_stream(codec, hinfo->nid);
 	return 0;
 }



--===============4272755697412814473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4272755697412814473==--
