From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 20/20] ALSA: pcm: Define
	snd_pcm_lib_preallocate_*() as returning void
Date: Tue,  5 Feb 2019 20:42:21 +0100
Message-ID: <20190205194221.25924-21-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 89A0726795C
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 20:42:29 +0100 (CET)
In-Reply-To: <20190205194221.25924-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Now all callers no longer check the return value from
snd_pcm_lib_preallocate_pages() and co, let's make them to return
void, so that any new code won't fall into the same pitfall.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h     |  8 ++++----
 sound/core/pcm_memory.c | 29 ++++++++---------------------
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index ca20f80f8976..465d7d033c4c 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1185,12 +1185,12 @@ static inline void snd_pcm_gettime(struct snd_pcm_runtime *runtime,
  *  Memory
  */
 
-int snd_pcm_lib_preallocate_free(struct snd_pcm_substream *substream);
-int snd_pcm_lib_preallocate_free_for_all(struct snd_pcm *pcm);
-int snd_pcm_lib_preallocate_pages(struct snd_pcm_substream *substream,
+void snd_pcm_lib_preallocate_free(struct snd_pcm_substream *substream);
+void snd_pcm_lib_preallocate_free_for_all(struct snd_pcm *pcm);
+void snd_pcm_lib_preallocate_pages(struct snd_pcm_substream *substream,
 				  int type, struct device *data,
 				  size_t size, size_t max);
-int snd_pcm_lib_preallocate_pages_for_all(struct snd_pcm *pcm,
+void snd_pcm_lib_preallocate_pages_for_all(struct snd_pcm *pcm,
 					  int type, void *data,
 					  size_t size, size_t max);
 int snd_pcm_lib_malloc_pages(struct snd_pcm_substream *substream, size_t size);
diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 9a98bc61461f..049d65cad54a 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -87,13 +87,10 @@ static void snd_pcm_lib_preallocate_dma_free(struct snd_pcm_substream *substream
  * @substream: the pcm substream instance
  *
  * Releases the pre-allocated buffer of the given substream.
- *
- * Return: Zero if successful, or a negative error code on failure.
  */
-int snd_pcm_lib_preallocate_free(struct snd_pcm_substream *substream)
+void snd_pcm_lib_preallocate_free(struct snd_pcm_substream *substream)
 {
 	snd_pcm_lib_preallocate_dma_free(substream);
-	return 0;
 }
 
 /**
@@ -101,10 +98,8 @@ int snd_pcm_lib_preallocate_free(struct snd_pcm_substream *substream)
  * @pcm: the pcm instance
  *
  * Releases all the pre-allocated buffers on the given pcm.
- *
- * Return: Zero if successful, or a negative error code on failure.
  */
-int snd_pcm_lib_preallocate_free_for_all(struct snd_pcm *pcm)
+void snd_pcm_lib_preallocate_free_for_all(struct snd_pcm *pcm)
 {
 	struct snd_pcm_substream *substream;
 	int stream;
@@ -112,7 +107,6 @@ int snd_pcm_lib_preallocate_free_for_all(struct snd_pcm *pcm)
 	for (stream = 0; stream < 2; stream++)
 		for (substream = pcm->streams[stream].substream; substream; substream = substream->next)
 			snd_pcm_lib_preallocate_free(substream);
-	return 0;
 }
 EXPORT_SYMBOL(snd_pcm_lib_preallocate_free_for_all);
 
@@ -215,7 +209,7 @@ static inline void preallocate_info_init(struct snd_pcm_substream *substream)
 /*
  * pre-allocate the buffer and create a proc file for the substream
  */
-static int snd_pcm_lib_preallocate_pages1(struct snd_pcm_substream *substream,
+static void snd_pcm_lib_preallocate_pages1(struct snd_pcm_substream *substream,
 					  size_t size, size_t max)
 {
 
@@ -226,7 +220,6 @@ static int snd_pcm_lib_preallocate_pages1(struct snd_pcm_substream *substream,
 		substream->buffer_bytes_max = substream->dma_buffer.bytes;
 	substream->dma_max = max;
 	preallocate_info_init(substream);
-	return 0;
 }
 
 
@@ -239,16 +232,14 @@ static int snd_pcm_lib_preallocate_pages1(struct snd_pcm_substream *substream,
  * @max: the max. allowed pre-allocation size
  *
  * Do pre-allocation for the given DMA buffer type.
- *
- * Return: Zero if successful, or a negative error code on failure.
  */
-int snd_pcm_lib_preallocate_pages(struct snd_pcm_substream *substream,
+void snd_pcm_lib_preallocate_pages(struct snd_pcm_substream *substream,
 				  int type, struct device *data,
 				  size_t size, size_t max)
 {
 	substream->dma_buffer.dev.type = type;
 	substream->dma_buffer.dev.dev = data;
-	return snd_pcm_lib_preallocate_pages1(substream, size, max);
+	snd_pcm_lib_preallocate_pages1(substream, size, max);
 }
 EXPORT_SYMBOL(snd_pcm_lib_preallocate_pages);
 
@@ -262,21 +253,17 @@ EXPORT_SYMBOL(snd_pcm_lib_preallocate_pages);
  *
  * Do pre-allocation to all substreams of the given pcm for the
  * specified DMA type.
- *
- * Return: Zero if successful, or a negative error code on failure.
  */
-int snd_pcm_lib_preallocate_pages_for_all(struct snd_pcm *pcm,
+void snd_pcm_lib_preallocate_pages_for_all(struct snd_pcm *pcm,
 					  int type, void *data,
 					  size_t size, size_t max)
 {
 	struct snd_pcm_substream *substream;
-	int stream, err;
+	int stream;
 
 	for (stream = 0; stream < 2; stream++)
 		for (substream = pcm->streams[stream].substream; substream; substream = substream->next)
-			if ((err = snd_pcm_lib_preallocate_pages(substream, type, data, size, max)) < 0)
-				return err;
-	return 0;
+			snd_pcm_lib_preallocate_pages(substream, type, data, size, max);
 }
 EXPORT_SYMBOL(snd_pcm_lib_preallocate_pages_for_all);
 
-- 
2.16.4
