From: Michael Forney <mforney@mforney.org>
Subject: [PATCH 1/6] Use __func__ instead of __FUNCTION__
Date: Tue, 11 Jun 2019 23:08:09 -0700
Message-ID: <20190612060814.13534-2-mforney@mforney.org>
References: <20190612060814.13534-1-mforney@mforney.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE47BF896E0
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 08:08:19 +0200 (CEST)
Received: by mail-pl1-x62f.google.com with SMTP id f97so6174949plb.5
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 23:08:19 -0700 (PDT)
In-Reply-To: <20190612060814.13534-1-mforney@mforney.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

They are equivalent, but __func__ is in C99. __FUNCTION__ exists only
for backwards compatibility with old gcc versions.

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 aserver/aserver.c   | 4 ++--
 include/error.h     | 8 ++++----
 include/local.h     | 4 ++--
 src/pcm/pcm_share.c | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/aserver/aserver.c b/aserver/aserver.c
index 6d20f330..28387021 100644
--- a/aserver/aserver.c
+++ b/aserver/aserver.c
@@ -39,13 +39,13 @@ char *command;
 
 #if __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ >= 95)
 #define ERROR(...) do {\
-	fprintf(stderr, "%s %s:%i:(%s) ", command, __FILE__, __LINE__, __FUNCTION__); \
+	fprintf(stderr, "%s %s:%i:(%s) ", command, __FILE__, __LINE__, __func__); \
 	fprintf(stderr, __VA_ARGS__); \
 	putc('\n', stderr); \
 } while (0)
 #else
 #define ERROR(args...) do {\
-	fprintf(stderr, "%s %s:%i:(%s) ", command, __FILE__, __LINE__, __FUNCTION__); \
+	fprintf(stderr, "%s %s:%i:(%s) ", command, __FILE__, __LINE__, __func__); \
 	fprintf(stderr, ##args); \
 	putc('\n', stderr); \
 } while (0)
diff --git a/include/error.h b/include/error.h
index 9a996aba..7239db85 100644
--- a/include/error.h
+++ b/include/error.h
@@ -61,11 +61,11 @@ extern snd_lib_error_handler_t snd_lib_error;
 extern int snd_lib_error_set_handler(snd_lib_error_handler_t handler);
 
 #if __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ > 95)
-#define SNDERR(...) snd_lib_error(__FILE__, __LINE__, __FUNCTION__, 0, __VA_ARGS__) /**< Shows a sound error message. */
-#define SYSERR(...) snd_lib_error(__FILE__, __LINE__, __FUNCTION__, errno, __VA_ARGS__) /**< Shows a system error message (related to \c errno). */
+#define SNDERR(...) snd_lib_error(__FILE__, __LINE__, __func__, 0, __VA_ARGS__) /**< Shows a sound error message. */
+#define SYSERR(...) snd_lib_error(__FILE__, __LINE__, __func__, errno, __VA_ARGS__) /**< Shows a system error message (related to \c errno). */
 #else
-#define SNDERR(args...) snd_lib_error(__FILE__, __LINE__, __FUNCTION__, 0, ##args) /**< Shows a sound error message. */
-#define SYSERR(args...) snd_lib_error(__FILE__, __LINE__, __FUNCTION__, errno, ##args) /**< Shows a system error message (related to \c errno). */
+#define SNDERR(args...) snd_lib_error(__FILE__, __LINE__, __func__, 0, ##args) /**< Shows a sound error message. */
+#define SYSERR(args...) snd_lib_error(__FILE__, __LINE__, __func__, errno, ##args) /**< Shows a system error message (related to \c errno). */
 #endif
 
 /** \} */
diff --git a/include/local.h b/include/local.h
index e8390df5..bf19f0f8 100644
--- a/include/local.h
+++ b/include/local.h
@@ -244,8 +244,8 @@ size_t snd_strlcpy(char *dst, const char *src, size_t size);
 #ifndef NDEBUG
 #define CHECK_SANITY(x) x
 extern snd_lib_error_handler_t snd_err_msg;
-#define SNDMSG(args...) snd_err_msg(__FILE__, __LINE__, __FUNCTION__, 0, ##args)
-#define SYSMSG(args...) snd_err_msg(__FILE__, __LINE__, __FUNCTION__, errno, ##args)
+#define SNDMSG(args...) snd_err_msg(__FILE__, __LINE__, __func__, 0, ##args)
+#define SYSMSG(args...) snd_err_msg(__FILE__, __LINE__, __func__, errno, ##args)
 #else
 #define CHECK_SANITY(x) 0 /* not evaluated */
 #define SNDMSG(args...) /* nop */
diff --git a/src/pcm/pcm_share.c b/src/pcm/pcm_share.c
index 5a540c4f..bff9507d 100644
--- a/src/pcm/pcm_share.c
+++ b/src/pcm/pcm_share.c
@@ -54,11 +54,11 @@ char *snd_pcm_share_slaves_mutex_holder;
 do { \
 	int err = pthread_mutex_trylock(mutex); \
 	if (err < 0) { \
-		fprintf(stderr, "lock " #mutex " is busy (%s): waiting in " __FUNCTION__ "\n", *(mutex##_holder)); \
+		fprintf(stderr, "lock " #mutex " is busy (%s): waiting in " __func__ "\n", *(mutex##_holder)); \
 		pthread_mutex_lock(mutex); \
 		fprintf(stderr, "... got\n"); \
 	} \
-	*(mutex##_holder) = __FUNCTION__; \
+	*(mutex##_holder) = __func__; \
 } while (0)
 
 #define Pthread_mutex_unlock(mutex) \
-- 
2.20.1
