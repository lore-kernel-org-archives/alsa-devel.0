From: Mark Hills <mark@xwax.org>
Subject: Avoiding wordexp prevents environment variables being
	used
Date: Sun, 8 Apr 2018 17:13:43 +0100 (BST)
Message-ID: <1804081611300.19491@stax.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 by alsa0.perex.cz (Postfix) with ESMTP id 14B25267353
 for <alsa-devel@alsa-project.org>; Sun,  8 Apr 2018 18:13:47 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Natanael Copa <ncopa@alpinelinux.org>
List-Id: alsa-devel@alsa-project.org

I just came up against the patch below; it prevents useful snippets of 
alsa-conf like this:

  @hooks [
      {
          func load
          files [
              "~/.asoundrc-$HOSTNAME"
          ]
          errors false
       }
  ]

as the evalutation of all but "~" has been removed.

Seems like removal of a perfectly good feature in the name of security; 
because wordexp()

1) is not used (and should not be used) on data originating from an 
   untrusted source

2) is already used with WRDE_NOCMD, which the same POSIX spec documents 
   as:

    "The WRDE_NOCMD flag is provided for applications that, for security 
     or other reasons, want to prevent a user from executing shell 
     commands."

3) on glibc can be seen (with strace) not to execute other commands 

If one is to treat the POSIX doc as gospel (as cited by the patch) the 
cause of firefox (circa July 2017) not working would actually be that musl 
does not honour WRDE_NOCMD to the letter. I agree the spec of wordexp() 
could be more useful, though.

Also, hypothesising the attacks of an already-compromised application 
would get into a sticky conversation about the thread safety of 
getenv("HOME") (and associated buffer wrangling)  vs. a library function 
being used for its intended purpose.

In practice, Firefox may have moved on here (no ALSA support anymore) so 
should quirks of its sandbox be driving this?

-- 
Mark


>From cb34cee0d8da2fb131986d5782ddf5cec985c532 Mon Sep 17 00:00:00 2001
From: Natanael Copa <ncopa@alpinelinux.org>
Date: Fri, 14 Jul 2017 18:47:05 +0200
Subject: [PATCH] snd_user_file: avoid use wordexp

As suggested in POSIX[1], wordexp might execute the shell. If the libc
implementation does so, it will break the firefox sandbox which does
not allow exec. This happened on Alpine Linux with musl libc[2].

Since we cannot guarantee that the system wordexp implementation does
not execute shell, we cannot really use it, and need to implement the
~/ expansion ourselves.

We provide a configure option --with-wordexp for users that still may
need it, but we leave this off by default because wordexp is a large
attack vector and it is better to avoid it.

[1]: http://pubs.opengroup.org/onlinepubs/9699919799/functions/wordexp.html#tag_16_684_08
[2]: http://bugs.alpinelinux.org/issues/7454#note-2

Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 configure.ac   | 19 ++++++++++++++++-
 src/userfile.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 26e5d125..fbcfa829 100644
--- a/configure.ac
+++ b/configure.ac
@@ -303,8 +303,25 @@ fi
 
 AC_SUBST(ALSA_DEPLIBS)
 
+dnl Check for use of wordexp...
+AC_MSG_CHECKING(for use of wordexp)
+AC_ARG_WITH(wordexp,
+  AS_HELP_STRING([--with-wordexp],
+    [Use wordexp when expanding configs (default = no)]),
+  [case "$withval" in
+	y|yes) wordexp=yes ;;
+	*) wordexp=no ;;
+   esac],)
+if test "$wordexp" = "yes" ; then
+  AC_DEFINE(HAVE_WORDEXP, "1", [Enable use of wordexp])
+  AC_MSG_RESULT(yes)
+  AC_CHECK_HEADER([wordexp.h],[], [AC_MSG_ERROR([Couldn't find wordexp.h])])
+else
+  AC_MSG_RESULT(no)
+fi
+
 dnl Check for headers
-AC_CHECK_HEADERS([wordexp.h endian.h sys/endian.h sys/shm.h])
+AC_CHECK_HEADERS([endian.h sys/endian.h sys/shm.h])
 
 dnl Check for resmgr support...
 AC_MSG_CHECKING(for resmgr support)
diff --git a/src/userfile.c b/src/userfile.c
index 72779da4..f2145470 100644
--- a/src/userfile.c
+++ b/src/userfile.c
@@ -21,6 +21,7 @@
 #include <config.h>
 #include <string.h>
 #include <errno.h>
+#include <assert.h>
 
 /**
  * \brief Get the full file name
@@ -32,14 +33,13 @@
  * stores the first matchine one.  The returned string is strdup'ed.
  */
 
-#ifdef HAVE_WORDEXP_H
+#ifdef HAVE_WORDEXP
 #include <wordexp.h>
-#include <assert.h>
 int snd_user_file(const char *file, char **result)
 {
 	wordexp_t we;
 	int err;
-	
+
 	assert(file && result);
 	err = wordexp(file, &we, WRDE_NOCMD);
 	switch (err) {
@@ -61,13 +61,62 @@ int snd_user_file(const char *file, char **result)
 	return 0;
 }
 
-#else /* !HAVE_WORDEXP_H */
-/* just copy the string - would be nicer to expand by ourselves, though... */
+#else /* !HAVE_WORDEX */
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <pwd.h>
+#include <stdio.h>
+#include <stdlib.h>
+
 int snd_user_file(const char *file, char **result)
 {
-	*result = strdup(file);
-	if (! *result)
+	int err;
+	size_t len;
+	char *buf = NULL;
+
+	assert(file && result);
+	*result = NULL;
+
+	/* expand ~/ if needed */
+	if (file[0] == '~' && file[1] == '/') {
+		const char *home = getenv("HOME");
+		if (home == NULL) {
+			struct passwd pwent, *p = NULL;
+			uid_t id = getuid();
+			size_t bufsize = 1024;
+
+			buf = malloc(bufsize);
+			if (buf == NULL)
+				goto out;
+
+			while ((err = getpwuid_r(id, &pwent, buf, bufsize, &p)) == ERANGE) {
+				char *newbuf;
+				bufsize += 1024;
+				if (bufsize < 1024)
+					break;
+				newbuf = realloc(buf, bufsize);
+				if (newbuf == NULL)
+					goto out;
+				buf = newbuf;
+			}
+			home = err ? "" : pwent.pw_dir;
+		}
+		len = strlen(home) + strlen(&file[2]) + 2;
+		*result = malloc(len);
+		if (*result)
+			snprintf(*result, len, "%s/%s", home, &file[2]);
+	} else {
+		*result = strdup(file);
+	}
+
+out:
+	if (buf)
+		free(buf);
+
+	if (*result == NULL)
 		return -ENOMEM;
 	return 0;
 }
-#endif /* HAVE_WORDEXP_H */
+
+#endif /* HAVE_WORDEXP */
-- 
2.14.1
