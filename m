From: Waldemar Brodkorb <wbx@openadk.org>
Subject: [PATCH]: remove unnecessary/obsolete compat/hsearch_r.c
Date: Wed, 2 Oct 2013 21:00:51 +0200
Message-ID: <20131002190051.GA18721@waldemar-brodkorb.de>
Reply-To: Waldemar Brodkorb <wbx@openadk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from helium.waldemar-brodkorb.de (helium.waldemar-brodkorb.de
 [89.238.66.15]) by alsa0.perex.cz (Postfix) with ESMTP id EC5CC2654E0
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2013 21:00:51 +0200 (CEST)
Content-Disposition: inline
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

The usage of hsearch functions where removed long time
ago in commit 273d115de05574251bdd661747ecb68449a5cf1d.
This patch highly increases portability for non-glibc systems.

Remove the complete compat directory as requested by
Takashi Iwai.

Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
---
 configure.in           |    4 +-
 src/Makefile.am        |    7 +-
 src/compat/Makefile.am |    8 --
 src/compat/hsearch_r.c |  236 ------------------------------------------------
 4 files changed, 3 insertions(+), 252 deletions(-)
 delete mode 100644 src/compat/Makefile.am
 delete mode 100644 src/compat/empty.c
 delete mode 100644 src/compat/hsearch_r.c

diff --git a/configure.in b/configure.in
index 00fff2b..35fd89f 100644
--- a/configure.in
+++ b/configure.in
@@ -64,8 +64,6 @@ AC_HEADER_TIME
 
 dnl Checks for library functions.
 AC_PROG_GCC_TRADITIONAL
-AC_CHECK_FUNC([hsearch_r], [HAVE_HSEARCH_R=yes])
-AM_CONDITIONAL([ALSA_HSEARCH_R], [test "x$HAVE_HSEARCH_R" != xyes])
 AC_CHECK_FUNCS([uselocale])
 
 SAVE_LIBRARY_VERSION
@@ -659,7 +657,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/pcm/Makefile src/pcm/scopes/Makefile \
 	  src/rawmidi/Makefile src/timer/Makefile \
           src/hwdep/Makefile src/seq/Makefile src/ucm/Makefile \
-          src/compat/Makefile src/alisp/Makefile \
+          src/alisp/Makefile \
 	  src/conf/Makefile src/conf/alsa.conf.d/Makefile \
 	  src/conf/cards/Makefile \
 	  src/conf/pcm/Makefile \
diff --git a/src/Makefile.am b/src/Makefile.am
index 08f482a..8f789fe 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -46,8 +46,8 @@ if BUILD_ALISP
 SUBDIRS += alisp
 libasound_la_LIBADD += alisp/libalisp.la
 endif
-SUBDIRS += compat conf
-libasound_la_LIBADD += compat/libcompat.la @ALSA_DEPLIBS@
+SUBDIRS += conf
+libasound_la_LIBADD += @ALSA_DEPLIBS@
 
 libasound_la_LDFLAGS = -version-info $(COMPATNUM) $(VSYMS) $(SYMFUNCS) $(LDFLAGS_NOUNDEFINED)
 
@@ -84,9 +84,6 @@ ucm/libucm.la:
 instr/libinstr.la:
 	$(MAKE) -C instr libinstr.la
 
