From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2] compress: fix the typo in
	compress_get_alsa_rate()
Date: Sat, 20 Jul 2013 12:21:18 +0530
Message-ID: <1374303078-2951-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 26857260310
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2013 09:29:53 +0200 (CEST)
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

Reported-by: Ravi <ralama@codeaurora.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 utils.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/utils.c b/utils.c
index fa37f23..a835bef 100644
--- a/utils.c
+++ b/utils.c
@@ -72,7 +72,7 @@ unsigned int compress_get_alsa_rate(unsigned int rate)
 		return SNDRV_PCM_RATE_11025;
 	case 16000:
 		return SNDRV_PCM_RATE_16000;
-	case 220500:
+	case 22050:
 		return SNDRV_PCM_RATE_22050;
 	case 32000:
 		return SNDRV_PCM_RATE_32000;
-- 
1.7.0.4
