From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 1/5] hda: minor code cleanups
Date: Wed, 19 Nov 2008 15:13:59 +0800
Message-ID: <20081119072203.399139818@linux.intel.com>
References: <20081119071358.231716724@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CB4C245C2
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 08:26:00 +0100 (CET)
Content-Disposition: inline; filename=alsa-hdmi-cleanups.patch
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

Some minor code cleanups.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/hda_eld.c         |    2 +-
 sound/pci/hda/patch_intelhdmi.c |   18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
@@ -85,7 +85,7 @@ struct hdmi_audio_infoframe {
 	u8 CXT04;
 	u8 CA;
 	u8 LFEPBL01_LSV36_DM_INH7;
-	u8 reserved[5];	/* PB6  - PB10 */
+	u8 reserved[5];	/* PB6 - PB10 */
 };
 
 /*
@@ -160,7 +160,7 @@ static struct cea_channel_speaker_alloca
 { .ca_index = 0x00,  .speakers = {   0,    0,   0,   0,   0,    0,  FR,  FL } },
 				 /* 2.1 */
 { .ca_index = 0x01,  .speakers = {   0,    0,   0,   0,   0,  LFE,  FR,  FL } },
-				 /* dolby surround */
+				 /* Dolby Surround */
 { .ca_index = 0x02,  .speakers = {   0,    0,   0,   0,  FC,    0,  FR,  FL } },
 { .ca_index = 0x03,  .speakers = {   0,    0,   0,   0,  FC,  LFE,  FR,  FL } },
 { .ca_index = 0x04,  .speakers = {   0,    0,   0,  RC,   0,    0,  FR,  FL } },
@@ -287,7 +287,7 @@ static void hdmi_set_channel_count(struc
 
 	if (chs != hdmi_get_channel_count(codec))
 		snd_printd(KERN_INFO "Channel count expect=%d, real=%d\n",
-				chs, hdmi_get_channel_count(codec));
+					chs, hdmi_get_channel_count(codec));
 }
 
 static void hdmi_debug_channel_mapping(struct hda_codec *codec)
@@ -300,7 +300,7 @@ static void hdmi_debug_channel_mapping(s
 		slot = snd_hda_codec_read(codec, CVT_NID, 0,
 						AC_VERB_GET_HDMI_CHAN_SLOT, i);
 		printk(KERN_DEBUG "ASP channel %d => slot %d\n",
-				slot >> 4, slot & 0x7);
+						slot >> 4, slot & 0x7);
 	}
 #endif
 }
@@ -316,7 +316,7 @@ static void hdmi_parse_eld(struct hda_co
 
 
 /*
- * Audio Infoframe routines
+ * Audio InfoFrame routines
  */
 
 static void hdmi_debug_dip_size(struct hda_codec *codec)
@@ -547,8 +547,8 @@ static void intel_hdmi_unsol_event(struc
  */
 
 static int intel_hdmi_playback_pcm_open(struct hda_pcm_stream *hinfo,
-				     struct hda_codec *codec,
-				     struct snd_pcm_substream *substream)
+					struct hda_codec *codec,
+					struct snd_pcm_substream *substream)
 {
 	struct intel_hdmi_spec *spec = codec->spec;
 
@@ -556,8 +556,8 @@ static int intel_hdmi_playback_pcm_open(
 }
 
 static int intel_hdmi_playback_pcm_close(struct hda_pcm_stream *hinfo,
-				      struct hda_codec *codec,
-				      struct snd_pcm_substream *substream)
+					 struct hda_codec *codec,
+					 struct snd_pcm_substream *substream)
 {
 	struct intel_hdmi_spec *spec = codec->spec;
 
--- sound-2.6.orig/sound/pci/hda/hda_eld.c
+++ sound-2.6/sound/pci/hda/hda_eld.c
@@ -132,7 +132,7 @@ static char *cea_audio_coding_type_names
 /*
  * The following two lists are shared between
  * 	- HDMI audio InfoFrame (source to sink)
- * 	- CEA E-EDID extension (sink to source)
+ * 	- CEA E-EDID Extension (sink to source)
  */
 
 /*

-- 
