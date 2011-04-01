From: linux@audioscience.com
Subject: [snd-asihpi 6/8] Define pcm_debug_name if
	CONFIG_SND_DEBUG
Date: Fri, 01 Apr 2011 15:59:50 +1300
Message-ID: <1301626792-13705-7-git-send-email-linux@audioscience.com>
References: <1301626792-13705-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1301626792-13705-1-git-send-email-linux@audioscience.com>
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

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/asihpi.c |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index d5258aa..eac7b08 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -47,18 +47,7 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("AudioScience inc. <support@audioscience.com>");
 MODULE_DESCRIPTION("AudioScience ALSA ASI5000 ASI6000 ASI87xx ASI89xx");
 
-#if defined CONFIG_SND_DEBUG_VERBOSE
-/**
- * snd_printddd - very verbose debug printk
- * @format: format string
- *
- * Works like snd_printk() for debugging purposes.
- * Ignored when CONFIG_SND_DEBUG_VERBOSE is not set.
- * Must set snd module debug parameter to 3 to enable at runtime.
- */
-#define snd_printddd(format, args...) \
-	__snd_printk(3, __FILE__, __LINE__, format, ##args)
-
+#if defined CONFIG_SND_DEBUG
 /* copied from pcm_lib.c, hope later patch will make that version public
 and this copy can be removed */
 static void pcm_debug_name(struct snd_pcm_substream *substream,
@@ -71,12 +60,24 @@ static void pcm_debug_name(struct snd_pcm_substream *substream,
 		 substream->number);
 }
 #define DEBUG_NAME(substream, name) char name[16]; pcm_debug_name(substream, name, sizeof(name))
-
 #else
-#define snd_printddd(format, args...) do { } while (0)
 #define pcm_debug_name(s, n, l) do { } while (0)
 #define DEBUG_NAME(name, substream) do { } while (0)
+#endif
 
+#if defined CONFIG_SND_DEBUG_VERBOSE
+/**
+ * snd_printddd - very verbose debug printk
+ * @format: format string
+ *
+ * Works like snd_printk() for debugging purposes.
+ * Ignored when CONFIG_SND_DEBUG_VERBOSE is not set.
+ * Must set snd module debug parameter to 3 to enable at runtime.
+ */
+#define snd_printddd(format, args...) \
+	__snd_printk(3, __FILE__, __LINE__, format, ##args)
+#else
+#define snd_printddd(format, args...) do { } while (0)
 #endif
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* index 0-MAX */
@@ -857,7 +858,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 			unsigned int xfer1, xfer2;
 			char *pd = &s->runtime->dma_area[buf_ofs];
 
-			if (card->can_dma) {
+			if (card->can_dma) { /* buffer wrap is handled at lower level */
 				xfer1 = xfercount;
 				xfer2 = 0;
 			} else {
-- 
1.7.0.4
