From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 2/4] hda: make global
	snd_print_channel_allocation()
Date: Tue, 18 Nov 2008 16:57:15 +0800
Message-ID: <20081118085808.974907195@linux.intel.com>
References: <20081118085713.252457834@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 97019244D8
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 09:58:29 +0100 (CET)
Content-Disposition: inline; filename=alsa-global-print-ca.patch
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

code refactor: make a global function snd_print_channel_allocation().

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/hda_eld.c   |   11 +++++------
 sound/pci/hda/hda_local.h |    3 +++
 2 files changed, 8 insertions(+), 6 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_eld.c
+++ sound-2.6/sound/pci/hda/hda_eld.c
@@ -407,8 +407,7 @@ static void hdmi_show_short_audio_desc(s
 		printk(KERN_INFO "profile: %d\n", a->profile);
 }
 
-#define HDMI_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE 80
-static void hdmi_print_channel_allocation(int spk_alloc, char *buf, int buflen)
+void snd_print_channel_allocation(int spk_alloc, char *buf, int buflen)
 {
 	int i, j;
 
@@ -425,7 +424,7 @@ static void hdmi_print_channel_allocatio
 void snd_hdmi_show_eld(struct sink_eld *e)
 {
 	int i;
-	char buf[HDMI_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
+	char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
 
 	printk(KERN_INFO "ELD buffer size  is %d\n", e->eld_size);
 	printk(KERN_INFO "ELD baseline len is %d*4\n", e->baseline_len);
@@ -446,7 +445,7 @@ void snd_hdmi_show_eld(struct sink_eld *
 				eld_connection_type_names[e->conn_type]);
 	printk(KERN_INFO "monitor name     is %s\n", e->monitor_name);
 
-	hdmi_print_channel_allocation(e->spk_alloc, buf, sizeof(buf));
+	snd_print_channel_allocation(e->spk_alloc, buf, sizeof(buf));
 	printk(KERN_INFO "speaker allocations: (0x%x)%s\n", e->spk_alloc, buf);
 
 	for (i = 0; i < e->sad_count; i++)
@@ -484,7 +483,7 @@ static void hdmi_print_eld_info(struct s
 				struct snd_info_buffer *buffer)
 {
 	struct sink_eld *e = entry->private_data;
-	char buf[HDMI_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
+	char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
 	int i;
 
 	snd_iprintf(buffer, "monitor name\t\t%s\n", e->monitor_name);
@@ -501,7 +500,7 @@ static void hdmi_print_eld_info(struct s
 	snd_iprintf(buffer, "support_ai\t\t%d\n", e->support_ai);
 	snd_iprintf(buffer, "audio_sync_delay\t%d\n", e->aud_synch_delay);
 
-	hdmi_print_channel_allocation(e->spk_alloc, buf, sizeof(buf));
+	snd_print_channel_allocation(e->spk_alloc, buf, sizeof(buf));
 	snd_iprintf(buffer, "speakers\t\t[0x%x] %s\n", e->spk_alloc, buf);
 
 	snd_iprintf(buffer, "sad_count\t\t%d\n", e->sad_count);
--- sound-2.6.orig/sound/pci/hda/hda_local.h
+++ sound-2.6/sound/pci/hda/hda_local.h
@@ -493,4 +493,7 @@ inline int snd_hda_eld_proc_new(struct h
 }
 #endif
 
+#define SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE 80
+void snd_print_channel_allocation(int spk_alloc, char *buf, int buflen);
+
 #endif /* __SOUND_HDA_LOCAL_H */

-- 
