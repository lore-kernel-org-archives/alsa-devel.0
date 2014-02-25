From: Patrick Welche <prlw1@cam.ac.uk>
Subject: Re: alsa on non-linux
Date: Tue, 25 Feb 2014 12:45:14 +0000
Message-ID: <20140225124514.GB23368@quantz>
References: <20140110153700.GC1173@quark.internal.precedence.co.uk>
 <s5hwqi4t6zg.wl%tiwai@suse.de>
 <20140114101709.GB160@quark.internal.precedence.co.uk>
 <52D5440A.6080508@ladisch.de>
 <20140116132717.GB10286@quark.internal.precedence.co.uk>
 <s5hvbxkrqcz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gatW/ieO32f1wygP"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ppsw-52.csi.cam.ac.uk (ppsw-52.csi.cam.ac.uk [131.111.8.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 827512619E9
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 13:45:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hvbxkrqcz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 16, 2014 at 02:46:52PM +0100, Takashi Iwai wrote:
> At Thu, 16 Jan 2014 13:27:17 +0000,
> Patrick Welche wrote:
> Why excluding hwdep...?  And, no, the codes have been written to be
> portable, but the primary goal is a thin layer for Linux kernel ABI,
> thus its support is the highest priority.
> 
> The linux/*.h file inclusions are basically for allowing to include
> sound/asound.h as is.  It's a part of the Linux kernel code, and I
> don't think we'd add any extra ifdefs there just for non-Linux.
> 
> IOW, you'd need to prepare some compatible defines before including
> sound/asound.h if you need to compile for non-Linux systems.

I should have read this more carefully before preparing the attached
patch... I changed asound.h.

The attached is what I needed to be able to build with

../configure --prefix=/tmp \
--enable-debug          \
--disable-resmgr        \
--disable-aload         \
--disable-mixer         \
--disable-pcm           \
--disable-rawmidi       \
--disable-hwdep         \
--disable-seq           \
--disable-ucm           \
--disable-alisp         \
--disable-old-symbols   \
--disable-python        \
--with-debug            \
--without-libdl         \
--without-librt

so not very useful, but at least it compiles.
(This is on top of 0001-autotools-update-style.patch)

Suggestions on what to try to make it acceptable?

(byteswap.h needs tackling next...)

Cheers,

Patrick

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-Portability-fixes-mainly-asound.h.patch"

>From f4ddc106fc53ec950ec8b6f2b0bfe3e1677c959f Mon Sep 17 00:00:00 2001
From: Patrick Welche <prlw1@cam.ac.uk>
Date: Tue, 25 Feb 2014 12:25:48 +0000
Subject: [PATCH 2/2] Portability fixes - mainly asound.h

- replace linux/types.h with types from sys/types.h and stdint.h:
  __kerne_off_t (long) -> off_t (matches mmap())
  __kernel_pid_t (int) -> pid_t
  __u32                -> uint32_t
  __u64                -> uint64_t
- protect possibly now unnessary #include <linux/...> in local.h with ifdefs
- map extended error numbers to (not quite equivalent) posix numbers ifndef:
  ESTRPIPE Streams pipe error           -> EPIPE Broken pipe
  EBADFD   File descriptor in bad state -> EBADF Bad file descriptor
- test for versionsort() and only use if we have it
- LIST_HEAD can be defined in sys/queue.h, so undefine before defining

Signed-off-by: Patrick Welche <prlw1@cam.ac.uk>
---
 configure.ac           |  4 ++--
 include/list.h         |  3 +++
 include/local.h        | 10 ++++++++++
 include/sound/asound.h | 24 ++++++++++++++++++------
 src/conf.c             |  2 +-
 5 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index d744867..979764b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -65,7 +65,7 @@ AC_HEADER_TIME
 
 dnl Checks for library functions.
 AC_PROG_GCC_TRADITIONAL
-AC_CHECK_FUNCS([uselocale])
+AC_CHECK_FUNCS([uselocale versionsort])
 
 SAVE_LIBRARY_VERSION
 AC_SUBST(LIBTOOL_VERSION_INFO)
@@ -311,7 +311,7 @@ fi
 AC_SUBST(ALSA_DEPLIBS)
 
 dnl Check for headers
-AC_CHECK_HEADERS([wordexp.h endian.h sys/endian.h])
+AC_CHECK_HEADERS([wordexp.h endian.h sys/endian.h linux/types.h linux/ioctl.h])
 
 dnl Check for resmgr support...
 AC_MSG_CHECKING(for resmgr support)
diff --git a/include/list.h b/include/list.h
index 4d9895f..6cf0753 100644
--- a/include/list.h
+++ b/include/list.h
@@ -23,6 +23,9 @@ struct list_head {
 
 #define LIST_HEAD_INIT(name) { &(name), &(name) }
 
+#ifdef LIST_HEAD
+#undef LIST_HEAD
+#endif
 #define LIST_HEAD(name) \
 	struct list_head name = LIST_HEAD_INIT(name)
 
diff --git a/include/local.h b/include/local.h
index 2fe9a27..f1abfef 100644
--- a/include/local.h
+++ b/include/local.h
@@ -50,8 +50,18 @@
 #include <sys/poll.h>
 #include <sys/types.h>
 #include <errno.h>
+#ifndef ESTRPIPE
+#define ESTRPIPE EPIPE
+#endif
+#ifndef EBADFD
+#define EBADFD EBADF
+#endif
+#if HAVE_LINUX_TYPES_H
 #include <linux/types.h>
+#endif
+#if HAVE_LINUX_IOCTL_H
 #include <linux/ioctl.h>
+#endif
 
 #ifdef SUPPORT_RESMGR
 #include <resmgr.h>
diff --git a/include/sound/asound.h b/include/sound/asound.h
index 1774a5c..102bc50 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -23,7 +23,19 @@
 #ifndef _UAPI__SOUND_ASOUND_H
 #define _UAPI__SOUND_ASOUND_H
 
-#include <linux/types.h>
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <stdint.h>
+#ifdef __CHECKER__
+#define __bitwise__ __attribute__((bitwise))
+#else
+#define __bitwise__
+#endif
+#ifdef __CHECK_ENDIAN__
+#define __bitwise __bitwise__
+#else
+#define __bitwise
+#endif
 
 
 /*
@@ -348,7 +360,7 @@ struct snd_interval {
 #define SNDRV_MASK_MAX	256
 
 struct snd_mask {
-	__u32 bits[(SNDRV_MASK_MAX+31)/32];
+	uint32_t bits[(SNDRV_MASK_MAX+31)/32];
 };
 
 struct snd_pcm_hw_params {
@@ -391,7 +403,7 @@ struct snd_pcm_sw_params {
 
 struct snd_pcm_channel_info {
 	unsigned int channel;
-	__kernel_off_t offset;		/* mmap offset */
+	off_t offset;			/* mmap offset */
 	unsigned int first;		/* offset to first sample in bits */
 	unsigned int step;		/* samples distance in bits */
 };
