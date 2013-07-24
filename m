From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] fix error returned by compress_wait()
Date: Wed, 24 Jul 2013 23:26:17 +0530
Message-ID: <1374688577-27976-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 86386265544
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 20:34:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Eric Laurent <elaurent@google.com>
List-Id: alsa-devel@alsa-project.org

From: Eric Laurent <elaurent@google.com>

oops() expects positive error codes.

Signed-off-by: Eric Laurent <elaurent@google.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 compress.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compress.c b/compress.c
index 734fbbf..0e71c28 100644
--- a/compress.c
+++ b/compress.c
@@ -623,7 +623,7 @@ int compress_wait(struct compress *compress, int timeout_ms)
 		return 0;
 	}
 	if (fds.revents & POLLERR) {
-		return oops(compress, -EIO, "poll returned error!");
+		return oops(compress, EIO, "poll returned error!");
 	}
 	return ret;
 }
-- 
1.7.0.4
