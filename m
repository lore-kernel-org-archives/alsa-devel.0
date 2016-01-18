From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] tinycompress: crec: fix function
	declaration
Date: Mon, 18 Jan 2016 22:00:02 +0530
Message-ID: <1453134603-25356-3-git-send-email-vinod.koul@intel.com>
References: <1453134603-25356-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 950A82651FE
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 17:26:30 +0100 (CET)
In-Reply-To: <1453134603-25356-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

finish_record was not following ANSI standard for declaration as warned by
sparse

crec.c:193:26: warning: non-ANSI function declaration of function 'finish_record'

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 src/utils/crec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/utils/crec.c b/src/utils/crec.c
index e61e620d6490..6e8166d8f77b 100644
--- a/src/utils/crec.c
+++ b/src/utils/crec.c
@@ -190,7 +190,7 @@ static int print_time(struct compress *compress)
 	return 0;
 }
 
-static int finish_record()
+static int finish_record(void)
 {
 	struct wave_header header;
 	int ret;
-- 
1.9.1
