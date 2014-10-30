From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/8] ALSA: pcm: More kerneldoc updates
Date: Thu, 30 Oct 2014 16:06:18 +0100
Message-ID: <1414681581-4619-6-git-send-email-tiwai@suse.de>
References: <1414681581-4619-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F16C260628
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 16:06:24 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EA012ACF4
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

Add proper kerneldoc comments to the exported functions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h     | 160 +++++++++++++++++++++++++++++++++++++++++++++---
 sound/core/pcm.c        |  15 ++++-
 sound/core/pcm_native.c |  53 ++++++++++++++++
 3 files changed, 219 insertions(+), 9 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 5c3310d7d4b8..f78a5722f5cc 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -533,6 +533,12 @@ snd_pcm_debug_name(struct snd_pcm_substream *substream, char *buf, size_t size)
  *  PCM library
  */
 
+/**
+ * snd_pcm_stream_linked - Check whether the substream is linked with others
+ * @substream: substream to check
+ *
+ * Returns true if the given substream is being linked with others.
+ */
 static inline int snd_pcm_stream_linked(struct snd_pcm_substream *substream)
 {
 	return substream->group != &substream->self_group;
@@ -543,6 +549,16 @@ void snd_pcm_stream_unlock(struct snd_pcm_substream *substream);
 void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream);
 void snd_pcm_stream_unlock_irq(struct snd_pcm_substream *substream);
 unsigned long _snd_pcm_stream_lock_irqsave(struct snd_pcm_substream *substream);
+
+/**
+ * snd_pcm_stream_lock_irqsave - Lock the PCM stream
+ * @substream: PCM substream
+ * @flags: irq flags
+ *
+ * This locks the PCM stream like snd_pcm_stream_lock() but with the local
+ * IRQ (only when nonatomic is false).  In nonatomic case, this is identical
+ * as snd_pcm_stream_lock().
+ */
 #define snd_pcm_stream_lock_irqsave(substream, flags)		 \
 	do {							 \
 		typecheck(unsigned long, flags);		 \
@@ -551,9 +567,25 @@ unsigned long _snd_pcm_stream_lock_irqsave(struct snd_pcm_substream *substream);
 void snd_pcm_stream_unlock_irqrestore(struct snd_pcm_substream *substream,
 				      unsigned long flags);
 
+/**
+ * snd_pcm_group_for_each_entry - iterate over the linked substreams
+ * @s: the iterator
+ * @substream: the substream
+ *
+ * Iterate over the all linked substreams to the given @substream.
+ * When @substream isn't linked with any others, this gives returns @substream
+ * itself once.
+ */
 #define snd_pcm_group_for_each_entry(s, substream) \
 	list_for_each_entry(s, &substream->group->substreams, link_list)
 
+/**
+ * snd_pcm_running - Check whether the substream is in a running state
+ * @substream: substream to check
+ *
+ * Returns true if the given substream is in the state RUNNING, or in the
+ * state DRAINING for playback.
+ */
 static inline int snd_pcm_running(struct snd_pcm_substream *substream)
 {
 	return (substream->runtime->status->state == SNDRV_PCM_STATE_RUNNING ||
@@ -561,45 +593,81 @@ static inline int snd_pcm_running(struct snd_pcm_substream *substream)
 		 substream->stream == SNDRV_PCM_STREAM_PLAYBACK));
 }
 
+/**
+ * bytes_to_samples - Unit conversion of the size from bytes to samples
+ * @runtime: PCM runtime instance
+ * @size: size in bytes
+ */
 static inline ssize_t bytes_to_samples(struct snd_pcm_runtime *runtime, ssize_t size)
 {
 	return size * 8 / runtime->sample_bits;
 }
 
+/**
+ * bytes_to_frames - Unit conversion of the size from bytes to frames
+ * @runtime: PCM runtime instance
+ * @size: size in bytes
+ */
 static inline snd_pcm_sframes_t bytes_to_frames(struct snd_pcm_runtime *runtime, ssize_t size)
 {
 	return size * 8 / runtime->frame_bits;
 }
 
