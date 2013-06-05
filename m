From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [tinycompress][PATCH 1/1] compress: Add non-blocking
	I/O
Date: Wed, 5 Jun 2013 13:31:00 +0100
Message-ID: <20130605123100.GE21556@opensource.wolfsonmicro.com>
References: <20130605122850.GD21556@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 122ED265363
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 14:31:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130605122850.GD21556@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.wolfsonmicro.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Support for non-blocking I/O, based on API of main alsalib.
In non-blocking mode a compress_write() will return without
blocking after it has written all bytes that will fit in the
buffer and compress_read() will return after it has read all
bytes available from the buffer. Use compress_wait() to wait
for free write space or available read bytes.

Non-blocking mode is enabled and disabled using compress_nonblock().

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 compress.c                          |   34 ++++++++++++++++++++++++++++++++++
 include/tinycompress/tinycompress.h |   23 ++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletions(-)

diff --git a/compress.c b/compress.c
index bb68fa6..734fbbf 100644
--- a/compress.c
+++ b/compress.c
@@ -88,6 +88,7 @@ struct compress {
 	struct compr_config *config;
 	int running;
 	int max_poll_wait_ms;
+	int nonblocking;
 	unsigned int gapless_metadata;
 	unsigned int next_track;
 };
@@ -372,6 +373,10 @@ int compress_write(struct compress *compress, const void *buf, unsigned int size
 		 * or there is enough space for all remaining data
 		 */
 		if ((avail.avail < frag_size) && (avail.avail < size)) {
+
+			if (compress->nonblocking)
+				return total;
+
 			ret = poll(&fds, 1, compress->max_poll_wait_ms);
 			/* A pause will cause -EBADFD or zero.
 			 * This is not an error, just stop writing */
@@ -429,6 +434,9 @@ int compress_read(struct compress *compress, void *buf, unsigned int size)
 			/* Less than one fragment available and not at the
 			 * end of the read, so poll
 			 */
+			if (compress->nonblocking)
+				return total;
+
 			ret = poll(&fds, 1, compress->max_poll_wait_ms);
 			/* A pause will cause -EBADFD or zero.
 			 * This is not an error, just stop reading */
@@ -594,3 +602,29 @@ void compress_set_max_poll_wait(struct compress *compress, int milliseconds)
 	compress->max_poll_wait_ms = milliseconds;
 }
 
+void compress_nonblock(struct compress *compress, int nonblock)
+{
+	compress->nonblocking = !!nonblock;
+}
+
+int compress_wait(struct compress *compress, int timeout_ms)
+{
+	struct pollfd fds;
+	int ret;
+
+	fds.fd = compress->fd;
+	fds.events = POLLOUT | POLLIN;
+
+	ret = poll(&fds, 1, timeout_ms);
+	/* A pause will cause -EBADFD or zero. */
+	if ((ret < 0) && (ret != -EBADFD))
+		return oops(compress, errno, "poll error");
+	if (fds.revents & (POLLOUT | POLLIN)) {
+		return 0;
+	}
+	if (fds.revents & POLLERR) {
+		return oops(compress, -EIO, "poll returned error!");
+	}
+	return ret;
+}
+
diff --git a/include/tinycompress/tinycompress.h b/include/tinycompress/tinycompress.h
index e947322..40de69a 100644
--- a/include/tinycompress/tinycompress.h
+++ b/include/tinycompress/tinycompress.h
@@ -130,7 +130,15 @@ int compress_get_tstamp(struct compress *compress,
 /*
  * compress_write: write data to the compress stream
  * return bytes written on success, negative on error
- * this is a blocking call
+ * By default this is a blocking call and will not return
+ * until all bytes have been written or there was a
+ * write error.
+ * If non-blocking mode has been enabled with compress_nonblock(),
+ * this function will write all bytes that can be written without
+ * blocking and will then return the number of bytes successfully
+ * written. If the return value is not an error and is < size
+ * the caller can use compress_wait() to block until the driver
+ * is ready for more data.
  *
  * @compress: compress stream to be written to
  * @buf: pointer to data
@@ -141,6 +149,13 @@ int compress_write(struct compress *compress, const void *buf, unsigned int size
 /*
  * compress_read: read data from the compress stream
  * return bytes read on success, negative on error
+ * By default this is a blocking call and will block until
+ * size bytes have been written or there was a read error.
+ * If non-blocking mode was enabled using compress_nonblock()
+ * the behaviour will change to read only as many bytes as
+ * are currently available (if no bytes are available it
+ * will return immediately). The caller can then use
+ * compress_wait() to block until more bytes are available.
  *
  * @compress: compress stream from where data is to be read
  * @buf: pointer to data buffer
@@ -242,6 +257,12 @@ bool is_codec_supported(unsigned int card, unsigned int device,
  */
 void compress_set_max_poll_wait(struct compress *compress, int milliseconds);
 
+/* Enable or disable non-blocking mode for write and read */
+void compress_nonblock(struct compress *compress, int nonblock);
+
+/* Wait for ring buffer to ready for next read or write */
+int compress_wait(struct compress *compress, int timeout_ms);
+
 int is_compress_running(struct compress *compress);
 
 int is_compress_ready(struct compress *compress);
-- 
1.7.2.5
