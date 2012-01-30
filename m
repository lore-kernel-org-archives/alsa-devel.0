From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 2/3] ARM: ux500: Add DMA-channels for MSP
Date: Mon, 30 Jan 2012 15:18:22 +0100
Message-ID: <1327933102-22193-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog101.obsmtp.com (eu1sys200aog101.obsmtp.com
	[207.126.144.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5441910396A
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2012 15:18:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add DMA-channels for MSP0, MSP1, MSP2 and MSP3.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 arch/arm/mach-ux500/devices-db8500.c        |    6 ++++++
 arch/arm/mach-ux500/include/mach/hardware.h |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index a7c6cdc..6e66d37 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -101,6 +101,9 @@ static const dma_addr_t dma40_tx_map[DB8500_DMA_NR_DEV] = {
 	[DB8500_DMA_DEV41_SD_MM3_TX] = -1,
 	[DB8500_DMA_DEV42_SD_MM4_TX] = -1,
 	[DB8500_DMA_DEV43_SD_MM5_TX] = -1,
+	[DB8500_DMA_DEV14_MSP2_TX] = U8500_MSP2_BASE + MSP_TX_RX_REG_OFFSET,
+	[DB8500_DMA_DEV30_MSP1_TX] = U8500_MSP1_BASE + MSP_TX_RX_REG_OFFSET,
+	[DB8500_DMA_DEV31_MSP0_TX_SLIM0_CH0_TX] = U8500_MSP0_BASE + MSP_TX_RX_REG_OFFSET,
 };
 
 /* Mapping between source event lines and physical device address */
@@ -133,6 +136,9 @@ static const dma_addr_t dma40_rx_map[DB8500_DMA_NR_DEV] = {
 	[DB8500_DMA_DEV41_SD_MM3_RX] = -1,
 	[DB8500_DMA_DEV42_SD_MM4_RX] = -1,
 	[DB8500_DMA_DEV43_SD_MM5_RX] = -1,
+	[DB8500_DMA_DEV14_MSP2_RX] = U8500_MSP2_BASE + MSP_TX_RX_REG_OFFSET,
+	[DB8500_DMA_DEV30_MSP3_RX] = U8500_MSP3_BASE + MSP_TX_RX_REG_OFFSET,
+	[DB8500_DMA_DEV31_MSP0_RX_SLIM0_CH0_RX] = U8500_MSP0_BASE + MSP_TX_RX_REG_OFFSET,
 };
 
 /* Reserved event lines for memcpy only */
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index b6ba26a..d93d6db 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -30,6 +30,8 @@
 #include <mach/db8500-regs.h>
 #include <mach/db5500-regs.h>
 
+#define MSP_TX_RX_REG_OFFSET	0
+
 #ifndef __ASSEMBLY__
 
 #include <mach/id.h>
-- 
1.7.8.3
