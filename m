From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH TINYCOMPRESS 8/14 v2] compress: Handle	case
	of pause() during compress_write()
Date: Fri, 22 Feb 2013 16:04:22 +0000
Message-ID: <20130222160422.GH21174@opensource.wolfsonmicro.com>
References: <20130210001506.GH31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B395265378
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 17:04:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130210001506.GH31139@opensource.wolfsonmicro.com>
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

If stream is paused() during a compress_write() the poll()
will return 0 or -EBADFD, or the write() will return -EBADFD.
This is not an error so compress_write() should not pass an
error code to the caller. It should abort the write and then
return the number of bytes it had written up to that point.

---
 compress.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/compress.c b/compress.c
index 478652a..92d1a80 100644
--- a/compress.c
+++ b/compress.c
@@ -340,10 +340,13 @@ int compress_write(struct compress *compress, const void *buf, unsigned int size
 		if (avail.avail < compress->config.fragment_size) {
 			/* nothing to write so wait */
 			ret = poll(&fds, 1, compress->max_poll_wait_ms);
+			/* A pause will cause -EBADFD or zero return from driver
+			 * This is not an error, just stop writing
+			 */
+			if ((ret == 0) || (ret == -EBADFD))
+				break;
 			if (ret < 0)
 				return oops(compress, errno, "poll error");
-			if (ret == 0)
-				return oops(compress, -EPIPE, "Poll timeout, Broken Pipe");
 			if (fds.revents & POLLOUT) {
 				if (ioctl(compress->fd, SNDRV_COMPRESS_AVAIL, &avail))
 					return oops(compress, errno, "cannot get avail");
@@ -362,6 +365,9 @@ int compress_write(struct compress *compress, const void *buf, unsigned int size
 		else
 			to_write = size;
 		written = write(compress->fd, cbuf, to_write);
+		/* If play was paused the write returns -EBADFD */
+		if (written == -EBADFD)
+			break;
 		if (written < 0)
 			return oops(compress, errno, "write failed!");
 
-- 
1.7.2.5
