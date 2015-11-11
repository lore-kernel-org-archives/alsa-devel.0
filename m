From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/9] ASoC: Intel: Skylake: Don't enable
	WAKEENABLE on suspend
Date: Thu, 12 Nov 2015 00:16:42 +0530
Message-ID: <1447267609-27816-3-git-send-email-vinod.koul@intel.com>
References: <1447267609-27816-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 782782606B8
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 19:43:37 +0100 (CET)
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

For HDA codecs WAKEENABLE bit is to programmed if codec event
change has to wake the system when suspended.

In skylake I2S systems which are currently supported we have
only HDMI codec, which doesn't use this capability to detect a
HDMI connect/ disconnect event. HDMI HDA codec uses display
interface to detect connect/disconnect event.

This patch removes the WAKEBIT enabling during device D0/D3 as
this seems to cause spurious wakes on the system

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 390f839d6168..b771b74781ca 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -191,9 +191,6 @@ static int skl_runtime_suspend(struct device *dev)
 
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
-	/* enable controller wake up event */
-	snd_hdac_chip_updatew(bus, WAKEEN, 0, STATESTS_INT_MASK);
-
 	return _skl_suspend(ebus);
 }
 
@@ -203,17 +200,11 @@ static int skl_runtime_resume(struct device *dev)
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	struct skl *skl = ebus_to_skl(ebus);
-	int status;
 
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
-	/* Read STATESTS before controller reset */
-	status = snd_hdac_chip_readw(bus, STATESTS);
-
 	skl_init_pci(skl);
 	snd_hdac_bus_init_chip(bus, true);
-	/* disable controller Wake Up event */
-	snd_hdac_chip_updatew(bus, WAKEEN, STATESTS_INT_MASK, 0);
 
 	return _skl_resume(ebus);
 }
-- 
1.9.1
