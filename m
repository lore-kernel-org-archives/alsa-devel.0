From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda: move open coded tricks into
	get_wcaps_channels()
Date: Mon, 24 Aug 2009 09:50:46 +0800
Message-ID: <20090824015046.GA10025@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 4397524398
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Aug 2009 03:51:16 +0200 (CEST)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_local.h     |   10 ++++++++++
 sound/pci/hda/hda_proc.c      |    4 +---
 sound/pci/hda/patch_atihdmi.c |    3 +--
 3 files changed, 12 insertions(+), 5 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_local.h	2009-08-24 09:48:57.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_local.h	2009-08-24 09:49:44.000000000 +0800
@@ -410,6 +410,16 @@ static inline u32 get_wcaps(struct hda_c
 /* get the widget type from widget capability bits */
 #define get_wcaps_type(wcaps) (((wcaps) & AC_WCAP_TYPE) >> AC_WCAP_TYPE_SHIFT)
 
+static inline unsigned int get_wcaps_channels(u32 wcaps)
+{
+	unsigned int chans;
+
+	chans = (wcaps & AC_WCAP_CHAN_CNT_EXT) >> 13;
+	chans = ((chans << 1) | 1) + 1;
+
+	return chans;
+}
+
 u32 query_amp_caps(struct hda_codec *codec, hda_nid_t nid, int direction);
 int snd_hda_override_amp_caps(struct hda_codec *codec, hda_nid_t nid, int dir,
 			      unsigned int caps);
--- sound-2.6.orig/sound/pci/hda/hda_proc.c	2009-08-24 09:48:57.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_proc.c	2009-08-24 09:49:44.000000000 +0800
@@ -515,9 +515,7 @@ static void print_codec_info(struct snd_
 		snd_iprintf(buffer, "Node 0x%02x [%s] wcaps 0x%x:", nid,
 			    get_wid_type_name(wid_type), wid_caps);
 		if (wid_caps & AC_WCAP_STEREO) {
-			unsigned int chans;
-			chans = (wid_caps & AC_WCAP_CHAN_CNT_EXT) >> 13;
-			chans = ((chans << 1) | 1) + 1;
+			unsigned int chans = get_wcaps_channels(wid_caps);
 			if (chans == 2)
 				snd_iprintf(buffer, " Stereo");
 			else
--- sound-2.6.orig/sound/pci/hda/patch_atihdmi.c	2009-08-24 09:48:57.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_atihdmi.c	2009-08-24 09:49:44.000000000 +0800
@@ -141,8 +141,7 @@ static int atihdmi_build_pcms(struct hda
 	/* FIXME: we must check ELD and change the PCM parameters dynamically
 	 */
 	chans = get_wcaps(codec, CVT_NID);
-	chans = (chans & AC_WCAP_CHAN_CNT_EXT) >> 13;
-	chans = ((chans << 1) | 1) + 1;
+	chans = get_wcaps_channels(chans);
 	info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max = chans;
 
 	return 0;
