From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/4] compress: make variable 'running' as
	unsigned
Date: Mon, 18 Feb 2013 19:45:12 +0530
Message-ID: <1361196915-12121-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E5D026506E
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 15:16:02 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

as we never expect this to be negative

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 compress.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compress.c b/compress.c
index 19d618a..a8964f4 100644
--- a/compress.c
+++ b/compress.c
@@ -83,7 +83,7 @@ struct compress {
 	__u64 buffer_size;
 	char error[COMPR_ERR_MAX];
 	struct compr_config *config;
-	int running:1;
+	unsigned int running:1;
 };
 
 static int oops(struct compress *compress, int e, const char *fmt, ...)
-- 
1.7.0.4
