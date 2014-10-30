From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/8] ALSA: pcm: Use static inline for
	snd_pcm_lib_alloc_vmalloc_buffer()
Date: Thu, 30 Oct 2014 16:06:17 +0100
Message-ID: <1414681581-4619-5-git-send-email-tiwai@suse.de>
References: <1414681581-4619-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 00FA52605AF
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 16:06:23 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DB37EAC01
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 15:06:23 +0000 (UTC)
In-Reply-To: <1414681581-4619-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

... instead of #if 0 hack.  It's more straightforward and obvious.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index e862497f7556..5c3310d7d4b8 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -942,7 +942,6 @@ int _snd_pcm_lib_alloc_vmalloc_buffer(struct snd_pcm_substream *substream,
 int snd_pcm_lib_free_vmalloc_buffer(struct snd_pcm_substream *substream);
 struct page *snd_pcm_lib_get_vmalloc_page(struct snd_pcm_substream *substream,
 					  unsigned long offset);
-#if 0 /* for kernel-doc */
 /**
  * snd_pcm_lib_alloc_vmalloc_buffer - allocate virtual DMA buffer
  * @substream: the substream to allocate the buffer to
@@ -955,8 +954,13 @@ struct page *snd_pcm_lib_get_vmalloc_page(struct snd_pcm_substream *substream,
  * Return: 1 if the buffer was changed, 0 if not changed, or a negative error
  * code.
  */
-static int snd_pcm_lib_alloc_vmalloc_buffer
-			(struct snd_pcm_substream *substream, size_t size);
+static inline int snd_pcm_lib_alloc_vmalloc_buffer
+			(struct snd_pcm_substream *substream, size_t size)
+{
+	return _snd_pcm_lib_alloc_vmalloc_buffer(substream, size,
+						 GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
+}
+
 /**
  * snd_pcm_lib_alloc_vmalloc_32_buffer - allocate 32-bit-addressable buffer
  * @substream: the substream to allocate the buffer to
@@ -968,15 +972,12 @@ static int snd_pcm_lib_alloc_vmalloc_buffer
  * Return: 1 if the buffer was changed, 0 if not changed, or a negative error
  * code.
  */
-static int snd_pcm_lib_alloc_vmalloc_32_buffer
-			(struct snd_pcm_substream *substream, size_t size);
-#endif
-#define snd_pcm_lib_alloc_vmalloc_buffer(subs, size) \
-	_snd_pcm_lib_alloc_vmalloc_buffer \
-			(subs, size, GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO)
-#define snd_pcm_lib_alloc_vmalloc_32_buffer(subs, size) \
-	_snd_pcm_lib_alloc_vmalloc_buffer \
-			(subs, size, GFP_KERNEL | GFP_DMA32 | __GFP_ZERO)
+static inline int snd_pcm_lib_alloc_vmalloc_32_buffer
+			(struct snd_pcm_substream *substream, size_t size)
+{
+	return _snd_pcm_lib_alloc_vmalloc_buffer(substream, size,
+						 GFP_KERNEL | GFP_DMA32 | __GFP_ZERO);
+}
 
 #define snd_pcm_get_dma_buf(substream) ((substream)->runtime->dma_buffer_p)
 
-- 
2.1.2
