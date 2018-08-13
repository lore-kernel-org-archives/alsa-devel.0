From: Yong Zhi <yong.zhi@intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Acquire irq after RIRB
	allocation
Date: Mon, 13 Aug 2018 18:15:14 -0500
Message-ID: <1534202114-29164-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 898732677AE
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2018 01:37:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, pierre-louis.bossart@linux.intel.com
Cc: wenkai.du@intel.com, alsa-devel@alsa-project.org, harshapriya.n@intel.com, yang.jie@linux.intel.com, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, michal.wasko@intel.com, naveen.m@intel.com, sanyog.r.kale@intel.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Cold reboot stress test found that the hda irq could access rirb ring
buffer before its memory gets allocated which resulting in null
pointer dereference inside snd_hdac_bus_update_rirb().

Fix it by moving the skl_acquire_irq after ring buffer allocation.
While here, also change err return from -EBUSY to actual error code.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
---
 sound/soc/intel/skylake/skl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index dce649485649..cf09721ca13e 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -838,11 +838,7 @@ static int skl_first_init(struct hdac_bus *bus)
 
 	snd_hdac_bus_parse_capabilities(bus);
 
-	if (skl_acquire_irq(bus, 0) < 0)
-		return -EBUSY;
-
 	pci_set_master(pci);
-	synchronize_irq(bus->irq);
 
 	gcap = snd_hdac_chip_readw(bus, GCAP);
 	dev_dbg(bus->dev, "chipset global capabilities = 0x%x\n", gcap);
@@ -875,6 +871,12 @@ static int skl_first_init(struct hdac_bus *bus)
 	if (err < 0)
 		return err;
 
+	err = skl_acquire_irq(bus, 0);
+	if (err < 0)
+		return err;
+
+	synchronize_irq(bus->irq);
+
 	/* initialize chip */
 	skl_init_pci(skl);
 
-- 
2.7.4