@@ -407,7 +419,7 @@ struct snd_pcm_status {
 	snd_pcm_uframes_t avail_max;	/* max frames available on hw since last status */
 	snd_pcm_uframes_t overrange;	/* count of ADC (capture) overrange detections from last status */
 	snd_pcm_state_t suspended_state; /* suspended stream state */
-	__u32 reserved_alignment;	/* must be filled with zero */
+	uint32_t reserved_alignment;	/* must be filled with zero */
 	struct timespec audio_tstamp;	/* from sample counter or wall clock */
 	unsigned char reserved[56-sizeof(struct timespec)]; /* must be filled with zero */
 };
@@ -838,7 +850,7 @@ struct snd_ctl_elem_info {
 	snd_ctl_elem_type_t type;	/* R: value type - SNDRV_CTL_ELEM_TYPE_* */
 	unsigned int access;		/* R: value access (bitmask) - SNDRV_CTL_ELEM_ACCESS_* */
 	unsigned int count;		/* count of values */
-	__kernel_pid_t owner;		/* owner's PID of this control */
+	pid_t owner;			/* owner's PID of this control */
 	union {
 		struct {
 			long min;		/* R: minimum value */
@@ -854,7 +866,7 @@ struct snd_ctl_elem_info {
 			unsigned int items;	/* R: number of items */
 			unsigned int item;	/* W: item number */
 			char name[64];		/* R: value name */
-			__u64 names_ptr;	/* W: names list (ELEM_ADD only) */
+			uint64_t names_ptr;	/* W: names list (ELEM_ADD only) */
 			unsigned int names_length;
 		} enumerated;
 		unsigned char reserved[128];
diff --git a/src/conf.c b/src/conf.c
index 5ccc8e1..2a39d60 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -3517,7 +3517,7 @@ int snd_config_hook_load(snd_config_t *root, snd_config_t *config, snd_config_t
 			int n;
 
 #ifndef DOC_HIDDEN
-#ifdef _GNU_SOURCE
+#if defined(HAVE_VERSIONSORT) && defined(_GNU_SOURCE)
 #define SORTFUNC	versionsort
 #else
 #define SORTFUNC	alphasort
-- 
1.9.0


--gatW/ieO32f1wygP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--gatW/ieO32f1wygP--
