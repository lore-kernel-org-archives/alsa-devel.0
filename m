From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ALSA: hdac: Explicitly add io.h
Date: Tue, 13 Oct 2015 14:57:49 +0530
Message-ID: <1444728469-23319-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B8F6C261736
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 11:28:56 +0200 (CEST)
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

Compiling the hdac extended core on arm fails with below error:

  sound/hda/ext/hdac_ext_bus.c: In function 'hdac_ext_writel':
>> sound/hda/ext/hdac_ext_bus.c:29:2: error: implicit declaration of
>> function
+'writel' [-Werror=implicit-function-declaration]
     writel(value, addr);
     ^
   sound/hda/ext/hdac_ext_bus.c: In function 'hdac_ext_readl':
>> sound/hda/ext/hdac_ext_bus.c:34:2: error: implicit declaration of
>> function
+'readl' [-Werror=implicit-function-declaration]
     return readl(addr);

This is fixed by explicitly including io.h

Fixes: 99463b3a3994 - ('ALSA: hda: provide default bus io ops extended hdac')
Reported-by: kbuild test robot <lkp@intel.com>
Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/ext/hdac_ext_bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 4449d1a99089..2433f7c81472 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -19,6 +19,7 @@
 
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <sound/hdaudio_ext.h>
 
 MODULE_DESCRIPTION("HDA extended core");
-- 
2.4.3
