From: Vinod Koul <vinod.koul@intel.com>
Subject: [TINYCOMPRESS][PATCH] compress: check for config first
Date: Fri, 26 Apr 2013 22:24:30 +0530
Message-ID: <1366995270-8345-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BB5E260319
 for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2013 19:26:53 +0200 (CEST)
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

if invalid config is passed, then we return error for memory

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 compress.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/compress.c b/compress.c
index e80e598..ee792c3 100644
--- a/compress.c
+++ b/compress.c
@@ -218,8 +218,13 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 	struct snd_compr_caps caps;
 	char fn[256];
 
+	if (!config) {
+		oops(&bad_compress, -EINVAL, "passed bad config");
+		return &bad_compress;
+	}
+
 	compress = calloc(1, sizeof(struct compress));
-	if (!compress || !config) {
+	if (!compress) {
 		oops(&bad_compress, errno, "cannot allocate compress object");
 		return &bad_compress;
 	}
-- 
1.7.0.4
