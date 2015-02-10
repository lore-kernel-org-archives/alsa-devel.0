From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: [PATCH 1/3] ucm: fix variable mixup
Date: Tue, 10 Feb 2015 22:42:32 +0200
Message-ID: <1423600954-8751-2-git-send-email-tanu.kaskinen@linux.intel.com>
References: <1423600954-8751-1-git-send-email-tanu.kaskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D8080260569
 for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2015 21:42:40 +0100 (CET)
In-Reply-To: <1423600954-8751-1-git-send-email-tanu.kaskinen@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

I assume the intention was to use cdev1 for PlaybackCTL and cdev2 for
CaptureCTL, but cdev1 was being used for both and cdev2 was not used
for anything.
---
 src/ucm/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 182f174..3924aee 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -308,7 +308,7 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 					uc_error("cdev is not defined!");
 					return err;
 				}
-				err = get_value3(&cdev1, "CaptureCTL",
+				err = get_value3(&cdev2, "CaptureCTL",
 						 value_list1,
 						 value_list2,
 						 value_list3);
-- 
1.9.3
