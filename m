From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: bf5xx-sport: use common SPORT code for
	MMR info
Date: Tue,  9 Mar 2010 12:58:14 -0500
Message-ID: <1268157494-13447-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 33680103827
	for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2010 18:54:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Barry Song <barry.song@analog.com>

No point in duplicating this structure layout in each driver.

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
this is fine for 2.6.34 or 2.6.35

 sound/soc/blackfin/bf5xx-sport.h |   28 +---------------------------
 1 files changed, 1 insertions(+), 27 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-sport.h b/sound/soc/blackfin/bf5xx-sport.h
index 2e63dea..a86e8cc 100644
--- a/sound/soc/blackfin/bf5xx-sport.h
+++ b/sound/soc/blackfin/bf5xx-sport.h
@@ -34,33 +34,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <asm/dma.h>
-
-struct sport_register {
-	u16 tcr1;	u16 reserved0;
-	u16 tcr2;	u16 reserved1;
-	u16 tclkdiv;	u16 reserved2;
-	u16 tfsdiv;	u16 reserved3;
-	u32 tx;
-	u32 reserved_l0;
-	u32 rx;
-	u32 reserved_l1;
-	u16 rcr1;	u16 reserved4;
-	u16 rcr2;	u16 reserved5;
-	u16 rclkdiv;	u16 reserved6;
-	u16 rfsdiv;	u16 reserved7;
-	u16 stat;	u16 reserved8;
-	u16 chnl;	u16 reserved9;
-	u16 mcmc1;	u16 reserved10;
-	u16 mcmc2;	u16 reserved11;
-	u32 mtcs0;
-	u32 mtcs1;
-	u32 mtcs2;
-	u32 mtcs3;
-	u32 mrcs0;
-	u32 mrcs1;
-	u32 mrcs2;
-	u32 mrcs3;
-};
+#include <asm/bfin_sport.h>
 
 #define DESC_ELEMENT_COUNT 9
 
-- 
1.7.0.2
