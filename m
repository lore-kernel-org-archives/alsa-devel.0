From: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH - alsa-lib 1/1] snd_user_file: avoid use wordexp
Date: Wed, 12 Jul 2017 10:44:54 +0200
Message-ID: <20170712084454.11338-1-ncopa@alpinelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

Generally, wordexp is a large attack vector and it is better to avoid it
since only tilde expansion is needed.

[1]: http://pubs.opengroup.org/onlinepubs/9699919799/functions/wordexp.html#tag_16_684_08
[2]: http://bugs.alpinelinux.org/issues/7454#note-2

Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>

diff --git a/configure.ac b/configure.ac
index 26e5d125..076c6bab 100644
--- a/configure.ac
+++ b/configure.ac
@@ -304,7 +304,7 @@ fi
 AC_SUBST(ALSA_DEPLIBS)
 
 dnl Check for headers
-AC_CHECK_HEADERS([wordexp.h endian.h sys/endian.h sys/shm.h])
+AC_CHECK_HEADERS([endian.h sys/endian.h sys/shm.h])
 
 dnl Check for resmgr support...
 AC_MSG_CHECKING(for resmgr support)
diff --git a/src/userfile.c b/src/userfile.c
index 72779da4..0e3f5fae 100644
--- a/src/userfile.c
+++ b/src/userfile.c
@@ -21,6 +21,11 @@
 #include <config.h>
 #include <string.h>
 #include <errno.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <pwd.h>
+#include <stdio.h>
+#include <stdlib.h>
 
 /**
  * \brief Get the full file name
@@ -28,46 +33,58 @@
  * \param result The pointer to store the resultant file name
  * \return 0 if successful, or a negative error code
  *
- * Parses the given file name with POSIX-Shell-like expansion and
- * stores the first matchine one.  The returned string is strdup'ed.
+ * Parses the given file name with POSIX-Shell-like expansion for ~/.
+ * The returned string is strdup'ed.
  */
 
-#ifdef HAVE_WORDEXP_H
-#include <wordexp.h>
 #include <assert.h>
 int snd_user_file(const char *file, char **result)
 {
-	wordexp_t we;
 	int err;
-	
+	size_t len;
+	char *buf = NULL;
+
 	assert(file && result);
-	err = wordexp(file, &we, WRDE_NOCMD);
-	switch (err) {
-	case WRDE_NOSPACE:
-		wordfree(&we);
-		return -ENOMEM;
-	case 0:
-		if (we.we_wordc == 1)
-			break;
-		wordfree(&we);
-		/* fall thru */
-	default:
-		return -EINVAL;
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
 	}
-	*result = strdup(we.we_wordv[0]);
-	wordfree(&we);
+
+out:
+	if (buf)
+		free(buf);
+
 	if (*result == NULL)
 		return -ENOMEM;
 	return 0;
 }
 
-#else /* !HAVE_WORDEXP_H */
-/* just copy the string - would be nicer to expand by ourselves, though... */
-int snd_user_file(const char *file, char **result)
-{
-	*result = strdup(file);
-	if (! *result)
-		return -ENOMEM;
-	return 0;
-}
-#endif /* HAVE_WORDEXP_H */
-- 
2.13.2
