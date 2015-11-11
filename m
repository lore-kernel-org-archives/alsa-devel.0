From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/9] ASoC: Intel: Skylake: Remove redundant
	init in resume
Date: Thu, 12 Nov 2015 00:16:43 +0530
Message-ID: <1447267609-27816-4-git-send-email-vinod.koul@intel.com>
References: <1447267609-27816-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 08DBA2606D8
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 19:43:38 +0100 (CET)
In-Reply-To: <1447267609-27816-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Since we call _skl_resume which also initializes the chip we no
need to call these explicitly, so remove the duplication

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index b771b74781ca..5e468b167325 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -199,13 +199,9 @@ static int skl_runtime_resume(struct device *dev)
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
-	struct skl *skl = ebus_to_skl(ebus);
 
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
-	skl_init_pci(skl);
-	snd_hdac_bus_init_chip(bus, true);
-
 	return _skl_resume(ebus);
 }
 #endif /* CONFIG_PM */
-- 
1.9.1
