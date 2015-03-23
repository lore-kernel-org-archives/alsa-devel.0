From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [TINYCOMPRESS][PATCH 5/6] compress.c: fix check for
	errors from poll(), read() and write()
Date: Mon, 23 Mar 2015 13:09:04 +0000
Message-ID: <1427116145-519-6-git-send-email-qais.yousef@imgtec.com>
References: <1427116145-519-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id C738926066A
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 14:09:21 +0100 (CET)
In-Reply-To: <1427116145-519-1-git-send-email-qais.yousef@imgtec.com>
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
Cc: alsa-devel@alsa-project.org, Qais Yousef <qais.yousef@imgtec.com>
List-Id: alsa-devel@alsa-project.org

When these functions fail they return -1 and set errno. Fix error checks
accordingly.
---
 src/lib/compress.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/src/lib/compress.c b/src/lib/compress.c
index 15dfdb74137e..84738d24ff45 100644
--- a/src/lib/compress.c
+++ b/src/lib/compress.c
@@ -383,7 +383,7 @@ int compress_write(struct compress *compress, const void *buf, unsigned int size
 			}
 			/* A pause will cause -EBADFD or zero.
 			 * This is not an error, just stop writing */
-			if ((ret == 0) || (ret == -EBADFD))
+			if ((ret == 0) || (ret < 0 && errno == EBADFD))
 				break;
 			if (ret < 0)
 				return oops(compress, errno, "poll error");
@@ -397,11 +397,12 @@ int compress_write(struct compress *compress, const void *buf, unsigned int size
 		else
 			to_write = size;
 		written = write(compress->fd, cbuf, to_write);
-		/* If play was paused the write returns -EBADFD */
-		if (written == -EBADFD)
-			break;
-		if (written < 0)
+		if (written < 0) {
+			/* If play was paused the write returns -EBADFD */
+			if (errno == EBADFD)
+				break;
 			return oops(compress, errno, "write failed!");
+		}
 
 		size -= written;
 		cbuf += written;
@@ -443,7 +444,7 @@ int compress_read(struct compress *compress, void *buf, unsigned int size)
 			}
 			/* A pause will cause -EBADFD or zero.
 			 * This is not an error, just stop reading */
-			if ((ret == 0) || (ret == -EBADFD))
+			if ((ret == 0) || (ret < 0 && errno == EBADFD))
 				break;
 			if (ret < 0)
 				return oops(compress, errno, "poll error");
@@ -457,11 +458,12 @@ int compress_read(struct compress *compress, void *buf, unsigned int size)
 		else
 			to_read = size;
 		num_read = read(compress->fd, cbuf, to_read);
-		/* If play was paused the read returns -EBADFD */
-		if (num_read == -EBADFD)
-			break;
-		if (num_read < 0)
+		if (num_read < 0) {
+			/* If play was paused the read returns -EBADFD */
+			if (errno == EBADFD)
+				break;
 			return oops(compress, errno, "read failed!");
+		}
 
 		size -= num_read;
 		cbuf += num_read;
-- 
2.1.0
