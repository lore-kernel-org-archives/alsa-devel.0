From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] tinycompres: remove unused variable
Date: Fri, 22 Feb 2013 23:47:04 +0530
Message-ID: <1361557024-24437-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 364A92625DB
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 19:17:42 +0100 (CET)
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

cplay.c:210: warning: unused variable i

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 cplay.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cplay.c b/cplay.c
index e52d641..5b4e83e 100644
--- a/cplay.c
+++ b/cplay.c
@@ -207,7 +207,7 @@ void play_samples(char *name, unsigned int card, unsigned int device,
 	FILE *file;
 	char *buffer;
 	int size, num_read, wrote;
-	unsigned int i, channels, rate, bits;
+	unsigned int channels, rate, bits;
 
 	if (verbose)
 		printf("%s: entry\n", __func__);
-- 
1.7.0.4
