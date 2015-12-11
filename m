From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 10/14] ASoC: Intel: Skylake: manage link power
	in active suspend
Date: Fri, 11 Dec 2015 12:14:23 +0530
Message-ID: <1449816267-11910-11-git-send-email-vinod.koul@intel.com>
References: <1449816267-11910-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C8EC52657D8
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 07:41:53 +0100 (CET)
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
Cc: tiwai@suse.de, Jayachandran B <jayachandran.b@intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

When device enters active suspend, we should turn off the links
as they are not in use. Similarly we need to bring back links
when we exit active suspend.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 4696254c6743..99d6e5bf5f4c 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -194,6 +194,7 @@ static int skl_suspend(struct device *dev)
 	 * running, we need to save the state for these and continue
 	 */
 	if (skl->supend_active) {
+		snd_hdac_ext_bus_link_power_down_all(ebus);
 		pci_save_state(pci);
 		pci_disable_device(pci);
 		return 0;
@@ -216,6 +217,7 @@ static int skl_resume(struct device *dev)
 	if (skl->supend_active) {
 		pci_restore_state(pci);
 		ret = pci_enable_device(pci);
+		snd_hdac_ext_bus_link_power_up_all(ebus);
 	} else {
 		ret = _skl_resume(ebus);
 	}
-- 
1.9.1
