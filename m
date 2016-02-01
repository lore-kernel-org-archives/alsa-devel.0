From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] topology: fix debug output to print correct
	"max" value.
Date: Mon,  1 Feb 2016 14:20:44 +0000
Message-ID: <1454336444-28584-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C2B16260481
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2016 15:20:57 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Debug log is printing num_regs instead of max in the max section.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index 1c073f7..c250227 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -350,7 +350,7 @@ int tplg_parse_control_bytes(snd_tplg_t *tplg,
 				return -EINVAL;
 
 			be->max = atoi(val);
-			tplg_dbg("\t%s: %d\n", id, be->num_regs);
+			tplg_dbg("\t%s: %d\n", id, be->max);
 			continue;
 		}
 
-- 
2.5.0
