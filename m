From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH 5/9] ARM: DaVinci: ASoC: Adds Audio Serial Port
	support for TI DM646X processor
Date: Mon, 16 Mar 2009 08:05:01 -0400
Message-ID: <1237205101-30178-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 86B7E103804
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 13:22:15 +0100 (CET)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2GCM92e029821
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 07:22:14 -0500
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: alsa-devel@alsa-project.org, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

Adds Audio Serial Port support for TI DM646X processor

Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
This patch applies to the DaVinci git tree available at http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=commit;h=486afa37130356662213cc1a2199a285b4fd72af.

 arch/arm/mach-davinci/include/mach/asp.h |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/asp.h b/arch/arm/mach-davinci/include/mach/asp.h
index e0abc43..670afe9 100644
--- a/arch/arm/mach-davinci/include/mach/asp.h
+++ b/arch/arm/mach-davinci/include/mach/asp.h
@@ -6,16 +6,26 @@
 
 #include <mach/irqs.h>
 
-/* Bases of register banks */
+/* Bases of dm644x and dm355 register banks */
 #define DAVINCI_ASP0_BASE	0x01E02000
 #define DAVINCI_ASP1_BASE	0x01E04000
 
-/* EDMA channels */
+
+/* Bases of dm646x register banks */
+#define	DAVINCI_DM646X_MCASP0_REG_BASE		0x01D01000
+#define DAVINCI_DM646X_MCASP1_REG_BASE		0x01D01800
+
+/* EDMA channels of dm644x and dm355 */
 #define DAVINCI_DMA_ASP0_TX	2
 #define DAVINCI_DMA_ASP0_RX	3
 #define DAVINCI_DMA_ASP1_TX	8
 #define DAVINCI_DMA_ASP1_RX	9
 
+
+/* EDMA channels of dm646x */
+#define	DAVINCI_DM646X_DMA_MCASP0_AXEVT0	6
+#define	DAVINCI_DM646X_DMA_MCASP0_AREVT0	9
+#define	DAVINCI_DM646X_DMA_MCASP1_AXEVT1	12
 /* Interrupts */
 #define DAVINCI_ASP0_RX_INT	IRQ_MBRINT
 #define DAVINCI_ASP0_TX_INT	IRQ_MBXINT
-- 
1.5.6
