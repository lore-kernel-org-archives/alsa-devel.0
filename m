From: Jerome Forissier <jerome@taodyne.com>
Subject: [PATCH 1/3] Add snd_lib_error_set_local() to install a
	thread-local error handler.
Date: Thu, 31 Jan 2013 15:47:23 +0100
Message-ID: <1359643645-33558-2-git-send-email-jerome@taodyne.com>
References: <1359643645-33558-1-git-send-email-jerome@taodyne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ubuntu (102.30.7.109.rev.sfr.net [109.7.30.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 1053B2602F7
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 15:47:34 +0100 (CET)
In-Reply-To: <1359643645-33558-1-git-send-email-jerome@taodyne.com>
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
Cc: Jerome Forissier <jerome@taodyne.com>
List-Id: alsa-devel@alsa-project.org

This is required so we can make other functions reentrant (such as
snd_device_name_hint()).
The default error handling function snd_lib_error_default() now checks
if a local handler exists, and if so, calls it. Otherwise, the previous
behavior is unchanged.

Signed-off-by: Jerome Forissier <jerome@taodyne.com>
---
 configure.in    | 10 ++++++++++
 include/error.h |  6 ++++++
 src/error.c     | 24 +++++++++++++++++++++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/configure.in b/configure.in
index 4af917b..d675678 100644
--- a/configure.in
+++ b/configure.in
@@ -281,6 +281,16 @@ else
   AC_MSG_RESULT(no)
 fi
 
+dnl Check for __thread
+AC_MSG_CHECKING([for __thread])
+AC_LINK_IFELSE([AC_LANG_PROGRAM([#if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__)) && ((__GNUC__ < 4) || (__GNUC__ == 4 && __GNUC_MINOR__ < 1) || (__GNUC__ == 4 && __GNUC_MINOR__ == 1 && __GNUC_PATCHLEVEL__ < 2))
+#error gcc has this bug: http://gcc.gnu.org/ml/gcc-bugs/2006-09/msg02275.html
+#endif], [static __thread int p = 0])],
+[AC_DEFINE(HAVE___THREAD, 1,
+Define to 1 if compiler supports __thread)
+AC_MSG_RESULT([yes])],
+[AC_MSG_RESULT([no])])
+
 dnl Check for librt
 AC_MSG_CHECKING(for librt)
 AC_ARG_WITH(librt,
diff --git a/include/error.h b/include/error.h
index 6d27083..256cd5f 100644
--- a/include/error.h
+++ b/include/error.h
@@ -74,5 +74,11 @@ extern int snd_lib_error_set_handler(snd_lib_error_handler_t handler);
 }
 #endif
 
+typedef void (*snd_local_error_handler_t)(const char *file, int line,
+					  const char *func, int err,
+					  const char *fmt, va_list arg);
+
+snd_local_error_handler_t snd_lib_error_set_local(snd_local_error_handler_t func);
+
 #endif /* __ALSA_ERROR_H */
 
diff --git a/src/error.c b/src/error.c
index 7d5f509..85cea5e 100644
--- a/src/error.c
+++ b/src/error.c
@@ -60,6 +60,21 @@ const char *snd_strerror(int errnum)
 	return snd_error_codes[errnum];
 }
 
+#ifdef HAVE___THREAD
+#define TLS_PFX		__thread
+#else
+#define TLS_PFX		/* NOP */
+#endif
+
+static TLS_PFX snd_local_error_handler_t local_error = NULL;
+
+snd_local_error_handler_t snd_lib_error_set_local(snd_local_error_handler_t func)
+{
+	snd_local_error_handler_t old = local_error;
+	local_error = func;
+	return old;
+}
+
 /**
  * \brief The default error handler function.
  * \param file The filename where the error was hit.
@@ -69,12 +84,19 @@ const char *snd_strerror(int errnum)
  * \param fmt The message (including the format characters).
  * \param ... Optional arguments.
  *
- * Prints the error message including location to \c stderr.
+ * If a local error function has been installed for the current thread by
+ * \ref snd_lib_error_set_local, it is called. Otherwise, prints the error
+ * message including location to \c stderr.
  */
 static void snd_lib_error_default(const char *file, int line, const char *function, int err, const char *fmt, ...)
 {
 	va_list arg;
 	va_start(arg, fmt);
+	if (local_error) {
+		local_error(file, line, function, err, fmt, arg);
+		va_end(arg);
+		return;
+	}
 	fprintf(stderr, "ALSA lib %s:%i:(%s) ", file, line, function);
 	vfprintf(stderr, fmt, arg);
 	if (err)
-- 
1.8.1.2
