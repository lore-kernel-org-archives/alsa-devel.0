From: linux@audioscience.com
Subject: [PATCH v2] ALSA: Make snd_pcm_debug_name usable
	outside pcm_lib
Date: Sat, 23 Jul 2011 12:36:25 +1200
Message-ID: <1311381385-26149-1-git-send-email-linux@audioscience.com>
References: <s5hsjpy1upb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <s5hsjpy1upb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Formatting a PCM name is useful for module debug too.
Add snd_prefix when making function public.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 include/sound/pcm.h       |   12 ++++++++++++
 sound/core/pcm_lib.c      |   14 +++++++++-----
 sound/pci/asihpi/asihpi.c |   21 ---------------------
 3 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index e1bad11..c83c754 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -507,6 +507,18 @@ void snd_pcm_detach_substream(struct snd_pcm_substream *substream);
 void snd_pcm_vma_notify_data(void *client, void *data);
 int snd_pcm_mmap_data(struct snd_pcm_substream *substream, struct file *file, struct vm_area_struct *area);
 
+
+#if defined CONFIG_SND_DEBUG
+void snd_pcm_debug_name(struct snd_pcm_substream *substream,
+			   char *name, size_t len);
+#else
+static inline void
+snd_pcm_debug_name(struct snd_pcm_substream *substream, char *buf, size_t size)
+{
+	*buf = 0;
+}
+#endif
+
 /*
  *  PCM library
  */
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index f134130..e3079a1 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -128,7 +128,8 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 	}
 }
 
-static void pcm_debug_name(struct snd_pcm_substream *substream,
+#if defined CONFIG_SND_DEBUG
+void snd_pcm_debug_name(struct snd_pcm_substream *substream,
 			   char *name, size_t len)
 {
 	snprintf(name, len, "pcmC%dD%d%c:%d",
@@ -138,6 +139,9 @@ static void pcm_debug_name(struct snd_pcm_substream *substream,
 		 substream->number);
 }
 
+EXPORT_SYMBOL(snd_pcm_debug_name);
+#endif
+
 #define XRUN_DEBUG_BASIC	(1<<0)
 #define XRUN_DEBUG_STACK	(1<<1)	/* dump also stack */
 #define XRUN_DEBUG_JIFFIESCHECK	(1<<2)	/* do jiffies check */
@@ -168,7 +172,7 @@ static void xrun(struct snd_pcm_substream *substream)
 	snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
 	if (xrun_debug(substream, XRUN_DEBUG_BASIC)) {
 		char name[16];
-		pcm_debug_name(substream, name, sizeof(name));
+		snd_pcm_debug_name(substream, name, sizeof(name));
 		snd_printd(KERN_DEBUG "XRUN: %s\n", name);
 		dump_stack_on_xrun(substream);
 	}
@@ -243,7 +247,7 @@ static void xrun_log_show(struct snd_pcm_substream *substream)
 		return;
 	if (xrun_debug(substream, XRUN_DEBUG_LOGONCE) && log->hit)
 		return;
-	pcm_debug_name(substream, name, sizeof(name));
+	snd_pcm_debug_name(substream, name, sizeof(name));
 	for (cnt = 0, idx = log->idx; cnt < XRUN_LOG_CNT; cnt++) {
 		entry = &log->entries[idx];
 		if (entry->period_size == 0)
@@ -319,7 +323,7 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	if (pos >= runtime->buffer_size) {
 		if (printk_ratelimit()) {
 			char name[16];
-			pcm_debug_name(substream, name, sizeof(name));
+			snd_pcm_debug_name(substream, name, sizeof(name));
 			xrun_log_show(substream);
 			snd_printd(KERN_ERR  "BUG: %s, pos = %ld, "
 				   "buffer size = %ld, period size = %ld\n",
@@ -364,7 +368,7 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	if (xrun_debug(substream, in_interrupt ?
 			XRUN_DEBUG_PERIODUPDATE : XRUN_DEBUG_HWPTRUPDATE)) {
 		char name[16];
-		pcm_debug_name(substream, name, sizeof(name));
+		snd_pcm_debug_name(substream, name, sizeof(name));
 		snd_printd("%s_update: %s: pos=%u/%u/%u, "
 			   "hwptr=%ld/%ld/%ld/%ld\n",
 			   in_interrupt ? "period" : "hwptr",
diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index b941d25..eae62eb 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -41,31 +41,10 @@
 #include <sound/tlv.h>
 #include <sound/hwdep.h>
 
-
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("AudioScience inc. <support@audioscience.com>");
 MODULE_DESCRIPTION("AudioScience ALSA ASI5000 ASI6000 ASI87xx ASI89xx");
 
-#if defined CONFIG_SND_DEBUG
-/* copied from pcm_lib.c, hope later patch will make that version public
-and this copy can be removed */
-static inline void
-snd_pcm_debug_name(struct snd_pcm_substream *substream, char *buf, size_t size)
-{
-	snprintf(buf, size, "pcmC%dD%d%c:%d",
-		 substream->pcm->card->number,
-		 substream->pcm->device,
-		 substream->stream ? 'c' : 'p',
-		 substream->number);
-}
-#else
-static inline void
-snd_pcm_debug_name(struct snd_pcm_substream *substream, char *buf, size_t size)
-{
-	*buf = 0;
-}
-#endif
-
 #if defined CONFIG_SND_DEBUG_VERBOSE
 /**
  * snd_printddd - very verbose debug printk
-- 
1.7.0.4
