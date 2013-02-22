From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH TINYCOMPRESS 6/14 v2] compress:
	Fix	incorrect error message on compress_resume()
Date: Fri, 22 Feb 2013 16:02:17 +0000
Message-ID: <20130222160217.GF21174@opensource.wolfsonmicro.com>
References: <20130210001104.GF31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DEA84265378
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 17:02:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130210001104.GF31139@opensource.wolfsonmicro.com>
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

Was reporting compress_resume() errors as "cannot pause"

---
 compress.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compress.c b/compress.c
index d09e161..801f055 100644
--- a/compress.c
+++ b/compress.c
@@ -403,7 +403,7 @@ int compress_pause(struct compress *compress)
 int compress_resume(struct compress *compress)
 {
 	if (ioctl(compress->fd, SNDRV_COMPRESS_RESUME))
-		return oops(compress, errno, "cannot pause the stream");
+		return oops(compress, errno, "cannot resume the stream");
 	return 0;
 }
 
-- 
1.7.2.5
