From: Tanu Kaskinen <tanuk@iki.fi>
Subject: [PATCH] ucm: Set uc_mgr->ctl to NULL after closing it.
Date: Sat, 26 Jan 2013 14:20:20 +0200
Message-ID: <1359202820-9896-1-git-send-email-tanuk@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id B4CF82625E6
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 13:20:37 +0100 (CET)
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
Cc: Luke Yelavich <themuso@ubuntu.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, liam.r.girdwood@intel.com, Tanu Kaskinen <tanuk@iki.fi>
List-Id: alsa-devel@alsa-project.org

Fixes a double-free bug.

Signed-off-by: Tanu Kaskinen <tanuk@iki.fi>
---
 src/ucm/main.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 0d7d841..d8b8ada 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -145,6 +145,7 @@ static int open_ctl(snd_use_case_mgr_t *uc_mgr,
 		free(uc_mgr->ctl_dev);
 		uc_mgr->ctl_dev = NULL;
 		snd_ctl_close(uc_mgr->ctl);
+		uc_mgr->ctl = NULL;
 	
 	}
 	err = snd_ctl_open(ctl, ctl_dev, 0);
-- 
1.7.10.4
