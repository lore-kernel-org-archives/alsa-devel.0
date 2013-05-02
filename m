From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [TINYCOMPRESS][PATCH 1/1] compress: fix hpointer error
	when no	sample rate
Date: Thu, 2 May 2013 14:58:53 +0100
Message-ID: <20130502135853.GA2744@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 32B0B260307
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2013 16:03:58 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Fixes the oops() in compress_get_hpointer() to return
-ENODATA instead of errno if the sample rate is zero.
The value in errno here is not related to the reason
we are returning an error.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 compress.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compress.c b/compress.c
index e80e598..abd0799 100644
--- a/compress.c
+++ b/compress.c
@@ -315,7 +315,7 @@ int compress_get_hpointer(struct compress *compress,
 	if (ioctl(compress->fd, SNDRV_COMPRESS_AVAIL, &kavail))
 		return oops(compress, errno, "cannot get avail");
 	if (0 == kavail.tstamp.sampling_rate)
-		return oops(compress, errno, "invalid paramter");
+		return oops(compress, -ENODATA, "sample rate unknown");
 	*avail = (unsigned int)kavail.avail;
 	time = kavail.tstamp.pcm_io_frames / kavail.tstamp.sampling_rate;
 	tstamp->tv_sec = time;
-- 
1.7.2.5
