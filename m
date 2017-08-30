From: Zhang Keqiao <keqiao.zhang@intel.com>
Subject: [PATCH] alsabat: fix one uninitialized warning issue
Date: Wed, 30 Aug 2017 09:26:16 +0800
Message-ID: <20170830012616.25373-1-keqiao.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id C2783266C52
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 03:29:48 +0200 (CEST)
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
Cc: keqiao.zhang@intel.com, Zhang Keqiao <keqiaox.k.zhang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Zhang Keqiao <keqiaox.k.zhang@linux.intel.com>

Fix a variable uninitialized issue, adding the initialized assignment to fix it.

Signed-off-by: Zhang Keqiao <keqiaox.k.zhang@linux.intel.com>
---
 bat/analyze.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bat/analyze.c b/bat/analyze.c
index 2b8ca61..9808b73 100644
--- a/bat/analyze.c
+++ b/bat/analyze.c
@@ -34,7 +34,7 @@ static void check_amplitude(struct bat *bat, float *buf)
 	int i, percent;
 
 	/* calculate average value */
-	for (i = 0, sum = 0.0; i < bat->frames; i++)
+	for (i = 0, sum = 0.0, average = 0.0; i < bat->frames; i++)
 		sum += buf[i];
 	average = sum / bat->frames;
 
-- 
2.9.3
