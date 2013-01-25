From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH - TINYCOMPRESS 4/4] compress: Do not put
	newlines on error messages
Date: Fri, 25 Jan 2013 10:43:14 +0000
Message-ID: <1359110594-20163-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1359110594-20163-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1359110594-20163-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org, vinod.koul@linux.intel.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

In the oops function text is appended onto the end of the supplied error
message, so newlines appear in the middle of error messages. This patch
removes all newlines from supplied error messages.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

diff --git a/compress.c b/compress.c
index c575acd..19d618a 100644
--- a/compress.c
+++ b/compress.c
@@ -144,22 +144,22 @@ static bool _is_codec_supported(struct compress *compress, struct compr_config *
 	}
 
 	if (config->fragment_size < caps.min_fragment_size) {
-		oops(compress, -EINVAL, "requested fragment size %d is below min supported %d\n",
+		oops(compress, -EINVAL, "requested fragment size %d is below min supported %d",
 				config->fragment_size, caps.min_fragment_size);
 		return false;
 	}
 	if (config->fragment_size > caps.max_fragment_size) {
-		oops(compress, -EINVAL, "requested fragment size %d is above max supported %d\n",
+		oops(compress, -EINVAL, "requested fragment size %d is above max supported %d",
 				config->fragment_size, caps.max_fragment_size);
 		return false;
 	}
 	if (config->fragments < caps.min_fragments) {
-		oops(compress, -EINVAL, "requested fragments %d are below min supported %d\n",
+		oops(compress, -EINVAL, "requested fragments %d are below min supported %d",
 				config->fragments, caps.min_fragments);
 		return false;
 	}
 	if (config->fragments > caps.max_fragments) {
-		oops(compress, -EINVAL, "requested fragments %d are above max supported %d\n",
+		oops(compress, -EINVAL, "requested fragments %d are above max supported %d",
 				config->fragments, caps.max_fragments);
 		return false;
 	}
@@ -218,12 +218,12 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 
 	compress->flags = flags;
 	if (!((flags & COMPRESS_OUT) || (flags & COMPRESS_IN))) {
-		oops(&bad_compress, -EINVAL, "can't deduce device direction from given flags\n");
+		oops(&bad_compress, -EINVAL, "can't deduce device direction from given flags");
 		goto input_fail;
 	}
 	if (flags & COMPRESS_OUT) {
 		/* this should be removed once we have capture tested */
-		oops(&bad_compress, -EINVAL, "this version doesnt support capture\n");
+		oops(&bad_compress, -EINVAL, "this version doesnt support capture");
 		goto input_fail;
 	}
 
@@ -237,7 +237,7 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 	 * and treat in no support case
 	 */
 	if (_is_codec_supported(compress, config) == false) {
-		oops(&bad_compress, errno, "codec not supported\n");
+		oops(&bad_compress, errno, "codec not supported");
 		goto codec_fail;
 	}
 #endif
@@ -335,7 +335,7 @@ int compress_write(struct compress *compress, char *buf, unsigned int size)
 			to_write = size;
 		written = write(compress->fd, buf, to_write);
 		if (written < 0)
-			return oops(compress, errno, "write failed!\n");
+			return oops(compress, errno, "write failed!");
 
 		size -= written;
 		buf += written;
@@ -354,7 +354,7 @@ int compress_start(struct compress *compress)
 	if (!is_compress_ready(compress))
 		return oops(compress, -ENODEV, "device not ready");
 	if (ioctl(compress->fd, SNDRV_COMPRESS_START))
-		return oops(compress, errno, "cannot start the stream\n");
+		return oops(compress, errno, "cannot start the stream");
 	compress->running = 1;
 	return 0;
 
@@ -365,7 +365,7 @@ int compress_stop(struct compress *compress)
 	if (!is_compress_running(compress))
 		return oops(compress, -ENODEV, "device not ready");
 	if (ioctl(compress->fd, SNDRV_COMPRESS_STOP))
-		return oops(compress, errno, "cannot stop the stream\n");
+		return oops(compress, errno, "cannot stop the stream");
 	return 0;
 }
 
@@ -374,14 +374,14 @@ int compress_pause(struct compress *compress)
 	if (!is_compress_running(compress))
 		return oops(compress, -ENODEV, "device not ready");
 	if (ioctl(compress->fd, SNDRV_COMPRESS_PAUSE))
-		return oops(compress, errno, "cannot pause the stream\n");
+		return oops(compress, errno, "cannot pause the stream");
 	return 0;
 }
 
 int compress_resume(struct compress *compress)
 {
 	if (ioctl(compress->fd, SNDRV_COMPRESS_RESUME))
-		return oops(compress, errno, "cannot pause the stream\n");
+		return oops(compress, errno, "cannot pause the stream");
 	return 0;
 }
 
@@ -390,7 +390,7 @@ int compress_drain(struct compress *compress)
 	if (!is_compress_running(compress))
 		return oops(compress, -ENODEV, "device not ready");
 	if (ioctl(compress->fd, SNDRV_COMPRESS_DRAIN))
-		return oops(compress, errno, "cannot drain the stream\n");
+		return oops(compress, errno, "cannot drain the stream");
 	return 0;
 }
 
-- 
1.7.2.5
