From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 9/9] ASoC: Intel: Skylake: remove pci device
	enabling calls on suspend
Date: Thu,  3 Nov 2016 17:07:22 +0530
Message-ID: <1478173042-9458-10-git-send-email-vinod.koul@intel.com>
References: <1478173042-9458-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 504642671C4
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 12:28:41 +0100 (CET)
In-Reply-To: <1478173042-9458-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jayachandran B <jayachandran.b@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jayachandran B <jayachandran.b@intel.com>

We were invoking pci_disable_device() while going to suspend-to-idle and
pci_enable_device() while coming back to active state.

Turns out that we do not need these calls as we only need system to be
wake capable when in suspend-to-idle state. The wake capability is
already done by enable_irq_wake() calls, so remove these unwanted calls
in driver.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index e544d635de25..da5db5098274 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -299,7 +299,6 @@ static int skl_suspend(struct device *dev)
 
 		enable_irq_wake(bus->irq);
 		pci_save_state(pci);
-		pci_disable_device(pci);
 	} else {
 		ret = _skl_suspend(ebus);
 		if (ret < 0)
@@ -342,7 +341,6 @@ static int skl_resume(struct device *dev)
 	 */
 	if (skl->supend_active) {
 		pci_restore_state(pci);
-		ret = pci_enable_device(pci);
 		snd_hdac_ext_bus_link_power_up_all(ebus);
 		disable_irq_wake(bus->irq);
 		/*
-- 
1.9.1
