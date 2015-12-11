From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 06/14] ALSA: hdac: Increase timeout value for
	link power check
Date: Fri, 11 Dec 2015 12:14:19 +0530
Message-ID: <1449816267-11910-7-git-send-email-vinod.koul@intel.com>
References: <1449816267-11910-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E8C46265D98
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 07:41:43 +0100 (CET)
In-Reply-To: <1449816267-11910-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Jayachandran B <jayachandran.b@intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Jayachandran B <jayachandran.b@intel.com>

HW recommends 180us for worst case values for link power up
delay, so change the current delay value from 50 (150us) to 150
(450us)

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/ext/hdac_ext_controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 8f1d292a522c..2524b3baa029 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -247,7 +247,7 @@ static int check_hdac_link_power_active(struct hdac_ext_link *link, bool enable)
 	int mask = (1 << AZX_MLCTL_CPA);
 
 	udelay(3);
-	timeout = 50;
+	timeout = 150;
 
 	do {
 		val = readl(link->ml_addr + AZX_REG_ML_LCTL);
-- 
1.9.1
