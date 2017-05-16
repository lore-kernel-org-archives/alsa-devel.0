From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib 2/2] conf: Check the availability of
	PTHREAD_MUTEX_RECURSIVE
Date: Tue, 16 May 2017 16:28:19 +0200
Message-ID: <20170516142819.7734-2-tiwai@suse.de>
References: <20170516142819.7734-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 24060266CAF
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 16:28:23 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 86C9CAAB6
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 14:28:22 +0000 (UTC)
In-Reply-To: <20170516142819.7734-1-tiwai@suse.de>
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

Check the availability of PTHREAD_MUTEX_RECURSIVE in configure script
and use it only when possible.  A fairly old version of glibc still
seems working, but just to be sure.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 configure.ac  | 9 +++++++++
 src/conf.c    | 2 ++
 src/pcm/pcm.c | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/configure.ac b/configure.ac
index ec254762bed6..a17f2c4aef5c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -266,6 +266,15 @@ else
   AC_MSG_RESULT(no)
 fi
 
+dnl Check for pthread
+if test "$HAVE_LIBPTHREAD" = "yes"; then
+  AC_CHECK_DECL(PTHREAD_MUTEX_RECURSIVE,
+    AC_DEFINE(HAVE_PTHREAD_MUTEX_RECURSIVE, [],
+      [Define if your pthreads implementation have PTHREAD_MUTEX_RECURSIVE]),
+    ,
+    [#include <pthread.h>])
+fi
+
 dnl Check for __thread
 AC_MSG_CHECKING([for __thread])
 AC_LINK_IFELSE([AC_LANG_PROGRAM([#if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__)) && ((__GNUC__ < 4) || (__GNUC__ == 4 && __GNUC_MINOR__ < 1) || (__GNUC__ == 4 && __GNUC_MINOR__ == 1 && __GNUC_PATCHLEVEL__ < 2))
diff --git a/src/conf.c b/src/conf.c
index 2b52b44e9144..9a887433a4fe 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -490,7 +490,9 @@ static void snd_config_init_mutex(void)
 	pthread_mutexattr_t attr;
 
 	pthread_mutexattr_init(&attr);
+#ifdef HAVE_PTHREAD_MUTEX_RECURSIVE
 	pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
+#endif
 	pthread_mutex_init(&snd_config_update_mutex, &attr);
 	pthread_mutexattr_destroy(&attr);
 }
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 8a7a5950de3c..200b10c2c09c 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -2600,7 +2600,9 @@ int snd_pcm_new(snd_pcm_t **pcmp, snd_pcm_type_t type, const char *name,
 	INIT_LIST_HEAD(&pcm->async_handlers);
 #ifdef THREAD_SAFE_API
 	pthread_mutexattr_init(&attr);
+#ifdef HAVE_PTHREAD_MUTEX_RECURSIVE
 	pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
+#endif
 	pthread_mutex_init(&pcm->lock, &attr);
 	/* use locking as default;
 	 * each plugin may suppress this in its open call
-- 
2.13.0