-compat/libcompat.la:
-	$(MAKE) -C compat libcompat.la
-
 alisp/libalisp.la:
 	$(MAKE) -C alisp libalisp.la
 
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
deleted file mode 100644
index 01f54fc..0000000
--- a/src/compat/Makefile.am
+++ /dev/null
@@ -1,8 +0,0 @@
-noinst_LTLIBRARIES = libcompat.la
-EXTRA_libcompat_la_SOURCES = hsearch_r.c
-
-if ALSA_HSEARCH_R
-libcompat_la_SOURCES = empty.c hsearch_r.c
-else
-libcompat_la_SOURCES = empty.c
-endif
diff --git a/src/compat/empty.c b/src/compat/empty.c
deleted file mode 100644
index e69de29..0000000
diff --git a/src/compat/hsearch_r.c b/src/compat/hsearch_r.c
deleted file mode 100644
index 96ceac1..0000000
--- a/src/compat/hsearch_r.c
+++ /dev/null
@@ -1,236 +0,0 @@
-/* Copyright (C) 1993, 1995, 1996, 1997 Free Software Foundation, Inc.
-   This file is part of the GNU C Library.
-   Contributed by Ulrich Drepper <drepper@gnu.ai.mit.edu>, 1993.
-
-   The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Lesser General Public License as
-   published by the Free Software Foundation; either version 2.1 of the
-   License, or (at your option) any later version.
-
-   The GNU C Library is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Lesser General Public License for more details.
-
-   You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; see the file COPYING.LIB.  If not,
-   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
-   Boston, MA 02111-1307, USA.  */
-
-#include <errno.h>
-#include <malloc.h>
-#include <string.h>
-
-#define __USE_GNU
-#ifndef __set_errno
-#define __set_errno(e) errno = (e)
-#endif
-#include <search.h>
-
-/* [Aho,Sethi,Ullman] Compilers: Principles, Techniques and Tools, 1986
-   [Knuth]            The Art of Computer Programming, part 3 (6.4)  */
-
-
-/* The reentrant version has no static variables to maintain the state.
-   Instead the interface of all functions is extended to take an argument
-   which describes the current status.  */
-typedef struct _ENTRY
-{
-  unsigned int used;
-  ENTRY entry;
-}
-_ENTRY;
-
-
-/* For the used double hash method the table size has to be a prime. To
-   correct the user given table size we need a prime test.  This trivial
-   algorithm is adequate because
-   a)  the code is (most probably) called a few times per program run and
-   b)  the number is small because the table must fit in the core  */
-static int
-isprime (unsigned int number)
-{
-  /* no even number will be passed */
-  unsigned int div = 3;
-
-  while (div * div < number && number % div != 0)
-    div += 2;
-
-  return number % div != 0;
-}
-
-
-/* Before using the hash table we must allocate memory for it.
-   Test for an existing table are done. We allocate one element
-   more as the found prime number says. This is done for more effective
-   indexing as explained in the comment for the hsearch function.
-   The contents of the table is zeroed, especially the field used
-   becomes zero.  */
-int
-hcreate_r (nel, htab)
-     size_t nel;
-     struct hsearch_data *htab;
-{
-  /* Test for correct arguments.  */
-  if (htab == NULL)
-    {
-      __set_errno (EINVAL);
-      return 0;
-    }
-
-  /* There is still another table active. Return with error. */
-  if (htab->table != NULL)
-    return 0;
-
-  /* Change nel to the first prime number not smaller as nel. */
-  nel |= 1;      /* make odd */
-  while (!isprime (nel))
-    nel += 2;
-
-  htab->size = nel;
-  htab->filled = 0;
-
-  /* allocate memory and zero out */
-  htab->table = (_ENTRY *) calloc (htab->size + 1, sizeof (_ENTRY));
-  if (htab->table == NULL)
-    return 0;
-
-  /* everything went alright */
-  return 1;
-}
-
-
-/* After using the hash table it has to be destroyed. The used memory can
-   be freed and the local static variable can be marked as not used.  */
-void
-hdestroy_r (htab)
-     struct hsearch_data *htab;
-{
-  /* Test for correct arguments.  */
-  if (htab == NULL)
-    {
-      __set_errno (EINVAL);
-      return;
-    }
-
-  if (htab->table != NULL)
-    /* free used memory */
-    free (htab->table);
-
-  /* the sign for an existing table is an value != NULL in htable */
-  htab->table = NULL;
-}
-
-
-/* This is the search function. It uses double hashing with open addressing.
-   The argument item.key has to be a pointer to an zero terminated, most
-   probably strings of chars. The function for generating a number of the
-   strings is simple but fast. It can be replaced by a more complex function
-   like ajw (see [Aho,Sethi,Ullman]) if the needs are shown.
-
-   We use an trick to speed up the lookup. The table is created by hcreate
-   with one more element available. This enables us to use the index zero
-   special. This index will never be used because we store the first hash
-   index in the field used where zero means not used. Every other value
-   means used. The used field can be used as a first fast comparison for
-   equality of the stored and the parameter value. This helps to prevent
-   unnecessary expensive calls of strcmp.  */
-int
-hsearch_r (item, action, retval, htab)
-     ENTRY item;
-     ACTION action;
-     ENTRY **retval;
-     struct hsearch_data *htab;
-{
-  unsigned int hval;
-  unsigned int count;
-  unsigned int len = strlen (item.key);
-  unsigned int idx;
-
-  /* Compute an value for the given string. Perhaps use a better method. */
-  hval = len;
-  count = len;
-  while (count-- > 0)
-    {
-      hval <<= 4;
-      hval += item.key[count];
-    }
-
-  /* First hash function: simply take the modulo but prevent zero. */
-  hval %= htab->size;
-  if (hval == 0)
-    ++hval;
-
-  /* The first index tried. */
-  idx = hval;
-
-  if (htab->table[idx].used)
-    {
-      /* Further action might be required according to the action value. */
-      unsigned hval2;
-
-      if (htab->table[idx].used == hval
-	  && strcmp (item.key, htab->table[idx].entry.key) == 0)
-	{
-          if (action == ENTER)
-	    htab->table[idx].entry.data = item.data;
-
-	  *retval = &htab->table[idx].entry;
-	  return 1;
-	}
-
-      /* Second hash function, as suggested in [Knuth] */
-      hval2 = 1 + hval % (htab->size - 2);
-
-      do
-	{
-	  /* Because SIZE is prime this guarantees to step through all
-             available indexes.  */
-          if (idx <= hval2)
-	    idx = htab->size + idx - hval2;
-	  else
-	    idx -= hval2;
-
-	  /* If we visited all entries leave the loop unsuccessfully.  */
-	  if (idx == hval)
-	    break;
-
-            /* If entry is found use it. */
-          if (htab->table[idx].used == hval
-	      && strcmp (item.key, htab->table[idx].entry.key) == 0)
-	    {
-              if (action == ENTER)
-	        htab->table[idx].entry.data = item.data;
-
-	      *retval = &htab->table[idx].entry;
-	      return 1;
-	    }
-	}
-      while (htab->table[idx].used);
-    }
-
-  /* An empty bucket has been found. */
-  if (action == ENTER)
-    {
-      /* If table is full and another entry should be entered return
-	 with error.  */
-      if (action == ENTER && htab->filled == htab->size)
-	{
-	  __set_errno (ENOMEM);
-	  *retval = NULL;
-	  return 0;
-	}
-
-      htab->table[idx].used  = hval;
-      htab->table[idx].entry = item;
-
-      ++htab->filled;
-
-      *retval = &htab->table[idx].entry;
-      return 1;
-    }
-
-  __set_errno (ESRCH);
-  *retval = NULL;
-  return 0;
-}
-- 
1.7.9.5
