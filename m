From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: [PATCH 2/3] ucm: add a FIXME comment
Date: Tue, 10 Feb 2015 22:42:33 +0200
Message-ID: <1423600954-8751-3-git-send-email-tanu.kaskinen@linux.intel.com>
References: <1423600954-8751-1-git-send-email-tanu.kaskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C5209260577
 for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2015 21:42:42 +0100 (CET)
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

I'm pretty sure the current code will crash with some inputs, but I
don't know what the original author intended this code to do, so I
don't know how to fix it.
---
 src/ucm/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 3924aee..62bc374 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -317,6 +317,14 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 					uc_error("cdev is not defined!");
 					return err;
 				}
+                                /* FIXME: If cdev1 is NULL and cdev2 is not,
+                                 * then set cdev to cdev1... makes no sense!
+                                 * Also, what if both cdev1 and cdev2 are NULL?
+                                 * What should happen? Later in this function we
+                                 * call open_ctl(), which assumes non-NULL cdev,
+                                 * so leaving cdev to NULL here is not an
+                                 * option (or at least cdev has to be checked
+                                 * before calling open_ctl()). */
 				if (cdev1 == NULL || cdev2 == NULL ||
                                     strcmp(cdev1, cdev2) == 0) {
 					cdev = (char *)cdev1;
-- 
1.9.3
