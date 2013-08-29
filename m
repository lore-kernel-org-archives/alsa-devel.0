From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [TINYCOMPRESS][PATCH 1/1] compress: Must check for
	POLLERR before	POLLOUT/POLLIN
Date: Thu, 29 Aug 2013 09:32:02 +0100
Message-ID: <20130829083202.GA1538@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BBEE62616E1
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 10:40:08 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, elaurent@google.com
List-Id: alsa-devel@alsa-project.org

In the case of error the ALSA compressed driver sets revents as
(POLLOUT | POLLWRNORM | POLLERR) or (POLLIN | POLLWRNORM | POLLERR).
So we can't assume that POLLOUT or POLLIN indicate success, we must
check for POLLERR first.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 compress.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/compress.c b/compress.c
index 0e71c28..5cd0966 100644
--- a/compress.c
+++ b/compress.c
@@ -378,6 +378,9 @@ int compress_write(struct compress *compress, const void *buf, unsigned int size
 				return total;
 
 			ret = poll(&fds, 1, compress->max_poll_wait_ms);
+			if (fds.revents & POLLERR) {
+				return oops(compress, EIO, "poll returned error!");
+			}
 			/* A pause will cause -EBADFD or zero.
 			 * This is not an error, just stop writing */
 			if ((ret == 0) || (ret == -EBADFD))
@@ -387,9 +390,6 @@ int compress_write(struct compress *compress, const void *buf, unsigned int size
 			if (fds.revents & POLLOUT) {
 				continue;
 			}
-			if (fds.revents & POLLERR) {
-				return oops(compress, EIO, "poll returned error!");
-			}
 		}
 		/* write avail bytes */
 		if (size > avail.avail)
@@ -438,6 +438,9 @@ int compress_read(struct compress *compress, void *buf, unsigned int size)
 				return total;
 
 			ret = poll(&fds, 1, compress->max_poll_wait_ms);
+			if (fds.revents & POLLERR) {
+				return oops(compress, EIO, "poll returned error!");
+			}
 			/* A pause will cause -EBADFD or zero.
 			 * This is not an error, just stop reading */
 			if ((ret == 0) || (ret == -EBADFD))
@@ -447,9 +450,6 @@ int compress_read(struct compress *compress, void *buf, unsigned int size)
 			if (fds.revents & POLLIN) {
 				continue;
 			}
-			if (fds.revents & POLLERR) {
-				return oops(compress, EIO, "poll returned error!");
-			}
 		}
 		/* read avail bytes */
 		if (size > avail.avail)
@@ -616,15 +616,15 @@ int compress_wait(struct compress *compress, int timeout_ms)
 	fds.events = POLLOUT | POLLIN;
 
 	ret = poll(&fds, 1, timeout_ms);
+	if (fds.revents & POLLERR) {
+		return oops(compress, EIO, "poll returned error!");
+	}
 	/* A pause will cause -EBADFD or zero. */
 	if ((ret < 0) && (ret != -EBADFD))
 		return oops(compress, errno, "poll error");
 	if (fds.revents & (POLLOUT | POLLIN)) {
 		return 0;
 	}
-	if (fds.revents & POLLERR) {
-		return oops(compress, EIO, "poll returned error!");
-	}
 	return ret;
 }
 
-- 
1.7.2.5
