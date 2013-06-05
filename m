From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [tinycompress][PATCH 2/2] compress: do not poll if
	enough space to	write remaining data
Date: Wed, 5 Jun 2013 13:11:44 +0100
Message-ID: <20130605121144.GC21556@opensource.wolfsonmicro.com>
References: <20130605120827.GA21556@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A12526545E
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 14:11:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130605120827.GA21556@opensource.wolfsonmicro.com>
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

Changes the poll logic in compress_write() to prevent
it polling if there is enough available space to write
all remaining data. Previously the logic always polled for
an entire fragment to become available before starting the
first write.

This change allows short writes of < frag_size, which is likely
at the end of a stream.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 compress.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/compress.c b/compress.c
index 373de85..bb68fa6 100644
--- a/compress.c
+++ b/compress.c
@@ -368,12 +368,10 @@ int compress_write(struct compress *compress, const void *buf, unsigned int size
 		if (ioctl(compress->fd, SNDRV_COMPRESS_AVAIL, &avail))
 			return oops(compress, errno, "cannot get avail");
 
-		if ( (avail.avail < frag_size)
-			|| ((to_write != 0) && (avail.avail < size)) ) {
-			/* not enough space for one fragment, or we have done
-			 * a short write and there isn't enough space for all
-			 * the remaining data
-			 */
+		/* We can write if we have at least one fragment available
+		 * or there is enough space for all remaining data
+		 */
+		if ((avail.avail < frag_size) && (avail.avail < size)) {
 			ret = poll(&fds, 1, compress->max_poll_wait_ms);
 			/* A pause will cause -EBADFD or zero.
 			 * This is not an error, just stop writing */
-- 
1.7.2.5
