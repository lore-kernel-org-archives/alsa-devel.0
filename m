From: Patrick Welche <prlw1@cam.ac.uk>
Subject: Re: alsa on non-linux
Date: Tue, 14 Jan 2014 10:17:09 +0000
Message-ID: <20140114101709.GB160@quark.internal.precedence.co.uk>
References: <20140110153700.GC1173@quark.internal.precedence.co.uk>
 <s5hwqi4t6zg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ppsw-33.csi.cam.ac.uk (ppsw-33.csi.cam.ac.uk [131.111.8.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 94DB4261680
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 11:17:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwqi4t6zg.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 13, 2014 at 01:13:23PM +0100, Takashi Iwai wrote:
> At Fri, 10 Jan 2014 15:37:00 +0000,
> Patrick Welche wrote:
> > 
> > I am currently successfully running alsa-lib 1.0.22 with oss plugins on
> > a non-linux box. The advantage is that programs written to use libasound
> > work.
> > 
> > I just tried to update alsa-lib, and see that now alsa-lib directly
> > includes headers like linux/types.h, and all protection, such as
> > 
> >   #if defined(LINUX) || defined(__LINUX__) || defined(__linux__)
> > 
> > has been removed. This means that compilation on non-linux is
> > essentially impossible.
> > 
> > Is it that there is now a different way of obtaining that alsa lib
> > front end / oss back end layer?
> 
> Feel free to submit a fix patch :)
> 
> The inclusions of linux/*.h are mostly due to laziness.  If a patch is
> confirmed to work on both Linux glibc and others, we'll happily take
> that patch.

I started out, writing the attached patch in November, but then it looked
as though the boundaries of application library interface and linux sound
chip driver had become so blurred that I thought that a decision had been
taken to bin all OSes bar linux, hence the question. Can you give me a
hint on how you think it is supposed to work? (Which bits you know are
meant to be linux only, as they are the actual drivers, which bits you think
should be OS agnositic...)

Cheers,

Patrick

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Portability-fix-Use-SND_LITTLE_ENDIAN-SND_BIG_ENDIAN.patch"

>From c60287a8c5d3175b6df07757241cb59f3b94edb7 Mon Sep 17 00:00:00 2001
From: Patrick Welche <prlw1@cam.ac.uk>
Date: Tue, 12 Nov 2013 14:25:05 +0000
Subject: [PATCH] Portability fix: Use SND_LITTLE_ENDIAN / SND_BIG_ENDIAN
 instead of endian.h

The header file which defines __BYTE_ORDER varies wildly between
OSes, so give autoconf the job of detecting endianness. Use the
answer by defining SND_LITTLE_ENDIAN / SND_BIG_ENDIAN and using
them. (This may require teaching alsa-utilities expecting asoundlib.h
to include endian.h for them to use SND_LITTLE_ENDIAN instead.)
---
 configure.in             | 7 ++++++-
 include/asoundlib-head.h | 1 -
 include/local.h          | 9 +++------
 src/pcm/pcm_file.c       | 3 +--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/configure.in b/configure.in
index 35fd89f..679decd 100644
--- a/configure.in
+++ b/configure.in
@@ -61,6 +61,7 @@ dnl Checks for typedefs, structures, and compiler characteristics.
 AC_C_CONST
 AC_C_INLINE
 AC_HEADER_TIME
+AC_C_BIGENDIAN
 
 dnl Checks for library functions.
 AC_PROG_GCC_TRADITIONAL
@@ -685,5 +686,9 @@ test "$build_seq" = "yes" && echo "#include <alsa/seq_event.h>" >> include/asoun
 test "$build_seq" = "yes" && echo "#include <alsa/seq.h>" >> include/asoundlib.h
 test "$build_seq" = "yes" && echo "#include <alsa/seqmid.h>" >> include/asoundlib.h
 test "$build_seq" = "yes" && echo "#include <alsa/seq_midi_event.h>" >> include/asoundlib.h
+echo "" >> include/asoundlib.h
+test "$ac_cv_c_bigendian" = "yes" && echo "#define SND_BIG_ENDIAN" >> include/asoundlib.h
+test "$ac_cv_c_bigendian" = "yes" && echo "#define SNDRV_BIG_ENDIAN" >> include/asoundlib.h
+test "$ac_cv_c_bigendian" = "no" && echo "#define SND_LITTLE_ENDIAN" >> include/asoundlib.h
+test "$ac_cv_c_bigendian" = "no" && echo "#define SNDRV_LITTLE_ENDIAN" >> include/asoundlib.h
 cat "$srcdir"/include/asoundlib-tail.h >> include/asoundlib.h
-
diff --git a/include/asoundlib-head.h b/include/asoundlib-head.h
index 71b5c29..31408a4 100644
--- a/include/asoundlib-head.h
+++ b/include/asoundlib-head.h
@@ -35,7 +35,6 @@
 #include <string.h>
 #include <fcntl.h>
 #include <assert.h>
-#include <endian.h>
 #include <sys/poll.h>
 #include <errno.h>
 #include <stdarg.h>
diff --git a/include/local.h b/include/local.h
index 9464efa..1e7c0dc 100644
--- a/include/local.h
+++ b/include/local.h
@@ -28,7 +28,6 @@
 #include <string.h>
 #include <fcntl.h>
 #include <assert.h>
-#include <endian.h>
 #include <stdarg.h>
 #include <sys/poll.h>
 #include <sys/types.h>
@@ -46,14 +45,12 @@
 #define RTLD_NOW	0
 #endif
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-#define SND_LITTLE_ENDIAN
-#define SNDRV_LITTLE_ENDIAN
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#ifdef WORDS_BIGENDIAN
 #define SND_BIG_ENDIAN
 #define SNDRV_BIG_ENDIAN
 #else
-#error "Unsupported endian..."
+#define SND_LITTLE_ENDIAN
+#define SNDRV_LITTLE_ENDIAN
 #endif
 
 #define _snd_config_iterator list_head
diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index 7123025..7ee5c37 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -26,7 +26,6 @@
  *
  */
   
-#include <endian.h>
 #include <byteswap.h>
 #include <ctype.h>
 #include <string.h>
@@ -90,7 +89,7 @@ typedef struct {
 	size_t filelen;
 } snd_pcm_file_t;
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#ifdef SND_LITTLE_ENDIAN
 #define TO_LE32(x)	(x)
 #define TO_LE16(x)	(x)
 #else
-- 
1.8.5.2


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--zhXaljGHf11kAtnf--
