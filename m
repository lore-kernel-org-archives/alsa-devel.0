From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 05/13] ALSA: hdac: Increase timeout value
	for link power check
Date: Mon, 14 Dec 2015 09:57:21 +0530
Message-ID: <1450067249-7151-6-git-send-email-vinod.koul@intel.com>
References: <1450067249-7151-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 8921426051D
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2015 05:24:34 +0100 (CET)
In-Reply-To: <1450067249-7151-1-git-send-email-vinod.koul@intel.com>
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
index 556267e75591..1a55a781270d 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -246,7 +246,7 @@ static int check_hdac_link_power_active(struct hdac_ext_link *link, bool enable)
 	int mask = (1 << AZX_MLCTL_CPA);
 
 	udelay(3);
-	timeout = 50;
+	timeout = 150;
 
 	do {
 		val = readl(link->ml_addr + AZX_REG_ML_LCTL);
-- 
1.9.1
