From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Reset stream to link
	mapping
Date: Sun,  1 Apr 2018 15:13:23 +0530
Message-ID: <20180401094323.20864-1-sanyog.r.kale@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 05EDD267358
 for <alsa-devel@alsa-project.org>; Sun,  1 Apr 2018 11:43:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: abhijeet.kumar@intel.com, tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>

By default all the streams are mapped to all links after controller is
reset which causes stream to be broadcast on all the links.

This patch resets the stream-link mapping after controller reset. The
stream is mapped later to the appropriate link as part of stream setup.

Tested-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
---
 sound/soc/intel/skylake/skl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index abf324747b29..f0d9793f872a 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -127,10 +127,17 @@ static void skl_clock_power_gating(struct device *dev, bool enable)
  */
 static int skl_init_chip(struct hdac_bus *bus, bool full_reset)
 {
+	struct hdac_ext_bus *ebus = hbus_to_ebus(bus);
+	struct hdac_ext_link *hlink;
 	int ret;
 
 	skl_enable_miscbdcge(bus->dev, false);
 	ret = snd_hdac_bus_init_chip(bus, full_reset);
+
+	/* Reset stream-to-link mapping */
+	list_for_each_entry(hlink, &ebus->hlink_list, list)
+		bus->io_ops->reg_writel(0, hlink->ml_addr + AZX_REG_ML_LOSIDV);
+
 	skl_enable_miscbdcge(bus->dev, true);
 
 	return ret;
-- 
2.13.0
