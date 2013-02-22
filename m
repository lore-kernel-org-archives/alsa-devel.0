From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH TINYCOMPRESS 7/14 v2] compress:
	Remove	hardcoded limit on length of poll() wait
Date: Fri, 22 Feb 2013 16:03:25 +0000
Message-ID: <20130222160325.GG21174@opensource.wolfsonmicro.com>
References: <20130210001308.GG31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AE3B2265378
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 17:03:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130210001308.GG31139@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

For best power-saving we want to sleep on poll() for as long as
possible, we don't want to wake unnecessarily for arbitrary time
limits. Adds function compress_set_max_poll_wait() so that
client can configure the poll() timeout.

---
 compress.c                          |   17 ++++++++++++++---
 include/tinycompress/tinycompress.h |   10 ++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/compress.c b/compress.c
index 801f055..478652a 100644
--- a/compress.c
+++ b/compress.c
@@ -77,12 +77,16 @@
 
 #define COMPR_ERR_MAX 128
 
+/* Default maximum time we will wait in a poll() - 20 seconds */
+#define DEFAULT_MAX_POLL_WAIT_MS    20000
+
 struct compress {
 	int fd;
 	unsigned int flags;
 	char error[COMPR_ERR_MAX];
 	struct compr_config *config;
 	int running;
+	int max_poll_wait_ms;
 };
 
 static int oops(struct compress *compress, int e, const char *fmt, ...)
@@ -217,6 +221,8 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 
 	snprintf(fn, sizeof(fn), "/dev/snd/comprC%uD%u", card, device);
 
+	compress->max_poll_wait_ms = DEFAULT_MAX_POLL_WAIT_MS;
+
 	compress->flags = flags;
 	if (!((flags & COMPRESS_OUT) || (flags & COMPRESS_IN))) {
 		oops(&bad_compress, -EINVAL, "can't deduce device direction from given flags");
@@ -331,9 +337,9 @@ int compress_write(struct compress *compress, const void *buf, unsigned int size
 			return oops(compress, errno, "cannot get avail");
 
 		/* we will write only when avail > fragment size */
-		if (avail.avail < compress->config->fragment_size) {
-			/* nothing to write so wait for 10secs */
-			ret = poll(&fds, 1, 1000000);
+		if (avail.avail < compress->config.fragment_size) {
+			/* nothing to write so wait */
+			ret = poll(&fds, 1, compress->max_poll_wait_ms);
 			if (ret < 0)
 				return oops(compress, errno, "poll error");
 			if (ret == 0)
@@ -441,3 +447,8 @@ bool is_codec_supported(unsigned int card, unsigned int device,
 	return ret;
 }
 
+void compress_set_max_poll_wait(struct compress *compress, int milliseconds)
+{
+	compress->max_poll_wait_ms = milliseconds;
+}
+
diff --git a/include/tinycompress/tinycompress.h b/include/tinycompress/tinycompress.h
index 49c0ff2..982ff6b 100644
--- a/include/tinycompress/tinycompress.h
+++ b/include/tinycompress/tinycompress.h
@@ -190,6 +190,16 @@ int compress_drain(struct compress *compress);
 bool is_codec_supported(unsigned int card, unsigned int device,
 	       unsigned int flags, struct snd_codec *codec);
 
+/*
+ * compress_set_max_poll_wait: set the maximum time tinycompress
+ * will wait for driver to signal a poll(). Interval is in
+ * milliseconds.
+ * Pass interval of -1 to disable timeout and make poll() wait
+ * until driver signals.
+ * If this function is not used the timeout defaults to 20 seconds.
+ */
+void compress_set_max_poll_wait(struct compress *compress, int milliseconds);
+
 int is_compress_running(struct compress *compress);
 
 int is_compress_ready(struct compress *compress);
-- 
1.7.2.5
