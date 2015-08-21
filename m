From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/5] ALSA: hdac: Fix to read the correct offset
	of spcap/link register
Date: Fri, 21 Aug 2015 21:36:17 +0530
Message-ID: <1440173181-3150-2-git-send-email-vinod.koul@intel.com>
References: <1440173181-3150-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id EE927265898
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 18:04:35 +0200 (CEST)
In-Reply-To: <1440173181-3150-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

SPCAP and Mutilink register offset were incorrect as offset needs
to be based on capability offset. So correct the offset for
read/write of spcap/link register.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/ext/hdac_ext_controller.c | 10 +++++-----
 sound/hda/ext/hdac_ext_stream.c     |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 358f16195483..d3bb112754f2 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -177,8 +177,8 @@ int snd_hdac_ext_bus_get_ml_capabilities(struct hdac_ext_bus *ebus)
 		hlink->bus = bus;
 		hlink->ml_addr = ebus->mlcap + AZX_ML_BASE +
 					(AZX_ML_INTERVAL * idx);
-		hlink->lcaps  = snd_hdac_chip_readl(bus, ML_LCAP);
-		hlink->lsdiid = snd_hdac_chip_readw(bus, ML_LSDIID);
+		hlink->lcaps  = readl(hlink->ml_addr + AZX_REG_ML_LCAP);
+		hlink->lsdiid = readw(hlink->ml_addr + AZX_REG_ML_LSDIID);
 
 		list_add_tail(&hlink->list, &ebus->hlink_list);
 	}
@@ -243,7 +243,7 @@ static int check_hdac_link_power_active(struct hdac_ext_link *link, bool enable)
 	timeout = 50;
 
 	do {
-		val = snd_hdac_chip_readl(link->bus, ML_LCTL);
+		val = readl(link->ml_addr + AZX_REG_ML_LCTL);
 		if (enable) {
 			if (((val & mask) >> AZX_MLCTL_CPA))
 				return 0;
@@ -263,7 +263,7 @@ static int check_hdac_link_power_active(struct hdac_ext_link *link, bool enable)
  */
 int snd_hdac_ext_bus_link_power_up(struct hdac_ext_link *link)
 {
-	snd_hdac_chip_updatel(link->bus, ML_LCTL, 0, AZX_MLCTL_SPA);
+	snd_hdac_updatel(link->ml_addr, AZX_REG_ML_LCTL, 0, AZX_MLCTL_SPA);
 
 	return check_hdac_link_power_active(link, true);
 }
@@ -275,7 +275,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_power_up);
  */
 int snd_hdac_ext_bus_link_power_down(struct hdac_ext_link *link)
 {
-	snd_hdac_chip_updatel(link->bus, ML_LCTL, AZX_MLCTL_SPA, 0);
+	snd_hdac_updatel(link->ml_addr, AZX_REG_ML_LCTL, AZX_MLCTL_SPA, 0);
 
 	return check_hdac_link_power_active(link, false);
 }
diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index 3de47dd1a76d..b649625f43a4 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -423,7 +423,7 @@ void snd_hdac_ext_stream_spbcap_enable(struct hdac_ext_bus *ebus,
 
 	mask |= (1 << index);
 
-	register_mask = snd_hdac_chip_readl(bus, SPB_SPBFCCTL);
+	register_mask = readl(ebus->spbcap + AZX_REG_SPB_SPBFCCTL);
 
 	mask |= register_mask;
 
-- 
1.9.1
