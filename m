From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3] ASoC: Intel: Skylake: remove call to
	pci_dev_put
Date: Wed, 16 Mar 2016 21:37:18 +0530
Message-ID: <1458144438-28912-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CB072661EE
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 17:04:26 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The PCI bus takes pci_dev_get() and pci_dev_put() is also there.
So no need for drivers to invoke these. In SKL driver we were
calling pci_dev_put() only which is not right, so remove this

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index b67f3bd0fccd..c337d06793ec 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -732,7 +732,6 @@ static void skl_remove(struct pci_dev *pci)
 
 	if (pci_dev_run_wake(pci))
 		pm_runtime_get_noresume(&pci->dev);
-	pci_dev_put(pci);
 	skl_codecs_remove(ebus);
 	skl_platform_unregister(&pci->dev);
 	skl_free_dsp(skl);
-- 
1.9.1
