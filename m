From: jeeja.kp@intel.com
Subject: [PATCH 04/10] ASoC: Intel: Skylake: Disable SRAM
	Retention before D3
Date: Fri,  3 Jun 2016 18:29:37 +0530
Message-ID: <1464958783-19344-5-git-send-email-jeeja.kp@intel.com>
References: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CB77265554
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 14:56:34 +0200 (CEST)
In-Reply-To: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
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
Cc: Dharageswari R <dharageswari.r@intel.com>, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Dharageswari R <dharageswari.r@intel.com>

SW needs to set the PGCTL.LSRMD = 1 to disable LPSRAM retention
feature,otherwise it may lead to SRAM ECC Errors.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 3 +++
 sound/soc/intel/skylake/skl.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 06d8c26..5a08826 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -184,6 +184,7 @@ static int _skl_suspend(struct hdac_ext_bus *ebus)
 {
 	struct skl *skl = ebus_to_skl(ebus);
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct pci_dev *pci = to_pci_dev(bus->dev);
 	int ret;
 
 	snd_hdac_ext_bus_link_power_down_all(ebus);
@@ -193,6 +194,8 @@ static int _skl_suspend(struct hdac_ext_bus *ebus)
 		return ret;
 
 	snd_hdac_bus_stop_chip(bus);
+	update_pci_dword(pci, AZX_PCIREG_PGCTL,
+		AZX_PGCTL_LSRMD_MASK, AZX_PGCTL_LSRMD_MASK);
 	skl_enable_miscbdcge(bus->dev, false);
 	snd_hdac_bus_enter_link_reset(bus);
 	skl_enable_miscbdcge(bus->dev, true);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 4b4b387..bd8db1d 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -48,6 +48,8 @@
 #define AZX_REG_VS_SDXEFIFOS_XBASE	0x1094
 #define AZX_REG_VS_SDXEFIFOS_XINTERVAL	0x20
 
+#define AZX_PCIREG_PGCTL		0x44
+#define AZX_PGCTL_LSRMD_MASK		(1 << 4)
 #define AZX_PCIREG_CGCTL		0x48
 #define AZX_CGCTL_MISCBDCGE_MASK	(1 << 6)
 
-- 
2.5.0
