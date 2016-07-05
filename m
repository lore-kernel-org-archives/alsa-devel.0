From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC alsa-lib 5/5] pcm: Remove home brew atomic
	operations
Date: Tue,  5 Jul 2016 17:20:24 +0200
Message-ID: <20160705152024.20152-6-tiwai@suse.de>
References: <20160705152024.20152-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E8ED2663DF
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 17:20:28 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 97213AD44
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 15:20:27 +0000 (UTC)
In-Reply-To: <20160705152024.20152-1-tiwai@suse.de>
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

We've had a few home brew atomic operations in a couple of places in
the PCM code.  This was for supporting the concurrent accesses, but in
practice, it couldn't cover the race properly by itself alone.

Since we have a wider concurrency protection via mutex now, we can get
rid of these atomic codes, which worsens the portability
significantly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/Makefile.am  |   2 +-
 include/iatomic.h    | 170 ---------------------------------------------------
 src/pcm/Makefile.am  |   2 +-
 src/pcm/atomic.c     |  43 -------------
 src/pcm/pcm_plugin.c |  72 +++++-----------------
 src/pcm/pcm_plugin.h |   2 -
 src/pcm/pcm_rate.c   |  34 ++---------
 7 files changed, 20 insertions(+), 305 deletions(-)
 delete mode 100644 include/iatomic.h
 delete mode 100644 src/pcm/atomic.c

diff --git a/include/Makefile.am b/include/Makefile.am
index 31a3f748dc46..67f32e36c911 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -5,7 +5,7 @@ alsaincludedir = ${includedir}/alsa
 
 alsainclude_HEADERS = asoundlib.h asoundef.h \
 		      version.h global.h input.h output.h error.h \
-		      conf.h control.h iatomic.h
+		      conf.h control.h
 
 if BUILD_CTL_PLUGIN_EXT
 alsainclude_HEADERS += control_external.h
