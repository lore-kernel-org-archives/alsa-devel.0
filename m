From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 10/10] ARM: mxs-dma: include <linux/dmaengine.h>
Date: Fri, 8 Jul 2011 23:59:50 +0800
Message-ID: <1310140790-2132-11-git-send-email-b29396@freescale.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1310140790-2132-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org
Cc: s.hauer@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
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
