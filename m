From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 3/5] intelhdmi - channel mapping applies to Pin
Date: Fri, 11 Dec 2009 12:28:35 +0800
Message-ID: <20091211043213.152769523@intel.com>
References: <20091211042832.691808920@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 017D61037EA
	for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2009 05:32:41 +0100 (CET)
Content-Disposition: inline; filename=hdmi-channel-mapping-fix-to-pin.patch
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
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>, Shane W <shane-alsa@csy.ca>
List-Id: alsa-devel@alsa-project.org

HDA036-A specifies that the Audio Sample Packet (ASP) Channel Mapping
verbs apply to Digital Display Pin Complex instead of Converter.

With this fix, channel mapping is working as expected for IbexPeak.

Thanks to Marcin for pointing this out!

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-11-24 09:10:55.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-11-24 09:11:01.000000000 +0800
@@ -436,14 +436,15 @@ static void hdmi_set_channel_count(struc
 				    AC_VERB_SET_CVT_CHAN_COUNT, chs - 1);
 }
 
-static void hdmi_debug_channel_mapping(struct hda_codec *codec, hda_nid_t nid)
+static void hdmi_debug_channel_mapping(struct hda_codec *codec,
+				       hda_nid_t pin_nid)
 {
 #ifdef CONFIG_SND_DEBUG_VERBOSE
 	int i;
 	int slot;
 
 	for (i = 0; i < 8; i++) {
-		slot = snd_hda_codec_read(codec, nid, 0,
+		slot = snd_hda_codec_read(codec, pin_nid, 0,
 						AC_VERB_GET_HDMI_CHAN_SLOT, i);
 		printk(KERN_DEBUG "HDMI: ASP channel %d => slot %d\n",
 						slot >> 4, slot & 0xf);
@@ -619,7 +620,8 @@ static int hdmi_setup_channel_allocation
 	return ai->CA;
 }
 
-static void hdmi_setup_channel_mapping(struct hda_codec *codec, hda_nid_t nid,
+static void hdmi_setup_channel_mapping(struct hda_codec *codec,
+				       hda_nid_t pin_nid,
 				       struct hdmi_audio_infoframe *ai)
 {
 	int i;
@@ -633,11 +635,11 @@ static void hdmi_setup_channel_mapping(s
 	 */
 
 	for (i = 0; i < 8; i++)
-		snd_hda_codec_write(codec, nid, 0,
+		snd_hda_codec_write(codec, pin_nid, 0,
 				    AC_VERB_SET_HDMI_CHAN_SLOT,
 				    (i << 4) | i);
 
-	hdmi_debug_channel_mapping(codec, nid);
+	hdmi_debug_channel_mapping(codec, pin_nid);
 }
 
 static bool hdmi_infoframe_uptodate(struct hda_codec *codec, hda_nid_t pin_nid,
@@ -676,7 +678,6 @@ static void hdmi_setup_audio_infoframe(s
 	};
 
 	hdmi_setup_channel_allocation(codec, nid, &ai);
-	hdmi_setup_channel_mapping(codec, nid, &ai);
 
 	for (i = 0; i < spec->num_pins; i++) {
 		if (spec->pin_cvt[i] != nid)
@@ -686,6 +687,7 @@ static void hdmi_setup_audio_infoframe(s
 
 		pin_nid = spec->pin[i];
 		if (!hdmi_infoframe_uptodate(codec, pin_nid, &ai)) {
+			hdmi_setup_channel_mapping(codec, pin_nid, &ai);
 			hdmi_stop_infoframe_trans(codec, pin_nid);
 			hdmi_fill_audio_infoframe(codec, pin_nid, &ai);
 			hdmi_start_infoframe_trans(codec, pin_nid);