+/**
+ * samples_to_bytes - Unit conversion of the size from samples to bytes
+ * @runtime: PCM runtime instance
+ * @size: size in samples
+ */
 static inline ssize_t samples_to_bytes(struct snd_pcm_runtime *runtime, ssize_t size)
 {
 	return size * runtime->sample_bits / 8;
 }
 
+/**
+ * frames_to_bytes - Unit conversion of the size from frames to bytes
+ * @runtime: PCM runtime instance
+ * @size: size in frames
+ */
 static inline ssize_t frames_to_bytes(struct snd_pcm_runtime *runtime, snd_pcm_sframes_t size)
 {
 	return size * runtime->frame_bits / 8;
 }
 
+/**
+ * frame_aligned - Check whether the byte size is aligned to frames
+ * @runtime: PCM runtime instance
+ * @bytes: size in bytes
+ */
 static inline int frame_aligned(struct snd_pcm_runtime *runtime, ssize_t bytes)
 {
 	return bytes % runtime->byte_align == 0;
 }
 
+/**
+ * snd_pcm_lib_buffer_bytes - Get the buffer size of the current PCM in bytes
+ * @substream: PCM substream
+ */
 static inline size_t snd_pcm_lib_buffer_bytes(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	return frames_to_bytes(runtime, runtime->buffer_size);
 }
 
+/**
+ * snd_pcm_lib_period_bytes - Get the period size of the current PCM in bytes
+ * @substream: PCM substream
+ */
 static inline size_t snd_pcm_lib_period_bytes(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	return frames_to_bytes(runtime, runtime->period_size);
 }
 
