From: libin.yang@intel.com
Subject: [PATCH 1/2 v2] ALSA: hda - add more ML register
	definitions
Date: Thu,  6 Apr 2017 19:18:20 +0800
Message-ID: <1491477501-12379-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 48165266943
 for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2017 04:04:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, mengdong.lin@intel.com, infernix@infernix.net, rakesh.a.ughreja@intel.com, jeeja.kp@intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

This patch refines the definition of AZX_MLCTL_SPA and AZX_MLCTL_CPA
and add more definitions of ML registers

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 include/sound/hda_register.h        | 8 +++++---
 sound/hda/ext/hdac_ext_controller.c | 6 +++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/sound/hda_register.h b/include/sound/hda_register.h
index 0013063..8df12e4 100644
--- a/include/sound/hda_register.h
+++ b/include/sound/hda_register.h
@@ -243,9 +243,11 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define AZX_REG_ML_LOUTPAY		0x20
 #define AZX_REG_ML_LINPAY		0x30
 
-#define AZX_MLCTL_SPA			(1<<16)
-#define AZX_MLCTL_CPA			23
-
+#define ML_LCTL_SCF_MASK			0xF
+#define AZX_MLCTL_SPA				(0x1 << 16)
+#define AZX_MLCTL_CPA				(0x1 << 23)
+#define AZX_MLCTL_SPA_SHIFT			16
+#define AZX_MLCTL_CPA_SHIFT			23
 
 /* registers for DMA Resume Capability Structure */
 #define AZX_DRSM_CAP_ID			0x5
diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 2614691..84f3b81 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -171,7 +171,7 @@ static int check_hdac_link_power_active(struct hdac_ext_link *link, bool enable)
 {
 	int timeout;
 	u32 val;
-	int mask = (1 << AZX_MLCTL_CPA);
+	int mask = (1 << AZX_MLCTL_CPA_SHIFT);
 
 	udelay(3);
 	timeout = 150;
@@ -179,10 +179,10 @@ static int check_hdac_link_power_active(struct hdac_ext_link *link, bool enable)
 	do {
 		val = readl(link->ml_addr + AZX_REG_ML_LCTL);
 		if (enable) {
-			if (((val & mask) >> AZX_MLCTL_CPA))
+			if (((val & mask) >> AZX_MLCTL_CPA_SHIFT))
 				return 0;
 		} else {
-			if (!((val & mask) >> AZX_MLCTL_CPA))
+			if (!((val & mask) >> AZX_MLCTL_CPA_SHIFT))
 				return 0;
 		}
 		udelay(3);
-- 
2.7.4
