From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH TINYCOMPRESS 2/14] compress: Change
	compress_write() to	take buffer as const void *
Date: Sun, 10 Feb 2013 00:04:09 +0000
Message-ID: <20130210000409.GB31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 904A82615F2
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2013 01:04:11 +0100 (CET)
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

The input buffer to compress_write() should be const, and is
better defined as void * so the caller doesn't have to cast.

diff --git a/compress.c b/compress.c
index 19b9366..ee11988 100644
--- a/compress.c
+++ b/compress.c
@@ -299,11 +299,12 @@ int compress_get_tstamp(struct compress *compress,
 	return 0;
 }
 
-int compress_write(struct compress *compress, char *buf, unsigned int size)
+int compress_write(struct compress *compress, const void *buf, unsigned int size)
 {
 	struct snd_compr_avail avail;
 	struct pollfd fds;
 	int to_write, written, total = 0, ret;
+	const char* cbuf = buf;
 
 	if (!(compress->flags & COMPRESS_IN))
 		return oops(compress, -EINVAL, "Invalid flag set");
@@ -343,12 +344,12 @@ int compress_write(struct compress *compress, char *buf, unsigned int size)
 			to_write =  avail.avail;
 		else
 			to_write = size;
-		written = write(compress->fd, buf, to_write);
+		written = write(compress->fd, cbuf, to_write);
 		if (written < 0)
 			return oops(compress, errno, "write failed!\n");
 
 		size -= written;
-		buf += written;
+		cbuf += written;
 		total += written;
 	}
 	return total;
diff --git a/include/tinycompress/tinycompress.h b/include/tinycompress/tinycompress.h
index 8a98527..e285bd4 100644
--- a/include/tinycompress/tinycompress.h
+++ b/include/tinycompress/tinycompress.h
@@ -125,7 +125,7 @@ int compress_get_tstamp(struct compress *compress,
  * @buf: pointer to data
  * @size: number of bytes to be written
  */
-int compress_write(struct compress *compress, char *buf, unsigned int size);
+int compress_write(struct compress *compress, const void *buf, unsigned int size);
 
 /*
  * compress_read: read data from the compress stream
-- 
1.7.2.5
