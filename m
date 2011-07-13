From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH V2 10/10] ARM: mxs-dma: include
	<linux/dmaengine.h>
Date: Wed, 13 Jul 2011 11:40:54 +0800
Message-ID: <1310528454-25178-1-git-send-email-b29396@freescale.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by alsa0.perex.cz (Postfix) with ESMTP id 27C07103901
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 05:17:13 +0200 (CEST)
In-Reply-To: <1310483085-31442-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Other files using dma.h may fail to compile as follows:
In file included from sound/soc/mxs/mxs-pcm.h:22,
                 from sound/soc/mxs/mxs-saif.h:112,
                 from sound/soc/mxs/mxs-sgtl5000.c:34:
arch/arm/mach-mxs/include/mach/dma.h:16: warning: 'struct dma_chan' declared inside parameter list
arch/arm/mach-mxs/include/mach/dma.h:16: warning: its scope is only this definition or declaration, which is probably not what you want
arch/arm/mach-mxs/include/mach/dma.h: In function 'mxs_dma_is_apbh':
arch/arm/mach-mxs/include/mach/dma.h:18: error: dereferencing pointer to incomplete type
arch/arm/mach-mxs/include/mach/dma.h: At top level:
arch/arm/mach-mxs/include/mach/dma.h:21: warning: 'struct dma_chan' declared inside parameter list
arch/arm/mach-mxs/include/mach/dma.h: In function 'mxs_dma_is_apbx':
arch/arm/mach-mxs/include/mach/dma.h:23: error: dereferencing pointer to incomplete type
make[3]: *** [sound/soc/mxs/mxs-sgtl5000.o] Error 1
make[2]: *** [sound/soc/mxs] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

It seems it's better for dma.h to include dmaengine.h himself.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/include/mach/dma.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/dma.h b/arch/arm/mach-mxs/include/mach/dma.h
index 7f4aeea..203d7c4 100644
--- a/arch/arm/mach-mxs/include/mach/dma.h
+++ b/arch/arm/mach-mxs/include/mach/dma.h
@@ -9,6 +9,8 @@
 #ifndef __MACH_MXS_DMA_H__
 #define __MACH_MXS_DMA_H__
 
+#include <linux/dmaengine.h>
+
 struct mxs_dma_data {
 	int chan_irq;
 };
-- 
1.7.0.4
