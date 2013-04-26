From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [TINYCOMPRESS][PATCH 1/1] compress: Add support for
	capture streams
Date: Fri, 26 Apr 2013 16:14:22 +0100
Message-ID: <20130426151422.GA29257@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ADF8C260291
 for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2013 17:14:24 +0200 (CEST)
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
To: vinod.koul@linux.intel.com
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 compress.c                          |   64 +++++++++++++++++++++++++++++++---
 include/tinycompress/tinycompress.h |    2 +-
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/compress.c b/compress.c
index 86cca88..e80e598 100644
--- a/compress.c
+++ b/compress.c
@@ -240,13 +240,12 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 		oops(&bad_compress, -EINVAL, "can't deduce device direction from given flags");
 		goto config_fail;
 	}
+
 	if (flags & COMPRESS_OUT) {
-		/* this should be removed once we have capture tested */
-		oops(&bad_compress, -EINVAL, "this version doesnt support capture");
-		goto config_fail;
+		compress->fd = open(fn, O_RDONLY);
+	} else {
+		compress->fd = open(fn, O_WRONLY);
 	}
-
-	compress->fd = open(fn, O_WRONLY);
 	if (compress->fd < 0) {
 		oops(&bad_compress, errno, "cannot open device '%s'", fn);
 		goto config_fail;
@@ -403,7 +402,60 @@ int compress_write(struct compress *compress, const void *buf, unsigned int size
 
 int compress_read(struct compress *compress, void *buf, unsigned int size)
 {
-	return oops(compress, -ENOTTY, "Not supported yet in lib");
+	struct snd_compr_avail avail;
+	struct pollfd fds;
+	int to_read = 0;
+	int num_read, total = 0, ret;
+	char* cbuf = buf;
+	const unsigned int frag_size = compress->config->fragment_size;
+
+	if (!(compress->flags & COMPRESS_OUT))
+		return oops(compress, -EINVAL, "Invalid flag set");
+	if (!is_compress_ready(compress))
+		return oops(compress, -ENODEV, "device not ready");
+	fds.fd = compress->fd;
+	fds.events = POLLIN;
+
+	while (size) {
+		if (ioctl(compress->fd, SNDRV_COMPRESS_AVAIL, &avail))
+			return oops(compress, errno, "cannot get avail");
+
+		if ( (avail.avail < frag_size) && (avail.avail < size) ) {
+			/* Less than one fragment available and not at the
+			 * end of the read, so poll
+			 */
+			ret = poll(&fds, 1, compress->max_poll_wait_ms);
+			/* A pause will cause -EBADFD or zero.
+			 * This is not an error, just stop reading */
+			if ((ret == 0) || (ret == -EBADFD))
+				break;
+			if (ret < 0)
+				return oops(compress, errno, "poll error");
+			if (fds.revents & POLLIN) {
+				continue;
+			}
+			if (fds.revents & POLLERR) {
+				return oops(compress, -EIO, "poll returned error!");
+			}
+		}
+		/* read avail bytes */
+		if (size > avail.avail)
+			to_read = avail.avail;
+		else
+			to_read = size;
+		num_read = read(compress->fd, cbuf, to_read);
+		/* If play was paused the read returns -EBADFD */
+		if (num_read == -EBADFD)
+			break;
+		if (num_read < 0)
+			return oops(compress, errno, "read failed!");
+
+		size -= num_read;
+		cbuf += num_read;
+		total += num_read;
+	}
+
+	return total;
 }
 
 int compress_start(struct compress *compress)
diff --git a/include/tinycompress/tinycompress.h b/include/tinycompress/tinycompress.h
index ba9f3b6..9867afc 100644
--- a/include/tinycompress/tinycompress.h
+++ b/include/tinycompress/tinycompress.h
@@ -76,7 +76,7 @@ struct compr_gapless_mdata {
 	__u32 encoder_padding;
 };
 
-#define COMPRESS_OUT        0x00000000
+#define COMPRESS_OUT        0x20000000
 #define COMPRESS_IN         0x10000000
 
 struct compress;
-- 
1.7.2.5
