From: Meelis Roos <mroos@linux.ee>
Subject: [PATCH] fix jazz16 compile (udelay)
Date: Thu, 4 Mar 2010 20:33:07 +0200 (EET)
Message-ID: <alpine.SOC.1.00.1003042030460.4679@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.it.da.ut.ee (smtp1.it.da.ut.ee [193.40.5.66])
	by alsa0.perex.cz (Postfix) with ESMTP id 9369E2444F
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 19:33:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

While trying to compile jazz16 isa sound driver on alpha (2.6.33+git), I 
found a compile failure in jazz16.c (udelay is unknown). Fix it by 
including delay.h.

Signed-foo-by: Meelis Roos <mroos@linux.ee>

diff --git a/sound/isa/sb/jazz16.c b/sound/isa/sb/jazz16.c
index 8d21a3f..8ccbcdd 100644
--- a/sound/isa/sb/jazz16.c
+++ b/sound/isa/sb/jazz16.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 #include <asm/dma.h>
 #include <linux/isa.h>
 #include <sound/core.h>


-- 
Meelis Roos (mroos@linux.ee)