diff --git a/include/iatomic.h b/include/iatomic.h
deleted file mode 100644
index acdd3e29c13a..000000000000
--- a/include/iatomic.h
+++ /dev/null
@@ -1,170 +0,0 @@
-#ifndef __ALSA_IATOMIC_H
-#define __ALSA_IATOMIC_H
-
-#ifdef __i386__
-#define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
-#define rmb()	mb()
-#define wmb()	__asm__ __volatile__ ("": : :"memory")
-#define IATOMIC_DEFINED		1
-#endif 
-
-#ifdef __x86_64__
-#define mb() 	asm volatile("mfence":::"memory")
-#define rmb()	asm volatile("lfence":::"memory")
-#define wmb()	asm volatile("sfence":::"memory")
-#define IATOMIC_DEFINED		1
-#endif
-
-#ifdef __ia64__
-/*
- * Macros to force memory ordering.  In these descriptions, "previous"
- * and "subsequent" refer to program order; "visible" means that all
- * architecturally visible effects of a memory access have occurred
- * (at a minimum, this means the memory has been read or written).
- *
- *   wmb():	Guarantees that all preceding stores to memory-
- *		like regions are visible before any subsequent
- *		stores and that all following stores will be
- *		visible only after all previous stores.
- *   rmb():	Like wmb(), but for reads.
- *   mb():	wmb()/rmb() combo, i.e., all previous memory
- *		accesses are visible before all subsequent
- *		accesses and vice versa.  This is also known as
- *		a "fence."
- *
- * Note: "mb()" and its variants cannot be used as a fence to order
- * accesses to memory mapped I/O registers.  For that, mf.a needs to
- * be used.  However, we don't want to always use mf.a because (a)
- * it's (presumably) much slower than mf and (b) mf.a is supported for
- * sequential memory pages only.
- */
-#define mb()	__asm__ __volatile__ ("mf" ::: "memory")
-#define rmb()	mb()
-#define wmb()	mb()
-
-#define IATOMIC_DEFINED		1
-
-#endif /* __ia64__ */
-
-#ifdef __alpha__
-
-#define mb() \
-__asm__ __volatile__("mb": : :"memory")
-
-#define rmb() \
-__asm__ __volatile__("mb": : :"memory")
-
-#define wmb() \
-__asm__ __volatile__("wmb": : :"memory")
-
-#define IATOMIC_DEFINED		1
-
-#endif /* __alpha__ */
-
-#ifdef __powerpc__
-
-/*
- * Memory barrier.
- * The sync instruction guarantees that all memory accesses initiated
- * by this processor have been performed (with respect to all other
- * mechanisms that access memory).  The eieio instruction is a barrier
- * providing an ordering (separately) for (a) cacheable stores and (b)
- * loads and stores to non-cacheable memory (e.g. I/O devices).
- *
- * mb() prevents loads and stores being reordered across this point.
- * rmb() prevents loads being reordered across this point.
- * wmb() prevents stores being reordered across this point.
- *
- * We can use the eieio instruction for wmb, but since it doesn't
- * give any ordering guarantees about loads, we have to use the
- * stronger but slower sync instruction for mb and rmb.
- */
-#define mb()  __asm__ __volatile__ ("sync" : : : "memory")
-#define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
-#define wmb()  __asm__ __volatile__ ("eieio" : : : "memory")
-
-#define IATOMIC_DEFINED		1
-
-#endif /* __powerpc__ */
-
-#ifndef IATOMIC_DEFINED
-
-/* Generic __sync_synchronize is available from gcc 4.1 */
-
-#define mb() __sync_synchronize()
-#define rmb() mb()
-#define wmb() mb()
-
-#define IATOMIC_DEFINED		1
-
-#endif /* IATOMIC_DEFINED */
-
-/*
- *  Atomic read/write
- *  Copyright (c) 2001 by Abramo Bagnara <abramo@alsa-project.org>
- */
-
-/* Max number of times we must spin on a spin-lock calling sched_yield().
-   After MAX_SPIN_COUNT iterations, we put the calling thread to sleep. */
-
-#ifndef MAX_SPIN_COUNT
-#define MAX_SPIN_COUNT 50
-#endif
-
-/* Duration of sleep (in nanoseconds) when we can't acquire a spin-lock
-   after MAX_SPIN_COUNT iterations of sched_yield().
-   This MUST BE > 2ms.
-   (Otherwise the kernel does busy-waiting for real-time threads,
-    giving other threads no chance to run.) */
-
-#ifndef SPIN_SLEEP_DURATION
-#define SPIN_SLEEP_DURATION 2000001
-#endif
-
-typedef struct {
-	unsigned int begin, end;
-} snd_atomic_write_t;
-
-typedef struct {
-	volatile const snd_atomic_write_t *write;
-	unsigned int end;
-} snd_atomic_read_t;
-
-void snd_atomic_read_wait(snd_atomic_read_t *t);
-
-static __inline__ void snd_atomic_write_init(snd_atomic_write_t *w)
-{
-	w->begin = 0;
-	w->end = 0;
-}
-
-static __inline__ void snd_atomic_write_begin(snd_atomic_write_t *w)
-{
-	w->begin++;
-	wmb();
-}
-
-static __inline__ void snd_atomic_write_end(snd_atomic_write_t *w)
-{
-	wmb();
-	w->end++;
-}
-
-static __inline__ void snd_atomic_read_init(snd_atomic_read_t *r, snd_atomic_write_t *w)
-{
-	r->write = w;
-}
-
-static __inline__ void snd_atomic_read_begin(snd_atomic_read_t *r)
-{
-	r->end = r->write->end;
-	rmb();
-}
-
-static __inline__ int snd_atomic_read_ok(snd_atomic_read_t *r)
-{
-	rmb();
-	return r->end == r->write->begin;
-}
-
-#endif /* __ALSA_IATOMIC_H */
diff --git a/src/pcm/Makefile.am b/src/pcm/Makefile.am
index 81598f634bc3..8edbd0b5c719 100644
--- a/src/pcm/Makefile.am
+++ b/src/pcm/Makefile.am
@@ -3,7 +3,7 @@ DIST_SUBDIRS = scopes
 
 EXTRA_LTLIBRARIES = libpcm.la
 
-libpcm_la_SOURCES = atomic.c mask.c interval.c \
+libpcm_la_SOURCES = mask.c interval.c \
 		    pcm.c pcm_params.c pcm_simple.c \
 		    pcm_hw.c pcm_misc.c pcm_mmap.c pcm_symbols.c
 
