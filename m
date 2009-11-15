From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 09/11] intelhdmi - sticky channel count
Date: Sun, 15 Nov 2009 19:32:28 +0800
Message-ID: <20091115114440.434676294@intel.com>
References: <20091115113219.606666087@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 069C52415A
	for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2009 12:46:15 +0100 (CET)
Content-Disposition: inline; filename=hdmi-sticky-channel-count.patch
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

Don't change channel count if not necessary.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-11-05 16:48:43.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-11-05 16:49:22.000000000 +0800
@@ -422,24 +422,18 @@ static void hdmi_stop_infoframe_trans(st
 						AC_DIPXMIT_DISABLE);
 }
 
-#ifdef CONFIG_SND_DEBUG_VERBOSE
 static int hdmi_get_channel_count(struct hda_codec *codec, hda_nid_t nid)
 {
 	return 1 + snd_hda_codec_read(codec, nid, 0,
 					AC_VERB_GET_CVT_CHAN_COUNT, 0);
 }
-#endif
 
 static void hdmi_set_channel_count(struct hda_codec *codec,
 				   hda_nid_t nid, int chs)
 {
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_CVT_CHAN_COUNT, chs - 1);
-
-#ifdef CONFIG_SND_DEBUG_VERBOSE
 	if (chs != hdmi_get_channel_count(codec, nid))
-		snd_printd(KERN_INFO "HDMI channel count: expect %d, get %d\n",
-			   chs, hdmi_get_channel_count(codec, nid));
-#endif
+		snd_hda_codec_write(codec, nid, 0,
+				    AC_VERB_SET_CVT_CHAN_COUNT, chs - 1);
 }
 
 static void hdmi_debug_channel_mapping(struct hda_codec *codec, hda_nid_t nid)
