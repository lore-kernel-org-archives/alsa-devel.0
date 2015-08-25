From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: ppc: Add missing inclusion of
	linux/module.h
Date: Tue, 25 Aug 2015 14:07:29 +0200
Message-ID: <1440504449-12421-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C9C0C260557
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 14:07:31 +0200 (CEST)
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
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: alsa-devel@alsa-project.org

Otherwise it triggers a compile warning like:
 sound/ppc/keywest.c:104:1: warning: data definition has no type or storage class
 sound/ppc/keywest.c:104:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE' [-Werror=implicit-int]

Fixes: a2bc2af66a5b ('ALSA: ppc: keywest: Export I2C module alias information')
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/ppc/keywest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index f644a8c57e0a..4373615f13e2 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/module.h>
 #include <sound/core.h>
 #include "pmac.h"
 
-- 
2.5.0
