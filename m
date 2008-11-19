From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 2/5] hda: rename sink_eld to hdmi_eld
Date: Wed, 19 Nov 2008 15:14:00 +0800
Message-ID: <20081119072203.496858382@linux.intel.com>
References: <20081119071358.231716724@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 81A6C245C4
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 08:26:01 +0100 (CET)
Content-Disposition: inline; filename=alsa-rename-sink-eld.patch
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

Rename struct sink_eld to hdmi_eld.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/hda_eld.c         |   14 +++++++-------
 sound/pci/hda/hda_local.h       |   10 +++++-----
 sound/pci/hda/patch_intelhdmi.c |    8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_eld.c
+++ sound-2.6/sound/pci/hda/hda_eld.c
@@ -267,8 +267,8 @@ static void hdmi_update_short_audio_desc
 /*
  * Be careful, ELD buf could be totally rubbish!
  */
-static int hdmi_update_sink_eld(struct sink_eld *e,
-				const unsigned char *buf, int size)
+static int hdmi_update_eld(struct hdmi_eld *e,
+			   const unsigned char *buf, int size)
 {
 	int mnl;
 	int i;
@@ -351,7 +351,7 @@ int snd_hdmi_get_eld_size(struct hda_cod
 						 AC_DIPSIZE_ELD_BUF);
 }
 
-int snd_hdmi_get_eld(struct sink_eld *eld,
+int snd_hdmi_get_eld(struct hdmi_eld *eld,
 		     struct hda_codec *codec, hda_nid_t nid)
 {
 	int i;
@@ -380,7 +380,7 @@ int snd_hdmi_get_eld(struct sink_eld *el
 	for (i = 0; i < size; i++)
 		buf[i] = hdmi_get_eld_byte(codec, nid, i);
 
-	ret = hdmi_update_sink_eld(eld, buf, size);
+	ret = hdmi_update_eld(eld, buf, size);
 
 	kfree(buf);
 	return ret;
@@ -421,7 +421,7 @@ void snd_print_channel_allocation(int sp
 	buf[j] = '\0';	/* necessary when j == 0 */
 }
 
-void snd_hdmi_show_eld(struct sink_eld *e)
+void snd_hdmi_show_eld(struct hdmi_eld *e)
 {
 	int i;
 	char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
@@ -482,7 +482,7 @@ static void hdmi_print_sad_info(int i, s
 static void hdmi_print_eld_info(struct snd_info_entry *entry,
 				struct snd_info_buffer *buffer)
 {
-	struct sink_eld *e = entry->private_data;
+	struct hdmi_eld *e = entry->private_data;
 	char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
 	int i;
 
@@ -509,7 +509,7 @@ static void hdmi_print_eld_info(struct s
 		hdmi_print_sad_info(i, e->sad + i, buffer);
 }
 
-int snd_hda_eld_proc_new(struct hda_codec *codec, struct sink_eld *eld)
+int snd_hda_eld_proc_new(struct hda_codec *codec, struct hdmi_eld *eld)
 {
 	char name[32];
 	struct snd_info_entry *entry;
--- sound-2.6.orig/sound/pci/hda/hda_local.h
+++ sound-2.6/sound/pci/hda/hda_local.h
@@ -462,7 +462,7 @@ struct cea_sad {
 /*
  * ELD: EDID Like Data
  */
-struct sink_eld {
+struct hdmi_eld {
 	int	eld_size;
 	int	baseline_len;
 	int	eld_ver;	/* (eld_ver == 0) indicates invalid ELD */
@@ -481,13 +481,13 @@ struct sink_eld {
 };
 
 int snd_hdmi_get_eld_size(struct hda_codec *codec, hda_nid_t nid);
-int snd_hdmi_get_eld(struct sink_eld *, struct hda_codec *, hda_nid_t);
-void snd_hdmi_show_eld(struct sink_eld *eld);
+int snd_hdmi_get_eld(struct hdmi_eld *, struct hda_codec *, hda_nid_t);
+void snd_hdmi_show_eld(struct hdmi_eld *eld);
 
 #ifdef CONFIG_PROC_FS
-int snd_hda_eld_proc_new(struct hda_codec *codec, struct sink_eld *eld);
+int snd_hda_eld_proc_new(struct hda_codec *codec, struct hdmi_eld *eld);
 #else
-inline int snd_hda_eld_proc_new(struct hda_codec *codec, struct sink_eld *eld)
+inline int snd_hda_eld_proc_new(struct hda_codec *codec, struct hdmi_eld *eld)
 {
 	return 0;
 }
--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
@@ -42,7 +42,7 @@
 struct intel_hdmi_spec {
 	struct hda_multi_out multiout;
 	struct hda_pcm pcm_rec;
-	struct sink_eld sink;
+	struct hdmi_eld sink_eld;
 };
 
 static struct hda_verb pinout_enable_verb[] = {
@@ -308,7 +308,7 @@ static void hdmi_debug_channel_mapping(s
 static void hdmi_parse_eld(struct hda_codec *codec)
 {
 	struct intel_hdmi_spec *spec = codec->spec;
-	struct sink_eld *eld = &spec->sink;
+	struct hdmi_eld *eld = &spec->sink_eld;
 
 	if (!snd_hdmi_get_eld(eld, codec, PIN_NID))
 		snd_hdmi_show_eld(eld);
@@ -411,7 +411,7 @@ static int hdmi_setup_channel_allocation
 					 struct hdmi_audio_infoframe *ai)
 {
 	struct intel_hdmi_spec *spec = codec->spec;
-	struct sink_eld *eld = &spec->sink;
+	struct hdmi_eld *eld = &spec->sink_eld;
 	int i;
 	int spk_mask = 0;
 	int channels = 1 + (ai->CC02_CT47 & 0x7);
@@ -663,7 +663,7 @@ static int patch_intel_hdmi(struct hda_c
 	codec->spec = spec;
 	codec->patch_ops = intel_hdmi_patch_ops;
 
-	snd_hda_eld_proc_new(codec, &spec->sink);
+	snd_hda_eld_proc_new(codec, &spec->sink_eld);
 
 	init_channel_allocations();
 

-- 
