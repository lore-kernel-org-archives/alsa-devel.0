From: <vm.rod25@gmail.com>
Subject: [PATCH v5 2/9] davinci: EDMA support for
	Omapl138-Hawkboard
Date: Tue, 19 Oct 2010 13:06:20 -0500
Message-ID: <1287511587-22216-3-git-send-email-vm.rod25@gmail.com>
References: <1287511587-22216-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id E9E1C2439E
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 20:05:39 +0200 (CEST)
In-Reply-To: <1287511587-22216-1-git-send-email-vm.rod25@gmail.com>
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
Cc: nsekhar@ti.com, alsa-devel@alsa-project.org, khasim@ti.com, caglarakyuz@gmail.com, sshtylyov@mvista.com
List-Id: alsa-devel@alsa-project.org

From: Victor Rodriguez <victor.rodriguez@sasken.com>

This patch adds EDMA support for the Hawkboard-L138 system

Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c |   54 +++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 8633245..ef3974e 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -64,6 +64,55 @@ static __init void omapl138_hawk_config_emac(void)
 			__func__, ret);
 }
 
+/*
+ * The following EDMA channels/slots are not being used by drivers (for
+ * example: Timer, GPIO, UART events etc) on da850/omap-l138 EVM/Hawkboard,
+ * hence they are being reserved for codecs on the DSP side.
+ */
+static const s16 da850_dma0_rsv_chans[][2] = {
+	/* (offset, number) */
+	{ 8,  6},
+	{24,  4},
+	{30,  2},
+	{-1, -1}
+};
+
+static const s16 da850_dma0_rsv_slots[][2] = {
+	/* (offset, number) */
+	{ 8,  6},
+	{24,  4},
+	{30, 50},
+	{-1, -1}
+};
+
+static const s16 da850_dma1_rsv_chans[][2] = {
+	/* (offset, number) */
+	{ 0, 28},
+	{30,  2},
+	{-1, -1}
+};
+
+static const s16 da850_dma1_rsv_slots[][2] = {
+	/* (offset, number) */
+	{ 0, 28},
+	{30, 90},
+	{-1, -1}
+};
+
+static struct edma_rsv_info da850_edma_cc0_rsv = {
+	.rsv_chans	= da850_dma0_rsv_chans,
+	.rsv_slots	= da850_dma0_rsv_slots,
+};
+
+static struct edma_rsv_info da850_edma_cc1_rsv = {
+	.rsv_chans	= da850_dma1_rsv_chans,
+	.rsv_slots	= da850_dma1_rsv_slots,
+};
+
+static struct edma_rsv_info *da850_edma_rsv[2] = {
+	&da850_edma_cc0_rsv,
+	&da850_edma_cc1_rsv,
+};
 
 static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
 	.enabled_uarts = 0x7,
@@ -77,6 +126,11 @@ static __init void omapl138_hawk_init(void)
 
 	omapl138_hawk_config_emac();
 
+	ret = da850_register_edma(da850_edma_rsv);
+	if (ret)
+		pr_warning("%s: EDMA registration failed: %d\n",
+			__func__, ret);
+
 	ret = da8xx_register_watchdog();
 	if (ret)
 		pr_warning("omapl138_hawk_init: "
-- 
1.6.0.5