diff --git a/src/pcm/atomic.c b/src/pcm/atomic.c
deleted file mode 100644
index 75659457af76..000000000000
--- a/src/pcm/atomic.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- *  Atomic read/write
- *  Copyright (c) 2001 by Abramo Bagnara <abramo@alsa-project.org>
- *
- *   This library is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU Lesser General Public License as
- *   published by the Free Software Foundation; either version 2.1 of
- *   the License, or (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU Lesser General Public License for more details.
- *
- *   You should have received a copy of the GNU Lesser General Public
- *   License along with this library; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
- */
-  
-#include <stdlib.h>
-#include <time.h>
-#include <sched.h>
-#include "iatomic.h"
-
-void snd_atomic_read_wait(snd_atomic_read_t *t)
-{
-	volatile const snd_atomic_write_t *w = t->write;
-	unsigned int loops = 0;
-	struct timespec ts;
-	while (w->begin != w->end) {
-		if (loops < MAX_SPIN_COUNT) {
-			sched_yield();
-			loops++;
-			continue;
-		}
-		loops = 0;
-		ts.tv_sec = 0;
-		ts.tv_nsec = SPIN_SLEEP_DURATION;
-		nanosleep(&ts, NULL);
-	}
-}
-
diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
index 8527783c3569..e53c5bb5568e 100644
--- a/src/pcm/pcm_plugin.c
+++ b/src/pcm/pcm_plugin.c
@@ -133,7 +133,6 @@ void snd_pcm_plugin_init(snd_pcm_plugin_t *plugin)
 	memset(plugin, 0, sizeof(snd_pcm_plugin_t));
 	plugin->undo_read = snd_pcm_plugin_undo_read;
 	plugin->undo_write = snd_pcm_plugin_undo_write;
-	snd_atomic_write_init(&plugin->watom);
 }
 
 static int snd_pcm_plugin_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
@@ -157,15 +156,11 @@ static int snd_pcm_plugin_prepare(snd_pcm_t *pcm)
 {
 	snd_pcm_plugin_t *plugin = pcm->private_data;
 	int err;
-	snd_atomic_write_begin(&plugin->watom);
 	err = snd_pcm_prepare(plugin->gen.slave);
-	if (err < 0) {
-		snd_atomic_write_end(&plugin->watom);
+	if (err < 0)
 		return err;
-	}
 	*pcm->hw.ptr = 0;
 	*pcm->appl.ptr = 0;
-	snd_atomic_write_end(&plugin->watom);
 	if (plugin->init) {
 		err = plugin->init(pcm);
 		if (err < 0)
@@ -178,15 +173,11 @@ static int snd_pcm_plugin_reset(snd_pcm_t *pcm)
 {
 	snd_pcm_plugin_t *plugin = pcm->private_data;
 	int err;
-	snd_atomic_write_begin(&plugin->watom);
 	err = snd_pcm_reset(plugin->gen.slave);
-	if (err < 0) {
-		snd_atomic_write_end(&plugin->watom);
+	if (err < 0)
 		return err;
-	}
 	*pcm->hw.ptr = 0;
 	*pcm->appl.ptr = 0;
-	snd_atomic_write_end(&plugin->watom);
 	if (plugin->init) {
 		err = plugin->init(pcm);
 		if (err < 0)
@@ -212,14 +203,10 @@ snd_pcm_sframes_t snd_pcm_plugin_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames
 		return 0;
 	
         sframes = frames;
-	snd_atomic_write_begin(&plugin->watom);
 	sframes = snd_pcm_rewind(plugin->gen.slave, sframes);
-	if (sframes < 0) {
-		snd_atomic_write_end(&plugin->watom);
+	if (sframes < 0)
 		return sframes;
-	}
 	snd_pcm_mmap_appl_backward(pcm, (snd_pcm_uframes_t) sframes);
-	snd_atomic_write_end(&plugin->watom);
 	return (snd_pcm_sframes_t) sframes;
 }
 
@@ -240,14 +227,10 @@ snd_pcm_sframes_t snd_pcm_plugin_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frame
 		return 0;
 	
         sframes = frames;
-	snd_atomic_write_begin(&plugin->watom);
 	sframes = INTERNAL(snd_pcm_forward)(plugin->gen.slave, sframes);
-	if (sframes < 0) {
-		snd_atomic_write_end(&plugin->watom);
+	if (sframes < 0)
 		return sframes;
-	}
 	snd_pcm_mmap_appl_forward(pcm, (snd_pcm_uframes_t) frames);
-	snd_atomic_write_end(&plugin->watom);
 	return (snd_pcm_sframes_t) frames;
 }
 
@@ -279,31 +262,27 @@ static snd_pcm_sframes_t snd_pcm_plugin_write_areas(snd_pcm_t *pcm,
 			err = -EPIPE;
 			goto error;
 		}
-		snd_atomic_write_begin(&plugin->watom);
 		result = snd_pcm_mmap_commit(slave, slave_offset, slave_frames);
 		if (result > 0 && (snd_pcm_uframes_t)result != slave_frames) {
 			snd_pcm_sframes_t res;
 			res = plugin->undo_write(pcm, slave_areas, slave_offset + result, slave_frames, slave_frames - result);
 			if (res < 0) {
 				err = res;
-				goto error_atomic;
+				goto error;
 			}
 			frames -= res;
 		}
 		if (result <= 0) {
 			err = result;
-			goto error_atomic;
+			goto error;
 		}
 		snd_pcm_mmap_appl_forward(pcm, frames);
-		snd_atomic_write_end(&plugin->watom);
 		offset += frames;
 		xfer += frames;
 		size -= frames;
 	}
 	return (snd_pcm_sframes_t)xfer;
 
- error_atomic:
-	snd_atomic_write_end(&plugin->watom);
  error:
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : err;
 }
