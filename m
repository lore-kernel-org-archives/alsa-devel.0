From: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH v2 - alsa-lib] snd_user_file: avoid use wordexp
Date: Fri, 14 Jul 2017 18:47:05 +0200
Message-ID: <20170714164705.3212-1-ncopa@alpinelinux.org>
References: <s5ha84akm6j.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5ha84akm6j.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Natanael Copa <ncopa@alpinelinux.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As suggested in POSIX[1], wordexp might execute the shell. If the libc
implementation does so, it will break the firefox sandbox which does
not allow exec. This happened on Alpine Linux with musl libc[2].

Since we cannot guarantee that the system wordexp implementation does
not execute shell, we cannot really use it, and need to implement the
~/ expansion ourselves.

We provide a configure option --with-wordexp for users that still may
need it, but we leave this off by default because wordexp is a large
large attack vector and it is better to avoid it.

[1]: http://pubs.opengroup.org/onlinepubs/9699919799/functions/wordexp.html#tag_16_684_08
[2]: http://bugs.alpinelinux.org/issues/7454#note-2

Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
---
changes v2:
 - add configure option to enable old behaviour which uses wordexp.
   this is off by default.

I was not sure if I should use --with-wordexp or --enable-wordexp but
went with --with-wordexp similar to --with-softfloat.

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
2.13.2
