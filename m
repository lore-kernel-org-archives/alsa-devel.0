From: Keyon Jie <yang.jie@linux.intel.com>
Subject: [PATCH] ALSA: hda: Fix mismatch for register mask and
	value in ext controller.
Date: Fri, 28 Sep 2018 17:38:59 +0800
Message-ID: <20180928093859.5488-1-yang.jie@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C5141267738
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2018 11:39:27 +0200 (CEST)
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
Cc: tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, vkoul@kernel.org, rakesh.a.ughreja@intel.com
List-Id: alsa-devel@alsa-project.org

E.g. for snd_hdac_ext_bus_link_power_up(), we should set mask to be
AZX_MLCTL_SPA(it was 0), and AZX_MLCTL_SPA as value to power up it,
here correct it and several similar mismatches.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
---
 sound/hda/ext/hdac_ext_controller.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 5bc4a1d587d4..60cb00fd0c69 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -48,9 +48,11 @@ void snd_hdac_ext_bus_ppcap_enable(struct hdac_bus *bus, bool enable)
 	}
 
 	if (enable)
-		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL, 0, AZX_PPCTL_GPROCEN);
+		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL,
+				 AZX_PPCTL_GPROCEN, AZX_PPCTL_GPROCEN);
 	else
-		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL, AZX_PPCTL_GPROCEN, 0);
+		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL,
+				 AZX_PPCTL_GPROCEN, 0);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_ppcap_enable);
 
@@ -68,9 +70,11 @@ void snd_hdac_ext_bus_ppcap_int_enable(struct hdac_bus *bus, bool enable)
 	}
 
 	if (enable)
-		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL, 0, AZX_PPCTL_PIE);
+		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL,
+				 AZX_PPCTL_PIE, AZX_PPCTL_PIE);
 	else
-		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL, AZX_PPCTL_PIE, 0);
+		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL,
+				 AZX_PPCTL_PIE, 0);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_ppcap_int_enable);
 
@@ -194,7 +198,8 @@ static int check_hdac_link_power_active(struct hdac_ext_link *link, bool enable)
  */
 int snd_hdac_ext_bus_link_power_up(struct hdac_ext_link *link)
 {
-	snd_hdac_updatel(link->ml_addr, AZX_REG_ML_LCTL, 0, AZX_MLCTL_SPA);
+	snd_hdac_updatel(link->ml_addr, AZX_REG_ML_LCTL,
+			 AZX_MLCTL_SPA, AZX_MLCTL_SPA);
 
 	return check_hdac_link_power_active(link, true);
 }
@@ -222,8 +227,8 @@ int snd_hdac_ext_bus_link_power_up_all(struct hdac_bus *bus)
 	int ret;
 
 	list_for_each_entry(hlink, &bus->hlink_list, list) {
-		snd_hdac_updatel(hlink->ml_addr,
-				AZX_REG_ML_LCTL, 0, AZX_MLCTL_SPA);
+		snd_hdac_updatel(hlink->ml_addr, AZX_REG_ML_LCTL,
+				 AZX_MLCTL_SPA, AZX_MLCTL_SPA);
 		ret = check_hdac_link_power_active(hlink, true);
 		if (ret < 0)
 			return ret;
@@ -243,7 +248,8 @@ int snd_hdac_ext_bus_link_power_down_all(struct hdac_bus *bus)
 	int ret;
 
 	list_for_each_entry(hlink, &bus->hlink_list, list) {
-		snd_hdac_updatel(hlink->ml_addr, AZX_REG_ML_LCTL, AZX_MLCTL_SPA, 0);
+		snd_hdac_updatel(hlink->ml_addr, AZX_REG_ML_LCTL,
+				 AZX_MLCTL_SPA, 0);
 		ret = check_hdac_link_power_active(hlink, false);
 		if (ret < 0)
 			return ret;
-- 
2.17.1