@@ -336,7 +315,6 @@ static snd_pcm_sframes_t snd_pcm_plugin_read_areas(snd_pcm_t *pcm,
 			err = -EPIPE;
 			goto error;
 		}
-		snd_atomic_write_begin(&plugin->watom);
 		result = snd_pcm_mmap_commit(slave, slave_offset, slave_frames);
 		if (result > 0 && (snd_pcm_uframes_t)result != slave_frames) {
 			snd_pcm_sframes_t res;
@@ -344,24 +322,21 @@ static snd_pcm_sframes_t snd_pcm_plugin_read_areas(snd_pcm_t *pcm,
 			res = plugin->undo_read(slave, areas, offset, frames, slave_frames - result);
 			if (res < 0) {
 				err = res;
-				goto error_atomic;
+				goto error;
 			}
 			frames -= res;
 		}
 		if (result <= 0) {
 			err = result;
-			goto error_atomic;
+			goto error;
 		}
 		snd_pcm_mmap_appl_forward(pcm, frames);
-		snd_atomic_write_end(&plugin->watom);
 		offset += frames;
 		xfer += frames;
 		size -= frames;
 	}
 	return (snd_pcm_sframes_t)xfer;
 
- error_atomic:
-	snd_atomic_write_end(&plugin->watom);
  error:
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : err;
 }
@@ -417,9 +392,7 @@ snd_pcm_plugin_mmap_commit(snd_pcm_t *pcm,
 	int err;
 
 	if (pcm->stream == SND_PCM_STREAM_CAPTURE) {
-		snd_atomic_write_begin(&plugin->watom);
 		snd_pcm_mmap_appl_forward(pcm, size);
-		snd_atomic_write_end(&plugin->watom);
 		return size;
 	}
 	slave_size = snd_pcm_avail_update(slave);
@@ -443,7 +416,6 @@ snd_pcm_plugin_mmap_commit(snd_pcm_t *pcm,
 			frames = cont;
 		frames = plugin->write(pcm, areas, appl_offset, frames,
 				       slave_areas, slave_offset, &slave_frames);
-		snd_atomic_write_begin(&plugin->watom);
 		result = snd_pcm_mmap_commit(slave, slave_offset, slave_frames);
 		if (result > 0 && (snd_pcm_uframes_t)result != slave_frames) {
 			snd_pcm_sframes_t res;
@@ -451,16 +423,15 @@ snd_pcm_plugin_mmap_commit(snd_pcm_t *pcm,
 			res = plugin->undo_write(pcm, slave_areas, slave_offset + result, slave_frames, slave_frames - result);
 			if (res < 0) {
 				err = res;
-				goto error_atomic;
+				goto error;
 			}
 			frames -= res;
 		}
 		if (result <= 0) {
 			err = result;
-			goto error_atomic;
+			goto error;
 		}
 		snd_pcm_mmap_appl_forward(pcm, frames);
-		snd_atomic_write_end(&plugin->watom);
 		if (frames == cont)
 			appl_offset = 0;
 		else
@@ -475,8 +446,6 @@ snd_pcm_plugin_mmap_commit(snd_pcm_t *pcm,
 	}
 	return xfer;
 
- error_atomic:
-	snd_atomic_write_end(&plugin->watom);
  error:
 	return xfer > 0 ? xfer : err;
 }
@@ -519,7 +488,6 @@ static snd_pcm_sframes_t snd_pcm_plugin_avail_update(snd_pcm_t *pcm)
 				frames = cont;
 			frames = (plugin->read)(pcm, areas, hw_offset, frames,
 					      slave_areas, slave_offset, &slave_frames);
-			snd_atomic_write_begin(&plugin->watom);
 			result = snd_pcm_mmap_commit(slave, slave_offset, slave_frames);
 			if (result > 0 && (snd_pcm_uframes_t)result != slave_frames) {
 				snd_pcm_sframes_t res;
@@ -527,16 +495,15 @@ static snd_pcm_sframes_t snd_pcm_plugin_avail_update(snd_pcm_t *pcm)
 				res = plugin->undo_read(slave, areas, hw_offset, frames, slave_frames - result);
 				if (res < 0) {
 					err = res;
-					goto error_atomic;
+					goto error;
 				}
 				frames -= res;
 			}
 			if (result <= 0) {
 				err = result;
-				goto error_atomic;
+				goto error;
 			}
 			snd_pcm_mmap_hw_forward(pcm, frames);
-			snd_atomic_write_end(&plugin->watom);
 			if (frames == cont)
 				hw_offset = 0;
 			else
@@ -547,8 +514,6 @@ static snd_pcm_sframes_t snd_pcm_plugin_avail_update(snd_pcm_t *pcm)
 		}
 		return (snd_pcm_sframes_t)xfer;
 
-	error_atomic:
-		snd_atomic_write_end(&plugin->watom);
 	error:
 		return xfer > 0 ? (snd_pcm_sframes_t)xfer : err;
 	}
