From: domen@coderock.org
Subject: [patch 1/1] alsa: Fix "nocast type" warnings
Date: Thu, 14 Jul 2005 23:43:29 +0200
Message-ID: <20050714214329.423569000@homer>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 50B0E1E9
	for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2005 23:43:56 +0200 (MEST)
Content-Disposition: inline; filename=sparse-sound_core_memalloc
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, Victor Fusco <victor@cetuc.puc-rio.br>, domen@coderock.org
List-Id: alsa-devel@alsa-project.org

From: Victor Fusco <victor@cetuc.puc-rio.br>


Fix the sparse warning "implicit cast to nocast type"

File/Subsystem:sound/core

Signed-off-by: Victor Fusco <victor@cetuc.puc-rio.br>
Signed-off-by: Domen Puncer <domen@coderock.org>

--

---
 include/sound/core.h              |    6 +++---
 include/sound/driver.h            |    2 +-
 sound/core/memalloc.c             |    3 ++-
 sound/core/memory.c               |    8 ++++----
 sound/core/seq/instr/ainstr_gf1.c |    3 ++-
 sound/core/seq/instr/ainstr_iw.c  |    8 +++++---
 sound/core/wrappers.c             |    2 +-
 7 files changed, 18 insertions(+), 14 deletions(-)

Index: quilt/sound/core/memalloc.c
===================================================================
--- quilt.orig/sound/core/memalloc.c
+++ quilt/sound/core/memalloc.c
@@ -105,7 +105,8 @@ struct snd_mem_list {
  */
 
 static void *snd_dma_hack_alloc_coherent(struct device *dev, size_t size,
-					 dma_addr_t *dma_handle, int flags)
+					 dma_addr_t *dma_handle,
+					 unsigned int __nocast flags)
 {
 	void *ret;
 	u64 dma_mask, coherent_dma_mask;
Index: quilt/sound/core/wrappers.c
===================================================================
--- quilt.orig/sound/core/wrappers.c
+++ quilt/sound/core/wrappers.c
@@ -27,7 +27,7 @@
 #include <linux/fs.h>
 
 #ifdef CONFIG_SND_DEBUG_MEMORY
-void *snd_wrapper_kmalloc(size_t size, int flags)
+void *snd_wrapper_kmalloc(size_t size, unsigned int __nocast flags)
 {
 	return kmalloc(size, flags);
 }
Index: quilt/include/sound/core.h
===================================================================
--- quilt.orig/include/sound/core.h
+++ quilt/include/sound/core.h
@@ -287,12 +287,12 @@ void snd_memory_init(void);
 void snd_memory_done(void);
 int snd_memory_info_init(void);
 int snd_memory_info_done(void);
-void *snd_hidden_kmalloc(size_t size, int flags);
-void *snd_hidden_kcalloc(size_t n, size_t size, int flags);
+void *snd_hidden_kmalloc(size_t size, unsigned int __nocast flags);
+void *snd_hidden_kcalloc(size_t n, size_t size, unsigned int __nocast flags);
 void snd_hidden_kfree(const void *obj);
 void *snd_hidden_vmalloc(unsigned long size);
 void snd_hidden_vfree(void *obj);
-char *snd_hidden_kstrdup(const char *s, int flags);
+char *snd_hidden_kstrdup(const char *s, unsigned int __nocast flags);
 #define kmalloc(size, flags) snd_hidden_kmalloc(size, flags)
 #define kcalloc(n, size, flags) snd_hidden_kcalloc(n, size, flags)
 #define kfree(obj) snd_hidden_kfree(obj)
Index: quilt/include/sound/driver.h
===================================================================
--- quilt.orig/include/sound/driver.h
+++ quilt/include/sound/driver.h
@@ -51,7 +51,7 @@
 #ifdef CONFIG_SND_DEBUG_MEMORY
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-void *snd_wrapper_kmalloc(size_t, int);
+void *snd_wrapper_kmalloc(size_t, unsigned int __nocast);
 #undef kmalloc
 void snd_wrapper_kfree(const void *);
 #undef kfree
Index: quilt/sound/core/memory.c
===================================================================
--- quilt.orig/sound/core/memory.c
+++ quilt/sound/core/memory.c
@@ -89,7 +89,7 @@ void snd_memory_done(void)
 	}
 }
 
-static void *__snd_kmalloc(size_t size, int flags, void *caller)
+static void *__snd_kmalloc(size_t size, unsigned int __nocast flags, void *caller)
 {
 	unsigned long cpu_flags;
 	struct snd_alloc_track *t;
@@ -111,12 +111,12 @@ static void *__snd_kmalloc(size_t size, 
 }
 
 #define _snd_kmalloc(size, flags) __snd_kmalloc((size), (flags), __builtin_return_address(0));
-void *snd_hidden_kmalloc(size_t size, int flags)
+void *snd_hidden_kmalloc(size_t size, unsigned int __nocast flags)
 {
 	return _snd_kmalloc(size, flags);
 }
 
-void *snd_hidden_kcalloc(size_t n, size_t size, int flags)
+void *snd_hidden_kcalloc(size_t n, size_t size, unsigned int __nocast flags)
 {
 	void *ret = NULL;
 	if (n != 0 && size > INT_MAX / n)
@@ -184,7 +184,7 @@ void snd_hidden_vfree(void *obj)
 	snd_wrapper_vfree(obj);
 }
 
-char *snd_hidden_kstrdup(const char *s, int flags)
+char *snd_hidden_kstrdup(const char *s, unsigned int __nocast flags)
 {
 	int len;
 	char *buf;
Index: quilt/sound/core/seq/instr/ainstr_gf1.c
===================================================================
--- quilt.orig/sound/core/seq/instr/ainstr_gf1.c
+++ quilt/sound/core/seq/instr/ainstr_gf1.c
@@ -50,7 +50,8 @@ static int snd_seq_gf1_copy_wave_from_st
 {
 	gf1_wave_t *wp, *prev;
 	gf1_xwave_t xp;
-	int err, gfp_mask;
+	int err;
+	unsigned int gfp_mask;
 	unsigned int real_size;
 	
 	gfp_mask = atomic ? GFP_ATOMIC : GFP_KERNEL;
Index: quilt/sound/core/seq/instr/ainstr_iw.c
===================================================================
--- quilt.orig/sound/core/seq/instr/ainstr_iw.c
+++ quilt/sound/core/seq/instr/ainstr_iw.c
@@ -58,7 +58,7 @@ static int snd_seq_iwffff_copy_env_from_
 					       iwffff_xenv_t *ex,
 					       char __user **data,
 					       long *len,
-					       int gfp_mask)
+					       unsigned int __nocast gfp_mask)
 {
 	__u32 stype;
 	iwffff_env_record_t *rp, *rp_last;
@@ -128,7 +128,8 @@ static int snd_seq_iwffff_copy_wave_from
 {
 	iwffff_wave_t *wp, *prev;
 	iwffff_xwave_t xp;
-	int err, gfp_mask;
+	int err;
+	unsigned int gfp_mask;
 	unsigned int real_size;
 	
 	gfp_mask = atomic ? GFP_ATOMIC : GFP_KERNEL;
@@ -234,7 +235,8 @@ static int snd_seq_iwffff_put(void *priv
 	iwffff_xinstrument_t ix;
 	iwffff_layer_t *lp, *prev_lp;
 	iwffff_xlayer_t lx;
-	int err, gfp_mask;
+	int err;
+	unsigned int gfp_mask;
 
 	if (cmd != SNDRV_SEQ_INSTR_PUT_CMD_CREATE)
 		return -EINVAL;

--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
