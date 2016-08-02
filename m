From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1285/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:34:46 +0800
Message-ID: <20160802123446.3852-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, colin.king@canonical.com, chuansheng.liu@intel.com, baolex.ni@intel.com, zidan.wang@freescale.com, sachinpandhare@gmail.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/usb/usx2y/usbusx2yaudio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index dd40ca9..a98ddcf 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -61,7 +61,7 @@
 #ifdef USX2Y_NRPACKS_VARIABLE
  static int nrpacks = USX2Y_NRPACKS; /* number of packets per urb */
  #define  nr_of_packs() nrpacks
- module_param(nrpacks, int, 0444);
+ module_param(nrpacks, int, S_IRUSR | S_IRGRP | S_IROTH);
  MODULE_PARM_DESC(nrpacks, "Number of packets per URB.");
 #else
  #define nr_of_packs() USX2Y_NRPACKS
-- 
2.9.2
