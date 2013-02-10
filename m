From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH TINYCOMPRESS 10/14] compress: Block if unable
	to write all	data in single write()
Date: Sun, 10 Feb 2013 00:18:12 +0000
Message-ID: <20130210001812.GJ31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84D4426161F
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2013 01:18:14 +0100 (CET)
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
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Previously compress_write() would only block on poll() if the
available space < fragment_size. If the device has a small fragment
size this could lead to it never blocking and instead looping around
doing many small writes. This is bad for power saving.

If we were unable to write all the remaining data in a single write
we want to block until the device reaches a buffer high water mark,
to allow the CPU to sleep.

This change will always attempt to issue the first write providing
avail >= fragment_size. All subsequent loops will block on poll()
before attempting another write() unless there is enough buffer space
to write all remaining data.

diff --git a/compress.c b/compress.c
index 7c8ddc8..7ee287d 100644
--- a/compress.c
+++ b/compress.c
@@ -317,7 +317,8 @@ int compress_write(struct compress *compress, const void *buf, unsigned int size
 {
 	struct snd_compr_avail avail;
 	struct pollfd fds;
-	int to_write, written, total = 0, ret;
+	int to_write = 0;	/* zero indicates we haven't written yet */
+	int written, total = 0, ret;
 	const char* cbuf = buf;
 
 	if (!(compress->flags & COMPRESS_IN))
@@ -333,24 +334,21 @@ int compress_write(struct compress *compress, const void *buf, unsigned int size
 		if (ioctl(compress->fd, SNDRV_COMPRESS_AVAIL, &avail))
 			return oops(compress, errno, "cannot get avail");
 
-		/* we will write only when avail > fragment size */
-		if (avail.avail < compress->config.fragment_size) {
-			/* nothing to write so wait */
-			ret = poll(&fds, 1, compress->max_poll_wait_ms);
-			/* A pause will cause -EBADFD or zero return from driver
-			 * This is not an error, just stop writing
+		if ( (avail.avail < compress->config.fragment_size)
+			|| ((to_write != 0) && (avail.avail < size)) ) {
+			/* not enough space for one fragment, or we have done
+			 * a short write and there isn't enough space for all
+			 * the remaining data
 			 */
+			ret = poll(&fds, 1, compress->max_poll_wait_ms);
+			/* A pause will cause -EBADFD or zero.
+			 * This is not an error, just stop writing */
 			if ((ret == 0) || (ret == -EBADFD))
 				break;
 			if (ret < 0)
 				return oops(compress, errno, "poll error");
 			if (fds.revents & POLLOUT) {
-				if (ioctl(compress->fd, SNDRV_COMPRESS_AVAIL, &avail))
-					return oops(compress, errno, "cannot get avail");
-				if (avail.avail == 0) {
-					oops(compress, -EIO, "woken up even when avail is 0!!!");
-					continue;
-				}
+				continue;
 			}
 			if (fds.revents & POLLERR) {
 				return oops(compress, -EIO, "poll returned error!");
-- 
1.7.2.5
