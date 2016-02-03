From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 11/11] ASoC: Intel: Skylake: Remove autosuspend
	delay
Date: Wed,  3 Feb 2016 17:59:54 +0530
Message-ID: <1454502594-21700-12-git-send-email-vinod.koul@intel.com>
References: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 46DC8265A9E
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 13:26:51 +0100 (CET)
In-Reply-To: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The driver used autosuspend delay to delay going to D3. But per
HW recommendation we should go to D3 soon, so remove the delay
from driver

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 443a15de94b5..092705e73db4 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -614,8 +614,6 @@ static int skl_probe(struct pci_dev *pci,
 		goto out_unregister;
 
 	/*configure PM */
-	pm_runtime_set_autosuspend_delay(bus->dev, SKL_SUSPEND_DELAY);
-	pm_runtime_use_autosuspend(bus->dev);
 	pm_runtime_put_noidle(bus->dev);
 	pm_runtime_allow(bus->dev);
 
-- 
1.9.1
