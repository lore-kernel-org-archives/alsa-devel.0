From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH TINYCOMPRESS 6/14] compress: Fix incorrect
	error message on	compress_resume()
Date: Sun, 10 Feb 2013 00:11:04 +0000
Message-ID: <20130210001104.GF31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC025261609
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2013 01:11:06 +0100 (CET)
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

Was reporting compress_resume() errors as "cannot pause"

diff --git a/compress.c b/compress.c
index 871c19e..5235ea4 100644
--- a/compress.c
+++ b/compress.c
@@ -392,7 +392,7 @@ int compress_pause(struct compress *compress)
 int compress_resume(struct compress *compress)
 {
 	if (ioctl(compress->fd, SNDRV_COMPRESS_RESUME))
-		return oops(compress, errno, "cannot pause the stream\n");
+		return oops(compress, errno, "cannot resume the stream\n");
 	return 0;
 }
 
-- 
1.7.2.5