@@ -558,24 +523,15 @@ static int snd_pcm_plugin_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 {
 	snd_pcm_plugin_t *plugin = pcm->private_data;
 	snd_pcm_sframes_t err;
-	snd_atomic_read_t ratom;
-	snd_atomic_read_init(&ratom, &plugin->watom);
- _again:
-	snd_atomic_read_begin(&ratom);
+
 	/* sync with the latest hw and appl ptrs */
 	snd_pcm_plugin_avail_update(pcm);
 
 	err = snd_pcm_status(plugin->gen.slave, status);
-	if (err < 0) {
-		snd_atomic_read_ok(&ratom);
+	if (err < 0)
 		return err;
-	}
 	status->appl_ptr = *pcm->appl.ptr;
 	status->hw_ptr = *pcm->hw.ptr;
-	if (!snd_atomic_read_ok(&ratom)) {
-		snd_atomic_read_wait(&ratom);
-		goto _again;
-	}
 	return 0;
 }
 
diff --git a/src/pcm/pcm_plugin.h b/src/pcm/pcm_plugin.h
index b0a3e1869ea1..217f0757ea59 100644
--- a/src/pcm/pcm_plugin.h
+++ b/src/pcm/pcm_plugin.h
@@ -19,7 +19,6 @@
  *
  */
   
-#include "iatomic.h"
 #include "pcm_generic.h"
 
 typedef snd_pcm_uframes_t (*snd_pcm_slave_xfer_areas_func_t)
@@ -46,7 +45,6 @@ typedef struct {
 	snd_pcm_slave_xfer_areas_undo_func_t undo_write;
 	int (*init)(snd_pcm_t *pcm);
 	snd_pcm_uframes_t appl_ptr, hw_ptr;
-	snd_atomic_write_t watom;
 } snd_pcm_plugin_t;	
 
 /* make local functions really local */
diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 0fe466647a55..e44bd21be8c9 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -32,7 +32,6 @@
 #include "pcm_local.h"
 #include "pcm_plugin.h"
 #include "pcm_rate.h"
-#include "iatomic.h"
 
 #include "plugin_ops.h"
 
@@ -51,7 +50,6 @@ typedef struct _snd_pcm_rate snd_pcm_rate_t;
 
 struct _snd_pcm_rate {
 	snd_pcm_generic_t gen;
-	snd_atomic_write_t watom;
 	snd_pcm_uframes_t appl_ptr, hw_ptr;
 	snd_pcm_uframes_t last_commit_ptr;
 	snd_pcm_uframes_t orig_avail_min;
@@ -584,9 +582,7 @@ static int snd_pcm_rate_hwsync(snd_pcm_t *pcm)
 	int err = snd_pcm_hwsync(rate->gen.slave);
 	if (err < 0)
 		return err;
-	snd_atomic_write_begin(&rate->watom);
 	snd_pcm_rate_sync_hwptr(pcm);
-	snd_atomic_write_end(&rate->watom);
 	return 0;
 }
 
