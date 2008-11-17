From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda-intel: reorder HDMI audio enabling sequence
Date: Mon, 17 Nov 2008 16:57:33 +0800
Message-ID: <20081117085733.GA17334@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id BE9AF1037EE
	for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2008 09:57:53 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Reorder HDMI audio enabling sequence so that
	1) the sink knows about the coming audio stream
	2) unmute
	3) start transferring audio samples

The theory is that in the path A=>B=>C, we first make C ready, and then
enable B, and lastly allow A to send audio samples.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
@@ -312,16 +312,16 @@ static void hdmi_write_dip_byte(struct h
 
 static void hdmi_enable_output(struct hda_codec *codec)
 {
-	/* Enable pin out and unmute */
-	snd_hda_sequence_write(codec, pinout_enable_verb);
-	if (get_wcaps(codec, PIN_NID) & AC_WCAP_OUT_AMP)
-		snd_hda_codec_write(codec, PIN_NID, 0,
-				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
-
 	/* Enable Audio InfoFrame Transmission */
 	hdmi_set_dip_index(codec, PIN_NID, 0x0, 0x0);
 	snd_hda_codec_write(codec, PIN_NID, 0, AC_VERB_SET_HDMI_DIP_XMIT,
 						AC_DIPXMIT_BEST);
+	/* Unmute */
+	if (get_wcaps(codec, PIN_NID) & AC_WCAP_OUT_AMP)
+		snd_hda_codec_write(codec, PIN_NID, 0,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+	/* Enable pin out */
+	snd_hda_sequence_write(codec, pinout_enable_verb);
 }
 
 static void hdmi_disable_output(struct hda_codec *codec)
