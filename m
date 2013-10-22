From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [TINYCOMPRESS][PATCH] compress: compress_wait() must
	return error	if timed out
Date: Tue, 22 Oct 2013 11:51:58 +0100
Message-ID: <20131022105158.GA12320@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5C93F26036C
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2013 13:00:51 +0200 (CEST)
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

The caller must be certain that a return of 0 really means
that compress is ready for more data, so when poll() returns
0 for a timeout we must report that as an error.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 compress.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/compress.c b/compress.c
index 5cd0966..d1a2283 100644
--- a/compress.c
+++ b/compress.c
@@ -616,15 +616,17 @@ int compress_wait(struct compress *compress, int timeout_ms)
 	fds.events = POLLOUT | POLLIN;
 
 	ret = poll(&fds, 1, timeout_ms);
-	if (fds.revents & POLLERR) {
-		return oops(compress, EIO, "poll returned error!");
+	if (ret > 0) {
+		if (fds.revents & POLLERR)
+			return oops(compress, EIO, "poll returned error!");
+		if (fds.revents & (POLLOUT | POLLIN))
+			return 0;
 	}
-	/* A pause will cause -EBADFD or zero. */
-	if ((ret < 0) && (ret != -EBADFD))
+	if (ret == 0)
+		return oops(compress, ETIME, "poll timed out");
+	if (ret < 0)
 		return oops(compress, errno, "poll error");
-	if (fds.revents & (POLLOUT | POLLIN)) {
-		return 0;
-	}
-	return ret;
+
+	return oops(compress, EIO, "poll signalled unhandled event");
 }
 
-- 
1.7.2.5