@@ -602,15 +598,11 @@ static int snd_pcm_rate_prepare(snd_pcm_t *pcm)
 	snd_pcm_rate_t *rate = pcm->private_data;
 	int err;
 
-	snd_atomic_write_begin(&rate->watom);
 	err = snd_pcm_prepare(rate->gen.slave);
-	if (err < 0) {
-		snd_atomic_write_end(&rate->watom);
+	if (err < 0)
 		return err;
-	}
 	*pcm->hw.ptr = 0;
 	*pcm->appl.ptr = 0;
-	snd_atomic_write_end(&rate->watom);
 	err = snd_pcm_rate_init(pcm);
 	if (err < 0)
 		return err;
@@ -621,15 +613,11 @@ static int snd_pcm_rate_reset(snd_pcm_t *pcm)
 {
 	snd_pcm_rate_t *rate = pcm->private_data;
 	int err;
-	snd_atomic_write_begin(&rate->watom);
 	err = snd_pcm_reset(rate->gen.slave);
-	if (err < 0) {
-		snd_atomic_write_end(&rate->watom);
+	if (err < 0)
 		return err;
-	}
 	*pcm->hw.ptr = 0;
 	*pcm->appl.ptr = 0;
-	snd_atomic_write_end(&rate->watom);
 	err = snd_pcm_rate_init(pcm);
 	if (err < 0)
 		return err;
@@ -923,9 +911,7 @@ static snd_pcm_sframes_t snd_pcm_rate_mmap_commit(snd_pcm_t *pcm,
 		if (err < 0)
 			return err;
 	}
-	snd_atomic_write_begin(&rate->watom);
 	snd_pcm_mmap_appl_forward(pcm, size);
-	snd_atomic_write_end(&rate->watom);
 	return size;
 }
 
@@ -938,9 +924,7 @@ static snd_pcm_sframes_t snd_pcm_rate_avail_update(snd_pcm_t *pcm)
 	slave_size = snd_pcm_avail_update(slave);
 	if (pcm->stream == SND_PCM_STREAM_CAPTURE)
 		goto _capture;
-	snd_atomic_write_begin(&rate->watom);
 	snd_pcm_rate_sync_hwptr(pcm);
-	snd_atomic_write_end(&rate->watom);
 	snd_pcm_rate_sync_playback_area(pcm, rate->appl_ptr);
 	return snd_pcm_mmap_avail(pcm);
  _capture: {
@@ -1090,15 +1074,10 @@ static int snd_pcm_rate_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 {
 	snd_pcm_rate_t *rate = pcm->private_data;
 	snd_pcm_sframes_t err;
-	snd_atomic_read_t ratom;
-	snd_atomic_read_init(&ratom, &rate->watom);
- _again:
-	snd_atomic_read_begin(&ratom);
+
 	err = snd_pcm_status(rate->gen.slave, status);
-	if (err < 0) {
-		snd_atomic_read_ok(&ratom);
+	if (err < 0)
 		return err;
-	}
 	if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
 		if (rate->start_pending)
 			status->state = SND_PCM_STATE_RUNNING;
@@ -1116,10 +1095,6 @@ static int snd_pcm_rate_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 		status->avail = snd_pcm_mmap_capture_avail(pcm);
 		status->avail_max = rate->ops.output_frames(rate->obj, status->avail_max);
 	}
-	if (!snd_atomic_read_ok(&ratom)) {
-		snd_atomic_read_wait(&ratom);
-		goto _again;
-	}
 	return 0;
 }
 
@@ -1309,7 +1284,6 @@ int snd_pcm_rate_open(snd_pcm_t **pcmp, const char *name,
 	rate->gen.close_slave = close_slave;
 	rate->srate = srate;
 	rate->sformat = sformat;
-	snd_atomic_write_init(&rate->watom);
 
 	err = snd_pcm_new(&pcm, SND_PCM_TYPE_RATE, name, slave->stream, slave->mode);
 	if (err < 0) {
-- 
2.9.0