-/*
- *  result is: 0 ... (boundary - 1)
+/**
+ * snd_pcm_playback_avail - Get the available (writable) space for playback
+ * @runtime: PCM runtime instance
+ *
+ * Result is between 0 ... (boundary - 1)
  */
 static inline snd_pcm_uframes_t snd_pcm_playback_avail(struct snd_pcm_runtime *runtime)
 {
@@ -611,8 +679,11 @@ static inline snd_pcm_uframes_t snd_pcm_playback_avail(struct snd_pcm_runtime *r
 	return avail;
 }
 
-/*
- *  result is: 0 ... (boundary - 1)
+/**
+ * snd_pcm_playback_avail - Get the available (readable) space for capture
+ * @runtime: PCM runtime instance
+ *
+ * Result is between 0 ... (boundary - 1)
  */
 static inline snd_pcm_uframes_t snd_pcm_capture_avail(struct snd_pcm_runtime *runtime)
 {
@@ -622,11 +693,19 @@ static inline snd_pcm_uframes_t snd_pcm_capture_avail(struct snd_pcm_runtime *ru
 	return avail;
 }
 
+/**
+ * snd_pcm_playback_hw_avail - Get the queued space for playback
+ * @runtime: PCM runtime instance
+ */
 static inline snd_pcm_sframes_t snd_pcm_playback_hw_avail(struct snd_pcm_runtime *runtime)
 {
 	return runtime->buffer_size - snd_pcm_playback_avail(runtime);
 }
 
+/**
+ * snd_pcm_capture_hw_avail - Get the free space for capture
+ * @runtime: PCM runtime instance
+ */
 static inline snd_pcm_sframes_t snd_pcm_capture_hw_avail(struct snd_pcm_runtime *runtime)
 {
 	return runtime->buffer_size - snd_pcm_capture_avail(runtime);
@@ -706,6 +785,20 @@ static inline int snd_pcm_capture_empty(struct snd_pcm_substream *substream)
 	return snd_pcm_capture_avail(runtime) == 0;
 }
 
+/**
+ * snd_pcm_trigger_done - Mark the master substream
+ * @substream: the pcm substream instance
+ * @master: the linked master substream
+ *
+ * When multiple substreams of the same card are linked and the hardware
+ * supports the single-shot operation, the driver calls this in the loop
+ * in snd_pcm_group_for_each_entry() for marking the substream as "done".
+ * Then most of trigger operations are performed only to the given master
+ * substream.
+ *
+ * The trigger_master mark is cleared at timestamp updates at the end
+ * of trigger operations.
+ */
 static inline void snd_pcm_trigger_done(struct snd_pcm_substream *substream, 
 					struct snd_pcm_substream *master)
 {
@@ -881,6 +974,14 @@ unsigned int snd_pcm_rate_bit_to_rate(unsigned int rate_bit);
 unsigned int snd_pcm_rate_mask_intersect(unsigned int rates_a,
 					 unsigned int rates_b);
 
+/**
+ * snd_pcm_set_runtime_buffer - Set the PCM runtime buffer
+ * @substream: PCM substream to set
+ * @bufp: the buffer information, NULL to clear
+ *
+ * Copy the buffer information to runtime->dma_buffer when @bufp is non-NULL.
+ * Otherwise it clears the current buffer information.
+ */
 static inline void snd_pcm_set_runtime_buffer(struct snd_pcm_substream *substream,
 					      struct snd_dma_buffer *bufp)
 {
@@ -906,6 +1007,11 @@ void snd_pcm_timer_resolution_change(struct snd_pcm_substream *substream);
 void snd_pcm_timer_init(struct snd_pcm_substream *substream);
 void snd_pcm_timer_done(struct snd_pcm_substream *substream);
 
+/**
+ * snd_pcm_gettime - Fill the timespec depending on the timestamp mode
+ * @runtime: PCM runtime instance
+ * @tv: timespec to fill
+ */
 static inline void snd_pcm_gettime(struct snd_pcm_runtime *runtime,
 				   struct timespec *tv)
 {
@@ -997,18 +1103,35 @@ struct page *snd_pcm_sgbuf_ops_page(struct snd_pcm_substream *substream,
 #define snd_pcm_sgbuf_ops_page	NULL
 #endif /* SND_DMA_SGBUF */
 
+/**
+ * snd_pcm_sgbuf_get_addr - Get the DMA address at the corresponding offset
+ * @substream: PCM substream
+ * @ofs: byte offset
+ */
 static inline dma_addr_t
 snd_pcm_sgbuf_get_addr(struct snd_pcm_substream *substream, unsigned int ofs)
 {
 	return snd_sgbuf_get_addr(snd_pcm_get_dma_buf(substream), ofs);
 }
 
+/**
+ * snd_pcm_sgbuf_get_ptr - Get the virtual address at the corresponding offset
+ * @substream: PCM substream
+ * @ofs: byte offset
+ */
 static inline void *
 snd_pcm_sgbuf_get_ptr(struct snd_pcm_substream *substream, unsigned int ofs)
 {
 	return snd_sgbuf_get_ptr(snd_pcm_get_dma_buf(substream), ofs);
 }
 
+/**
+ * snd_pcm_sgbuf_chunk_size - Compute the max size that fits within the contig.
+ * page from the given size
+ * @substream: PCM substream
+ * @ofs: byte offset
+ * @size: byte size to examine
+ */
 static inline unsigned int
 snd_pcm_sgbuf_get_chunk_size(struct snd_pcm_substream *substream,
 			     unsigned int ofs, unsigned int size)
@@ -1016,13 +1139,24 @@ snd_pcm_sgbuf_get_chunk_size(struct snd_pcm_substream *substream,
 	return snd_sgbuf_get_chunk_size(snd_pcm_get_dma_buf(substream), ofs, size);
 }
 
-/* handle mmap counter - PCM mmap callback should handle this counter properly */
+/**
+ * snd_pcm_mmap_data_open - increase the mmap counter
+ * @area: VMA
+ *
+ * PCM mmap callback should handle this counter properly
+ */
 static inline void snd_pcm_mmap_data_open(struct vm_area_struct *area)
 {
 	struct snd_pcm_substream *substream = (struct snd_pcm_substream *)area->vm_private_data;
 	atomic_inc(&substream->mmap_count);
 }
 
+/**
+ * snd_pcm_mmap_data_close - decrease the mmap counter
+ * @area: VMA
+ *
+ * PCM mmap callback should handle this counter properly
+ */
 static inline void snd_pcm_mmap_data_close(struct vm_area_struct *area)
 {
 	struct snd_pcm_substream *substream = (struct snd_pcm_substream *)area->vm_private_data;
@@ -1042,6 +1176,11 @@ int snd_pcm_lib_mmap_iomem(struct snd_pcm_substream *substream, struct vm_area_s
 
 #define snd_pcm_lib_mmap_vmalloc NULL
 
+/**
+ * snd_pcm_limit_isa_dma_size - Get the max size fitting with ISA DMA transfer
+ * @dma: DMA number
+ * @max: pointer to store the max size
+ */
 static inline void snd_pcm_limit_isa_dma_size(int dma, size_t *max)
 {
 	*max = dma < 4 ? 64 * 1024 : 128 * 1024;
@@ -1094,7 +1233,11 @@ struct snd_pcm_chmap {
 	void *private_data;	/* optional: private data pointer */
 };
 
-/* get the PCM substream assigned to the given chmap info */
+/**
+ * snd_pcm_chmap_substream - get the PCM substream assigned to the given chmap info
+ * @info: chmap information
+ * @idx: the substream number index
+ */
 static inline struct snd_pcm_substream *
 snd_pcm_chmap_substream(struct snd_pcm_chmap *info, unsigned int idx)
 {
@@ -1121,7 +1264,10 @@ int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
 			   unsigned long private_value,
 			   struct snd_pcm_chmap **info_ret);
 
-/* Strong-typed conversion of pcm_format to bitwise */
+/**
+ * pcm_format_to_bits - Strong-typed conversion of pcm_format to bitwise
+ * @pcm_format: PCM format
+ */
 static inline u64 pcm_format_to_bits(snd_pcm_format_t pcm_format)
 {
 	return 1ULL << (__force int) pcm_format;
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 42ded997b223..31acc3df62cd 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -218,6 +218,10 @@ static char *snd_pcm_format_names[] = {
 	FORMAT(DSD_U32_LE),
 };
 
+/**
+ * snd_pcm_format_name - Return a name string for the given PCM format
+ * @format: PCM format
+ */
 const char *snd_pcm_format_name(snd_pcm_format_t format)
 {
 	if ((__force unsigned int)format >= ARRAY_SIZE(snd_pcm_format_names))
@@ -707,7 +711,6 @@ int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count)
 	}
 	return 0;
 }				
-
 EXPORT_SYMBOL(snd_pcm_new_stream);
 
 static int _snd_pcm_new(struct snd_card *card, const char *id, int device,
@@ -1155,6 +1158,15 @@ static int snd_pcm_dev_disconnect(struct snd_device *device)
 	return 0;
 }
 
+/**
+ * snd_pcm_notify - Add/remove the notify list
+ * @notify: PCM notify list
+ * @nfree: 0 = register, 1 = unregister
+ *
+ * This adds the given notifier to the global list so that the callback is
+ * called for each registered PCM devices.  This exists only for PCM OSS
+ * emulation, so far.
+ */
 int snd_pcm_notify(struct snd_pcm_notify *notify, int nfree)
 {
 	struct snd_pcm *pcm;
@@ -1177,7 +1189,6 @@ int snd_pcm_notify(struct snd_pcm_notify *notify, int nfree)
 	mutex_unlock(&register_mutex);
 	return 0;
 }
-
 EXPORT_SYMBOL(snd_pcm_notify);
 
 #ifdef CONFIG_PROC_FS
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 2f7ad10ee7c3..4d5795d8b9f7 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -74,6 +74,14 @@ static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream);
 static DEFINE_RWLOCK(snd_pcm_link_rwlock);
 static DECLARE_RWSEM(snd_pcm_link_rwsem);
 
+/**
+ * snd_pcm_stream_lock - Lock the PCM stream
+ * @substream: PCM substream
+ *
+ * This locks the PCM stream's spinlock or mutex depending on the nonatomic
+ * flag of the given substream.  This also takes the global link rw lock
+ * (or rw sem), too, for avoiding the race with linked streams.
+ */
 void snd_pcm_stream_lock(struct snd_pcm_substream *substream)
 {
 	if (substream->pcm->nonatomic) {
@@ -86,6 +94,12 @@ void snd_pcm_stream_lock(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_lock);
 
+/**
+ * snd_pcm_stream_lock - Unlock the PCM stream
+ * @substream: PCM substream
+ *
+ * This unlocks the PCM stream that has been locked via snd_pcm_stream_lock().
+ */
 void snd_pcm_stream_unlock(struct snd_pcm_substream *substream)
 {
 	if (substream->pcm->nonatomic) {
@@ -98,6 +112,14 @@ void snd_pcm_stream_unlock(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock);
 
+/**
+ * snd_pcm_stream_lock_irq - Lock the PCM stream
+ * @substream: PCM substream
+ *
+ * This locks the PCM stream like snd_pcm_stream_lock() and disables the local
+ * IRQ (only when nonatomic is false).  In nonatomic case, this is identical
+ * as snd_pcm_stream_lock().
+ */
 void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream)
 {
 	if (!substream->pcm->nonatomic)
@@ -106,6 +128,12 @@ void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_lock_irq);
 
+/**
+ * snd_pcm_stream_unlock_irq - Unlock the PCM stream
+ * @substream: PCM substream
+ *
+ * This is a counter-part of snd_pcm_stream_lock_irq().
+ */
 void snd_pcm_stream_unlock_irq(struct snd_pcm_substream *substream)
 {
 	snd_pcm_stream_unlock(substream);
@@ -124,6 +152,13 @@ unsigned long _snd_pcm_stream_lock_irqsave(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL_GPL(_snd_pcm_stream_lock_irqsave);
 
+/**
+ * snd_pcm_stream_unlock_irqrestore - Unlock the PCM stream
+ * @substream: PCM substream
+ * @flags: irq flags
+ *
+ * This is a counter-part of snd_pcm_stream_lock_irqsave().
+ */
 void snd_pcm_stream_unlock_irqrestore(struct snd_pcm_substream *substream,
 				      unsigned long flags)
 {
@@ -3312,6 +3347,15 @@ static const struct vm_operations_struct snd_pcm_vm_ops_data_fault = {
 /*
  * mmap the DMA buffer on RAM
  */
+
+/**
+ * snd_pcm_lib_default_mmap - Default PCM data mmap function
+ * @substream: PCM substream
+ * @area: VMA
+ *
+ * This is the default mmap handler for PCM data.  When mmap pcm_ops is NULL,
+ * this function is invoked implicitly.
+ */
 int snd_pcm_lib_default_mmap(struct snd_pcm_substream *substream,
 			     struct vm_area_struct *area)
 {
@@ -3343,6 +3387,15 @@ EXPORT_SYMBOL_GPL(snd_pcm_lib_default_mmap);
  * mmap the DMA buffer on I/O memory area
  */
 #if SNDRV_PCM_INFO_MMAP_IOMEM
+/**
+ * snd_pcm_lib_mmap_iomem - Default PCM data mmap function for I/O mem
+ * @substream: PCM substream
+ * @area: VMA
+ *
+ * When your hardware uses the iomapped pages as the hardware buffer and
+ * wants to mmap it, pass this function as mmap pcm_ops.  Note that this
+ * is supposed to work only on limited architectures.
+ */
 int snd_pcm_lib_mmap_iomem(struct snd_pcm_substream *substream,
 			   struct vm_area_struct *area)
 {
-- 
2.1.2
